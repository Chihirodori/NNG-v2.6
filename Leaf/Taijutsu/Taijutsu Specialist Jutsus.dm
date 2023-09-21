mob/proc
	taileveling()
		if(level==4)
			src<<"<b><font color=cyan>You have learned Whirlwind Kick! This technique does a quick spin kick to attack the legs of enemies around you. Enemies hit are knocked back and slowed for 2 seconds."
			new/obj/jutsu/taijutsu/Whirlwind_Kick(src)
		if(level==9)
			src<<"<b><font color=cyan>You have learned Strong Fist(passive). You break the bones of your enemies by attacking them in succession. Every 3 hits to the same person will deal 5% of their max hp as damage and slow them for 2 seconds"
		if(level==14)
			src<<"<b><font color=cyan>You have learned Dancing Leaf Shadow. This technique teleports you behind a crippled target and grants a 50% damage increase on your next attack."
			new/obj/jutsu/taijutsu/Dancing_Leaf_Shadow(src)
		if(level==18)
			src<<"<b><font color=cyan>You have learned Primary Lotus. With this technique, you throw a fast moving bandage that will wrap around an enemy it collides with. You then pull yourself to them, kick them in the air, and piledrive them to the ground. You deal massive damage to your enemy, slow them down, confuse their movements, and enter the Gate of Opening."
			new/obj/jutsu/taijutsu/Primary_Lotus(src)
		if(level==22)
			src<<"<b><font color=cyan>You have learned Dynamic Entry. With this technique, you turn invisible for 2 seconds. Activating the jutsu again while invisible will make charge forward with a high knock out kick. Enemies you collide with will be damaged, knocked back, and stunned briefly."
			new/obj/jutsu/taijutsu/Dynamic_Entry(src)
		if(level==26)
			src<<"<b><font color=cyan>You have learned Hidden Lotus. This technique targets the closest enemy to you, and makes you move at inhuman speeds while you repeatedly punch them with such force that they fly back. The amount of punches you throw scales with your attack speed. You enter the Gate of Pain before doing your combo."
			new/obj/jutsu/taijutsu/Hidden_Lotus(src)
		if(level==30)
			src<<"<b><font color=cyan>You have learned Rising Wind. This technique causes you to kick enemies directly in front of you high into the air."
			new/obj/jutsu/taijutsu/Rising_Wind(src)
		if(level==38)
			src<<"<b><font color=cyan>You have learned Morning Peacock. This technique teleports you forward 4 tiles, stopping if you run into an enemy. You then throw 8 punches so fast that you send fire in all directions. You enter the Gate of View before doing your combo."
			new/obj/jutsu/taijutsu/Morning_Peacock(src)
		if(level==12)src<<"<b><font color=cyan>Your Whirlwind Kick is level 2. It now deals 10% more damage."
		if(level==40)src<<"<b><font color=cyan>Your Whirlwind Kick is now mastered. The cooldown has decreased by 5%."
		if(level==16)src<<"<b><font color=cyan>Your Dancing Leaf Shadow is now level 2. The cooldown has decreased by 10%."
		if(level==44)src<<"<b><font color=cyan>Your Dancing Leaf Shadow is now mastered. It now has a higher range."
		if(level==20)src<<"<b><font color=cyan>Your Primary Lotus is now level 2. The damage has increased by 10%."
		if(level==48)src<<"<b><font color=cyan>Your Primary Lotus is now mastered. The cooldown has decreased by 10%."
		if(level==24)src<<"<b><font color=cyan>Your Dynamic Entry is now level 2. You now dash further."
		if(level==52)src<<"<b><font color=cyan>Your Dynamic Entry is now mastered. The damage has increased by 10%."
		if(level==28)src<<"<b><font color=cyan>Hidden Lotus is now level 2. You now throw an extra punch."
		if(level==56)src<<"<b><font color=cyan>Hidden Lotus is now mastered. The damage has increased by 5%."
		if(level==32)src<<"<b><font color=cyan>Rising Wind is now level 2. The cooldown has decreased by 5%."
		if(level==60)src<<"<b><font color=cyan>Rising Wind is now mastered. The damage has increased by 10%."
		if(level==41)src<<"<b><font color=cyan>Morning Peacock is now level 2. The cooldown has decreased by 10%."
		if(level==64)src<<"<b><font color=cyan>Morning Peacock is now mastered. The damage has increased by 10%."
mob/var
	tmp/strongfist=""
	tmp/strongfistc=0
	tmp/crippled=""
	tmp/winded=0
	tmp/dynamic=0
	tmp/lotus=0
	tmp/peacockdelay=0
	tmp/peacocking=0
	tmp/shadowport=0
	tmp/crippledd=0
	tmp/purolin=0
	tmp/hundredfists=0
	tmp/Gate=""
	tmp/Debuff=""
	tmp/list/obj/Bandages=new
	tmp/lotushit = 0
mob
	proc
		EnterGates(var/Gates="")
			if(Gates=="Opening")
				range(8)<<"<font color=lime><b>[src]: Gate of Opening!"
				Gate="Opening"
				immuneslow=1
				atkdef()
				overlay()
				iconrefresh()
				forceupdate()
				spawn(100+(20*tier51))
					if(Gate=="Opening")
						EnterDebuff("Tired")
						immuneslow=0
						Gate=""
						atkdef()
						overlay()
						iconrefresh()
						forceupdate()
			if(Gates=="Pain")
				range(8)<<"<font color=lime><b>[src]: Gate of Pain!"
				Gate="Pain"
				immuneslow=1
				atkdef()
				overlay()
				iconrefresh()
				forceupdate()
				spawn(100+(20*tier51))
					if(Gate=="Pain")
						EnterDebuff("Muscle Tear")
						immuneslow=0
						Gate=""
						atkdef()
						overlay()
						iconrefresh()
						forceupdate()
			if(Gates=="View")
				range(8)<<"<font color=lime><b>[src]: Gate of View!"
				Gate="View"
				immuneslow=0
				overlay()
				iconrefresh()
				atkdef()
				forceupdate()
				spawn(100+(20*tier51))
					if(Gate=="View")
						EnterDebuff("Body Destruction")
						Gate=""
						overlay()
						iconrefresh()
						atkdef()
						forceupdate()
		EnterDebuff(var/Debuffs="")
			if(Debuffs=="Tired")
				src<<"<font color=silver><b>You have received the Tired debuff for 30 seconds!"
				Debuff="Tired"
				forceupdate()
				spawn(300)
					if(Debuff=="Tired")
						Debuff=""
						forceupdate()
						src<<"<font color=silver><b>Your Tired debuff has worn off!"
			if(Debuffs=="Muscle Tear")
				src<<"<font color=silver><b>You have received the Muscle Tear debuff for 30 seconds!"
				Debuff="Muscle Tear"
				atkdef()
				spawn(300)
					if(Debuff=="Muscle Tear")
						Debuff=""
						atkdef()
						src<<"<font color=silver><b>Your Muscle Tear debuff has worn off!"
			if(Debuffs=="Body Destruction")
				src<<"<font color=silver><b>You have received the Body Destruction debuff for 30 seconds!"
				Debuff="Body Destruction"
				spawn(300)
					if(Debuff=="Body Destruction")
						Debuff=""
						src<<"<font color=silver><b>Your Body Destruction debuff has worn off!"
		whirlwindkick()
			prejutsu()
			if(cdelay1||swim||dead||stun||resting||caught||seals||busy||imitated||paralysed||lotus)return
			cdelay1=1
			var/sdelay=350*(cdapow/100)
			if(level>=40)sdelay-=0.95
			if(tier61&&hp<maxhp)
				sdelay-=tier61*10
				var/tmp/num=(maxhp-hp)/(200-(50*tier61))
				sdelay-=num*10
				if(sdelay<100)sdelay=100
			for(var/obj/jutsu/taijutsu/Whirlwind_Kick/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)cdelay1=0
			if(tier53&&!hundredfists)hundredfists()
			flick("whirlwind kick",src)
			for(var/mob/M in range(2, src))
				if(aff == M.aff)
					continue
				if(M.illusion)
					M.illusionhit(src)
					continue
				if(level>=9)
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
				if(tier41)M.strengthpurolin(src)
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
				var/damage = apow * 0.60
				if(level>=12)damage*=1.1
				if(shadowport)
					shadowport=0
					damage*=1.5
				if(M.clan=="Taijutsu Specialist")
					if(M.tier32)damage*=1-(M.tier32*0.05)
				M.dmgch(src, 1)
				damage = (damage*M.variable) + M.variable2
				critroll(M)
				var/random = rand(1, 100)
				if(tier22)random-=6*tier22
				if(criticalroll >= random)
					M.damage(damage, 1.1 + (tier33*0.05))
				else
					M.damage(damage)
				if(M)
					if(tier31)
						if(hp<maxhp)
							var/tmp/heal=(M.maxhp-M.hp)*(0.005*tier31)
							new/obj/heal(loc)
							hp+=heal
							if(hp>maxhp)hp=maxhp
							if(mybar)mybar:updatebar()
					M.stepback(4)
					M.snared(28,3)
					if(tier63&&M.hp<M.maxhp*(0.04*tier63))
						view(12)<<"<b><center><font color=silver>[src] executed [M] with Whirlwind Kick!"
						M.damage(M.hp)
						M.death(src)
					else
						M.death(src)
		//
		//
		crippled(var/mob/M)
			crippled=M
			spawn(30)crippled=""
			if(tier21)
				M.crippledd=tier21
				M.atkdef()
				spawn(100)
					M.crippledd=0
					M.atkdef()
			M.snared(20,3)
			var/damage = M.maxhp*0.05
			if(M.clan=="Taijutsu Specialist")
				if(M.tier32)damage*=1-(M.tier32*0.05)
			M.dmgch(src, 1)
			damage = (damage*M.variable) + M.variable2
			critroll(M)
			var/random = rand(1, 100)
			if(tier22)random-=6*tier22
			if(criticalroll >= random)
				M.damage(damage, 1.1 + (tier33*0.05))
			else
				M.damage(damage)
			if(M)
				if(tier31)
					if(hp<maxhp)
						var/tmp/heal=(M.maxhp-M.hp)*(0.005*tier31)
						new/obj/heal(loc)
						hp+=heal
						if(hp>maxhp)hp=maxhp
						if(mybar)mybar:updatebar()
				if(tier63&&M.hp<M.maxhp*(0.04*tier63))
					view(12)<<"<b><center><font color=silver>[src] executed [M] with Cripple!"
					M.damage(M.hp)
					M.death(src)
				else
					M.death(src)
		//
		//
		dancingleafshadow()
			prejutsu()
			if(cdelay2||snared||freeze||dead||caught||seals||stun||imitated||imitation||busy||lotus)return
			cdelay2=1
			var/sdelay=400*(cdapow/100)
			if(level>=16)sdelay*=0.90
			if(tier61&&hp<maxhp)
				sdelay-=tier61*10
				var/tmp/num=(maxhp-hp)/(200-(50*tier61))
				sdelay-=num*10
				if(sdelay<100)sdelay=100
			for(var/obj/jutsu/taijutsu/Dancing_Leaf_Shadow/T in src)timerjutsu(sdelay,T)
			spawn(sdelay)cdelay2=0
			if(tier53&&!hundredfists)hundredfists()
			var/range=3
			var/obj/assassinate/F=new(loc)
			step(F,dir)
			step(F,dir)
			step(F,dir)
			if(level>=44)
				step(F,dir)
				range++
			spawn()
				for(var/mob/player/M in range(range,F))
					if(aff==M.aff)continue
					if(level>=9)
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
					if(tier41)M.strengthpurolin(src)
					moving=0
					if(M.dir==NORTH)loc=locate(M.x,M.y-1,M.z)
					if(M.dir==SOUTH)loc=locate(M.x,M.y+1,M.z)
					if(M.dir==EAST)loc=locate(M.x-1,M.y,M.z)
					if(M.dir==WEST)loc=locate(M.x+1,M.y,M.z)
					dir=M.dir
					flick("k",src)
					barloc()
					if(tier63&&M.hp<M.maxhp*(0.04*tier63))
						view(12)<<"<b><center><font color=silver>[src] executed [M] with Dancing Leaf Shadow!"
						M.damage(M.hp)
						M.death(src)
						return
					shadowport=1
		//
		//
		dynamicentry()
			if(dynamic)
				dynamic=0
				dynamicdash()
				return
			prejutsu()
			if(cdelay4||snared||freeze||dead||caught||seals||stun||imitated||imitation||busy||lotus)return
			cdelay4=1
			var/sdelay=300*cdapow/100
			if(tier61&&hp<maxhp)
				sdelay-=tier61*10
				var/tmp/num=(maxhp-hp)/(200-(50*tier61))
				sdelay-=num*10
				if(sdelay<100)sdelay=100
			for(var/obj/jutsu/taijutsu/Dynamic_Entry/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)cdelay4=0
			if(tier53&&!hundredfists)hundredfists()
			dynamic=1
			invisibility=10
			sight |= SEE_SELF
			barloc()
			spawn(20)
				if(dynamic)dynamicdash()
		dynamichemorrhage(var/mob/M,var/damage=0)
			damage*=0.15*M.tier52
			var/tmp/times=6
			snared(30,1)
			loop
				if(times)
					times--
					new/obj/hit(loc)
					damage(damage/6)
					death(M)
					spawn(5)goto loop
		dynamicdash()
			view(8)<<"<b><font color=silver>[src]: Dynamic Entry!"
			dynamic=0
			invisibility=1
			sight &= ~SEE_SELF
			barloc()
			var/am = 4
			if(level>=24)am++
			fast=1
			flick("dynamic entry",src)
			loop
				if(am)
					am --
					moving = 0
					step(src,dir)
					for(var/mob/M in oview(1))
						if(aff==M.aff)continue
						if(dir==SOUTH&&M.y<y||dir==NORTH&&M.y>y||dir==EAST&&M.x>x||dir==WEST&&M.x<x)
							if(M.illusion)
								M.illusionhit(src)
								continue
							flick("dynamic entry hit",src)
							faceme(M)
							M.stepback(4)
							M.stun(8)
							var/damage = apow*0.75
							if(level>=52)damage*=1.1
							if(shadowport)
								shadowport=0
								damage*=1.5
							if(M.clan=="Taijutsu Specialist")
								if(M.tier32)damage*=1-(M.tier32*0.05)
							M.dmgch(src, 1)
							damage = (damage*M.variable) + M.variable2
							M.damage(damage, 1.1 + (tier33*0.05))
							if(M)
								if(tier31)
									if(hp<maxhp)
										var/tmp/heal=(M.maxhp-M.hp)*(0.005*tier31)
										new/obj/heal(loc)
										hp+=heal
										if(hp>maxhp)hp=maxhp
										if(mybar)mybar:updatebar()
								if(level>=9)
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
								if(tier41)M.strengthpurolin(src)
								if(tier52)M.dynamichemorrhage(src,damage*(1.4+(tier33*0.05)))
								if(tier63&&M.hp<M.maxhp*(0.04*tier63))
									view(12)<<"<b><center><font color=silver>[src] executed [M] with Dynamic Entry!"
									M.damage(M.hp)
									M.death(src)
								else
									M.death(src)
						return
					moving=0
					step(src,dir)
					for(var/mob/M in oview(1))
						if(aff==M.aff)continue
						if(dir==SOUTH&&M.y<y||dir==NORTH&&M.y>y||dir==EAST&&M.x>x||dir==WEST&&M.x<x)
							if(M.illusion)
								M.illusionhit(src)
								continue
							flick("dynamic entry hit",src)
							faceme(M)
							M.stepback(4)
							M.stun(8)
							var/damage = apow*0.75
							if(level>=52)damage*=1.1
							if(shadowport)
								shadowport=0
								damage*=1.5
							if(M.clan=="Taijutsu Specialist")
								if(M.tier32)damage*=1-(M.tier32*0.05)
							M.dmgch(src, 1)
							damage = (damage*M.variable) + M.variable2
							M.damage(damage, 1.1 + (tier33*0.05))
							if(M)
								if(tier31)
									if(hp<maxhp)
										var/tmp/heal=(M.maxhp-M.hp)*(0.005*tier31)
										new/obj/heal(loc)
										hp+=heal
										if(hp>maxhp)hp=maxhp
										if(mybar)mybar:updatebar()
								if(level>=9)
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
								if(tier41)M.strengthpurolin(src)
								if(tier52)M.dynamichemorrhage(src,damage*(1.4+(tier33*0.05)))
								if(tier63&&M.hp<M.maxhp*(0.04*tier63))
									view(12)<<"<b><center><font color=silver>[src] executed [M] with Dynamic Entry!"
									M.damage(M.hp)
									M.death(src)
								else
									M.death(src)
						return
					spawn(1)goto loop
			fast=0
		//
		//
		hiddenlotus()
			prejutsu()
			if(cdelay5||snared||freeze||dead||caught||seals||stun||imitated||imitation||busy||lotus)return
			cdelay5=1
			var/sdelay=500*cdapow/100
			if(tier61&&hp<maxhp)
				sdelay-=tier61*10
				var/tmp/num=(maxhp-hp)/(200-(50*tier61))
				sdelay-=num*10
				if(sdelay<100)sdelay=100
			for(var/obj/jutsu/taijutsu/Hidden_Lotus/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)cdelay5=0
			if(tier53&&!hundredfists)hundredfists()
			busy = "hiddenlotus"
			stepup(8)
			spawn(15)
				if(busy == "hiddenlotus")
					busy = null
		hiddenlotuss(var/mob/M)
			M.lotus=1
			lotus=1
			var/damage = apow * 0.20
			if(level>=56)damage*=1.05
			if(shadowport)
				shadowport=0
				damage*=1.5
			if(M.clan=="Taijutsu Specialist")
				if(M.tier32)damage*=1-(M.tier32*0.05)
			M.dmgch(src, 1)
			damage = (damage*M.variable) + M.variable2
			critroll(M)
			var/random = rand(1, 100)
			if(tier22)random-=6*tier22
			if(tier41)M.strengthpurolin(src)
			//
			var/oldloc=loc
			var/punches=3
			if(level>=28)punches++
			punches+=round(attackdelay/100)
			loop
				if(punches&&!M.hosptime)
					punches--
					walk(M, 0)
					new/obj/flashstep(loc)
					var/list/Directions
					Directions = list(NORTH,SOUTH,WEST,EAST)
					Directions.Remove(dir)
					dir=pick(Directions)
					if(dir==NORTH)loc=locate(M.x,M.y-1,M.z)
					if(dir==EAST)loc=locate(M.x-1,M.y,M.z)
					if(dir==SOUTH)loc=locate(M.x,M.y+1,M.z)
					if(dir==WEST)loc=locate(M.x+1,M.y,M.z)
					new/obj/flashstep(loc)
					barloc()
					faceme(M)
					flick("attack",src)
					M.stepback(3)
					if(criticalroll >= random)
						M.damage(damage, 1.1 + (tier33*0.05))
					else
						M.damage(damage)
					if(tier31)
						if(hp<maxhp)
							var/tmp/heal=(M.maxhp-M.hp)*(0.005*tier31)
							new/obj/heal(loc)
							hp+=heal
							if(hp>maxhp)hp=maxhp
							if(mybar)mybar:updatebar()
					spawn(3)goto loop
				else
					if(intourn!=2)loc=oldloc
					barloc()
					new/obj/flashstep(loc)
					M.lotus=0
					lotus=0
					if(M)
						if(tier63&&M.hp<M.maxhp*(0.04*tier63))
							view(12)<<"<b><center><font color=silver>[src] executed [M] with Hidden Lotus!"
							M.damage(M.hp)
							M.death(src)
						else
							M.death(src)

		//
		//
		risingwind()
			prejutsu()
			if(cdelay6||swim||dead||stun||resting||caught||seals||busy||imitated||paralysed||lotus)return
			handseals(1,1,1)
			if(!sealpass)return
			cdelay6=1
			var/sdelay=400*(cdapow/100)
			if(level>=32)sdelay*=0.95
			if(tier61&&hp<maxhp)
				sdelay-=tier61*10
				var/tmp/num=(maxhp-hp)/(200-(50*tier61))
				sdelay-=num*10
				if(sdelay<100)sdelay=100
			for(var/obj/jutsu/taijutsu/Rising_Wind/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)cdelay6=0
			if(tier53&&!hundredfists)hundredfists()
			flick("rising wind",src)
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
			for(var/mob/player/M in get_step(src, T))
				if(aff==M.aff)continue
				if(M.illusion)
					M.illusionhit(src)
					continue
				if(tier63&&M.hp<M.maxhp*(0.04*tier63))
					view(12)<<"<b><center><font color=silver>[src] executed [M] with Rising Wind!"
					M.damage(M.hp)
					M.death(src)
					return
				if(level>=9)
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
				faceme(M)
				M.goup(src)
		goup(var/mob/M)
			if(dead)return
			var/times=0
			if(dir==EAST||dir==WEST)icon_state="dead"
			winded=1
			loop
				if(lotus)return
				if(times>=7)
					godown(M)
					return
				moving=0
				runstep=0
				var/P=dir
				if(dir==NORTH)
					step(src,SOUTH)
					goto tisk
				if(dir==SOUTH)
					step(src,NORTH)
					goto tisk
				if(dir==EAST)
					step(src,WEST)
					goto tisk
				if(dir==WEST)
					step(src,EAST)
					goto tisk
				tisk
				dir=P
				pixel_y+=25
				times++
				spawn(1)goto loop
		godown(var/mob/M)
			var/times=0
			var/damage=round(M.apow*1.25)
			if(M.level>=60)damage*=1.1
			if(M.shadowport)
				M.shadowport=0
				damage*=1.5
			if(clan=="Taijutsu Specialist")
				if(tier32)damage*=1-(tier32*0.05)
			dmgch(M,1)
			damage=(damage*variable)+variable2
			M.critroll(src)
			var/random = rand(1, 100)
			if(M.tier22)random-=6*M.tier22
			if(M.tier41)strengthpurolin(M)
			loop
				if(lotus)return
				if(times>=7)
					if(dir==EAST||dir==WEST)
						new/obj/taismash(loc)
					else
						new/obj/bigcrater(loc)
						new/obj/medic/groundcrack(loc)
					pixel_y=0
					icon_state=""
					if(winded)winded=0
					if(M.criticalroll >= random)
						damage(damage, 1.1 + (M.tier33*0.05))
					else
						damage(damage)
					if(M.tier31)
						if(M.hp<M.maxhp)
							var/tmp/heal=(maxhp-hp)*(0.005*M.tier31)
							new/obj/heal(M.loc)
							M.hp+=heal
							if(M.hp>M.maxhp)M.hp=M.maxhp
							if(M.mybar)M.mybar:updatebar()
					death(M)
					return
				if(times>=5)
					if(dir==EAST||dir==WEST)
						new/obj/taismash(loc)
					else
						new/obj/bigcrater(loc)
						new/obj/medic/groundcrack(loc)
				moving=0
				runstep=0
				var/P=dir
				if(dir==NORTH)
					step(src,SOUTH)
					goto tisk
				if(dir==SOUTH)
					step(src,NORTH)
					goto tisk
				if(dir==EAST)
					step(src,WEST)
					goto tisk
				if(dir==WEST)
					step(src,EAST)
					goto tisk
				tisk
				dir=P
				if(pixel_y!=0)pixel_y-=35
				times++
				spawn(1)goto loop
		//
		//
		morningpeacock()
			prejutsu()
			if(peacockdelay||swim||dead||stun||resting||caught||seals||busy||imitated||paralysed||lotus)return
			handseals(1,1,1)
			if(!sealpass)return
			peacockdelay=1
			var/sdelay=600*cdapow/100
			if(level>=36)sdelay*=0.90
			if(tier61&&hp<maxhp)
				sdelay-=tier61*10
				var/tmp/num=(maxhp-hp)/(200-(50*tier61))
				sdelay-=num*10
				if(sdelay<100)sdelay=100
			for(var/obj/jutsu/taijutsu/Morning_Peacock/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)peacockdelay=0
			if(tier53&&!hundredfists)hundredfists()
			flick("attack",src)
			for(var/mob/M in get_step(src,dir))
				if(aff==M.aff)continue
				if(M.illusion)
					M.illusionhit(src)
					continue
				peacock(M)
				return
			var/am = 4
			fast=1
			spawn(1)fast=0
			loop
				if(am)
					am --
					step(src,dir)
					for(var/mob/M in get_step(src,dir))
						if(aff==M.aff)continue
						if(M.illusion)
							M.illusionhit(src)
							continue
						EnterGates("View")
						if(tier63&&M.hp<M.maxhp*(0.04*tier63))
							flick("attack",src)
							view(12)<<"<b><center><font color=silver>[src] executed [M] with Morning Peacock!"
							M.damage(M.hp)
							M.death(src)
							return
						if(level>=9)
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
						peacock(M)
						return
					goto loop
		peacock(var/mob/M)
			faceme(M)
			var/damage = apow*0.25
			if(level>=64)damage*=1.1
			if(shadowport)
				shadowport=0
				damage*=1.5
			if(M.clan=="Taijutsu Specialist")
				if(M.tier32)damage*=1-(M.tier32*0.05)
			M.dmgch(src, 1)
			damage = (damage*M.variable) + M.variable2
			critroll(M)
			var/random = rand(1, 100)
			if(tier22)random-=6*tier22
			if(tier41)M.strengthpurolin(src)
			var/times=4
			M.stun(8)
			stun(8)
			loop
				if(times&&!M.hosptime)
					times--
					flick("attack",src)
					if(criticalroll >= random)
						M.damage(damage, 1.1 + (tier33*0.05))
					else
						M.damage(damage)
					if(M)
						if(tier31)
							if(hp<maxhp)
								var/tmp/heal=(M.maxhp-M.hp)*(0.005*tier31)
								new/obj/heal(loc)
								hp+=heal
								if(hp>maxhp)hp=maxhp
								if(mybar)mybar:updatebar()
						M.death(src)
					spawn(2)goto loop
				else
					flick("attack",src)
					faceme(M)
					M.stepback(4)
					new/obj/medic/groundcrack(M.loc)
					M.peacockignite(src)
		peacockignite(var/mob/M)
			if(!M)
				return
			if(aff == M.aff)
				return
			var/damage = M.apow*0.18
			if(M.level>=64)damage*=1.1
			if(clan=="Taijutsu Specialist")if(tier32)damage*=1-(tier32*0.05)
			dmgch(M, 1)
			damage = (damage*variable) + variable2
			var/times=5
			peacocking=1
			ovcheck()
			loop
				if(times)
					times--
					if(M.tier31)
						if(M.hp<M.maxhp)
							var/tmp/heal=(maxhp-hp)*(0.005*M.tier31)
							new/obj/heal(M.loc)
							M.hp+=heal
							if(M.hp>M.maxhp)M.hp=M.maxhp
							if(M.mybar)M.mybar:updatebar()
					damage(damage)
					death(M)
					spawn(10)goto loop
				else
					peacocking=0
					ovcheck()
		//
		strengthpurolin(var/mob/M)
			purolin=1
			M.purolin=2
			atkdef()
			M.atkdef()
			spawn(30*M.tier41)
				purolin=0
				M.purolin=0
				atkdef()
				M.atkdef()
		hundredfists()
			hundredfists=1
			forceupdate()
			spawn(50)
				hundredfists=0
				forceupdate()
		//
		//
		primarylotus()
			prejutsu()
			if(cdelay3||swim||dead||stun||resting||caught||seals||busy||imitated||paralysed||lotus||freeze)return
			cdelay3 = 1
			var/sdelay = 450*cdapow/100
			if(level>=48)sdelay*=0.90
			if(tier61&&hp<maxhp)
				sdelay-=tier61*10
				var/tmp/num=(maxhp-hp)/(200-(50*tier61))
				sdelay-=num*10
				if(sdelay<100)sdelay=100
			for(var/obj/jutsu/taijutsu/Primary_Lotus/M in src)timerjutsu(sdelay, M)
			spawn(sdelay)cdelay3=0
			if(tier53&&!hundredfists)hundredfists()
			for(var/mob/player/M in get_step(src,dir))
				if(aff==M.aff||M.shield)continue
				if(M.illusion)
					M.illusionhit(src)
					continue
				flick("rising wind",src)
				faceme(M)
				M.lotusup(src)
				return
			stun = 1
			icon_state = "jutsu"
			busy = "lotus"
			spawn(10)
				if(busy == "lotus")
					busy = null
					icon_state= ""
					stun = 0
			var/obj/bandage/K = new(loc)
			K.owner = src
			K.dir = dir
			step(K,K.dir)
			walk(K,K.dir)
			for(var/obj/bandagetrail/M in loc)M.icon_state = "begin"
		bandaged(var/obj/T, var/mob/M)
			T.freeze = 1
			M.freeze = 1
			src.busy = "lotushit"
			stun = 1
			M.stun = 1
			spawn()src.bandagedash(get_dist(M, src) + 3)
			spawn(20)
				if(!lotushit)
					M.freeze = 0
					freeze = 0
					stun = 0
					M.stun = 0
					for(var/obj/U in src.Bandages)del U

		bandagedash(K)
			fast = 1
			for(var/obj/bandagetrail/M in loc)del M
			density = 0
			loop
				if(K)
					K --
					flick("attack",src)
					for(var/mob/M in get_step(src,dir))
						density = 1
						K = 1
						flick("rising wind",src)
					var/obj/image = new/obj/kimage(loc)
					image.dir = dir
					image.icon = icon
					image.overlays = overlays
					image.invisibility = invisibility
					moving = 0
					step(src, dir)
					for(var/mob/M in get_step(src,dir))
						density = 1
						K = 1
						flick("rising wind",src)
					for(var/obj/bandagetrail/M in loc)del M
					spawn(1)goto loop
				else
					for(var/obj/M in src.Bandages)del M
			fast = 0
		lotusup(var/mob/M)
			if(dead)return
			var/times=0
			M.barloc()
			barloc()
			M.freeze=1
			loop
				if(times>=7)
					M.loc=loc
					M.pixel_y=pixel_y
					if(dir==EAST)M.dir=WEST
					if(dir==WEST)M.dir=EAST
					if(dir==NORTH)M.dir=SOUTH
					if(dir==SOUTH)M.dir=NORTH
					var/obj/K=new/obj/lotus(loc)
					K.pixel_x+=pixel_x
					K.pixel_y+=pixel_y
					lotusdown(M,K)
					return
				pixel_y+=25
				times++
				spawn(1)goto loop
		lotusdown(var/mob/M,var/obj/K)
			var/times=0
			var/damage=M.apow
			if(M.level>=20)damage*=1.1
			if(M.shadowport)
				M.shadowport=0
				damage*=1.5
			if(clan=="Taijutsu Specialist")
				if(tier32)damage*=1-(tier32*0.05)
			dmgch(M,1)
			damage=(damage*variable)+variable2
			M.critroll(src)
			var/random = rand(1, 100)
			if(M.tier22)random-=6*M.tier22
			if(M.tier41)strengthpurolin(M)
			loop
				if(times>=7)
					spawn(3)
						M.EnterGates("Opening")
						freeze=0
						M.freeze=0
						stun=0
						M.stun=0
						M.barloc()
						barloc()
						M.stun(3)
						stun(3)
						M.stepback(3)
						stepback(3)
						if(M.criticalroll >= random)
							damage(damage, 1.1 + (M.tier33*0.05))
						else
							damage(damage)
						if(M.tier31)
							if(M.hp<M.maxhp)
								var/tmp/heal=(maxhp-hp)*(0.005*M.tier31)
								new/obj/heal(M.loc)
								M.hp+=heal
								if(M.hp>M.maxhp)M.hp=M.maxhp
								if(M.mybar)M.mybar:updatebar()
						if(M.level>=9)
							if(istype(src,/mob/player))
								if(M.strongfist==src)
									if(M.crippled=="")
										M.strongfistc++
										M.relentless(1)
										if(M.strongfistc==3)
											M.strongfistc=0
											M.relentless(-3)
											M.crippled(src)
								else
									M.strongfistc=1
									M.relentless(0,1)
									M.strongfist=src
						if(M.tier63&&hp<maxhp*(0.04*M.tier63))
							view(12)<<"<b><center><font color=silver>[M] executed [src] with Primary Lotus!"
							damage(hp)
							death(M)
						else
							snared(20,2)
							confusion(20)
							death(M)
					del K
					new/obj/medic/groundcrack(loc)
					new/obj/bigcrater(loc)
					pixel_y=0
					M.pixel_y=0
					M.lotushit = 0
					return
				pixel_y-=25
				M.pixel_y-=25
				K.pixel_y-=25
				times++
				spawn(1)goto loop
obj
	bandage
		icon = 'bandage.dmi'
		animate_movement = 0
		layer = 15
		var/moved = 0
		density=1
		Bump(A)
			if(istype(A,/mob/player))
				var/mob/O=owner
				var/mob/D=A
				if(O.aff == D.aff || D.shield)
					loc = D.loc
					return
				if(D.clone)
					loc=D.loc
					del D
					return
				if(D.winded)
					loc=D.loc
				else
					walk(src,0)
					icon_state = "bind"
					loc = D.loc
					density = 0
					spawn()O.bandaged(src, D)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					del(src)
		Move()
			var/obj/T = new/obj/bandagetrail(loc)
			T.dir = dir
			T.owner = owner
			owner.Bandages += T
			..()
			moved ++
			if(moved >= 10 && !freeze)del src
		Del()
			for(var/obj/bandagetrail/M in range(12, src))
				if(M.owner == owner)del M
			owner.busy = null
			owner.icon_state = ""
			owner.stun = 0
			..()
	bandagetrail
		icon='bandage.dmi'
		density=0
		layer=15
	gatesaura
		icon='gates.dmi'
		layer=30
		pixel_y=-36
		pixel_x=-32
	taismash
		pixel_x=-110
		layer=21
		icon='taismash.dmi'
		icon_state="null"
		New()
			flick("Explosion",src)
			spawn(9)del src
	lotus
		pixel_x=-16
		pixel_y=-16
		layer=100
		icon='lotus.dmi'



