mob/var
	intut=0
	tj1=0
	tj2=0
	tj3=0
	tj4=0
obj/tutobj
	layer=500
	icon='tutorial.dmi'
	screen_loc="19,19"
	arrowpointing
		icon_state="arrow"
	Fbut/icon_state="F"
	Gbut/icon_state="G"
	Kbut/icon_state="K"
	Hbut/icon_state="H"
	Nbut/icon_state="N"
mob/proc/tutclear()
	for(var/obj/tutobj/M in client.screen)del M
turf/tutline1
	Enter(o)
		usr=o
		if(istype(usr,/mob/player))
			if(usr.shirt&&usr.shoes&&usr.pant)
				usr.loc=locate(83,340,1)
				usr.tutclear()
			else
				return
		if(isobj(o))del o
		..()
turf/tutline2
	Entered(var/M)
		if(ismob(M))
			if(M:intut<16)usr.y++
			..()
		else
			..()
turf/shadows
	icon='shadows.dmi'
	layer=70
	density=1

client
	var
		// This variable keeps track of the map fade screen object.
		// If none is present when the map tries to fade, it will create one.
		// That way the library doesn't create map fade objects for clients
		// unless the clients are actually going to use them.
		map_fade/map_fade_loaded
// Each new client gets its own map_fade object.
client/New()
	..()
	src.screen += new/map_fade
// This is the fade object that is used by the library - each client gets one.
// It will automatically be added to the client's screen and it will change
// truanslucency dependant on the client's current fade settings.
map_fade
	parent_type = /atom/movable
	icon = 'fade_gradient.dmi'
	icon_state = "0"
	mouse_opacity=0
	screen_loc = "NORTHWEST to SOUTHEAST"
	// Defaults to 255, but this can be altered with the fade.MapLayer() proc.
	layer = 70
var/fade/fade = new()
fade
	// This checks to see if the client has used its map fade functions yet. If it has
	// not, then it will create a new map fade object for the client to use and assign
	// it to the map_fade_loaded variable.
	proc/CreateMapFadeObj(client/C)
		if(!C.map_fade_loaded)
			C.map_fade_loaded = new/map_fade
			C.screen += C.map_fade_loaded
			return 1
		return
	/*
	MAP ALPHA FADE
	Description: This causes the map_fade datum, which is stretched across the entire
		map window to fade from one level of alpha transparency to another.
	Exceptions: Will not work if no client/mob or alpha level is specified.
	Variables:
		- client/C: This is the client or mob (with client) being affected.
		- alphA. The level of alpha transparency that you want displayed.
		- increments: This is the number of increments between the map's original alpha
			transparency the new alpha transparency. Each increment is an amount of time
			equal to the world's tick_lag.
	*/
	proc/Map(client/C, alpha, increments = 16, time = 10)
		// Since alpha can be zero, we need to check if its boolean false
		// but also make sure that its non-zero at the same time.
		if(!alpha)
			if(alpha != 0)
				return
		if(!C || increments < 1)
			return
		// If the "client" is actually a mob, assign the mob's client to C.
		if(ismob(C))
			var/mob/M = C
			if(!M.client)
				return
			C = M.client
		// If necessary, load the client's map_fade object.
		src.CreateMapFadeObj(C)
		// If the map's alpha is already that shade, cancel.
		if(C.map_fade_loaded.icon_state == "[alpha]")
			return
		// If there are more increments than there is time to have at
		// lest one tick per increment, then limit the number of increments
		// to the amount of time available.
		increments = min(increments, time)
		// Calculate the amount of change we need with each increment.
		var/current_alpha = text2num(C.map_fade_loaded.icon_state)
		var/inc_amount = (alpha - current_alpha) / increments
		var/inc_time = time / increments
		for(var/inc = 0, inc < increments, inc++)
			// This is a check to see if the map_fade is changing outside
			// of this function. If the map fade is changing through some
			// other function, then we will cut this function short.
			if(C)
				if(C.map_fade_loaded.icon_state != "[round(current_alpha)]")
					return // end prematurely
				current_alpha += inc_amount
				C.map_fade_loaded.icon_state = "[round(current_alpha)]"
				sleep(inc_time * world.tick_lag)
		return 1
	/*
	MAP ALPHA SET
	Description: Instantly sets the map's alpha transparency level.
	Exceptions: Will not work if no client/mob or alpha level is specified.
	Variables:
		- client/C: This is the client or mob (with client) being affected.
		- alphA. The level of alpha transparency that you want displayed.
	*/
	proc/MapSet(client/C, alpha)
		// Since alpha can be zero, we need to check if its boolean false
		// but also make sure that its non-zero at the same time.
		if(!alpha)
			if(alpha != 0)
				return
		if(!C)
			return
		// If the "client" is actually a mob, assign the mob's client to C.
		if(ismob(C))
			var/mob/M = C
			if(!M.client)
				return
			C = M.client
		// If necessary, load the client's map_fade object.
		src.CreateMapFadeObj(C)
		// If the map's alpha is already that shade, cancel.
		if(C.map_fade_loaded.icon_state == "[alpha]")
			return
		// Set the map fade to the desired alpha.
		C.map_fade_loaded.icon_state = "[round(alpha)]"
		return 1
	/*
	MAP ALPHA LAYER
	Description: Changes the layer that the map_fade object is displayed on.
		Use this if you need to change the layer because it interferes with your
		current HUD or has other layering issues.
	Exceptions: Will not work if no client/mob or new layer is specified.
	Variables:
		- client/C: This is the client or mob (with client) being affected.
		- new_layer: The new layer to assign the map_fade object to.
	*/
	proc/MapLayer(client/C, new_layer)
		if(!C)
			return
		// If the "client" is actually a mob, assign the mob's client to C.
		if(ismob(C))
			var/mob/M = C
			if(!M.client)
				return
			C = M.client
		// If necessary, load the client's map_fade object.
		src.CreateMapFadeObj(C)
		C.map_fade_loaded.layer = new_layer
		return new_layer
var/last_layer = 255
/*client/verb/ChangeLayer()
	var/new_layer = (last_layer == 255 ? OBJ_LAYER : 255)
	last_layer = new_layer
	fade.MapLayer(src, new_layer)
client/verb/SetFade()
	//var/level = input(src, "Level of fade:", "Fade Level", 100) as null|num
	//if(!level)
	//	return
	//fade.Map(src, level, 32)
	fade.MapSet(src, 255)*/


mob/tutorial
	icon='Yondaime.dmi'
	name="Minato Namikaze (NPC)"
	npc=2
	village="Leaf"
	level=120
	Sta=25
	Hsl=25
	Tai=20
	Nin=25
	Str=20
	Int=25
	Spd=30
	rank="Former Hokage"
	freeze=1
	Click()
		if(usr.busy)return
		if(usr.intut==1)
			usr.busy="talking"
			alert(usr,"Hey. You're finally awake. You've been out cold for weeks.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>Hey. You're finally awake. You've been out cold for weeks. "
			alert(usr,"Do you know where this is? No? Amnesia huh? Well, it did take quite a bit of chakra to resurrect you.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>Do you know where this is? No? Amnesia huh? Well, it did take quite a bit of chakra to resurrect you. "
			if(usr.clan=="Uchiha")
				alert(usr,"Curiously, I saw that you had activated Sharingan when I found you.")
				usr<<"<b><font color=silver>Minato Namikaze: </b>Curiously, I saw that you had activated Sharingan when I found you."
			alert(usr,"Do you remember your name?")
			usr<<"<b><font color=silver>Minato Namikaze: </b>Do you remember your name? "
			restart
			usr.name=input("What is your character's first name?") as text
			if(findtext(usr.name," ")||length(usr.name)<=1||length(usr.name)>15)goto restart
			var/famname=null
			switch(alert("Would you like to have a last name?","","Yes","No"))
				if("Yes")
					here
					famname=input("What is your character's family name?") as text
					if(findtext(famname," ")||length(famname)>15||findtext(famname,"Kaguya")&&usr.clan!="Kaguya"||findtext(famname,"Hyuuga")&&usr.clan!="Hyuuga"||findtext(famname,"Uchiha")&&usr.clan!="Uchiha"||findtext(famname,"Nara")&&usr.clan!="Nara")goto here
					if(length(famname)==0)famname=null
				if("No")famname=null
			var/checkname="[usr.name]"
			if(famname)checkname="[usr.name] [famname]"
			switch(alert("Would you like your name to be [checkname]?","Confirmation","Yes","No"))
				if("Yes")
					if(famname)usr.name="[usr.name] [famname]"
					else usr.name="[usr.name]"
					usr.name="[html_encode(usr.name)]"
					usr.savedname=usr.name
					usr.mouseovername()
				if("No")
					goto restart
			if(usr.clan=="Uchiha")
				alert(usr,"Ah I see. You must be an Uchiha, one of the few survivors from that terrible massacre.")
				usr<<"<b><font color=silver>Minato Namikaze: </b>Ah I see. You must be an Uchiha, one of the few survivors from that terrible massacre. "
			if(usr.clan=="Hyuuga")
				alert(usr,"Judging from your eyes, you must be part of the Hyuuga clan.")
				usr<<"<b><font color=silver>Minato Namikaze: </b>Judging from your eyes, you must be part of the Hyuuga clan. "
			if(usr.clan=="Kaguya")
				alert(usr,"Judging from the markings on your forehead, you must be from the Kaguya clan.")
				usr<<"<b><font color=silver>Minato Namikaze: </b>Judging from the markings on your forehead, you must be from the Kaguya clan. "
			alert(usr,"I'm afraid that you awaken in the midst of a great shinobi war between 4 major powers, the Leaf village, Sand village, Sound village and the incredibly dangerous Akatsuki organization.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>I'm afraid that you awaken in the midst of a great shinobi war between 4 major powers, the Leaf village, Sand village, Sound village and the incredibly dangerous Akatsuki organization.</b> "
			alert(usr,"I do not personally like conflict, but fighting has become a necessity to survive in this cutthroat and dangerous world.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>I do not personally like conflict, but fighting has become a necessity to survive in this cutthroat and dangerous world. "
			alert(usr,"Before I let you go, I will teach you about fighting and the basics.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>Before I let you go, I will teach you about fighting and the basics. "
			alert(usr,"Here, put these clothes on and come outside.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>Here, put these clothes on and come outside."
			var/image/I=image('Flooring.dmi',src)
			new/obj/smoke(loc)
			usr.soundeff(pick('puff.wav','puff2.wav','puff3.wav','puff4.wav','puff5.wav'),25,0)
			I:icon_state="Floor 3"
			usr<<I
			alert(usr,"You received some clothing. Click them in your inventory to put them on.")
			usr.intut=2
			new/obj/items/equippable/Shoes(usr)
			new/obj/items/equippable/Black_Pants(usr)
			if(usr.village=="Leaf")new/obj/items/equippable/Green_Shirt(usr)
			if(usr.village=="Sand")new/obj/items/equippable/Tan_Shirt(usr)
			if(usr.village=="Sound")new/obj/items/equippable/Grey_Shirt(usr)
			var/T=new/obj/tutobj/arrowpointing
			T:screen_loc="21,18"
			T:dir=EAST
			usr.client.screen+=T
			usr.busy=null
			return
		if(usr.intut==2)
			usr.busy="talking"
			alert(usr,"I will teach you about the basics of fighting as a shinobi.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>I will teach you about the basics of fighting as a shinobi. "
			alert(usr,"This is your health bar. Your objective during combat is to bring your enemy's health to 0.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>This is your health bar. Your objective during combat is to bring your enemy's health to 0. "
			var/T=new/obj/tutobj/arrowpointing
			T:screen_loc="14,20"
			T:dir=WEST
			usr.client.screen+=T
			alert(usr,"The most basic form of attack is by punching. You punch by pressing the F button on your keyboard.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>The most basic form of attack is by punching. You punch by pressing the F button on your keyboard. "
			alert(usr,"Practice your punching by attacking one of those target dummies over there. Talk to me once you destroy it.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>Practice your punching by attacking one of those target dummies over there. Talk to me once you destroy it. "
			usr.intut=3
			usr.tutclear()
			usr.client.screen+=new/obj/tutobj/Fbut
			usr.busy=null
			return
		if(usr.intut==4)
			usr.busy="talking"
			usr.exp(5)
			alert(usr,"Nicely done.  If you noticed, your last attack was a critical strike. Critical strikes deal significantly more damage than usual.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>If you noticed, your last attack was a critical strike. Critical strikes deal significantly more damage than usual. "
			alert(usr,"Now I will teach you about projectile weapons.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>Now I will teach you about projectile weapons. "
			alert(usr,"As a ninja, projectile weapons are a very important part of combat.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>As a ninja, projectile weapons are a very important part of combat. "
			alert(usr,"Shurikens are bladed stars that you can throw quickly. Kunais are stronger and faster, but are a bit harder to aim and takes longer to repeatedly throw.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>Shurikens are bladed stars that you can throw quickly. Kunais are stronger and faster, but are a bit harder to aim and takes longer to repeatedly throw. "
			alert(usr,"You throw projectile weapons by pressing G. Talk to me after you have hit a target 3 times with your shuriken.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>You throw projectile weapons by pressing G. Talk to me after you have hit a target 3 times with your shuriken. "
			usr.intut=5
			usr.kstoggle="Shuriken"
			usr.client.screen+=new/obj/tutobj/Gbut
			usr.busy=null
			usr.variable3=0
			return
		if(usr.intut==6)
			usr.busy="talking"
			usr.exp(5)
			alert(usr,"To switch between shurikens and kunais, press K. Talk to me again after you hit a target 3 times with kunais.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>To switch between shurikens and kunais, press K. Talk to me again after you hit a target 3 times with kunais. "
			usr.intut=7
			usr.client.screen+=new/obj/tutobj/Kbut
			usr.busy=null
			usr.variable3=0
			return
		if(usr.intut==8)
			usr.busy="talking"
			usr.exp(5)
			alert(usr,"Good job.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>Good job."
			alert(usr,"One thing about these projectile weapons is that they deal more damage the further they travel. Throwing them point blank wont do much damage, but they can seriously injure an enemy if you snipe them.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>One thing about these projectile weapons is that they deal more damage the further they travel. Throwing them point blank wont do much damage, but they can seriously injure an enemy if you snipe them. "
			alert(usr,"Now I will teach you about the most important tool of a ninjA. jutsus.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>Now I will teach you about the most important tool of a ninjA. jutsus. "
			alert(usr,"Jutsus are skills that use your chakra to perform superhuman feats. I will teach you the most basic jutsus: clone jutsu and transformation.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>Jutsus are skills that use your chakra to perform superhuman feats. I will teach you the most basic jutsus: clone jutsu and transformation. "
			usr<<"<b><font color=lime>You have learned Clone Jutsu! This jutsu temporarily makes you invisible and creates a illusionary clone in your place that runs in the direction you were going."
			usr<<"<b><font color=lime>You have learned Transformation! This jutsu transforms you into an enemy or inanimate object."
			alert(usr,"Clone jutsu turns you invisible for a short time and replace your body with a clone that runs forward. Useful to juke enemies when repositioning yourself or escaping.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>Clone jutsu turns you invisible for a short time and replace your body with a clone that runs forward. Useful to juke enemies when repositioning yourself or escaping. "
			alert(usr,"Transformation lets you transform into a target or a tree. Useful to infiltrate an enemy village and to ambush.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>Transformation lets you transform into a target or a tree. Useful to infiltrate an enemy village and to ambush. "
			alert(usr,"This is your chakra bar. You use chakra to perform these abilities.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>This is your chakra bar. You use chakra to perform these abilities. "
			var/T=new/obj/tutobj/arrowpointing
			T:screen_loc="14,19"
			T:dir=WEST
			usr.client.screen+=T
			alert(usr,"If you run out of chakra, you can press N to rest to regenerate health and chakra much faster. Resting is more effective on a bed, but you can rest anywhere.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>If you run out of chakra, you can press N to rest to regenerate health and chakra much faster. Resting is more effective on a bed, but you can rest anywhere. "
			alert(usr,"Be sure to rest in a safe place though, as you take much more damage when resting.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>Be sure to rest in a safe place though, as you take much more damage when resting. "
			alert(usr,"Talk to me once you have used Clone jutsu and Transformation.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>Talk to me once you have used Clone jutsu and Transformation. "
			usr.tutclear()
			new/obj/jutsu/Clone_Jutsu(usr)
			new/obj/jutsu/Transformation(usr)
			usr.intut=9
			usr.client.screen+=new/obj/tutobj/Nbut
			usr.busy=null
			return
		if(usr.intut==9&&usr.cloneused&&usr.transused)
			usr.tutclear()
			usr.busy="talking"
			usr.exp(5)
			alert(usr,"Your progress is outstanding. I will teach you one more technique: hiding.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>Your progress is outstanding. I will teach you one more technique: hiding. "
			alert(usr,"Press H on your keyboard to hide. Hiding allows you to turn invisible to spy and ambush enemies.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>Press H on your keyboard to hide. Hiding allows you to turn invisible to spy and ambush enemies. "
			alert(usr,"Be careful though, as moving can reveal your position.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>Be careful though, as moving can reveal your position. "
			alert(usr,"Talk to me once you have used your hiding ability.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>Talk to me once you have used your hiding ability. "
			usr.intut=10
			usr.client.screen+=new/obj/tutobj/Hbut
			usr.busy=null
			return
		if(usr.intut==11)
			usr.busy="talking"
			usr.exp(20)
			alert(usr,"You have done well. Now I will teach you how to improve your strength.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>You have done well. Now I will teach you how to improve your strength. "
			alert(usr,"You may have noticed your experience racking up here.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>You probably noticed your experience racking up here. "
			alert(usr,"Experience is used to raise your stats. The 7 stats you have is Strength, Speed, Stamina, Ninjutsu, Taijutsu, Intelligence and Handseals.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>Experience is used to raise your stats. The 7 stats you have is Strength, Speed, Stamina, Ninjutsu, Taijutsu, Intelligence and Handseals. "
			alert(usr,"Here is an explaination of how stats work and how to use your experience on these stats. You can always bring this menu up on the command tab.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>Here is an explaination of how stats work and how to use your experience on these stats. You can always bring this menu up on the command tab."
			usr.trainingfaq()
			usr.intut=11.5
			usr.busy=null
			return
		if(usr.intut==11.5)
			usr.busy="talking"
			alert(usr,"That is definately a handful of knowledge to take in. You currently have [usr.exp] experience, which is enough for you to raise a stat to level 2.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>That is definately a handful of knowledge to take in. You currently have 100 experience, which is just enough for you to raise a stat to level 2. "
			alert(usr,"Here are a pair of weights. Put them on and move around with it until you gain a Speed stat.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>Here are a pair of weights. Put them on and move around with it until you gain a Speed stat. "
			new/obj/items/equippable/Weights(usr)
			usr<<"<b><center>You received a pair of weights."
			usr.intut=12
			usr.busy=null
			return
		if(usr.intut==13)
			usr.busy="talking"
			alert(usr,"Well done. I see your potential. Whether for good or for evil, you are destined for greatness.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>Well done. I see your potential. Whether for good or for evil, you are destined for greatness. "
			alert(usr,"Now you learned how to gain stats, but training does little to gain actual experience.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>Now you learned how to gain stats, but training does little to gain actual experience. "
			alert(usr,"The best way to gain experience is by doing missions. Missions are tasks you are given by a mission contractor or mission board within your village.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>The best way to gain experience is by doing missions. Missions are tasks you are given by a mission contractor or mission board within your village. "
			alert(usr,"I will give you a simple mission now. The objective is simple: to blow this horn.")
			usr<<"<b><font color=silver>Minato Namikaze: </b>I will give you a simple mission now. The objective is simple: to blow this horn. "
			usr<<"<center><b><u><font color=yellow>Mission Received"
			usr<<"<center><b><font color=yellow>Blow the Horn (Rank D)"
			usr<<"<center><font color=yellow>Objective: Blow the mysterious horn."
			usr<<"<b><center>You received a mysterious horn."
			new/obj/items/Mysterious_Horn(usr)
			usr.intut=14
			usr.busy=null
			return



var/bldlin=0
mob/var/tmp/nesbere=0
mob
	dummy
		icon='dummy.dmi'
		npc=3
		hp=60
		maxhp=60
		freeze=1
		var/dying=0
		Move()return
		New()
			..()
			var/B1=new/obj/bars/healthbar(loc)
			B1:barowner=src
			B1:updatebar()
			mybar=B1
		proc/dummyhit(var/mob/M)
			if(dying)return
			if(hp>20)
				hp-=20
				mybar:updatebar()
				flick("struck",src)
				new/obj/hit(loc)
			else
				hp=0
				mybar:updatebar()
				hp=60
				dying=1
				new/obj/crithit2(loc)
				M:intut=4
				M:tutclear()
				flick("destroy",src)
				spawn(55)
					dying=0
					mybar:updatebar()

mob/proc/endtut()
	fade.Map(src, 255, 10, 5)
	sleep(34)
	loc=locate(36,311,1)
	var/M1=new/obj/deathgod(locate(34,309,1))
	flick("fade",M1)
	sleep(60)
	del M1
	var/list/K=list()
	if(village=="Leaf")for(var/obj/Spawn_Point/leaf/M in world)K+=M
	if(village=="Sand")for(var/obj/Spawn_Point/sand/M in world)K+=M
	if(village=="Sound")for(var/obj/Spawn_Point/sound/M in world)K+=M
	if(village=="None")for(var/obj/Spawn_Point/missing/M in world)K+=M
	if(village=="Akatsuki")for(var/obj/Spawn_Point/akatsuki/M in world)K+=M
	var/S=pick(K)
	loc=S:loc
	named=1
	for(var/mob/M in world)if(M.village==village)M<<"<font color=yellow><B>Info:<font color=silver> [client] has created [src], from the [village]."
	fade.Map(src, 0, 10, 25)
