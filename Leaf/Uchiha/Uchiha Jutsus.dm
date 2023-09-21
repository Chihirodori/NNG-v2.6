mob/var
	illusion1=0
	illusion2=0
	illusionl1=0
	illusionl2=0
	closs=0
	susanoo=0
	godmode=0
	veng=0
	illusiondef=0
mob
	proc
		uchihaleveling()
			if(level==2)
				src<<"<b><font color=red><u>Skill Level Up:</u> You have learned your first fire jutsu, Fireball Jutsu! This jutsu makes you breath out a ball of fire that explodes into flames on impact, dealing ninjutsu damage and leaving a area of flames that deals damage to everyone in it every second."
				new/obj/jutsu/uchiha/Fireball_Jutsu(src)
			if(level==3)
				src<<"<b><font color=red><u>Skill Level Up:</u> You have awaken your Sharingan! While this eye jutsu is activated, you are able to perform actions that normally would be impossible to do, like falcon drop. While sharingan is active, you gain accuracy, dodge and handseal speed."
				new/obj/jutsu/uchiha/Sharingan(src)
			if(level==5)
				src<<"<b><font color=red><u>Skill Level Up:</u> You have learned Phoenix Flower Jutsu! This jutsu lets you fire multiple fireballs out of your mouth, dealing ninjutsu damage on impact."
				new/obj/jutsu/uchiha/Phoenix_Flower_Jutsu(src)
			if(level==7)
				src<<"<b><font color=red><u>Skill Level Up:</u> You have learned Piercing Gaze! This move uses your sharingan to slow the enemy heavily for 2 seconds. You may use this move while hidden or transformed, as long as you are facing your target."
				new/obj/jutsu/uchiha/Piercing_Gaze(src)
			if(level==10)src<<"<b><font color=red><u>Skill Level Up:</u> Fireball Jutsu is now level 2! The flames now last longer and the charge time is reduced! Also the fireball size increased."
			if(level==15)src<<"<b><font color=red><u>Skill Level Up:</u> Phoenix Flower level is now level 2! You now fire one more fireball and you fire them faster."
			if(level==20)
				src<<"<b><font color=red><u>Skill Level Up:</u> Your Sharingan has matured to two tomoes! Your accuracy, dodge, handseal time, damage, defense and cooldown speed increased!"
				for(var/obj/jutsu/uchiha/Sharingan/F in src)F.icon_state="sharingan2"
				if(sharingan)
					sharingan++
					forceupdate()
			if(level==22)
				new/obj/jutsu/uchiha/Body_Illusion(src)
				src<<"<b><font color=red><u>Skill Level Up:</u> You have learned Body Illusion! This illusion temporarily changes your body into an illusion and when you get hit by any attack, your body will turn into crows and fly away and your real body will appear behind the attacker."
			if(level==25)src<<"<b><font color=red><u>Skill Level Up:</u> Fireball Jutsu level is now level 3! The flame area increased and last even longer."
			if(level==28)
				src<<"<b><font color=red><u>Skill Level Up:</u> You have learned your third fire jutsu, Dragon Flames Jutsu. You shoot a quick wire forward binding the first enemy struck for 1.5 second. If it hits a enemy, you set the wire in flames and replace your body with a clone, dealing ninjutsu damage to the enemy."
				new/obj/jutsu/uchiha/Dragon_Flames_Jutsu(src)
			if(level==30)src<<"<b><font color=red><u>Skill Level Up:</u> Piercing Gaze level is now level 2! It now reduces the enemy's defense by 10% for 8 seconds."
			if(level==35)src<<"<b><font color=red><u>Skill Level Up:</u> Phoenix Flower level is now level 3! You now fire one more fireball and fire them more rapidly."
			if(level==40)
				new/obj/jutsu/uchiha/Chidori(src)
				src<<"<b><font color=red><u>Skill Level Up:</u> You have learned Chidori! This powerful ability charges lightning-like chakra in your palm, and boost you forward. Anyone you collide with gets hit for heavy piercing damage."
			if(level==45)
				src<<"<b><font color=red><u>Skill Level Up:</u> You have mastered Fireball Jutsu! The flame area is increased, the charge time is reduced and the flame lasting time is increased!"
			if(level==50)
				src<<"<b><font color=red><u>Skill Level Up:</u> Body Illusion level is now level 2! You stun the enemy for 0.5 second when this ability activates"
			if(level==52)src<<"<b><font color=red><u>Skill Level Up:</u> Dragon Flames is now level 2! The flame damage of fireball jutsu and dragon flames is increased by 25%."
			if(level==55)
				src<<"<b><font color=red><u>Skill Level Up:</u> Piercing Gaze level is now level 3! The ability is now wider."
			if(level==58)
				src<<"<b><font color=red><u>Skill Level Up:</u> You have learned Chidori Current. This move emits a chidori around your body, silencing and damaging everyone around you."
				new/obj/jutsu/uchiha/Chidori_Current(src)
			if(level==60)
				for(var/obj/jutsu/uchiha/Sharingan/F in src)F.icon_state="sharingan3"
				if(sharingan)
					sharingan++
					forceupdate()
				src<<"<b><font color=red><u>Skill Level Up:</u> Your Sharingan has matured to three tomoes! Your accuracy, dodge, handseal speed, defense and damage increased! Your vision also will not be obscured by chidori and your movement speed increased in sharingan."
			if(level==62)
				new/obj/jutsu/uchiha/Ephemeral(src)
				src<<"<b><font color=red><u>Skill Level Up:</u> You have learned Ephemeral. This move fires a wave of crows that deals high ninjutsu damage and slowing the enemy for 2 seconds."
			if(level==65)src<<"<b><font color=red><u>Skill Level Up:</u> Chidori is now level 2! The handseal time and charge-up time has decreased by 40%."
			if(level==70)src<<"<b><font color=red><u>Skill Level Up:</u> You have mastered Dragon Flames! This jutsu leaves a patch of flames under the enemy after the bind is complete."
			if(level==75)
				src<<"<b><font color=red><u>Skill Level Up:</u> Chidori Current is now level 2! It now slows for 2 seconds."
			if(level==80)
				new/obj/jutsu/uchiha/Mangekyou_Sharingan(src)
				src<<"<b><font color=red><u>Skill Level Up: You have unlocked your Mangekyou Sharingan. When this ability is activated, you gain immense power for 16 seconds and a new set of powerful jutsus. Your vision gets damaged with each use of this jutsu and you must rest for one minute to recover for each time you use this jutsu.</u>"
			if(level==85)src<<"<b><font color=red><u>Skill Level Up:</u> Piercing Gaze level is now mastered. You don't have to face the enemy to affect them now, but it only lasts one second."
			if(level==88)src<<"<b><font color=red><u>Skill Level Up:</u> Ephemeral is now level 2! It now prevents the enemy from seeing friends or foes for 2 seconds."
			if(level==90)src<<"<b><font color=red><u>Skill Level Up:</u> You have mastered Phoenix Flower! The fireball damage has increased!"
			if(level==95)src<<"<b><font color=red><u>Skill Level Up:</u> Chidori is now level 3! Your vision is now steady while using it."
			if(level==100)src<<"<b><font color=red><u>Skill Level Up:</u> You have mastered Chidori Current! It now does 20% more damage!"
			if(level==110)src<<"<b><font color=red><u>Skill Level Up:</u> Body Illusion level is now mastered. The cooldown is reduced by 15%."
			if(level==115)src<<"<b><font color=red><u>Skill Level Up:</u> You have mastered Ephemeral! The crows are now invisible for the first 3 steps."
			if(level==120)src<<"<b><font color=red><u>Skill Level Up:</u> Chidori is now mastered! The charge-up time is decreased by 90% and the damage increased by 30%."

		disperse()
			if(tsukcd||swim||dead||resting||seals||imitated)return
			var/t=1+(0.08*tier33)
			if(tier53)t+=2
			handseals(40*t,0,60,1)
			if(!sealpass)return
			tsukcd=1
			for(var/obj/jutsu/uchiha/Disperse/M in src)timerjutsu(900,M)
			spawn(900)tsukcd=0
			new/obj/illusion(loc)
			icon=null
			overlays=null
			godmode=1
			spawn(3)
			icon='ephmeral.dmi'
			sleep(5+10*tier52)
			godmode=0
			iconrefresh()
			overlay()
			new/obj/randraven(loc)
			new/obj/randraven2(loc)
			new/obj/randraven3(loc)

		fireballjutsu()
			prejutsu()
			if(kyuubimode)
				src<<"<center>Kyuubi locks the usage of this jutsu with his dark power."
				return
			if(cdelay1||copydelay1||swim||dead||stun||resting||caught||seals||busy||imitated||paralysed)return
			var/t=1+(0.08*tier33)
			if(tier53)t+=2
			handseals(20*t,10)
			if(!sealpass)return
			var/sdelay=220*cdpow/100
			if(clan=="Copy Ninja")copydelay1=1
			else	cdelay1=1
			for(var/obj/jutsu/uchiha/Fireball_Jutsu/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)
				cdelay1=0
				copydelay1=0
			if(sharingan==4)
				var/obj/amatball/L=new(loc)
				L.owner=usr
				soundeff('explosion3.wav',35,0)
				var/N=10
				while(N>0)
					N--
					if(L)step(L,dir)
				if(L)L:blackburn(src,75,15,3)
			else
				view(8)<<"<b><font color=red>[usr]: Fire Style! Fireball Jutsu!"
				stun=1
				busy="stun"
				if(level<10&&clan!="Copy Ninja")
					firecharge(5)
					sleep(5)
					var/L=new/obj/fireb/sfireball2(loc)
					L:owner=usr
					step(L,dir)
					if(L)walk(L,dir)
					goto skip
				if(level<45&&clan!="Copy Ninja")
					firecharge(5)
					var/J=new/obj(loc)
					J:icon='fireball.dmi'
					step(J,dir)
					J:layer=20
					sleep(2)
					del J
					var/L=new/obj/fireb/sfireball3(loc)
					L:owner=usr
					step(L,dir)
					sleep(3)
					if(L)walk(L,dir)
					goto skip
				firecharge(5)
				var/J=new/obj(loc)
				J:icon='fireball.dmi'
				step(J,dir)
				J:layer=20
				J:impendingdemise()
				sleep(2)
				if(J)del J
				var/H=new/obj/chargefireball(loc)
				step(H,dir)
				sleep(2)
				var/L=new/obj/fireb/sfireball5(loc)
				L:owner=usr
				step(L,dir)
				sleep(1)
				if(L)walk(L,dir)
				skip
				soundeff('explosion3.wav',35,0)
				stun=0
				busy=null
				spawn(80)if(L)del L
			if(clan=="Copy Ninja")tactics()
		bodyillusion()
			if(!sharingan)
				src<<"<b>Without the Sharingan active, this illusion can not be used."
				return
			prejutsu()
			if(illusion1||illusion||swim||dead||stun||caught||seals||busy||!sharingan||imitated||paralysed)return
			var/t=1+(0.08*tier33)
			if(tier53)t+=2
			handseals(50*t,0,80,1)
			if(!sealpass)return
			illusion=1
			if(tier31)
				crowed=1
				atkdef()
			src<<"Your body is now prepared for attack."
			illusion1=1
			var/g=tier42*10
			spawn(50+g)
				if(illusion)
					illusion=0
					if(crowed)
						crowed=0
						atkdef()
					src<<"Your illusion deactivated."
			var/sdelay=520
			sdelay-=52*tier32
			if(level >= 110)
				sdelay *= 0.85
			for(var/obj/jutsu/uchiha/Body_Illusion/M in src)
				timerjutsu(sdelay, M)
			spawn(sdelay)
				illusion1 = 0

		sharingan()
			prejutsu()
			if(swim||dead||stun||resting||caught||seals||moving||dous||busy||imitated||paralysed)return
			if(blind >= 100)
				src<<"<font color=red><b>You can not use Sharingan anymore! You are blind! Rest to slowly regain your eyesight!"
				return
			dous = 1
			for(var/obj/jutsu/uchiha/Sharingan/M in src)
				M.overlays += 'timer.dmi'
			spawn(42)
				for(var/obj/jutsu/uchiha/Sharingan/M in src)
					M.overlays -= 'timer.dmi'
				dous = 0
			if(!sharingan)
				new/obj/eyeac(loc)
				sharingan ++
				soundeff('poof.wav', 25, 0)
				view(8) << "<font color=red><b>[usr]: Sharingan!"
				if(level >= 20 || clan == "Copy Ninja")
					sharingan ++
				if(level >= 60 || clan == "Copy Ninja")
					sharingan ++
				forceupdate()
				regenupdate()
				overlay()
				closs = 5
				if(sharingan == 2)
					closs = 10
				if(sharingan == 3)
					closs = 12
				if(sharingan >= 4)
					closs = 30
				if(clan == "Uchiha")
					if(tier12)
						closs *= 1 - (0.15*tier12)
				closs -= Int
				if(clan=="Copy Ninja")closs=round(25-(Int/2))
				if(clan=="Copy Ninja"&&tier12)closs*=1-(tier12*0.05)
				closs = max(closs, 0)
			else
				new/obj/eyeac(loc)
				sharingan = 0
				regenupdate()
				forceupdate()
				overlay()
				mangoff()
				view(8) << "<font color=red>[usr] deactivates his Sharingan."

		ephemeral()
			if(!sharingan)
				src<<"<b>Without the Sharingan active, this jutsu can not be used."
				return
			prejutsu()
			if(cdelay3||swim||dead||stun||resting||caught||seals||busy||imitated||paralysed)return
			var/t2=1+(0.2*tier53)+(0.08*tier33)
			handseals(50*t2,10,70)
			if(!sealpass)return
			cdelay3=1
			var/sdelay=400*cdpow/100
			for(var/obj/jutsu/uchiha/Ephemeral/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)cdelay3=0
			var/K=new/obj/ephemeral(loc)
			K:dir=dir
			K:owner=src
			walk(K,dir)
			var/K2=new/obj/ephemeral(loc)
			K2:dir=dir
			K2:owner=src
			var/K3=new/obj/ephemeral(loc)
			K3:dir=dir
			K3:owner=src
			if(dir==NORTH||dir==SOUTH)
				K2:x--
				K3:x++
			if(dir==WEST||dir==EAST)
				K2:y--
				K3:y++
			walk(K2,dir)
			walk(K3,dir)

		falcondrop()
			if(!sharingan&&clan!="Copy Ninja")
				src<<"<b>Without the Sharingan active, this jutsu can not be used."
				return
			prejutsu()
			if(cdelay3||copydelay2||swim||dead||stun||resting||caught||seals||busy||imitated||paralysed)return
			if(clan=="Copy Ninja")copydelay2=1
			else	cdelay3=1
			var/sdelay=200*cdpow/100
		//	if(level>=12)sdelay-=40
		//	if(tier41)sdelay*=0.95-tier41*0.05
			for(var/obj/jutsu/uchiha/Peregrine_Falcon_Drop/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)
				cdelay3=0
				copydelay2=0
			stepup(5)
			stun=1
			spawn(1)pixel_y=2
			spawn(2)pixel_y=4
			spawn(3)pixel_y=5
			spawn(4)pixel_y=3
			spawn(7)
				pixel_y=0
				stun=0
			spawn(2)
				for(var/mob/M in get_step(src,dir))
					if(aff==M.aff)return
					if(M.illusion)
						M.illusionhit(src)
						continue
					if(M.client)
						M.stun(13)
					faceme(M)
					flick("attack",src)
					var/damage=apow
					M.dmgch(src,1)
					damage=(damage*M.variable)+M.variable2
					M.stepback(5)
					spawn(1)if(M)M.pixel_y=pixel_y+5
					spawn(2)if(M)M.pixel_y=pixel_y+5
					spawn(3)if(M)M.pixel_y=pixel_y+5
					spawn(4)if(M)M.pixel_y=pixel_y+5
					spawn(7)if(M)
						new/obj/hit(M.loc)
						M.pixel_y=50
						var/image2=new/obj/kimage(loc)
						image2:dir=dir
						image2:icon=icon
						image2:overlays=overlays
						image2:pixel_y=M.pixel_y-5
						invisibility+=5
						spawn(3)
							invisibility-=5
							del image2
					spawn(6)if(M)M.pixel_y=80
					spawn(7)if(M)M.pixel_y=90
					spawn(8)if(M)M.pixel_y=95
					spawn(9)if(M)M.pixel_y=40
					spawn(10)if(M)M.pixel_y=10
					spawn(11)if(M)M.pixel_y=0
					spawn(12)if(M)M.pixel_y=10
					spawn(13)if(M)
						new/obj/crater(M.loc)
						M.stepback(1)
						M.damage(damage)
						M.pixel_y=0
						pixel_y=0
						M.death(src)
						if(M&&!M.dead)M.confusion(30)
			if(clan=="Copy Ninja")tactics()
		phoenixflower()
			prejutsu()
			if(cdelay2||copydelay2||swim||dead||stun||resting||caught||seals||busy||imitated||paralysed)
				return
			var/t2 = 1 + (0.2*tier53) + (0.08*tier33)
			if(tier53)
				t2 += 2
			handseals(30*t2, 5, 40)
			if(!sealpass)
				return
			view(8) << "<b><font color=red>[usr]: Fire Style! Phoenix Flower Jutsu!"
			if(clan=="Copy Ninja")copydelay2=1
			else	cdelay2=1
			var/sdelay = (220*cdpow)/100
			for(var/obj/jutsu/uchiha/Phoenix_Flower_Jutsu/M in src)
				timerjutsu(sdelay, M)
			spawn(sdelay)
				cdelay2 = 0
				copydelay2 = 0
			spidering = 1
			var/t = 4
			if(level >= 15)
				t --
			if(level >= 35)
				t --
			var/L = new/obj/proj/fflower(loc)
			L:owner = usr
			L:dir = dir
			soundeff('puff4.wav', 25, 0)
			L:movequick(dir)
			sleep(t)
			var/L1 = new/obj/proj/fflower(loc)
			L1:owner = usr
			L1:dir = dir
			soundeff('puff4.wav', 25, 0)
			L1:movequick(dir)
			sleep(t)
			var/L2 = new/obj/proj/fflower(loc)
			L2:owner = usr
			L2:dir = dir
			soundeff('puff4.wav', 25, 0)
			L2:movequick(dir)
			if(level >= 15 || clan=="Copy Ninja")
				sleep(3)
				var/L3 = new/obj/proj/fflower(loc)
				L3:owner = usr
				L3:dir = dir
				soundeff('puff4.wav', 25, 0)
				L3:movequick(dir)
			if(level >= 35 || clan=="Copy Ninja")
				sleep(2)
				var/L4 = new/obj/proj/fflower(loc)
				L4:owner = usr
				L4:dir = dir
				soundeff('puff4.wav', 25, 0)
				L4:movequick(dir)
			spidering = 0
			if(clan=="Copy Ninja")tactics()
		mangekyou()
			if(sharingan==4&&amatcd!=2)
				sharingan=3
				overlay()
				new/obj/eyeac(loc)
				forceupdate()
				blindrefresh()
				mangoff()
				return
			prejutsu()
			if(swim||amatcd||dead||stun||resting||caught||seals||moving||busy||imitated)return
			amatcd=2
			spawn(30)if(amatcd==2)amatcd=0
			if(sharingan==3)
				new/obj/eyeac(loc)
				sharingan=4
				overlay()
				forceupdate()
				view(10)<<"<font color=red><b>[usr]: Mangekyou Sharingan!"
				blind+=20
				blindrefresh()
				for(var/obj/jutsu/uchiha/Fireball_Jutsu/M in src)
					M.name="Amaterasu"
					M.icon_state="amaterasu"
				for(var/obj/jutsu/uchiha/Phoenix_Flower_Jutsu/M in src)
					M.name="Yasaka Magatama"
					M.icon_state="yasaka magatama"
				for(var/obj/jutsu/uchiha/Piercing_Gaze/M in src)
					M.name="Tsukuyome"
					M.icon_state="tsukuyome"
				for(var/obj/jutsu/uchiha/Body_Illusion/M in src)
					M.name="Kagutsuchi"
					M.icon_state="kagutsuchi"
				for(var/obj/jutsu/uchiha/Chidori/M in src)
					M.name="Amaterasu Unleash"
					M.icon_state="amaterasu unleash"
				for(var/obj/jutsu/uchiha/Chidori_Current/M in src)
					M.name="Susanoo"
					M.icon_state="susanoo"
				//if(GM<3)
				spawn()mangekyoushowdown()

		emangekyou()
			if(sharingan==4&&amatcd!=2)
				sharingan=3
				overlay()
				new/obj/eyeac(loc)
				forceupdate()
				blindrefresh()
				mangoff()
				return
			prejutsu()
			if(swim||amatcd||dead||stun||resting||caught||seals||moving||busy||imitated)return
			amatcd=2
			spawn(30)if(amatcd==2)amatcd=0
			if(sharingan==3)
				new/obj/eyeac(loc)
				sharingan=4
				overlay()
				forceupdate()
				view(10)<<"<font color=red><b>[usr]: Mangekyou Sharingan!"
				for(var/obj/jutsu/uchiha/Fireball_Jutsu/M in src)
					M.name="Amaterasu"
					M.icon_state="amaterasu"
				for(var/obj/jutsu/uchiha/Phoenix_Flower_Jutsu/M in src)
					M.name="Yasaka Magatama"
					M.icon_state="yasaka magatama"
				for(var/obj/jutsu/uchiha/Piercing_Gaze/M in src)
					M.name="Tsukuyome"
					M.icon_state="tsukuyome"
				for(var/obj/jutsu/uchiha/Body_Illusion/M in src)
					M.name="Kagutsuchi"
					M.icon_state="kagutsuchi"
				for(var/obj/jutsu/uchiha/Chidori/M in src)
					M.name="Amaterasu Unleash"
					M.icon_state="amaterasu unleash"
				for(var/obj/jutsu/uchiha/Chidori_Current/M in src)
					M.name="Susanoo"
					M.icon_state="susanoo"
				//if(GM<3)

		mangekyoushowdown()
			while(sharingan==4&&!dead)
				sleep(10)
				var/hpdeath=maxhp*0.02
				var/mangdefd=1
				if(tier62)
					hpdeath*=(0.95-(0.15*tier62))
					mangdefd-=0.05+(0.15*tier62)
				hp-=hpdeath
				if(mybar)mybar:updatebar()
				mangdef+=mangdefd
				atkdef()
				blind+=0.5
				if(blind%5==0&&blind>=20)blindrefresh()
				if(hp<=1&&!dead)
					hp=1
					sharingan=3
					overlay()
					forceupdate()
					blindrefresh()
					mangoff()

		triplewindmill()
			if(!sharingan)
				src<<"<b>Without the Sharingan active, this jutsu can not be used."
				return
			prejutsu()
			if(cdelay2||swim||dead||stun||resting||caught||seals||busy||imitated)return
			cdelay2=1
			for(var/obj/jutsu/uchiha/Triple_Windmill/M in src)M.overlays+='timer.dmi'
			flick("attack",src)
			var/K=new/obj/wire(loc)
			K:owner=usr
			K:dir=dir
			walk(K,dir)
			spawn(12)if(K)if(K:loc!=locate(0,0,0))del K
			var/sdelay=300
			if(curseseal==2)sdelay=sdelay/1.5
			if(curseseal==3)sdelay=sdelay/2
			spawn(sdelay*(cdapow/100))
				for(var/obj/jutsu/uchiha/Triple_Windmill/M in src)M.overlays-='timer.dmi'
				cdelay2=0

		chidoricurrent()
			prejutsu()
			if(cdelay6||swim||dead||stun||resting||caught||seals||busy||imitated)return
			var/t=1+(0.08*tier33)
			if(tier53)t+=2
			cdelay6=1
			handseals(50*t,0,70)
			if(!sealpass)
				cdelay6=0
				return
			if(sharingan==4)
				susanoo=1
				ovcheck()
				spawn(140)
					susanoo=0
					ovcheck()
				new/obj/susanoowave(loc)
			else new/obj/chidoricurrent(loc)
			var/sdelay=900*cdpow/100
			for(var/obj/jutsu/uchiha/Chidori_Current/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)cdelay6=0
			for(var/mob/M in oview(3))
				if(aff==M.aff)continue
				if(M.illusion)
					M.illusionhit(src)
					continue
				var/damage=pow*0.6
				M.dmgch(src,1)
				damage=(damage*M.variable)+M.variable2
				if(level>=100)damage*=1.2
				M.silenced(20)
				if(level>=75)
					M.snared(20,4)
				M.damage(damage)
				M.death(usr)

		firestacks()
			firestack ++
			spawn(30)
				firestack--

		cloneexplosion()
			if(GM<3)return
			prejutsu()
			if(cdelay6||swim||dead||stun||resting||caught||seals||busy||imitated)return
			var/t=1
			cdelay6=1
			handseals(100*t,0,70)
			if(!sealpass)
				cdelay6=0
				return
			var/mob/Clone/boomclone/K=new(loc)
			cloneused=1
			K.cloneowner=usr
			K.icon=icon
			K.dir=dir
			K.overlays=overlays
			K.village=village
			K.name=name
			var/obj/bars/healthbar/B1=new(K.loc)
			B1.barowner=K
			B1.copy(src)
			K.mybar=B1
			var/obj/bars/chakrabar/B2=new(K.loc)
			B2.barowner=K
			B2.copy(src)
			K.mybar2=B2
			invisibility+=3
			var/image/I=image('baseinvis.dmi',src)
			src<<I
			barloc()
			spawn(34)
				invisibility-=3
				del I
				barloc()
				new/obj/randraven(loc)
				new/obj/randraven(loc)
				new/obj/randraven(loc)
				new/obj/randraven(loc)
				new/obj/randraven2(loc)
				new/obj/randraven2(loc)
				new/obj/randraven2(loc)
				new/obj/randraven2(loc)
				new/obj/randraven3(loc)
				new/obj/randraven3(loc)
				new/obj/randraven3(loc)
				new/obj/randraven3(loc)
				spawn(1)
					new/obj/randraven(loc)
					new/obj/randraven(loc)
				spawn(2)new/obj/randraven(loc)
				if(K)del K
			var/sdelay=620*cdpow/100
			for(var/obj/jutsu/uchiha/Clone_Explosion/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)cdelay6=0

		dragonflames()
			prejutsu()
			if(cdelay5||copydelay3||swim||dead||stun||resting||caught||seals||busy||imitated)return
			var/t=1+(0.08*tier33)
			if(tier53)t+=2
			if(clan=="Copy Ninja")t=1
			handseals(50*t,5,50)
			if(!sealpass)return
			view(8)<<"<font color=red>[usr]: Fire Style! Dragon Flames Jutsu!"
			icon_state="spear"
			busy="wiring"
			if(clan=="Copy Ninja")copydelay3=1
			else	cdelay5=1
			freeze=1
			var/sdelay=280*cdpow/100
			for(var/obj/jutsu/uchiha/Dragon_Flames_Jutsu/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)
				cdelay5=0
				copydelay3=0
			var/L=new/obj/dragonwire(loc)
			L:owner=usr
			L:dir=dir
			L:movequick(dir)
			sleep(8)
			freeze=0
			icon_state=""
			busy=null
			if(clan=="Copy Ninja")tactics()
		greatdragonflames()
			prejutsu()
			if(cdelay6||copydelay5||swim||dead||stun||resting||caught||seals||busy||imitated)return
			handseals(80,20,80)
			if(!sealpass)return
			view(8)<<"<font color=red>[usr]: Fire Style! Great Dragon Flames!"
			if(clan=="Copy Ninja")copydelay5=1
			else	cdelay6=1
			var/sdelay=300*cdpow/100
			for(var/obj/jutsu/uchiha/Great_Dragon_Flames/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)
				cdelay6=0
				copydelay5=0
			freeze=1
			icon_state="jutsu"
			spawn(7)
				freeze=0
				icon_state=""
			var/L=new/obj/greatdragonflames(loc)
			L:owner=usr
			L:dir=dir
			walk(L,dir)
			if(clan=="Copy Ninja")tactics()
		chidori()
			if(!sharingan)
				src<<"<b>Without the half mature Sharingan active, this jutsu can not be used."
				return
			prejutsu()
			if(cdelay4||swim||dead||stun||caught||seals||busy||!sharingan||imitated)return
			var/t=1+(0.08*tier33)
			if(tier53)t+=2
			var/g=10
			if(level>=38)g=5
			handseals(60*t,g,90)
			if(!sealpass)return
			cdelay4=1
			if(sharingan==4)
				if(kyuubimode)
					src<<"<center>Kyuubi locks the usage of this jutsu with his dark power."
					return
				var/sdelay=300*cdpow/100
				for(var/obj/jutsu/uchiha/Chidori/M in src)timerjutsu(sdelay,M)
				spawn(sdelay)cdelay4=0
				var/T1=new/obj/amaterasu(loc)
				usr.soundeff('fireunleash.wav',100,1)
				T1:owner=src
			else
				var/sdelay=900*cdpow/100
				for(var/obj/jutsu/uchiha/Chidori/M in src)timerjutsu(sdelay,M)
				spawn(sdelay)cdelay4=0
				stun=1
				busy="stun"
				view(8)<<"<font color=aqua><b>[usr]: Chidori!"
				icon_state="chidori"
				soundeff('chidori.wav',45,0)
				ovcheck()
				var/g2=25
				if(level>=65)g2=15
				if(level>=120)g2=2
				sleep(g2+snared*3)
				busy="chidori"
				if(level<95)spawn()chidorieffect()
				stun=0
				chidorimove()
				sleep(40)
				if(busy=="chidori")
					icon_state=""
					busy=null
					ovcheck()

		sasukechidori()
			if(src:chidori||swim||dead||stun||caught||seals||busy||!sharingan||imitated)return
			if(!sealpass)return
			freeze=1
			src:chidori=2
			view(8)<<"<font color=aqua><b>[usr]: Chidori!"
			overlays+=/obj/chidori
			soundeff('chidori.wav',45,0)
			sleep(21)
			src:chidori=1
			freeze=0
			for(var/mob/M in oview(16))
				step_towards(src,M)
			spawn(56)
			if(src:chidori==1)
				icon_state=""
				src:chidori=2
				overlays-=/obj/chidori
				spawn(200)
					src:chidori=0

		illusionhit(var/mob/M)
			illusion=0
			if(sharingan==4)
				new/obj/amatillusion(loc)
			else
				new/obj/illusion(loc)
				new/obj/randraven(loc)
				new/obj/randraven(loc)
				new/obj/randraven(loc)
				new/obj/randraven(loc)
				new/obj/randraven2(loc)
				new/obj/randraven2(loc)
				new/obj/randraven2(loc)
				new/obj/randraven2(loc)
				new/obj/randraven3(loc)
				new/obj/randraven3(loc)
				new/obj/randraven3(loc)
				new/obj/randraven3(loc)
				spawn(1)
					new/obj/randraven(loc)
					new/obj/randraven(loc)
				spawn(2)new/obj/randraven(loc)
			if(crowed)
				spawn(10*tier31*1.4)
					crowed=0
					atkdef()
			loc=M.loc
			moving=0
			if(M.dir==SOUTH)
				step(src,NORTH)
			if(M.dir==NORTH)
				step(src,SOUTH)
			if(M.dir==EAST)
				step(src,WEST)
			if(M.dir==WEST)
				step(src,EAST)
			if(level>=50)M.stun(7)
			if(sharingan==4)
				var/damage=pow*0.6
				M.dmgch(src,1)
				damage=(damage*M.variable)+M.variable2
				M.damage(damage)
				M.death(usr)

		piercinggaze()
			if(dead||copydelay4||marking||imitated||paralysed||caught||seals||busy)return
			if(clan=="Copy Ninja")copydelay4=1
			else	marking=1
			for(var/obj/jutsu/uchiha/Piercing_Gaze/M in src)timerjutsu(300,M)
			spawn(300)
				marking=0
				copydelay4=0
			new/obj/eyeac(loc)
			var/K=new/obj/piercinggaze(loc)
			K:owner=usr
			K:dir=dir
			if(dir==SOUTH)K:gazedir=NORTH
			if(dir==NORTH)K:gazedir=SOUTH
			if(dir==EAST)K:gazedir=WEST
			if(dir==WEST)K:gazedir=EAST
			var/K2
			var/K3
			if(level>=55||clan=="Copy Ninja")
				K2=new/obj/piercinggaze(loc)
				K2:owner=usr
				K2:dir=dir
				if(dir==SOUTH)
					K2:x++
					K2:gazedir=NORTH
				if(dir==NORTH)
					K2:x++
					K2:gazedir=SOUTH
				if(dir==EAST)
					K2:y++
					K2:gazedir=WEST
				if(dir==WEST)
					K2:y++
					K2:gazedir=EAST
				K3=new/obj/piercinggaze(loc)
				K3:owner=usr
				K3:dir=dir
				if(dir==SOUTH)
					K3:x--
					K3:gazedir=NORTH
				if(dir==NORTH)
					K3:x--
					K3:gazedir=SOUTH
				if(dir==EAST)
					K3:y--
					K3:gazedir=WEST
				if(dir==WEST)
					K3:y--
					K3:gazedir=EAST
			var/N=10
			while(N>0)
				N--
				if(K)step(K,dir)
				if(K2)step(K2,dir)
				if(K3)step(K3,dir)
			if(K)del K
			if(K2)del K2
			if(K3)del K3
			if(clan=="Copy Ninja")tactics()
		gazeproc(var/mob/M,var/R=1)
			snared(28/R,3)
			if(M.sharingan==4&&client)
				lockdown()
			if(client)
				var/obj/statuseffect/t=new/obj/statuseffect/piercinggaze
				debuffcount(28)
				t.screen_loc="[7+debuffa],16"
				client.screen+=t
				seffect(28,t)

		vengeance()
			prejutsu()
			if(lusted||swim||dead||stun||caught||seals||busy||imitated||paralysed)
				return
			view(8) << "<b><center><font color=red>[src] goes into a blood-crazed trance!"
			lusted = 1
			veng = 1
			new/obj/statuspop/bloodlust(loc)
			var/obj/statuseffect/t = new/obj/statuseffect/vengeance
			t.screen_loc = "15, 15"
			client.screen += t
			seffect((tier63 + 1) * 10, t)
			spawn((tier63 + 1) * 10)
				hp -= veng * (1 - (0.15 * tier63))
				new/obj/curse(loc)
				if(hp < 0)
					hp = 1
				if(mybar)
					mybar:updatebar()
				veng = 0
				ovcheck()
			for(var/obj/jutsu/uchiha/Vengeance/M in src)
				timerjutsu(2520, M)
			spawn(2520)
				lusted = 0

		refreshbodyill()
			if(clan=="Uchiha" && prob(25 * tier32))
				if(illusion1)
					for(var/obj/jutsu/uchiha/Body_Illusion/M in src)
						for(var/obj/timershade/F in src)
							if(F.screen_loc==M.screen_loc)del F
					illusion1=0
					new/obj/statuspop/bloodlust(loc)
					src << "<center>Willpower refreshed Body Illusion's cooldown."
					new/obj/randraven(loc)
					new/obj/randraven(loc)
					new/obj/randraven(loc)

		ignite(var/mob/M)
			if(!M || !M.tier61)
				return
			if(aff == M.aff)
				return
			if(!ignited)
				ignited = M.tier61+1
				if(M.sharingan == 4)
					ignitedamat = 1
				if(client)
					var/obj/statuseffect/t = new/obj/statuseffect/inferno
					debuffcount(M.tier61 * 14, "ibleed")
					t.screen_loc = "[7+debuffa],16"
					client.screen += t
					seffect(M.tier61 * 14,t)
				ovcheck()
				burnbaby(M)
			else
				ignited = M.tier61

		burnbaby(var/mob/M)
			if(ignited > 0 && M && !dead)
				ignited --
				var/damage = (hp * 0.01) + (maxhp * 0.01)
				if(ignitedamat)
					damage = (maxhp * 0.02)
				dmgch(M)
				damage = (damage * variable) + variable2
				damage(damage)
				death(M)
				if(ignited <= 0)
					ignited = 0
					ignitedamat = 0
					ovcheck()
					return
				spawn(14)
					if(M)
						burnbaby(M)
					else
						ignited = 0
						ignitedamat = 0
						ovcheck()
			else
				ignited = 0
				ignitedamat = 0
				ovcheck()

		mangoff()
			for(var/obj/jutsu/uchiha/Fireball_Jutsu/M in src)
				M.name="Fireball Jutsu"
				M.icon_state="fireball"
			for(var/obj/jutsu/uchiha/Phoenix_Flower_Jutsu/M in src)
				M.name="Phoenix Flower Jutsu"
				M.icon_state="phoenix flower"
			for(var/obj/jutsu/uchiha/Piercing_Gaze/M in src)
				M.name="Piercing Gaze"
				M.icon_state="piercing gaze"
			for(var/obj/jutsu/uchiha/Body_Illusion/M in src)
				M.name="Body Illusion"
				M.icon_state="body illusion"
			for(var/obj/jutsu/uchiha/Chidori/M in src)
				M.name="Chidori"
				M.icon_state="chidori"
			for(var/obj/jutsu/uchiha/Chidori_Current/M in src)
				M.name="Chidori Current"
				M.icon_state="current"
			var/sdelay=1200-70*tier12
			amatcd=1
			spawn(300*1.4)
				mangdef=0
				atkdef()
			for(var/obj/jutsu/uchiha/Mangekyou_Sharingan/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)amatcd=0

		hatred(var/mob/M)
			if(!corrupt)
				corrupt = 2
				atkdef()
				M.hate()
				sleep(100)
				if(M)
					corrupt = 1
					atkdef()
				sleep(650 - tier51 * 150)
				if(M)
					corrupt=0

		hate()
			hatred = 1
			ovcheck()
			spawn(140)
				hatred = 0
				ovcheck()

		invisflames()
			invisibility+=3
			var/image/I=image('baseinvis.dmi',src)
			I.vtype="invisbase"
			client.images+=I
			barloc()
			spawn(20)
				invisibility-=3
				client.images-=I
				barloc()

mob/var/ignitedamat= 0
mob/var/hatred = 0

mob/proc/chidorieffect()
	while(busy=="chidori"||busy=="raikiri")
		if(!client)return
		var/oldeye=client.eye
		client.eye=get_step(src,pick(NORTH,SOUTH,EAST,WEST))
		sleep(1)
		client.eye=oldeye

mob/proc/shakedown()
	while(snared)
		var/oldeye=client.eye
		client.eye=get_step(src,pick(NORTH,SOUTH,EAST,WEST))
		sleep(1)
		client.eye=oldeye

mob/proc/shakedown3()
	while(intut)
		var/oldeye=client.eye
		client.eye=get_step(src,pick(NORTH,SOUTH,EAST,WEST))
		sleep(1)
		client.eye=oldeye

mob/var/tmp
	crowed=0
	amatcd=0
	ignited=0
	tsukcd=0

obj
	ephemeral
		icon='ephmeral.dmi'
		density=1
		projint=2
		New()
			..()
			spawn()
			if(owner.level>=115)
				invisibility+=3
				spawn(3)invisibility-=3
			spawn(20)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(O.aff==D.aff)
					loc=D.loc
					return
				D.soundeff('bind.wav',20,1)
				D.snared(28,2)
				if(O.level>=88)D.notsee(28)
				if(O.tier42)
					O.hp+=O.pow*0.3*O.tier42
					if(O.hp>O.maxhp)O.hp=O.maxhp
					new/obj/heal(O.loc)
					if(O.mybar)O.mybar:updatebar()
				new/obj/randraven(loc)
				new/obj/randraven(loc)
				new/obj/randraven2(loc)
				new/obj/randraven2(loc)
				new/obj/randraven3(loc)
				new/obj/randraven3(loc)
				projectilep(O,D,O.pow*0.7)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)

	dragonwiretrail
		icon='dragonwire.dmi'
		density=0
		layer=15
		New()
			spawn(100)del src

	dragonwire
		icon='dragonwire.dmi'
		animate_movement=0
		layer=15
		density=1
		var/Fa=0
		projint=1
		New()
			spawn(100)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(O.busy!="wiring")del src
				if(D.illusion)
					D.illusionhit(O)
					return
				if(O.aff==D.aff)
					loc=D.loc
					return
				if(Fa>10)Fa=10
				D.stun(Fa*2+1)
				loc=D.loc
				O.busy=null
				O.freeze=0
				var/obj/crowclone/T=new(O.loc)
				T.icon=O.icon
				T.dir=O.dir
				O.soundeff('fireunleash.wav',45,0)
				T.overlays=O.overlays
				T.icon_state="spear"
				T.owner=O
				if(O.client)
					O.invisflames()
				icon_state="hit"
				var/obj/dragonwiretrail/TZ=new(loc)
				TZ.dir=D.dir
				TZ.owner=O
				TZ.icon_state="bind"
				freeze=1
				density=0
				var/obj/dragonflames/I=new(O.loc)
				I.owner=O
				I.dir=O.dir
				I.movequick(I.dir)
				spawn(Fa*2+1)del src
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)
		Move()
			if(freeze)return
			var/obj/dragonwiretrail/T=new(loc)
			T.dir=dir
			T.owner=owner
			if(!Fa)
				Fa=1
				T.icon_state="begin"
			else
				Fa++
			..()
		Del()
			var/mob/Y=owner
			if(Y)
				for(var/obj/dragonwiretrail/M in world)if(M.owner==Y)del M
				if(Y.busy=="wiring")
					Y.busy=null
					Y.freeze=0
					Y.icon_state=null
			..()
	proc
		impendingdemise()
			spawn(3)
			del src

	amatball
		density=1
		New()
			spawn(1)del src
		Move()
			..()
			for(var/atom/M in oview(src,1))
				if(M==owner)continue
				if(M.density)
					for(var/mob/A in range(3))
						var/mob/O=owner
						var/mob/D=A
						if(O.inchunin!=4)if(O!=D)if(O.aff==D.aff)continue
						if(D.illusion)
							D.illusionhit(O)
							continue
						var/damage=O.pow*0.9
						damage*=1+(O.tier22*0.08)
						D.soundeff('explosion3.wav',35,0)
						D.dmgch(O)
						damage=(damage*D.variable)+D.variable2
						D.damage(damage)
						D.death(O)
					blackburn(owner,75,15,3)

	dragonflames
		name="Dragon Flame Jutsu"
		icon='dragonflames.dmi'
		destro=1
		layer=15
		density=1
		animate_movement=0
		var/first=0
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				var/g=1
				D.soundeff('explosion3.wav',35,0)
				if(O.aff==D.aff)
					loc=D.loc
					return
				else D.ignite(O)
				if(O.clan=="Uchiha"&&O.tier31)g+=0.05+0.05*O.tier31
				if(O.clan!="Copy Ninja")projectilep(O,D,O.pow*0.7*(1+(O.tier22*0.08)))
				else	projectilep(O,D,O.pow*0.95)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)
			if(owner)
				if(owner.level>=70||owner.clan=="Copy Ninja")
					burn(owner,40,6,2)
				else
					burn(owner,40,6,0)
		Move()
			if(freeze)return
			var/mob/M=owner
			if(!M)del src
			var/obj/K=new/obj/proj/dragonfiretrail(loc)
			K.owner=src
			K.dir=dir
			if(!first)
				first=1
				K:icon_state="begin"
				K:layer=2
			..()
		Del()
			var/mob/M=owner
			if(!M)..()
			M.freeze=0
			M.icon_state=""
			for(var/obj/proj/dragonfiretrail/G in world)if(G.owner==src)del G
			freeze=1
			density=0
			sleep(5)
			..()

	chidoricurrent
		layer=80
		icon='chidoricurrent.dmi'
		pixel_x=-96
		pixel_y=-96
		New()
			..()
			flick("zap",src)
			spawn(8)del src

	susanoowave
		layer=80
		pixel_x=-64
		pixel_y=-64
		New()
			..()
			flick('susanoowave.dmi',src)
			spawn(8)del src

	amatillusion
		layer=80
		pixel_x=-32
		pixel_y=-32
		New()
			..()
			flick('amatillusion.dmi',src)
			spawn(8)del src

	illusion
		layer=20
		New()
			..()
			flick('illusion.dmi',src)
			spawn(8)del src

	susanoo
		layer=20
		icon='susanoo.dmi'
		icon_state="cage"
		pixel_x=-32
		pixel_y=-32

	susanooaura
		icon='susanoo.dmi'
		icon_state="aura"
		layer=2
		pixel_x=-32
		pixel_y=-32

	piercinggaze
		rundelay=0
		density=1
		var/gazedir
		Bump(mob/A)
			..()
			if(ismob(A))
				if(owner.aff==A.aff)loc=A.loc
				if(gazedir!=A.dir)
					if(owner.level>=85)
						A.gazeproc(owner,2)
					else del src
				else
					A.gazeproc(owner)
			del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(O.aff==D.aff)
					loc=D.loc
					return
				if(gazedir!=D.dir)
					if(O.level>=85)
						D.gazeproc(O,2)
					else del src
				else
					D.gazeproc(O)
				del src
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)

mob/var
	mangdef=0
	firestack=0