mob/var/ClematisHits = list()
mob
	proc
		kaguyaleveling()
			if(level==6)
				src<<"<b><font color=lime><b>You have learned Dance of the Willow! This dance makes you strike everyone around you in a rapid series of slashes, pushing them back."
				new/obj/jutsu/kaguya/Dance_of_the_Willow(src)
			if(level==13)src<<"<b><font color=lime>Your Dance of the Willow is now level 2! It now has a 20% higher chance to critically strike. Critical strikes deal 50% more damage."
			if(level==80)src<<"<b><font color=lime>You have mastered Dance of the Willow! It now pushes back farther and has a slightly longer range!"
			if(level==2)
				src<<"<b><font color=lime>You have learned your first kaguya dance, Dance of the Camellia. The dance causes you to dash instantly, striking everyone in front in a wide area. You deal extra damage if you hit them directly, and deal even more damage if you hit them from behind. People hit by this are slowed for 2 seconds."
				new/obj/jutsu/kaguya/Dance_of_the_Camellia(src)
			if(level==10)src<<"<b><font color=lime>Your Dance of the Camellia is now level 2! You dash further now!"
			if(level==18)
				src<<"<b><font color=lime>You have learned Dance of the Pines! This dance creates spearlike bones around you, increasing defense by 30%."
				new/obj/jutsu/kaguya/Dance_of_the_Pines(src)
			if(level==20)src<<"<b><font color=lime>Your Dance of the Camellia is now level 3! It now does 30% more damage!"
			if(level==25)
				src<<"<b><font color=lime>You have learned Snap Regeneration! This move instantly regenerates your bone reserve to max."
				new/obj/jutsu/kaguya/Snap_Regeneration(src)
			if(level==30)src<<"<b><font color=lime>Your Dance of the Pines is now level 2! It now last longer!"
			if(level==35)src<<"<b><font color=lime>You have learned Bone Bullets! Your throw button now shoots out bullets of hardened bones from your fingertips. They have the damage and speed of kunais, aiming capabilities of shurikens and pierces."
			if(level==48)src<<"<b><font color=lime>You have mastered Dance of the Camellia! It now costs 10 less bone resource!"
			if(level==55)
				src<<"<b><font color=lime>You have learned your fifth dance, Dance of the Clematis! This deadly dance lets you throw your spine as a whip. Once you strike someone with the whip you will bind them and devastate them with a bone drill. This ability always critically strike."
				new/obj/jutsu/kaguya/Dance_of_the_Clematis(src)
			if(level==60)src<<"<b><font color=lime>Your Bone Bullets is now level 2! You now regenerate 5 bone resource if you hit an enemy with your bullets!"
			if(level==70)
				src<<"<b><font color=lime><b>You have learned your final clan jutsu, Dance of the Seedling Ferns! This jutsu uses a massive amount of bone reserve to create a forest of bones that rends all that gets in its way. You move around in your ferns."
				new/obj/jutsu/kaguya/Dance_of_the_Seedling_Ferns(src)
			if(level==75)src<<"<b><font color=lime>Your Dance of the Clematis is now level 2! It now deals 50% more damage to enemies under 65% health!"
			if(level==80)src<<"<b><font color=lime>You have mastered Dance of the Willow! It now strike further!"
			if(level==82)src<<"<b><font color=lime>You have mastered Dance of the Pines! It now increase your defense by 40%!"
			if(level==90)src<<"<b><font color=lime>You have mastered Bone Bullets! You can now rapid fire them!"
			if(level==100)src<<"<b><font color=lime>You have mastered Snap Regeneration! It now doubles your bone regeneration speed for 10 seconds after using this ability!"
			if(level==110)src<<"<b><font color=lime>You have mastered Dance of the Clematis! It now does double damage to enemies under 35% health!"
			if(level==120)src<<"<b><font color=lime>You have mastered Dance of the Seedling Fern! It is now wider!"

		camellia()
			prejutsu()
			if(cdelay1||swim||dead||imitated||paralysed||stun||caught||seals||busy||weapon!=/obj/bonesword&&weapon!=/obj/boneknife)return
			var/ccost=50
			if(level>=48)ccost-=10
			if(ccost>energy)return
			cdelay1=1
			energy-=ccost
			energyrefresh()
			var/sdelay=150*cdapow/100
			if(tier52)sdelay*=1-0.1*tier52
			for(var/obj/jutsu/kaguya/Dance_of_the_Camellia/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)cdelay1=0
			if(tier21)
				invisibility+=3
				var/image/I=image('baseinvis.dmi',src)
				src << I
				barloc()
				spawn(tier21*3)
					invisibility -= 3
					del I
					barloc()
			flick("attack",src)
			for(var/mob/M in oview(1))
				if(aff==M.aff)continue
				if(dir==SOUTH&&M.y<y||dir==NORTH&&M.y>y||dir==EAST&&M.x>x||dir==WEST&&M.x<x)
					var/obj/L=new/obj/camelliahit(loc)
					var/obj/L2=new/obj/camelliahit(loc)
					var/obj/L3=new/obj/camelliahit(loc)
					step(L,dir)
					step(L2,dir)
					step(L3,dir)
					flick("1",L2)
					flick("2",L3)
					flick("0",L)
					if(dir==NORTH||dir==SOUTH)
						L2.x++
						L3.x--
					if(dir==EAST||dir==WEST)
						L2.y--
						L3.y++
					if(M.illusion)
						M.illusionhit(src)
						continue
					var/damage=apow*0.35
					if(M.clan=="Taijutsu Specialist")
						if(M.tier32)damage*=1-(M.tier32*0.05)
					if(x==M.x||y==M.y)damage*=1.5
					if(dir==M.dir)damage*=2
					M.dmgch(src,1)
					damage=(damage*M.variable)+M.variable2
					if(level>=20)damage*=1.3
					critroll(M)
					var/random=rand(1,100)
					if(tier52)random-=tier52*5
					if(criticalroll>=random)
						M.damage(damage,1.5)
					else
						M.damage(damage)
					new/obj/willowslash(M.loc)
					if(tier13)
						new/obj/statuspop/cleave(M.loc)
						spawn()if(M)if(!M.kagcleave)M.bleedingkag(src)
					if(M)
						if(!M in src.ClematisHits)M.addtolist(src)
						M.snared(20,3)
						M.death(src)
					return
			var/am=2
			if(level>=10)am=4
			new/obj/flashstep(loc)
			fast=1
			spawn(1)fast=0
			loop
				if(am)
					am--
					step(src,dir)
					for(var/mob/M in oview(1))
						if(aff==M.aff)continue
						if(dir==SOUTH&&M.y<y||dir==NORTH&&M.y>y||dir==EAST&&M.x>x||dir==WEST&&M.x<x)
							var/obj/L=new/obj/camelliahit(loc)
							var/obj/L2=new/obj/camelliahit(loc)
							var/obj/L3=new/obj/camelliahit(loc)
							step(L,dir)
							step(L2,dir)
							step(L3,dir)
							flick("1",L2)
							flick("2",L3)
							flick("0",L)
							if(dir==NORTH||dir==SOUTH)
								L2.x++
								L3.x--
							if(dir==EAST||dir==WEST)
								L2.y--
								L3.y++
							if(M.illusion)
								M.illusionhit(src)
								continue
							var/damage=apow*0.35
							if(M.clan=="Taijutsu Specialist")
								if(M.tier32)damage*=1-(M.tier32*0.05)
							if(x==M.x||y==M.y)damage*=1.5
							if(dir==M.dir)damage*=2
							M.dmgch(src,1)
							damage=(damage*M.variable)+M.variable2
							if(level>=20)damage*=1.3
							critroll(M)
							var/random=rand(1,100)
							if(tier52)random-=tier52*5
							if(criticalroll>=random)
								M.damage(damage,1.5)
							else
								M.damage(damage)
							new/obj/willowslash(M.loc)
							if(tier13)
								new/obj/statuspop/cleave(M.loc)
								spawn()if(M)if(!M.kagcleave)M.bleedingkag(src)
							if(M)
								if(!M in src.ClematisHits)M.addtolist(src)
								M.snared(20,3)
								M.death(usr)
							return
					goto loop
			var/obj/L=new/obj/camelliahit(loc)
			var/obj/L2=new/obj/camelliahit(loc)
			var/obj/L3=new/obj/camelliahit(loc)
			step(L,dir)
			step(L2,dir)
			step(L3,dir)
			flick("1",L2)
			flick("2",L3)
			flick("0",L)
			if(dir==NORTH||dir==SOUTH)
				L2.x++
				L3.x--
			if(dir==EAST||dir==WEST)
				L2.y--
				L3.y++
		addtolist(var/mob/M)
			M.ClematisHits+=src
			spawn(30)M.ClematisHits-=src
		willow()
			prejutsu()
			if(swim||cdelay2||dead||imitated||paralysed||stun||caught||seals||busy||weapon!=/obj/bonesword&&weapon!=/obj/boneknife)
				return
			var/ccost = 50
			if(tier32)
				ccost *= 1-(0.05*tier32)
			if(ccost > energy)
				return
			var/sdelay = 90*cdapow/100
			cdelay2 = 1
			for(var/obj/jutsu/kaguya/Dance_of_the_Willow/J in src)
				timerjutsu(sdelay, J)
			spawn(sdelay)
				cdelay2 = 0
			busy = "stun"
			stun(5)
			spawn(10)
				busy = ""
			energy -= ccost
			energyrefresh()
			var/obj/himage/T1 = new(loc)
			var/obj/himage/T2 = new(loc)
			var/obj/himage/T3 = new(loc)
			var/obj/himage/T4 = new(loc)
			for(var/obj/himage/G in loc)
				G.owner = src
				G.icon = icon
				G.layer = layer
				G.overlays = overlays
				spawn(7)
					del G
			T1.dir = WEST
			T2.dir = EAST
			T3.dir = NORTH
			T4.dir = SOUTH
			spawn(1)
				flick("attack", T1)
				flick("attack", T2)
				flick("attack", T3)
				flick("attack", T4)
			var/Hits = list()
			for(var/mob/M in range(1, src))
				Hits += M
			if(level >= 80)
				for(var/mob/M in range(2, src))
					var/search = 1
					if(get_dist(src, M) >= 2)
						var/turf/t = M.loc
						while(search)
							t = get_step(t, NORTH)
							t = get_step(t, NORTH)
							if(t == src.loc)
								Hits += M
							t = M.loc
							t = get_step(t, EAST)
							t = get_step(t, EAST)
							if(t == src.loc)
								Hits += M
							t = M.loc
							t = get_step(t, SOUTH)
							t = get_step(t, SOUTH)
							if(t == src.loc)
								Hits += M
							t = M.loc
							t = get_step(t, WEST)
							t = get_step(t, WEST)
							if(t == src.loc)
								Hits += M
							search = 0
					else
						continue
			for(var/mob/M in Hits)
				if(aff == M.aff)
					continue
				if(M.illusion)
					M.illusionhit(src)
					continue
				M.dir = get_dir(M, src)
				if(M.dir == NORTHEAST)
					if(src.dir == SOUTH)
						M.dir = NORTH
					if(src.dir == EAST)
						M.dir = EAST
					if(src.dir == WEST)
						M.dir = EAST
				if(M.dir == NORTHWEST)
					if(src.dir == SOUTH)
						M.dir = NORTH
					if(src.dir == EAST)
						M.dir = WEST
					if(src.dir == WEST)
						M.dir = WEST
				if(M.dir == SOUTHEAST)
					if(src.dir == NORTH)
						M.dir = SOUTH
					if(src.dir == EAST)
						M.dir = EAST
					if(src.dir == WEST)
						M.dir = EAST
				if(M.dir == SOUTHWEST)
					if(src.dir == NORTH)
						M.dir = SOUTH
					if(src.dir == EAST)
						M.dir = WEST
					if(src.dir == WEST)
						M.dir = WEST
				var/damage = apow * 0.60
				if(M.clan=="Taijutsu Specialist")
					if(M.tier32)damage*=1-(M.tier32*0.05)
				M.dmgch(src, 1)
				damage = (damage*M.variable) + M.variable2
				if(tier32)
					damage *= 1+(0.15*tier32)
				critroll(M)
				var/random = rand(1, 100)
				if(level >= 13)
					random -= 20
				if(tier52)
					random -= tier52*5
				if(level >= 80)
					M.stepback(3)
				else
					M.stepback(2)
				if(criticalroll >= random)
					M.damage(damage, 1.5)
				else
					M.damage(damage)
				new/obj/willowslash(M.loc)
				if(tier13)
					new/obj/statuspop/cleave(M.loc)
					spawn()
						if(M)
							if(!M.kagcleave)
								M.bleedingkag(src)
				if(M)
					if(M in src.ClematisHits&&clan=="Kaguya")
						if(hp<maxhp)
							var/heal=(maxhp-hp)*0.03
							heal*=1.5
							new/obj/heal(loc)
							hp+=heal
							if(hp>maxhp)hp=maxhp
							if(mybar)mybar:updatebar()
					M.death(usr)

		pines()
			prejutsu()
			if(swim||dead||stun||cdelay3||imitated||paralysed||resting||caught||seals||busy||freeze)return
			var/ccost=50
			if(tier41)ccost*=1-0.2*tier41
			if(ccost>energy)return
			handseals(60,0,1)
			if(!sealpass)return
			energy-=ccost
			energyrefresh()
			cdelay3=1
			pines++
			var/pine=56
			if(level>=30)
				pine = 70
			if(level>=82)
				pines ++
			pine += tier41*14
			ovcheck()
			atkdef()
			spawn(pine)
				pines=0
				ovcheck()
				atkdef()
			var/sdelay=460*cdapow/100
			if(tier52)sdelay*=1-0.1*tier52
			for(var/obj/jutsu/kaguya/Dance_of_the_Pines/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)cdelay3=0

		clematis()
			prejutsu()
			if(cdelay5||swim||dead||stun||resting||caught||seals||busy||imitated||paralysed)
				return
			if(65 > energy)
				return
			handseals(70, 0, 1, 1)
			if(!sealpass)
				return
			cdelay5 = 1
			energy -= 65
			energyrefresh()
			stun = 1
			icon_state = "jutsu"
			busy = "snake"
			var/sdelay = 320*cdapow/100
			if(tier52)
				sdelay *= 1-0.1*tier52
			for(var/obj/jutsu/kaguya/Dance_of_the_Clematis/M in src)
				timerjutsu(sdelay, M)
			spawn(sdelay)cdelay5=0
			spawn(6)
				if(busy == "snake")
					busy = null
					icon_state= ""
					stun = 0
			var/obj/proj/bonewhip/K = new(loc)
			K.owner = usr
			K.dir = dir
			step(K, dir)
			if(K)
				K.movequick(dir)
			for(var/obj/proj/bonewhiptrail/M in loc)
				M.icon_state = "begin"

		bonewhipped(var/obj/whip, var/mob/target)
			whip.freeze = 1
			if(!target.freeze)
				target.freeze = 1
			src.overlays += /obj/bonedrill
			src.icon_state = "spear"
			src.busy = "drill"
			spawn()
				src.stepup(4 + get_dist(target, src))
			for(var/obj/proj/bonewhiptrail/M in range(20, src))
				if(M.owner == src)
					del M
			spawn(10)
				src.busy = null
				src.overlays -= /obj/bonedrill
				src.icon_state = ""
				src.stun = 0
			spawn(14)
				if(target)
					target.freeze = 0
					target.death(src)
				del whip

		snapregen()
			prejutsu()
			if(wpalming||swim||dead||stun||caught||seals||busy||imitated||paralysed)return
			handseals(130+maxenergy*2.5-energy*2.5,0,1)
			if(!sealpass)return
			view(8)<<"<b><center>[src] used snap regeneration!"
			wpalming=1
			energy=maxenergy
			energyrefresh()
			new/obj/statuspop/snapregen(loc)
			if(level>=100)
				var/obj/statuseffect/t=new/obj/statuseffect/snapregen
				t.screen_loc="14,16"
				client.screen+=t
				seffect(100,t)
				wpalming=2
				spawn(140)wpalming=1
			var/sdelay=600
			if(tier52)sdelay*=1-0.1*tier52
			for(var/obj/jutsu/kaguya/Snap_Regeneration/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)wpalming=0

		seedlingferns()
			prejutsu()
			if(kyuubimode)
				src<<"<center>Kyuubi locks the usage of this jutsu with his dark power."
				return
			var/euse=100
			if(tier62)euse*=1-0.2*tier62
			if(cdelay6||energy<euse||swim||dead||stun||caught||seals||busy||imitated||paralysed)return
			handseals(100,0)
			if(!sealpass)return
			cdelay6=1
			stun=1
			fernzing=1
			spawn(150)fernzing=0
			energy-=euse
			energyrefresh()
			busy="stun"
			view(8)<<"<b><font color=silver>[usr]: Dance of the Seedling Ferns!"
			icon_state="jutsu"
			sleep(5)
			icon_state=""
			stun=0
			busy=null
			var/obj/proj/Bone_Creation/A=new(loc)
			var/obj/proj/Bone_Creation/B=new(loc)
			var/obj/proj/Bone_Creation/C=new(loc)
			var/obj/proj/Bone_Creation/D=new(loc)
			var/obj/proj/Bone_Creation/E=new(loc)
			for(var/obj/proj/Bone_Creation/M in loc)M.owner=usr
			A.loc=loc
			if(dir==NORTH||dir==SOUTH)
				B.loc=locate(x+1,y,z)
				C.loc=locate(x-1,y,z)
				D.loc=locate(x+2,y,z)
				E.loc=locate(x-2,y,z)
			if(dir==EAST||dir==WEST)
				B.loc=locate(x,y+1,z)
				C.loc=locate(x,y-1,z)
				D.loc=locate(x,y+2,z)
				E.loc=locate(x,y-2,z)
			for(var/obj/proj/Bone_Creation/M in oview(2))if(M.owner==usr)walk(M,dir)
			if(level>=120)
				var/obj/proj/Bone_Creation/F=new(loc)
				var/obj/proj/Bone_Creation/G=new(loc)
				for(var/obj/proj/Bone_Creation/M in loc)M.owner=usr
				if(dir==NORTH||dir==SOUTH)
					F.loc=locate(x+3,y,z)
					G.loc=locate(x-3,y,z)
				if(dir==EAST||dir==WEST)
					F.loc=locate(x,y+3,z)
					G.loc=locate(x,y-3,z)
			for(var/obj/proj/Bone_Creation/M in oview(3))if(M.owner==usr)walk(M,dir)
			var/sdelay=1200*cdapow/100
			if(tier52)sdelay*=1-0.1*tier52
			for(var/obj/jutsu/kaguya/Dance_of_the_Seedling_Ferns/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)cdelay6=0

		bloodlust()
			prejutsu()
			if(lusted||swim||dead||stun||caught||seals||busy||imitated||paralysed)return
			handseals(200+maxenergy*3-energy*3,0,1)
			if(!sealpass)return
			view(8)<<"<b><center><font color=red>[src] goes into a blood-crazed trance!"
			lusted=3
			ovcheck()
			new/obj/statuspop/bloodlust(loc)
			var/obj/statuseffect/t=new/obj/statuseffect/bloodlust
			t.screen_loc="15,15"
			client.screen+=t
			seffect(100,t)
			spawn(140)
				lusted=2
				ovcheck()
			var/obj/statuseffect/t2=new/obj/statuseffect/recklessness
			debuffcount(200)
			t2.screen_loc="[7+debuffa],16"
			client.screen+=t2
			seffect(200,t2)
			spawn(200)lusted=1
			var/sdelay=2520
			for(var/obj/jutsu/kaguya/Bloodlust/M in src)timerjutsu(2520,M)
			spawn(sdelay)lusted=0

		doubleblades()
			if(dead||imitated||paralysed||caught||seals||busy)return
			if(stancing)return
			stancing=1
			spawn(10)stancing=0
			if(stance=="Double Blades")
				stance="None"
				forceupdate()
				new/obj/statuspop/normalstance(loc)
				for(var/obj/statuseffect/stance/M in client.screen)del M
				overlay()
				iconrefresh()
				return
			if(stance!="None")for(var/obj/statuseffect/stance/M in client.screen)del M
			stance="Double Blades"
			forceupdate()
			overlay()
			iconrefresh()
			new/obj/statuspop/doubleblades(loc)
			var/obj/statuseffect/t=new/obj/statuseffect/stance/doubleblades
			t.screen_loc="20,20"
			client.screen+=t

		extremecondensing()
			if(dead||imitated||paralysed||caught||seals||busy)return
			if(stancing)return
			stancing=1
			spawn(10)stancing=0
			if(stance=="Extreme Condensing")
				stance="None"
				forceupdate()
				new/obj/statuspop/normalstance(loc)
				for(var/obj/statuseffect/stance/M in client.screen)del M
				overlay()
				iconrefresh()
				return
			if(stance!="None")for(var/obj/statuseffect/stance/M in client.screen)del M
			stance="Extreme Condensing"
			forceupdate()
			overlay()
			iconrefresh()
			new/obj/statuspop/extremecondensing(loc)
			var/obj/statuseffect/t=new/obj/statuseffect/stance/extremecondensing
			t.screen_loc="20,20"
			client.screen+=t

		bonegolem()
			if(bonegolemdelay||dead||imitated||paralysed||caught||seals||busy)return
			bonegolemdelay=1
			var/sdelay=800
			for(var/obj/jutsu/kaguya/Bone_Golem/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)bonegolemdelay=0
			bonegolem=1
			overlay()
			iconrefresh()
			atkdef()
			regenupdate()
			spawn(57*tier53)
				bonegolem=0
				overlay()
				iconrefresh()
				atkdef()
				regenupdate()
mob/var/
	bonegolemdelay=0
	bonegolem=0
	fernzing=0
obj/camelliahit
	icon='camelliaslash.dmi'
	layer=80
	New()
		..()
		spawn(7)del src
