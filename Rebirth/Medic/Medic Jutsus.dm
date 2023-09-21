mob
	var
		tmp/preheal=0
		tmp/obj/prehealing=/obj/medic/prehealingjutsu
mob/proc
	medicleveling()
		if(level==2)
			src<<"<b><font color=lime>You have learned Healing Jutsu. Emit a wave healing for 40% of your ninjutsu to everyone within 4 tiles. Costs 30 chakra."
			new/obj/jutsu/medic/Healing_Jutsu(src)
		if(level==5)
			src<<"<b><font color=lime>You have learned Poison Needle Barrage. Fires a fast wave of poisonous needles that deals 50% attack power and poisons them for 60% ninjutsu power over 6 seconds. "
			new/obj/jutsu/medic/Poison_Needle_Barrage(src)
		if(level==10)
			src<<"<b><font color=lime>You have learned Pre-Healing Jutsu. You receive 40% defence for the next 10 seconds, degenerating by 4% every second."
			new/obj/jutsu/medic/PreHealing_Jutsu(src)
		if(level==15)src<<"<b><font color=lime>Healing Jutsu is now level 2. Can emit waves of healing every second up to two times if you stand still."
		if(level==20)
			src<<"<b><font color=lime>You have learned Nervous System Rupture. You tamper with the nerves of enemies in front of you, making their movement keys reversed back and forth every 0.1-2 seconds for 5 seconds."
			new/obj/jutsu/medic/Nervous_System_Rupture(src)
		if(level==25)src<<"<b><font color=lime>Pre-Healing Jutsu is now level 2! The defence boost is increased to 60%, degenerating by 6% per second."
		if(level==30)
			src<<"<b><font color=lime>You have learned Chakra Transfer. Buff an ally for 5 minutes or until they die, increasing their offense by 10%. Can buff one person at a time. Can not buff yourself."
			new/obj/jutsu/medic/Chakra_Transfer(src)
		if(level==35)
			src<<"<b><font color=lime>Poison Needle Barrage is now level 2. The cooldown is reduced by 20%."
		if(level==40)
			src<<"<b><font color=lime><b>You have learned Poison Fog. Breath out a large fog of poison. Anyone inside will get poisoned for 2 seconds. Poisoned enemies can not see any target or ally and is damaged for 20% ninjutsu damage per second."
			new/obj/jutsu/medic/Poison_Fog(src)
		if(level==45)src<<"<b><font color=lime>Healing Jutsu is now level 3. Can emit up to three healing waves while moving. These healing waves costs 60 chakra total."
		if(level==50)src<<"<b><font color=lime>Pre-Healing Jutsu is now level 3! The cooldown is reduced by 15%."
		if(level==55)src<<"<b><font color=lime>Nervous System Rupture is now level 2! Slows the enemy heavily for 3 seconds after the nerve overload ends."
		if(level==60)src<<"<b><font color=lime>Poison Needle Barrage is now level 3! Poison damage increased by 40%."
		if(level==65)src<<"<b><font color=lime>Poison Fog is now level 2! Slows poisoned enemies down."
		if(level==70)src<<"<b><font color=lime>You have mastered Poison Needle Barrage. It now slows the enemy for 3 seconds."
		if(level==75)src<<"<b><font color=lime>Chakra Transfer is now level 2! Increase buffed ally's defense by 5%. Can buff up to 2 people."
		if(level==80)src<<"<b><font color=lime>Nervous System Rupture is now level 3! Decrease handseal speed by 40% during nerve overload."
		if(level==85)src<<"<b><font color=lime>Poison Fog is now level 3! Creates a even larger poison field."
		if(level==90)src<<"<b><font color=lime>You have mastered Pre-Healing Jutsu. The defense boost increased to 80%, degenerating 8% per second."
		if(level==95)src<<"<b><font color=lime>Chakra Transfer is now level 3! Increase buffed ally's chakra control and regeneration by 25%. Can buff up to 3 people."
		if(level==100)src<<"<b><font color=lime>You have mastered Poison Fog. Poison lasts for 4 seconds."
		if(level==105)src<<"<b><font color=lime>You have mastered Healing Jutsu! Will keep emitting healing waves every second as long as you stand still. These extra healing waves costs 30 chakra + 10 chakra per additional wave."
		if(level==110)src<<"<b><font color=lime>You have mastered Nervous System Rupture. Decrease attack speed by 50% during nerve overload."
		if(level==120)src<<"<b><font color=lime>You have mastered Chakra Transfer. You gain 10% offense and 5% defense. Increase buffed ally's movement speed and cooldown reduction by 10%."

	nervous(var/mob/M)
		if(M.level>=75)
			nervous=1
		if(M.level>=110)
			nervous=2
		confused=1
		var/G=2
		var/D=4
		if(bleeding && M.tier31)
			G+=3*M.tier31
			D+=3*M.tier31
		spawn(7)
			confused=0
			spawn(7)
				confused=1
				spawn(7)
					confused=0
					spawn(G)
						confused=1
						spawn(D)
							confused=0
							nervous=0
							forceupdate()
							if(M)
								if(M.level>=55)
									snared(35,2)

	heal()
		new/obj/medic/healingjutsu(loc)
		for(var/mob/M in range(4))
			if(M!=src)if(village!=M.village||M.pktoggle||pktoggle||village=="None")continue
			var/heal=pow*0.4
			if(tier11)heal*=1+0.06*tier11
			if(tier42)
				var/Z=0.1+0.15*tier42
				if(M.maxhp*Z>M.hp)
					heal*=1.25
			new/obj/heal(M.loc)
			M.hp+=heal
			if(tier53)
				var/oathheal=tier52*0.08*heal
				M.oath(oathheal)
				cycleld(70)
			if(M.hp>M.maxhp)M.hp=M.maxhp
			if(M.mybar)M.mybar:updatebar()

	oath(var/healamount)
		if(!mybar)return
		var/ZG
		overlays+=/obj/oath
		spawn(14)
			ZG=healamount/5
			if(checkld)ZG*=1+0.4*tier63
			hp+=ZG
			mybar:updatebar()
			spawn(14)
				ZG=healamount/5
				if(checkld)ZG*=1+0.4*tier63
				hp+=ZG
				mybar:updatebar()
				spawn(14)
					ZG=healamount/5
					if(checkld)ZG*=1+0.4*tier63
					hp+=ZG
					mybar:updatebar()
					spawn(14)
						ZG=healamount/5
						if(checkld)ZG*=1+0.4*tier63
						hp+=ZG
						mybar:updatebar()
						spawn(14)
							ZG=healamount/5
							if(checkld)ZG*=1+0.4*tier63
							hp+=ZG
							mybar:updatebar()
							overlays-=/obj/oath

	healingjutsu()
		prejutsu()
		if(cdelay1||seals||swim||dead||resting||stun||busy||moving||imitated||paralysed)return
		handseals(30,5,60)
		if(!sealpass)return
		cdelay1=1
		var/sdelay=200*cdpow/100
		for(var/obj/jutsu/medic/Healing_Jutsu/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay1=0
		heal()
		if(level>=25)
			var/oloc=loc
			sleep(10)
			if(level<45)
				if(loc!=oloc||cha<30)return
				cha-=30
				mybar2:updatebar()
				heal()
				sleep(10)
				if(loc!=oloc||cha<30)return
				cha-=30
				mybar2:updatebar()
				heal()
			else
				if(cha<15)return
				cha-=15
				mybar2:updatebar()
				heal()
				sleep(10)
				if(cha<15)return
				cha-=15
				mybar2:updatebar()
				heal()
				if(level>=105)
					oloc=loc
					var/timesz=0
					while(oloc==loc&&cha>=30+timesz*10)
						sleep(10)
						if(oloc!=loc)return
						cha-=30+timesz*10
						mybar2:updatebar()
						timesz++
						heal()

	poisonneedlebarrage()
		prejutsu()
		if(cdelay2||swim||dead||resting||stun||busy||moving||imitated||paralysed)return
		cdelay2=1
		var/sdelay=80*cdapow/100
		if(level>=35)sdelay*=0.8
		if(sdelay<40)sdelay=40
		for(var/obj/jutsu/medic/Poison_Needle_Barrage/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay2=0
		flick("attack",usr)
		var/obj/L=new/obj/poisonsenbon(loc)
		var/obj/L4=new/obj/poisonsenbon(loc)
		var/obj/L5=new/obj/poisonsenbon(loc)
		L.right=dir
		if(dir==NORTH)
			L4.right=NORTHWEST
			L5.right=NORTHEAST
		if(dir==SOUTH)
			L4.right=SOUTHWEST
			L5.right=SOUTHEAST
		if(dir==EAST)
			L4.right=NORTHEAST
			L5.right=SOUTHEAST
		if(dir==WEST)
			L4.right=SOUTHWEST
			L5.right=NORTHWEST
		L.owner=usr
		L4.owner=usr
		L5.owner=usr
		L.movequick(L.right)
		L4.movequick(L4.right)
		L5.movequick(L5.right)

	medicpoison(mob/M)
		if(!M)return
		if(M==src||aff==M.aff||M.shield)return
		var/t=0
		spawn()while(t<5&&M&&!M.dead)
			M.checkld(14)
			sleep(10)
			if(M&&!M.dead)
				t++
				var/damage=M.pow*0.1
				if(M.cycleld)damage*=1+M.tier63*0.4
				if(M.level>=60)damage*=1.4
				if(damage<1)damage=1
				damage(damage)
				new/obj/statuspop/poison(loc)
				death(M)

	prehealingjutsu()
		prejutsu()
		if(cdelay3||copydelay3||seals||swim||dead||resting||stun||busy||moving||imitated||paralysed)return
		handseals(50,0,65)
		if(!sealpass)return
		if(clan=="Copy Ninja")copydelay3=1
		else	cdelay3=1
		var/sdelay=420*cdpow/100
		if(level>=50)sdelay-=60
		if(tier61&&clan!="Copy Ninja")sdelay*=1-0.05*tier61
		if(sdelay<150)sdelay=150
		for(var/obj/jutsu/medic/PreHealing_Jutsu/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)
			cdelay3=0
			copydelay3=0
		preheal=40
		if(level>=25)preheal=60
		if(level>=90)preheal=80
		if(clan=="Copy Ninja")preheal=50
		var/timerz=preheal/10
		overlay()
		atkdef()
		while(preheal)
			sleep(10)
			preheal-=timerz
			if(preheal<=0)overlay()
			atkdef()
		if(clan=="Copy Ninja")tactics()
	nervoussystemrupture()
		prejutsu()
		if(cdelay4||seals||swim||dead||resting||stun||busy||moving||imitated||paralysed)return
		handseals(30,10,60)
		if(!sealpass)return
		cdelay4=1
		var/sdelay=250*cdpow/100
		for(var/obj/jutsu/medic/Nervous_System_Rupture/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay4=0
		var/obj/D=new/obj/kickloc(loc)
		step(D,dir)
		step(D,dir)
		step(D,dir)
		flick("attack",dir)
		for(var/mob/player/A in range(D,2))
			if(aff==A.aff)
				continue
			if(A.illusion)
				A.illusionhit(src)
				continue
			var/damage=pow*0.3+apow*0.3
			A.dmgch(src)
			new/obj/nervous(A.loc)
			damage=(damage*A.variable)+A.variable2
			A.damage(damage)
			A.nervous(src)
			A.death(src)

	chakratransfer()
		if(cdelay5||transbusy||dead||resting||swim||stun||imitated||imitation||caught||seals||busy)return
		prejutsu()
		handseals(100,25,100)
		if(!sealpass)return
		cdelay5=1
		for(var/obj/jutsu/medic/Chakra_Transfer/M in src)timerjutsu(60,M)
		spawn(60)cdelay5=0
		transbusy=1
		var/list/choose = list()
		var/cap=1
		if(level>=75)cap++
		if(level>=95)cap++
		cap+=tier52
		if(buffcan<cap)
			for(var/mob/M in oview(12))
				if(M.client)
					if(M.buffed||M.village!=village&&village!="None")continue
					choose.Add(M)
		var/cancel="Cancel"
		var/inanim="Remove Buffs"
		choose+=cancel
		choose+=inanim
		var/mob/M=input("Who do you want to use this jutsu on?","") as null|anything in choose
		spawn(14)transbusy=0
		if(M==cancel)return
		if(M==inanim)
			for(var/mob/F in world)
				if(F.buffed)
					if(F.buffedby==id)
						F.buffedtime=0
		else
			if(!M)return
			if(M.buffed)return
			buffcan++
			if(tier43)
				atkdef()
			new/obj/chakratransfer(M.loc)
			M.buffed=1
			if(level>=75)M.buffed=2
			if(level>=95)M.buffed=3
			if(level>=120)M.buffed=4
			M.buffedby=id
			M.buffedtime=300
			M.buffdeath=tier52
			if(tier62)
				M.buffedtime+=120*tier62
			M.buffedtime()
			M.statset()
			M.ovcheck()
			range(10)<<"<font color=cyan><b><center>[src] uses chakra transfer on [M]."
			src<<"<font color=cyan><center>You have [buffcan] chakra transfer targets currently active."

	poisonfog()
		prejutsu()
		if(cdelay6||copydelay5||seals||swim||dead||resting||stun||busy||moving||imitated||paralysed)return
		handseals(90,10,100)
		if(!sealpass)return
		if(clan=="Copy Ninja")copydelay5=1
		else	cdelay6=1
		var/sdelay=500*cdpow/100
		for(var/obj/jutsu/medic/Poison_Fog/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)
			cdelay6=0
			copydelay5=0
		var/f=100
		var/DS=3
		if(level>=100||clan=="Copy Ninja")
			DS=5
			f=200
		while(f>0)
			f--
			var/obj/F=new/obj/poisonfog(locate(x+rand(-DS,DS),y+rand(-DS,DS),z))
			F.owner=src
			walk_to(F,locate(x+rand(-10,10),y+rand(-10,10),z),0,rand(2,5))
			if(prob(3))
				sleep(1)
		if(clan=="Copy Ninja")tactics()
	chakrascalpel()
		if(dead||imitated||paralysed||caught||seals||busy)
			return
		if(stancing)
			return
		stancing = 1
		spawn(10)
			stancing = 0
		if(stance == "Chakra Scalpel")
			stance = "None"
			forceupdate()
			new/obj/statuspop/normalstance(loc)
			for(var/obj/statuseffect/stance/M in client.screen)
				del M
			overlay()
			return
		if(stance != "None")
			for(var/obj/statuseffect/stance/M in client.screen)
				del M
		stance = "Chakra Scalpel"
		forceupdate()
		ovcheck()
		var/obj/statuseffect/t = new/obj/statuseffect/stance/chakrascalpel
		t.screen_loc = "20,20"
		client.screen += t
		if(clan=="Copy Ninja")tactics()
	mitoticregeneration()
		if(bonegolemdelay == 2)
			genesis = 0
			genesisweaken = round(genesistime/2, 1)
			spawn(300)
				genesisweaken = 0
				atkdef()
			bonegolemdelay = 1
			atkdef()
			regenupdate()
			ovcheck()
			for(var/obj/jutsu/medic/Mitotic_Regeneration/M in src)
				timerjutsu(800, M)
			spawn(800)
				bonegolemdelay = 0
			for(var/obj/statuseffect/stance/mitoticregeneration/M in client.screen)
				del M
		if(bonegolemdelay||dead||imitated||paralysed||caught||seals||busy)
			return
		bonegolemdelay = 3
		spawn(20)
			if(bonegolemdelay == 3)
				bonegolemdelay = 2
		genesis = 1
		genesistime = 0
		ovcheck()
		iconrefresh()
		atkdef()
		regenupdate()
		genesisregen()
		var/obj/statuseffect/t = new/obj/statuseffect/stance/mitoticregeneration
		t.screen_loc="19,20"
		client.screen+=t

	chakraenhancedstrength()
		if(dead||imitated||paralysed||caught||seals||busy)
			return
		if(stancing)
			return
		stancing = 1
		spawn(10)
			stancing = 0
		if(stance == "Chakra Enhanced Strength")
			stance = "None"
			forceupdate()
			new/obj/statuspop/normalstance(loc)
			for(var/obj/statuseffect/stance/M in client.screen)
				del M
			overlay()
			return
		if(stance != "None")
			for(var/obj/statuseffect/stance/M in client.screen)
				del M
		stance = "Chakra Enhanced Strength"
		forceupdate()
		new/obj/chakratransfer(loc)
		var/obj/statuseffect/t = new/obj/statuseffect/stance/chakraenhancedstrength
		t.screen_loc = "20,20"
		client.screen += t

	poisongassed(mob/M)
		if(gastime<=0)
			poisongasproc(M)
		gastime=2
		if(M.level>=100||M.clan=="Copy Ninja")gastime=4

	poisongasproc(mob/M)
		if(!M)
			gastime=0
			return
		if(M.tier63&&M.clan!="Copy Ninja")M.checkld(14)
		see_invisible=0
		sight|=SEE_SELF
		spawn(14)
			sight&=~SEE_SELF
			see_invisible=1
			if(!M)
				gastime=0
			else
				var/damage=M.pow*0.2
				if(M.cycleld&&M.clan!="Copy Ninja")damage*=1+M.tier63*0.4
				if(damage<1)damage=1
				damage(damage)
				snared(14,2)
				new/obj/statuspop/poison(loc)
				death(M)
				gastime--
				if(gastime>0)
					poisongasproc(M)
				else
					gastime=0

	notsee(var/F)
		see_invisible=0
		sight|=SEE_SELF
		spawn(F)
			sight&=~SEE_SELF
			see_invisible=1

	buffedtime()
		if(buffedtime>0)
			buffedtime--
			var/A=14
			if(hosptime&&buffdeath)
				switch(buffdeath)
					if(1)
						A=21
					if(2)
						A=28
					if(3)
						A=56
			spawn(A)buffedtime()
		else
			src<<"<b><center><font color=silver>Your buff has worn off."
			buffed=0
			buffdeath=0
			for(var/mob/player/M in world)
				if(buffedby==M.id)
					M<<"<b><font color=cyan>The buff on [src] has worn off."
					M.buffcan--
					if(M.tier43)
						M.atkdef()
					M<<"<font color=cyan><center>You have [M.buffcan] chakra transfer targets currently active."
			buffedby=null
			statset()
			ovcheck()

	checkld(var/S)
		checkld++
		spawn(S)
			checkld--

	cycleld(var/S)
		cycleld++
		spawn(S)
			cycleld--

	superpunch()
		if(kickcd)
			return
		kickcd = 1
		var/F = 7
		F -= 2 * tier32
		stun(4+F)
		spawn(120*(cdapow/100))kickcd=0
		icon_state="spear"
		sleep(F)
		flick("attack",src)
		icon_state=""
		spawn(3)
			var/obj/D=new/obj/kickloc(loc)
			soundeff('explosion4.wav',70,0)
			step(D,dir)
			new/obj/medic/groundcrack(D.loc)
			for(var/mob/M in D.loc)
				if(M==src)continue
				if(aff==M.aff)continue
				if(M.illusion)
					M.illusionhit(src)
					continue
				var/damage=apow*1.2
				if(M.clan=="Taijutsu Specialist")
					if(M.tier32)damage*=1-(M.tier32*0.05)
				M.dmgch(src,1)
				damage=(damage*M.variable)+M.variable2
				M.stun(28)
				M.damage(damage,1)
				M.death(usr)
			spawn(2)
				for(var/mob/M in range(D,2))
					if(M==src)continue
					if(aff==M.aff)continue
					if(M.illusion)
						M.illusionhit(src)
						continue
					var/damage=apow
					if(M.clan=="Taijutsu Specialist")
						if(M.tier32)damage*=1-(M.tier32*0.05)
					M.dmgch(src,1)
					M.soundeff('mountain.wav',40,0)
					damage=(damage*M.variable)+M.variable2
					M.snared(28, 4)
					M.damage(damage,1)
					M.death(usr)

mob/var
	kickcd=0
	buffed=0
	buffedby=0
	buffedtime=0
	buffcan=0
	buffdeath=0
	gastime=0
	checkld=0
	cycleld=0

obj
	genesis
		icon='genesis.dmi'
		layer=5
	scalpel
		layer=15
		icon='scalpel.dmi'
	kickloc
		New()
			..()
			spawn(5)
				del src
	oath
		icon='oath.dmi'
		layer=40
	medic
		prehealingjutsu
			icon='prehealing.dmi'
			layer=30
			animate_movement=2
		healingjutsu
			layer=15
			icon='healingjutsu.dmi'
			pixel_x=-128
			pixel_y=-138
			New()
				..()
				flick("wave",src)
				spawn(20)del src
		groundcrack
			layer=2
			icon='groundcrack.dmi'
			pixel_x=-64
			pixel_y=-64
			New()
				..()
				flick("begin",src)
				spawn(80)del src
	poisonfog
		pixel_x=-16
		pixel_y=-16
		layer=50
		New()
			..()
			flick('poisongas.dmi',src)
			spawn(20)
				del src
		Move()
			..()
			var/mob/O=owner
			for(var/mob/A in loc)
				var/mob/M=A
				if(O.aff==M.aff||M.shield)return
				M.poisongassed(O)
		Crossed(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(O.aff==D.aff)return
				D.poisongassed(O)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					T.loc=loc
	poisonsenbon
		icon_state="w"
		icon='Senbon Wave.dmi'
		density=1
		rundelay=0
		layer=38
		projint=1
		var/moveeee=0
		New()
			..()
			spawn(12)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				loc=D.loc
				if(O.aff==D.aff)return
				D.medicpoison(O)
				if(O.level>=70)D.snared(30,2)
				projectile(O,D,O.apow*0.5)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)
mob/var/genesistime
obj/var/right=null