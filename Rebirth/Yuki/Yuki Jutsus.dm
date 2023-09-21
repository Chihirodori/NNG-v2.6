mob/proc
	yukileveling()
		if(level==2)src<<"<b><font color=cyan>You now throw needles with pinpoint precision instead of Shurikens or Kunais. These needles can be thrown incredibly fast and has extra chance to critically hit."
		if(level==5)
			src<<"<b><font color=cyan>You have learned Senbon Wave. You throw a quick wave of needles in a wide area, doing double damage. "
			new/obj/jutsu/yuki/Senbon_Wave(src)
		if(level==7)
			src<<"<b><font color=cyan>You have learned Water Clone Jutsu. When activated, the next time you get damaged a water clone will takes the hit and you turn invisible for 0.5 second. If they don't get destroyed by the initial damage they will fight with you for up to 15 seconds. The water clones has 10% of your current health."
			new/obj/jutsu/yuki/Water_Clone(src)
		if(level==10)
			src<<"<b><font color=cyan>You have learned A Thousand Needles of Death. You create ice in a circular area in front of you that shoots ice needles that strikes from all directions in front of you. Multiple needles hitting the same enemy deal 25% less damage per needle."
			new/obj/jutsu/yuki/A_Thousand_Needles_of_Death(src)
		if(level==12)src<<"<b><font color=cyan>Your Senbon Wave is level 2. The needles can now pierce and hit up to two enemies."
		if(level==15)
			src<<"<b><font color=cyan>You have learned Hidden Mist Jutsu. This jutsu creates a huge patch of mist that renders you invisible to enemies. The mist dissipates around enemies. You regenerate 3% of your maximum health per second inside the mist. Lasts 20 seconds. "
			new/obj/jutsu/yuki/Hidden_Mist_Jutsu(src)
			src<<"<b><font color=cyan>You have learned False Mirror. This jutsu renders you invisible, grants 80% defense and your movement becomes unhindered regardless of slows and stuns for 1.25 seconds. During that time, damaging icicles fall to where you tread. "
			new/obj/jutsu/yuki/False_Mirror(src)
		if(level==18)
			src<<"<b><font color=cyan>You have learned Ice Prison Jutsu. Thie jutsu encase all enemies around you in a ice prison for up to two seconds. Any damage done will shatter the prison, freeing them and dealing damage."
			new/obj/jutsu/yuki/Ice_Prison(src)
		if(level==22)src<<"<b><font color=cyan>Your Water Clone Jutsu is level 2. You now remain invisible for 1.5 second."
		if(level==25)src<<"<b><font color=cyan>A Thousand Needles of Death is level 2. It deals 20% more damage."
		if(level==30)src<<"<b><font color=cyan>Your Senbon Wave is level 3. The cooldown has decreased."
		if(level==32)
			src<<"<b><font color=cyan>You have learned Crystal Ice Mirrors. You dash forward. If you collide with an enemy they are slowed down and mirrors surround them. The mirrors shoot senbons rapidly and lasts 3 seconds or until you deactivate it. You appear in a mirror behind the enemy if you deactivate this jutsu."
			new/obj/jutsu/yuki/Demon_Ice_Mirrors(src)
			src<<"<b><font color=cyan>You created a mask of the mist."
			new/obj/items/equippable/Mask_of_the_Mist(src)
		if(level==35)src<<"<b><font color=cyan>Your Hidden Mist Jutsu is level 2. You take 20% less damage while hidden."
		if(level==38)src<<"<b><font color=cyan>Your Water Clone Jutsu is level 3. The clones now have 12% of your maximum health."
		if(level==40)
			src<<"<b><font color=cyan>You have learned Iceberg Smasher. Massive spikes of ice shoots up from the ground, dealing massive damage and knocking enemies up in a cone."
			new/obj/jutsu/yuki/Iceberg_Breaker(src)
		if(level==42)src<<"<b><font color=cyan>Ice Prison is level 2. It now freeze for up to 3 seconds."
		if(level==45)src<<"<b><font color=cyan>A Thousand Needles of Death is level 3. The cooldown decreased by 30%."
		if(level==50)src<<"<b><font color=cyan>Your Senbon Wave is mastered. The first hit deals triple damage instead of double"
		if(level==52)src<<"<b><font color=cyan>Crystal Ice Mirrors is level 2. You deal 30% more damage."
		if(level==55)src<<"<b><font color=cyan>Your Hidden Mist Jutsu is level 3. The mist takes longer to reveal than before when you move around."
		if(level==58)src<<"<b><font color=cyan>Your Iceberg Smasher is level 2. The handseal time is halfened."
		if(level==60)
			src<<"<b><font color=cyan>You have learned Ice Dome. Create a arena of ice around you for up to 8 seconds, trapping any enemies inside. People inside the arena can not use lightning flash to escape. You gain 15% more damage and receive 20% less damage inside the dome."
			new/obj/jutsu/yuki/Ice_Dome(src)
		if(level==65)src<<"<b><font color=cyan>Your Water Clone Jutsu is mastered. You now create a full health water clone to fight with you when this jutsu is triggered."
		if(level==68)src<<"<b><font color=cyan>Your Ice Prison is mastered. The range has increased."
		if(level==70)src<<"<b><font color=cyan>Your Iceberg Smasher is level 3. It now deals 25% more damage."
		if(level==75)src<<"<b><font color=cyan>Your Ice Dome is level 2. You take 40% less damage inside the dome."
		if(level==80)src<<"<b><font color=cyan>Your Hidden Mist Jutsu is mastered. The handseal time is halfened."
		if(level==85)src<<"<b><font color=cyan>Crystal Ice Mirrors is mastered. It now last up to 5 seconds."
		if(level==90)src<<"<b><font color=cyan>Your Ice Dome is level 3. It now lasts 12 seconds."
		if(level==100)src<<"<b><font color=cyan>Your Iceberg Smasher is mastered. You now stun the enemy for 2 seconds after the land on the ground."
		if(level==110)src<<"<b><font color=cyan>Your A Thousand Needles of Death is mastered. The damage reduction per needle decreased to 12% from 25%."
		if(level==120)src<<"<b><font color=cyan>Your Ice Dome is mastered. You deal 30% more damage inside the dome."

	demonicemirrors()
		if(busy == "mirror")
			for(var/obj/hakumirror/M in range(5))
				if(M.owner==src)del M
			freeze=0
			invisibility-=20
			density=1
			busy=null
			mybar:updatebar()
			mybar2:updatebar()
			if(target)
				if(target!=dead&&target:z==z&&target:z!=0)
					loc=target:loc
					moving=0
					if(target:dir==NORTH)step(src,SOUTH)
					if(target:dir==SOUTH)step(src,NORTH)
					if(target:dir==EAST)step(src,WEST)
					if(target:dir==WEST)step(src,EAST)
					dir=target:dir
			new/obj/mirrorbreak(loc)
			return
		prejutsu()
		if(cdelay4||swim||dead||resting||stun||busy||freeze||moving||imitated||paralysed)return
		cdelay4=1
		handseals(45, 0, 35)
		if(!sealpass)
			cdelay4=0
			return
		var/sdelay = 500*cdapow/100
		if(level >= 30)
			sdelay -= 20
		for(var/obj/jutsu/yuki/Demon_Ice_Mirrors/M in src)
			timerjutsu(sdelay,M)
		spawn(sdelay)
			cdelay4 = 0
		busy = "mirroring"
		stepup(8)
		spawn(21)
			if(busy == "mirroring")
				busy = null
	icemirrors()
		prejutsu()
		if(cdelay4||swim||dead||resting||stun||busy||freeze||moving||imitated||paralysed)return
		handseals(45, 0, 35)
		if(!sealpass)
			cdelay4=0
			return
		cdelay4=1
		freeze=1
		view(8)<<output("<b><font color=aqua>[usr]: Ice Style!","infobox")
		var/time=5
		sleep(time)
		view(8)<<output("<b><font color=aqua>[usr]: Demonic Ice Mirrors!","infobox")
		density = 0
		invisibility=10
		var/timee=2
		var/obj/t=new/obj/iceprisonx(locate(x-4,y,z))
		var/obj/t1=new/obj/iceprisonx(locate(x-4,y+1,z))
		var/obj/t2=new/obj/iceprisonx(locate(x-4,y+2,z))
		sleep(timee)
		var/obj/t3=new/obj/iceprisonx(locate(x-4,y+3,z))
		var/obj/t7=new/obj/iceprisonx(locate(x-4,y-1,z))
		var/obj/t8=new/obj/iceprisonx(locate(x-4,y-2,z))
		sleep(timee)
		var/obj/t9=new/obj/iceprisonx(locate(x-4,y-3,z))
		var/obj/t24=new/obj/iceprisonx(locate(x+4,y,z))
		var/obj/t13=new/obj/iceprisonx(locate(x+4,y+1,z))
		sleep(timee)
		var/obj/t14=new/obj/iceprisonx(locate(x+4,y+2,z))
		var/obj/t15=new/obj/iceprisonx(locate(x+4,y+3,z))
		var/obj/t19=new/obj/iceprisonx(locate(x+4,y-1,z))
		sleep(timee)
		var/obj/t20=new/obj/iceprisonx(locate(x+4,y-2,z))
		var/obj/t21=new/obj/iceprisonx(locate(x+4,y-3,z))
		var/obj/t28=new/obj/iceprisonx(locate(x,y-3,z))
		sleep(timee)
		var/obj/t29=new/obj/iceprisonx(locate(x+1,y-3,z))
		var/obj/t30=new/obj/iceprisonx(locate(x+2,y-3,z))
		var/obj/t31=new/obj/iceprisonx(locate(x+3,y-3,z))
		sleep(timee)
		var/obj/t35=new/obj/iceprisonx(locate(x-1,y-3,z))
		var/obj/t36=new/obj/iceprisonx(locate(x-2,y-3,z))
		var/obj/t37=new/obj/iceprisonx(locate(x-3,y-3,z))
		sleep(timee)
		var/obj/t41=new/obj/iceprisonx(locate(x,y+3,z))
		var/obj/t42=new/obj/iceprisonx(locate(x+1,y+3,z))
		var/obj/t43=new/obj/iceprisonx(locate(x+2,y+3,z))
		sleep(timee)
		var/obj/t44=new/obj/iceprisonx(locate(x+3,y+3,z))
		var/obj/t48=new/obj/iceprisonx(locate(x-1,y+3,z))
		var/obj/t49=new/obj/iceprisonx(locate(x-2,y+3,z))
		sleep(timee)
		var/obj/t50=new/obj/iceprisonx(locate(x-3,y+3,z))
		for(var/mob/M in oview(4))spawn()
			if(aff==M.aff)continue
			var/damage=pow*0.5
			M.dmgch(src,1)
			damage=(damage*M.variable)+M.variable2
			M.stun(30)
			M.overlays += 'mirrordamage.dmi'
			M.damage(damage)
			new/obj/bloodstep(M.loc)
			M.dir = NORTH
			sleep(5)
			M.damage(damage)
			new/obj/bloodstep(M.loc)
			M.dir = WEST
			sleep(5)
			M.damage(damage)
			new/obj/bloodstep(M.loc)
			M.dir = EAST
			sleep(5)
			M.damage(damage)
			new/obj/bloodstep(M.loc)
			M.dir = NORTH
			sleep(5)
			M.damage(damage)
			new/obj/bloodstep(M.loc)
			M.dir = SOUTH
			spawn(10)
				M.death(usr)
				M.overlays -= 'mirrordamage.dmi'
		spawn(15)
			density = 1
			freeze=0
			invisibility=0
			del t
			del t1
			del t2
			del t3
			del t7
			del t8
			del t9
			del t13
			del t14
			del t15
			del t19
			del t20
			del t21
			del t24
			del t28
			del t29
			del t30
			del t31
			del t35
			del t36
			del t37
			del t41
			del t42
			del t43
			del t44
			del t48
			del t49
			del t50
		var/sdelay=200
		for(var/obj/jutsu/yuki/Demon_Ice_Mirrors/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay4=0
	senbonwave()
		prejutsu()
		if(cdelay1||copydelay1||swim||dead||resting||stun||busy||moving||imitated||paralysed)return
		if(clan=="Copy Ninja")copydelay1=1
		else	cdelay1=1
		var/sdelay=100*cdapow/100
		if(level>=30)sdelay-=20
		for(var/obj/jutsu/yuki/Senbon_Wave/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)
			cdelay1=0
			copydelay1=0
		flick("attack",usr)
		var/obj/L=new/obj/senbonwave(loc)
		var/obj/L2=new/obj/senbonwave(loc)
		var/obj/L3=new/obj/senbonwave(loc)
		var/obj/L4=new/obj/senbonwave(loc)
		var/obj/L5=new/obj/senbonwave(loc)
		if(dir==NORTH||dir==SOUTH)
			L2.loc=locate(x+1,y,z)
			L3.loc=locate(x-1,y,z)
			L4.loc=locate(x+1,y,z)
			L5.loc=locate(x-1,y,z)
		if(dir==EAST||dir==WEST)
			L2.loc=locate(x,y+1,z)
			L3.loc=locate(x,y-1,z)
			L4.loc=locate(x,y+1,z)
			L5.loc=locate(x,y-1,z)
		L.right=dir
		L2.right=dir
		L3.right=dir
		if(dir==NORTH)
			L4.right=NORTHEAST
			L5.right=NORTHWEST
		if(dir==SOUTH)
			L4.right=SOUTHEAST
			L5.right=SOUTHWEST
		if(dir==EAST)
			L4.right=NORTHEAST
			L5.right=SOUTHEAST
		if(dir==WEST)
			L4.right=NORTHWEST
			L5.right=SOUTHWEST
		L.owner=usr
		L2.owner=usr
		L3.owner=usr
		L4.owner=usr
		L5.owner=usr
		if(level<12||clan!="Copy Ninja")
			L.icon_state="w"
			L2.icon_state="w"
			L3.icon_state="w"
			L4.icon_state="w"
			L5.icon_state="w"
		L.movequick(L.right)
		L2.movequick(L2.right)
		L3.movequick(L3.right)
		L4.movequick(L4.right)
		L5.movequick(L5.right)
		if(clan=="Copy Ninja")tactics()
	quickwave(var/t=0)
		if(t==0)flick("attack",usr)
		var/obj/L=new/obj/senbonwave(loc)
		var/obj/L2=new/obj/senbonwave(loc)
		var/obj/L3=new/obj/senbonwave(loc)
		var/obj/L4=new/obj/senbonwave(loc)
		var/obj/L5=new/obj/senbonwave(loc)
		if(dir==NORTH||dir==SOUTH)
			L2.loc=locate(x+1,y,z)
			L3.loc=locate(x-1,y,z)
			L4.loc=locate(x+1,y,z)
			L5.loc=locate(x-1,y,z)
		if(dir==EAST||dir==WEST)
			L2.loc=locate(x,y+1,z)
			L3.loc=locate(x,y-1,z)
			L4.loc=locate(x,y+1,z)
			L5.loc=locate(x,y-1,z)
		var/doo=dir
		if(t==1)
			if(dir==NORTH)doo=SOUTH
			if(dir==SOUTH)doo=NORTH
			if(dir==EAST)doo=WEST
			if(dir==WEST)doo=EAST
		L.right=doo
		L2.right=doo
		L3.right=doo
		if(doo==NORTH)
			L4.right=NORTHEAST
			L5.right=NORTHWEST
		if(doo==SOUTH)
			L4.right=SOUTHEAST
			L5.right=SOUTHWEST
		if(doo==EAST)
			L4.right=NORTHEAST
			L5.right=SOUTHEAST
		if(doo==WEST)
			L4.right=NORTHWEST
			L5.right=SOUTHWEST
		L.owner=usr
		L2.owner=usr
		L3.owner=usr
		L4.owner=usr
		L5.owner=usr
		L.movequick(L.right)
		L2.movequick(L2.right)
		L3.movequick(L3.right)
		L4.movequick(L4.right)
		L5.movequick(L5.right)

	onekdeath()
		prejutsu()
		if(cdelay2||swim||dead||resting||stun||busy||moving||imitated||paralysed)return
		cdelay2=1
		handseals(30,5,15)
		if(!sealpass)
			cdelay2=0
			return
		var/sdelay=110*cdpow/100
		if(tier51)sdelay*=1-(0.05*tier51)
		if(level>=45)sdelay*=0.7
		for(var/obj/jutsu/yuki/A_Thousand_Needles_of_Death/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay2=0
		var/obj/K=new/obj/iceneedlemaker(loc)
		K.owner=src
		step(K,dir)
		step(K,dir)
		step(K,dir)
		step(K,dir)
		del K

	falsemirror()
		if(cdelay6||dead||resting||busy)return
		cdelay6=1
		for(var/obj/jutsu/yuki/False_Mirror/M in src)timerjutsu(200,M)
		spawn(200)cdelay6=0
		stance="fmirror"
		falsemirrorX()
		atkdef()
		invisibility+=3
		var/image/I=image('baseinvis.dmi',src)
		src<<I
		barloc()
		spawn(18)
			stance=0
			atkdef()
			invisibility-=3
			del I
			barloc()
	falsemirrorX()
		loop
			if(stance=="fmirror")
				var/obj/R=new/obj/icicle(loc)
				R.owner=src
				spawn(3)goto loop
	icedome()
		if(inbarrier == 2)
			inbarrier = 0
			atkdef()
			for(var/obj/icedome/M in world)
				if(M.owner == src)
					del M
			return
		prejutsu()
		if(tsukcd||swim||dead||resting||stun||busy||moving||imitated||paralysed)
			return
		tsukcd = 1
		handseals(60*(1-(tier11*0.08)),20,40)
		if(!sealpass)
			tsukcd=0
			return
		var/sdelay = 700*cdpow/100
		for(var/obj/jutsu/yuki/Ice_Dome/M in src)
			timerjutsu(sdelay,M)
		spawn(sdelay)
			tsukcd = 0
		var/timea = 80
		if(level >= 100)
			timea = 120
		for(var/mob/player/M in range(7))
			M.inbarrier=1
			spawn(timea)
				if(M.inbarrier == 1)
					M.inbarrier = 0
		inbarrier = 2
		atkdef()
		spawn(timea)
			if(inbarrier == 2)
				inbarrier = 0
				atkdef()
		var/createx = -7
		var/createy = -7
		while(createx <= 7)
			var/obj/icedome/V = new(locate(x+createx,y-8,z))
			V.owner = src
			var/obj/icedome/V2= new(locate(x+createx,y+8,z))
			V2.owner = src
			V.layer += 8
			V2.layer -= 8
			V.zipline = 1
			V2.zipline = 1
			createx ++
		while(createy <= 7)
			var/obj/icedome/V = new(locate(x-8,y+createy,z))
			V.owner=src
			var/obj/icedome/V2 = new(locate(x+8,y+createy,z))
			V2.owner = src
			V.layer -= createy
			V2.layer -= createy
			createy ++

	icebreaker()
		prejutsu()
		if(cdelay5||copydelay5||swim||dead||resting||stun||busy||freeze||moving||imitated||paralysed)return
		if(clan=="Copy Ninja")copydelay5=1
		else	cdelay5=1
		var/cheque=1
		if(level>=58||clan=="Copy Ninja")cheque=2
		handseals(65,15/cheque,50)
		if(!sealpass)
			cdelay5=0
			copydelay5=0
			return
		var/sdelay=450*cdpow/100
		if(clan=="Copy Ninja")sdelay-=50
		if(tier51&&clan=="Copy Ninja")sdelay*=1-(0.05*tier51)
		for(var/obj/jutsu/yuki/Iceberg_Breaker/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)
			cdelay5=0
			copydelay5=0
		freeze=1
		icon_state="jutsu"
		spawn(14)
			freeze=0
			icon_state=""
		if(dir==WEST)
			new/obj/iceberg2(locate(x-1,y,z))
			new/obj/iceberg2(locate(x-2,y,z))
			spawn(1)
				new/obj/iceberg2(locate(x-3,y,z))
				new/obj/iceberg2(locate(x-2,y-1,z))
				new/obj/iceberg2(locate(x-2,y+1,z))
				new/obj/iceberg1(locate(x-4,y-1,z))
				new/obj/iceberg1(locate(x-4,y+1,z))
			spawn(2)
				new/obj/iceberg1(locate(x-5,y,z))
			spawn(3)
				new/obj/iceberg(locate(x-6,y-1,z))
				new/obj/iceberg(locate(x-6,y+1,z))
			spawn(4)
				new/obj/iceberg(locate(x-7,y-2,z))
				new/obj/iceberg(locate(x-7,y+2,z))
			spawn(7)
				new/obj/iceberg(locate(x-8,y,z))
			spawn(6)
				new/obj/iceberg(locate(x-9,y+2,z))
				new/obj/iceberg(locate(x-9,y+1,z))
				new/obj/iceberg(locate(x-10,y,z))
				new/obj/iceberg(locate(x-9,y-1,z))
				new/obj/iceberg(locate(x-9,y-2,z))
		if(dir==EAST)
			new/obj/eiceberg2(locate(x+1,y,z))
			new/obj/eiceberg2(locate(x+2,y,z))
			spawn(1)
				new/obj/eiceberg2(locate(x+3,y,z))
				new/obj/eiceberg2(locate(x+2,y-1,z))
				new/obj/eiceberg2(locate(x+2,y+1,z))
				new/obj/eiceberg1(locate(x+4,y-1,z))
				new/obj/eiceberg1(locate(x+4,y+1,z))
			spawn(2)
				new/obj/eiceberg1(locate(x+5,y,z))
			spawn(3)
				new/obj/eiceberg(locate(x+6,y-1,z))
				new/obj/eiceberg(locate(x+6,y+1,z))
			spawn(4)
				new/obj/eiceberg(locate(x+7,y-2,z))
				new/obj/eiceberg(locate(x+7,y+2,z))
			spawn(7)
				new/obj/eiceberg(locate(x+8,y,z))
			spawn(6)
				new/obj/eiceberg(locate(x+9,y+2,z))
				new/obj/eiceberg(locate(x+9,y+1,z))
				new/obj/eiceberg(locate(x+10,y,z))
				new/obj/eiceberg(locate(x+9,y-1,z))
				new/obj/eiceberg(locate(x+9,y-2,z))
		if(dir==SOUTH)
			new/obj/diceberg2(locate(x,y-1,z))
			new/obj/iceberg2(locate(x,y-1,z))
			new/obj/iceberg2(locate(x,y-2,z))
			new/obj/diceberg2(locate(x,y-2,z))
			spawn(1)
				new/obj/iceberg1(locate(x-3,y-3,z))
				new/obj/iceberg1(locate(x-1,y-2,z))
				new/obj/eiceberg1(locate(x+3,y-3,z))
				new/obj/eiceberg1(locate(x+1,y-2,z))
			spawn(2)
				new/obj/iceberg1(locate(x-3,y-4,z))
				new/obj/eiceberg1(locate(x+3,y-4,z))
			spawn(3)
				new/obj/iceberg(locate(x-2,y-4,z))
				new/obj/eiceberg(locate(x+2,y-4,z))
			spawn(4)
				new/obj/iceberg(locate(x-2,y-5,z))
				new/obj/eiceberg(locate(x+2,y-5,z))
			spawn(7)
				new/obj/iceberg(locate(x-3,y-6,z))
				new/obj/eiceberg(locate(x+3,y-6,z))
			spawn(6)
				new/obj/eiceberg(locate(x+2,y-7,z))
				new/obj/eiceberg(locate(x+3,y-8,z))
				new/obj/eiceberg(locate(x+1,y-7,z))
				new/obj/iceberg(locate(x-2,y-7,z))
				new/obj/iceberg(locate(x-3,y-8,z))
				new/obj/iceberg(locate(x-1,y-7,z))
		if(dir==NORTH)
			new/obj/diceberg2(locate(x,y+1,z))
			new/obj/iceberg2(locate(x,y+1,z))
			new/obj/iceberg2(locate(x,y+2,z))
			new/obj/diceberg2(locate(x,y+2,z))
			spawn(1)
				new/obj/iceberg1(locate(x-3,y+3,z))
				new/obj/iceberg1(locate(x-1,y+2,z))
				new/obj/eiceberg1(locate(x+3,y+3,z))
				new/obj/eiceberg1(locate(x+1,y+2,z))
			spawn(2)
				new/obj/iceberg1(locate(x-3,y+4,z))
				new/obj/eiceberg1(locate(x+3,y+4,z))
			spawn(3)
				new/obj/iceberg(locate(x-2,y+2,z))
				new/obj/eiceberg(locate(x+2,y+2,z))
			spawn(4)
				new/obj/iceberg(locate(x-2,y+3,z))
				new/obj/eiceberg(locate(x+2,y+3,z))
			spawn(7)
				new/obj/iceberg(locate(x-3,y+4,z))
				new/obj/eiceberg(locate(x+3,y+4,z))
			spawn(6)
				new/obj/eiceberg(locate(x+2,y+5,z))
				new/obj/eiceberg(locate(x+3,y+6,z))
				new/obj/eiceberg(locate(x+1,y+5,z))
				new/obj/iceberg(locate(x-2,y+5,z))
				new/obj/iceberg(locate(x-3,y+6,z))
				new/obj/iceberg(locate(x-1,y+5,z))
		var/obj/G=new/obj/iceberghit(loc)
		G.owner=src
		var/odir=dir
		var/dir2
		var/dir3
		if(dir==WEST||dir==EAST)
			dir2=NORTH
			dir3=SOUTH
		if(dir==NORTH||dir==SOUTH)
			dir2=WEST
			dir3=EAST
		spawn(1)
			step(G,odir)
			spawn(2)
				step(G,odir)
				var/obj/G2=new/obj/iceberghit(G.loc)
				G2.owner=src
				step(G2,dir2)
				step(G2,odir)
				var/obj/G3=new/obj/iceberghit(G.loc)
				G2.owner=src
				step(G3,dir3)
				step(G3,odir)
				step(G,odir)
				spawn(3)
					if(!G||!G2||!G3)
						if(G)
							del G
						if(G2)
							del G2
						if(G3)
							del G3
						return
					step(G,odir)
					step(G,odir)
					step(G,odir)
					step(G2,odir)
					var/obj/G4=new/obj/iceberghit(G2.loc)
					G4.owner=src
					step(G4,dir2)
					step(G4,odir)
					step(G4,odir)
					step(G3,odir)
					var/obj/G5=new/obj/iceberghit(G3.loc)
					G5.owner=src
					step(G5,dir3)
					step(G5,odir)
					step(G5,odir)
					step(G2,odir)
					step(G2,odir)
					step(G3,odir)
					step(G3,odir)
					spawn(1)
						step(G,odir)
						step(G2,odir)
						step(G3,odir)
						step(G4,odir)
						step(G5,odir)
						spawn(1)
							del G
							del G2
							del G3
							del G4
							del G5

		if(clan=="Copy Ninja")tactics()
	waterclone()
		prejutsu()
		if(wpalming||copydelay2||swim||attacking||dead||resting||stun||busy||moving||seals||imitated)return
		if(clan=="Copy Ninja")copydelay2=1
		else	wpalming=1
		handseals(30,5,20)
		if(!sealpass)
			wpalming=0
			copydelay2=0
			return
		var/sdelay=600*cdpow/100
		for(var/obj/jutsu/yuki/Water_Clone/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)
			wpalming=0
			copydelay2=0
		sandarmor=hp/10
		if(level>=38)sandarmor=maxhp*0.12
		if(clan=="Copy Ninja")tactics()
	waterc(var/t=0)
		invisibility+=5
		var/image/I=image('baseinvis.dmi',src)
		src<<I
		barloc()
		var/invistime=5
		if(level>=22)invistime=15
		spawn(invistime)
			new/obj/icetele(loc)
			invisibility-=5
			del I
			barloc()
			if(level>=65)
				var/obj/waterup/T=new(loc)
				step_rand(T)
				step_rand(T)
				spawn(3)
					var/mob/Clone/waterclone/M2=new(T.loc)
					M2.cloneowner=src
					M2.icon=icon
					M2.dir=T:dir
					M2.moving=0
					M2.maxhp=maxhp*0.12
					M2.hp=maxhp*0.12
					M2.aff=aff
					M2.overlays=overlays
					M2.animate_movement=2
					M2.name=name
					M2.village=village
					M2.rundelay=rundelay
					M2.apow=round(apow/3)
					var/obj/bars/healthbar/B12=new(M2.loc)
					B12.barowner=M2
					B12.copy(src)
					M2.mybar=B12
					var/obj/bars/chakrabar/B22=new(M2.loc)
					B22.barowner=M2
					B22.copy(src)
					M2.mybar2=B22
					M2.shadowclone()
		if(t>0)
			sandarmor=0
			var/mob/Clone/waterclone/M=new(loc)
			M.cloneowner=src
			M.icon=icon
			M.dir=dir
			M.moving=0
			M.maxhp=t
			M.aff=aff
			M.hp=t
			M.overlays=overlays
			M.animate_movement=2
			M.name=name
			M.village=village
			M.rundelay=rundelay
			M.apow=round(apow/3)
			var/obj/bars/healthbar/B1=new(M.loc)
			B1.barowner=M
			B1.copy(src)
			M.mybar=B1
			var/obj/bars/chakrabar/B2=new(M.loc)
			B2.barowner=M
			B2.copy(src)
			M.mybar2=B2
			M.shadowclone()
			if(level>=65)
				var/obj/waterup/T=new(loc)
				step_rand(T)
				step_rand(T)
				spawn(3)
					var/mob/Clone/waterclone/M2=new(T.loc)
					M2.cloneowner=src
					M2.icon=icon
					M2.dir=T:dir
					M2.aff=aff
					M2.moving=0
					M2.maxhp=maxhp*0.12
					M2.hp=maxhp*0.12
					M2.overlays=overlays
					M2.animate_movement=2
					M2.name=name
					M2.village=village
					M2.rundelay=rundelay
					M2.apow=round(apow/3)
					var/obj/bars/healthbar/B12=new(M2.loc)
					B12.barowner=M2
					B12.copy(src)
					M2.mybar=B12
					var/obj/bars/chakrabar/B22=new(M2.loc)
					B22.barowner=M2
					B22.copy(src)
					M2.mybar2=B22
					M2.shadowclone()

	iceprison()
		prejutsu()
		if(cdelay3||copydelay4||swim||dead||resting||stun||busy||moving||imitated||paralysed)
			return
		if(clan=="Copy Ninja")copydelay4=1
		else	cdelay3=1
		handseals(60,10,55)
		if(!sealpass)
			cdelay3=0
			copydelay4=0
			return
		var/sdelay = 300*cdpow/100
		if(clan=="Copy Ninja")sdelay+=100
		if(tier51)
			sdelay *= 1-(0.05*tier51)
		for(var/obj/jutsu/yuki/Ice_Prison/M in src)
			timerjutsu(sdelay, M)
		spawn(sdelay)
			cdelay3 = 0
			copydelay4=0
		var/zinga = 3
		if(level >= 68 && clan == "Yuki")
			zinga ++
		for(var/turf/T in range(zinga, src))
			var/obj/flashfreeze/V = new(T)
			flick('iceinit.dmi',V)
			V.owner = src
		if(clan=="Copy Ninja")tactics()
	mistjutsu()
		prejutsu()
		if(amatcd||swim||dead||resting||stun||busy||moving||imitated||paralysed)return
		amatcd = 1
		var/inita = 1
		if(level >= 80)
			inita = 2
		handseals(60, 30/inita, 40)
		if(!sealpass)
			amatcd = 0
			return
		var/sdelay = 800*cdpow/100
		for(var/obj/jutsu/yuki/Hidden_Mist_Jutsu/M in src)
			timerjutsu(sdelay, M)
		spawn(sdelay)
			amatcd = 0
		sight |= SEE_SELF
		spawn(200)
			sight = 0
		var/createx=-21
		var/createy=-21
		while(createy<=21)
			if(createx>21)
				createx=-21
				createy+=3
			var/obj/V=new/obj/mist(locate(x+createx,y+createy,z))
			flick('mist.dmi',V)
			V.owner=src
			createx+=3

	flashfreeze(var/mob/M)
		var/obj/T=new/obj/iceprison(loc)
		var/G = 20
		if(M.level >= 42)
			G = 30
		freeze=1
		frozenby=M
		busy="frozen"
		spawn(G)
			if(busy == "frozen" || freeze == 1)
				freeze=0
				busy=""
				frozenby=null
				if(T)del T
				if(M)frozenhit(M)

	frozenhit(var/mob/M)
		if(M.clan!="Copy Ninja")snared(5+M.tier21*15,4)
		else	snared(20,4)
		var/damage=round(M.pow*0.75)
		if(clan=="Copy Ninja")damage*=0.85
		if(M.tier51&&M.clan!="Copy Ninja")damage*=1+(0.08*M.tier51)
		if(M.tier63&&M.clan!="Copy Ninja")markfrost()
		dmgch(M)
		damage=(damage*variable)+variable2
		damage(damage)
		death(M)

	frostmarktrigger(var/mob/M)
		frostmark=0
		ovcheck()
		if(M.tier63)
			var/obj/T=new/obj/iceprison(loc)
			var/G=5*M.tier63
			freeze++
			stun++
			spawn(G)
				freeze--
				stun--
				if(freeze<0)freeze=0
				if(stun<0)stun=0
				if(T)del T
				if(M)
					new/obj/frostmarktrigger(loc)
					var/damage=round(M.pow*0.15)
					dmgch(M)
					damage=(damage*variable)+variable2
					damage(damage)
					death(M)

	deadliness(var/mob/M)
		if(M==src||deadlydelay||aff==M.aff)return
		deadlydelay=1
		spawn(60)deadlydelay=0
		var/damage=maxhp*0.01*M.tier31
		damage(damage)
		new/obj/statuspop/internalbleeding(loc)
		death(M)

	mistinvis()
		inmist --
		atkdef()
		invisibility += 10
		overlays += /obj/mistinvis
		barloc()
		spawn(21)
			inmist ++
			atkdef()
			overlays -= /obj/mistinvis
			invisibility -= 10
			barloc()

	mistaffect(var/t)
		inmist ++
		if(t)
			snared(t*5, 2)
		spawn(21)
			inmist --

	knockedup()
		spawn(34)icehit=0
		stun(8)
		pixel_y+=45
		spawn(1)pixel_y+=35
		spawn(2)pixel_y+=20
		spawn(3)pixel_y+=5
		spawn(7)pixel_y-=5
		spawn(7)pixel_y-=10
		spawn(6)pixel_y-=25
		spawn(7)pixel_y-=45
		spawn(8)pixel_y-=20

	needlehit()
		needlehit ++
		spawn(7)
			needlehit --

	poisontip(mob/M)
		if(aff==M.aff||M.shield)return
		var/t=0
		spawn()while(t<3&&M&&!M.dead)
			sleep(10)
			if(M&&!M.dead)
				t++
				var/damage=M.pow*0.08*M.tier42/3
				if(damage<1)damage=1
				damage(damage)
				new/obj/statuspop/poison(loc)
				death(M)

mob/var/tmp/
	icehit=0
	deadlydelay=0
	inmist=0
	needlehit=0
	frozenby=null
	inbarrier=0
obj/iceprisonx
	name="IPrison"
	icon='icemirrors.dmi'
	icon_state="mirror"
	layer=10
	density=1
	opacity = 1
	New()
		flick("rise",src)
		..()
		spawn(50)
		del src
obj
	iceberghit
		density=1
		icon='base.dmi'
		New()
			..()
			spawn(34)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				loc=D.loc
				if(D==O||D.icehit||O.aff==D.aff)return
				var/damage=O.pow*1.15
				if(O.clan=="Copy Ninja")damage*=0.85
				if(O.level>=70||O.clan=="Copy Ninja")damage*=1.25
				if(O.tier51&&O.clan!="Copy Ninja")damage*=1+(0.08*O.tier51)
				projectilep(O,D,damage)
				if(D)if(!D.dead)
					D.icehit=1
					D.markfrost()
					D.knockedup()
					O.faceme(D)
					D.stepback(4)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					density=0
					step(src,dir)
					density=1
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					loc=T.loc
	iceneedlemaker
		density=0
		New()
			..()
			spawn(14)del src
		Del()
			var/mob/O=owner
			var/obj/R=new/obj/icenee(locate(x-4,y,z))
			var/obj/R2=new/obj/icenee(locate(x-4,y-4,z))
			var/obj/R3=new/obj/icenee(locate(x-4,y+4,z))
			var/obj/R4=new/obj/icenee(locate(x+4,y,z))
			var/obj/R5=new/obj/icenee(locate(x+4,y+4,z))
			var/obj/R6=new/obj/icenee(locate(x+4,y-4,z))
			var/obj/R7=new/obj/icenee(locate(x,y-4,z))
			var/obj/R8=new/obj/icenee(locate(x,y+4,z))
			R.dir=EAST
			R2.dir=NORTHEAST
			R3.dir=SOUTHEAST
			R4.dir=WEST
			R5.dir=SOUTHWEST
			R6.dir=NORTHWEST
			R7.dir=NORTH
			R8.dir=SOUTH
			R.owner=O
			R2.owner=O
			R3.owner=O
			R4.owner=O
			R5.owner=O
			R6.owner=O
			R7.owner=O
			R8.owner=O
			..()
	icenee
		name=""
		icon='icenee.dmi'
		density=0
		projint=1
		New()
			..()
			flick("begin",src)
			spawn(3)
				density=1
				step(src,dir)
				walk(src,dir)
			spawn(12)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				loc=D.loc
				if(O.aff==D.aff)return
				var/T=O.pow*0.7
				if(O.level>=25)T*=1.2
				var/amountdec=0.6
				if(O.tier51)T*=1+(0.08*O.tier51)
				if(O.level>=110)amountdec=0.75
				var/timesdec=D.needlehit
				while(timesdec)
					timesdec--
					T*=amountdec
				projectile(O,D,(O.pow/1.2))
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)
	senbonwave
		name=""
		icon='Senbon Wave.dmi'
		density=1
		rundelay=0
		layer=38
		var/moveeee=0
		var/intensity=1
		projint=1
		New()
			..()
			spawn(12)del src
		Move()
			..()
			intensity+=0.25
			if(intensity>3)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				loc=D.loc
				if(D.aff==O.aff)return
				var/fhit=0.8
				var/clitchance=0
				if(O.level>=50)fhit=1.2
				if(O.tier33&&O.clan!="Copy Ninja")clitchance=6+10*O.tier33
				if(O.tier42||O.clan=="Copy Ninja")D.poisontip(O)
				if(icon_state!="w")
					projectilep(O,D,(O.apow*0.4)*fhit*intensity,clitchance)
					icon_state="w"
				else
					projectile(O,D,(O.apow*0.4)*0.8*intensity,clitchance)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)
obj
	iceprison
		icon='iceprison.dmi'
		layer=40
		pixel_x=-32
		pixel_y=-6
		New()
			..()
			spawn(70)del src
		Del()
			flick("break",src)
			spawn(7)..()
	flashfreeze
		density=0
		New()
			..()
			spawn(14)del src
			spawn(7)
				for(var/mob/M in loc)
					var/mob/O=owner
					var/mob/D=M
					if(O.aff==D.aff)continue
					if(D.illusion)
						D.illusionhit(O)
						continue
					if(D.freeze||D.busy)
						var/obj/T=new/obj/iceprison(D.loc)
						del T
						D.frozenhit(O)
					else
						D.flashfreeze(O)



	eiceberg
		icon='iceberg.dmi'
		density=0
		layer=40
		pixel_x=-100
		New()
			..()
			flick("create2",src)
			spawn(14)del src
	eiceberg1
		icon='iceberg1.dmi'
		density=0
		layer=40
		pixel_x=-76
		New()
			..()
			flick("create2",src)
			spawn(14)del src
	eiceberg2
		icon='iceberg2.dmi'
		density=0
		layer=42
		pixel_x=-16
		New()
			..()
			flick("create2",src)
			spawn(14)del src
	diceberg2
		icon='iceberg2.dmi'
		density=0
		layer=42
		New()
			..()
			flick("create2",src)
			spawn(14)del src
	iceberg
		icon='iceberg.dmi'
		density=0
		layer=40
		New()
			..()
			flick("create",src)
			spawn(14)del src
	iceberg1
		icon='iceberg1.dmi'
		density=0
		layer=40
		New()
			..()
			flick("create",src)
			spawn(14)del src
	iceberg2
		icon='iceberg2.dmi'
		density=0
		layer=42
		New()
			..()
			flick("create",src)
			spawn(14)del src
	mirrorbreak
		icon='demonmirrors.dmi'
		density=0
		icon_state="n"
		layer=42
		New()
			..()
			flick("break",src)
			spawn(7)del src
	icedome
		layer=30
		density=1
		var/zipline=0
		New()
			..()
			spawn(1)
				var/obj/t8=new/obj/domespike(loc)
				t8.spiketype="2"
				t8.pixel_x=10
				t8.pixel_y=16
				var/obj/t9=new/obj/domespike(loc)
				t9.spiketype="4"
				t9.pixel_x=-10
				t9.pixel_y=16
				var/obj/t=new/obj/domespike(loc)
				t.spiketype="5"
				t.pixel_x=-20
				t.pixel_y=12
				var/obj/t6=new/obj/domespike(loc)
				t6.spiketype="1"
				t6.pixel_x=20
				t6.pixel_y=12
				var/obj/t2=new/obj/domespike(loc)
				t2.spiketype="5"
				t2.pixel_x=-24
				t2.pixel_y=6
				var/obj/t7=new/obj/domespike(loc)
				t7.spiketype="1"
				t7.pixel_x=24
				t7.pixel_y=6
				var/obj/t5=new/obj/domespike(loc)
				t5.spiketype="4"
				t5.pixel_x=10
				var/obj/t3=new/obj/domespike(loc)
				t3.spiketype="2"
				t3.pixel_x=-10
				var/obj/t4=new/obj/domespike(loc)
				t4.spiketype="3"
				t4.pixel_y=-5
				for(var/obj/domespike/M in loc)
					M.layer=layer
					pixel_x+=rand(-5,5)
					pixel_y+=rand(-5,5)
				if(zipline)
					t9.layer--
					t8.layer--
				spawn(120)del src
	frostmarktrigger
		layer=30
		density=0
		New()
			..()
			spawn(1)
				var/obj/t8=new/obj/domespike(loc)
				t8.spiketype="2"
				t8.pixel_x=10
				t8.pixel_y=16
				var/obj/t9=new/obj/domespike(loc)
				t9.spiketype="4"
				t9.pixel_x=-10
				t9.pixel_y=16
				var/obj/t=new/obj/domespike(loc)
				t.spiketype="5"
				t.pixel_x=-20
				t.pixel_y=12
				var/obj/t6=new/obj/domespike(loc)
				t6.spiketype="1"
				t6.pixel_x=20
				t6.pixel_y=12
				var/obj/t2=new/obj/domespike(loc)
				t2.spiketype="5"
				t2.pixel_x=-24
				t2.pixel_y=6
				var/obj/t7=new/obj/domespike(loc)
				t7.spiketype="1"
				t7.pixel_x=24
				t7.pixel_y=6
				var/obj/t5=new/obj/domespike(loc)
				t5.spiketype="4"
				t5.pixel_x=10
				var/obj/t3=new/obj/domespike(loc)
				t3.spiketype="2"
				t3.pixel_x=-10
				var/obj/t4=new/obj/domespike(loc)
				t4.spiketype="3"
				t4.pixel_y=-5
				for(var/obj/domespike/M in loc)
					M.layer=layer
					pixel_x+=rand(-5,5)
					pixel_y+=rand(-5,5)
					del M
				spawn(42)del src
		Del()
			for(var/obj/domespike/M in loc)
				del M
			..()
	domespike
		layer=40+TOPDOWN_LAYER
		icon='Yuki spikes.dmi'
		New()
			..()
			spawn(rand(1,5))
				icon_state="[spiketype]"
				flick("[spiketype]a",src)
			spawn(120)del src
		Del()
			var/obj/D=new/obj/domecrash(loc)
			D.pixel_x=pixel_x
			D.pixel_y=pixel_y
			D.layer=layer
			flick("[spiketype]b",D)
			..()
	domecrash
		icon_state=""
		icon='Yuki spikes.dmi'
		New()
			..()
			spawn(10)del src
	mist
		layer=89
		mouse_opacity=0
		bound_height=96
		bound_width=96
		pixel_x=-32
		pixel_y=-32
		var/clearing=0
		New()
			..()
			spawn(206)
				clearing=2
				del src
			spawn(14)checkaround()
		Del()
			if(clearing==2)..()
			if(clearing==1)return
			if(clearing==0)
				clearing=1
				icon='mist.dmi'
				flick("clear",src)
				spawn(3)..()
		proc/checkaround()
			if(!owner)del src
			for(var/mob/player/M in loc)
				if(M==owner)
					owner:mistinvis()
					var/timer=20
					if(owner:level>=55)timer=30
					spawn(timer)if(clearing==0)del src
				else
					M.mistaffect(owner:tier23)
					spawn(3)
					if(clearing==0)del src
				return
			sleep(15)
			checkaround()
		Crossed(M)
			if(ismob(M))
				if(M==owner)
					M:mistinvis()
					spawn(34)if(clearing==0)del src
				else
					M:mistaffect()
					spawn(3)if(clearing==0)del src
	mistinvis
		icon='mistinvis.dmi'
		layer=100
	hakumirror
		icon='demonmirrors.dmi'
		layer=2
		density=1
		New()
			..()
			overlays+=/obj/hakureflect
			spawn(42)if(owner)if(owner.level<85)del src
			spawn(70)del src
		Del()
			flick("break",src)
			density=0
			for(var/obj/hakuimage/G in loc)del G
			spawn(4)
				..()
		proc
			mirrorproc()
				var/mob/O=owner
				var/obj/image=new/obj/hakuimage(loc)
				image.dir=O.dir
				image.icon=O.icon
				image.overlays=O.overlays
				image.pixel_y=2
				var/dir2
				var/dir3
				if(dir==SOUTH)
					image.dir=SOUTH
					dir2=SOUTHEAST
					dir3=SOUTHWEST
				if(dir==SOUTHEAST)
					image.dir=EAST
					dir2=SOUTH
					dir3=EAST
					pixel_x=-10
					image.pixel_x=-10
				if(dir==SOUTHWEST)
					image.dir=WEST
					dir2=WEST
					dir3=SOUTH
					pixel_x=10
					image.pixel_x=10
				if(dir==EAST)
					del image
					dir2=SOUTHEAST
					dir3=NORTHEAST
				if(dir==WEST)
					del image
					dir2=NORTHWEST
					dir3=SOUTHWEST
				if(dir==NORTH)
					del image
					dir2=NORTHEAST
					dir3=NORTHWEST
				if(dir==NORTHEAST)
					del image
					dir2=NORTH
					dir3=EAST
					pixel_x=-10
				if(dir==NORTHWEST)
					del image
					dir2=NORTH
					dir3=WEST
					pixel_x=10
				spawn()while(src)
					var/obj/L=new/obj/Mirror_Senbon(loc)
					L.owner=O
					L.dir=dir
					if(prob(50))walk(L,pick(dir,dir2,dir3))
					else
						L.icon_state="mirror2"
						L.movequick(pick(dir,dir2,dir3))
					sleep(rand(3,7))
	hakuimage
		layer=3
		New()
			..()
			spawn(70)del src
	hakureflect
		icon='demonmirrors.dmi'
		icon_state="cover"
		layer=19
		New()
			..()
			spawn(70)del src
	icicle
		icon='icicle.dmi'
		layer=50
		pixel_y=160
		New()
			..()
			flick("start",src)
			spawn(20)del src
			spawn()while(pixel_y>0)
				pixel_y-=32
				if(pixel_y>0)
					sleep(1)
				else
					flick("end",src)
					spawn(3)
						del src
					for(var/mob/A in loc)
						var/mob/O=owner
						var/mob/D=A
						if(O==D)break
						if(D.inchunin!=4)if(D.aff==O.aff)break
						var/damage=round(O.pow*0.6)
						D.dmgch(O)
						damage=(damage*D.variable)+D.variable2
						D.damage(damage)
						D.death(O)

	Mirror_Senbon
		icon='senbon.dmi'
		icon_state="mirror"
		projint=1
		New()
			..()
			pixel_x=rand(8,-8)
			pixel_y=rand(8,-8)
			spawn(34)del src
		Move()
			..()
			for(var/mob/G in loc)
				projectile(owner,G,(owner.apow/8))
			for(var/obj/hakumirror/G in loc)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(D.aff==O.aff)return
				var/dps=O.apow*0.45
				var/clitchance=0
				if(O.tier33)clitchance=6+10*O.tier33
				if(O.tier42)D.poisontip(O)
				if(icon_state=="mirror")dps=O.apow*0.8
				if(O.level>=52)dps*=1.3
				if(O.inbarrier==2)dps*=1.3
				if(icon_state=="mirror")projectile(O,D,dps,clitchance)
				else projectile(O,D,dps,clitchance)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(istype(T,/obj/Mirror_Senbon))
					loc=T.loc
				else
					if(T.density)del(src)
obj/var/spiketype="1"