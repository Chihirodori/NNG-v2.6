mob/var
	matarmor=0
	matdelay=0
mob/proc
	sandleveling()
		if(level==2)
			src<<"<b><font color=lime>You have moulded a sand gourd with your chakra. While this gourd is equipped your punch is replaced with a ninjutsu based sand attack."
			src<<"<b><font color=lime>You have learned Sand Shuriken. Your throw button now shoots out sharp bursts of hardened sand. They have the damage and speed of kunais, aiming capabilities of shurikens and gets stronger with ninjutsu power."
			src<<"<b><font color=lime>You have learned Sand Suspension. Your throw toggle button now creates a cloud of sand that suspends you in the air and increase your movement speed to max. The cloud dissipates when you get damaged or attack."
			new/obj/items/equippable/Sand_Gourd(src)
		if(level==3)
			src<<"<b><font color=lime>You have learned Sand Shower. This jutsu fires a shower of sand that covers the enemy, slowing them down for 2 seconds and allowing you to use Sand Burial on them."
			new/obj/jutsu/sandc/Sand_Shower(src)
		if(level==5)
			src<<"<b><font color=lime>You have learned Sand Burial. This jutsu causes your sand that is covering any enemies to implode violently, dealing massive damage."
			new/obj/jutsu/sandc/Sand_Burial(src)
		if(level==7)
			src<<"<b><font color=lime>You have learned Sand Shield. While activated you become immobile and forms a shield that reduces damage by 90% and piercing damage by 50%. You can still use most attacks inside this shield but you can not use mobility jutsus shortly after you deactivate it."
			new/obj/jutsu/sandc/Sand_Shield(src)
		if(level==10)src<<"<b><font color=lime>Sand Shower is now level 2! The slow has been increased in magnitude and duration to 3 seconds."
		if(level==15)
			src<<"<b><font color=lime>You have learned Sand Armour. This jutsu forms a armour of sand that protects you from all damage until the armour is broken. This jutsu has a long casting time and heavy chakra cost so it's best to be used before fights."
			new/obj/jutsu/sandc/Sand_Armour(src)
		if(level==20)
			src<<"<b><font color=lime>Sand Burial is now level 2. The damage dealt is increased by 30%."
		if(level==25)
			src<<"<b><font color=lime><b>You have learned Sand Coffin. This jutsu creates a controllable wave of sand that encases the enemy with large amount of sand on contact. While trapped, the enemy takes 50% less damage except for sand burial, which will do 100% more damage. "
			new/obj/jutsu/sandc/Sand_Coffin(src)
		if(level==30)src<<"<b><font color=lime>Sand Shield is now level 2. You basic attack while in the shield now attacks in an area."
		if(level==32)src<<"<b><font color=lime>Sand Shower is now level 3. The cooldown is decreased by 30%."
		if(level==35)src<<"<b><font color=lime>Sand Shuriken is now level 2! It now makes the enemy flinch momentarily when struck."
		if(level==38)src<<"<b><font color=lime>Sand Armour is now level 2! It now impedes your movement less."
		if(level==40)
			src<<"<b><font color=lime>Sand Coffin is now level 2! The sand's speed is now much faster."
		if(level==45)
			src<<"<b><font color=lime>You have learned Shukaku's Pike. You can create a pike out of the hardest minerals of the earth, and throw it for massive piercing damage."
			new/obj/jutsu/sandc/Shukakus_Pike(src)
		if(level==52)src<<"<b><font color=lime>You have mastered Sand Shower! The chakra cost decreased by 20% and you don't have to use handseals to perform this jutsu anymore."
		if(level==60)
			src<<"<b><font color=lime>You have learned Sand Tsunami. This jutsu creates a massive torrent of sand towards you, burying anyone struck and knocking them towards you. The sand turns into quicksand that quickly sinks anyone that tries to walk in the sand. Buried targets take 150% more damage from sand burial."
			new/obj/jutsu/sandc/Sand_Tsunami(src)
		if(level==65)src<<"<b><font color=lime>You have mastered Sand Burial. You can now use it while you are controlling sand coffin."
		if(level==70)src<<"<b><font color=lime>You have mastered Sand Armour. The amount of damage it absorbs increased by 25%."
		if(level==75)src<<"<b><font color=lime>You have mastered Shukaku's Pike. It now fires at a much faster speed."
		if(level==80)src<<"<b><font color=lime>You have mastered Sand Shuriken. You now shoot sand shurikens in a wider area."
		if(level==95)src<<"<b><font color=lime>You have mastered Sand Coffin. You now take 40% less damage for 5 seconds after casting it."
		if(level==100)src<<"<b><font color=lime>You have mastered Sand Shield. The chakra cost is decreased by 30%."
		if(level==120)src<<"<b><font color=lime>You have mastered Sand Tsunami. The handseal time and channeling time is decreased by 50%."

mob/var/ultimatedefense=0
mob/proc
	ultimatedefense()
		ultimatedefense=1
		spawn(900)ultimatedefense=0
		var/T=new/obj/armorup(loc)
		T:dir=dir
		var/armorgod=pow*2
		if(level>=70)armorgod*=1.25
		armorgod*=tier61*0.5
		sandarmor+=armorgod
		if(hp<maxhp/20)
			hp+=maxhp/20
			sandarmor-=maxhp/20
			if(sandarmor<0)sandarmor=200
	sandarmour()
		prejutsu()
		if(sandarmor)
			sandarmor=0
			new/obj/armordown(loc)
			return
		if(cdelay4||swim||attacking||dead||resting||stun||busy&&busy!="shield"||moving||seals||imitated)return
		cdelay4=1
		if(tier52)handseals(200*(0.95-(tier52*0.15)),80*(0.95-(tier52*0.15)))
		else handseals(200,80)
		if(!sealpass)
			cdelay4=0
			return
		var/sdelay=800*cdpow/100
		for(var/obj/jutsu/sandc/Sand_Armour/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay4=0
		freeze=1
		var/T
		if(key=="JillyBear")T=new/obj/armorupb(loc)
		else T=new/obj/armorup(loc)
		T:dir=dir
		sleep(10)
		freeze=0
		sandarmor=pow*2.5
		if(level>=70)sandarmor*=1.25
	sandreserve()
		prejutsu()
		if(wpalming||swim||dead||stun||caught||seals||busy||imitated||paralysed)return
		view(8)<<"<b><center>[src] tapped their sand reserve!"
		wpalming=1
		cha+=maxcha*(0.1+0.1*tier33)
		if(cha>maxcha)cha=maxcha
		mybar2:updatebar()
		new/obj/statuspop/snapregen(loc)
		var/sdelay=750*cdpow/100
		for(var/obj/jutsu/sandc/Tap_Sand_Reserve/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)wpalming=0
	sandshower()
		prejutsu()
		if(cdelay2||swim||attacking||dead||resting||stun||busy&&busy!="shield"||moving||seals||imitated)return
		cdelay2=1
		handseals(30,5,20)
		if(!sealpass)
			cdelay2=0
			return
		var/sdelay=160*cdpow/100
		if(level>=32)sdelay*=0.7
		for(var/obj/jutsu/sandc/Sand_Shower/M in src)timerjutsu(sdelay,M)
		for(var/obj/jutsu/sandc/Sand_Barrage/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay2=0
		var/T
		var/L2
		var/L3
		soundeff('sandshower.wav',40,0)
		if(!tier51)
			T=new/obj/sandshower(loc)
			L2=new/obj/sandshower(loc)
			L3=new/obj/sandshower(loc)
		else
			T=new/obj/sandbarrage(loc)
			L2=new/obj/sandbarrage(loc)
			L3=new/obj/sandbarrage(loc)
		if(dir==NORTH||dir==SOUTH)
			L2:loc=locate(x+1,y,z)
			L3:loc=locate(x-1,y,z)
		if(dir==EAST||dir==WEST)
			L2:loc=locate(x,y+1,z)
			L3:loc=locate(x,y-1,z)
		if(key=="JillyBear")
			T:icon='psandshower.dmi'
			L2:icon='psandshower.dmi'
			L3:icon='psandshower.dmi'
		T:dir=dir
		L2:dir=dir
		L3:dir=dir
		T:owner=src
		step(T,dir,2)
		walk(T,dir,2)
		L2:owner=src
		step(L2,dir,2)
		walk(L2,dir,2)
		L3:owner=src
		step(L3,dir,2)
		walk(L3,dir,2)
	sandshell()
		prejutsu()
		if(busy=="shield"||sandshield)
			shelloff()
			return
		if(cha<maxcha*(0.08-tier41*0.01)||swim||dead||stun||imitated||paralysed||resting||caught||seals||imitated||paralysed||cdelay1)return
		if(busy==null)
			sandshield=1
			atkdef()
			busy="shield"
			cha-=maxcha*(0.08-tier41*0.01)
			mybar2:updatebar()
			cdelay1=1
			var/F=new/obj/sandbarrier(loc)
			if(key=="JillyBear")
				F:icon='psandshellf.dmi'
			F:owner=src
			shellchakra()
	shukakusspear()
		prejutsu()
		if(cdelay5||swim||dead||resting||stun||busy||freeze||moving||imitated||paralysed)return
		cdelay5=1
		handseals(45,5,35)
		if(!sealpass)
			cdelay5=0
			return
		freeze=1
		icon_state="spear"
		var/obj/L=new/obj/shukakusspearp(loc)
		L.owner=src
		L.dir=dir

		//
		var/obj/q=new/obj/shukakus/tip(loc)
		var/obj/r=new/obj/shukakus/end(loc)
		if(dir==SOUTH)
			q.pixel_y=-32
			q.pixel_x=2
			r.pixel_y=32
		if(dir==NORTH)
			q.pixel_y=32
			q.pixel_x=-6
			r.pixel_y=-32
		if(dir==EAST)
			q.pixel_x=32
			q.pixel_y=2
			r.pixel_x=-32
		if(dir==WEST)
			q.pixel_x=-32
			r.pixel_x=32
			q.pixel_y=2
		q.dir=dir
		r.dir=dir
		L.overlays+=q
		L.overlays+=r
		//
		var/wait=2
		spawn(wait)
			soundeff('puff.wav',40,0)
			freeze=0
			icon_state=""
			L.layer=10
			flick("attack",src)
			if(level<75)
				walk(L,dir)
			else
				L.movequick(dir)
		var/sdelay=300*cdpow/100
		for(var/obj/jutsu/sandc/Shukakus_Pike/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay5=0
	sandcoffin()
		if(icon_state=="jutsu"&&freeze==1)
			for(var/obj/coffinmove/M in world)if(M.owner==src)flick("fall",M)
			for(var/obj/coffinmovetrail/M in world)if(M.owner==src)flick("fall",M)
			coffinoff()
			return
		prejutsu()
		if(swim||cdelay3||dead||stun||teleport||resting||busy||caught||seals||!cha||imitated||paralysed)return
		handseals(35,15,45)
		if(!sealpass)return
		cdelay3=1
		var/sdelay=300*cdpow/100
		for(var/obj/jutsu/sandc/Sand_Coffin/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay3=0
		busy="coffin"
		if(level>=95)
			coffinshield=1
			atkdef()
			spawn(50)
				atkdef()
				coffinshield=0
			//makeiconforthis
		view(8)<<"<font color='#E0A175'>[usr]: Sand Coffin!"
		freeze=1
		icon_state="jutsu"
		sleep(3)
		soundeff('sandshower.wav',40,0)
		var/obj/K=new/obj/coffinmove(loc)
		K.owner = usr
		K.dir = dir
		K.shadowstep = K.dir
		if(!K)
			for(var/obj/coffinmove/M in world)if(M.owner==src)flick("fall",M)
			for(var/obj/coffinmovetrail/M in world)if(M.owner==src)flick("fall",M)
			coffinoff()
			return
		for(var/obj/coffinmovetrail/M in loc)
			M.icon_state="begin"
			if(dir==NORTH)layer=2
			step(M,dir)
		sleep(2)
		if(!K)
			for(var/obj/coffinmove/M in world)if(M.owner==src)flick("fall",M)
			for(var/obj/coffinmovetrail/M in world)if(M.owner==src)flick("fall",M)
			coffinoff()
			return
		var/N=32
		var/speedy=2
		if(level>=40)speedy=1
		loop
			if(N>0)
				N --
				if(K)
					step(K, K:dir)
					spawn(speedy)
						goto loop
			else
				for(var/obj/coffinmove/M in world)if(M.owner==src)flick("fall",M)
				for(var/obj/coffinmovetrail/M in world)if(M.owner==src)flick("fall",M)
				spawn(5)
					coffinoff()
					del K
	sandburial()
		prejutsu()
		if(swim||dead||caught||busy&&busy!="shield"&&busy!="coffin"||seals||stun||imitated||paralysed)return
		if(busy=="coffin"&&level<65)return
		var/T=0
		for(var/mob/M in oview(10))if(M.coffined&&M.coffinby==src||M.sandcount>=3)T=1
		if(!T)return
		handseals(25,0)
		if(!sealpass)return
		for(var/mob/M in oview(10))
			if(aff==M.aff)continue
			if(M.sandcount>=3)
				M.lingeringdelay=1
				soundeff('mountain.wav',40,0)
				spawn(140)if(M)M.lingeringdelay=0
				M.sandcount=0
				M.overlays-=/obj/lingeringsand
				M.freeze++
				new/obj/lingeringburial(M.loc)
				spawn(7)
					if(M)
						var/damage=round(pow*1.15*(0.2+0.1*tier11))
						if(level>=20)damage*=1.3
						M.dmgch(src,0,"burial")
						damage=(damage*M.variable)+M.variable2
						M.damage(damage)
						if(tier42)
							new/obj/statuspop/internalbleeding(M.loc)
							if(M)
								if(M.bleeding)spawn()M.bleeding2(1+3*tier42,M.maxhp/400,src)
								else spawn()M.bleeding2(1+3*tier42,M.maxhp/200,src)
						if(!M)return
						M.snared(30,4)
						M.stun(10)
						M.death(src)
						spawn(3)
						if(M)
							if(!M.dead)
								M.freeze--
								if(tier43)M.magnetic(src,tier43)
								if(tier23)M.snared(30,1+tier23)
			if(!M)continue
			if(M.coffinby!=src)continue
			switch(M.coffined)
				if(3)
					M.coffined=0
					M.coffinby=null
					M.overlays-=/obj/showerslow
					new/obj/showerburial(M.loc)
					soundeff('mountain.wav',40,0)
					M.freeze=1
					spawn(7)
						if(M)
							M.dir=SOUTH
							var/damage=round(pow*1.15)
							if(level>=20)damage*=1.3
							M.dmgch(src,0,"burial")
							damage=(damage*M.variable)+M.variable2
							M.damage(damage)
							if(M.hp<=0)M.smite=1
							else
								if(tier42)
									new/obj/statuspop/internalbleeding(M.loc)
									if(M.bleeding)spawn()M.bleeding2(1+3*tier42,M.maxhp/400,src)
									else spawn()M.bleeding2(1+3*tier42,M.maxhp/200,src)
							if(!M)return
							M.death(src)
							spawn(3)
							if(M)
								if(!M.dead)
									M.freeze=0
									if(tier43)M.magnetic(src,tier43)
									if(tier23)M.snared(30,1+tier23)
				if(1)
					M.overlays-=/obj/sandcoffin
					M.overlays-=/obj/bsandcoffin
					new/obj/sandcoffinb(M.loc)
					var/damage=round(pow*2.3)
					soundeff('mountain.wav',40,0)
					if(level>=20)damage*=1.3
					M.dmgch(src,0,"burial")
					damage=(damage*M.variable)+M.variable2
					M.damage(damage)
					M.coffined=0
					M.coffinby=null
					if(tier62&&M.hp<=M.maxhp*(0.04+(0.04*tier62))&&M.rank!="Bijuu")
						M.hp=0
						range(14)<<"<font color=red><center>[src] annihilated [M]."
					if(M.hp<=0)M.smite=1
					else
						if(tier42)
							new/obj/statuspop/internalbleeding(M.loc)
							if(M.bleeding)spawn()M.bleeding2(1+3*tier42,M.maxhp/200,src)
							else spawn()M.bleeding2(1+3*tier42,M.maxhp/100,src)
					if(!M)return
					M.death(src)
					spawn(7)
						if(M)
							if(!M.dead)
								M.freeze=0
								M.busy=null
								if(tier43)M.magnetic(src,tier43)
								if(tier23)M.snared(30,1+tier23)
				if(2)
					new/obj/sandtsunamib(M.loc)
					M.coffined=0
					M.coffinby=null
					soundeff('mountain.wav',40,0)
					M.overlay()
					spawn(4)
						if(M)
							var/damage=round(pow*2.3)
							if(level>=20)damage*=1.3
							M.dmgch(src,0,"burial")
							damage=(damage*M.variable)+M.variable2
							M.damage(damage)
							if(tier62&&M.hp<=M.maxhp*(0.04+(0.04*tier62)))
								M.hp=0
								range(14)<<"<font color=red><center>[src] annihilated [M]."
							if(M.hp<=0)M.smite=1
							else
								if(tier42)
									new/obj/statuspop/internalbleeding(M.loc)
									if(M.bleeding)spawn()M.bleeding2(1+3*tier42,M.maxhp/200,src)
									else spawn()M.bleeding2(1+3*tier42,M.maxhp/100,src)
							if(!M)return
							M.death(src)
							spawn(3)
								if(M)
									if(!M.dead)
										M.freeze=0
										M.busy=null
										if(tier43)M.magnetic(src,tier43)
										if(tier23)M.snared(30,1+tier23)
	sandtsunami()
		if(kyuubimode)
			src<<"<center>Kyuubi locks the usage of this jutsu with his dark power."
			return
		prejutsu()
		if(cdelay6||x<11||y<11||x>489||y>489||swim||dead||stun||busy&&busy!="shield"||caught||seals||busy||z==1||imitated||paralysed)return
		cdelay6=1
		if(level<120)handseals(220,35,60)
		else
			handseals(220,20,60)
		if(!sealpass)
			cdelay6=0
			return
		view(8)<<"<b><font color='#E0A175'>[usr]: Sand...."
		stun=1
		busy="stun"
		icon_state="jutsu"
		if(level<120)sleep(25)
		else sleep(21)
		view(8)<<"<b><font color='#E0A175'>[usr]: TSUNAMI!"
		spawn(34)
			stun=0
			icon_state=""
			busy=null
		var/obj/proj/Tsunami_Creation/A=new(loc)
		var/obj/proj/Tsunami_Creation/B=new(loc)
		var/obj/proj/Tsunami_Creation/C=new(loc)
		var/obj/proj/Tsunami_Creation/D=new(loc)
		var/obj/proj/Tsunami_Creation/E=new(loc)
		var/obj/proj/Tsunami_Creation/F=new(loc)
		var/obj/proj/Tsunami_Creation/G=new(loc)
		var/obj/proj/Tsunami_Creation/H=new(loc)
		var/obj/proj/Tsunami_Creation/I=new(loc)
		soundeff('sandshower.wav',60,0)
		spawn(5)soundeff('sandshower.wav',60,0)
		spawn(10)soundeff('sandshower.wav',60,0)
		spawn(15)soundeff('sandshower.wav',60,0)
		spawn(20)soundeff('sandshower.wav',60,0)
		if(dir==NORTH)
			A.loc=locate(x,y+10,z)
			B.loc=locate(x+1,y+10,z)
			C.loc=locate(x-1,y+10,z)
			D.loc=locate(x+2,y+10,z)
			E.loc=locate(x-2,y+10,z)
			F.loc=locate(x+3,y+10,z)
			G.loc=locate(x-3,y+10,z)
			H.loc=locate(x+4,y+10,z)
			H.typez=2
			I.loc=locate(x-4,y+10,z)
			I.typez=1
		if(dir==EAST)
			A.loc=locate(x+10,y,z)
			B.loc=locate(x+10,y+1,z)
			C.loc=locate(x+10,y-1,z)
			D.loc=locate(x+10,y+2,z)
			E.loc=locate(x+10,y-2,z)
			F.loc=locate(x+10,y-3,z)
			G.loc=locate(x+10,y+3,z)
			H.loc=locate(x+10,y+4,z)
			H.typez=1
			I.loc=locate(x+10,y-4,z)
			I.typez=2
		if(dir==SOUTH)
			A.loc=locate(x,y-10,z)
			B.loc=locate(x+1,y-10,z)
			C.loc=locate(x-1,y-10,z)
			D.loc=locate(x+2,y-10,z)
			E.loc=locate(x-2,y-10,z)
			F.loc=locate(x+3,y-10,z)
			G.loc=locate(x-3,y-10,z)
			H.loc=locate(x+4,y-10,z)
			H.typez=2
			I.loc=locate(x-4,y-10,z)
			I.typez=1
		if(dir==WEST)
			A.loc=locate(x-10,y,z)
			B.loc=locate(x-10,y+1,z)
			C.loc=locate(x-10,y-1,z)
			D.loc=locate(x-10,y+2,z)
			E.loc=locate(x-10,y-2,z)
			F.loc=locate(x-10,y-3,z)
			G.loc=locate(x-10,y+3,z)
			H.loc=locate(x-10,y+4,z)
			H.typez=1
			I.loc=locate(x-10,y-4,z)
			I.typez=2
		A.owner=src
		B.owner=src
		C.owner=src
		D.owner=src
		E.owner=src
		F.owner=src
		G.owner=src
		H.owner=src
		I.owner=src
		for(var/obj/proj/Tsunami_Creation/M in range(12))if(M.owner==src)
			var/supdir
			if(dir==SOUTH)supdir=NORTH
			if(dir==NORTH)supdir=SOUTH
			if(dir==EAST)supdir=WEST
			if(dir==WEST)supdir=EAST
			if(key=="JillyBear")
				M.icon='psandwave.dmi'
			M.dir=supdir
			M.icon_state="begin[M:typez]"
			walk(M,supdir,2)
		var/sdelay=1500*cdpow/100
		for(var/obj/jutsu/sandc/Sand_Tsunami/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay6=0
obj/sandcoffin
	layer=35
	name="Sand Coffin"
	icon='sandcoffin.dmi'
	pixel_x=-32
obj/twister
	layer=70
	name="Twister"
	icon='twister.dmi'
	pixel_x=-16
	pixel_y=-16
	New()
		..()
		flick('twister.dmi',src)
		spawn(21)del src
obj/sandcoffinb
	layer=35
	name="Sand Coffin"
	pixel_x=-32
	New()
		..()
		flick('sandfuneral.dmi',src)
		spawn(13)del src
obj/bsandcoffin
	layer=35
	name="Sand Coffin"
	icon='psandcoffin.dmi'
	pixel_x=-32
obj/bsandcoffinb
	layer=35
	name="Sand Coffin"
	pixel_x=-32
	New()
		..()
		flick('psandfuneral.dmi',src)
		spawn(13)del src
obj/bsandtsunamib
	layer=35
	icon='psandwavebury.dmi'
	icon_state="leblanc"
	name="Sand Burial"
	New()
		..()
		flick("burial",src)
		spawn(13)del src
obj/sandtsunamib
	layer=35
	icon='sandwavebury.dmi'
	icon_state="leblanc"
	name="Sand Burial"
	New()
		..()
		flick("burial",src)
		spawn(13)del src
mob/proc
	coffinsuf(M)
		while(M&&coffined)
			hp-=hp*0.01
			death(M)
			sleep(5)
	coffined(var/mob/M)
		var/T=30
		if(M.tier53)
			T+=5+M.tier53*5
			spawn()coffinsuf(M)
		spawn(T)
			overlays-=/obj/sandcoffin
			overlays-=/obj/bsandcoffin
			busy=null
			freeze=0
			coffined=0
			coffinby=null
	twistered(var/mob/M)
		if(aff==M.aff)return
		if(prob(5+M.tier63*5)&&!freeze&&!busy)
			new/obj/twister(loc)
			pixel_y+=6
			busy="twister"
			freeze=1
			var/t=7
			while(t)
				sleep(1)
				t--
				switch(dir)
					if(EAST)dir=SOUTH
					if(SOUTH)dir=WEST
					if(WEST)dir=NORTH
					if(NORTH)dir=EAST
			pixel_y-=6
			busy=null
			freeze=0
	sandwave(var/mob/M)
		if(sandwavedelay)return
		busy="coffined"
		freeze=1
		coffined=2
		coffinby=M
		overlay()
		sandwavedelay=1
		spawn(200)sandwavedelay=0
		spawn(140)
			if(coffined==2)
				busy=null
				freeze=0
				coffined=0
				coffinby=null
				overlay()
mob/var
	sandwavedelay=0
	sandcount=0
obj
	coffinmove
		icon = 'sandcoffinshoot.dmi'
		name="Sand Snake"
		animate_movement=0
		density=1

		rundelay=0
		var
			oldtrack = null
			First = 0
		New()
			..()
			spawn(70)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(D.clone)
					del D
					return
				if(D.shield)
					loc=D.loc
					return
				if(D.aff==O.aff)
					loc=D.loc
					return
				range(O,8)<<"<b>[D] has been caught by [O]'s Sand Coffin!"
				D.breakresting()
				O.busy=null
				D.freeze=1
				D.busy="coffined"
				D.coffined=1
				D.coffinby=O
				D.overlays+=/obj/sandcoffin
				O.icon_state=""
				D.coffined(O)
				del src
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					owner.coffinoff()
					del src
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					loc=T.loc
		Move()
			if(First == 0)
				First ++
				..()
				return
			var/mob/O=owner
			var/obj/coffinmovetrail/K = new(loc)
			K.icon = icon
			sleep(-1)
			K.dir = dir
			if(oldtrack == NORTH)
				if(K.dir == EAST)
					K.dir = NORTHEAST
				if(K.dir == WEST)
					K.dir = NORTHWEST
			if(oldtrack == SOUTH)
				if(K.dir == EAST)
					K.dir = SOUTHEAST
				if(K.dir == WEST)
					K.dir = SOUTHWEST
			if(oldtrack == EAST)
				if(K.dir == NORTH)
					K.dir = SOUTHWEST
				if(K.dir == SOUTH)
					K.dir = NORTHWEST
			if(oldtrack == WEST)
				if(K.dir == NORTH)
					K.dir = SOUTHEAST
				if(K.dir == SOUTH)
					K.dir = NORTHEAST
			oldtrack = src.dir
			K.owner = O
			K.shadowstep = K.dir
			..()
		Del()
			var/mob/O=owner
			if(O)
				O.freeze=0
				O.icon_state=""
				O.busy=null
			for(var/obj/coffinmovetrail/M in world)if(M.owner==O)del M
			..()
	coffinmovetrail
		name=""
		icon_state="trail"

		rundelay=0
		animate_movement=2
		Move()
			..()
			dir=shadowstep
mob/var
	tmp/coffined=0
	tmp/coffinby=null
	tmp/lingeringdelay=0
obj
	sandbarrage
		name=""
		icon_state="barhead"
		icon='sandshower.dmi'
		density=1
		rundelay=0
		layer=38
		projint=2
		var/moveeee=0
		var/intensity=1
		New()
			..()
			spawn(12)del src
		Move()
			if(moveeee)
				var/obj/T=new/obj/sandbarraget(loc)
				T.dir=dir
			else
				moveeee=1
			..()
			intensity+=0.25
			if(intensity>3)intensity=3
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				loc=D.loc
				if(D.shield)return
				if(O.aff==D.aff)return
				D.showerslow(35+10*O.tier23,5+O.tier22,O)
				projectilep(O,D,(O.pow/3)*0.6*intensity*(0.8+0.4*O.tier51))
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)
	sandbarraget
		icon='sandshower.dmi'
		layer=30
		New()
			..()
			flick("bartrail",src)
			spawn(7)del src
	sandshower
		name=""
		icon='sandshower.dmi'
		density=1
		projint=1
		rundelay=0
		layer=38
		var/moveeee=0
		New()
			..()
			flick("head",src)
			spawn(12)del src
		Move()
			if(moveeee)
				var/obj/T=new/obj/sandshowert(loc)
				T.dir=dir
			else
				moveeee=1
			..()
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				loc=D.loc
				if(O.aff==D.aff)return
				if(O.level<10)D.showerslow(20,3,O)
				else D.showerslow(35+10*O.tier23,5+O.tier22,O)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)
	sandshowert
		icon='sandshower.dmi'
		layer=30
		New()
			..()
			flick("trail",src)
			spawn(7)del src
	showerslow
		icon='showerslow.dmi'
		layer=35
		New()
			..()
			spawn(120)del src
	showerburial
		icon='showerslow.dmi'
		layer=37
		icon_state="leblanc"
		New()
			..()
			flick("burial",src)
			spawn(14)del src
	lingeringsand
		icon='lingeringsand.dmi'
		layer=35
		New()
			..()
			spawn(120)del src
	lingeringburial
		icon='lingeringsand.dmi'
		layer=37
		icon_state="leblanc"
		New()
			..()
			flick("burial",src)
			spawn(14)del src
mob/var/coffinshield=0
mob/proc/showerslow(var/N,var/S,var/M)
	new/obj/slowed(loc)
	overlays+=/obj/showerslow
	snared(N,S)
	coffined=3
	coffinby=M
	if(client)
		var/obj/statuseffect/t=new/obj/statuseffect/sandshower
		debuffcount(N)
		t.screen_loc="[7+debuffa],16"
		client.screen+=t
		seffect(N,t)
	spawn(N)
		if(coffined==3)
			coffined=0
			coffinby=null
		overlays-=/obj/showerslow
mob/proc/snared(var/N,var/S)
	if(shield)
		return
	snared += S
	slow = snared
	if(slow > 4)
		slow = 4
	new/obj/slowed(loc)
	var/time=N
	if(byakugan)time*=0.75
	if(clan=="Taijutsu Specialist" && tier43)time*=1-(tier43*0.1)
	spawn(time)
		snared -= S
		if(snared < 0)
			snared = 0
		slow = snared
		if(slow > 4)
			slow = 4
mob/var/slow=0
mob/proc/silenced(var/N)
	silenced++
	silencecheck()
	spawn(N)
		silenced--
		if(silenced<0)silenced=0
		silencecheck()
mob/proc/venom()
	venom++
	venomcheck()
	spawn(420)
		venom--
		venomcheck()
mob/proc/sandcount(var/mob/M)
	if(lingeringdelay)return
	sandcount++
	overlays-=/obj/lingeringsand
	if(sandcount>=3)
		overlays+=/obj/lingeringsand
	spawn(30+M.tier11*20)
		if(sandcount)
			sandcount--
			if(sandcount==2)overlays-=/obj/lingeringsand