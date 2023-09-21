mob/proc
	senjuleveling()
		if(level==4)
			src<<"<b><font color=cyan>You have learned Tree Roots! With this jutsu, nearby enemies have roots come out of the ground and wrap around their legs, dealing damage and stunning them briefly."
			new/obj/jutsu/senju/Tree_Roots(src)
		if(level==9)
			src<<"<b><font color=cyan>You have learned Tree Bind Burial. Enemies who have roots around their legs have the roots expand into a coffin. After a short delay, the coffin caves in, dealing heavy damage. People inside the coffin take 50% less damage."
			new/obj/jutsu/senju/Tree_Bind_Burial(src)
		if(level==14)
			src<<"<b><font color=cyan>You have learned Trees of Life. This jutsu creates two trees that emit healing waves for you and nearby allies."
			new/obj/jutsu/senju/Trees_of_Life(src)
		if(level==18)
			src<<"<b><font color=cyan>You have learned Thorn Outburst. This jutsu causes a thorny canvas of branches to erupt beneath you, encasing you inside it. While inside your branches, you take 90% less damage. You can press G to fire wood spikes in your direction. Lasts 5 seconds or until you activate the jutsu again to release it early."
			new/obj/jutsu/senju/Thorn_Outburst(src)
		if(level==22)
			src<<"<b><font color=cyan>You have learned Wood Grave. With this jutsu, you can click somewhere on your screen to impale that location with big wood spikes. The spikes remain in place for 5 seconds, damaging and slowing anyone who walks on them. "
			new/obj/jutsu/senju/Wood_Grave(src)
		if(level==26)
			src<<"<b><font color=cyan>You have learned Wood Drill Barrage. This jutsu fires several waves of wood drills in your direction. The drills sap hp from enemies they connect with, and the drain increases while they fly through the air."
			new/obj/jutsu/senju/Wood_Drill_Barrage(src)
		if(level==30)
			src<<"<b><font color=cyan>You have learned Deep Forest Emergence. Dense branches form over a large area around you. The branches block enemy movement, creating a maze like formation. Poison then forms and looms near the branches, damaging everyone in it's path."
			new/obj/jutsu/senju/Deep_Forest_Emergence(src)
		if(level==36)
			src<<"<b><font color=cyan>You have learned Four Pillars Prison. After activated, the next time you take damage you will turn invisible for 2 seconds and create a huge prison around you, trapping you and nearby enemies inside. People from the outside of the prison cannot see inside. At the four corners of the prison, there are pillars that emit healing waves. All other jutsus are augmented while inside the prison."
			new/obj/jutsu/senju/Four_Pillars_Prison(src)
		if(level==10)src<<"<b><font color=cyan>Your Tree Roots is level 2. The cooldown has decreased by 5 seconds."
		if(level==32)src<<"<b><font color=cyan>Your Tree Roots is now mastered. The damage has increased by 10%."
		if(level==13)src<<"<b><font color=cyan>Your Tree Bind Burial is now level 2. The cooldown has decreased by 5 seconds."
		if(level==34)src<<"<b><font color=cyan>Your Tree Bind Burial is now mastered. The damage has increased by 10%."
		if(level==19)src<<"<b><font color=cyan>Your Trees of Life is now level 2. The heal has increased by 5%."
		if(level==37)src<<"<b><font color=cyan>Your Trees of Life is now mastered. They now last 5 seconds longer."
		if(level==20)src<<"<b><font color=cyan>Your Thorn Outburst is now level 2. You can now stay in the branches for 2 seconds longer."
		if(level==39)src<<"<b><font color=cyan>Your Thorn Outburst is now mastered. The cooldown has decreased by 5 seconds."
		if(level==28)src<<"<b><font color=cyan>Your Wood Grave is now level 2. The damage has increased by 5%."
		if(level==44)src<<"<b><font color=cyan>Your Wood Grave is now mastered. The cooldown has decreased by 5 seconds."
		if(level==33)src<<"<b><font color=cyan>Your Wood Drill Barrage is now level 2. The hp sap is increased by 5%."
		if(level==52)src<<"<b><font color=cyan>Your Wood Drill Barrage is now mastered. You now fire 3 waves of wood drills."
		if(level==38)src<<"<b><font color=cyan>Your Deep Forest Emergence is now level 2. The damage has increased by 10%."
		if(level==60)src<<"<b><font color=cyan>Your Deep Forest Emergence is now mastered. The cooldown has decreased by 5 seconds."
		if(level==42)src<<"<b><font color=cyan>Your Four Pillars Prison is now level 2. The cooldown has decreased by 5 seconds."
		if(level==72)src<<"<b><font color=cyan>Your Four Pillars Prison is now mastered. The time before expiration has increased by 1 second."


mob/var
	rootcaught=""
	woodgrave=0
	fourpillars=0
	pillarcaught=""
	emercd=0
	senjustancedelay=0
	thornstance=0
	stumpstance=0
	growthstance=0
	repercussivecd=0
	prisonup=0
	sagemodecd=0
	sagemode=0
	outburst=0
	treecaught=0
	fprisoncd=0
	treehealed=0
mob/proc
	growthstance()
		if(dead||imitated||paralysed||caught||seals||busy)return
		if(senjustancedelay)return
		senjustancedelay = 1
		spawn(30)
			senjustancedelay=0
		if(growthstance)
			src<<"<font color=silver><small><b>You deactivated Growth Stance!"
			growthstance=0
			regenupdate()
			forceupdate()
			return
		if(stumpstance)
			stumpstance=0
			src<<"<font color=silver><small><b>You deactivated Stump Stance!"
		if(thornstance)
			thornstance=0
			src<<"<font color=silver><small><b>You deactivated Thorn Stance!"
		range(8)<<"<font color=silver><b>[src]: Growth Stance!"
		growthstance=1
		regenupdate()
		forceupdate()
	stumpstance()
		if(dead||imitated||paralysed||caught||seals||busy)return
		if(senjustancedelay)return
		senjustancedelay = 1
		spawn(30)
			senjustancedelay=0
		if(stumpstance)
			src<<"<font color=silver><small><b>You deactivated Stump Stance!"
			stumpstance=0
			forceupdate()
			return
		if(thornstance)
			thornstance=0
			src<<"<font color=silver><small><b>You deactivated Thorn Stance!"
		if(growthstance)
			growthstance=0
			regenupdate()
			src<<"<font color=silver><small><b>You deactivated Growth Stance!"
		range(8)<<"<font color=silver><b>[src]: Stump Stance!"
		stumpstance=1
		forceupdate()
	thornstance()
		if(dead||imitated||paralysed||caught||seals||busy)return
		if(senjustancedelay)return
		senjustancedelay = 1
		spawn(30)
			senjustancedelay=0
		if(thornstance)
			src<<"<font color=silver><small><b>You deactivated Thorn Stance!"
			thornstance=0
			forceupdate()
			return
		if(stumpstance)
			stumpstance=0
			src<<"<font color=silver><small><b>You deactivated Stump Stance!"
		if(growthstance)
			growthstance=0
			regenupdate()
			src<<"<font color=silver><small><b>You deactivated Growth Stance!"
		range(8)<<"<font color=silver><b>[src]: Thorn Stance!"
		thornstance=1
		forceupdate()
	sagemode()
		if(dead||imitated||paralysed||caught||seals||busy)return
		if(sagemodecd)return
		var/sdelay=1200-(tier63*200)
		sagemodecd = 1
		spawn(sdelay)sagemodecd=0
		range(8)<<"<font color=silver><b>[src] has entered Sage Mode!"
		sagemode=1
		forceupdate()
		overlay()
		new/obj/smokebomb(loc)
		new/obj/smokebomb(loc)
		new/obj/smokebomb(loc)
		spawn(150)
			sagemode=0
			forceupdate()
			overlay()
	treeroots()
		prejutsu()
		if(cdelay1||swim||attacking||dead||resting||stun||busy||moving||seals||imitated)return
		cdelay1=1
		var/sdelay=420*cdpow/100
		if(tier52)sdelay-=sdelay*(tier52*0.03)
		if(level>=10)sdelay-=50
		handseals(30,7,15)
		if(!sealpass)
			cdelay1=0
			return
		for(var/obj/jutsu/senju/Tree_Roots/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay1=0
		if(tier23)
			new/obj/heal(loc)
			var/heal=round(maxhp*(0.0025*tier23))
			if(tier62)heal*=1+(tier62*0.04)
			hp+=heal
			if(hp>maxhp)hp=maxhp
			if(mybar)mybar:updatebar()
		range(8)<<"<font color=silver><b>[src]: Tree Roots!"
		var/obj/treerootsbinder/F=new(loc)
		step(F,dir)
		step(F,dir)
		step(F,dir)
		step(F,dir)
		sleep(5)
		spawn()
			for(var/mob/M in range(3,F))if(M.rootcaught=="")
				if(aff==M.aff)continue
				if(M.illusion)
					M.illusionhit(src)
					continue
				M.rootcaught(src)
				var/damage=pow*0.65
				if(level>=32)damage*=1.1
				if(sagemode)damage*=1.1
				M.dmgch(src)
				damage=(damage*M.variable)+M.variable2
				M.damage(damage)
				M.death(src)
				if(tier21)
					for(var/mob/T in range(2,M))if(T.rootcaught==null)
						if(aff==T.aff)continue
						if(T.illusion)
							T.illusionhit(src)
							continue
						T.rootcaught(src)
						var/damagex=damage*(0.2*tier12)
						if(sagemode)damagex*=1.1
						T.dmgch(src)
						damagex=(damagex*T.variable)+T.variable2
						T.damage(damagex)
						T.death(src)
	rootcaught(var/mob/M,var/T=0)
		stun(21)
		new/obj/treeroot(loc)
		if(!T)
			rootcaught=M
			spawn(21)rootcaught=""
	treebindburial()
		var/T=0
		for(var/mob/M in oview(8))if(M.rootcaught==src)T=1
		if(!T)return
		prejutsu()
		if(cdelay2||swim||attacking||dead||resting||stun||busy||moving||seals||imitated)return
		cdelay2=1
		var/sdelay=420*cdpow/100
		if(level>=13)sdelay-=50
		if(tier52)sdelay-=sdelay*(tier52*0.03)
		handseals(35,7,15)
		if(!sealpass)
			cdelay2=0
			return
		if(tier23)
			new/obj/heal(loc)
			var/heal=round(maxhp*(0.0025*tier23))
			if(tier62)heal*=1+(tier62*0.04)
			hp+=heal
			if(hp>maxhp)hp=maxhp
			if(mybar)mybar:updatebar()
		for(var/obj/jutsu/senju/Tree_Bind_Burial/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay2=0
		range(8)<<"<font color=silver><b>[src]: Tree Bind Burial!"
		for(var/mob/M in oview(8))if(M.rootcaught==src)
			if(aff==M.aff)continue
			if(M.illusion)
				M.illusionhit(src)
				continue
			var/chadamage=cha*(0.03*tier42)
			cha-=chadamage
			var/damage=pow*0.70
			if(level>=34)damage*=1.1
			if(sagemode)damage*=1.1
			if(tier42)damage+=chadamage
			M.dmgch(src)
			damage=(damage*M.variable)+M.variable2
			if(cha<=0)cha=0
			M.rootcaught=null
			M.treecaught=1
			M.forceupdate()
			spawn(30)
				M.treecaught=0
				M.forceupdate()
			M.stun(30)
			M.dir=SOUTH
			new/obj/treebind(M.loc)
			spawn(15)
				M.damage(damage)
				M.death(src)
				if(M&&tier53)spawn(10)M.treedamage(damage*(0.25*tier53),src)
	treedamage(var/D=0,var/mob/M)
		var/T=5
		var/damage=D
		dmgch(M)
		damage=(damage*variable)+variable2
		D=round(D*0.2)
		while(T)
			T--
			damage(damage)
			death(M)
			sleep(5)
	thornoutburst()
		if(outburst)
			outburst = 0
			for(var/obj/thornoutburst/M in loc)
				flick("delete",M)
				spawn(10)
					del M
					sandshield=0
					forceupdate()
			return
		prejutsu()
		if(cdelay4||swim||attacking||dead||resting||stun||busy||moving||seals||imitated)return
		cdelay4=1
		var/sdelay=450*cdpow/100
		if(level>=39)sdelay-=50
		if(tier52)sdelay-=sdelay*(tier52*0.03)
		handseals(25,5,12)
		if(!sealpass)
			cdelay4=0
			return
		for(var/obj/jutsu/senju/Thorn_Outburst/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay4=0
		if(tier23)
			new/obj/heal(loc)
			var/heal=round(maxhp*(0.0025*tier23))
			if(tier62)heal*=1+(tier62*0.04)
			hp+=heal
			if(hp>maxhp)hp=maxhp
			if(mybar)mybar:updatebar()
		spawn(10)outburst=1
		sandshield=1
		forceupdate()
		var/obj/thornoutburst/L=new(loc)
		L.owner=src
		var/time=50
		if(level>=20)time+=20
		spawn(time)
			if(outburst)
				outburst = 0
				for(var/obj/thornoutburst/M in loc)
					flick("delete",M)
					spawn(10)
						del M
						sandshield=0
						forceupdate()
		for(var/mob/M in oview(1))
			if(aff==M.aff)continue
			if(M.illusion)
				M.illusionhit(src)
				continue
			M.dir = get_dir(M, src)
			if(M.dir == NORTHEAST)
				if(src.dir == SOUTH)M.dir = NORTH
				if(src.dir == EAST)M.dir = EAST
				if(src.dir == WEST)M.dir = EAST
			if(M.dir == NORTHWEST)
				if(src.dir == SOUTH)M.dir = NORTH
				if(src.dir == EAST)M.dir = WEST
				if(src.dir == WEST)M.dir = WEST
			if(M.dir == SOUTHEAST)
				if(src.dir == NORTH)M.dir = SOUTH
				if(src.dir == EAST)M.dir = EAST
				if(src.dir == WEST)M.dir = EAST
			if(M.dir == SOUTHWEST)
				if(src.dir == NORTH)M.dir = SOUTH
				if(src.dir == EAST)M.dir = WEST
				if(src.dir == WEST)M.dir = WEST
			var/damage=pow*0.70
			if(sagemode)damage*=1.1
			M.dmgch(src)
			damage=(damage*M.variable)+M.variable2
			M.damage(damage)
			M.death(src)
			if(M)M.stepback(4)
	outburst()
		if(dir==NORTH)
			var/obj/woodthrow/F=new(loc)
			F.owner=src
			walk(F,NORTHEAST)
			var/obj/woodthrow/F1=new(loc)
			F1.owner=src
			walk(F1,NORTH)
			var/obj/woodthrow/F2=new(loc)
			F2.owner=src
			walk(F2,NORTHWEST)
			spawn(4)
				if(F)del F
				if(F1)del F1
				if(F2)del F2
		if(dir==EAST)
			var/obj/woodthrow/F=new(loc)
			F.owner=src
			walk(F,NORTHEAST)
			var/obj/woodthrow/F1=new(loc)
			F1.owner=src
			walk(F1,EAST)
			var/obj/woodthrow/F2=new(loc)
			F2.owner=src
			walk(F2,SOUTHEAST)
			spawn(4)
				if(F)del F
				if(F1)del F1
				if(F2)del F2
		if(dir==SOUTH)
			var/obj/woodthrow/F=new(loc)
			F.owner=src
			walk(F,SOUTH)
			var/obj/woodthrow/F1=new(loc)
			F1.owner=src
			walk(F1,SOUTHWEST)
			var/obj/woodthrow/F2=new(loc)
			F2.owner=src
			walk(F2,SOUTHEAST)
			spawn(4)
				if(F)del F
				if(F1)del F1
				if(F2)del F2
		if(dir==WEST)
			var/obj/woodthrow/F=new(loc)
			F.owner=src
			walk(F,WEST)
			var/obj/woodthrow/F1=new(loc)
			F1.owner=src
			walk(F1,SOUTHWEST)
			var/obj/woodthrow/F2=new(loc)
			F2.owner=src
			walk(F2,NORTHWEST)
			spawn(4)
				if(F)del F
				if(F1)del F1
				if(F2)del F2
	treesoflife()
		prejutsu()
		if(cdelay3||swim||attacking||dead||resting||stun||busy||moving||seals||imitated)return
		cdelay3=1
		var/sdelay=600*cdpow/100
		if(tier52)sdelay-=sdelay*(tier52*0.03)
		handseals(50,8,20)
		if(!sealpass)
			cdelay3=0
			return
		if(tier23)
			new/obj/heal(loc)
			var/heal=round(maxhp*(0.0025*tier23))
			if(tier62)heal*=1+(tier62*0.04)
			hp+=heal
			if(hp>maxhp)hp=maxhp
			if(mybar)mybar:updatebar()
		for(var/obj/jutsu/senju/Trees_of_Life/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay3=0
		var/obj/treeoflife/L=new(locate(x-4,y,z))
		L.owner=src
		var/obj/treeoflife/L1=new(locate(x+3,y,z))
		L1.owner=src
		var/obj/healhere/T=new(locate(x-3,y,z))
		T.owner=src
		T.hp=round(1+level/75)
		var/obj/healhere/T1=new(locate(x+4,y,z))
		T1.owner=src
		T1.hp=round(1+level/75)
		for(var/obj/healhere/M in oview(4))if(M.owner==src)M.treeheal(src)
		var/time=100+tier41*20
		if(level>=37)time+=50
		spawn(time)
			if(L)del L
			if(L1)del L1
			if(T)del T
			if(T1)del T1
	woodgrave()
		prejutsu()
		if(cdelay5||swim||attacking||dead||resting||stun||busy||moving||seals||imitated)return
		cdelay5=1
		var/sdelay=500*cdpow/100
		if(level>=44)sdelay-=50
		if(tier52)sdelay-=sdelay*(tier52*0.03)
		handseals(40,7,20)
		if(!sealpass)
			cdelay5=0
			return
		if(tier23)
			new/obj/heal(loc)
			var/heal=round(maxhp*(0.0025*tier23))
			if(tier62)heal*=1+(tier62*0.04)
			hp+=heal
			if(hp>maxhp)hp=maxhp
			if(mybar)mybar:updatebar()
		for(var/obj/jutsu/senju/Wood_Grave/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay5=0
		woodgrave=1
		spawn(50)if(woodgrave)woodgrave=0
	wooddrillbarrage()
		prejutsu()
		if(cdelay6||swim||dead||stun||resting||caught||seals||busy||imitated||paralysed)return
		handseals(35,6,20)
		if(!sealpass)return
		cdelay6=1
		var/sdelay=350*(cdapow/100)
		if(tier52)sdelay-=sdelay*(tier52*0.03)
		for(var/obj/jutsu/senju/Wood_Drill_Barrage/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay6=0
		range(8)<<"<font color=silver><b>[src]: Wood Drill Barrage!"
		if(tier23)
			new/obj/heal(loc)
			var/heal=round(maxhp*(0.0025*tier23))
			if(tier62)heal*=1+(tier62*0.04)
			hp+=heal
			if(hp>maxhp)hp=maxhp
			if(mybar)mybar:updatebar()
		var/waves=2
		if(level>=52)waves++
		while(waves)
			waves--
			var/obj/wooddrill/F=new(loc)
			var/obj/wooddrill/F2=new(loc)
			var/obj/wooddrill/F3=new(loc)
			F.owner=src
			F2.owner=src
			F3.owner=src
			if(dir==NORTH||dir==SOUTH)
				F2.x--
				F3.x++
			if(dir==EAST||dir==WEST)
				F2.y--
				F3.y++
			F.movequick(dir)
			F2.movequick(dir)
			F3.movequick(dir)
			sleep(2)
	fourpillarsprison()
		prejutsu()
		if(fprisoncd||swim||dead||stun||resting||caught||seals||busy||imitated||paralysed)return
		handseals(75,15,25)
		if(!sealpass)return
		fprisoncd=1
		var/sdelay=800*(cdapow/100)
		if(level>=42)sdelay-=50
		if(tier52)sdelay-=sdelay*(tier52*0.03)
		for(var/obj/jutsu/senju/Four_Pillars_Prison/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)fprisoncd=0
		if(tier23)
			new/obj/heal(loc)
			var/heal=round(maxhp*(0.0025*tier23))
			if(tier62)heal*=1+(tier62*0.04)
			hp+=heal
			if(hp>maxhp)hp=maxhp
			if(mybar)mybar:updatebar()
		fourpillars=1
		var/time=50
		if(level>=72)time+=10
		spawn(time)if(fourpillars)fourpillars=0
	deepforestemergence()
		prejutsu()
		if(emercd||seals||swim||dead||resting||stun||busy||moving||imitated||paralysed)return
		handseals(50,12,18)
		if(!sealpass)return
		emercd=1
		var/sdelay=600*cdpow/100
		if(level>=60)sdelay-=50
		if(tier52)sdelay-=sdelay*(tier52*0.03)
		spawn(sdelay)emercd=0
		for(var/obj/jutsu/senju/Deep_Forest_Emergence/M in src)timerjutsu(sdelay,M)
		if(tier23)
			new/obj/heal(loc)
			var/heal=round(maxhp*(0.0025*tier23))
			if(tier62)heal*=1+(tier62*0.04)
			hp+=heal
			if(hp>maxhp)hp=maxhp
			if(mybar)mybar:updatebar()
		var/createx=-4
		var/createy=-4
		while(createy<=4)
			if(createx>4)
				createx=-4
				createy++
			if(prob(23))
				for(var/obj/G in locate(x+createx,y+createy,z))
					if(G:density)
						createx++
						if(createx==0&&createy==0)createx++
						continue
				var/obj/deepforest/V=new(locate(x+createx,y+createy,z))
				V.owner=src
			createx++
			if(createx==0&&createy==0)createx++
	createprison()
		range(8)<<"<font color=silver><b>[src]: Four Pillars Prison!"
		fourpillars=0
		for(var/mob/M in range(5))
			if(aff==M.aff)continue
			M.pillarcaught=src
			spawn(60)M.pillarcaught=""
		invisibility=10
		subinvis=1
		spawn(20)
			invisibility=1
			subinvis=0
		for(var/turf/Q in range(6,src))
			var/obj/prisondark/T=new(locate(Q.x,Q.y,Q.z))
			T.owner=src
		prisonup=1
		forceupdate()
		spawn(60)
			prisonup=0
			forceupdate()
		var/obj/prison/topleft/t=new(locate(x-6,y+6,z))
		t.dir=SOUTHEAST
		var/obj/prison/topright/t1=new(locate(x+6,y+6,z))
		t1.dir=SOUTHWEST
		var/obj/prison/bottomleft/t2=new(locate(x-6,y-6,z))
		t2.dir=NORTHEAST
		var/obj/prison/bottomright/t3=new(locate(x+6,y-6,z))
		t3.dir=NORTHWEST
		var/obj/prison/topmiddle/t4=new(locate(x-5,y+6,z))
		var/obj/prison/topmiddle/t5=new(locate(x-4,y+6,z))
		var/obj/prison/topmiddle/t6=new(locate(x-3,y+6,z))
		var/obj/prison/topmiddle/t7=new(locate(x-2,y+6,z))
		var/obj/prison/topmiddle/t8=new(locate(x-1,y+6,z))
		var/obj/prison/topmiddle/t9=new(locate(x,y+6,z))
		t9.dir=SOUTH
		var/obj/prison/topmiddle/t10=new(locate(x+1,y+6,z))
		var/obj/prison/topmiddle/t11=new(locate(x+2,y+6,z))
		var/obj/prison/topmiddle/t12=new(locate(x+3,y+6,z))
		var/obj/prison/topmiddle/t13=new(locate(x+4,y+6,z))
		var/obj/prison/topmiddle/t14=new(locate(x+5,y+6,z))
		var/obj/prison/bottommiddle/t15=new(locate(x-5,y-6,z))
		var/obj/prison/bottommiddle/t16=new(locate(x-4,y-6,z))
		var/obj/prison/bottommiddle/t17=new(locate(x-3,y-6,z))
		var/obj/prison/bottommiddle/t18=new(locate(x-2,y-6,z))
		var/obj/prison/bottommiddle/t19=new(locate(x-1,y-6,z))
		var/obj/prison/bottommiddle/t20=new(locate(x,y-6,z))
		t20.dir=NORTH
		var/obj/prison/bottommiddle/t21=new(locate(x+1,y-6,z))
		var/obj/prison/bottommiddle/t22=new(locate(x+2,y-6,z))
		var/obj/prison/bottommiddle/t23=new(locate(x+3,y-6,z))
		var/obj/prison/bottommiddle/t24=new(locate(x+4,y-6,z))
		var/obj/prison/bottommiddle/t25=new(locate(x+5,y-6,z))
		var/obj/prison/left/t26=new(locate(x-6,y-5,z))
		var/obj/prison/left/t27=new(locate(x-6,y-4,z))
		var/obj/prison/left/t28=new(locate(x-6,y-3,z))
		var/obj/prison/left/t29=new(locate(x-6,y-2,z))
		var/obj/prison/left/t30=new(locate(x-6,y-1,z))
		var/obj/prison/left/t31=new(locate(x-6,y,z))
		t31.dir=EAST
		var/obj/prison/left/t32=new(locate(x-6,y+1,z))
		var/obj/prison/left/t33=new(locate(x-6,y+2,z))
		var/obj/prison/left/t34=new(locate(x-6,y+3,z))
		var/obj/prison/left/t35=new(locate(x-6,y+4,z))
		var/obj/prison/left/t36=new(locate(x-6,y+5,z))
		var/obj/prison/right/t37=new(locate(x+6,y-5,z))
		var/obj/prison/right/t38=new(locate(x+6,y-4,z))
		var/obj/prison/right/t39=new(locate(x+6,y-3,z))
		var/obj/prison/right/t40=new(locate(x+6,y-2,z))
		var/obj/prison/right/t41=new(locate(x+6,y-1,z))
		var/obj/prison/right/t42=new(locate(x+6,y,z))
		t42.dir=WEST
		var/obj/prison/right/t43=new(locate(x+6,y+1,z))
		var/obj/prison/right/t44=new(locate(x+6,y+2,z))
		var/obj/prison/right/t45=new(locate(x+6,y+3,z))
		var/obj/prison/right/t46=new(locate(x+6,y+4,z))
		var/obj/prison/right/t47=new(locate(x+6,y+5,z))
		if(tier61)
			var/time=4*tier61
			t.drillproc(time)
			t1.drillproc(time)
			t2.drillproc(time)
			t3.drillproc(time)
			t9.drillproc(time)
			t20.drillproc(time)
			t31.drillproc(time)
			t42.drillproc(time)
		t.owner=src
		t1.owner=src
		t2.owner=src
		t3.owner=src
		t4.owner=src
		t5.owner=src
		t6.owner=src
		t7.owner=src
		t8.owner=src
		t9.owner=src
		t10.owner=src
		t11.owner=src
		t12.owner=src
		t13.owner=src
		t14.owner=src
		t15.owner=src
		t16.owner=src
		t17.owner=src
		t18.owner=src
		t19.owner=src
		t20.owner=src
		t21.owner=src
		t22.owner=src
		t23.owner=src
		t24.owner=src
		t25.owner=src
		t26.owner=src
		t27.owner=src
		t28.owner=src
		t29.owner=src
		t30.owner=src
		t31.owner=src
		t32.owner=src
		t33.owner=src
		t34.owner=src
		t35.owner=src
		t36.owner=src
		t37.owner=src
		t38.owner=src
		t39.owner=src
		t40.owner=src
		t41.owner=src
		t42.owner=src
		t43.owner=src
		t44.owner=src
		t45.owner=src
		t46.owner=src
		t47.owner=src
		t.treeheal(src,2)
		t1.treeheal(src,2)
		t2.treeheal(src,2)
		t3.treeheal(src,2)
	finaldraw()
		var/obj/woodspikes/F=new(locate(x+1,y+1,z))
		F.owner=src
		var/obj/woodspikes/F1=new(locate(x-1,y+1,z))
		F1.owner=src
		var/obj/woodspikes/F2=new(locate(x-1,y-1,z))
		F2.owner=src
		var/obj/woodspikes/F3=new(locate(x+1,y-1,z))
		F3.owner=src
		var/obj/woodspikes/F4=new(locate(x,y+1,z))
		F4.owner=src
		var/obj/woodspikes/F5=new(locate(x,y-1,z))
		F5.owner=src
		var/obj/woodspikes/F6=new(locate(x+1,y,z))
		F6.owner=src
		var/obj/woodspikes/F7=new(locate(x-1,y,z))
		F7.owner=src
		spawn(1)
			var/obj/woodspikes/T=new(locate(x+2,y+2,z))
			T.owner=src
			var/obj/woodspikes/T1=new(locate(x-2,y+2,z))
			T1.owner=src
			var/obj/woodspikes/T2=new(locate(x-2,y-2,z))
			T2.owner=src
			var/obj/woodspikes/T3=new(locate(x+2,y-2,z))
			T3.owner=src
			var/obj/woodspikes/T4=new(locate(x,y+2,z))
			T4.owner=src
			var/obj/woodspikes/T5=new(locate(x,y-2,z))
			T5.owner=src
			var/obj/woodspikes/T6=new(locate(x+2,y,z))
			T6.owner=src
			var/obj/woodspikes/T7=new(locate(x-2,y,z))
			T7.owner=src
		spawn(2)
			var/obj/woodspikes/Y=new(locate(x+3,y+3,z))
			Y.owner=src
			var/obj/woodspikes/Y1=new(locate(x-3,y+3,z))
			Y1.owner=src
			var/obj/woodspikes/Y2=new(locate(x-3,y-3,z))
			Y2.owner=src
			var/obj/woodspikes/Y3=new(locate(x+3,y-3,z))
			Y3.owner=src
			var/obj/woodspikes/Y4=new(locate(x,y+3,z))
			Y4.owner=src
			var/obj/woodspikes/Y5=new(locate(x,y-3,z))
			Y5.owner=src
			var/obj/woodspikes/Y6=new(locate(x+3,y,z))
			Y6.owner=src
			var/obj/woodspikes/Y7=new(locate(x-3,y,z))
			Y7.owner=src
		spawn(3)
			var/obj/woodspikes/Q=new(locate(x+4,y+4,z))
			Q.owner=src
			var/obj/woodspikes/Q1=new(locate(x-4,y+4,z))
			Q1.owner=src
			var/obj/woodspikes/Q2=new(locate(x-4,y-4,z))
			Q2.owner=src
			var/obj/woodspikes/Q3=new(locate(x+4,y-4,z))
			Q3.owner=src
			var/obj/woodspikes/Q4=new(locate(x,y+4,z))
			Q4.owner=src
			var/obj/woodspikes/Q5=new(locate(x,y-4,z))
			Q5.owner=src
			var/obj/woodspikes/Q6=new(locate(x+4,y,z))
			Q6.owner=src
			var/obj/woodspikes/Q7=new(locate(x-4,y,z))
			Q7.owner=src
		spawn(4)
			for(var/obj/woodspikes/G in oview(4))if(G.owner==src)
				for(var/mob/M in G.loc)
					if(aff==M.aff)continue
					var/damage=pow*(0.40*tier32)
					if(sagemode)damage*=1.1
					M.dmgch(src)
					damage=(damage*M.variable)+M.variable2
					M.damage(damage)
					M.death(src)
obj/proc
	treeheal(var/mob/T,var/I=1)
		loop
			new/obj/medic/healingjutsu(loc)
			for(var/mob/M in range(4,src))
				if(M!=T)if(T.village!=M.village||M.pktoggle||T.pktoggle||T.village=="None")continue
				var/heal=T.pow*0.30
				if(I==1)
					for(var/obj/prisondark/Y in loc)if(Y.owner==T)heal*=1.2
					if(T.level>=19)heal*=1.05
				if(T.tier41)heal*=1+(0.03*T.tier41)
				if(T.tier62&&M==T)heal*=1+(0.04*T.tier62)
				heal=round(heal/I)
				new/obj/heal(M.loc)
				M.hp+=heal
				if(M.hp>M.maxhp)M.hp=M.maxhp
				if(M.mybar)M.mybar:updatebar()
				M.treehealed=1
				M.forceupdate()
				spawn(30/I+1)
					M.treehealed=0
					M.forceupdate()
			if(src)spawn(30/I)goto loop
	createpoison(var/turf/T)
		while(src)
			var/obj/forestpoison/V=new(loc)
			V.owner=owner
			var/obj/forestpoison/V1=new(loc)
			V1.owner=owner
			for(var/obj/forestpoison/M in loc)walk_rand(M,2)
			sleep(15)
//	moverandom(var/turf/T)
//		loop
//			if(src)
//				walk_to(src,locate(T.x+rand(-3,3),T.y+rand(-3,3),z),0,rand(2,4))
//				spawn(5)goto loop
obj
	treerootsbinder
		New()spawn(15)del src
	sageeyes
		layer=MOB_LAYER+6
		icon='sage eyes.dmi'
	woodspikes
		icon='wood spike.dmi'
		layer=15
		New()
			..()
			flick("create",src)
			spawn(4)
				flick("delete",src)
				spawn(4)del src
	woodthrow
		density=1
		New()spawn(10)del src
		Move()
			..()
			var/obj/woodspikes/Q=new(loc)
			Q.owner=owner
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				loc=D.loc
				if(O.aff==D.aff)return
				if(O.tier43)D.snared(O.tier43*0.6,3)
				var/damage=O.pow*0.50
				if(O.sagemode)damage*=1.1
				D.dmgch(O)
				damage=(damage*D.variable)+D.variable2
				D.damage(damage)
				D.death(O)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)
	thornoutburst
		icon='Thorn Outburst.dmi'
		layer=40
		pixel_x=-30
		pixel_y=-13
		New()
			..()
			flick("create",src)
			spawn(100)if(src)del src
	deepforest
		icon='forest.dmi'
		layer=40
		var/fa=1
		density=1
		New()
			..()
			spawn(7)createpoison(loc)
			fa="[rand(1,2)]"
			flick("[fa]a",src)
			spawn(53)
				flick("[fa]b",src)
				spawn(7)
					del src
	forestpoison
		pixel_x=-16
		pixel_y=-16
		layer=50
		New()
			..()
			flick('poisongas.dmi',src)
			spawn(10)
				del src
		Move()
			..()
			if(!owner)del src
			for(var/mob/A in loc)
				var/mob/O=owner
				var/mob/D=A
				if(O.aff==D.aff)return
				if(O.tier43)D.snared(O.tier43*0.6,3)
				var/damage=O.pow*0.50
				if(O.sagemode)damage*=1.1
				D.dmgch(O)
				damage=(damage*D.variable)+D.variable2
				D.damage(damage)
				D.death(O)
	prisondark
		icon='prisondark.dmi'
		mouse_opacity=0
		New()spawn(60)if(src)del src
	prison
		icon='Four Pillars Prison.dmi'
		layer=40
		density=1
		opacity=1
		topleft
			New()
				flick("1",src)
				spawn(60)del src
		topmiddle
			New()
				flick("2",src)
				spawn(60)del src
		topright
			New()
				flick("3",src)
				spawn(60)del src
		//
		left
			New()
				flick("4",src)
				spawn(60)del src
		right
			New()
				flick("5",src)
				spawn(60)del src
		//
		bottomleft
			New()
				flick("6",src)
				spawn(60)del src
		bottommiddle
			New()
				flick("7",src)
				spawn(60)del src
		bottomright
			New()
				flick("8",src)
				spawn(60)del src
		proc
			drillproc(var/time=0)
				spawn()while(src&&time)
					time--
					var/obj/wooddrillx/V=new(loc)
					V.owner=owner
					V.dir=dir
					walk(V,V.dir)
					sleep(rand(4,5))
	wooddrill
		icon='wood drill.dmi'
		layer=15
		density=1
		projint=2
		var/hpsap=0.05
		New()spawn(20)del src
		Move()
			..()
			if(!owner)del src
			hpsap+=0.01
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				loc=D.loc
				if(O.aff==D.aff)return
				if(O.tier43)D.snared(O.tier43*0.6,3)
				var/damage=O.pow*0.65
				if(O.sagemode)damage*=1.1
				D.dmgch(O)
				damage=(damage*D.variable)+D.variable2
				D.damage(damage)
				D.death(O)
				var/heal=round(damage*hpsap)
				for(var/obj/prisondark/Y in loc)if(Y.owner==O)heal*=1.1
				if(O.level>=33)heal*=1.05
				new/obj/heal(O.loc)
				O.hp+=heal
				if(O.hp>O.maxhp)O.hp=O.maxhp
				if(O.mybar)O.mybar:updatebar()
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)
	wooddrillx
		icon='wood drill.dmi'
		layer=15
		var/hpsap=0.05
		New()spawn(20)del src
		Move()
			..()
			if(!owner)del src
			hpsap+=0.01
			for(var/mob/A in loc)
				var/mob/O=owner
				var/mob/D=A
				if(O.aff==D.aff)return
				if(O.tier43)D.snared(O.tier43*0.6,3)
				var/damage=O.pow*0.30
				if(O.sagemode)damage*=1.1
				D.dmgch(O)
				damage=(damage*D.variable)+D.variable2
				D.damage(damage)
				D.death(O)
				var/heal=round(damage*hpsap)
				new/obj/heal(O.loc)
				O.hp+=heal
				if(O.hp>O.maxhp)O.hp=O.maxhp
				if(O.mybar)O.mybar:updatebar()
			for(var/obj/prison/G in loc)del src
	woodgrave
		icon='Wood Grave.dmi'
		layer=40
		var/fa=1
		New()
			..()
			fa="[rand(1,4)]"
			flick("[fa]a",src)
			spawn(46)
				flick("[fa]b",src)
				spawn(4)
					del src
		Crossed(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(O.aff==D.aff)return
				D.snared(20,2)
				var/damage=O.pow*0.35
				if(O.sagemode)damage*=1.1
				if(O.level>=28)damage*=1.05
				D.dmgch(O)
				damage=(damage*D.variable)+D.variable2
				D.damage(damage)
				D.death(O)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					T.loc=loc
	treeoflife
		icon='Dead Tree.png'
		layer=45
		New()
			spawn(360)if(src)del src
	healhere
		var/hp=1
		density=1
		New()
			spawn(360)if(src)del src
	treebind
		icon='Tree Bind Burial.dmi'
		layer=45
		pixel_x=-32
		New()
			flick("1",src)
			spawn(30)del src
	treeroot
		layer=42
		icon='tree roots.dmi'
		icon_state="caught"
		New()
			flick("caught",src)
			spawn(17)
				flick("delete",src)
				spawn(4)del src
