
obj/statuseffect
	icon='statusdark.dmi'
	layer=95
	disable/icon_state="disable"
	internalbleeding/icon_state="internalbleeding"
	cleave/icon_state="cleave"
	silenced/icon_state="silenced"
	stun/icon_state="stun"
	inferno/icon_state="inferno"
	disruption/icon_state="disruption"
	piercinggaze/icon_state="piercinggaze"
	seedling/icon_state="seedling"
	shadowwordpain/icon_state="shadowwordpain"
	snared/icon_state="snared"
	bloodlust/icon_state="bloodlust"
	vengeance/icon_state="vengeance"
	recklessness/icon_state="recklessness"
	sandstorm/icon_state="sandstorm"
	markofdeath/icon_state="markofdeath"
	snapregen/icon_state="snapregen"
	sandshower/icon_state="sandshower"
	stance
		bonegolem/icon_state="bonegolem"
		doubleblades/icon_state="doubleblades"
		extremecondensing/icon_state="extremecondensing"
		windshield/icon_state="windshield"
		precisestriking/icon_state="precisestriking"
		condensedwind/icon_state="condensedwind"
		hurricane/icon_state="hurricane"
		rapidpalms/icon_state="rapidpalms"
		chakraenhancedstrength/icon_state="chakraenhancedstrength"
		mitoticregeneration/icon_state="mitoticregeneration"
		chakrascalpel/icon_state="chakrascalpel"
	eyejutsu
		byakugan/icon_state="byakugan"
	var/mytimer=null
mob
	proc/seffect(var/ttime,var/obj/statuseffect/M)
		if(M)
			if(M.mytimer)del M.mytimer
		var/obj/I=new/obj/timershade(src)
		client.screen+=I
		I.screen_loc=M.screen_loc
		I.icon_state="1"
		M.mytimer=I
		var/Y=round(ttime/28,1)
		var/G=ttime/28
		var/F
		if(G>Y)F=(G-Y)*28
		else F=(G-Y)*28
		var/Z=1
		loop
			if(F<0&&Z==14)
				spawn(Y+F)
					Z++
					if(I)I.icon_state="[Z]"
					goto loop
			else
				spawn(Y)
					Z++
					if(I)I.icon_state="[Z]"
					if(Z<28)
						if(Z==14&&F>0)
							spawn(F)
							goto loop
						else
							goto loop
					else
						if(I)del I
						if(M)del M

mob
	verb
		GiveReputation(mob/player/M in range(10))
			set hidden = 1
			if(repdelay)return
			if(M.client&&M!=src)
				src<<"<b><b><font color=lime><u>You have given [M] reputation."
				M<<"<b><b><font color=lime><u>[src] has given you reputation."
				M.reputation++
				if(M.reputation>=30&&!M.rep30)
					M.rep30=1
					M.medal(2,10)
				repdelay=180
				repdelay()
		ReduceReputation(mob/player/M in range(10))
			set hidden = 1
			if(repdelay)return
			if(M.client&&M!=src)
				src<<"<b><b><font color=red><u>You have reduced [M]'s reputation."
				M<<"<b><b><font color=red><u>[src] has reduced your reputation."
				M.reputation--
				repdelay=180
				repdelay()
mob/var
	freerespec=0
	ryomissiongain=0
mob/verb
	givecredits()
		set hidden = 1
		if(!client.NNGcredits)
			usr<<"You have no credits to give."
			return
		var/list/choose=list()
		for(var/mob/player/M in world)if(M!=usr&&M.client)choose.Add(M)
		var/cancel="Cancel"
		choose+=cancel
		var/mob/M=input("Who do you want to give credits to?") as null|anything in choose
		if(!M)return
		var/N=input("How many credits do you want to give to [M]? ([client.NNGcredits] maximum)")as num
		if(N<=0||N>client.NNGcredits)return
		client.NNGcredits-=N
		M.client.NNGcredits+=N
		alert(usr,"You have given [M] [N] credits!")
		alert(M,"[usr] has given you [N] credits!")
	creditstore()
		set hidden=1
		switch(input("What would you like to buy? You have [client.NNGcredits] NNG Credits.")in list("Golden Scroll - 250 Credits","Custom Status - 200 Credits","Color Text - 150 Credits","10 Senryo - 100 Credits","1 Free Respec - 150 Credits","Random Armor Scroll - 100 Credits","4 Random Armor Scroll - 250 Credits","Ryo Mission Gain +100% - 250 Credits","Name Change - 150 Credits","Nothing."))
			if("Golden Scroll - 250 Credits")
				if(client.NNGcredits>=250)
					client.NNGcredits-=250
					new/obj/usable/Scroll_of_Gold(usr)
					alert(usr,"You have obtained a Golden Scroll!")
				else
					alert(usr,"Insufficient Credits!")
					return
			if("Custom Status - 200 Credits")
				if(client.NNGcredits>=200)
					client.NNGcredits-=200
					var/old=usr.status
					usr.status=input(usr,"What do you want your status to be? Inappropriate statuses can be taken away.") as text
					if(usr.status=="Owner"||usr.status=="Game Master"||usr.status=="GM"||usr.status=="Mod"||usr.status=="Moderator"||usr.status=="Supreme Owner"||usr.status=="NNG Owner")
						alert(usr,"No.")
						usr.status=old
						client.NNGcredits+=200
				else
					alert(usr,"Insufficient Credits!")
					return
			if("10 Senryo - 100 Credits")
				if(client.NNGcredits>=100)
					client.NNGcredits-=100
					usr.senryo+=10
					usr.ryorefresh()
					alert(usr,"You have gained 10 senryo.")
				else
					alert(usr,"Insufficient Credits!")
					return
			if("1 Free Respec - 150 Credits")
				if(client.NNGcredits>=150)
					client.NNGcredits-=150
					usr.freerespec++
				else
					alert(usr,"Insufficient Credits!")
					return
			if("Random Armor Scroll - 100 Credits")
				if(client.NNGcredits>=100)
					client.NNGcredits-=100
					new/obj/items/Random_Armor_Scroll(usr)
				else
					alert(usr,"Insufficient Credits!")
					return
			if("4 Random Armor Scroll - 250 Credits")
				if(client.NNGcredits>=250)
					client.NNGcredits-=250
					var/T=4
					while(T)
						T--
						new/obj/items/Random_Armor_Scroll(usr)
				else
					alert(usr,"Insufficient Credits!")
					return
			if("Color Text - 150 Credits")
				if(client.NNGcredits>=150)
					client.NNGcredits-=150
					switch(input("Which color?")in list("Light Blue","Sky Blue","Crimson","Aqua","Cadet Blue","Violet","Dark Green","Light Green","Orange Red","Turquoise","Cancel"))
						if("Light Blue")
							client.customtext=1
							alert(usr,"Your text is now light blue!")
						if("Sky Blue")
							client.customtext=2
							alert(usr,"Your text is now sky blue!")
						if("Crimson")
							client.customtext=3
							alert(usr,"Your text is now crimson!")
						if("Aqua")
							client.customtext=4
							alert(usr,"Your text is now aqua!")
						if("Cadet Blue")
							client.customtext=5
							alert(usr,"Your text is now cadet blue!")
						if("Violet")
							client.customtext=6
							alert(usr,"Your text is now violet!")
						if("Dark Green")
							client.customtext=7
							alert(usr,"Your text is now dark green!")
						if("Light Green")
							client.customtext=8
							alert(usr,"Your text is now light green!")
						if("Orange Red")
							client.customtext=9
							alert(usr,"Your text is now orange red!")
						if("Turquoise")
							client.customtext=10
							alert(usr,"Your text is now turquoise!")
						if("Cancel")
							client.NNGcredits+=150

				else
					alert(usr,"Insufficient Credits!")
					return
			if("Name Change - 150 Credits")
				if(client.NNGcredits>=150)
					client.NNGcredits-=150
					var/newn = input("What do you want to change your name to?") as text
					if(newn == "")
						client.NNGcredits+=150
						return
					world << "<b><font color=red>Name Change: <font color=white>[usr]<font color=red>'s name is now <font color=white>[newn].<font color=red>"
					var/firstletter = copytext(ckey(usr.key), 1, 2)
					var/savefile/F = new("Saves/[firstletter]/[ckey(usr.key)].sav")
					F.cd = "/[ckey(key)]"
					F.dir.Remove(ckeyEx(savedname))
					if(usr.village=="Akatsuki")
						akatlist.Remove(usr.name)
						akatsave()
					usr.name = newn
					usr.savedname = usr.name
					usr.mouseovername()
					if(usr.village=="Akatsuki")
						akatlist.Add(usr.name)
						akatsave()
				else
					alert(usr,"Insufficient Credits!")
					return
			if("Ryo Mission Gain +100% - 250 Credits")
				if(client.NNGcredits>=250)
					client.NNGcredits-=250
					usr.ryomissiongain+=5
					alert(usr,"The next [usr.ryomissiongain] missions you do will grant 100% extra ryo!")
				else
					alert(usr,"Insufficient Credits!")
					return
	/*Spar()
		if(spardelay||dead||!istype(src,/mob/player))return
		if(sparpartner)
			for(var/mob)
		spardelay=1
		var/list/choose=list()
		for(var/mob/M in oview(12))if(village==M.village&&!M.blockspar)choose.Add(M)
		var/cancel="Cancel"
		choose+=cancel
		var/mob/M=input("Which character do you want to strip naked?") as null|anything in choose
		if(!M)return
		var/image/I = image('icon.dmi',usr)  //make an image attached to usr
		usr << I    //allow usr to see it

	Block_Sparring_Requests()
		if(!blockspar)
			blockspar=1
			src<<"<center>You are now blocking sparring requests."
		else
			blockspar=1
			src<<"<center>You are now blocking sparring requests."*/
	Donationinfo()
		set hidden = 1
		donationinfo()
	TrainingFAQ()
		set hidden = 1
		trainingfaq()
	Forums()
		set hidden = 1
		src<<link("http://narutonextgen.forumotion.com/")
	Scoreboard()
		set hidden = 1
		src<<link("http://www.byond.com/games/Berlin2222/NNG#tab=scores")
	RankFAQ()
		set hidden = 1
		rankfaq()
	/*Teleport_to_Test_Zone()
		set category="GM"
		loc=locate(294,264,1)
		testing=1*/

	/*Reset_Stats()

		level=1
		Sta=1
		Hsl=1
		Tai=1
		Nin=1
		Str=1
		Int=1
		Spd=1
		staexp=0
		intexp=0
		hslexp=0
		taiexp=0
		apowexp=0
		ninexp=0
		spdexp=0
		intexp=0
		staexpm=100
		intexpm=100
		energy=100
		maxenergy=100
		hslexpm=100
		taiexpm=100
		apowexpm=100
		ninexpm=100
		spdexpm=100
		intexpm=100
		skillpoint=1
		tier11=0
		tier12=0
		tier13=0
		tier21=0
		tier22=0
		tier23=0
		tier31=0
		tier32=0
		tier33=0
		tier41=0
		tier42=0
		tier43=0
		tier51=0
		tier52=0
		tier53=0
		tier61=0
		tier62=0
		slot1=null
		slot2=null
		slot3=null
		slot4=null
		slot5=null
		slot6=null
		slot7=null
		slot8=null
		slot9=null
		slot10=null
		slot11=null
		slot12=null
		slot13=null
		slot14=null
		slot15=null
		slot16=null
		skilltotal=0
		tier63=0
		overlay()
		statset()
		for(var/obj/jutsu/Mastered_Substitution/G in src)del G
		for(var/obj/jutsu/Backdash/G in src)del G
		for(var/obj/jutsu/Assassinate/G in src)del G
		for(var/obj/jutsu/troj/Lightning_Flash/G in src)del G
		for(var/obj/jutsu/kaguya/G in src)del G
		for(var/obj/jutsu/hyuuga/G in src)del G
		for(var/obj/jutsu/wind/G in src)del G
		for(var/obj/jutsu/uchiha/G in src)del G
		refreshword()
		world<<"<font color=red><b>Stat Notice: [src] resetted!"*/
	handsealz()
		set hidden=1
		if(resting||busy||freeze||meditating||attacking||seals||dead)return
		seals=1
		exp(1)
		if(missioned&&!mission)exp(rand(1,4))
		if(ancestorboost)exp(10)
		if(secretpower)exp(40)
		if(goldscroll)exp(20)
		icon_state="seals"
		sleep(expgainscale(16,Spd*0.75+Int*0.75))
		icon_state=""
		seals=0
		hslexp()
	Attack()
		set hidden=1
		attack()
	ClayTele()
		set hidden=1
		clayteleport()
	Save()
		set hidden = 1
		if(cdelay1)return
		cdelay1++
		spawn(70)cdelay1--
		src<<"<b>You saved your game."
		client.SaveMob()
	Throw()
		set hidden=1
		throwx()
	Interact()
		set hidden=1
		//interact()
	Rest()
		set hidden=1
		rest()
	Hide()
		set hidden=1
		hide()
	ClearChatbox()
		set hidden = 1
		src<<output(null,"output1")
		src<<"<center>Your screen has been cleared."
	SetChatboxAutomatedClear()
		set hidden = 1
		switch(input("The chatbox slows the performance of the game on some computers. This will clear the chatbox regularily.") in list ("Never Clear","30 seconds","1 minute","2 minutes","3 minutes","5 minutes","10 minutes","15 minutes","20 minutes","30 minutes","45 minutes(recommended)","1 hour ","2 hours"))
			if("Never Clear")
				cleartime=0
				clearcap=1000000
				src<<"<center>Your screen will now never clear automatically."
			if("30 seconds")
				cleartime=0
				clearcap=30
				src<<"<center>Your screen will now clear every 30 seconds."
			if("1 minute")
				cleartime=0
				clearcap=60
				src<<"<center>Your screen will now clear every minute."
			if("2 minutes")
				cleartime=0
				clearcap=120
				src<<"<center>Your screen will now clear every 2 minutes."
			if("3 minutes")
				cleartime=0
				clearcap=180
				src<<"<center>Your screen will now clear every 3 minutes."
			if("5 minutes")
				cleartime=0
				clearcap=300
				src<<"<center>Your screen will now clear every 5 minutes."
			if("10 minutes")
				cleartime=0
				clearcap=600
				src<<"<center>Your screen will now clear every 10 minutes."
			if("15 minutes")
				cleartime=0
				clearcap=900
				src<<"<center>Your screen will now clear every 15 minutes."
			if("20 minutes")
				cleartime=0
				clearcap=1200
				src<<"<center>Your screen will now clear every 20 minutes."
			if("30 minutes")
				cleartime=0
				clearcap=1800
				src<<"<center>Your screen will now clear every 30 minutes."
			if("45 minutes(recommended)")
				cleartime=0
				clearcap=2700
				src<<"<center>Your screen will now clear every 45 minutes."
			if("1 hour")
				cleartime=0
				clearcap=3600
				src<<"<center>Your screen will now clear every hour."
			if("2 hours")
				cleartime=0
				clearcap=7200
				src<<"<center>Your screen will now clear every 2 hours."
	Meditate()
		set hidden=1
		if(!initialized)return
		if(meditating)
			src<<"<b>You stop meditating and got up!"
			meditating=0
			freeze=0
			icon_state=""
			for(var/obj/chakraarrow/M in world)if(M.owner==src)del M
			for(var/obj/chakraball/M in world)if(M.owner==src)del M
			return
		if(imitation||cloaking||paralysed||imitated||resting||swim||henge||dead||caught||moving||attacking||stun||freeze)
			src<<"<b>You can not do that at the moment!"
			return
		src<<"<b>You sit down and began meditating!"
		icon_state="rest"
		meditating=1
		freeze=1
		var/T=new/obj/chakraarrow(locate(x,y+1,z))
		T:dir=pick(NORTH,EAST,WEST,SOUTH)
		var/image/I=image('chakracarrows.dmi',T)
		usr<<I
		var/E=new/obj/chakraball(loc)
		E:owner=src
		T:owner=src
	Toggle_Weaponry()
		set hidden=1
		throwingtoggle()
	Toggle_Bounty_Info()
		set hidden = 1
		if(bountytoggle)
			bountytoggle=0
			usr<<"You stopped receiving bounty info."
		else
			bountytoggle=1
			usr<<"You will now receive bounty info."

	Say(say as text)
		set hidden = 1
		if(intut==1)return
		if(name=="File in Title Screen")return
		hengeback()
		if(talknum>5)
			alert("Please wait a little while before talking again!")
			return
		if(!GM&&muted)return
		if(say==">font+")if(nesbere)nesbere++//editing this bugs the game. don't touch, jonaz
		if(findtext(say,"chink")||findtext(say,"nigga")||findtext(say,"nigger"))
			alert("Don't be racist.")
			return
		if(say=="")return
		if(length(say)>=300)
			usr<<"Your message is too long."
			usr<<"You tried to say [say]"
			return
		if(!usr)return
		if(talknum<5)
			talknum++
			spawn(13)if(usr)talknum--
		else
			talknum+=15
			overhead()
			spawn(200)if(usr)
				overhead()
				talknum-=20
		var/repchose="silver"
		if(reputation>=30)repchose="yellow"
		if(GM)repchose="red"
		if(client.customtext)
			if(client.customtext==1)repchose="#00FFCC"
			if(client.customtext==2)repchose=colour2html("skyblue")
			if(client.customtext==3)repchose=colour2html("crimson")
			if(client.customtext==4)repchose=colour2html("aqua")
			if(client.customtext==5)repchose=colour2html("cadetblue")
			if(client.customtext==6)repchose=colour2html("violet")
			if(client.customtext==7)repchose=colour2html("darkgreen")
			if(client.customtext==8)repchose=colour2html("lightgreen")
			if(client.customtext==9)repchose=colour2html("orangered")
			if(client.customtext==10)repchose=colour2html("turquoise")
		range(usr,10)<<"<font color=[repchose]>[usr]: [html_encode(say)]"
		speech_bubble(src,"[say]", duration = 20+(length(say)/2))
		for(var/mob/player/M in world)if(M.key=="Chihirodori"&&M.tapping)M<<"<font color=white>[usr]: [html_encode(say)]"
		if(GM||client.tracked)record("Say",user=usr.key,target="Area",notes=html_encode(say))
	VillageSay()
		set hidden=1
		if(intut==1)return
		if(name=="File in Title Screen")return
		var/say=input("What would you like to say to your village?") as text
		if(findtext(say,"[textafk]")&&textafk!=null)
			notafk=1
			alert("You are safe from this AFK check.")
			return
		if(talknum>5)
			alert("Please wait a little while before talking again!")
			return
		if(!GM&&muted)return
		if(findtext(say,"chink")||findtext(say,"nigga")||findtext(say,"nigger"))
			alert("Don't be racist.")
			return
		if(say=="")return
		if(length(say)>=300)
			usr<<"Your message is too long."
			usr<<"You tried to say [say]"
			return
		if(talknum<5)
			talknum++
			spawn(13)if(usr)talknum--
		else
			talknum+=15
			spawn(200)if(usr)talknum-=20
	//	world<<"<font color=red><FONT COLOR='#4d9ae6'>[squadname]<FONT COLOR=#7376ac>([status])([rank])[usr]<font color=silver>: [html_encode(say)]"
		var/repchose="silver"
		if(reputation>=30)
			repchose="yellow"
		if(GM)
			repchose="red"
		if(client.customtext)
			if(client.customtext==1)repchose="#00FFCC"
			if(client.customtext==2)repchose=colour2html("skyblue")
			if(client.customtext==3)repchose=colour2html("crimson")
			if(client.customtext==4)repchose=colour2html("aqua")
			if(client.customtext==5)repchose=colour2html("cadetblue")
			if(client.customtext==6)repchose=colour2html("violet")
			if(client.customtext==7)repchose=colour2html("darkgreen")
			if(client.customtext==8)repchose=colour2html("lightgreen")
			if(client.customtext==9)repchose=colour2html("orangered")
			if(client.customtext==10)repchose=colour2html("turquoise")
		for(var/mob/player/M in world)
			if(M.village == village)
				if(rank == "Hokage" || rank == "Kazekage" || rank == "Sound Leader")
					M << "<b><font color=red><FONT COLOR=#7376ac>([status])([rank])[usr]<font color=[repchose]>: [html_encode(say)]"
				else
					M << "<font color=red><FONT COLOR=#7376ac>([status])([rank])[usr]<font color=[repchose]>: [html_encode(say)]"
		if(GM || client.tracked)
			record("Village_Say",user=usr.key,target="Village",notes=html_encode(say))

	Toggle_Client_OOC()
		set hidden = 1
		if(src.notooc)
			src.notooc = 0
			src << "Your OOC is now disabled."
		else
			src.notooc = 1
			src << "Your OOC is now enabled."

	OOCSay()
		set hidden=1
		if(intut==1)return
		if(!ooc)
			src << "World OOC is currently disabled."
			return
		if(!src.notooc)
			src << "Your OOC is currently disabled."
			return
		if(name=="File in Title Screen")return
		var/say=input("What would you like to say to the world?") as text
		if(talknum>5)
			alert("Please wait a little while before talking again!")
			return
		if(!GM&&muted)return
		if(findtext(say,"chink")||findtext(say,"nigga")||findtext(say,"nigger"))
			alert("Don't be racist.")
			return
		if(say=="")return
		if(length(say)>=300)
			usr<<"Your message is too long."
			usr<<"You tried to say [say]"
			return
		if(talknum<5)
			talknum++
			spawn(13)if(usr)talknum--
		else
			talknum+=15
			spawn(200)if(usr)talknum-=20
		var/repchose="silver"
		if(reputation>=30)repchose="yellow"
		if(GM)repchose="red"
		if(client.customtext)
			if(client.customtext==1)repchose="#00FFCC"
			if(client.customtext==2)repchose=colour2html("skyblue")
			if(client.customtext==3)repchose=colour2html("crimson")
			if(client.customtext==4)repchose=colour2html("aqua")
			if(client.customtext==5)repchose=colour2html("cadetblue")
			if(client.customtext==6)repchose=colour2html("violet")
			if(client.customtext==7)repchose=colour2html("darkgreen")
			if(client.customtext==8)repchose=colour2html("lightgreen")
			if(client.customtext==9)repchose=colour2html("orangered")
			if(client.customtext==10)repchose=colour2html("turquoise")
		var/villicon=icon('chat.dmi',"[village]")
		for(var/mob/player/M in world)
			if(M.GM && M.tapping || intourney || testserver || ooc)
				if(!M.notooc && !M.tapping)
					continue
				M<<"|\icon[villicon]|<FONT COLOR=#7376ac>([status])([rank])[usr]<font color=[repchose]>: [html_encode(say)]"
		if(GM||client.tracked)
			if(ooc) record("OOC_Say",user=usr.key,target="World",notes=html_encode(say))
//attack
mob/proc
	attack()
		if(intut)
			if(intut==3&&!attacking)
				flick("attack",src)
				attacking=1
				spawn(15/(attackdelay/100))attacking=0
				for(var/mob/dummy/M in get_step(src,dir))M:dummyhit(src)
			return
		if(resting&&!attacking)
			attacking=1
			new/obj/elet(loc)
			exp(1)
			if(missioned&&!mission)exp(rand(1,4))
			if(ancestorboost)exp(10)
			if(secretpower)exp(40)
			if(goldscroll)exp(20)
			ninexp()
			spawn(expgainscale(16,Int*0.75+Hsl*0.75))attacking=0
			return
		if(intense<3)intense()
		prejutsu()
		if(attacking||lotus||godmode||stun||dead||shield||swim||meditating||coffined||imitated||paralysed||busy=="trigram"||busy=="stun"||caught||coffined==1||coffined==2)return
		if(energy<=10)
			usr<<"<b>You need to catch your breath!"
			attacking=1
			spawn(42)attacking=0
			return
		attacking = 1
		punchamount ++
		if(punchamount == 5000)
			medal(2,18)
		if(tier31 && stance == "Chakra Scalpel" || clan == "Copy Ninja" && stance == "Chakra Scalpel")
			var/D = new/obj/kickloc(loc)
			step(D, dir)
			flick("attack", dir)
			for(var/mob/M in range(D, 1))
				if(aff == M.aff)
					continue
				if(M.illusion)
					M.illusionhit(src)
					continue
				var/damage = round(apow*0.2 + pow*0.1)
				M.dmgch(src)
				damage = (damage*M.variable) + M.variable2
				M.damage(damage)
				M.death(usr)
				new/obj/statuspop/cleave(M.loc)
				M.bleeding2(5,pow*0.1,src)
		if(usr.level>=30&&usr.sandshield&&usr.clan=="Sand")
			spawn(15/(attackdelay/100))attacking=0
			for(var/obj/sandbarrier/G in loc)flick("attack",G)
			spawn(1)
				for(var/mob/M in oview(1))
					if(aff==M.aff)continue
					if(M.illusion)
						M.illusionhit(src)
						continue
					var/damage=pow/3+8
					M.dmgch(src)
					M.snared(28,2)
					damage=(damage*M.variable)+M.variable2
					if(M.pines)
						if(M.pines==1)damage*=0.7
						if(M.pines==1)damage*=0.6
					M.damage(damage)
					if(tier11)M.sandcount(src)
					if(!M.intut&&!intut)
						for(var/obj/Safe_Zone/M2 in loc)goto zkip
						if(M.npc==0)if(prob(33))if(damage>=10)exp(1)
					zkip
					M.death(usr)
			return
		for(var/obj/Tree/M in get_step(src,dir))
			if(prob(50))flick("attack",src)
			else flick("attack",src)
			exp(1)
			if(missioned&&!mission)exp(rand(1,4))
			if(ancestorboost)exp(10)
			if(secretpower)exp(40)
			if(goldscroll)exp(20)
			if(prob(10))
				new/obj/crithit2(M.loc)
				exp(3)
				stepback(1)
			else new/obj/hit2(M.loc)
			taiexp()
			energy-=1
			soundeff(pick('punch.wav','punch2.wav','punch3.wav'),35,1)
			eupdatebar()
			if(energy<0)energy=0
			if(key=="Chihirodori")spawn(1)attacking=0
			else
				spawn(expgainscale(19,Tai+Spd/2))attacking=0
			return
		for(var/obj/healhere/M in get_step(src,dir))
			if(M.owner.aff==aff)
				flick("attack",src)
				spawn(expgainscale(19,Tai+Spd/2))attacking=0
			else
				flick("attack",src)
				new/obj/hit2(M.loc)
				energy-=1
				soundeff(pick('punch.wav','punch2.wav','punch3.wav'),35,1)
				eupdatebar()
				if(energy<0)energy=0
				spawn(expgainscale(19,Tai+Spd/2))attacking=0
				M.hp--
				if(!M.hp)
					for(var/obj/treeoflife/T in range(2,M))if(T.owner==M.owner)del T
					del M
			return
		for(var/obj/tempdummy/exp/M in get_step(src,dir))
			if(prob(50))flick("attack",src)
			else flick("attack",src)
			new/obj/crithit3(M.loc)
			exp(100)
			spawn(1)attacking=0
			return
		var/T=dir
		for(var/mob/M in get_step(src,dir))goto dirchose
		if(dir==NORTH)
			for(var/mob/M in get_step(src,NORTHEAST))
				T=NORTHEAST
				goto dirchose
			for(var/mob/M in get_step(src,NORTHWEST))
				T=NORTHWEST
				goto dirchose
		if(dir==SOUTH)
			for(var/mob/M in get_step(src,SOUTHEAST))
				T=SOUTHEAST
				goto dirchose
			for(var/mob/M in get_step(src,SOUTHWEST))
				T=SOUTHWEST
				goto dirchose
		if(dir==EAST)
			for(var/mob/M in get_step(src,NORTHEAST))
				T=NORTHEAST
				goto dirchose
			for(var/mob/M in get_step(src,SOUTHEAST))
				T=SOUTHEAST
				goto dirchose
		if(dir==WEST)
			for(var/mob/M in get_step(src,SOUTHWEST))
				T=SOUTHWEST
				goto dirchose
			for(var/mob/M in get_step(src,NORTHWEST))T=NORTHWEST
		dirchose
		for(var/mob/Clone/clayclone/U in get_step(src,T))
			if(aff==U.aff)continue
			stun(15)
			del U
		if(usr.weapon==/obj/gourd||usr.sandshield&&usr.clan=="Sand")
			new/obj/sandfist(get_step(src,T))
			spawn(15/(attackdelay/100))attacking=0
			spawn(1)
				for(var/mob/M in get_step(src,T))
					if(aff==M.aff)continue
					if(M.illusion)
						M.illusionhit(src)
						continue
					var/damage=pow*0.4
					soundeff(pick('dodge.wav','dodge2.wav','dodge3.wav','dodge4.wav','dodge5.wav','dodge6.wav'),25,1)
					M.dmgch(src)
					M.snared(28,2)
					damage=(damage*M.variable)+M.variable2
					if(M.pines)
						if(M.pines==1)damage*=0.7
						if(M.pines==1)damage*=0.6
					M.damage(damage)
					if(tier11)M.sandcount(src)
					if(!M.intut&&!intut)
						for(var/obj/Safe_Zone/M2 in loc)goto zkip
						if(M.npc==0)if(prob(33))if(damage>=10)exp(2)
					zkip
					M.death(usr)
			return
		if(usr.weapon==/obj/fan)
			fanattack()
			return
		if(perk2==4&&!hyugdelay)
			hyugdelay(40)
			if(targethyug)
				for(var/mob/M in range(3))
					if("[M]"=="[targethyug]")
						fast=1
						new/obj/flashstep(loc)
						step_towards(src,M)
						step_towards(src,M)
						fast=0
						goto weredone
			for(var/mob/M in range(3))
				if(M.clone||M.npc>=2||M.dead)continue
				if(aff==M.aff)continue
				targethyug="[M]"
				fast=1
				new/obj/flashstep(loc)
				step_towards(src,M)
				step_towards(src,M)
				fast=0
			weredone
		var/tmp/speedmulti=attackdelay
		if(sharingan>=3)speedmulti+=30
		if(clan=="Uchiha"&&tier52)speedmulti+=tier52*10
		var/tmp/delay=15/(speedmulti/100)
		if(weights)
			delay=expgainscale(48,Str)
			exp(1)
			if(missioned&&!mission)exp(rand(5,14))
			if(ancestorboost)exp(30)
			if(secretpower)exp(120)
			if(goldscroll)exp(60)
			apowexp()
		spawn(delay)attacking=0
		if(prob(50))flick("attack",src)
		else flick("attack",src)
		for(var/mob/M in get_step(src,T))
			if(aff==M.aff)continue
			if(M.illusion)
				M.illusionhit(src)
				continue
			if(violentwindpalm)
				violentwindpalm=0
				if(dir==EAST)
					M.stun(15)
					loc=locate(M.x-1,M.y,M.z)
					var/K=new/mob/Clone/vwpclone(loc)
					K:loc=locate(M.x+1,M.y,M.z)
					K:cloneowner=src
					K:icon=icon
					K:dir=WEST
					K:overlays=overlays
					K:name=name
					var/B1=new/obj/bars/healthbar(K:loc)
					B1:barowner=K
					B1:copy(src)
					K:mybar=B1
					var/B2=new/obj/bars/chakrabar(K:loc)
					B2:barowner=K
					B2:copy(src)
					K:mybar2=B2
					viopalm(src)
					K:viopalm(src)
				if(dir==WEST)
					M.stun(15)
					loc=locate(M.x+1,M.y,M.z)
					var/K=new/mob/Clone/vwpclone(loc)
					K:loc=locate(M.x-1,M.y,M.z)
					K:cloneowner=src
					K:icon=icon
					K:dir=EAST
					K:overlays=overlays
					K:name=name
					var/B1=new/obj/bars/healthbar(K:loc)
					B1:barowner=K
					B1:copy(src)
					K:mybar=B1
					var/B2=new/obj/bars/chakrabar(K:loc)
					B2:barowner=K
					B2:copy(src)
					K:mybar2=B2
					viopalm(src)
					K:viopalm(src)
				if(dir==NORTH)
					M.stun(15)
					loc=locate(M.x,M.y-1,M.z)
					var/K=new/mob/Clone/vwpclone(loc)
					K:loc=locate(M.x,M.y+1,M.z)
					K:cloneowner=src
					K:icon=icon
					K:dir=SOUTH
					K:overlays=overlays
					K:name=name
					var/B1=new/obj/bars/healthbar(K:loc)
					B1:barowner=K
					B1:copy(src)
					K:mybar=B1
					var/B2=new/obj/bars/chakrabar(K:loc)
					B2:barowner=K
					B2:copy(src)
					K:mybar2=B2
					viopalm(src)
					K:viopalm(src)
				if(dir==SOUTH)
					M.stun(15)
					loc=locate(M.x,M.y+1,M.z)
					var/K=new/mob/Clone/vwpclone(loc)
					K:loc=locate(M.x,M.y-1,M.z)
					K:cloneowner=src
					K:icon=icon
					K:dir=NORTH
					K:overlays=overlays
					K:name=name
					var/B1=new/obj/bars/healthbar(K:loc)
					B1:barowner=K
					B1:copy(src)
					K:mybar=B1
					var/B2=new/obj/bars/chakrabar(K:loc)
					B2:barowner=K
					B2:copy(src)
					K:mybar2=B2
					viopalm(src)
					K:viopalm(src)
				return
			var/tmp/hitrate=accuracy-M.dodge
			critroll(M)
			if(hitrate<20)hitrate=20
			if(clan=="Yuki")criticalroll+=5*tier22
			if(sagemode)criticalroll+=10*tier63
			if(M.clan=="Uchiha"&&M.tier52)hitrate-=5+5*M.tier52
			if(clan=="Uchiha"&&tier21)criticalroll+=5+tier21*3
			if(sagemode)hitrate=75
			if(assurance||Gate=="View")hitrate=100
			var/tmp/random=rand(0,100)
			if(hitrate<=random&&!M.stun)
				faceme(M)
				M.stepback(1)
			for(var/mob/G in get_step(usr,T))if(G==M)
				var/tmp/C=0
				random=rand(0,100)
				if(criticalroll>random)C=1
				var/tmp/damage=apow*0.2+10
				if(clan=="Senju"&&sagemode)damage=pow*0.3+10
				if(clan=="Yuki"&&tier22)
					damage*=1+0.1*tier22
					if(tier42)if(M)M.poisontip(src)
				if(clan=="Uchiha"&&tier21)damage+=(pow*0.1*tier21)
				if(stance == "Chakra Scalpel")
					damage += pow*0.2
				if(C)
					damage = apow * 0.4 + 10
					if(clan=="Senju"&&sagemode)damage = pow * 0.5 + 10
					if(stance=="Precise Striking")
						damage *= 1 + 0.3 * tier33
						if(tier63)
							damage *= 1.2
					if(clan=="Uchiha"&&tier52)damage+=pow*0.2*tier52
					if(clan=="Hyuuga"&&tier32)damage*=1+(tier32*0.03)
				if(sagemode)M.dmgch(src)
				else	M.dmgch(src,1)
				damage=(damage*M.variable)+M.variable2
				var/tmp/S = energy + 200
				if(S > 100)
					S = 100
				damage = round((S * damage)/100)
				if(clan=="Taijutsu Specialist")
					if(tier12)damage*=1+(tier12*0.04)
					if(Gate=="Pain")damage*=1.2+(0.05*tier51)
					if(shadowport)
						shadowport=0
						damage*=1.5
				if(M.clan=="Taijutsu Specialist")
					if(M.tier32)damage*=1-(M.tier32*0.05)
				if(special==/obj/kisamering)damage*=1.2
				if(special==/obj/peinring)damage*=1.05
				if(clan == "Hyuuga" && tier61 && stance == "Rapid Palms")
					punchcounter ++
					if(punchcounter >= 3)
						punchcounter = 0
						new/obj/airboom(M.loc)
						damage *= 1+0.2*tier61
						M.disabled(src, 0.5*tier21)
				if(clan=="Kaguya"&&tier43)
					hp+=damage*(0.04+0.04*tier43)
					new/obj/heal(loc)
					if(hp>maxhp)hp=maxhp
					mybar:updatebar()
				if(weapon==/obj/kusanagi)
					damage+=((kusan-1)*(pow*0.02))+((kusan-1)*(apow*0.02))
					if(M.venom)damage+=maxhp*0.004*tier11
					kusan=1
					relentless=0
					relentless(0)
					M.cursed(src,damage)
					if(tier63)damage+=(M.maxhp-M.hp)*(0.0075*tier63)
				if(weapon&&clan=="Iron")M.poisoned(src)
				if(snaking)damage*=0.5
				if(damage<5)damage=5
				M.damage(damage,C)
				if(stance == "Precise Striking")
					M.cha -= round(8 * tier33 + rand(1, 3))
					M.cha = max(M.maxcha, 0)
				if(stance=="Rapid Palms")
					rapidpalmstack()
				if(tier43&&clan=="Hyuuga")
					M.bleedtotal+=damage*0.015*tier43
					if(!M.hyuugableed)
						M.hyuugableed=4
						new/obj/statuspop/internalbleeding(M.loc)
						spawn()if(M)M.hyuugableed(src)
					else
						M.hyuugableed=4
				if(!M.intut&&!intut)
					for(var/obj/Safe_Zone/M2 in loc)goto zkip
					if(M.npc==0)if(damage>=10)exp(2)
				zkip
				if(weapon==/obj/redkatana)
					new/obj/ghostevil(M.loc)
					hp-=maxhp/5
					M.hp+=maxhp/5
					if(M.hp>=M.maxhp)M.hp=M.maxhp
				if(C)
					new/obj/crater(M.loc)
					if(clan=="Yuki"&&tier22&&tier33)
						M.snared(30,3)
					if(clan=="Hyuuga"&&tier21)
						M.disabled(src,2*0.5*tier21)
					if(stance=="Precise Striking"&&tier63)mountainpalm(M)
				else
					if(clan=="Hyuuga"&&tier21)
						M.disabled(src,0.5*tier21)
				if(M)
					if(clan=="Taijutsu Specialist"&&level>=9)
						if(istype(M,/mob/player))
							if(strongfist==M)
								if(crippled=="")
									strongfistc++
									relentless(1)
									if(strongfistc==3)
										strongfistc=0
										relentless(-3)
										crippled(M)
							else
								strongfistc=1
								relentless(0,1)
								strongfist=M
						if(tier31)
							if(hp<maxhp)
								var/tmp/heal=(M.maxhp-M.hp)*(0.01*tier31)
								new/obj/heal(loc)
								hp+=heal
								if(hp>maxhp)hp=maxhp
								if(mybar)mybar:updatebar()
						if(tier41)M.strengthpurolin(src)
					if(clan=="Nara"&&assurance&&tier33&&!assurancecd)
						if(istype(M,/mob/player))
							assurance=0
							assurancecd=1
							spawn(340-(40*tier33))assurancecd=0
							if(dir==NORTH)M.loc=locate(x,y+1,z)
							if(dir==EAST)M.loc=locate(x+1,y,z)
							if(dir==SOUTH)M.loc=locate(x,y-1,z)
							if(dir==WEST)M.loc=locate(x-1,y,z)
							faceme(M)
							M.stepback(4)
							M.stun(10)
							freeze=1
							shadow=1
							icon_state="jutsu"
							spawn(5)shadowed=1
							spawn(2)shadow=1
							var/obj/K=new/obj/imitation(loc)
							K.owner=src
							K.dir=dir
							K.shadowstep=K.dir
							step(K,dir)
							for(var/obj/imitationt/H in loc)H.icon_state="begin"
							var/N=4
							loop
								if(N>0)
									N--
									if(K)
										step(K,K.dir)
										spawn(2)goto loop
								else
									K:icon_state="struggle"
									sleep(14)
									shadowoff()
									del K
					if(M in src.ClematisHits&&clan=="Kaguya")
						if(hp<maxhp)
							var/heal=(maxhp-hp)*0.03
							new/obj/heal(loc)
							hp+=heal
							if(hp>maxhp)hp=maxhp
							if(mybar)mybar:updatebar()
					if(clan=="Hyuuga"&&tier11)
						M.disruption(tier11*28,dir,tier11)
					if(clan=="Kaguya"&&tier13&&!M.kagcleave)
						new/obj/statuspop/cleave(M.loc)
						spawn()if(M)M.bleedingkag(src)
					if(clan=="Clay"&&tier23&&!shockwavecd)
						shockwavecd=1
						spawn(50)shockwavecd=0
						new/obj/claymineexplosion(M.loc)
						faceme(M)
						M.stepback(3)
						if(tier11)M.snared(tier11*0.2,2)
						var/damage2=round(pow*(0.2*tier23))
						M.dmgch(src,1)
						damage2=(damage2*M.variable)+M.variable2
						var/critchance=0+(10*tier52)
						if(prob(critchance)&&tier52)
							if(tier62)
								M.stun(2.5*tier62)
								M.maimingshock(usr)
							M.damage(damage2,1.4)
						else
							M.damage(damage2)
					if(M)M.death(usr)
	disruption(var/timer,var/cdir,var/disrupted)
		var/obj/g=new/obj/disruption(loc)
		g.dir=cdir
		if(disruptiondelay==0)
			if(client)
				var/obj/statuseffect/t=new/obj/statuseffect/disruption
				t.screen_loc="4,7"
				client.screen+=t
			disruptiondelay++
		disruption=disrupted
		spawn(timer)
			disruptiondelay--
			if(disruptiondelay<=0)
				disruption=0
				if(client)
					for(var/obj/statuseffect/disruption/G in client.screen)
						del G
	disablecheck()
		disabletime++
		spawn(60)
			disabletime--
			if(disabletime<=0)
				disabletime=0
				if(disabled>0)
					disabled=0
					disableov()
	disabled(mob/M,var/stacks=1)
		if(disabledelay)return
		if(!M)return
		if(M==src||aff==M.aff)return
		disabled+=stacks
		if(disabled>=10)
			disabled=0
			disabledelay=1
			disablecheck()
			stun(14)
			new/obj/statuspop/disabled(loc)
			if(M.tier42)
				M.hp+=M.maxhp*0.02*M.tier42
				M.cha+=M.maxcha*0.02*M.tier42
				new/obj/chakratransfer(M.loc)
			forceupdate()
			ovcheck()
			spawn(140)
				disabledelay=0
				overlays-=/obj/disabledelay
				forceupdate()
		disableov()

	fanattack()
		flick("attack",src)
		spawn(25/(attackdelay/100))attacking=0
		spawn(1)
			var/Tx=new/obj/fanwind(loc)
			var/T2=new/obj/fanwind(loc)
			var/T3=new/obj/fanwind(loc)
			Tx:owner=src
			T2:owner=src
			T3:owner=src
			var/dir1=dir
			var/dir2=WEST
			var/dir3=EAST
			if(dir==EAST||dir==WEST)
				dir2=NORTH
				dir3=SOUTH
			step(Tx,dir1)
			step(T2,dir1)
			step(T3,dir1)
			spawn(1)
				if(Tx)step(Tx,dir1)
				if(T2)step(T2,dir1)
				if(T3)step(T3,dir1)
				if(T2)step(T2,dir2)
				if(T3)step(T3,dir3)
				if(T2)T2:dir=dir1
				if(T3)T3:dir=dir1
			spawn(2)
				if(Tx)step(Tx,dir1)
				if(T2)step(T2,dir1)
				if(T3)step(T3,dir1)
			spawn(7)
				if(Tx)del Tx
				if(T2)del T2
				if(T3)del T3
	hyugdelay(var/D)
		hyugdelay=1
		spawn(D*1.4)
			hyugdelay=0
	throwx()
		if(npc==4&&GM<3||!initialized)return
		if(mask==/obj/spiralmask&&GM==3)
			stepback(5)
			return
		hengeback()
		cloakoff()
		if(subinvis)
			subinvis=0
		if(intense<3)intense()
		if(npc==4&&GM==3&&!attacking)
			var/F=new/obj/heartbomb(loc)
			F:owner=src
			walk(F,dir)
			attacking=1
			spawn(5)attacking=0
			return
		if(ingenin==4)
			if(swim||dead||godmode||stun||meditating||resting||attacking||busy=="stun"||caught)return
			if(prob(50))flick("attack",src)
			else flick("attack",src)
			var/L=new/obj/proj/eKunai(loc)
			attacking=1
			L:owner=usr
			walk(L,dir)
			spawn(8)attacking=0
		else
			if(swim||insnake||dead||shield||caught||resting||coffined==1||coffined==2||attacking||imitated||paralysed||clan=="Kaguya"&&level>=35&&energy<10||energy<5)return
			if(wpalm)
				whirlwindp()
				return
			if(outburst)
				attacking=1
				spawn(20)attacking=0
				outburst()
				return
			if(stance == "Chakra Enhanced Strength")
				superpunch()
				return
			var/throwdelay=15/(attackdelay/100)
			if(throwdelay<3)throwdelay=3
			soundeff(pick('throw.wav','throw2.wav','throw3.wav'),40,0)
			if(clan=="Kaguya"&&level>=35)
				energy-=10
				eupdatebar()
				var/L=new/obj/proj/breakable/bonebullet(loc)
				attacking=1
				L:owner=usr
				L:dir=dir
				L:movequick(dir)
				if(level<90)spawn(throwdelay)attacking=0
				else spawn(throwdelay/1.25)attacking=0
				return
			if(clan=="Snake"&&tier32)
				var/L=new/obj/proj/breakable/snakethrow(loc)
				attacking=1
				L:owner=usr
				L:dir=dir
				L:movequick(dir)
				var/D=throwdelay*1.25
				if(D<2)D=2
				spawn(D)attacking=0
				return
			if(clan=="Copy Ninja"&&tier13&&!fuumadelay&&kstoggle=="Shuriken")
				attacking=1
				fuumadelay=1
				var/L=new/obj/proj/ShurikenF(loc)
				L:owner=usr
				L:dir=dir
				L:movequick(dir)
				spawn(throwdelay)attacking=0
				spawn(100-(tier13*20))fuumadelay=0
			if(clan=="Nara"&&tier13&&!shurikensdelay&&kstoggle=="Shuriken")
				attacking=1
				shurikensdelay=1
				var/obj/F=new/obj/shadowshurikens(loc)
				var/obj/F2=new/obj/shadowshurikens(loc)
				var/obj/F3=new/obj/shadowshurikens(loc)
				for(var/obj/shadowshurikens/H in loc)
					H.owner=src
					H.dir=dir
				if(dir==NORTH||dir==SOUTH)
					F2.x--
					F3.x++
				if(dir==EAST||dir==WEST)
					F2.y--
					F3.y++
				F.movequick(dir)
				F2.movequick(dir)
				F3.movequick(dir)
				spawn(throwdelay)attacking=0
				spawn(40)shurikensdelay=0
			if(clan=="Yuki"&&level>=2)
				flick("attack",src)
				var/L=new/obj/proj/breakable/Senbon(loc)
				attacking=1
				L:owner=usr
				L:dir=dir
				L:movequick(dir)
				var/D=throwdelay/2.2
				if(D<2)D=2
				spawn(D)attacking=0
				return
			if(kstoggle=="Kunai"&&jutsutoggle&&clan=="Spider")
				if(cha<2)return
				cha-=2
				var/L=new/obj/proj/breakable/Golden_Spider_Kunai(loc)
				attacking=1
				if(prob(50))flick("attack",src)
				else flick("attack",src)
				L:owner=usr
				walk(L,dir)
				spawn(13)attacking=0
				return
			if(level>=2&&clan=="Sand")
				var/L=new/obj/proj/breakable/sandshuriken(loc)
				attacking=1
				L:owner=usr
				L:movequick(dir)
				if(level>=80)
					var/L2=new/obj/proj/breakable/sandshuriken(loc)
					var/L3=new/obj/proj/breakable/sandshuriken(loc)
					L2:dir=dir
					L3:dir=dir
					if(dir==NORTH||dir==SOUTH)
						L2:loc=locate(x+1,y,z)
						L3:loc=locate(x-1,y,z)
					if(dir==EAST||dir==WEST)
						L2:loc=locate(x,y+1,z)
						L3:loc=locate(x,y-1,z)
					L2:owner=src
					L3:owner=src
					L2:movequick(dir)
					L3:movequick(dir)
				spawn((throwdelay+5)*1.5)attacking=0
				return
			energy-=5
			eupdatebar()
			flick("attack",src)
			if(kstoggle=="Shuriken")
				var/obj/tmp/L=new/obj/proj/breakable/Shuriken(loc)
				attacking=1
				L.owner=src
				walk(L,dir)
				spawn(throwdelay)attacking=0
			else
				var/obj/tmp/L=new/obj/proj/breakable/Kunai(loc)
				attacking=1
				L.owner=src
				L.movequick(dir)
				spawn(throwdelay+3)attacking=0
	rest()
		if(resting&&restdef<2)
			resting = 0
			regenupdate()
			src<<"<b>You have stopped resting."
			spawn(50)
				restdef = 0
				atkdef()
			freeze=0
			icon_state=""
			if(blind)blindrefresh()
			return
		if(imitation||fernzing||imitated||restdef||paralysed||swim||henge||dead||meditating||caught||moving||stun||freeze||cloaking||sandshield)
			return
		var/bed=0
		for(var/obj/Furnature/Bed/G in loc)bed=1
		if(!bed)
			src<<"<b>You sit down and begin resting."
			if(!teabag)
				for(var/obj/deadbody/F in loc)
					teabag=1
					medal(1,24)
			icon_state="rest"
			resting=1
			restdef=2
			spawn(10)restdef=1
			regenupdate()
			freeze=1
			if(tier42&&clan=="Snake"&&!cansnake)
				spawn(42)
					if(resting)
						cansnake=1
						src<<"<center><b><font color=silver>Your snake form is ready."
		else
			src<<"<b>You close your eyes and start sleeping!"
			dir=SOUTH
			icon_state=icon(icon,"",SOUTH,2,0)
			resting=2
			restdef=2
			spawn(10)restdef=1
			regenupdate()
			freeze=1
	hide()
		if(!initialized)
			return
		if(!cloaking)
			if(moving||snared||dead||stun||freeze||stun||busy||sandstormslow||inchunin||attacking||resting||defendraid||helpraid)
				return
			if(GM && gmhosp)
				new/obj/tele(loc)
				invisibility += 10
				cloaking=1
				return
			for(var/mob/M in oview(8))
				if(!intut && M.village != village || !intut && M.village == "None")
					if(M.type == /mob/Animal/Deer || M.type == /mob/Animal/Lost_Cat)
						continue
					usr<<"<center>Cloaking in ineffective with enemies around."
					return
			busy="cloaking"
			var/X=loc
			var/Y=hp
			var/g=new/obj/hideanim(loc)
			var/count=10
			while(count)
				sleep(5)
				if(hp<Y||X!=loc)
					busy=null
					if(g)del g
					return
				count--
			if(Spd<13)
				spawn(3)soundeff('dodge6.wav',10,0)
				new/obj/cloakingstart(loc)
			else
				soundeff(pick('puff.wav','puff2.wav','puff3.wav','puff4.wav','puff5.wav'),25,0)
				new/obj/smoke(loc)
			invisibility+=10
			if(intut==10)
				intut=11
				tutclear()
			cloaking=1
			busy=null
		else
			invisibility=1
			if(GM&&gmhosp)
				new/obj/tele(loc)
				cloaking=0
				return
			if(Spd<13)
				soundeff('dodge6.wav',10,0)
				new/obj/cloakingend(loc)
			else
				soundeff(pick('puff.wav','puff2.wav','puff3.wav','puff4.wav','puff5.wav'),25,0)
				new/obj/smoke(loc)
			if(Spd>=17)
				ambush = 1
				spawn(34)
					ambush = 0
			cloaking=0
obj/skill
	icon='clear.dmi'
	layer=180
	skillback/Click()
		for(var/obj/skilldark/T in usr.client.screen)del T
		for(var/obj/skilllevel/T in usr.client.screen)del T
		usr.client.perspective=MOB_PERSPECTIVE
		usr.client.eye=usr.client.mob
	tierone1/Click()
		if(usr.skillusing)return
		usr.skillusing=1
		var/t=usr.tier11+1
		if(usr.tier11==usr.tier11max)t--
		switch(usr.clan)
			if("Hyuuga")
				alert("Causes your basic melee attacks to debuff the target for [2*t] seconds, stopping chakra regen, lowering the enemy's chakra control by 50% and increasing enemy's chakra cost of jutsus by 50%. [usr.tier11]/[usr.tier11max]","Disruption")
			if("Fan")alert("Wind jutsus use [t*8]% less chakra. [usr.tier11]/[usr.tier11max]","Wind Control")
			if("Uchiha")
				alert("Increase jutsu damage by [4*t]%. [usr.tier11]/[usr.tier11max]")
			if("Kaguya")alert("Decrease all damage taken by [4*t]%. [usr.tier11]/[usr.tier11max]","Harden Bone")
			if("Nara")alert("Increase the duration of Shadow Imitation by [t] seconds. [usr.tier11]/[usr.tier11max]","")
			if("Sand")alert("After 3 melee and sand shuriken strikes within [3+t*2] seconds to the same enemy, their legs get covered with sand. You can then use sand burial to slow them heavily for 3 seconds for [20+t*10]% damage.  [usr.tier11]/[usr.tier11max]","Lingering Sand")
			if("Yuki")alert("Your cooldowns are lowered by [t*3]% and your handseal speed is increased by [t*0.3] second.  [usr.tier11]/[usr.tier11max]","")
			if("Sound")alert("  [usr.tier11]/[usr.tier11max]","")
			if("Senju")alert("Learn the ability Growth Stance. While active, you gain [t*5]% increased health and chakra regeneration. [usr.tier11]/[usr.tier11max]","")
			if("Medic")alert("Increase healing effectiveness by [6*t]%.")
			if("Iron")alert("Increase iron sand jutsu damage by [t*5]%.")
			if("Snake")alert("Your striking shadow snake and binding snake glare applies a poison for 30 seconds that causes your sword of kusanagi and sky blade to deal bonus damage equal to [0.4*t]% of your maximum health.")
			if("Clay")alert("Your explosions slow the enemy for [t*0.2] seconds.")
			if("Copy Ninja")alert("Decrease chakra cost per second of sharingan implant by [t*5]% and decrease cooldowns of jutsus by [t*4]%. [usr.tier11]/[usr.tier11max]")
			if("Taijutsu Specialist")alert("Increase attack power by [t*3]. [usr.tier11]/[usr.tier11max]")
		if(usr.tier11>=usr.tier11max)
			usr.skillusing=0
			return
		if(!usr.skillpoint)
			alert("You do not have any skill points")
			usr.skillusing=0
			return
		switch(input("Do you want to raise this skill to [usr.tier11+1]/[usr.tier11max]?") in list ("Yes","No"))
			if("Yes")
				usr.skillpoint--
				usr.skilltotal++
				if(usr.clan=="Uchiha")usr.handseals-=0.5
				if(usr.clan=="Yuki")
					usr.handseals-=0.3
					usr.cdpow-=3
					usr.cdapow-=3
				if(usr.clan=="Taijutsu Specialist")usr.apow+=3
				usr.tier11++
				if(usr.tier11==1&&usr.clan=="Senju")
					new/obj/jutsu/senju/Growth_Stance(usr)
					usr<<"<b><font color=lime>You have learned Growth Stance."
				usr.skilllevel()
		usr.skillusing=0
	tierone2/Click()
		if(usr.skillusing)return
		usr.skillusing=1
		var/t=usr.tier12+1
		if(usr.tier12==usr.tier12max)t--
		switch(usr.clan)
			if("Hyuuga")alert("Physical attacks deal [t*6]% more damage. [usr.tier12]/[usr.tier12max]","Momentum")
			if("Kaguya")alert("Increase maximum health by [t*5]%. [usr.tier12]/[usr.tier12max]","Inner Blood")
			if("Uchiha")alert("Reduces chakra drain of Sharingan by [15*t]%. Reduce the cooldown of Mangekyou sharingan by [5*t] seconds.   [usr.tier12]/[usr.tier12max]")
			if("Fan")alert("You learn the ability whirlwind palm, which allows you to toggle G between normal throw and whirlwind palm. Whirlwind palm does minimal damage but knocks back and flinch enemies in a radius. Leveling this skill decreases whirlwind palm's cooldown to [9-t] seconds and increase your health by [t*25]. [usr.tier12]/[usr.tier12max]","Whirlwind Palm")
			if("Yuki")alert("Your attack speed is increased by [t*10]%  [usr.tier12]/[usr.tier12max]","")
			if("Sand")alert("Increase maximum chakra by [t*10]%.  [usr.tier12]/[usr.tier12max]","Inner Chakra")
			if("Spider")alert("  [usr.tier12]/[usr.tier12max]","")
			if("Sound")alert("  [usr.tier12]/[usr.tier12max]","")
			if("Senju")alert("Learn the ability Thorn Stance. While active, you gain [t*7] ninjutsu power. [usr.tier12]/[usr.tier12max]","")
			if("Medic")alert("Increase damage dealt by [4*t]%.")
			if("Iron")alert("Health is increased by [t*5]%.")
			if("Snake")alert("Increase training speed and damage by [t*3]%.")
			if("Clay")alert("You deal [t*4]% more damage.")
			if("Copy Ninja")alert("Increase training speed by [t*4]%. [usr.tier12]/[usr.tier12max]")
			if("Nara")alert("Increase damage dealt by [4*t]%. [usr.tier12]/[usr.tier12max]")
			if("Taijutsu Specialist")alert("Increase melee damage by [t*4]%. [usr.tier12]/[usr.tier12max]")
		if(usr.tier12>=usr.tier12max)
			usr.skillusing=0
			return
		if(!usr.skillpoint)
			alert("You do not have any skill points")
			usr.skillusing=0
			return
		switch(input("Do you want to raise this skill to [usr.tier12+1]/[usr.tier12max]?") in list ("Yes","No"))
			if("Yes")
				usr.skillpoint--
				usr.skilltotal++
				usr.tier12++
				if(usr.clan=="Uchiha")usr.maxhp=usr.basehp*(1+usr.tier12*0.02+usr.tier33*0.05)
				if(usr.clan=="Kaguya")usr.maxhp=usr.basehp*(1+usr.tier12/20)
				if(usr.clan=="Sand")usr.maxcha=usr.basecha*(1+usr.tier12/10)
				if(usr.clan=="Yuki")usr.attackdelay+=10
				if(usr.tier12==1&&usr.clan=="Senju")
					new/obj/jutsu/senju/Thorn_Stance(usr)
					usr<<"<b><font color=lime>You have learned Thorn Stance."
				if(usr.clan=="Fan")
					usr.maxhp+=25
					usr.hp+=25
					if(usr.tier12==1)
						new/obj/jutsu/wind/Whirlwind_Palm(usr)
						usr<<"<b><font color=lime>You have learned Whirlwind Palm! While this is active your throw button causes you to use whirlwind palm. It knocks enemies back while flinching them, giving distance from you and the enemy."
				usr.skilllevel()
		usr.skillusing=0
	tierone3/Click()
		if(usr.skillusing)return
		usr.skillusing=1
		var/t=usr.tier13+1
		if(usr.tier13==usr.tier13max)t--
		switch(usr.clan)
			if("Kaguya")alert("Stops regeneration and damages the enemy for 1% of their maximum health every second for [t+1] seconds after a dance or critical melee. [usr.tier13]/[usr.tier13max]","Cleave")
			if("Hyuuga")alert("Increase maximum chakra by [t*10]%. [usr.tier13]/[usr.tier13max]","Inner Chakra")
			if("Uchiha")alert("Increase experience gain by [4*t]% and ninjutsu power by [2*t]. [usr.tier13]/[usr.tier13max]")
			if("Fan")alert("Sickling wind's intensity is increased by [0.4*t]. Sickling wind's damage is also increased by [3*t]% and this bonus is increased to [6*t]% if it deflects a projectile. [usr.tier13]/[usr.tier13max]","Breakthrough")
			if("Yuki")alert("+[t*50]% chakra regeneration.  [usr.tier13]/[usr.tier13max]","")
			if("Sand")alert("Increase damage by [t*4]%. [usr.tier13]/[usr.tier13max]","Impact")
			if("Spider")alert("  [usr.tier13]/[usr.tier13max]","")
			if("Sound")alert("  [usr.tier13]/[usr.tier13max]","")
			if("Senju")alert("Learn the ability Stump Stance. While active, you gain [t*5]% defense. [usr.tier13]/[usr.tier13max]","")
			if("Medic")alert("Increase defense by [4*t]%.")
			if("Iron")alert("Increase poison damage by [t*20]%.")
			if("Snake")alert("Increases maximum health by [t*5]%")
			if("Clay")alert("Decrease C1 cooldowns by [t*3]% and increase their damage by [t*4]%. But after every use, increase chakra cost by 5, up to 3 uses, at which point the chakra cost resets.")
			if("Copy Ninja")alert("Your shurikens are replaced with Fuuma Shuriken. This has a [10-(t*2)] second cooldown and does 3x more damage than regular shurikens. [usr.tier13]/[usr.tier13max]")
			if("Nara")alert("Your G fires a 3 tiled wave of shadow shurikens. The shurikens deal [30+(t*10)]% ninjutsu power + [2+t]% of your current chakra as damage, and gain [1+t]% damage per tile they travel. Has a 4 second cooldown. [usr.tier13]/[usr.tier13max]")
			if("Taijutsu Specialist")alert("Increase accuracy of melee by [t*20]% [usr.tier13]/[usr.tier13max]")
		if(usr.tier13>=usr.tier13max)
			usr.skillusing=0
			return
		if(!usr.skillpoint)
			alert("You do not have any skill points")
			usr.skillusing=0
			return
		switch(input("Do you want to raise this skill to [usr.tier13+1]/[usr.tier13max]?") in list ("Yes","No"))
			if("Yes")
				usr.skillpoint--
				usr.skilltotal++
				usr.tier13++
				if(usr.clan=="Taijutsu Specialist")usr.accuracy+=20
				if(usr.clan=="Hyuuga")usr.maxcha=usr.basecha*(1+(usr.tier13/10))
				if(usr.tier13==1&&usr.clan=="Senju")
					new/obj/jutsu/senju/Stump_Stance(usr)
					usr<<"<b><font color=lime>You have learned Stump Stance."
				usr.skilllevel()
		usr.skillusing=0
	tiertwo1/Click()
		if(usr.skillusing)return
		usr.skillusing=1
		var/t=usr.tier21+1
		if(usr.tier21==usr.tier21max)t--
		switch(usr.clan)
			if("Kaguya")alert("Become invisible for [t*0.3] second after dance of the camellia. [usr.tier21]/[usr.tier21max]","Camellia Mastery")
			if("Uchiha")alert("Increase melee dodge rate by [5+5*t]% and attack speed by [15*t]% You deal an extra [10*t]% of ninjutsu power in damage with basic attacks, shurikens and kunais. [usr.tier21]/[usr.tier21max]")
			if("Hyuuga")alert("Each time you melee or lion palms you stack [0.5+0.5*t] stacks of disable on the enemy. Critical strikes and mountain crusher adds twice the amount of stacks. Once the enemy hits 10 stacks of disable, the enemy gets stunned for 1 second, and debuffed for 10% less defense, -30% attack speed and 1.5 second increased handseals for 10 seconds. [usr.tier21]/[usr.tier21max]","Disable")
			if("Fan")alert("Learn the ability Wind Shield. When activated you will have shredding winds around you as protection, increasing your defense by [t*5]% and dealing 3.5% of your enemies maximum health every second when they have over [80-20*t]% health. Slow and stun effects are also halved and you stop regenerating chakra while this is active. [usr.tier21]/[usr.tier21max]","Wind Shield")
			if("Yuki")alert("Enemies are slowed for [0.5+t*1.5] seconds after ice prison breaks.  [usr.tier21]/[usr.tier21max]","")
			if("Sand")alert("Increase chakra regeneration by [50*t]%.  [usr.tier21]/[usr.tier21max]","Chakra Flow")
			if("Spider")alert("  [usr.tier21]/[usr.tier21max]","")
			if("Sound")alert("  [usr.tier21]/[usr.tier21max]","")
			if("Senju")alert("Trapping someone with Tree Roots will makes them spread to people within two tiles. Deals [t*20]% of the original damage. [usr.tier21]/[usr.tier21max]","")
			if("Medic")alert("Stance - Your melee deals an extra 20% ninjutsu power in damage and causes them to bleed for [t+1] seconds for 10% ninjutsu power per second.")
			if("Iron")alert("Scattered Showers turns into shards, dealing [t*15]% ninjutsu power damage.")
			if("Snake")alert("Grants the ability Shed Skin, allowing you to remove all binds and slows from yourself and regenerate 10% of your maximum health. You are immune to slows for 3 seconds after using this jutsu. It has a [120-t*20] second CD that is unaffected by cooldown reduction")
			if("Clay")alert("Increase chakra regeneration by [25*t]%.")
			if("Copy Ninja")alert("Increase the amount of influence you get by [t*5]%. [usr.tier21]/[usr.tier21max]")
			if("Nara")alert("Increase maximum health by [t*5]%. [usr.tier21]/[usr.tier21max]")
			if("Taijutsu Specialist")alert("Reduce the defense of anyone you cripple by [t*5]% for 5 seconds. [usr.tier21]/[usr.tier21max]")
		if(usr.skilltotal<5)
			alert("You need to have 5 skill points spent to unlock tier 2. [usr.skilltotal]/5")
			usr.skillusing=0
			return
		if(usr.tier21>=usr.tier21max)
			usr.skillusing=0
			return
		if(!usr.skillpoint)
			alert("You do not have any skill points")
			usr.skillusing=0
			return
		switch(input("Do you want to raise this skill to [usr.tier21+1]/[usr.tier21max]?") in list ("Yes","No"))
			if("Yes")
				usr.skillpoint--
				usr.skilltotal++
				usr.tier21++
				if(usr.tier21==1&&usr.clan=="Medic")
					new/obj/jutsu/medic/Chakra_Scalpel(usr)
					usr<<"<b><font color=lime>You have learned Chakra Scalpel."
				if(usr.tier21==1&&usr.clan=="Snake")
					new/obj/jutsu/snake/Shed_Skin(usr)
					usr<<"<b><font color=lime>You have learned Shed Skin."
				if(usr.tier21==1&&usr.clan=="Fan")
					new/obj/jutsu/wind/Wind_Shield(usr)
					usr<<"<b><font color=lime>You have learned Wind Shield."
				usr.skilllevel()
		usr.skillusing=0
	tiertwo2/Click()
		if(usr.skillusing)return
		usr.skillusing=1
		var/t=usr.tier22+1
		if(usr.tier22==usr.tier22max)t--
		switch(usr.clan)
			if("Kaguya")alert("Increase defense by [t]% every time you are damaged for 5 seconds. Stacks up to 10 times. [usr.tier22]/[usr.tier22max]","Second Defense")
			if("Hyuuga")alert("Increase maximum health by [t*5]%. [usr.tier22]/[usr.tier22max]","Inner Blood")
			if("Fan")alert("Learns the stance Condensed Wind. In this stance, the speed of sickling wind and sandstorm increases. Their damage is also increased by [t*10]%. Damage of air bullet is also increased by [10*t]%.  [usr.tier22]/[usr.tier22max]","Condensed Wind")
			if("Uchiha")alert("Increases all fire damage by [8*t]%.  [usr.tier22]/[usr.tier22max]")
			if("Yuki")alert("You stab the enemy with needles when you melee, dealing [t*10]% extra damage and [t*5]% increased critical strike chance.  [usr.tier22]/[usr.tier22max]","")
			if("Sand")alert("Decrease the chakra cost to maintain Sand Shield to [t-t*0.5]% of maximum chakra + [20-5*t] chakra per second. [usr.tier22]/[usr.tier22max]","Improved Sand Shield")
			if("Spider")alert("  [usr.tier22]/[usr.tier22max]","")
			if("Sound")alert("  [usr.tier22]/[usr.tier22max]","")
			if("Senju")alert("Heals you for [0.25*t]% of your maximum hp when you use a wood jutsu. [usr.tier22]/[usr.tier22max]","")
			if("Medic")alert("Stance - Increase your attack power by [t*10]. Your secondary attack smash the ground in front of you, dealing heavy physical damage to everyone within 2 tiles radius from the center and slowing them for 2 seconds. If you hit an enemy directly in the center, you stun them for 2 seconds and deal additional physical damage.")
			if("Iron")alert("Poison can critically strike for 50% extra damage. Increase critical strike chance by [t*5]% and poison critical strike chance by another [t*10]%. ")
			if("Snake")alert("Sky Blade and Sword of Kusanagi causes a delayed curse that deals [t*10]% extra damage that is applied after 3 seconds. Additional strikes from sky blade or your sword stacks the curse damage and refreshes the 3 second delay. ")
			if("Clay")alert("Upon taking damage from an enemy, you bomb them in return, dealing [t*0.15] power damage. Has a 10 second cooldown.")
			if("Copy Ninja")alert("Increase chakra by [t*10]%. [usr.tier22]/[usr.tier22max]")
			if("Nara")alert("Increase maximum chakra by [t*10]%. [usr.tier22]/[usr.tier22max]")
			if("Taijutsu Specialist")alert("Increase the critical strike rate of your taijutsu techniques by [t*6]%. [usr.tier22]/[usr.tier22max]")
		if(usr.skilltotal<5)
			alert("You need to have 5 skill points spent to unlock tier 2. [usr.skilltotal]/5")
			usr.skillusing=0
			return
		if(usr.tier22>=usr.tier22max)
			usr.skillusing=0
			return
		if(!usr.skillpoint)
			alert("You do not have any skill points")
			usr.skillusing=0
			return
		switch(input("Do you want to raise this skill to [usr.tier22+1]/[usr.tier22max]?") in list ("Yes","No"))
			if("Yes")
				usr.skillpoint--
				usr.skilltotal++
				usr.tier22++
				if(usr.tier22==1&&usr.clan=="Medic")
					new/obj/jutsu/medic/Chakra_Enhanced_Strength(usr)
					usr<<"<b><font color=lime>You have learned Chakra Enhanced Strength."
				if(usr.clan=="Hyuuga")usr.maxhp=usr.basehp*(1+(usr.tier22/20))
				if(usr.tier22==1&&usr.clan=="Fan")
					new/obj/jutsu/wind/Condensed_Wind(usr)
					usr<<"<b><font color=lime>You have learned Condensed Wind."
				usr.skilllevel()
		usr.skillusing=0
	tiertwo3/Click()
		if(usr.skillusing)return
		usr.skillusing=1
		var/t=usr.tier23+1
		if(usr.tier23==usr.tier23max)t--
		switch(usr.clan)
			if("Kaguya")alert("Increase melee speed by [t*8]%. [usr.tier23]/[usr.tier23max]","Swift Blade")
			if("Hyuuga")alert("Rotation hits [15*t]% faster. [usr.tier23]/[usr.tier23max]","Counter-Spin")
			if("Fan")alert("Learn the stance Hurricane. While activates, increases width of sickling wind and sandstorm. Your ninjutsu cooldown is increased by [45-15*t]%, your great sickling wind and dragon storm damage is increased by [8*t]%.[usr.tier23]/[usr.tier23max]","Hurricane")
			if("Uchiha")alert("You chidori deals an extra [4*t]% of the enemy's missing health in damage. Your Phoenix Flower and Yasaka Magatama deals an extra [t/4]% of the enemy's maximum health in damage.  [usr.tier23]/[usr.tier23max]")
			if("Yuki")alert("Enemies in your mist can not run and is slowed down for [t*0.5] second when they walk through it.  [usr.tier23]/[usr.tier23max]","")
			if("Sand")alert("Sand burial slows the enemy with a level [t+1] magnitude for 3 seconds and sand shower's slow duration is increased by [t] seconds.  [usr.tier23]/[usr.tier23max]","Cripple")
			if("Spider")alert("  [usr.tier23]/[usr.tier23max]","")
			if("Sound")alert("  [usr.tier23]/[usr.tier23max]","")
			if("Senju")alert("When someone attacks you, you retaliate by rooting everyone within a 2 tile radius of you. Has a [29-4*t] second cooldown. [usr.tier23]/[usr.tier23max]","")
			if("Medic")alert("Health is increased by [t*5]%.")
			if("Iron")alert("Your cooldowns are lowered by [t*3]% and your handseal speed is increased by [t*0.3] second.")
			if("Snake")alert("When you get hit by critical strikes, you regenerate [t*5]% over 3 seconds.")
			if("Clay")alert("Your melees causes the enemy to explode and take [t*0.20] power damage. This has a 5 second cooldown")
			if("Copy Ninja")alert("Increase attack power by [t*4]%. [usr.tier23]/[usr.tier23max]")
			if("Nara")alert("Deal [t*10]% more damage to enemies under 25% health. [usr.tier23]/[usr.tier23max]")
			if("Taijutsu Specialist")alert("Increase health by [t*5]%. [usr.tier23]/[usr.tier23max]")
		if(usr.skilltotal<5)
			alert("You need to have 5 skill points spent to unlock tier 2. [usr.skilltotal]/5")
			usr.skillusing=0
			return
		if(usr.tier23>=usr.tier23max)
			usr.skillusing=0
			return
		if(!usr.skillpoint)
			alert("You do not have any skill points")
			usr.skillusing=0
			return
		switch(input("Do you want to raise this skill to [usr.tier23+1]/[usr.tier23max]?") in list ("Yes","No"))
			if("Yes")
				usr.skillpoint--
				usr.skilltotal++
				if(usr.clan=="Uchiha")usr.maxcha=usr.basecha*(1+(usr.tier23/10))
				if(usr.clan=="Uchiha")usr.maxcha=usr.basecha*(1+(usr.tier23/10))
				if(usr.clan=="Medic")usr.maxhp=usr.basehp*(1+usr.tier23*0.05)
				usr.tier23++
				if(usr.clan=="Kaguya")usr.forceupdate()
				if(usr.tier23==1&&usr.clan=="Fan")
					new/obj/jutsu/wind/Hurricane(usr)
					usr<<"<b><font color=lime>You have learned Hurricane."
				usr.skilllevel()
		usr.skillusing=0
	tierthree1/Click()
		if(usr.skillusing)return
		usr.skillusing=1
		var/t=usr.tier31+1
		if(usr.tier31==usr.tier31max)t--
		switch(usr.clan)
			if("Kaguya")alert("Increase health regeneration by [t*2]. [usr.tier31]/[usr.tier31max]","Blood Flow")
			if("Hyuuga")alert("Increase chakra regeneration by [t*50]%. [usr.tier31]/[usr.tier31max]","Chakra Flow")
			if("Fan")alert("Sickling Wind, Sandstorm and Great Sickling Wind's cooldown is decreased by [t*10]% but deals 15% less damage. [usr.tier31]/[usr.tier31max]","Fury")
			if("Uchiha")alert("Decrease Body Illusion CD by [10*t]% and Body Illusion increases your defense by 40% while it is active until [t] seconds after it triggers.  [usr.tier31]/[usr.tier31max]")
			if("Yuki")alert("You damage [t]% of the enemy's maximum health every time you deal damage. This effect can only occur once every 6 seconds.  [usr.tier31]/[usr.tier31max]","")
			if("Sand")alert("You gain 1 relentlessness stack from hitting sand shuriken and 5 stacks from hitting shukakus pike up to a maximum of 10 stacks. You deal [0.75*t]% more damage with sand shuriken and shukakus pike per relentless stack.  [usr.tier31]/[usr.tier31max]","Relentlessness")
			if("Spider")alert("  [usr.tier31]/[usr.tier31max]","")
			if("Sound")alert("  [usr.tier31]/[usr.tier31max]","")
			if("Senju")alert("Take [5*t]% less damage when above 50% hp. [usr.tier31]/[usr.tier31max]","")
			if("Medic")
				if(usr.tier21<3)
					alert("You need to master Chakra Scalpel to learn this skill.")
					usr.skillusing=0
					return
				alert("Increase chakra scalpel's effective range and cause Nervous System Rupture to last [t] seconds longer when applied to targets suffering from any sort of bleeding.")
			if("Iron")alert("Enemies are silenced for [t*0.7] seconds from Toxic Shock.")
			if("Snake")alert("Your chakra absorption steals [t]% of the enemy's attack and defense per tick for 10 seconds. You can not get more than 80% defense from this jutsu.")
			if("Clay")alert("Take 40% less damage when below [t*10]% hp.")
			if("Copy Ninja")alert("Increase health regeneration by [t*2]. [usr.tier31]/[usr.tier31max]")
			if("Nara")alert("Heal for [t*4]% of the damage you deal with Shadow Strangle Jutsu. [usr.tier31]/[usr.tier31max]")
			if("Taijutsu Specialist")alert("Your taijutsu techniques and melee will heal you for [t/2]% of the enemies' missing health. [usr.tier31]/[usr.tier31max]")
		if(usr.skilltotal<10)
			alert("You need to have 10 skill points spent to unlock tier 2. [usr.skilltotal]/10")
			usr.skillusing=0
			return
		if(usr.tier31>=usr.tier31max)
			usr.skillusing=0
			return
		if(!usr.skillpoint)
			alert("You do not have any skill points")
			usr.skillusing=0
			return
		switch(input("Do you want to raise this skill to [usr.tier31+1]/[usr.tier31max]?") in list ("Yes","No"))
			if("Yes")
				usr.skillpoint--
				usr.skilltotal++
				usr.tier31++
				usr.skilllevel()
		usr.skillusing=0
	tierthree2/Click()
		if(usr.skillusing)return
		usr.skillusing=1
		var/t=usr.tier32+1
		if(usr.tier32==usr.tier32max)t--
		switch(usr.clan)
			if("Kaguya")alert("Your dance of the willow cost [t*5]% less bone resource and deal [15*t]% more damage. [usr.tier32]/[usr.tier32max]","Willow Mastery")
			if("Hyuuga")alert("Increase melee critical damage by [t*3]%. [usr.tier32]/[usr.tier32max]","Concentration")
			if("Fan")alert("Increase maximum chakra by [t*10]%. [usr.tier32]/[usr.tier32max]","Inner Chakra")
			if("Uchiha")alert("Increases max health by [t*5]%  [usr.tier32]/[usr.tier32max]")
			if("Yuki")alert("You enter critical condition state at [25-t*5]% hp instead of 25%. Deals [-0.25+t*0.75]% more damage per 10% hp missing.  [usr.tier32]/[usr.tier32max]","")
			if("Sand")alert("Enemies trapped in sand coffin take [45-t*15]% less damage instead of 50%.  [usr.tier32]/[usr.tier32max]","Sadism")
			if("Spider")alert("  [usr.tier32]/[usr.tier32max]","")
			if("Sound")alert("  [usr.tier32]/[usr.tier32max]","")
			if("Senju")alert("Upon death, send a wave of wood spikes in every direction that move 4 tiles. Deals [40*t]% of your power as damage. [usr.tier32]/[usr.tier32max]","")
			if("Medic")
				if(usr.tier22<3)
					alert("You need to master Chakra Enhanced Strength to learn this skill.")
					usr.skillusing=0
					return
				alert("Reduce the charge time of the secondary attack of Chakra Enhanced Strength by [30*t]%. Increase physical damage by [15*t]% while pre-healing jutsu is active.")
			if("Iron")alert("+[50*t]% chakra regeneration.")
			if("Snake")alert("Your secondary attack throws a fast snake that deals Kunai damage and poisons the enemy for [12*t]% ninjutsu damage over 3 seconds.")
			if("Clay")alert("Your big explosions cause the earth below it to burn, dealing 2% of the enemies' max health per second as damage. Has a 20 second cooldown and lasts [t*2] seconds.")
			if("Copy Ninja")alert("Increase health by [t*5]%. [usr.tier32]/[usr.tier32max]")
			if("Nara")alert("Place [t] extra bomb(s) when using Strategic Bombing. [usr.tier32]/[usr.tier32max]")
			if("Taijutsu Specialist")alert("Take [t*5]% less damage from attack power centered jutsus. [usr.tier32]/[usr.tier32max]")
		if(usr.skilltotal<10)
			alert("You need to have 10 skill points spent to unlock tier 2. [usr.skilltotal]/10")
			usr.skillusing=0
			return
		if(usr.tier32>=usr.tier32max)
			usr.skillusing=0
			return
		if(!usr.skillpoint)
			alert("You do not have any skill points")
			usr.skillusing=0
			return
		switch(input("Do you want to raise this skill to [usr.tier32+1]/[usr.tier32max]?") in list ("Yes","No"))
			if("Yes")
				usr.skillpoint--
				usr.skilltotal++
				usr.tier32++
				if(usr.clan=="Hyuuga")usr.critrate+=3
				if(usr.clan=="Fan")usr.maxcha=usr.basecha*(1+(usr.tier32/10))
				usr.skilllevel()
		usr.skillusing=0
	tierthree3/Click()
		if(usr.skillusing)return
		usr.skillusing=1
		var/t=usr.tier33+1
		if(usr.tier33==usr.tier33max)t--
		switch(usr.clan)
			if("Kaguya")alert("Physical attacks deal [4*t]% more damage. [usr.tier33]/[usr.tier33max]","Momentum")
			if("Hyuuga")alert("Learns the ability Precise Striking. While this stance is active your critical strike rate is unaffected by critical strike defense. Your attack speed is fixed to [100+50*t]% and increases your critical strike damage by [30*t]%. [usr.tier33]/[usr.tier33max]","Precise Striking")
			if("Fan")alert("Increase air bullet damage by [t*10]%. Also decreases air bullet's cooldown by [t*20]%. [usr.tier33]/[usr.tier33max]","Bombardment")
			if("Uchiha")alert("Decreases ninjutsu CD by [5*t]% Increases chakra cost of jutsus by [8*t]%. [usr.tier33]/[usr.tier33max]")
			if("Yuki")alert("Senbons has a [6+t*10]% increased critical strike chance. Critical strikes with senbons and needle strike slows the enemy for 3 seconds.  [usr.tier33]/[usr.tier33max]","")
			if("Sand")alert("Learns Tap Sand Reserve. This ability taps your stored sand reserve, regenerating [10+10*t]% of your maximum chakra instantly.  [usr.tier33]/[usr.tier33max]","Tap Sand Reserve")
			if("Spider")alert("  [usr.tier33]/[usr.tier33max]","")
			if("Sound")alert("  [usr.tier33]/[usr.tier33max]","")
			if("Senju")alert("Deal [4*t]% more damage with your wood jutsus to people below 50% health. [usr.tier33]/[usr.tier33max]","")
			if("Medic")alert("Chakra is increased by [10*t]%.")
			if("Iron")alert("While using Iron Rain, increase defense by [10*t]% and regenerate [0.5*t]% of your missing health per second.")
			if("Snake")alert("Increase health regeneration by [t*5]%. Regeneration is further increased by 1% per 50 hp you're missing.")
			if("Clay")alert("Your C1 Bird scatters into shrapnels if it does not hit anything after 0.3 seconds, dealing [t*25]% power damage to anyone they hit.")
			if("Copy Ninja")alert("Increase ninjutsu power by [t*4]%. [usr.tier33]/[usr.tier33max]")
			if("Nara")alert("Your next melee after Shadow Gathering will apply Shadow Imitation. Has a [24-(t*4)] second cooldown. [usr.tier33]/[usr.tier33max]")
			if("Taijutsu Specialist")alert("Increase the damage of your critical strikes by [t*5]%. [usr.tier33]/[usr.tier33max]")
		if(usr.skilltotal<10)
			alert("You need to have 10 skill points spent to unlock tier 2. [usr.skilltotal]/10")
			usr.skillusing=0
			return
		if(usr.tier33>=usr.tier33max)
			usr.skillusing=0
			return
		if(!usr.skillpoint)
			alert("You do not have any skill points")
			usr.skillusing=0
			return
		switch(input("Do you want to raise this skill to [usr.tier33+1]/[usr.tier33max]?") in list ("Yes","No"))
			if("Yes")
				usr.skillpoint--
				usr.skilltotal++
				usr.tier33++
				if(usr.clan=="Medic")usr.maxcha=usr.maxcha*(1+usr.tier33*0.1)
				if(usr.tier33==1&&usr.clan=="Sand")
					new/obj/jutsu/sandc/Tap_Sand_Reserve(usr)
					usr<<"<b><font color=lime>You have learned Tap Sand Reserve. You instantly regenerates a portion of your maximum chakra."
				if(usr.clan=="Uchiha")usr.maxhp=usr.basehp*(1+usr.tier12*0.03+usr.tier33/20)
				if(usr.tier33==1&&usr.clan=="Hyuuga")
					new/obj/jutsu/hyuuga/Precise_Striking(usr)
					usr<<"<b><font color=lime>You have learned Precise Striking! While this stance is active your critical strike damage is increased by 30% and your punches drain chakra at the cost of reduced attack speed. Only one stance can be active at the same time."
				usr.skilllevel()
		usr.skillusing=0
	tierfour1/Click()
		if(usr.skillusing)return
		usr.skillusing=1
		var/t=usr.tier41+1
		if(usr.tier41==usr.tier41max)t--
		switch(usr.clan)
			if("Kaguya")alert("Increase length of pine by [t] seconds and reduce its bone resource cost by [20*t]%. [usr.tier41]/[usr.tier41max]","Pine Mastery")
			if("Hyuuga")alert("Rotation costs [15*t]% less maximum chakra. You can use rotation while stunned. [usr.tier41]/[usr.tier41max]","Ultimate Shield")
			if("Fan")
				if(!usr.tier31)
					alert("You need to learn Fury to learn this skill.")
					usr.skillusing=0
					return
				alert("Increase Sickling Wind, Sandstorm and Great Sickling Wind's damage by [8*t]%. [usr.tier41]/[usr.tier41max]","Path of Deapowuction")
			if("Uchiha")alert("Increases maximum Chakra by [10*t]%. [usr.tier41]/[usr.tier41max]")
			if("Yuki")alert("Enemies trapped inside demon ice mirrors are slowed down by a extra [t*2] magnitude.  [usr.tier41]/[usr.tier41max]","")
			if("Sand")alert("Sand shield cooldown decreased to to [6-t] seconds. Initial cost to activate sand shield is decreased to [8-t]% chakra.  [usr.tier41]/[usr.tier41max]","")
			if("Spider")alert("  [usr.tier41]/[usr.tier41max]","")
			if("Sound")alert("  [usr.tier41]/[usr.tier41max]","")
			if("Senju")alert("Increase the heal aura of your trees by [t*3]% and increase the lifetime of the trees by [t*2] seconds. [usr.tier41]/[usr.tier41max]","")
			if("Medic")alert("Health and chakra regeneration is increased by [2*t].")
			if("Iron")alert("Increase length of Golden Sand by [1.5*t] seconds.")
			if("Snake")alert("Binding Snake Glare will execute victims' under [10+2.5*t]% max hp.")
			if("Clay")alert("Upon taking fatal damage, you have 3 seconds to click and bomb that location, causing a massive explosion that does heavy damage + [t*8]% of the enemies' missing health as damage.")
			if("Copy Ninja")alert("Increase chakra regeneration by [t*50]%. [usr.tier41]/[usr.tier41max]")
			if("Nara")alert(" Reduce the cooldown on shadow jutsus by [t*5]%. [usr.tier41]/[usr.tier41max]")
			if("Taijutsu Specialist")alert("Hitting someone with melee or a taijutsu technique will steal [t*5]% of their damage for 10 seconds. [usr.tier41]/[usr.tier41max]")
		if(usr.skilltotal<15)
			alert("You need to have 15 skill points spent to unlock tier 2. [usr.skilltotal]/15")
			usr.skillusing=0
			return
		if(usr.tier41>=usr.tier41max)
			usr.skillusing=0
			return
		if(!usr.skillpoint)
			alert("You do not have any skill points")
			usr.skillusing=0
			return
		switch(input("Do you want to raise this skill to [usr.tier41+1]/[usr.tier41max]?") in list ("Yes","No"))
			if("Yes")
				usr.skillpoint--
				usr.skilltotal++
				usr.tier41++
				usr.skilllevel()
		usr.skillusing=0
	tierfour2/Click()
		if(usr.skillusing)return
		usr.skillusing=1
		var/t=usr.tier42+1
		if(usr.tier42==usr.tier42max)t--
		switch(usr.clan)
			if("Kaguya")alert("You learn the stance double blades. While activated you create a blade of bone in your off-hand. Increase attack power by [0.4*t] for every point of speed you have while in double blades. Increase attack speed by [15*t]% and increase bone resource regeneration by [t*10]%. Can not be used with Hardened Bone Sword. This type of bone sword is good for Kaguyas with a focus on agility. [usr.tier42]/[usr.tier42max]","Double Blades")
			if("Hyuuga")
				alert("You heal for [2*t]% of your maximum health and chakra each time you disable a target. [usr.tier42]/[usr.tier42max]","Chakra Reap")
			if("Fan")alert("Allows you to learn Mark of Death. This move will let you mark a enemy on your screen for 30 seconds. Dragon's storm will always focus on that target and all damage is increased by [t*10]% on that target. [usr.tier42]/[usr.tier42max]","Mark of Death")
			if("Uchiha")alert("Steal [40*t]% of the damage you deal with Ephemeral.   [usr.tier42]/[usr.tier42max]")
			if("Yuki")alert("Your senbons, senbon wave, demon ice mirrors and needle strike deal [t*8]% of your ninjutsu power over 3 seconds.  [usr.tier42]/[usr.tier42max]","")
			if("Sand")alert("Sand burial and shukaku's pike causes the target to bleed for 1% their maximum health for [1+2*t] seconds. Damage is halfened for sand shower and cripple sand burials and for additional hemorrhages while a hemorrhage is active.  [usr.tier42]/[usr.tier42max]","")
			if("Spider")alert("  [usr.tier42]/[usr.tier42max]","")
			if("Sound")alert("  [usr.tier21]/[usr.tier42max]","")
			if("Senju")alert("Consume [t*3]% of your current chakra and add it as damage when you use Tree Bind Burial. [usr.tier42]/[usr.tier42max]","")
			if("Medic")alert("Your healing jutsu is 25% more effective on targets under [10+15*t]% health. ")
			if("Iron")alert("While using Iron Sand Rain, use 1% of your current health per second to deal [100+20*t]% of that damage to the enemy.")
			if("Snake")alert("Your throwing toggle button gets replaced with a snake transformation. You are immune to slow effects for [t] seconds after you transform and you move at maximum speed. Getting hit by any attack breaks out of this form and decrease your current health by [40-10*t]% and slows you down heavily for [3-t] second. Animals ignore you while you are in this form. Cooldown refreshes after resting for 3 seconds.")
			if("Clay")alert("Any clones you summon will explode when they expire. Regular clones do [t*40]% nin damage and shadow clones do [t*8]% nin damage to nearby enemies.")
			if("Copy Ninja")alert("Increase critical strike rate by [t*3]%. [usr.tier42]/[usr.tier42max]")
			if("Nara")alert("Hitting someone with any of your offensive shadow jutsus stops their regen for [t*2] seconds. [usr.tier42]/[usr.tier42max]")
			if("Taijutsu Specialist")alert("Your taijutsu techniques will ignore [t*3]% of the enemies' defense. [usr.tier42]/[usr.tier42max]")
		if(usr.skilltotal<15)
			alert("You need to have 15 skill points spent to unlock tier 2. [usr.skilltotal]/15")
			usr.skillusing=0
			return
		if(usr.tier42>=usr.tier42max)
			usr.skillusing=0
			return
		if(!usr.skillpoint)
			alert("You do not have any skill points")
			usr.skillusing=0
			return
		switch(input("Do you want to raise this skill to [usr.tier42+1]/[usr.tier42max]?") in list ("Yes","No"))
			if("Yes")
				usr.skillpoint--
				usr.skilltotal++
				usr.tier42++
				if(usr.clan=="Copy Ninja")usr.critrate+=3
				if(usr.tier42==1&&usr.clan=="Kaguya")
					new/obj/jutsu/kaguya/Double_Blades(usr)
					usr<<"<b><font color=lime>You have learned Double Blades!"
				if(usr.tier42==1&&usr.clan=="Fan")
					new/obj/jutsu/wind/Mark_of_Death(usr)
					usr<<"<b><font color=lime>You have learned Mark of Death! Using this will let you mark a enemy for 30 seconds, increasing all damage done to that target while forcing your dragons storm to focus on that target."
				usr.skilllevel()
		usr.skillusing=0
	tierfour3/Click()
		if(usr.skillusing)return
		usr.skillusing=1
		var/t=usr.tier43+1
		if(usr.tier43==usr.tier43max)t--
		switch(usr.clan)
			if("Kaguya")alert("Kaguya Bloodlust changed to: You steal [4+4*t]% of the damage you deal with melee attacks. [usr.tier43]/[usr.tier43max]","Kaguya Bloodlust")
			if("Hyuuga")alert("Deals [t*6]% of the original damage of melee attacks and mountain crusher every second over 4 seconds. The bleeding damage stacks and refreshs on each application. Deals double damage while in precise striking stance. [usr.tier43]/[usr.tier43max]","Internal Bleeding")
			if("Fan")alert("Enables Sickling Wind and Sandstorm to critically strike and increases it's critical chance by [t*5]%. Ripping Gale's critical chance is also increased by [t*5]%. [usr.tier43]/[usr.tier43max]","Pounding Gale")
			if("Uchiha")alert("Increase chakra regeneration by [50*t]%.  [usr.tier43]/[usr.tier43max]","Chakra Flow")
			if("Yuki")alert("Strength and Taijutsu also increase your ninjutsu power by [t/10], and Ninjutsu increase your attack power by [t/5].  [usr.tier43]/[usr.tier43max]","")
			if("Sand")alert("Sand burial from sand shower and cripple drags the enemy back to you [t] tiles.  [usr.tier43]/[usr.tier43max]","")
			if("Spider")alert("  [usr.tier43]/[usr.tier43max]","")
			if("Sound")alert("  [usr.tier43]/[usr.tier43max]","")
			if("Senju")alert("Hitting someone with Wood Drill Barrage will slow them down for [0.6*t] seconds. [usr.tier43]/[usr.tier43max]","")
			if("Medic")alert("For each person that you chakra transfer, your attack and defense is increased by [0.3*t]%.")
			if("Iron")alert("Reduce the cooldown on Toxic Shock by [10*t]%.")
			if("Snake")alert("Increase your attack power and ninjutsu power by [15*t] and decrease the attack power and ninjutsu power you gain from your stats by [10+10*t]%.")
			if("Clay")alert("Your damage increases by [t*10]% when below 50% health. [usr.tier43]/[usr.tier43max]")
			if("Copy Ninja")alert("Increase Raikiri and Raiden damage by [t*10]% and increase their critical strike chance by [t*5]%. Criticals deal 30% more damage. [usr.tier43]/[usr.tier43max]")
			if("Nara")alert("Convert [t*10]% of the damage you do with Shadow Sewing to chakra. [usr.tier43]/[usr.tier43max]")
			if("Taijutsu Specialist")alert("Reduce the durations of slows on you by [t*10]%. [usr.tier43]/[usr.tier43max]")
		if(usr.skilltotal<15)
			alert("You need to have 15 skill points spent to unlock tier 2. [usr.skilltotal]/15")
			usr.skillusing=0
			return
		if(usr.tier43>=usr.tier43max)
			usr.skillusing=0
			return
		if(!usr.skillpoint)
			alert("You do not have any skill points")
			usr.skillusing=0
			return
		switch(input("Do you want to raise this skill to [usr.tier43+1]/[usr.tier43max]?") in list ("Yes","No"))
			if("Yes")
				usr.skillpoint--
				usr.skilltotal++
				usr.tier43++
				if(usr.clan=="Kaguya")usr.maxenergy+=5
				if(usr.clan=="Yuki")usr.forceupdate()
				usr.skilllevel()
		usr.skillusing=0
	tierfive1/Click()
		if(usr.skillusing)return
		usr.skillusing=1
		var/t=usr.tier51+1
		if(usr.tier51==usr.tier51max)t--
		switch(usr.clan)
			if("Kaguya")alert("Learns the ability Extreme Condensing. While activated your bone sword will become much larger and more powerful. Increase damage by [12*t]% and increase critical strike rate by [25*t]%. Decrease bone regeneration and attack speed by 30%. Can not be used with double blades. This form of bone sword is good for Kaguyas with a focus on strength. [usr.tier51]/[usr.tier51max]","Extreme Condensing")
			if("Hyuuga")alert("Empty palm gains [t] intensity and its cooldown is reduced to [18-4*t] seconds. [usr.tier51]/[usr.tier51max]","Power Palm")
			if("Fan")alert("Sickling Wind, Great Sickling Wind and Ripping Gale has a [15*t]% chance to hit again for 50% of the damage. [usr.tier51]/[usr.tier51max]","Gust Reaper")
			if("Uchiha")alert("Every [65-15*t] seconds the next target you damage will be marked with your hatred lasting 10 seconds. You steal 10% of your hatred target's melee and jutsu damage percentage while it's active. [usr.tier51]/[usr.tier51max]")
			if("Yuki")alert("A thousand needles of death, Ice Prison and Iceberg Smasher deal [t*8]% more damage and has [t*5]% less cooldown.  [usr.tier21]/[usr.tier21max]","")
			if("Sand")alert("Replaces sand shower with sand barrage. Sand barrage deals [80+40*t]% sand shuriken damage and has [5*t]% less cooldown. Sand barrage does more damage the longer it travels.  [usr.tier51]/[usr.tier51max]","")
			if("Spider")alert("  [usr.tier21]/[usr.tier21max]","")
			if("Sound")alert("  [usr.tier21]/[usr.tier21max]","")
			if("Senju")alert("Grants [t*3]% damage and defense while your Four Pillars Prison is up. [usr.tier21]/[usr.tier21max]","")
			if("Medic")
				if(usr.tier41<3)
					alert("You need to master Inner Flow to learn this skill.")
					usr.skillusing=0
					return
				alert("While activated your health regeneration is set to 60 health per second and chakra regeneration to -[30-5*t] per second. Your defense is also increased by 30% while this is active. When you deactivate this ability your defense is decreased by 1% for every two seconds it was active. This debuff lasts for 30 seconds.")
			if("Iron")alert("Iron Sand Cluster and Iron Sand Gathering slows the enemy for [t] seconds and deal [5*t]% more damage.")
			if("Snake")alert("Your Edo Tensei regenerates [0.5*t]% of its maximum health per second. The buff from sacrificing your Edo Tensei lasts [2*t] seconds longer.")
			if("Clay")alert("When one of your mines get triggered, you are notified of its coordinate, their health, level and their name. You can then teleport to its location provided that you are at maximum health. Also increases mine damage by [t*10]%.")
			if("Copy Ninja")alert("While charging forward during Raikiri and Raiden, you leave behind patches of static. The static slows the enemy down heavily for [t*1.5] seconds. [usr.tier51]/[usr.tier51max]")
			if("Nara")alert("Apply a slow for [1+(t*0.5)] seconds after you use Shadow Endgame. [usr.tier51]/[usr.tier51max]")
			if("Taijutsu Specialist")alert("Increase the duration of Gates by [t*2] seconds and increase the positive effects by [t*5]%. [usr.tier51]/[usr.tier51max]")
		if(usr.skilltotal<20)
			alert("You need to have 20 skill points spent to unlock tier 2. [usr.skilltotal]/20")
			usr.skillusing=0
			return
		if(usr.tier51>=usr.tier51max)
			usr.skillusing=0
			return
		if(!usr.skillpoint)
			alert("You do not have any skill points")
			usr.skillusing=0
			return
		switch(input("Do you want to raise this skill to [usr.tier51+1]/[usr.tier51max]?") in list ("Yes","No"))
			if("Yes")
				usr.skillpoint--
				usr.skilltotal++
				usr.tier51++
				if(usr.tier51==1&&usr.clan=="Medic")
					new/obj/jutsu/medic/Mitotic_Regeneration(usr)
					usr<<"<b><font color=lime>You have learned Mitotic Regeneration."
				if(usr.tier51==1&&usr.clan=="Sand")
					for(var/obj/jutsu/sandc/Sand_Shower/M in usr)del M
					new/obj/jutsu/sandc/Sand_Barrage(usr)
					src<<"<center><b><font color=lime>Your Sand Shower is upgraded to Sand Barrage."
				if(usr.tier51==1&&usr.clan=="Kaguya")
					new/obj/jutsu/kaguya/Extreme_Condensing(usr)
					usr<<"<b><font color=lime>You have learned Extreme Condensing!"
				usr.skilllevel()
		usr.skillusing=0
	tierfive2/Click()
		if(usr.skillusing)return
		usr.skillusing=1
		var/t=usr.tier52+1
		if(usr.tier52==usr.tier52max)t--
		switch(usr.clan)
			if("Kaguya")alert("Reduces dance cooldown by [t*10]% and critical chance for dances by [t*5]%. [usr.tier52]/[usr.tier52max]","Master Bladedancer")
			if("Hyuuga")alert("Increase dodge rate by [t*5]%, attack speed by [t*8]% and critical rate by [t*3]%. [usr.tier52]/[usr.tier52max]","Byakugan Mastery")
			if("Fan")alert("Wind clan jutsus except for Dragon's Storm and Great Sickling Wind deal [t*10]% more damage after moving 4 tiles. [usr.tier52]/[usr.tier52max]","Buildup")
			if("Uchiha")alert("Transform into a flock of crows for [t+0.5] seconds, becoming invulnerable and immune to slows and stuns but can not attack. Can be used while stunned.  [usr.tier52]/[usr.tier52max]")
			if("Yuki")alert("Body flicker becomes a instant and has a [1+t*33]% chance to fire a senbon wave behind you. Backdash also has a [1+t*33]% chance to fire a senbon wave in front of you.  [usr.tier52]/[usr.tier52max]","")
			if("Sand")alert("Sand armour's casting time and chakra cost is reduced by [5+15*t]%.  [usr.tier52]/[usr.tier52max]","")
			if("Spider")alert("  [usr.tier52]/[usr.tier52max]","")
			if("Sound")alert("  [usr.tier52]/[usr.tier52max]","")
			if("Senju")alert("Gain [t*3]% cooldown reduction for wood jutsus. [usr.tier52]/[usr.tier52max]","")
			if("Medic")alert("You can buff [t] more targets with Chakra Transfer. The chakra transfer persists after death and degenerates at -[25*t]% speed while the person is recovering.")
			if("Iron")alert("Your toxic shock prevents enemies from using substitution and lightning flash for [1.5*t] seconds.")
			if("Snake")alert("Your Striking Shadow Snake, Viper Strike and Binding Snake Glare causes 2 snakes to appear close to the enemy. Stepping on the snake slows the enemy down for [t] seconds and deals [20*t]% ninjutsu damage. The snakes last up to 20 seconds. ")
			if("Clay")alert("All of your explosions have a [t*10]% chance to critically strike, dealing 40% more damage.")
			if("Copy Ninja")alert("Learn the ability Assassinate. Instantly teleport behind the enemy and stunning them for 0.5 second. Has a [50-(t*10)] second cooldown. [usr.tier52]/[usr.tier52max]")
			if("Nara")alert("Bombs that collide with an enemy from Shadow Clutch deal extra damage equal to [t*4]% of their missing health. [usr.tier52]/[usr.tier52max]")
			if("Taijutsu Specialist")alert("Hitting someone with Dynamic Entry causes them to bleed for 5 seconds. The bleed applies a weak slow, and deals [t*10]% of the damage of dynamic entry over the duration. [usr.tier52]/[usr.tier52max]")
		if(usr.skilltotal<20)
			alert("You need to have 20 skill points spent to unlock tier 2. [usr.skilltotal]/20")
			usr.skillusing=0
			return
		if(usr.tier52>=usr.tier52max)
			usr.skillusing=0
			return
		if(!usr.skillpoint)
			alert("You do not have any skill points")
			usr.skillusing=0
			return
		switch(input("Do you want to raise this skill to [usr.tier52+1]/[usr.tier52max]?") in list ("Yes","No"))
			if("Yes")
				usr.skillpoint--
				usr.skilltotal++
				usr.tier52++
				if(usr.clan=="Copy Ninja"&&usr.tier52==1)
					usr<<"<b><font color=lime>You have learned Assassinate! This move instantly positions you behind a enemy's back and stuns them momentarily, allowing you to execute deadly criticals. Must be within 4 steps of someone to activate."
					new/obj/jutsu/Assassinate(usr)
				if(usr.tier52==1&&usr.clan=="Uchiha")
					new/obj/jutsu/uchiha/Disperse(usr)
				usr.forceupdate()
				usr.skilllevel()
		usr.skillusing=0
	tierfive3/Click()
		if(usr.skillusing)return
		usr.skillusing=1
		var/t=usr.tier53+1
		if(usr.tier53==usr.tier53max)t--
		switch(usr.clan)
			if("Kaguya")alert("Learns the ability Bone Golem, increasing your defense by 25% for [t*4] seconds but removing your ability to run while this is active. [usr.tier53]/[usr.tier53max]","Bone Golem")
			if("Hyuuga")alert("Learns the ability Rapid Palms. While this stance is active your attack speed is increased every punch for up to 10 punches. Your critical strike chance is halved. [usr.tier53]/[usr.tier53max]","Power Palm")
			if("Fan")alert("You gain [t*3]% damage. Dragon's storm shredding damage is also increased by [t*10]%. [usr.tier53]/[usr.tier53max]","Razor Blades")
			if("Uchiha")alert("Increases jutsu damage by 30% and triples the chakra cost of all jutsus. Each time you reach 0 chakra you expend [35-5*t]% of your current health to restore 50% of your maximum chakra.   [usr.tier53]/[usr.tier53max]")
			if("Yuki")alert("Receive [20*t]% defense penetration.  [usr.tier53]/[usr.tier53max]","")
			if("Sand")alert("Sand coffin lasts [0.5+t*0.5] second longer and deal 1% of the enemy's current health in damage every half second.  [usr.tier53]/[usr.tier53max]","")
			if("Spider")alert("  [usr.tier53]/[usr.tier53max]","")
			if("Sound")alert("  [usr.tier53]/[usr.tier53max]","")
			if("Senju")alert("Tree Bind Burial causes a serious rupture in the enemies' body. Deals [t*25]% of the damage over 2.5 seconds. [usr.tier53]/[usr.tier53max]","")
			if("Medic")alert("Healing wave causes additional healing equal to [8*t]% of the original healing over 5 seconds.")
			if("Iron")alert("You gain [10*t]% defense while using golden sand.")
			if("Snake")alert("Reduce cooldown for immortality jutsu [20*t] seconds.")
			if("Clay")alert("Learn the ability Last Resort. This ability charges your remaining chakra as damage in the next C3 bomb you drop in the next 10 seconds with [t*25]% conversion efficiency, and causes your next C3 in the next 10 seconds to cost 0 chakra.")
			if("Copy Ninja")alert("Deal [t*10]% more damage to people below 30% hp. [usr.tier53]/[usr.tier53max]")
			if("Nara")alert("Heal for [t]% of your max hp per second while you have someone in Shadow Imitation. [usr.tier53]/[usr.tier53max]")
			if("Taijutsu Specialist")alert("After using a taijutsu technique, gain [t*50]% attack speed for 5 seconds. Does not stack. [usr.tier53]/[usr.tier53max]")
		if(usr.skilltotal<20)
			alert("You need to have 20 skill points spent to unlock tier 2. [usr.skilltotal]/20")
			usr.skillusing=0
			return
		if(usr.tier53>=usr.tier53max)
			usr.skillusing=0
			return
		if(!usr.skillpoint)
			alert("You do not have any skill points")
			usr.skillusing=0
			return
		switch(input("Do you want to raise this skill to [usr.tier53+1]/[usr.tier53max]?") in list ("Yes","No"))
			if("Yes")
				usr.skillpoint--
				usr.skilltotal++
				usr.tier53++
				if(usr.tier53==1&&usr.clan=="Kaguya")
					new/obj/jutsu/kaguya/Bone_Golem(usr)
					usr<<"<b><font color=lime>You have learned Bone Golem!"
				if(usr.tier53==1&&usr.clan=="Hyuuga")
					new/obj/jutsu/hyuuga/Rapid_Palms(usr)
					usr<<"<b><font color=lime>You have learned Rapid Palms! While this stance is active your attack speed is increased every punch for up to 10 punches. Your critical strike chance is halved. Only one stance can be active at the same time."
				if(usr.tier53==1&&usr.clan=="Clay")
					new/obj/jutsu/clay/Last_Resort(usr)
					usr<<"<b><font color=lime>You have learned Last Resort."
				usr.skilllevel()
		usr.skillusing=0
	tiersix1/Click()
		if(usr.skillusing)return
		usr.skillusing=1
		var/t=usr.tier61+1
		if(usr.tier61==usr.tier61max)t--
		switch(usr.clan)
			if("Kaguya")alert("While Bone Golem is active, set your health regeneration to 40 per second. [usr.tier61]/1","Rooted to the Bone")
			if("Hyuuga")alert("Causes every third melee attack to deal [20*t]% extra damage and causing double disable stacks while using rapid palms.","Shockwave")
			if("Fan")alert("Swing charge time of dragon's storm is decreased by [25+t*25]%. [usr.tier61]/[usr.tier61max]","Wind Mastery")
			if("Uchiha")alert("Fire jutsus and flames engulf the enemy in fire, slowing them and damaging them for 1% of their current health plus 1% of their maximum health per second for [t] seconds. While in Mangekyou Sharingan, it damages for 2% of their maximum health per second.  [usr.tier61]/[usr.tier61max]")
			if("Yuki")alert("You automatically use Water Clone jutsu and take [5+t*5]% less damage when you are under 20% hp. This effect refreshes every 20 seconds as long as you are under 20% hp.  [usr.tier61]/[usr.tier61max]","")
			if("Sand")alert("Your sand armour automatically refreshes upon reaching under 20% health. The sand armour has [50*t]% of normal sand armour durability  [usr.tier61]/[usr.tier61max]","")
			if("Spider")alert("  [usr.tier61]/[usr.tier61max]","")
			if("Sound")alert("  [usr.tier61]/[usr.tier61max]","")
			if("Senju")alert("When you form your Four Pillars Prison, the walls of the prison will fire [t*4] wood drills each. [usr.tier61]/[usr.tier61max]","")
			if("Medic")alert("Slows are reduced by level [1+t] while under pre-healing jutsu. Reduce cooldown of pre-healing jutsu by [5*t]%.")
			if("Iron")alert("Every [55-15*t] seconds, your next poison applying jutsu instantly applies 5 stacks of poison and you restore 10% of your chakra.")
			if("Snake")alert("You gain [8*t]% defense while your Edo Tensei is alive.")
			if("Clay")alert("Increase the amount of mines you can place from 6 to [6+(t*2)].")
			if("Copy Ninja")alert("Learn the ability rally. When activated you and all nearby allies deal 10% extra damage and take 10% less damage for [t*4] seconds. [usr.tier61]/[usr.tier61max]")
			if("Nara")alert("Learn Shadow Fists. You fire [t] wave(s) of shadow fists that deal damage based on how much hp theyre missing. Deals 25% ninjutsu power + 3% of their missing hp as damage. Damage is increased by 10% against targets under your shadow imitation. [usr.tier61]/[usr.tier61max]")
			if("Taijutsu Specialist")alert("Decrease the cooldown of your taijutsu techniques by [t] second(s). For every [175-(t*25)] hp you're missing, decrease the cooldowns by 1 additional second. Cooldowns cannot fall below 10 seconds. [usr.tier61]/[usr.tier61max]")
		if(usr.skilltotal<25)
			alert("You need to have 25 skill points spent to unlock tier 2. [usr.skilltotal]/25")
			usr.skillusing=0
			return
		if(usr.tier61>=usr.tier61max)
			usr.skillusing=0
			return
		if(!usr.skillpoint)
			alert("You do not have any skill points")
			usr.skillusing=0
			return
		switch(input("Do you want to raise this skill to [usr.tier61+1]/[usr.tier61max]?") in list ("Yes","No"))
			if("Yes")
				usr.skillpoint--
				usr.skilltotal++
				usr.tier61++
				if(usr.clan=="Copy Ninja"&&usr.tier61==1)
					usr<<"<b><font color=lime>You have learned Rally! This jutsu encourages nearby allies. You and nearby allies are granted damage and defense for a short period of time."
					new/obj/jutsu/copynin/Rally(usr)
				if(usr.clan=="Nara"&&usr.tier61==1)
					new/obj/jutsu/nara/Shadow_Fists(usr)
					usr<<"<b><font color=lime>You have learned Shadow Fists! This jutsu fires waves of shadow fists that deal damage based on how much hp the enemy is missing!"
				usr.skilllevel()
		usr.skillusing=0
	tiersix2/Click()
		if(usr.skillusing)return
		usr.skillusing=1
		var/t=usr.tier62+1
		if(usr.tier62==usr.tier62max)t--
		switch(usr.clan)
			if("Kaguya")alert("Reduce cost of dance of the seedling ferns by [20*t]%, and increase the damage while traveling in the bones by 20/40/60%. [usr.tier62]/[usr.tier62max]","Seedling Mastery")
			if("Hyuuga")alert("Learns the ability Eight Trigram: One Hundred and Twenty Eight Palms. [usr.tier62]/[usr.tier62max]","Pinpoint")
			if("Fan")alert("Has a [20+t*10]% chance to create a second dragon's storm when you use dragon's storm that deals 50% of the original's damage [usr.tier62]/[usr.tier62max]","Twin Dragoons")
			if("Uchiha")alert("Reduce the drawbacks of Mangekyou Sharingan by [5+15*t]%.   [usr.tier62]/[usr.tier62max]")
			if("Yuki")alert("Your damage is increased by [t*2]%. Additionally, you instantly regenerate 25% health and chakra and gain 40% increased damage for 5 seconds after defeating a enemy not less than 30 levels under you.  [usr.tier62]/[usr.tier62max]","")
			if("Sand")alert("If the enemy would have less than [4+4*t]% health after your sand burial from sand coffin or sand tsunami, your sand burial will instantly kill them.  [usr.tier62]/[usr.tier62max]","")
			if("Spider")alert("  [usr.tier62]/[usr.tier62max]","")
			if("Sound")alert("  [usr.tier62]/[usr.tier62max]","")
			if("Senju")alert("Increases all self healing by [t*4]% [usr.tier62]/[usr.tier62max]","")
			if("Medic")alert("Your chakra transfer lasts [2*t] more minutes.")
			if("Iron")alert("Your iron sand unleash deals [10*t]% more damage and has [1+33*t]% less charging time. The slow magnitude is also increased.")
			if("Snake")alert("You become invisible for [0.5+0.5*t] seconds after you resurrect from immortality jutsu. You also bind your killer for [t*0.6] seconds.")
			if("Clay")alert("Requires Katsu!!. Your critical explosions briefly stuns the enemy for [t*0.25] seconds and causes their attack speed and handseal speed to have double their delay for [t*1.5] seconds.")
			if("Copy Ninja")alert("While Rally is active, your sharingan costs no chakra and your damage is increased by an additional 10% and you have a 20% chance to take 20% less damage from any attack. [usr.tier62]/[usr.tier62max]")
			if("Nara")alert("Catching someone in Shadow Imitation applies a debuff that will reduce their damage by [t*10]% for [t*2] seconds after they are released. [usr.tier62]/[usr.tier62max]")
			if("Taijutsu Specialist")alert("The fire sent forth by Morning Peacock will burn people they go through, dealing [t]% of their max hp as damage. [usr.tier62]/[usr.tier62max]")
		if(usr.skilltotal<25)
			alert("You need to have 25 skill points spent to unlock tier 2. [usr.skilltotal]/25")
			usr.skillusing=0
			return
		if(usr.tier62>=usr.tier62max)
			usr.skillusing=0
			return
		if(!usr.skillpoint)
			alert("You do not have any skill points")
			usr.skillusing=0
			return
		switch(input("Do you want to raise this skill to [usr.tier62+1]/[usr.tier62max]?") in list ("Yes","No"))
			if("Yes")
				usr.skillpoint--
				usr.skilltotal++
				usr.tier62++
				if(usr.tier62==1&&usr.clan=="Hyuuga")
					new/obj/jutsu/hyuuga/One_Twenty_Eight_Palms(usr)
					usr<<"<b><font color=lime>You have learned a ultimate jutsu, Eight Trigrams One Hundred and Eight Palms. This move will create a huge circle and everyone that is caught in it will get hit for health and chakra damage repeatedly, usually causing fatal damage to one or major damage to a group of enemies."
				usr.skilllevel()
		usr.skillusing=0

	tiersix3/Click()
		if(usr.skillusing)
			return
		usr.skillusing = 1
		var/t=usr.tier63 + 1
		if(usr.tier63 == usr.tier63max)
			t--
		switch(usr.clan)
			if("Kaguya")alert("Increase cleave damage to [1+t*0.5]% of the enemy's max health per second.","Impaler")
			if("Hyuuga")alert("Precise striking causes your critical strikes to deal 20% more damage and reduce the enemy's defense by 10% for 5 seconds, stacking up to [1+t] times. You gain 5% defense for 5 seconds every time you apply this debuff up to 30% bonus defense. [usr.tier63]/[usr.tier63max]","Mountain Palms")
			if("Fan")alert("Has a [5+t*5]% chance to make the enemy spin around after a wind jutsu for 0.7 second. They will be unable to do any action in that period of time. [usr.tier63]/[usr.tier63max]","Twister")
			if("Uchiha")alert("Learns Vengeance. While vengence is active you take no damage from any source and become immune to slows. Lasts [t+1] seconds. After this jutsu's effects are over, you take [100-t*15]% of the damage you would have taken. You can not die from this backlash effect. [usr.tier63]/[usr.tier63max]")
			if("Yuki")alert("Ice Prison and Iceberg Smasher leaves a mark of frost on the enemy for 10 seconds. If they get damaged by a thousand needles of death it will trigger the mark, freezing them for [t*0.5] second and damaging them for [t*15]% of your ninjutsu power.  [usr.tier63]/[usr.tier63max]","")
			if("Sand")alert("Enemies struck by your Shukaku's pike take 20% more damage, can not regenerate health and leave a trail of blood for [t*10] seconds.  [usr.tier63]/[usr.tier63max]","")
			if("Spider")alert("  [usr.tier63]/[usr.tier63max]","")
			if("Sound")alert("  [usr.tier63]/[usr.tier63max]","")
			if("Senju")alert("Learn Sage Mode. Increases damage and defense by [t*3]%, changes your melee to NIN based, increases attack speed by [t*50]%, and grants [t*10]% increased critical strike rate for 15 seconds. Has a [120-(t*20)] second cooldown. [usr.tier63]/[usr.tier63max]","")
			if("Medic")
				if(usr.tier53<3)
					alert("You need to master Oath to learn this skill.")
					usr.skillusing=0
					return
				alert("While Oath is active on you, your damage over time effects deal [40*t]% more damage. While an enemy is poisoned, your Oath heals for [40*t]% more.")
			if("Iron")alert("Everyone within [1+2*t] tiles of the impact of your iron sand cluster will get stunned for 1.2 second. ")
			if("Snake")alert("Your melee with the Sword of Kusanagi deals an additional [0.75*t]% of the enemy's missing health in damage.")
			if("Clay")alert("Take [t*25]% less damage while charging, during, and for 3 seconds after you use C4.")
			if("Copy Ninja")alert("Increase damage dealt by 5% and reduce damage taken by 3% every time you use a copied jutsu. Stacks up to 4 times. Stacks fall off [4+t] seconds after they are applied. [usr.tier63]/[usr.tier63max]")
			if("Nara")alert("After using any shadow jutsus, gain a stack of recurrence. Every stack increases your damage and cooldown reduction by [t*2]%. Stacks up to 5 times. Stacks fall off 5 seconds after theyre applied [usr.tier63]/[usr.tier63max]")
			if("Taijutsu Specialist")alert("Your taijutsu techniques will execute people below [t*4]% max hp. [usr.tier63]/[usr.tier63max]")
		if(usr.skilltotal < 25)
			alert("You need to have 25 skill points spent to unlock tier 2. [usr.skilltotal]/25")
			usr.skillusing = 0
			return
		if(usr.tier63 >= usr.tier63max)
			usr.skillusing = 0
			return
		if(!usr.skillpoint)
			alert("You do not have any skill points")
			usr.skillusing = 0
			return
		switch(input("Do you want to raise this skill to [usr.tier63+1]/[usr.tier63max]?") in list ("Yes","No"))
			if("Yes")
				usr.skillpoint --
				usr.skilltotal ++
				usr.tier63 ++
				if(usr.clan == "Kaguya")
					usr.maxenergy += 5
				if(usr.tier63 == 1 && usr.clan == "Uchiha")
					new/obj/jutsu/uchiha/Vengeance(usr)
				if(usr.tier63==1&&usr.clan=="Senju")
					new/obj/jutsu/senju/Sage_Mode(usr)
					usr<<"<b><font color=lime>You have learned Sage Mode."
				usr.skilllevel()
		usr.skillusing = 0

mob/proc
	trainingfaq()
		var/window = {"
<STYLE>BODY {background: black; color: silver}</STYLE>
<html>
<body>
<center>-----------------------------------------------------------------
<br><b>Stats FAQ</center></b>
<br>
<br>There are 7 stats in NNG. Strength, Stamina, Intelligence, Speed, Taijutsu, Ninjutsu and Handseals.
<br>Strength, Taijutsu and Speed improves your melee capabilities, while Ninjutsu, Intelligence and Handseals increase your jutsu capabilities. Stamina is vital to stay alive for any build.
<br>
<br><b>Strength: </b>Highly affect physical damage, slightly affect health
<br><b>Stamina.</b> Highly affect health, energy regeneration and health regeneration
<br><b>Intelligence:</b> Highly affect chakra pool, chakra regeneration, chakra control and has various other effects
<br><b>Speed:</b> Affects critical strike rate, cooldown reduction, attack speed and dodge rate. You also learn various jutsus from raising speed.
<br><b>Taijutsu: </b>Affects melee jutsu cooldown reduction, attack speed, dodge, accuracy and attack power
<br><b>Ninjutsu:</b> Affect ninjutsu cooldown reduction and highly affect ninjutsu power
<br><b>Handseals:</b> Affects chakra control and handseal speed
<br><center>-----------------------------------------------------------------
<br><b>Training FAQ</center></b>
<br>
<br>To gain stats, you must first get experience through doing missions or killing enemies. <br>You also gain a little experience from doing almost anything. Once you have experience <br>you must convert that experience into stat experience. Converting experience to stat <br>experience is different for each stat.
<br>
<br><b>Strength</b> - Punch while wearing weights
<br><b>Stamina</b> - Waterfall Meditation
<br><b>Intelligence</b> - Meditation
<br><b>Ninjutsu</b> - Elemental Focus(Press F/attack while resting on water)
<br><b>Taijutsu</b> - Punching logs
<br><b>Speed</b> - Run while wearing weights
<br><b>Handseals</b> - Practice Handseals(Hotkey J)
<br>
<br>You level up when you gain a stat. When you level up, you gain a small amount of health and chakra pool and learn new abilities. The maximum you can have on any individual stat is 30, while your level cap is initially 60 up to a maximum of 120 through rebirths.
<br><center>-----------------------------------------------------------------
<br><b>Detailed Stat Guide</center>
<br>
<br>Level Up:</b> +20 health, +5 chakra
<br><b>Strength:</b> +25 health, +15 attack power
<br><b>Stamina.</b> +100 health, +0.2 energy regen per second, +1.4 health per second
<br><b>Intelligence:</b> +25 chakra, +1 chakra regen per second, +4 chakra control, -0.25% ninjutsu cooldown, +2% training speed, +4% business skill*, +1 genjutsu proficiency, +1 genjutsu resistance, +0.5% critical rate
<br><b>Speed:</b> +1% critical defense, +1% critical rate, -0.5% cooldown, -0.025 attack delay, +3% dodge
<br><b>Taijutsu:</b> -1% taijutsu cooldown, -0.04 attack delay, +3% dodge, +4% accuracy, +6 attack power, +1 taijutsu proficiency
<br><b>Ninjutsu:</b> -1% ninjutsu cooldown, +15 ninjutsu power, +1 ninjutsu proficiency")
<br><b>Handseals:</b> +2 chakra control, +0.33 second handseal speed
<br><center>-----------------------------------------------------------------
</font>
</center>
</body>
</html>
"}
		usr << browse(window,"window=Training FAQ;size=500x600")
	donationinfo()
		var/window = {"
<STYLE>BODY {background: black; color: silver}</STYLE>
<html>
<body>
<center>-----------------------------------------------------------------
<br><b><font color=silver>Information on Donating</b>
<br>
<br><u>No unfair advantages, such as damage or defense boosts, will be given out.
<br>Do not even ask. You will be denied later purchases.</u>
<br>
<br>The purpose of donating is to support the developer.
<br>Not to make others suffer because you had money to spend.
<br>
<br>The following packages are available for purchase:
<br>
<br>$5.00
<br>650 NNG Credits
<br>+0 Bonus NNG Credits
<br>
<br>$10.00
<br>1300 NNG Credits
<br>+80 Bonus NNG Credits
<br>
<br>$20.00
<br>2600 NNG Credits
<br>+200 Bonus NNG Credits
<br>
<br>$35.00
<br>4550 NNG Credits
<br>+450 Bonus NNG Credits
<br>
<br>$50.00
<br>6500 NNG Credits
<br>+700 Bonus NNG Credits
<br>
<br>$100.00
<br>13000 NNG Credits
<br>+2000 Bonus NNG Credits
<br>
<br>Purchasing any of the above packages gives you the following:
<br>
<br>Optional Subscriber Status
<br>+5% training speed
<br>Chat exclusive to Subscribers
<br>
<br>NNG Credits can be spent at the Credits Shop for various things.
<br>
<br>Notes:
<br><u>There are absolutely no refunds. You are responsible for
<br>charges to your account!</u>
<br>You can give NNG Credits to your friends.
<br>
<br>
<br>
<img><form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
<input type="hidden" name="cmd" value="_s-xclick">
<input type="hidden" name="encrypted" value="-----BEGIN PKCS7-----MIIHNwYJKoZIhvcNAQcEoIIHKDCCByQCAQExggEwMIIBLAIBADCBlDCBjjELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRYwFAYDVQQHEw1Nb3VudGFpbiBWaWV3MRQwEgYDVQQKEwtQYXlQYWwgSW5jLjETMBEGA1UECxQKbGl2ZV9jZXJ0czERMA8GA1UEAxQIbGl2ZV9hcGkxHDAaBgkqhkiG9w0BCQEWDXJlQHBheXBhbC5jb20CAQAwDQYJKoZIhvcNAQEBBQAEgYCKrndiLgjTkMfOw4N2fmZhEfFlCE0rPcWjI/LE9xgn/sw5+l3SAxO7AycYElHn2bE+aLWgkwLLw2ibPPbYuMgTSXEY0lAEI3bTWja3a5+x7tKrIDRa4FVwlLLR/IyT58bQ8qJoHyKv7kguDS9zwcHmV4oh8lulw9cdtNOnDJavMjELMAkGBSsOAwIaBQAwgbQGCSqGSIb3DQEHATAUBggqhkiG9w0DBwQIOgyAW2I+sueAgZDF3iUgFBizNUuLXf4EZ1Q6zXE3xNboF+GAO2eblXL5x/llROZ27840Cm8nSB5Nwed+dPFxL8fJRM6t1R7sRrcJxwTig1OsXNGTs0AkdQe92DvCCcLzPTpwA9oNit3om0HCbz7Zo7izGLJypdI6I0eAe9NwKcsaHRLti4R11gQm6pkvlwci7jVgdgrjZilFssGgggOHMIIDgzCCAuygAwIBAgIBADANBgkqhkiG9w0BAQUFADCBjjELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRYwFAYDVQQHEw1Nb3VudGFpbiBWaWV3MRQwEgYDVQQKEwtQYXlQYWwgSW5jLjETMBEGA1UECxQKbGl2ZV9jZXJ0czERMA8GA1UEAxQIbGl2ZV9hcGkxHDAaBgkqhkiG9w0BCQEWDXJlQHBheXBhbC5jb20wHhcNMDQwMjEzMTAxMzE1WhcNMzUwMjEzMTAxMzE1WjCBjjELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRYwFAYDVQQHEw1Nb3VudGFpbiBWaWV3MRQwEgYDVQQKEwtQYXlQYWwgSW5jLjETMBEGA1UECxQKbGl2ZV9jZXJ0czERMA8GA1UEAxQIbGl2ZV9hcGkxHDAaBgkqhkiG9w0BCQEWDXJlQHBheXBhbC5jb20wgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMFHTt38RMxLXJyO2SmS+Ndl72T7oKJ4u4uw+6awntALWh03PewmIJuzbALScsTS4sZoS1fKciBGoh11gIfHzylvkdNe/hJl66/RGqrj5rFb08sAABNTzDTiqqNpJeBsYs/c2aiGozptX2RlnBktH+SUNpAajW724Nv2Wvhif6sFAgMBAAGjge4wgeswHQYDVR0OBBYEFJaffLvGbxe9WT9S1wob7BDWZJRrMIG7BgNVHSMEgbMwgbCAFJaffLvGbxe9WT9S1wob7BDWZJRroYGUpIGRMIGOMQswCQYDVQQGEwJVUzELMAkGA1UECBMCQ0ExFjAUBgNVBAcTDU1vdW50YWluIFZpZXcxFDASBgNVBAoTC1BheVBhbCBJbmMuMRMwEQYDVQQLFApsaXZlX2NlcnRzMREwDwYDVQQDFAhsaXZlX2FwaTEcMBoGCSqGSIb3DQEJARYNcmVAcGF5cGFsLmNvbYIBADAMBgNVHRMEBTADAQH/MA0GCSqGSIb3DQEBBQUAA4GBAIFfOlaagFrl71+jq6OKidbWFSE+Q4FqROvdgIONth+8kSK//Y/4ihuE4Ymvzn5ceE3S/iBSQQMjyvb+s2TWbQYDwcp129OPIbD9epdr4tJOUNiSojw7BHwYRiPh58S1xGlFgHFXwrEBb3dgNbMUa+u4qectsMAXpVHnD9wIyfmHMYIBmjCCAZYCAQEwgZQwgY4xCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJDQTEWMBQGA1UEBxMNTW91bnRhaW4gVmlldzEUMBIGA1UEChMLUGF5UGFsIEluYy4xEzARBgNVBAsUCmxpdmVfY2VydHMxETAPBgNVBAMUCGxpdmVfYXBpMRwwGgYJKoZIhvcNAQkBFg1yZUBwYXlwYWwuY29tAgEAMAkGBSsOAwIaBQCgXTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNDExMjIwMDE5MzRaMCMGCSqGSIb3DQEJBDEWBBReH3itaK6PZPZlfx99nnx1s7HzxDANBgkqhkiG9w0BAQEFAASBgFvMuhW8FrIATKnmejfrxEDRvilZSjTYSTX2rNctfDM1YP3ISkEtfLPItGALX/IYROnEsV6VjmegVgGk0qPeD7WnlGsrlZ+D16Lhy8YBw6BSkcI3bZCNJLeCTujg9nMy8Oxd8k98LVerwJW158MQc60/YXpJLuXcoWGmQw1rDBWj-----END PKCS7-----
">
<input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
<img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
</form>
<br>
<br><b>Credits Shop</b>
<br>
<br><b>Golden Scroll(250 NNG Credits)</b>
<br>Grants 500% exp gain for 6 minutes
<br>
<br><b>Custom Status(200 NNG Credits)</b>
<br>Create your own custom status to be made known by
<br>
<br><b>Custom Color Texts(150 NNG Credits)</b>
<br>Choose from a variety of colors to use as your text color
<br>
<br><b>10 Senryo(100 NNG Credits)</b>
<br>Buy in-game currency to purchase various things
<br>
<br><b>Random Armor Scroll(100 NNG Credits)</b>
<br>Will create a random piece of armor for you to wear
<br>
<br><b>4 Random Armor Scrolls(250 NNG Credits)</b>
<br>Will create a random piece of armor for you to wear
<br>
<br><b>1 Free Respec(150 NNG Credits)</b>
<br>Reset your skilltree and select a new set of passives
<br>
<br><b>Name Change(150 NNG Credits)</b>
<br>Change the name you go by
<br>
<br><b>+100% Ryo Gain(250 NNG Credits)</b>
<br>Gain extra ryo for the next 5 missions you do
<br>
<br><center>-----------------------------------------------------------------
</font>
</center>
</body>
</html>
"}
		usr << browse(window,"window=Training FAQ;size=600x800")
	rankfaq()
		var/window = {"
<STYLE>BODY {background: black; color: silver}</STYLE>
<html>
<body>
<center>
<center>-----------------------------------------------------------------
<br><b>Village Ranks</center></b>
<br>
<br><b>Academy Student: </b>Lowest ranking shinobi. Can only do rank D missions. Can advance to Genin by doing the Genin exam.
<br><b>Genin:</b> Low ranking shinobi graduated from the ninja academy. Has a shinobi forehead plate to signify that.  Can do up to rank C missions and vote in a village leader selection.
<br><b>Chunin:</b> Medium ranking shinobi. Can do up to rank A missions, although they can't do rank A missions very often. They get a vest for their rank.
<br><b>Jounin:</b> High ranking shinobi given to Chunins that have done at least 3 rank A missions. Jounins are candidates to become a village leader.
<br><b>ANBU: </b>
<br><b>Village Leader:</b> Hokage(Leaf), Kazekage(Sand) and Sound Leader(Sound).
<br><center>-----------------------------------------------------------------
</font>
</center>
</body>
</html>
"}
		usr << browse(window,"window=Rank FAQ;size=500x400")
mob/var/tmp/skillusing=0
obj/skilldark
	name="This skill can not be learned yet."
	icon='skillnumber.dmi'
	icon_state="dark"
	layer=180
	tier21
		screen_loc = "9,14"
		sand/screen_loc="8,14"
	tier22
		screen_loc = "11,14"
		sand/screen_loc="11,14"
	tier23
		screen_loc = "13,14"
		sand/screen_loc="14,14"
	tier31
		screen_loc = "9,12"
		sand/screen_loc="8,12"
	tier32
		screen_loc = "11,12"
		sand/screen_loc="11,12"
	tier33
		screen_loc = "13,12"
		sand/screen_loc="14,12"
	tier41
		screen_loc = "9,10"
		sand/screen_loc="8,10"
	tier42
		screen_loc = "11,10"
		sand/screen_loc="11,10"
	tier43
		screen_loc = "13,10"
		sand/screen_loc="14,10"
	tier51
		screen_loc = "9,8"
		sand/screen_loc="8,8"
	tier52
		screen_loc = "11,8"
		sand/screen_loc="11,8"
	tier53
		screen_loc = "13,8"
		sand/screen_loc="14,8"
	tier61
		screen_loc = "9,6"
		sand/screen_loc="8,6"
	tier62
		screen_loc = "11,6"
		sand/screen_loc="11,6"
	tier63
		screen_loc = "13,6"
		sand/screen_loc="14,6"
obj/skilllevel
	name=""
	icon = 'skillnumber.dmi'
	layer = 180
	tier11/screen_loc = "10,16"
	tier12/screen_loc = "12,16"
	tier13/screen_loc = "14,16"
	tier21/screen_loc = "10,14"
	tier22/screen_loc = "12,14"
	tier23/screen_loc = "14,14"
	tier31/screen_loc = "10,12"
	tier32/screen_loc = "12,12"
	tier33/screen_loc = "14,12"
	tier41/screen_loc = "10,10"
	tier42/screen_loc = "12,10"
	tier43/screen_loc = "14,10"
	tier51/screen_loc = "10,8"
	tier52/screen_loc = "12,8"
	tier53/screen_loc = "14,8"
	tier61/screen_loc = "10,6"
	tier62/screen_loc = "12,6"
	tier63/screen_loc = "14,6"
obj/eyeshadow
	icon='darken.dmi'
	layer=180
	blue/screen_loc = "6,9"
	green/screen_loc = "4,9"
	brown/screen_loc = "5,9"
	black/screen_loc = "3,9"
	hyuuga/screen_loc = "7,9"