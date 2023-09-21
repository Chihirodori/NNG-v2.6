mob/var
	stunted=0
	skyblade
	hostamount=0
	host1eff=0
	host2eff=0
	host3eff=0
	venom=0
	tmp/regencd=0
obj
	absorber
		New()
			spawn(50)
				while(owner)
					sleep(50)
				del src
	chakrasuck
		icon='chakrasuck.dmi'
		layer=20
		one
			New()
				flick("1",src)
				spawn(15)del src
		two
			New()
				flick("2",src)
				spawn(15)del src
mob/proc
	snakeregen(var/tmp/T)
		var/tmp/ss = 6
		var/tmp/heal=T
		if(tier33)
			heal *= 1+(tier33*0.05)
			var/missinghp=(maxhp-hp)/50
			heal *= 1+(missinghp*0.01)
		heal=round(heal)
		regencd=1
		loop
			if(ss)
				hp += round(heal/6)
				if(hp > maxhp)hp = maxhp
				new/obj/heal(loc)
				if(mybar)mybar:updatebar()
				ss --
				spawn(5)goto loop
			else
				regencd=0
	snakeleveling()
		if(level==2)
			src<<"<b><font color=cyan>You have learned Striking Shadow Snake. You create a clone in your location that fires a snake in front of you, wrapping the first enemy struck. The enemy is binded for 1.5 second for moderate damage. You are invisible during the duration of this ability."
			new/obj/jutsu/snake/Striking_Shadow_Snake(src)
		if(level==6)
			src<<"<b><font color=cyan>You have learned Chakra Absorption. You channel the chakra from a massive area in front of you, taking 16% of the enemy's maximum chakra per second for up to 3 seconds. The enemy regenerates 80% of their lost chakra over 10 seconds."
			new/obj/jutsu/snake/Chakra_Absorption(src)
		if(level==10)
			src<<"<b><font color=cyan>You have summoned a Sword of Kusanagi. This blade charges damage every second and unleash it when you attack."
			new/obj/items/equippable/Sword_of_Kusanagi(src)
		if(level==12)
			src<<"<b><font color=cyan>You have learned Sky Blade. You fire 2 waves of fast kusanagi blades in the direction you're facing, dealing high physical damage. The waves of blades fire in the direction you were in when you activate this ability, regardless of your direction after you activate this."
			new/obj/jutsu/snake/Sky_Blade(src)
		if(level==15)src<<"<b><font color=cyan>Striking Shadow Snake is now level 2. You can now press the skill again after you bind a enemy to pull the enemy to your clone."
		if(level==20)src<<"<b><font color=cyan>Chakra Absorption is now level 2. This ability now lasts 4 seconds."
		if(level==22)src<<"<b><font color=cyan>Sky Blade is now level 2. You now fire 3 waves of blades."
		if(level==25)
			src<<"<b><font color=cyan>You have learned Binding Snake Glare. After a delay, you root enemies within 2 tiles around you, binding and dealing damage to them for 2 seconds."
			new/obj/jutsu/snake/Binding_Snake_Glare(src)
		if(level==28)
			src<<"<b><font color=cyan>You have learned Immortality Jutsu. Use this jutsu on a dead body to obtain a body host. You sacrifice the body host when you die and you get resurrected for up to 30% health. The effectiveness of the jutsu depends on the quality of the body. You suffer a temporary defense reduction and lower health from a low quality body. Additional body hosts replace the current body host if the quality is better."
			new/obj/jutsu/snake/Immortality_Jutsu(src)
		if(level==32)src<<"<b><font color=cyan>Striking Shadow Snake is now level 3. You can now press the skill while the snake is flying through the air to create a blade in the mouth of the snake, causing it to fly faster, pierces, and strike a wider area."
		if(level==35)
			src<<"<b><font color=cyan>Chakra Absorption is now level 3.  You now sake 20% chakra per second."
		if(level==40)
			src<<"<b><font color=cyan>You have learned Edo Tensei. Summons the soul you have captured. They will fight for you for 10 seconds. They have 75% of the stats of the original soul and can use jutsus based on the captured soul's clan."
			new/obj/jutsu/snake/Edo_Tensei(src)
			src<<"<b><font color=cyan>Binding Snake Glare is now level 2. You can press the jutsu again on enemies under 10% health to instantly kill them and capturing their soul for Edo Tensei if you don't have a active soul."
		if(level==45)src<<"<b><font color=cyan>Sky Blade is now level 3. The blades now slow the enemy down."
		if(level==50)src<<"<b><font color=cyan>Striking Shadow Snake is now mastered. The bind now lasts 2 seconds and the cooldown is reduced by 20%."
		if(level==55)src<<"<b><font color=cyan>Immortality Jutsu is now level 2. You can obtain a second body host. "
		if(level==60)src<<"<b><font color=cyan>Binding Snake Glare is now level 3. The windup time decreased."
		if(level==65)src<<"<b><font color=cyan>Sky Blade is now mastered. You now deal 30% less damage with the blades, but it now fires 7 waves."
		if(level==70)src<<"<b><font color=cyan>Edo Tensei is now level 2. It now lasts 20 seconds."
		if(level==75)src<<"<b><font color=cyan>Immortality Jutsu is now level 3. You can now get resurrected to up to 45% health."
		if(level==80)src<<"<b><font color=cyan>Chakra Absorption is now mastered. You can now drain up to 5 seconds."
		if(level==88)src<<"<b><font color=cyan>Edo Tensei is now level 3. You can press this jutsu again sacrifice your Edo Tensei to increase your attack power and ninjutsu power by 25% of your Edo Tensei's for 10 seconds."
		if(level==92)src<<"<b><font color=cyan>Binding Snake Glare is now mastered. The range increased."
		if(level==100)src<<"<b><font color=cyan>Immortality Jutsu is now mastered. You can obtain a third body host. "
		if(level==110)src<<"<b><font color=cyan>Edo Tensei is now mastered. Your Edo Tensei gains a deathly aura, absorbing 1% of its nearby enemies max health every second."
	stunted()
		stunted++
		if(stunted==1)if(mybar)mybar:overlays+=/obj/barline/stunted
		spawn(70)
			stunted--
			if(stunted==0)if(mybar)mybar:overlays-=/obj/barline/stunted
	skyblade()
		prejutsu()
		if(cdelay3||swim||dead||stun||resting||caught||seals||busy||imitated||paralysed)return
		skyblade=dir
		handseals(65,8,40)
		if(!sealpass)return
		cdelay3=1
		var/sdelay=200*(cdapow/100)
		for(var/obj/jutsu/snake/Sky_Blade/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)
			cdelay3=0
		var/waves=2
		if(level>=22)waves=3
		if(level>=65)waves=7
		while(waves)
			waves--
			var/obj/F=new/obj/skyblade(loc)
			var/obj/F2=new/obj/skyblade(loc)
			var/obj/F3=new/obj/skyblade(loc)
			F.owner=src
			F2.owner=src
			F3.owner=src
			soundeff('throw3.wav',40,0)
			if(skyblade==NORTH||skyblade==SOUTH)
				F2.x--
				F3.x++
			if(skyblade==EAST||skyblade==WEST)
				F2.y--
				F3.y++
			F.movequick(skyblade)
			F2.movequick(skyblade)
			F3.movequick(skyblade)
			sleep(3)
	chakraabs()
		prejutsu()
		if(cdelay2||copydelay3||silenced||swim||dead||stun||resting||caught||seals||busy||imitated||paralysed)return
		if(clan=="Copy Ninja")copydelay3=1
		else	cdelay2=1
		var/sdelay=650*(cdpow/100)
		for(var/obj/jutsu/snake/Chakra_Absorption/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)
			cdelay2=0
			copydelay3=0
		var/tmp/here=loc
		icon_state="jutsu"
		var/obj/F=new/obj/absorber(loc)
		F.owner=src
		step(F,dir)
		step(F,dir)
		step(F,dir)
		step(F,dir)
		step(F,dir)
		var/absorbtimes=6
		if(level>=20)absorbtimes=8
		if(level>=80)absorbtimes=10
		while(loc==here&&absorbtimes&&!dead&&!silenced&&!stun)
			absorbtimes--
			new/obj/chakrasuck/one(loc)
			for(var/mob/M in range(F,4))
				if(aff==M.aff||M.isanimal||M.npc)continue
				new/obj/chakrasuck/two(M.loc)
				var/chaa=M.maxcha*0.9
				if(level>=35)chaa=M.maxcha*0.12
				M.cha-=chaa
				M.charegenback(chaa*0.8)
				if(M.mybar2)M.mybar2:updatebar()
				if(tier31||clan=="Copy Ninja")
					M.superholy(-tier31)
					superholy(tier31)
					new/obj/airboom(M.loc)
					new/obj/airboom(loc)
			sleep(5)
		icon_state=""
		if(clan=="Copy Ninja")tactics()
	superholy(var/times)
		superholy+=times
		atkdef()
		spawn(100*1.4)
			superholy=0
			atkdef()
	charegenback(var/backr)
		var/multiblow=10
		spawn()while(multiblow)
			multiblow--
			if(multiblow<7)
				cha+=backr/7
				if(mybar2)mybar2:updatebar()
			sleep(10)
	immortality()
		if(hp<maxhp*0.6)
			src<<"<b><center>You must be at over 60% health to use this jutsu."
			return
		if(swim||amatcd||dead||stun||resting||caught||seals||busy||imitated||paralysed)return
		var/f=1
		if(level>=55)f=2
		if(level>=100)f=3
		for(var/obj/deadbody/M in range(3))
			if(hostamount>=f)
				if(M.level>host1eff)
					immortalhost1(M)
					return
				if(M.level>host2eff)
					immortalhost2(M)
					return
				if(M.level>host3eff)
					immortalhost3(M)
					return
			else
				switch(hostamount)
					if(0,null)
						hostamount=1
						immortalhost1(M,1)
					if(1)
						hostamount=2
						immortalhost2(M,1)
					if(2)
						hostamount=3
						immortalhost3(M,1)
			return
	izimmortalitya()
		var/K=new/obj/deadbody(loc)
		K:name=name
		K:overlays+=overlays
		K:icon=icon
		new/obj/immortality(loc)
		freeze=1
		dead=1
		density=0
		invisibility=11
		sleep(10)
		new/obj/izanagi(loc)
		soundeff('immortality2.wav',45,0)
		sleep(2)
		del K
		freeze=0
		invisibility=1
		dead=0
		density=1
		hp=maxhp*0.4
		if(mybar)mybar:updatebar()
	immortalitya()
		hostamount--
		var/K=new/obj/deadbody(loc)
		K:name=name
		K:overlays+=overlays
		K:icon=icon
		var/F=maxhp*0.3
		if(level>=75)F=maxhp*0.45
		if(hostamount==2)
			F*=host3eff/100
			host3eff=0
		if(hostamount==1)
			F*=host2eff/100
			host2eff=0
		if(hostamount==0)
			F*=host1eff/100
			host1eff=0
		new/obj/immortality(loc)
		freeze=1
		dead=1
		density=0
		invisibility=11
		sleep(10)
		new/obj/immortalityfire(loc)
		soundeff('immortality2.wav',45,0)
		sleep(2)
		del K
		freeze=0
		invisibility=1
		dead=0
		density=1
		hp=F
		if(mybar)mybar:updatebar()
		if(tier62)
			invisibility+=3
			spawn(7+7*tier62)
				invisibility-=3
	immortalhost1(var/obj/deadbody/M,var/F)
		amatcd=1
		var/sdelay=2520-tier53*28
		for(var/obj/jutsu/snake/Immortality_Jutsu/Ms in src)timerjutsu(sdelay,Ms)
		spawn(sdelay)
			amatcd=0
		new/obj/immortality(M.loc)
		soundeff('immortality.wav',45,0)
		icon_state="jutsu"
		stun(50)
		sleep(10)
		if(!M)
			icon_state=""
			return
		new/obj/immortalityfire(M.loc)
		host1eff=20+M.level
		if(host1eff>100)host1eff=100
		src<<"<b>You have taken [M]'s body. The quality is [host1eff]%."
		if(F)hostamount=1
		sleep(2)
		icon_state=""
		if(M)del M
	immortalhost2(var/obj/deadbody/M,var/F)
		amatcd=1
		var/sdelay=2520-tier53*28
		for(var/obj/jutsu/snake/Immortality_Jutsu/Ms in src)timerjutsu(sdelay,Ms)
		spawn(sdelay)
			amatcd=0
		new/obj/immortality(M.loc)
		soundeff('immortality.wav',45,0)
		icon_state="jutsu"
		stun(50)
		sleep(10)
		if(!M)
			icon_state=""
			return
		new/obj/immortalityfire(M.loc)
		host2eff=20+M.level
		if(host2eff>100)host2eff=100
		src<<"<b>You have taken [M]'s body. The quality is [host2eff]%."
		if(F)hostamount=2
		sleep(2)
		icon_state=""
		if(M)del M
	immortalhost3(var/obj/deadbody/M,var/F)
		amatcd=1
		var/sdelay=2520-tier53*28
		for(var/obj/jutsu/snake/Immortality_Jutsu/Ms in src)timerjutsu(sdelay,Ms)
		spawn(sdelay)
			amatcd=0
		new/obj/immortality(M.loc)
		soundeff('immortality.wav',45,0)
		icon_state="jutsu"
		stun(15)
		sleep(10)
		if(!M)
			icon_state=""
			return
		new/obj/immortalityfire(M.loc)
		host3eff=20+M.level
		if(host3eff>100)host3eff=100
		src<<"<b>You have taken [M]'s body. The quality is [host3eff]%."
		if(F)hostamount=3
		sleep(2)
		if(M)del M
		sleep(10)
		icon_state=""
	edotensei()
		if(variable3==5)return
		if(edo)
			edo=0
			atkdef()
			for(var/mob/edo/M in world)
				if(M.edoowner==src)
					if(level>=88)
						apow+=M.apow/4
						pow+=M.pow/4
						new/obj/unholyaura(loc)
						spawn(140+tier51*28)
							new/obj/unholyaura(loc)
							forceupdate()
					del M
			return
		if(edol==0)
			src<<"<center>You do not have a soul stored."
			return
		if(cdelay6||swim||dead||stun||resting||caught||seals||busy||imitated||paralysed)return
		handseals(100,20,60)
		if(!sealpass)return
		cdelay6=1
		var/sdelay=720*(cdpow/100)
		for(var/obj/jutsu/snake/Edo_Tensei/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)
			cdelay6=0
		edo=1
		variable3=5
		atkdef()
		var/Fa=new/obj/edotenseicoffin(loc)
		step(Fa,dir)
		soundeff('edo.wav',45,0)
		sleep(10)
		Fa:icon_state="opened"
		soundeff('edo2.wav',45,0)
		new/obj/edotenseidoor(Fa:loc)
		var/savefile/F = new(SAVEFILE_PATH("[current_slot]edo"))
		var/mob/edo/M=new/mob/edo(Fa:loc)
		M.level=edol
		M.aff=aff
		M.edoowner=src
		M.village=village
		F["Sta"]>>M.Sta
		F["Hsl"]>>M.Hsl
		F["Nin"]>>M.Nin
		F["Str"]>>M.Str
		F["Int"]>>M.Int
		F["Tai"]>>M.Tai
		F["Spd"]>>M.Spd
		F["hair"]>>M.hair
		F["hair_red"]>>M.hair_red
		F["hair_blue"]>>M.hair_blue
		F["rank"]>>M.rank
		F["hair_green"]>>M.hair_green
		F["icon"]>>M.icon
		F["name"]>>M.name
		F["special"]>>M.special
		F["gloves"]>>M.gloves
		F["shoes"]>>M.shoes
		F["pant"]>>M.pant
		F["kunaipouch"]>>M.kunaipouch
		F["shirt"]>>M.shirt
		F["cloak"]>>M.cloak
		F["headgear"]>>M.headgear
		F["clan"]>>M.clan
		F["headband"]>>M.headband
		F["armor"]>>M.armor
		F["mask"]>>M.mask
		F["kstoggle"]>>M.kstoggle
		F["pant2"]>>M.pant2
		F["shirt2"]>>M.shirt2
		F["weapon"]>>M.weapon
		F["weapon"]>>M.weaponsh
		F["belt"]>>M.belt
		F["fullbody"]>>M.fullbody
		M.statset()
		M.overlay()
		M.freeze=1
		M.npc=2
		M.tmpvillage=village
		M.name="[src]'s [M.name]"
		M.mouseovername()
		M.hp=M.maxhp
		M.cha=M.maxcha
		M.barset()
		sleep(15)
		variable3=0
		if(M)
			M.freeze=0
			M.npc=0
			M.edoproc()
	strikingsnake()
		if(snaking==1&&level>=32||snaking==1&&clan=="Copy Ninja")
			snaking=5
			for(var/obj/strikingsnake/M in range(16))
				if(M.owner==src)
					var/obj/F=new/obj/strikingsnake2(M.loc)
					F.owner=src
					F.dir=dir
					var/obj/D1=new/obj/snakeblader(M.loc)
					var/obj/D2=new/obj/snakeblader(M.loc)
					D1.owner=src
					D2.owner=src
					if(dir==SOUTH||dir==NORTH)
						D1.x--
						D2.x++
					if(dir==EAST||dir==WEST)
						D1.y--
						D2.y++
					D1.dir=dir
					D2.dir=dir
					F.movequick(dir)
					D1.movequick(dir)
					D2.movequick(dir)
					del M
			return
		if(snaking==2&&level>=15||snaking==2&&clan=="Copy Ninja")
			for(var/mob/M in range(16))
				if(M.stun&&!M.npc&&M.rank!="Bijuu"&&!M.outburst)spawn()M.blitzhook(src)
			return
		prejutsu()
		if(cdelay1||copydelay2||swim||dead||stun||resting||caught||seals||busy||imitated||paralysed)return
		handseals(45,0,30)
		if(!sealpass)return
		if(clan=="Copy Ninja")copydelay2=1
		else	cdelay1=1
		var/sdelay=160*(cdpow/100)
		if(level>=50)sdelay*=0.8
		for(var/obj/jutsu/snake/Striking_Shadow_Snake/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)
			cdelay1=0
			copydelay2=0
		var/obj/snakeclone/T=new(loc)
		T.icon=icon
		T.dir=dir
		T.overlays=overlays
		T.icon_state="jutsu"
		T.owner=src
		soundeff('snake.wav',45,0)
		snaking=1
		if(client)
			invisibility+=3
			var/image/I=image('baseinvis.dmi',src)
			I.vtype="invisbase"
			client.images+=I
			barloc()
			spawn(50)
				if(snaking)
					invisibility-=3
					snaking=0
					client.images-=I
					barloc()
		var/obj/strikingsnake/K=new(loc)
		K.owner=src
		K.dir=dir
		step(K,dir)
		if(K)if(K.icon_state=="head")walk(K,dir)
		for(var/obj/strikenaketrail/M in loc)M.icon_state="begin"
		if(clan=="Copy Ninja")tactics()
	shedskin()
		if(tsukcd||swim||dead||resting||caught)return
		tsukcd=1
		var/sdelay=1680-420*tier21
		for(var/obj/jutsu/snake/Shed_Skin/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)
			tsukcd=0
		stun=0
		snared=0
		sandstormslow=0
		immuneslow=1
		spawn(42)immuneslow=0
		new/obj/shed(loc)
		hp+=(maxhp-hp)*0.12
		if(mybar)mybar:updatebar()
	snakeglare()
		if(level>=40&&cdelay4)
			for(var/obj/snakebinding/F in range(5))
				if(F:owner==src)
					for(var/mob/M in F:loc)
						if(aff==M.aff||M.rank=="Bijuu")continue
						if(M.hp<M.maxhp*(0.1+0.025*tier41))
							soultake(M)
		if(cdelay4||swim||dead||stun||resting||caught||seals||busy||imitated||paralysed)return
		handseals(45,0,30)
		if(!sealpass)return
		cdelay4=1
		var/sdelay=320*(cdpow/100)
		for(var/obj/jutsu/snake/Binding_Snake_Glare/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)
			cdelay4=0
		stun(5)
		var/obj/F=new/obj/snakebinder(loc)
		F.dir=dir
		var/K=8
		if(level>=60)K=3
		sleep(K)
		var/C=2
		if(level>=92)C=3
		soundeff('bind.wav',45,0)
		var/obj/absorber/Fa=new(loc)
		Fa.owner=src
		for(var/mob/M in oview(C))
			if(aff==M.aff)continue
			var/obj/Fz=new/obj/snakebinding(M.loc)
			Fz.dir=M.dir
			Fz.owner=src
			Fz:newshur=4
			if(tier52)
				var/obj/F2=new/obj/groundsnake(locate(M.x+pick(-2,-1,1,2),M.y+pick(-2,-1,1,2),M.z))
				F2.owner=src
				var/obj/F23=new/obj/groundsnake(locate(M.x+pick(-2,-1,1,2),M.y+pick(-2,-1,1,2),M.z))
				F23.owner=src
		var/D=4
		while(D)
			for(var/obj/snakebinding/S in range(Fa,C))
				if(S.newshur==0)
					del S
					continue
				for(var/mob/M in S.loc)
					if(aff==M.aff)
						del S
						continue
					M.stun(6)
					if(tier11)M.venom()
					flick("bind2",S)
					var/damage=apow*0.2
					if(M.clan=="Taijutsu Specialist")
						if(M.tier32)damage*=1-(M.tier32*0.05)
					M.dmgch(src,1)
					damage=(damage*M.variable)+M.variable2
					M.damage(damage)
					M.death(src)
				if(S.newshur==1)
					S.icon_state=""
					flick("bindoff",S)
				S.newshur--
			D--
			sleep(3)
		if(Fa)del Fa
	soultake(mob/M)
		if(M.variable3==50)return
		M.dir=SOUTH
		M.stun(20)
		M.variable3=50
		new/obj/snakebindmax(M.loc)
		soundeff('snake.wav',45,0)
		spawn(8)
			for(var/obj/snakebinding/F in M.loc)del F
			var/allowable=0
		//	if(M.client)
			if(edol<M.level)allowable=1
			else
				if(edol==M.level&&edokd<M.kills-M.deaths)
					allowable=1
			if(allowable)
				var/savefile/F = new(SAVEFILE_PATH("[current_slot]edo"))
				edol=M.level
				edokd=M.kills-M.deaths
				F["Sta"]<<round(M.Sta*0.75)
				F["Hsl"]<<round(M.Hsl*0.75)
				F["Nin"]<<round(M.Nin*0.75)
				F["Str"]<<round(M.Str*0.75)
				F["Int"]<<round(M.Int*0.75)
				F["Tai"]<<round(M.Tai*0.75)
				F["Spd"]<<round(M.Spd*0.75)
				F["hair"]<<M.hair
				F["hair_red"]<<M.hair_red
				F["hair_blue"]<<M.hair_blue
				F["hair_green"]<<M.hair_green
				F["icon"]<<M.icon
				F["rank"]<<M.rank
				F["name"]<<M.name
				F["special"]<<M.special
				F["gloves"]<<M.gloves
				F["shoes"]<<M.shoes
				F["pant"]<<M.pant
				F["clan"]<<M.clan
				F["kunaipouch"]<<M.kunaipouch
				F["shirt"]<<M.shirt
				F["cloak"]<<M.cloak
				F["headgear"]<<M.headgear
				F["headband"]<<M.headband
				F["armor"]<<M.armor
				F["mask"]<<M.mask
				F["kstoggle"]<<M.kstoggle
				F["pant2"]<<M.pant2
				F["shirt2"]<<M.shirt2
				F["weapon"]<<M.weapon
				F["belt"]<<M.belt
				F["fullbody"]<<M.fullbody
			M.hp=0
			M.smite=1
			M.variable3=0
			M.death(src)
	blitzhook(var/mob/F)
		var/D=0
		F.snaking=3
		animate_movement=0
		soundeff('snake.wav',45,0)
		for(var/obj/strikenaketrail/G in range(src,1))
			if(G:icon_state=="begin")continue
			if(G.owner!=F)continue
			D=1
			loc=G:loc
			barloc()
			for(var/obj/strikingsnake/Fs in range(src,1))
				if(Fs:owner==F)Fs:loc=loc
			del G
			sleep(1)
		while(D)
			D=0
			for(var/obj/strikenaketrail/G in range(src,1))
				if(G:icon_state=="begin")continue
				if(G.owner!=F)continue
				D=1
				loc=G:loc
				barloc()
				for(var/obj/strikingsnake/Fs in range(src,1))
					if(Fs:owner==F)Fs:loc=loc
				del G
				sleep(1)
		animate_movement=2
		if(F:snaking)F.snaking=4
	cursed(mob/M,var/damage)
		if(!M)return
		if(aff==M.aff||!M.tier22)return
		cursebuild+=damage*0.1*M.tier22
		if(cursetimer<=0)
			spawn()curseproc(M)
		cursetimer=3
	curseproc(mob/M)
		while(cursetimer)
			sleep(10)
			cursetimer--
			if(cursetimer==0)
				if(!M)
					cursebuild=0
				else
					if(cursebuild>maxhp*0.15)cursebuild=maxhp*0.15
					damage(cursebuild)
					new/obj/curse(loc)
					soundeff('metalclash2.wav',50,0)
					death(M)
					cursebuild=0
	snakethrowpoison(mob/M)
		var/F=3
		spawn()while(F)
			sleep(10)
			F--
			if(!M)
				return
			else
				var/damage = M.tier32*M.pow*0.03
				dmgch(M)
				damage=(damage*variable)+variable2
				damage(damage)
				new/obj/statuspop/poison(loc)
				death(M)

mob/var
	edo=0
	cursebuild=0
	cursetimer=0
	edol=0
	edokd=0
	snaking=0
	insnake=0
	immuneslow=0
obj
	groundsnake
		icon='groundsnake.dmi'
		Crossed(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(D.aff==O.aff)return
				D.snared(14*O.tier52,3)
				var/damage=O.pow*0.2*O.tier52
				D.dmgch(O)
				new/obj/bite(D.loc)
				damage=(damage*D.variable)+D.variable2
				D.damage(damage)
				D.death(O)
				del src
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					T.loc=loc
		New()
			..()
			icon_state="[rand(1,8)]"
			spawn(275)
				flick("[icon_state]1",src)
				icon_state=null
			spawn(280)del src
	unholyaura
		layer=50
		New()
			flick('unholyaura.dmi',src)
			spawn(12)del src
	immortality
		pixel_x=-64
		pixel_y=-64
		New()
			flick('immortality.dmi',src)
			spawn(50)del src
	immortalityfire
		pixel_x=-64
		pixel_y=-64
		layer=50
		New()
			flick('immortalityfire.dmi',src)
			spawn(20)del src
	edotenseicoffin
		icon='edotensei.dmi'
		layer=2
		density=1
		New()
			flick("begin",src)
			spawn(2)
			overlays+=/obj/edosuperlayer
			spawn(100)del src
	edosuperlayer
		icon='edotensei.dmi'
		icon_state="superlayer"
		layer=20
	edotenseidoor
		icon='edotenseidoor.dmi'
		pixel_y=-64
		layer=20
		New()
			flick("begin",src)
			spawn(5)
				layer=3
			spawn(86)del src
	strikingsnake
		icon='strikingshadow.dmi'
		icon_state="head"
		animate_movement=0
		layer=15
		projint=2
		density=1
		var/moved=0
		New()
			spawn(100)del src
		proc
			constrict(var/mob/snake,var/mob/attacker,var/bindtime)
				while(bindtime&&attacker&&snake)
					snake.stun(8)
					sleep(5)
					if(attacker&&snake)
						if(attacker.snaking==4)break
						if(attacker.tier11)snake.venom()
						flick("[icon_state]s",src)
						var/damage=attacker.apow*0.20
						if(snake.clan=="Taijutsu Specialist")
							if(snake.tier32)damage*=1-(snake.tier32*0.05)
						snake.dmgch(attacker,1)
						damage=(damage*snake.variable)+snake.variable2
						snake.damage(damage)
						snake.death(attacker)
						if(snake)if(snake.dead)break
						bindtime--
				if(attacker)
					if(attacker.snaking&&attacker:client)
						attacker.invisibility-=3
						attacker.snaking=0
						attacker.barloc()
						for(var/image/M in attacker.client.images)
							if(M.vtype=="invisbase")
								del(M)
					for(var/obj/snakeclone/M in world)if(M.owner==attacker)del M
				del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(D.illusion)
					D.illusionhit(O)
					return
				if(O.aff==D.aff)
					loc=D.loc
					return
				var/stime=3
				if(O.level>=50)stime=4
				spawn()constrict(D,O,stime)
				loc=D.loc
				O.snaking=2
				if(O.tier52||O.clan=="Copy Ninja")
					var/obj/F=new/obj/groundsnake(locate(D.x+pick(-2,-1,1,2),D.y+pick(-2,-1,1,2),D.z))
					F.owner=O
					var/obj/F2=new/obj/groundsnake(locate(D.x+pick(-2,-1,1,2),D.y+pick(-2,-1,1,2),D.z))
					F2.owner=O
				if(D.dir==EAST)icon_state="bind2"
				else icon_state="bind"
				density=0
				walk(src,0)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(T)
		Move()
			var/obj/T=new/obj/strikenaketrail(loc)
			T.dir=dir
			T.owner=owner
			..()
			moved++
			if(moved>=12)del src
		Del()
			var/mob/x=owner
			if(x.snaking!=5)for(var/obj/strikenaketrail/M in world)if(M.owner==x)del M
			if(x.snaking&&x.client)
				x.invisibility-=3
				x.snaking=0
				x.barloc()
				for(var/image/M in x.client.images)
					if(M.vtype=="invisbase")
						del(M)
			for(var/obj/snakeclone/M in world)if(M.owner==x)del M
			..()
	strikingsnake2
		icon='strikingshadow.dmi'
		icon_state="head2"
		animate_movement=0
		layer=15
		density=1
		projint=2
		var/moved=0
		New()
			spawn(100)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(D.aff==O.aff)
					loc=O.loc
					return
				if(O.tier11)D.venom()
				if(O.tier52||O.clan=="Copy Ninja")
					var/obj/F=new/obj/groundsnake(locate(D.x+pick(-2,-1,1,2),D.y+pick(-2,-1,1,2),D.z))
					F.owner=O
					var/obj/F2=new/obj/groundsnake(locate(D.x+pick(-2,-1,1,2),D.y+pick(-2,-1,1,2),D.z))
					F2.owner=O
				projectilep(O,D,O.apow)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)
		Move()
			var/obj/T=new/obj/strikenaketrail(loc)
			T.dir=dir
			T.owner=owner
			..()
			moved++
			if(moved>=12)del src
		Del()
			var/mob/x=owner
			if(x.snaking)
				x.invisibility-=3
				x.snaking=0
				x.barloc()
				for(var/image/M in x.client.images)
					if(M.vtype=="invisbase")
						del(M)
			for(var/obj/snakeclone/M in world)if(M.owner==x)del M
			for(var/obj/strikenaketrail/M in world)if(M.owner==x)del M
			..()
	snakeblader
		icon='snakeblader.dmi'
		animate_movement=0
		layer=15
		density=1
		projint=2
		var/moved=0
		New()
			spawn(20)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				projectilep(O,D,O.apow)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)
		Move()
			var/obj/T=new/obj/snakebladert(loc)
			T.dir=dir
			..()
			moved++
			if(moved>=12)del src
	skyblade
		icon='skyblade.dmi'
		animate_movement=0
		layer=15
		density=1
		var/moved=0
		projint=2
		New()
			spawn(20)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(O.aff==D.aff)
					loc=D.loc
					return
				var/dmg=O.apow*0.30
				if(D.clan=="Taijutsu Specialist")
					if(D.tier32)dmg*=1-(D.tier32*0.05)
				if(O.level>=65)dmg*=0.7
				if(O.level>=45)D.snared(14,2)
				if(D.venom)dmg+=O.maxhp*0.004*O.tier11
				D.cursed(O,dmg)
				projectilep(O,D,dmg)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)
	strikenaketrail
		name="Striking Snake"
		icon='strikingshadow.dmi'
		density=0
		layer=15
		New()
			spawn(100)del src

	snakebladert
		name="Striking Snake"
		icon='snakeblader.dmi'
		density=0
		layer=15
		New()
			flick("flick",src)
			spawn(20)del src
	snakebinder
		layer=16
		icon='snakebind.dmi'
		New()
			flick("binder",src)
			spawn(12)
				del src
	snakebindmax
		layer=17
		pixel_x=-32
		pixel_y=-32
		icon='snakebindmax.dmi'
		New()
			flick("maxstep",src)
			spawn(32)
				del src
	snakebinding
		icon_state="bind"
		layer=16
		icon='snakebind.dmi'
		New()
			flick("binding",src)
			spawn(42)
				flick("bindoff",src)
				icon_state=""
				spawn(8)
					del src
	edooff
		layer=10
		New()
			flick('edooff.dmi',src)
			spawn(20)del src
mob
	edo
		New()
			..()
			spawn(1)
				var/F=140
				if(edoowner:level>=70)F=280
				spawn(F)
					del src
			spawn()while(edoowner)
				if(edoowner:level<100)return
				sleep(10)
				for(var/mob/M in oview(1))
					if(aff==M.aff)continue
					var/damage=M.maxhp/100
					M.dmgch(edoowner)
					damage=(damage*M.variable)+M.variable2
					M.damage(damage)
					new/obj/unholyaura(M.loc)
					M.death(edoowner)
			if(edoowner)
				if(edoowner:tier51)
					spawn()while(edoowner)
						sleep(10)
						hp+=maxhp*0.005*edoowner:tier51
						if(hp>maxhp)hp=maxhp
						if(mybar)mybar:updatebar()
		MouseEntered()
			if(village=="Leaf")mouse_over_pointer='cursorleaf.dmi'
			if(village=="Sand")mouse_over_pointer='cursorsand.dmi'
			if(village=="Sound")mouse_over_pointer='cursorsound.dmi'
			if(village=="None")mouse_over_pointer='cursormiss.dmi'
			if(village=="Akatsuki")mouse_over_pointer='cursorakat.dmi'
			for(var/obj/Max_Obj_Letters in src.Max_Name)
				var/image/Max_Image = image(Max_Obj_Letters,src)
				usr.client.images += Max_Image
				spawn(usr.Max_Wait_Time)if(usr)if(usr.client)usr.client.images -= Max_Image
		Click()
			if(usr.clickedplayer)return
			usr.clickedplayer=1
			spawn(70)if(usr)usr.clickedplayer=0
			usr<<"-----------------------------------"
			usr<<"Name: [name]"
			usr<<"Level: [level]"
			usr<<"Clan: [clan]"
			usr<<"Village: [village]"
			usr<<"Stamina: [Sta]"
			usr<<"Intelligence: [Int]"
			usr<<"Handseals: [Hsl]"
			usr<<"Strength: [Str]"
			usr<<"Taijutsu: [Tai]"
			usr<<"Ninjutsu: [Nin]"
			usr<<"Speed: [Spd]"
			usr<<"-----------------------------------"
			return
		Bump(A)
			..()
			if(ismob(A))
				if(!edoowner)del src
				if(attacking)return
				if(A:aff==aff)return
				if(A:illusion)
					A:illusionhit(src)
					return
				var/damage=round(apow/3)+rand(3,5)
				if(A:clan=="Taijutsu Specialist")
					if(A:tier32)damage*=1-(A:tier32*0.05)
				A:dmgch(src,1)
				damage=(damage*A:variable)+A:variable2
				A:damage(damage)
				if(prob(50))flick("attack",src)
				else flick("attack",src)
				A:death(edoowner)
				attacking=1
				spawn(15/(attackdelay/100))
				attacking=0
		Del()
			var/D=new/obj/edooff(loc)
			D:dir=dir
			if(edoowner)
				edoowner:edo=0
				edoowner:atkdef()
			..()
		proc
			edoproc()
				if(!edoowner)del src
				walk(src,0)
				if(edoowner:aggro||edoowner:target)
					for(var/mob/M in oview(14,edoowner))
						if(M==edoowner:aggro||M==edoowner:target)
							if(M.npc==2||aff==M.aff)continue
							walk_to(src,M,1)
							for(var/mob/G in oview(1,src))if(G==M)
								walk(src,0)
								moving=0
								walk_towards(src,M)
							continue
					spawn(7)edoproc()
				else
					var/G=0
					for(var/mob/H in oview(2,src))if(H==edoowner)
						G=1
						walk(src,0)
						dir=edoowner:dir
					if(!G)walk_to(src,edoowner,1)
					spawn(7)edoproc()