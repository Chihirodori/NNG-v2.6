obj
	empty
		rundelay=0
		density=1
		projint=1
		Bump(mob/A)
			..()
			if(ismob(A))
				if(owner.aff==A.aff)
					loc=A.loc
					return
				var/s=14
				if(owner.level>=22||owner.clan=="Copy Ninja")s+=14
				owner.faceme(A)
				if(owner.level<70&&owner.clan!="Copy Ninja")
					A.stepback(1,2)
				else
					if(A.illusion)
						A.illusionhit(owner)
						loc=A.loc
						return
					new/obj/crater(A.loc)
					var/damage=owner.apow*0.55
					if(A.clan=="Taijutsu Specialist")
						if(A.tier32)damage*=1-(A.tier32*0.05)
					A.dmgch(owner,1)
					damage=(damage*A.variable)+A.variable2
					A.damage(damage)
					A.death(owner)
				if(A)
					A.snared(s,1)
					A.snared(s*0.3,1)
					A.snared(s*0.5,1)
					A.snared(s*0.7,1)
				if(owner.level<70&&owner.clan!="Copy Ninja")del src
				else if(A)loc=A.loc
			if(istype(A,/turf/))del src
			if(istype(A,/obj/))projduel(A)
mob
	proc
		hyuugaleveling()
			if(level==2)
				src<<"<b><font color=lime>You have learned Byakugan! This eye jutsu is the most important jutsu for Hyuugas. This allows you to see people from up to 20 tiles, see their chakra if they're hiding and is required for your other jutsus to work. You gain increased accuracy, critical strike rate, attack power, taijutsu cooldown reduction, and slow reduction while this is active."
				new/obj/jutsu/hyuuga/Byakugan(src)
			if(level==5)
				src<<"<b><font color=lime><b>You have learned Rotation! This lets you use your advanced chakra control to create a spinning chakra barrier around you, shielding you from all damage and causing damage to enemies around you every second."
				new/obj/jutsu/hyuuga/Rotation(src)
			if(level==8)
				src<<"<b><font color=lime><b>You have learned Empty Palm! This move knocks back a enemy in front of you and slows them heavily. If they are directly in front of you they will also get hit for heavy damage."
				new/obj/jutsu/hyuuga/Empty_Palm(src)
			if(level==12)
				src<<"<b><font color=lime><b>You have learned Lion Palm! This move dashes you forward, striking targets in front of you, preventing them from performing jutsus for 1 second."
				new/obj/jutsu/hyuuga/Lion_Palm(src)
			if(level==18)src<<"<font size=2><b><font color=lime>Rotation is now level 2! It now destroys all clones near you."
			if(level==22)src<<"<font size=2><b><font color=lime>Empty Palm is now level 2! The slow is now 2 seconds."
			if(level==28)
				src<<"<font size=2><b><font color=lime>Lion Palm is now level 2! The silence now lasts 2 seconds."
			if(level==32)
				src<<"<b><font color=lime>You have learned your fifth clan move, Mountain Crusher. This move will let you charge up chakra to hit the person in front of you for extreme damage. It will always critically strike."
				new/obj/jutsu/hyuuga/Mountain_Crusher(src)
			if(level==35)
				if(byakugan)
					byakugan++
					forceupdate()
				src<<"<b><font color=lime><b>Your Byakugan has matured! It now allows you to track further and you gain extra attack speed, accuracy, critical strike rate, attack power, taijutsu cooldown reduction, and slow reduction."
			if(level==40)src<<"<font size=2><b><font color=lime>You have mastered Rotation! When you deactivate this jutsu it knocks back and stuns briefly everyone around you!"
			if(level==45)src<<"<font size=2><b><font color=lime>Empty Palm level is now level 3! The range of its effect inreased."
			if(level==50)
				src<<"<font size=2><b><font color=lime>You have mastered Lion Palm! You also slow the enemy when you silence!"
			if(level==60)
				src<<"<b><font color=lime>You have learned your sixth clan move, Eight Trigrams Sixty Four Palms. This move will create a large circle and everyone that is caught in it will get their chakra nodes clogged, disabling their ability to perform jutsus temporarily."
				new/obj/jutsu/hyuuga/Sixty_Four_Palms(src)
			if(level==65)src<<"<font size=2><b><font color=lime>Mountain Crusher is now level 2! You will cause a slowing shockwave if you land this ability on a enemy that's already slowed."
			if(level==70)src<<"<font size=2><b><font color=lime>You have mastered Empty Palm! You learned to channel your energy downwards, making your empty palm smash your enemies into the ground, instead of knocking them back you deal heavy damage and incapacitate everyone in your path for 2 seconds."
			if(level==75)src<<"<font size=2><b><font color=lime>Mountain Crusher level is now level 3! It now deals a extra 12% of the enemy's missing health in damage."
			if(level==80)src<<"<font size=2><b><font color=lime>Eight Trigrams Sixty Four Palms is now level 2! Enemies are also slowed down while they are silenced."
			if(level==85)src<<"<font size=2><b><font color=lime>You have mastered Mountain Crusher! The cooldown has decreased by 30%."
			if(level==95)
				if(byakugan)
					byakugan++
					forceupdate()
				src<<"<b><font color=lime><b>Your Byakugan is now mastered! Your radar now lets you view a massive area and your critical strike chance, accuracy, dodge rate, attack speed, slow reduction, attack power, and critical strike rate increased."
			if(level==105)src<<"<font size=2><b><font color=lime>Eight Trigrams Sixty Four Palms is now mastered! The startup time decreased dramatically."
		rapidpalmstack()
			if(!rapidtime)
				spawn()rapidash()
			rapidtime=3
			if(rapidstack<10)
				rapidstack++
				relentless(1)
				attackdelay+=15*tier53
		rapidash()
			rapidtime=3
			sleep(10)
			while(rapidtime&&stance=="Rapid Palms")
				rapidtime--
				sleep(10)
			if(stance == "Rapid Palms")
				attackdelay -= 15*tier53*rapidstack
			rapidstack=0
			rapidtime=0
			relentless=0
			relentless(0)
		byakugan()
			hengeback()
			cloakoff()
			if(swim||dead||stun||resting||caught||seals||moving||dous||busy||imitated||paralysed)return
			dous=1
			for(var/obj/jutsu/hyuuga/Byakugan/M in src)M.overlays+='timer.dmi'
			spawn(42)
				for(var/obj/jutsu/hyuuga/Byakugan/M in src)M.overlays-='timer.dmi'
				dous=0
			if(!byakugan)
				new/obj/eyeac(loc)
				byakugan++
				range(12)<<"<font color=silver><b>[usr]: Byakugan!"
				if(level>=35)
					byakugan++
				if(level>=95)
					byakugan++
				var/obj/statuseffect/t=new/obj/statuseffect/eyejutsu/byakugan
				forceupdate()
				t.screen_loc="19,20"
				client.screen+=t
				soundeff('poof.wav',25,0)
				overlay()
				//client.addbyakugan()
				//client.byakuganupdate()
			else
				//client.removebyakugan()
				new/obj/eyeac(loc)
				byakugan=0
				forceupdate()
				overlay()
				range(12)<<"<font color=silver><b>[usr] deactivates his Byakugan."

		empty()
			prejutsu()
			if(cdelay3||copydelay4||swim||dead||stun||!byakugan&&clan!="Copy Ninja"||resting||caught||seals||busy||imitated||paralysed)
				return
			if(clan=="Copy Ninja")copydelay4=1
			else	cdelay3=1
			flick("attack", usr)
			soundeff('sonicboom.wav', 30, 1)
			for(var/mob/M in get_step(usr, dir))
				if(aff == M.aff)
					continue
				if(M.illusion)
					M.illusionhit(src)
					continue
				var/damage = apow
				if(M.clan=="Taijutsu Specialist")
					if(M.tier32)damage*=1-(M.tier32*0.05)
				M.dmgch(src, 1)
				damage = (damage * M.variable) + M.variable2
				M.damage(damage)
			var/K = new/obj/empty(loc)
			K:owner = usr
			if(clan!="Copy Ninja")K:projint += tier51
			var/N = 10
			while(N > 0)
				N --
				if(K)
					step(K, dir)
			if(K)
				del K
			if(level >= 45 || clan == "Copy Ninja")
				var/obj/empty/K2 = new(loc)
				K2.owner = usr
				if(clan!="Copy Ninja")K2.projint += tier51
				var/obj/empty/K3 = new(loc)
				K3.owner=usr
				if(clan!="Copy Ninja")K3.projint += tier51
				if(dir == NORTH || dir == SOUTH)
					K2.loc = locate(x+1,y,z)
					K3.loc = locate(x-1,y,z)
				if(dir == EAST || dir == WEST)
					K2.loc = locate(x, y+1, z)
					K3.loc = locate(x, y-1, z)
				var/N2 = 8
				while(N2 > 0)
					N2 --
					if(K2)
						step(K2, dir)
					if(K3)
						step(K3, dir)
				if(K2)
					del K2
				if(K3)
					del K3
			var/sdelay = (180 - (tier51*40)) * cdapow/100
			if(clan=="Copy Ninja")sdelay=120
			for(var/obj/jutsu/hyuuga/Empty_Palm/M in src)
				timerjutsu(sdelay, M)
			spawn(sdelay)
				cdelay3 = 0
				copydelay4=0
			if(clan=="Copy Ninja")tactics()
		hyuugableed(var/mob/M)
			sleep(10)
			while(hyuugableed&&M)
				hyuugableed--
				if(M.stance=="Precise Striking")
					damage(bleedtotal*2)
				else
					damage(bleedtotal)
				death(M)
				new/obj/bleed(loc)
				sleep(10)
			bleedtotal=0

		mountain()
			prejutsu()
			if(cdelay5||swim||resting||caught||seals||dead||stun||!byakugan||busy||imitated||paralysed)return
			handseals(90,0,60)
			if(!sealpass)return
			cdelay5=1
			for(var/obj/jutsu/hyuuga/Mountain_Crusher/M in src)M.overlays+='timer.dmi'
			new/obj/crater(loc)
			view(8)<<"<b><font color=aqua>[usr]: Mountain Crusher!"
			flick("attack",usr)
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
			for(var/mob/M in get_step(usr, T))
				if(aff==M.aff)continue
				if(M.illusion)
					M.illusionhit(src)
					continue
				var/damage = apow*1.35
				if(M.clan=="Taijutsu Specialist")
					if(M.tier32)damage*=1-(M.tier32*0.05)
				M.dmgch(src, 1)
				damage = (damage*M.variable) + M.variable2
				if(tier21)
					M.disabled(src,0.5*tier21*2)
				if(tier43)
					M.bleedtotal+=damage*0.015*tier43
					if(!M.hyuugableed)
						M.hyuugableed=4
						spawn()M.hyuugableed(src)
						new/obj/statuspop/internalbleeding(M.loc)
					else
						M.hyuugableed=4
				M.damage(damage)
				soundeff('mountain.wav', 45, 1)
				faceme(M)
				if(level >= 75)
					var/extradmg = (M.maxhp-M.hp)*0.12
					M.hp -= extradmg
					if(M.mybar)
						M.mybar:updatebar()
				if(level >= 65 && M.slow)
					soundeff('explosion4.wav', 70, 0)
					new/obj/medic/groundcrack(M.loc)
					for(var/mob/M2 in range(M, 2))
						if(M2 == src)continue
						if(aff == M2.aff)continue
						if(M2.illusion)
							M2.illusionhit(src)
							continue
						M.snared(28, 4)
				M.death(src)
				var/K = new/obj/mountainc(loc)
				K:owner = usr
				K:dir = dir
				var/N = 16
				while(N > 0)
					N --
					if(K)
						step(K, dir)
				sleep(1)
				for(var/obj/mountainc/G in world)if(G:owner==usr)
					G.dir=dir
					flick("c",G)
				for(var/obj/mountainc/G2 in usr.loc)
					if(G2:owner==usr)
						flick("e",G2)
			stepback(1)
			var/sdelay=240*cdapow/100
			if(tier53)sdelay=sdelay*1-(0.15*tier53)
			if(level>=85)sdelay*=0.7
			for(var/obj/jutsu/hyuuga/Mountain_Crusher/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)cdelay5=0

		kaiten()
			if(cdelay2==2)return
			if(shield)
				for(var/obj/kaiten/M in range(6))
					if(M.owner==src)del M
				busy=null
				shield=0
				icon_state="trigram"
				spawn(2)icon_state=""
				if(level>=40)
					for(var/mob/M in oview(2))
						if(aff==M.aff)continue
						faceme2(M)
						M.stepback(2,1)
						M.stun(7)
				var/sdelay=200*cdapow/100
				for(var/obj/jutsu/hyuuga/Rotation/M in src)timerjutsu(sdelay,M)
				spawn(sdelay)cdelay2=0
				return
			prejutsu()
			if(swim||dead||!byakugan||cdelay2||imitated||paralysed||resting||caught||seals||busy)return
			handseals(5,0,0)
			if(!sealpass)return
			if(level>=18)for(var/mob/Clone/O in oview(3))del O
			cdelay2=2
			spawn(14)if(cdelay2==2)cdelay2=1
			shield=1
			busy="shield"
			var/F=new/obj/kaiten(loc)
			F:owner=src
			new/obj/bigcrater(loc)
			var/speedspin=12-tier23*2
			var/timesspun=0
			while(shield)
				for(var/mob/M in oview(2))
					if(aff==M.aff)continue
					var/damage=apow*0.2
					if(M.clan=="Taijutsu Specialist")
						if(M.tier32)damage*=1-(M.tier32*0.05)
					M.dmgch(src,1)
					damage=(damage*M.variable)+M.variable2
					M.damage(damage)
					M.death(usr)
				for(var/mob/M in oview(1))
					if(aff==M.aff)continue
					var/damage=apow*0.3
					if(M.clan=="Taijutsu Specialist")
						if(M.tier32)damage*=1-(M.tier32*0.05)
					M.dmgch(src,1)
					damage=(damage*M.variable)+M.variable2
					M.damage(damage)
					M.death(usr)
				var/ccost=maxcha*(0.03+(0.02*timesspun))
				if(tier41)ccost*=1-0.15*tier41
				if(tier23)ccost*=1-0.15*tier23
				cha-=ccost
				mybar2:updatebar()
				if(cha<=0)
					var/sdelay=200*cdapow/100
					for(var/obj/jutsu/hyuuga/Rotation/M in src)timerjutsu(sdelay,M)
					spawn(sdelay)cdelay2=0
					cha=0
					for(var/obj/kaiten/M in range(6))
						if(M.owner==src)del M
					busy=null
					shield=0
					icon_state="trigram"
					spawn(2)icon_state=""
					return
				sleep(speedspin)
				timesspun++

		sixtyfour()
			if(swim||dead||cdelay6||stun||!byakugan||imitated||paralysed||resting||caught||seals||busy)return
			prejutsu()
			handseals(70,0,70)
			if(!sealpass)return
			cdelay6=1
			var/sdelay=750*cdapow/100
			for(var/obj/jutsu/hyuuga/Sixty_Four_Palms/M in src)
				timerjutsu(sdelay,M)
			for(var/obj/jutsu/hyuuga/One_Twenty_Eight_Palms/M in src)
				timerjutsu(sdelay,M)
			spawn(sdelay)cdelay6=0
			stun=1
			busy="trigram"
			icon_state="trigram"
			var/D=new/obj/Trigram(loc)
			var/Cdelay=15
			if(level>=105)Cdelay-=13
			for(var/mob/M in oview(3))
				if(aff==M.aff)continue
			view(8)<<"<b><font color=aqua>[usr]: Eight Trigrams..."
			sleep(Cdelay)
			view(8)<<"<b><font color=aqua>[usr]: Sixty-Four Palms!"
			var/list/view=view(3,usr)
			for(var/atom/A in view)if(!ismob(A))view-=A
			for(var/mob/M in view)
				if(aff==M.aff)
					view-=M
					continue
				spawn()M.sixtyfourcaught(src,19)
			var/Y=0
			for(var/mob/A in view)Y=1
			if(Y==0)goto skip
			var/OL=loc
			fade.MapLayer(src,2)
			fade.Map(src, 255, 40, 5)
			sleep(5)
			icon_state=""
			if(dead)
				for(var/mob/M in world)if(M.caughtby==src)
					M.caughtby=null
					M.caught=0
					fade.Map(M, 0, 20, 5)
					M.death(usr)
				goto skip
			sleep(2)
			view(10)<<"<b><font color=aqua>[usr]: Two Palms!"
			var/target=pick(view)
			if(!target)goto skip
			src:strikeblow(target,apow*0.15)
			sleep(2)
			view(10)<<"<b><font color=aqua>[usr]: Four Palms!"
			target=pick(view)
			if(!target)goto skip
			src:strikeblow(target,apow*0.15)
			sleep(2)
			view(10)<<"<b><font color=aqua>[usr]: Eight Palms!"
			target=pick(view)
			if(!target)goto skip
			src:strikeblow(target,apow*0.25)
			sleep(2)
			view(10)<<"<b><font color=aqua>[usr]: Sixteen Palms!"
			target=pick(view)
			if(!target)goto skip
			src:strikeblow(target,apow*0.25)
			sleep(2)
			view(10)<<"<b><font color=aqua>[usr]: Thirty-Two Palms!"
			target=pick(view)
			if(!target)goto skip
			src:strikeblow(target,apow*0.35)
			sleep(2)
			view(10)<<"<b><font color=aqua>[usr]: Sixty-Four Palms!"
			target=pick(view)
			if(!target)goto skip
			src:strikeblow(target,apow*0.35)
			sleep(2)
			target=pick(view)
			if(!target)goto skip
			target:stepback(1,2)
			new/obj/crithit2(target:loc)
			new/obj/crater(target:loc)
			src:strikeblow(target,apow*0.45)
			if(stance=="Precise Striking"&&tier63)mountainpalm(target)
			sleep(2)
			loc=OL
			barloc()
			skip
			spawn(15)del D
			fade.Map(src, 0, 20, 10)
			stun=0
			busy=null
			icon_state=""

		onetwentyeight()
			if(swim||dead||cdelay6||stun||!byakugan||imitated||paralysed||resting||caught||seals||busy)return
			prejutsu()
			handseals(100,0,70)
			if(!sealpass)return
			cdelay6=1
			var/sdelay=750*cdapow/100
			for(var/obj/jutsu/hyuuga/Sixty_Four_Palms/M in src)timerjutsu(sdelay,M)
			for(var/obj/jutsu/hyuuga/One_Twenty_Eight_Palms/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)cdelay6=0
			busy="trigram"
			stun=1
			icon_state="trigram"
			var/D=new/obj/Trigram(loc)
			for(var/mob/M in oview(4))
				if(aff==M.aff)continue
			var/Cdelay=15
			if(level>=105)Cdelay-=13
			view(8)<<"<b><font color=aqua>[usr]: Gentle Fist Art!"
			sleep(Cdelay)
			del D
			var/D2=new/obj/Trigram/onetwentyeight(loc)
			view(8)<<"<b><font color=aqua>[usr]: Eight Trigrams, One Hundred and Twenty-Eight Palms!"
			var/list/view=view(4,usr)
			for(var/atom/A in view)if(!ismob(A))view-=A
			for(var/mob/M in view)
				if(aff==M.aff)
					view-=M
					continue
				spawn()M.sixtyfourcaught(src,21)
			var/Y=0
			for(var/mob/A in view)	Y=1
			if(Y==0)goto skip
			var/OL=loc
			fade.MapLayer(src,2)
			fade.Map(src, 255, 40, 5)
			sleep(5)
			if(dead)
				for(var/mob/M in world)if(M.caughtby==src)
					M.caughtby=null
					M.caught=0
					fade.Map(M, 0, 20, 10)
					M.death(usr)
				goto skip
			icon_state=""
			sleep(2)
			view(10)<<"<b><font color=aqua>[usr]: Two Palms!"
			var/target=pick(view)
			if(!target)goto skip
			src:strikeblow(target, apow*0.25)
			sleep(2)
			view(10)<<"<b><font color=aqua>[usr]: Four Palms!"
			target=pick(view)
			if(!target)goto skip
			src:strikeblow(target, apow*0.25)
			sleep(2)
			view(10)<<"<b><font color=aqua>[usr]: Eight Palms!"
			target=pick(view)
			if(!target)goto skip
			src:strikeblow(target, apow*0.35)
			sleep(2)
			view(10)<<"<b><font color=aqua>[usr]: Sixteen Palms!"
			target=pick(view)
			if(!target)goto skip
			src:strikeblow(target, apow*0.35)
			sleep(2)
			view(10)<<"<b><font color=aqua>[usr]: Thirty-Two Palms!"
			target=pick(view)
			if(!target)goto skip
			src:strikeblow(target, apow*0.45)
			sleep(2)
			view(10)<<"<b><font color=aqua>[usr]: Sixty-Four Palms!"
			target=pick(view)
			if(!target)goto skip
			src:strikeblow(target, apow*0.45)
			sleep(2)
			view(8)<<"<b><font color=aqua>[usr]: One Hundred and Twenty-Eight Palms!"
			target = pick(view)
			if(!target)
				goto skip
			var/damage = apow*0.55
			new/obj/crithit2(target:loc)
			new/obj/crater(target:loc)
			src:strikeblow(target,damage)
			target:stepback(2)
			if(stance=="Precise Striking"&&tier63)mountainpalm(target)
			sleep(2)
			loc=OL
			barloc()
			skip
			del D2
			spawn(15)del D2
			fade.Map(src, 0, 20, 10)
			stun=0
			busy=null
			icon_state=""

		sixtyfourcaught(var/mob/M,var/time)
			caught=1
			caughtby=usr
			fade.MapLayer(src,2)
			fade.Map(src, 255, 40, 5)
			sleep(time)
			caughtby=null
			caught=0
			fade.Map(src, 0, 20, 10)
			death(M)

		precisestriking()
			if(dead||imitated||paralysed||caught||seals||busy)
				return
			if(stancing)
				return
			stancing = 1
			spawn(10)
				stancing=0
			if(stance == "Precise Striking")
				stance = "None"
				forceupdate()
				new/obj/statuspop/normalstance(loc)
				for(var/obj/statuseffect/stance/M in client.screen)
					del M
				return
			if(stance != "None")
				for(var/obj/statuseffect/stance/M in client.screen)
					del M
			stance = "Precise Striking"
			forceupdate()
			new/obj/statuspop/precisestriking(loc)
			var/obj/statuseffect/t = new/obj/statuseffect/stance/precisestriking
			t.screen_loc = "18,20"
			client.screen += t

		rapidpalms()
			if(dead||imitated||paralysed||caught||seals||busy)return
			if(stancing)return
			stancing=1
			spawn(10)stancing=0
			if(stance == "Rapid Palms")
				stance = "None"
				forceupdate()
				new/obj/statuspop/normalstance(loc)
				for(var/obj/statuseffect/stance/M in client.screen)del M
				return
			if(stance!="None")for(var/obj/statuseffect/stance/M in client.screen)del M
			stance = "Rapid Palms"
			forceupdate()
			new/obj/statuspop/rapidpalms(loc)
			var/obj/statuseffect/t=new/obj/statuseffect/stance/rapidpalms
			t.screen_loc="18,20"
			client.screen+=t

		mountainpalm(var/mob/M)
			M:winddebuff(70)
			var/K=new/obj/mountainc(loc)
			K:owner=usr
			K:dir=dir
			K:icon='mpalm.dmi'
			var/N=16
			loop
				if(N>0)
					N--
					step(K,dir)
					if(K)
						goto loop
			sleep(1)
			for(var/obj/mountainc/G in world)if(G:owner==usr)
				G.dir=dir
				flick("c",G)
			for(var/obj/mountainc/G2 in usr.loc)
				if(G2:owner==usr)
					flick("e",G2)

		lionpalm()
			prejutsu()
			if(swim||dead||stun||!byakugan||cdelay4||imitated||paralysed||resting||caught||seals||busy)return
			handseals(70,0,50)
			if(!sealpass)return
			cdelay4=1
			var/sdelay=100*cdapow/100
			if(tier53)sdelay=sdelay*(1-(0.15*tier53))
			for(var/obj/jutsu/hyuuga/Lion_Palm/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)cdelay4=0
			flick("attack",src)
			for(var/mob/M in oview(1))
				if(aff==M.aff)continue
				if(dir==SOUTH&&M.y<y||dir==NORTH&&M.y>y||dir==EAST&&M.x>x||dir==WEST&&M.x<x)
					var/L5=new/obj/lionpalm(loc)
					L5:owner=usr
					L5:dir=dir
					walk(L5,dir,2)
					if(M.illusion)
						M.illusionhit(src)
						continue
					var/damage = apow * 0.35
					if(M.clan=="Taijutsu Specialist")
						if(M.tier32)damage*=1-(M.tier32*0.05)
					if(tier21)
						M.disabled(src, 0.5 * tier21 * 2)
					if(level < 28)
						M.silenced(14)
						M.snared(14, 4)
					else
						M.silenced(28)
						M.snared(28, 4)
					M.dmgch(src,1)
					damage = (damage*M.variable)+M.variable2
					critroll(M)
					var/random=rand(1,100)
					if(criticalroll>=random)
						M.damage(damage,1.5)
					else
						M.damage(damage)
					if(M)
						M.death(usr)
					return
			var/am = 2
			if(level >= 10)
				am = 4
			new/obj/flashstep(loc)
			fast=1
			spawn(1)fast=0
			loop
				if(am)
					am --
					step(src,dir)
					for(var/mob/M in oview(1))
						if(aff==M.aff)
							continue
						if(dir==SOUTH&&M.y<y||dir==NORTH&&M.y>y||dir==EAST&&M.x>x||dir==WEST&&M.x<x)
							var/L5 = new/obj/lionpalm(loc)
							L5:owner = usr
							L5:dir = dir
							walk(L5, dir, 2)
							if(M.illusion)
								M.illusionhit(src)
								continue
							var/damage = apow*0.35
							if(M.clan=="Taijutsu Specialist")
								if(M.tier32)damage*=1-(M.tier32*0.05)
							if(tier21)
								M.disabled(src, 0.5*tier21*2)
							if(level<28)
								M.silenced(14)
								M.snared(7, 4)
							else
								M.silenced(28)
								M.snared(14, 4)
							M.dmgch(src, 1)
							damage = (damage*M.variable) + M.variable2
							critroll(M)
							var/random = rand(1, 100)
							if(criticalroll >= random)
								M.damage(damage, 1.5)
							else
								M.damage(damage)
							if(M)
								M.death(usr)
							return
					goto loop

mob/var
	rapidstack=0
	rapidtime=0
	punchcounter=0
	disabletime=0
obj/lionpalm
	layer=35
	pixel_y=-32
	pixel_x=-32
	icon='lionpalm.dmi'
	New()
		..()
		spawn(0)
			flick("head",src)
			name="Lion Palm"
			spawn(8)del src
