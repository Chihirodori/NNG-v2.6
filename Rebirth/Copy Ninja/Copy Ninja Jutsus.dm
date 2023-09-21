mob/proc
	copyninleveling()
		if(level==2)
			src<<"<b><font color=cyan>You obtained a Sharingan Implant. While this is active, you gain 50% accuracy, 40% dodge, -3.5 handseal time, 8% damage increase, 8% defense increase, and 15% cooldown reduction."
			new/obj/jutsu/rebirth/Sharingan_Implant(src)
		if(level==3)
			src<<"<b><font color=cyan>You obtained a Blank Jutsu. Using this jutsu will allow you to copy another clan's jutsu. You will lose this ability when you copy a jutsu."
			new/obj/jutsu/copynin/Blank_Jutsu_1(src)
		if(level==10)
			src<<"<b><font color=cyan>You obtained a Blank Jutsu. Using this jutsu will allow you to copy another clan's jutsu. You will lose this ability when you copy a jutsu."
			new/obj/jutsu/copynin/Blank_Jutsu_2(src)
		if(level==22)
			src<<"<b><font color=cyan>You obtained a Blank Jutsu. Using this jutsu will allow you to copy another clan's jutsu. You will lose this ability when you copy a jutsu."
			new/obj/jutsu/copynin/Blank_Jutsu_3(src)
		if(level==35)
			src<<"<b><font color=cyan>You have learned Raikiri! You charge electricty in your hand for a short time, then dash forward extremely fast. You will drill into the first person you encounter, dealing massive damage."
			new/obj/jutsu/copynin/Raikiri(src)
		if(level==45)
			src<<"<b><font color=cyan>You obtained a Blank Jutsu. Using this jutsu will allow you to copy another clan's jutsu. You will lose this ability when you copy a jutsu."
			new/obj/jutsu/copynin/Blank_Jutsu_4(src)
		if(level==52)
			src<<"<b><font color=cyan>Your Raikiri is now level 2! It now deals 10% more damage."
		if(level==60)
			src<<"<b><font color=cyan>You obtained a Blank Jutsu. Using this jutsu will allow you to copy another clan's jutsu. You will lose this ability when you copy a jutsu."
			new/obj/jutsu/copynin/Blank_Jutsu_5(src)
		if(level==75)
			src<<"<b><font color=cyan>You have learned Raiden! This jutsu creates two clones of you. Electricity archs between the clones, and they rush forward. Anyone they encounter will be damaged heavily."
			new/obj/jutsu/copynin/Raiden(src)
		if(level==85)
			src<<"<b><font color=cyan>Your Raiden is now level 2! It now deals 10% more damage."
		if(level==90)
			src<<"<b><font color=cyan>Your Raikiri is now level 3! It now has no charge time."
		if(level==110)
			src<<"<b><font color=cyan>Your Raiden is now mastered! It now slows for 0.5 seconds."
		if(level==120)
			src<<"<b><font color=cyan>Your Raikiri is now mastered! It now slows for 1 seconds."
mob/var
	buttonscreen=0
	fuumadelay=0
	rally=0
	rallydelay=0
	raidening=0
	selfrally=0
	tactics=0
	copydelay1=0
	copydelay2=0
	copydelay3=0
	copydelay4=0
	copydelay5=0
	raidendelay=0
	raikiridelay=0
	copied1=0
	copied2=0
	copied3=0
	copied4=0
	copied5=0
obj
	rally
		layer=80
		icon='effect.dmi'
		icon_state="ele3"
		name="Rally"
		New()spawn(100)del src
	staticfieldov
		icon='Static.dmi'
	//	layer=45
		New()
			..()
			pixel_x+=rand(-8,8)
			pixel_y+=rand(-8,8)
	staticfield
		icon='Static.dmi'
		New()
			..()
			spawn(1)overlays+=new/obj/staticfieldov
			spawn(2)overlays+=new/obj/staticfieldov
			spawn(3)overlays+=new/obj/staticfieldov
			spawn(4)overlays+=new/obj/staticfieldov
			spawn(35)del src
		Crossed(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(O.aff==D.aff)return
				D.snared(15*O.tier51,3)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					T.loc=loc
	raidenoverlay
		layer=80
		icon='LightningArmor.dmi'
		icon_state="Aura"
		name="Raiden"
		New()spawn(100)del src
	raidenov
		icon='Raiden.dmi'
		layer=45
		New()
			..()
			pixel_x+=rand(-8,8)
			pixel_y+=rand(-8,8)
	raiden
		density=1
		icon='Raiden.dmi'
		layer=45
		rundelay=0
		New()
			..()
			spawn(1)overlays+=new/obj/raidenov
			spawn(2)overlays+=new/obj/raidenov
			spawn(3)overlays+=new/obj/raidenov
			spawn(4)overlays+=new/obj/raidenov
		Move()
			var/mob/M=owner
			if(M.tier51)
				var/obj/K=new/obj/staticfield(loc)
				K.owner=M
			..()
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				loc=D.loc
				if(O.aff==D.aff)return
				var/damage
				if(O.apow>O.pow)
					damage=O.apow*1.1
					if(D.clan=="Taijutsu Specialist")
						if(D.tier32)damage*=1-(D.tier32*0.05)
					D.dmgch(O,1)
				else
					damage=O.pow*1.1
					D.dmgch(O)
				if(O.tier43)damage*=1+(O.tier43*0.10)
				if(O.level>=85)damage*=1.1
				damage=(damage*D.variable)+D.variable2
				var/critchance=0+(O.tier43*5)
				if(prob(critchance))
					D.damage(damage,1.3)
				else
					D.damage(damage)
				if(O.level>=110)D.snared(5,1)
				D.death(O)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					loc=T.loc
obj/copyninjabuttons
	layer=99
	Fireball
		icon='Fireball.png'
		screen_loc = "CENTER-6,CENTER+4"
		Click()
			var/mob/O=usr
			O.copyjutsu("Fireball",1)
			..()
	SenbonWave
		icon='SenbonWave.png'
		screen_loc = "CENTER+3,CENTER+4"
		Click()
			var/mob/O=usr
			O.copyjutsu("Senbon Wave",1)
			..()
	SandClone
		icon='SandClone.png'
		screen_loc = "CENTER-6,CENTER-4"
		Click()
			var/mob/O=usr
			O.copyjutsu("Sand Clone",1)
			..()
	SicklingWind
		icon='SicklingWind.png'
		screen_loc = "CENTER+3,CENTER-4"
		Click()
			var/mob/O=usr
			O.copyjutsu("Sickling Wind",1)
			..()
	//
	StrikingShadowSnake
		icon='Shadow Snake.png'
		screen_loc = "CENTER-6,CENTER+4"
		Click()
			var/mob/O=usr
			O.copyjutsu("Shadow Snake",2)
			..()
	WaterClone
		icon='WaterClone.png'
		screen_loc = "CENTER+3,CENTER-4"
		Click()
			var/mob/O=usr
			O.copyjutsu("Water Clone",2)
			..()
	PeregrineFalconDrop
		icon='FalconDrop.png'
		screen_loc = "CENTER-6,CENTER-4"
		Click()
			var/mob/O=usr
			O.copyjutsu("Falcon Drop",2)
			..()
	PhoenixFlower
		icon='PhoenixFlower.png'
		screen_loc = "CENTER+3,CENTER+4"
		Click()
			var/mob/O=usr
			O.copyjutsu("Phoenix Flower",2)
			..()
	ThousandYears
		icon='1ThousandYears.png'
		screen_loc = "CENTER-1:-16,CENTER"
		Click()
			var/mob/O=usr
			O.copyjutsu("Thousand Years",2)
			..()
	//
	PreHealing
		icon='PreHealing.png'
		screen_loc = "CENTER-6,CENTER+4"
		Click()
			var/mob/O=usr
			O.copyjutsu("PreHealing",3)
			..()
	DragonFlames
		icon='DragonFlames.png'
		screen_loc = "CENTER+3,CENTER-4"
		Click()
			var/mob/O=usr
			O.copyjutsu("Dragon Flames",3)
			..()
	ChakraAbsorption
		icon='ChakraAbsorption.png'
		screen_loc = "CENTER-6,CENTER-4"
		Click()
			var/mob/O=usr
			O.copyjutsu("Chakra Absorption",3)
			..()
	ChakraScalpel
		icon='ChakraScalpel.png'
		screen_loc = "CENTER+3,CENTER+4"
		Click()
			var/mob/O=usr
			O.copyjutsu("Chakra Scalpel",3)
			..()
	//
	IcePrison
		icon='IcePrison.png'
		screen_loc = "CENTER-6,CENTER+4"
		Click()
			var/mob/O=usr
			O.copyjutsu("Ice Prison",4)
			..()
	PiercingGaze
		icon='PiercingGaze.png'
		screen_loc = "CENTER+3,CENTER-4"
		Click()
			var/mob/O=usr
			O.copyjutsu("Piercing Gaze",4)
			..()
	EmptyPalm
		icon='EmptyPalm.png'
		screen_loc = "CENTER-6,CENTER-4"
		Click()
			var/mob/O=usr
			O.copyjutsu("Empty Palm",4)
			..()
	TwinDragon
		icon='WeaponBarrage.png'
		screen_loc = "CENTER+3,CENTER+4"
		Click()
			var/mob/O=usr
			O.copyjutsu("Twin Dragon",4)
			..()
	Rasengan
		icon='Rasengan.png'
		screen_loc = "CENTER-1:-16,CENTER"
		Click()
			var/mob/O=usr
			O.copyjutsu("Rasengan",4)
			..()
	//
	GreatDragonFlames
		icon='GreatDragonFlames.png'
		screen_loc = "CENTER-6,CENTER+4"
		Click()
			var/mob/O=usr
			O.copyjutsu("Great Dragon Flames",5)
			..()
	DragonStorm
		icon='DragonsStorm.png'
		screen_loc = "CENTER+3,CENTER-4"
		Click()
			var/mob/O=usr
			O.copyjutsu("Dragons Storm",5)
			..()
	IcebergBreaker
		icon='IceBergBreaker.png'
		screen_loc = "CENTER-6,CENTER-4"
		Click()
			var/mob/O=usr
			O.copyjutsu("Iceberg Breaker",5)
			..()
	ViolentWindPalm
		icon='ViolentWindPalm.png'
		screen_loc = "CENTER+3,CENTER+4"
		Click()
			var/mob/O=usr
			O.copyjutsu("Violent Wind Palm",5)
			..()
	PoisonFog
		icon='PoisonFog.png'
		screen_loc = "CENTER-1:-16,CENTER"
		Click()
			var/mob/O=usr
			O.copyjutsu("Poison Fog",5)
			..()
mob/proc
	raiden()
		prejutsu()
		if(raidendelay||swim||dead||resting||stun||busy||moving||imitated||paralysed||busy=="raikiri"||hosptime||jailtime)return
		raidendelay=1
		handseals(40,10,40)
		if(!sealpass)
			raidendelay=0
			return
		var/sdelay=200
		for(var/obj/jutsu/copynin/Raiden/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)raidendelay=0
		var/L1=new/obj/raiden(loc)
		var/L2=new/obj/raiden(loc)
		var/L3=new/obj/raiden(loc)
		L1:owner=src
		L2:owner=src
		L3:owner=src
		if(dir==NORTH||dir==SOUTH)
			L2:loc=locate(x+1,y,z)
			L3:loc=locate(x-1,y,z)
		if(dir==EAST||dir==WEST)
			L2:loc=locate(x,y+1,z)
			L3:loc=locate(x,y-1,z)
		for(var/obj/raiden/M in view(3))if(M.owner==src)
			M.dir=dir
			M.raidenmove(dir)
		var/mob/Clone/raidenclone/K=new(loc)
		K.cloneowner=src
		var/mob/Clone/raidenclone/K1=new(loc)
		K1.cloneowner=src
		if(dir==NORTH||dir==SOUTH)
			K.loc=locate(x+2,y,z)
			K1.loc=locate(x-2,y,z)
		if(dir==EAST||dir==WEST)
			K.loc=locate(x,y+2,z)
			K1.loc=locate(x,y-2,z)
		for(var/mob/Clone/raidenclone/C in oview(3))if(C.cloneowner==src)
			C.icon=icon
			C.dir=dir
			C.aff=aff
			C.tier51=tier51
			C.moving=0
			C.overlays=overlays
			C.animate_movement=2
			C.name=name
			C.village=village
			C.rundelay=2
			var/obj/bars/healthbar/B1=new(C.loc)
			B1.barowner=C
			B1.copy(src)
			C.mybar=B1
			var/obj/bars/chakrabar/B2=new(C.loc)
			B2.barowner=C
			B2.copy(src)
			C.mybar2=B2
			C.raidenmove(dir)
	copyjutsu(var/jutsu="",var/D=0)
		if(D==1)
			for(var/obj/jutsu/copynin/Blank_Jutsu_1/J in src)del J
			copied1=1
		if(D==2)
			for(var/obj/jutsu/copynin/Blank_Jutsu_2/J in src)del J
			copied2=1
		if(D==3)
			for(var/obj/jutsu/copynin/Blank_Jutsu_3/J in src)del J
			copied3=1
		if(D==4)
			for(var/obj/jutsu/copynin/Blank_Jutsu_4/J in src)del J
			copied4=1
		if(D==5)
			for(var/obj/jutsu/copynin/Blank_Jutsu_5/J in src)del J
			copied5=1
		for(var/obj/copyninjabuttons/M in client.screen)del M
		switch(jutsu)
			if("Fireball")
				src<<"<b><font color=cyan>You have copied Fireball Jutsu! This jutsu makes you breath out a ball of fire that explodes into flames on impact, dealing ninjutsu damage and leaving a area of flames that deals damage to everyone in it every second."
				new/obj/jutsu/uchiha/Fireball_Jutsu(src)
			if("Senbon Wave")
				src<<"<b><font color=cyan>You have copied Senbon Wave. You throw a quick wave of needles in a wide area, doing double damage. "
				new/obj/jutsu/yuki/Senbon_Wave(src)
			if("Sand Clone")
				src<<"<b><font color=cyan>You have copied Sand Clone Jutsu. This jutsu summons two clones made of sand that will attack nearby enemies. The clones have 30% of your health and 20% of your attack power and ninjutsu power combined."
				new/obj/jutsu/sand/Sand_Clone_Jutsu(src)
			if("Sickling Wind")
				src<<"<b><font color=cyan>You have copied Sickling Wind. With this move you will swing your fan and create powerful gusts of wind that deals damage and blows them away."
				new/obj/jutsu/wind/Sickling_Wind(src)
			if("Shadow Snake")
				src<<"<b><font color=cyan>You have copied Striking Shadow Snake. You create a clone in your location that fires a snake in front of you, wrapping the first enemy struck. The enemy is binded for 1.5 second for moderate damage. You are invisible during the duration of this ability."
				new/obj/jutsu/snake/Striking_Shadow_Snake(src)
			if("Water Clone")
				src<<"<b><font color=cyan>You have copied Water Clone Jutsu. When activated, the next time you get damaged a water clone will takes the hit and you turn invisible for 0.5 second. If they don't get destroyed by the initial damage they will fight with you for up to 15 seconds. The water clones has 10% of your current health."
				new/obj/jutsu/yuki/Water_Clone(src)
			if("Falcon Drop")
				src<<"<b><font color=cyan>You have copied Peregrine Falcon Drop. With this jutsu, you rush forward. Upon colliding with someone, youll push them into the air and slam them to the ground."
				new/obj/jutsu/uchiha/Peregrine_Falcon_Drop(src)
			if("Phoenix Flower")
				src<<"<b><font color=cyan>You have copied Phoenix Flower Jutsu! This jutsu lets you fire multiple fireballs out of your mouth, dealing ninjutsu damage on impact."
				new/obj/jutsu/uchiha/Phoenix_Flower_Jutsu(src)
			if("Thousand Years")
				src<<"<b><font color=cyan>You have copied One Thousand Years Of Death! You teleport behind the enemy, dealing a swift attack from behind. You knock the enemy forward and stun them."
				new/obj/jutsu/leaf/One_Thousand_Years_of_Death(src)
			if("PreHealing")
				src<<"<b><font color=cyan>You have copied Pre-Healing Jutsu. You receive 40% defence for the next 10 seconds, degenerating by 4% every second."
				new/obj/jutsu/medic/PreHealing_Jutsu(src)
			if("Dragon Flames")
				src<<"<b><font color=cyan>You have copied Dragon Flames Jutsu. You shoot a quick wire forward binding the first enemy struck for 1.5 second. If it hits a enemy, you set the wire in flames and replace your body with a clone, dealing ninjutsu damage to the enemy."
				new/obj/jutsu/uchiha/Dragon_Flames_Jutsu(src)
			if("Chakra Absorption")
				src<<"<b><font color=cyan>You have copied Chakra Absorption. You channel the chakra from a massive area in front of you, taking 16% of the enemy's maximum chakra per second for up to 3 seconds. The enemy regenerates 80% of their lost chakra over 10 seconds."
				new/obj/jutsu/snake/Chakra_Absorption(src)
			if("Chakra Scalpel")
				usr<<"<b><font color=cyan>You have copied Chakra Scalpel. Your melee deals an extra 20% ninjutsu power in damage and causes them to bleed for 5 seconds for 10% ninjutsu power per second."
				new/obj/jutsu/medic/Chakra_Scalpel(usr)
			if("Ice Prison")
				src<<"<b><font color=cyan>You have copied Ice Prison Jutsu. This jutsu encases all enemies around you in a ice prison for up to two seconds. Any damage done will shatter the prison, freeing them and dealing damage."
				new/obj/jutsu/yuki/Ice_Prison(src)
			if("Piercing Gaze")
				src<<"<b><font color=cyan>You have copied Piercing Gaze! This move uses your sharingan to slow the enemy heavily for 2 seconds. You may use this move while hidden or transformed, as long as you are facing your target."
				new/obj/jutsu/uchiha/Piercing_Gaze(src)
			if("Empty Palm")
				src<<"<b><font color=cyan><b>You have copied Empty Palm! This move knocks back a enemy in front of you and slows them heavily. If they are directly in front of you they will also get hit for heavy damage."
				new/obj/jutsu/hyuuga/Empty_Palm(src)
			if("Twin Dragon")
				usr<<"<b><font color=cyan>You have copied Twin Dragon Weapon Barrage. This jutsu creates scrolls in front of you that will fire barrages of weaponry at the enemies."
				new/obj/jutsu/leaf/Twin_Dragon_Weapon_Barrage(usr)
			if("Rasengan")
				usr<<"<b><font color=cyan>You have copied Rasengan. This jutsu charges electricity in the palm of your hand. Your next attack will send you flying forward, drilling into any enemies you encounter."
				new/obj/jutsu/Rasengan(usr)
			if("Great Dragon Flames")
				usr<<"<b><font color=cyan>You have copied Great Dragon Flames. This jutsu fires two big dragons made of fire. They will explode on contact, leaving behind a large patch of fire."
				new/obj/jutsu/uchiha/Great_Dragon_Flames(usr)
			if("Dragons Storm")
				src<<"<b><font color=cyan>You have copied Dragon's Storm! This creates a raging tornado that homes in and destroy enemies as long as they are near it!"
				new/obj/jutsu/wind/Dragons_Storm(src)
			if("Iceberg Breaker")
				src<<"<b><font color=cyan>You have copied Iceberg Breaker. Massive spikes of ice shoots up from the ground, dealing massive damage and knocking enemies up in a cone."
				new/obj/jutsu/yuki/Iceberg_Breaker(src)
			if("Violent Wind Palm")
				usr<<"<b><font color=cyan>You have copied Violent Wind Palm. This jutsu causes your next melee to create a violent tornado that drills into the enemy from both sides."
				new/obj/jutsu/sand/Violent_Wind_Palm(usr)
			if("Poison Fog")
				src<<"<b><font color=cyan>You have copied Poison Fog. Breath out a large fog of poison. Anyone inside will get poisoned for 2 seconds. Poisoned enemies can not see any target or ally and is damaged for 20% ninjutsu damage per second."
				new/obj/jutsu/medic/Poison_Fog(src)
	blankjutsu1()
		if(copied1)return
		if(buttonscreen)
			buttonscreen = 0
			for(var/obj/copyninjabuttons/M in client.screen)del M
			return
		if(clan!="Copy Ninja")return
		var/obj/copyninjabuttons/Fireball/T=new()
		client.screen += T
		var/obj/copyninjabuttons/SicklingWind/T1=new()
		client.screen += T1
		var/obj/copyninjabuttons/SenbonWave/T2=new()
		client.screen += T2
		var/obj/copyninjabuttons/SandClone/T3=new()
		client.screen += T3
		spawn(5)buttonscreen=1
	blankjutsu2()
		if(copied2)return
		if(buttonscreen)
			buttonscreen = 0
			for(var/obj/copyninjabuttons/M in client.screen)del M
			return
		if(clan!="Copy Ninja")return
		var/obj/copyninjabuttons/StrikingShadowSnake/T=new()
		client.screen += T
		var/obj/copyninjabuttons/WaterClone/T1=new()
		client.screen += T1
		var/obj/copyninjabuttons/PeregrineFalconDrop/T2=new()
		client.screen += T2
		var/obj/copyninjabuttons/PhoenixFlower/T3=new()
		client.screen += T3
		var/obj/copyninjabuttons/ThousandYears/T4=new()
		client.screen += T4
		spawn(5)buttonscreen=1
	blankjutsu3()
		if(copied3)return
		if(buttonscreen)
			buttonscreen = 0
			for(var/obj/copyninjabuttons/M in client.screen)del M
			return
		if(clan!="Copy Ninja")return
		var/obj/copyninjabuttons/PreHealing/T=new()
		client.screen += T
		var/obj/copyninjabuttons/DragonFlames/T1=new()
		client.screen += T1
		var/obj/copyninjabuttons/ChakraAbsorption/T2=new()
		client.screen += T2
		var/obj/copyninjabuttons/ChakraScalpel/T3=new()
		client.screen += T3
		spawn(5)buttonscreen=1
	blankjutsu4()
		if(copied4)return
		if(buttonscreen)
			buttonscreen = 0
			for(var/obj/copyninjabuttons/M in client.screen)del M
			return
		if(clan!="Copy Ninja")return
		var/obj/copyninjabuttons/IcePrison/T=new()
		client.screen += T
		var/obj/copyninjabuttons/PiercingGaze/T1=new()
		client.screen += T1
		var/obj/copyninjabuttons/EmptyPalm/T2=new()
		client.screen += T2
		var/obj/copyninjabuttons/TwinDragon/T3=new()
		client.screen += T3
		var/obj/copyninjabuttons/Rasengan/T4=new()
		client.screen += T4
		spawn(5)buttonscreen=1
	blankjutsu5()
		if(copied5)return
		if(buttonscreen)
			buttonscreen = 0
			for(var/obj/copyninjabuttons/M in client.screen)del M
			return
		if(clan!="Copy Ninja")return
		var/obj/copyninjabuttons/GreatDragonFlames/T=new()
		client.screen += T
		var/obj/copyninjabuttons/DragonStorm/T1=new()
		client.screen += T1
		var/obj/copyninjabuttons/IcebergBreaker/T2=new()
		client.screen += T2
		var/obj/copyninjabuttons/ViolentWindPalm/T3=new()
		client.screen += T3
		var/obj/copyninjabuttons/PoisonFog/T4=new()
		client.screen += T4
		spawn(5)buttonscreen=1
	rally()
		prejutsu()
		if(rallydelay||seals||swim||dead||resting||stun||busy||moving||imitated||paralysed)return
		handseals(10,5,10)
		if(!sealpass)return
		rallydelay=1
		var/sdelay=250
		for(var/obj/jutsu/copynin/Rally/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)rallydelay=0
		for(var/mob/player/M in oview(8))
			if(M.aff==aff)
				M<<"<b>You have been rallied by [src]!"
				M.rally=1
				M.ovcheck()
				spawn(40*tier61)
					M.rally=0
					M.overlay()
		rally=1
		if(tier62)selfrally=1
		ovcheck()
		spawn(40*tier61)
			rally=0
			selfrally=0
			overlay()
	raikiri()
		hengeback()
		cloakoff()
		if(raikiridelay||raidening||swim||dead||stun||caught||seals||busy||imitated)return
		handseals(80,15,60)
		if(!sealpass)return
		raikiridelay=1
		var/sdelay=250
		for(var/obj/jutsu/copynin/Raikiri/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)raikiridelay=0
		stun=1
		busy="stun"
		overlays+=/obj/chidori
		var/time=12
		if(level>=90)time=1
		sleep(time)
		view(8)<<"<font color=aqua>[usr]: Raikiri!"
		stun=0
		busy="raikiri"
		icon_state="chidori"
		raikirimove(dir)
	tactics()
		tactics++
		if(tactics>=4)tactics=4
		spawn(40+tier63*10)
			tactics--
		if(tactics<0)tactics=0
		atkdef()
mob/proc/raikirimove(var/zdir)
	..()
	if(tier51)
		var/obj/staticfield/L=new(loc)
		L.owner=src
	moving=0
	step(src,zdir)
	spawn(1)
		if(tier51)
			var/obj/staticfield/L1=new(loc)
			L1.owner=src
		moving=0
		step(src,zdir)
		if(tier51)
			var/obj/staticfield/L2=new(loc)
			L2.owner=src
		moving=0
		step(src,zdir)
		spawn(1)
			if(tier51)
				var/obj/staticfield/L3=new(loc)
				L3.owner=src
			moving=0
			step(src,zdir)
			if(tier51)
				var/obj/staticfield/L4=new(loc)
				L4.owner=src
			moving=0
			step(src,zdir)
			spawn(1)
				if(tier51)
					var/obj/staticfield/L5=new(loc)
					L5.owner=src
				moving=0
				step(src,zdir)
				if(tier51)
					var/obj/staticfield/L6=new(loc)
					L6.owner=src
				moving=0
				step(src,zdir)
				spawn(1)
					if(tier51)
						var/obj/staticfield/L7=new(loc)
						L7.owner=src
					moving=0
					step(src,zdir)
					if(tier51)
						var/obj/staticfield/L8=new(loc)
						L8.owner=src
					moving=0
					step(src,zdir)
					spawn(1)
						if(tier51)
							var/obj/staticfield/L9=new(loc)
							L9.owner=src
						moving=0
						step(src,zdir)
						if(tier51)
							var/obj/staticfield/L10=new(loc)
							L10.owner=src
						moving=0
						step(src,zdir)
						spawn(1)
							if(tier51)
								var/obj/staticfield/L11=new(loc)
								L11.owner=src
							moving=0
							step(src,zdir)
							if(tier51)
								var/obj/staticfield/L12=new(loc)
								L12.owner=src
							moving=0
							step(src,zdir)
							spawn(1)
								if(tier51)
									var/obj/staticfield/L13=new(loc)
									L13.owner=src
								moving=0
								step(src,zdir)
								if(tier51)
									var/obj/staticfield/L14=new(loc)
									L14.owner=src
								moving=0
								step(src,zdir)
								spawn(1)
									if(tier51)
										var/obj/staticfield/L15=new(loc)
										L15.owner=src
									overlays-=/obj/chidori
									icon_state=""
									busy=null
mob/proc/raidenmove(var/zdir,var/T=0)
	..()
	overlays+=/obj/raidenoverlay
	moving=0
	step(src,zdir)
	if(tier51)
		var/obj/staticfield/L15=new(loc)
		L15.owner=src
	spawn(1)
		moving=0
		step(src,zdir)
		if(tier51)
			var/obj/staticfield/L15=new(loc)
			L15.owner=src
		spawn(1)
			moving=0
			step(src,zdir)
			if(tier51)
				var/obj/staticfield/L15=new(loc)
				L15.owner=src
			spawn(1)
				moving=0
				step(src,zdir)
				if(tier51)
					var/obj/staticfield/L15=new(loc)
					L15.owner=src
				spawn(1)
					moving=0
					step(src,zdir)
					if(tier51)
						var/obj/staticfield/L15=new(loc)
						L15.owner=src
					spawn(1)
						moving=0
						step(src,zdir)
						if(tier51)
							var/obj/staticfield/L15=new(loc)
							L15.owner=src
						spawn(1)
							moving=0
							step(src,zdir)
							if(tier51)
								var/obj/staticfield/L15=new(loc)
								L15.owner=src
							spawn(1)
								moving=0
								step(src,zdir)
								if(tier51)
									var/obj/staticfield/L15=new(loc)
									L15.owner=src
								spawn(1)
									moving=0
									step(src,zdir)
									if(tier51)
										var/obj/staticfield/L15=new(loc)
										L15.owner=src
									spawn(1)
										moving=0
										step(src,zdir)
										if(tier51)
											var/obj/staticfield/L15=new(loc)
											L15.owner=src
										spawn(1)
											moving=0
											step(src,zdir)
											if(tier51)
												var/obj/staticfield/L15=new(loc)
												L15.owner=src
											spawn(1)
												moving=0
												step(src,zdir)
												spawn(1)
													del src
obj/proc/raidenmove(var/zdir)
	..()
	step(src,zdir)
	spawn(1)
		step(src,zdir)
		spawn(1)
			step(src,zdir)
			spawn(1)
				step(src,zdir)
				spawn(1)
					step(src,zdir)
					spawn(1)
						step(src,zdir)
						spawn(1)
							step(src,zdir)
							spawn(1)
								step(src,zdir)
								spawn(1)
									step(src,zdir)
									spawn(1)
										step(src,zdir)
										spawn(1)
											step(src,zdir)
											spawn(1)
												step(src,zdir)
												if(!freeze)
													del src