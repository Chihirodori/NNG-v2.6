mob/proc
	clayleveling()
		if(level==4)
			src<<"<b><font color=cyan>You have learned C1 Spiders! You summon two spiders that crawl in front of you. They will move in the general direction of enemies and will explode on contact."
			new/obj/jutsu/clay/C1_Spiders(src)
		if(level==9)
			src<<"<b><font color=cyan>You have learned C1 Birds. You summon quick moving birds that rush forward in a V-formation. The birds will explode on contact, dealing damage and knocking back the enemy."
			new/obj/jutsu/clay/C1_Bird(src)
		if(level==14)
			src<<"<b><font color=cyan>You have learned Clay Clone. Using this jutsu turns you invisible and leaves a clone in your place that will explode after 2 seconds. If someone punches the clone, it will explode early and stun them for 2 seconds."
			new/obj/jutsu/clay/Clay_Clone(src)
		if(level==18)
			src<<"<b><font color=cyan>You have learned C2 Dragon. You summon a big dragon that you can control and move around freely. The dragon will periodically drop mines. The dragon itself will also explode when it expires or if you run it into something."
			new/obj/jutsu/clay/C2_Dragon(src)
		if(level==22)
			src<<"<b><font color=cyan>You have learned Clay Mines. With this jutsu you are able to drop large amounts of mines at your feet. If an enemy steps on them the mines will explode, dealing damage, knocking them back, and slowing their movement. "
			new/obj/jutsu/clay/Clay_Mines(src)
			new/obj/jutsu/clay/Clay_Mines_Detonate(src)
		if(level==26)
			src<<"<b><font color=cyan>You have learned C3. This jutsu quickly sucks nearby enemies in, and then causes a massive explosion around you."
			new/obj/jutsu/clay/C3(src)
		if(level==30)
			src<<"<b><font color=cyan>You have learned C4 Karura. You charge energy for 2 seconds, glowing as you do so. After the 2 second delay, you explode, dealing damage to yourself and causing a series of explosions all around you for 2 seconds."
			new/obj/jutsu/clay/C4_Karura(src)
		if(level==12)src<<"<b><font color=cyan>Your C1 Spiders is level 2. The explosion now does 15% more damage."
		if(level==40)src<<"<b><font color=cyan>Your C1 Spiders is now level 3. You now create 3 spiders."
		if(level==68)src<<"<b><font color=cyan>Your C1 Spiders is now mastered. The cooldown decreased."
		if(level==16)src<<"<b><font color=cyan>Your C1 Birds is now level 2. The birds now knock back 2 tiles."
		if(level==44)src<<"<b><font color=cyan>Your C1 Birds is now level 3. The birds now deal 15% more damage."
		if(level==72)src<<"<b><font color=cyan>Your C1 Birds is now mastered. The birds now knock back 3 tiles."
		if(level==20)src<<"<b><font color=cyan>Your Clay Clone is now level 2. You now remain invisible for 2.5 seconds."
		if(level==48)src<<"<b><font color=cyan>Your Clay Clone is now level 3. The explosion now does 10% more damage."
		if(level==76)src<<"<b><font color=cyan>Your Clay Clone is now mastered. You now remain invisible for 3 seconds."
		if(level==24)src<<"<b><font color=cyan>Your C2 Dragon is now level 2. You can now drop 4 mines."
		if(level==52)src<<"<b><font color=cyan>Your C2 Dragon is now level 3. You can now drop 5 mines."
		if(level==80)src<<"<b><font color=cyan>Your C2 Dragon is now mastered. The explosions now deal 5% more damage."
		if(level==28)src<<"<b><font color=cyan>Clay Mines is now level 2. The mines now slow for 0.5s longer."
		if(level==56)src<<"<b><font color=cyan>Clay Mines is now level 3. The mines now last one minute longer."
		if(level==84)src<<"<b><font color=cyan>Clay Mines is now mastered. The mines now deal 10% more damage."
		if(level==32)src<<"<b><font color=cyan>C3 is now level 2. The cooldown is decreased."
		if(level==60)src<<"<b><font color=cyan>C3 is now level 3. The explosion now does 10% more damage."
		if(level==88)src<<"<b><font color=cyan>C3 is now mastered. The suction range has increased."
		if(level==36)src<<"<b><font color=cyan>C4 Karura is now level 2. You now damage yourself for 10% less damage."
		if(level==64)src<<"<b><font color=cyan>C4 Karura is now level 3. The cooldown has decreased."
		if(level==92)src<<"<b><font color=cyan>C4 Karura is now mastered. You now deal 3% more damage with each explosion."
mob/var
	summonedspiders=0
	c2dragoning=0
	claymines=12
	clayminesactive=0
	c4delay=0
	c1spidercost=25
	c1birdcost=20
	repercussioncd=0
	shockwavecd=0
	scorchedcd=0
	lastlaugh=0
	minetelecd=0
	lastresortdamage=0
	lastresortcd=0
	maimingshock=0
	c4defense=0
obj/nomine
mob/proc
	c1spider()
		if(summonedspiders)
			summonedspiders = 0
			for(var/obj/clayspider/M in world)
				if(M.owner == src)
					del M
			return
		prejutsu()
		if(cdelay1||swim||attacking||dead||resting||stun||busy||moving||seals||imitated)return
		cdelay1=1
		handseals(c1spidercost,5,20)
		if(!sealpass)
			cdelay1=0
			return
		if(c1spidercost==35)c1spidercost=25
		if(tier13)c1spidercost+=5
		var/sdelay=250*cdpow/100
		if(level>=68)sdelay-=20
		if(tier13)sdelay-=sdelay*(tier13*0.03)
		for(var/obj/jutsu/clay/C1_Spiders/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay1=0
		spawn(10)
			summonedspiders=1
			spawn(20)summonedspiders=0
		var/obj/L2=new/obj/clayspider(loc)
		var/obj/L3=new/obj/clayspider(loc)
		if(dir==NORTH||dir==SOUTH)
			L2.loc=locate(x+2,y,z)
			L3.loc=locate(x-2,y,z)
		if(dir==EAST||dir==WEST)
			L2.loc=locate(x,y+2,z)
			L3.loc=locate(x,y-2,z)
		L2.dir=dir
		L3.dir=dir
		L2.owner=src
		L2.moveslowlong(dir)
		L3.owner=src
		L3.moveslowlong(dir)
		if(level>=40)
			var/obj/L4=new/obj/clayspider(loc)
			L4.dir=dir
			L4.owner=src
			L4.moveslowlong(dir)
	c1bird()
		prejutsu()
		if(cdelay2||swim||dead||resting||stun||busy||moving||imitated||paralysed)return
		cdelay2=1
		handseals(c1birdcost,5,15)
		if(!sealpass)
			cdelay2=0
			return
		if(c1birdcost==30)c1birdcost=20
		if(tier13)c1birdcost+=5
		var/sdelay=200*cdpow/100
		if(tier13)sdelay-=sdelay*(tier13*0.03)
		for(var/obj/jutsu/clay/C1_Bird/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay2=0
		flick("attack",usr)
		var/L=new/obj/c1bird(loc)
		L:dir=dir
		L:owner=usr
		L:movequick(dir)
		spawn(2)
			if(L&&tier33)
				var/T=new/obj/c1bird2(L:loc)
				var/T1=new/obj/c1bird2(L:loc)
				T:dir=L:dir
				T1:dir=L:dir
				T:owner=usr
				T1:owner=usr
				if(L:dir==NORTH)
					T:movequick(NORTHEAST)
					T1:movequick(NORTHWEST)
				if(L:dir==EAST)
					T:movequick(NORTHEAST)
					T1:movequick(SOUTHEAST)
				if(L:dir==SOUTH)
					T:movequick(SOUTHEAST)
					T1:movequick(SOUTHWEST)
				if(L:dir==WEST)
					T:movequick(NORTHWEST)
					T1:movequick(SOUTHWEST)
			//	del L
		spawn(2)
			var/L2=new/obj/c1bird(loc)
			L2:dir=dir
			L2:owner=usr
			var/L3=new/obj/c1bird(loc)
			L3:dir=dir
			L3:owner=usr
			if(dir==NORTH||dir==SOUTH)
				L2:loc=locate(x+1,y,z)
				L3:loc=locate(x-1,y,z)
			if(dir==EAST||dir==WEST)
				L2:loc=locate(x,y+1,z)
				L3:loc=locate(x,y-1,z)
			L2:movequick(dir)
			L3:movequick(dir)
			spawn(2)
				if(L2&&tier33)
					var/T2=new/obj/c1bird2(L2:loc)
					var/T3=new/obj/c1bird2(L2:loc)
					T2:dir=L2:dir
					T3:dir=L2:dir
					T2:owner=usr
					T3:owner=usr
					if(L2:dir==NORTH)
						T2:movequick(NORTHEAST)
						T3:movequick(NORTHWEST)
					if(L2:dir==EAST)
						T2:movequick(NORTHEAST)
						T3:movequick(SOUTHEAST)
					if(L2:dir==SOUTH)
						T2:movequick(SOUTHEAST)
						T3:movequick(SOUTHWEST)
					if(L2:dir==WEST)
						T2:movequick(NORTHWEST)
						T3:movequick(SOUTHWEST)
				//	del L2
				if(L3&&tier33)
					var/T4=new/obj/c1bird2(L3:loc)
					var/T5=new/obj/c1bird2(L3:loc)
					T4:dir=L3:dir
					T5:dir=L3:dir
					T4:owner=usr
					T5:owner=usr
					if(L3:dir==NORTH)
						T4:movequick(NORTHEAST)
						T5:movequick(NORTHWEST)
					if(L3:dir==EAST)
						T4:movequick(NORTHEAST)
						T5:movequick(SOUTHEAST)
					if(L3:dir==SOUTH)
						T4:movequick(SOUTHEAST)
						T5:movequick(SOUTHWEST)
					if(L3:dir==WEST)
						T4:movequick(NORTHWEST)
						T5:movequick(SOUTHWEST)
				//	del L3
		spawn(4)
			var/L4=new/obj/c1bird(loc)
			L4:dir=dir
			L4:owner=usr
			var/L5=new/obj/c1bird(loc)
			L5:dir=dir
			L5:owner=usr
			if(dir==NORTH||dir==SOUTH)
				L4:loc=locate(x+2,y,z)
				L5:loc=locate(x-2,y,z)
			if(dir==EAST||dir==WEST)
				L4:loc=locate(x,y+2,z)
				L5:loc=locate(x,y-2,z)
			L4:movequick(dir)
			L5:movequick(dir)
			spawn(2)
				if(L4&&tier33)
					var/T6=new/obj/c1bird2(L4:loc)
					var/T7=new/obj/c1bird2(L4:loc)
					T6:dir=L4:dir
					T7:dir=L4:dir
					T6:owner=usr
					T7:owner=usr
					if(L4:dir==NORTH)
						T6:movequick(NORTHEAST)
						T7:movequick(NORTHWEST)
					if(L4:dir==EAST)
						T6:movequick(NORTHEAST)
						T7:movequick(SOUTHEAST)
					if(L4:dir==SOUTH)
						T6:movequick(SOUTHEAST)
						T7:movequick(SOUTHWEST)
					if(L4:dir==WEST)
						T6:movequick(NORTHWEST)
						T7:movequick(SOUTHWEST)
				//	del L4
				if(L5&&tier33)
					var/T8=new/obj/c1bird2(L5:loc)
					var/T9=new/obj/c1bird2(L5:loc)
					T8:dir=L5:dir
					T9:dir=L5:dir
					T8:owner=usr
					T9:owner=usr
					if(L5:dir==NORTH)
						T8:movequick(NORTHEAST)
						T9:movequick(NORTHWEST)
					if(L5:dir==EAST)
						T8:movequick(NORTHEAST)
						T9:movequick(SOUTHEAST)
					if(L5:dir==SOUTH)
						T8:movequick(SOUTHEAST)
						T9:movequick(SOUTHWEST)
					if(L5:dir==WEST)
						T8:movequick(NORTHWEST)
						T9:movequick(SOUTHWEST)
				//	del L5
	clayclone()
		prejutsu()
		if(cdelay3||swim||attacking||dead||resting||stun||busy||moving||seals||imitated)return
		cdelay3=1
		var/sdelay=280*cdpow/100
		handseals(40,5,15)
		if(!sealpass)
			cdelay3=0
			return
		for(var/obj/jutsu/clay/Clay_Clone/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay3=0
		var/mob/Clone/clayclone/K=new(loc)
		K.cloneowner=usr
		invisibility=10
		stepup(1)
		subinvis=1
		var/time=20
		if(level>=20)time+=5
		if(level>=76)time+=5
		spawn(time)
			subinvis=0
			invisibility=1
		for(var/mob/Clone/clayclone/M in oview(1))
			if(M.cloneowner==usr)
				M.icon=icon
				M.dir=dir
				M.aff=aff
				M.moving=0
				M.overlays=overlays
				M.animate_movement=2
				M.name=name
				M.village=village
				M.rundelay=2
				var/obj/bars/healthbar/B1=new(M.loc)
				B1.barowner=M
				B1.copy(src)
				M.mybar=B1
				var/obj/bars/chakrabar/B2=new(M.loc)
				B2.barowner=M
				B2.copy(src)
				M.mybar2=B2
	c2dragon()
		if(usr.c2dragoning)
			for(var/obj/c2dragon/M in world)if(M.owner==usr)del M
			return
		prejutsu()
		if(cdelay4||swim||attacking||dead||resting||stun||busy||moving||seals||imitated)return
		cdelay4=1
		handseals(45,5,20)
		if(!sealpass)
			cdelay4=0
			return
		var/sdelay=330*cdpow/100
		for(var/obj/jutsu/clay/C2_Dragon/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay4=0
		var/tmp/number = 3
		if(level>=24)number++
		if(level>=52)number++
		var/obj/L=new/obj/c2dragon(loc)
		L.owner=src
		L.dir=dir
		L.dropmines(src,number)
		walk(L,dir)
		spawn(5)
			usr.c2dragoning = 1
			spawn(50)usr.c2dragoning=0
		usr.freeze = 1
		usr.invisibility = 10
		mybar:invisibility+=20
		mybar2:invisibility+=20
		usr.client.perspective = EYE_PERSPECTIVE
		usr.client.eye = L
	claymines()
		prejutsu()
		for(var/obj/nomine/J in loc)return
		var/T=0
		for(var/obj/claymine/M in loc)T=1
		if(T)
			if(!cdelay5)src<<"<b>You cannot stack mines on top of eachother."
			return
		if(cdelay5||swim||attacking||dead||resting||stun||busy||moving||seals||!claymines||clayminesactive>=6+(2*tier61)||clan!="Clay"||imitated)return
		cdelay5=1
		handseals(25,5,15)
		if(!sealpass)
			cdelay5=0
			return
		var/sdelay=50*cdpow/100
		for(var/obj/jutsu/clay/Clay_Mines/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay5=0
		var/obj/claymine/L=new(loc)
		L.owner=usr
		claymines--
		clayminesactive++
		src<<"<b>You have [claymines] mines left and [clayminesactive] currently active."
		spawn(600)
			if(src)
				claymines++
				if(claymines>=12)claymines=12
				src<<"<b>You have gained a clay mine([claymines] total)."
	clayminesdetonate()
		var/T=0
		for(var/obj/claymine/M in world)if(M.owner==src)
			T=1
			del M
		if(T)
			clayminesactive=0
			src<<"<b>You have detonated all your mines."
	c3()
		prejutsu()
		if(cdelay6||swim||attacking||dead||resting||stun||busy||moving||seals||imitated)return
		cdelay6=1
		var/sdelay=500*cdpow/100
		if(level>=32)sdelay-=30
		var/cost=65
		if(lastresortdamage)cost=0
		handseals(cost,8,30)
		if(!sealpass)
			cdelay6=0
			return
		for(var/obj/jutsu/clay/C3/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay6=0
		var/rangee=4
		if(level>=88)rangee++
		for(var/mob/player/M in range(rangee))
			if(M!=src&&M.aff!=aff)
				M.magnetic(src,8)
		new/obj/c3(loc)
		freeze=1
		spawn(10)
			freeze=0
			for(var/mob/M in oview(4))
				if(aff==M.aff)continue
				if(M.illusion)
					M.illusionhit(src)
					continue
				if(tier11)M.snared(tier11*0.2,2)
				var/damage=pow*1.4
				if(level>=60)damage*=1.1
				if(lastresortdamage)
					if(tier53==1)damage+=lastresortdamage*0.25
					if(tier53==2)damage+=lastresortdamage*0.50
					if(tier53==3)damage+=lastresortdamage*0.75
					lastresortdamage=0
				M.dmgch(src)
				damage=(damage*M.variable)+M.variable2
				var/critchance=0+(10*tier52)
				if(prob(critchance)&&tier52)
					if(tier62)
						M.stun(2.5*tier62)
						M.maimingshock(src)
					M.damage(damage,1.4)
				else
					M.damage(damage)
				M.death(src)
			var/F=10
			while(F)
				spawn(F)
					var/obj/explosion2/k=new(loc)
					var/obj/explosion2/k1=new(loc)
					var/obj/explosion2/k2=new(loc)
					var/obj/explosion2/k3=new(loc)
					var/obj/explosion2/k4=new(loc)
					for(var/obj/explosion2/G in loc)G.owner=src
					k.loc=locate(x+rand(-3,3),y+rand(-3,3),z)
					k1.loc=locate(x+rand(-3,3),y+rand(-3,3),z)
					k2.loc=locate(x+rand(-4,4),y+rand(-4,4),z)
					k3.loc=locate(x+rand(-4,4),y+rand(-4,4),z)
					k4.loc=locate(x+rand(-4,4),y+rand(-4,4),z)
				F--
	c4karura()
		prejutsu()
		if(c4delay||swim||attacking||dead||resting||stun||busy||seals||imitated)return
		c4delay=1
		handseals(75,5,40)
		if(!sealpass)
			c4delay=0
			return
		var/sdelay=650*cdpow/100
		if(level>=64)sdelay-=30
		for(var/obj/jutsu/clay/C4_Karura/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)c4delay=0
		freeze=1
		dir=SOUTH
		new/obj/c4clone(loc)
		if(tier63)
			c4defense=1
			atkdef()
			spawn(70)
				c4defense=0
				atkdef()
		spawn(20)
			freeze=0
			c4damage()
	c4damage()
		set background=1
		var/sdamage=0.25
		if(level>=36)sdamage=0.15
		hp-=hp*sdamage
		mybar:updatebar()
		mybar2:updatebar()
		var/times=40
		loop
			if(dead||!times)return
			times--
			var/obj/explosion2/k=new(loc)
			var/obj/explosion2/k1=new(loc)
			var/obj/explosion2/k2=new(loc)
			var/obj/explosion2/k3=new(loc)
			for(var/obj/explosion2/G in loc)G.owner=src
			k.loc=locate(x+rand(-4,4),y+rand(-4,4),z)
			k1.loc=locate(x+rand(-4,4),y+rand(-4,4),z)
			k2.loc=locate(x+rand(-5,5),y+rand(-5,5),z)
			k3.loc=locate(x+rand(-5,5),y+rand(-5,5),z)
			if(times==5||times==10||times==15||times==20||times==25||times==30||times==35||times==39)
				for(var/mob/M in oview(5))
					if(aff==M.aff)continue
					if(tier11)M.snared(tier11*0.2,2)
					var/damage=round(pow*0.5+M.maxhp*0.02)
					if(level>=92)damage*=1.03
					M.dmgch(src)
					damage=(damage*M.variable)+M.variable2
					var/critchance=0+(10*tier52)
					if(prob(critchance)&&tier52)
						if(tier62)
							M.stun(2.5*tier62)
							M.maimingshock(src)
						M.damage(damage,1.4)
					else
						M.damage(damage)
					M.death(src)
			spawn(2)goto loop
	lastresort()
		prejutsu()
		if(lastresortcd||swim||attacking||dead||resting||stun||busy||moving||seals||imitated)return
		lastresortcd=1
		var/sdelay=500*cdpow/100
		handseals(25,8,5)
		if(!sealpass)
			lastresortcd=0
			return
		for(var/obj/jutsu/clay/Last_Resort/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)lastresortcd=0
		lastresortdamage=cha
		cha=0
		mybar:updatebar()
		mybar2:updatebar()
		spawn(100)if(lastresortdamage)lastresortdamage=0
	lastlaugh()
		lastlaugh=1
		spawn(30)lastlaugh=0
	clayteleport()
		if(clan=="Clay"&&tier51&&hp>=maxhp*0.90&&!minetelecd&&!jailtime&&!hosptime)
			for(var/obj/minetelepoint/M in world)if(M.owner==src)
				minetelecd=1
				spawn(3000)minetelecd=0
				loc=M.loc
				del M
				return
	maimingshock(var/mob/M)
		maimingshock=1
		forceupdate()
		spawn(15*M.tier62)
			maimingshock=0
			forceupdate()

obj/proc
	clayburn(var/mob/M)
		M.scorchedcd=20
		for(var/turf/T in range(3,src))
			for(var/obj/clayfire/G in oview(T,0))continue
			var/obj/V=new/obj/clayfire(locate(T.x,T.y,T.z))
			V.owner=M
			V:deleteme(20*M.tier32)
	dropmines(var/mob/M,var/number)
		var/tmp/mines=number
		loop
			if(src&&mines)
				mines--
				var/obj/L=new/obj/c2dragonmine(loc)
				L.owner=M
				spawn(5)goto loop
obj
	explosion2
		pixel_x=-128
		pixel_y=-128
		layer=42
		icon='c3.dmi'
		icon_state="null"
		New()
			flick("boom",src)
			spawn(7)del src
		Del()
			var/mob/O=owner
			if(O.tier32&&!O.scorchedcd&&O.clan=="Clay")
				clayburn(O)
			..()
	clayfire
		icon='flame.dmi'
		layer=15
		pixel_y=-16
		pixel_x=-16
		proc/deleteme(var/T)spawn(T)del src
		New()
			flick("spawn",src)
			pixel_y-=rand(-6,6)
			pixel_x-=rand(-6,6)
			icon_state=pick("1","2","3","4")
		Crossed(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(O.aff==D.aff)return
				var/damage=D.maxhp*0.01
				D.dmgch(O)
				damage=(damage*D.variable)+D.variable2
				D.damage(damage)
				D.death(O)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					T.loc=loc
	c3
		pixel_x=-128
		pixel_y=-128
		layer=45
		New()
			flick('c3.dmi',src)
			spawn(10)del src
	claycloneexplosion
	//	pixel_x=-128
	//	pixel_y=-128
		layer=42
		icon='Bomb.dmi'
		icon_state="null"
		New()
			flick("boom",src)
			spawn(18)del src
	birdexplosion
		layer=42
		icon='c1bird.dmi'
		icon_state="null"
		New()
			flick("explosion",src)
			spawn(10)del src
	explosion
		pixel_x=-56
		pixel_y=-56
		layer=40
		New()
			flick('explosion.dmi',src)
			spawn(40)del src
	izanagi
		pixel_y=-32
		pixel_x=-32
		layer=60
		New()
			flick('izanagi.dmi',src)
			spawn(40)del src
	custpinkexplosion
		pixel_x=-56
		pixel_y=-56
		layer=40
		New()
			flick('cCarrisadabest101zexp.dmi',src)
			spawn(40)del src
	clayspider
		name=""
		icon='spiders.dmi'
		density=1
		rundelay=0
		layer=38
		New()
			..()
			spawn(2)if(owner)aim()
			spawn(30)del src
		proc/aim()
			while(src)
				for(var/mob/M in oview(src,5))
					var/mob/O=owner
					var/mob/D=M
					if(O.aff==D.aff)continue
					if(dir==SOUTH||dir==NORTH)
						if(M.x>x)
							step(src,EAST)
							break
						if(M.x<x)
							step(src,WEST)
							break
					if(dir==EAST||dir==WEST)
						if(M.y>y)
							step(src,NORTH)
							break
						if(M.y<y)
							step(src,SOUTH)
							break
				sleep(5)
		Bump(A)
			if(istype(A,/mob))
				var/mob/M=owner
				var/mob/T=A
				if(M.aff==T.aff)return
				del(src)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(istype(T,/obj/clayspider))
					loc=T.loc
				else
					if(T.density)
						projduel(A)
		Del()
			var/mob/O=owner
			var/obj/K=new/obj/explosion2(loc)
			K.owner=O
			for(var/mob/I in oview(src,3))
				var/mob/M=I
				if(O.inchunin!=4)if(O.aff==M.aff)continue
				if(M.illusion)
					M.illusionhit(O)
					continue
				if(O.tier11)M.snared(O.tier11*0.2,2)
				var/damage=O.pow*0.65
				if(O.level>=12)damage*=1.15
				if(O.tier13)damage*=1+O.tier13*0.04
				M.dmgch(O)
				damage=(damage*M.variable)+M.variable2
				var/critchance=0+(10*O.tier52)
				if(prob(critchance)&&O.tier52)
					if(O.tier62)
						M.stun(2.5*O.tier62)
						M.maimingshock(O)
					M.damage(damage,1.4)
				else
					M.damage(damage)
				M.death(O)
			..()
	c1bird
		name=""
		icon='c1bird.dmi'
		density=1
		rundelay=0
		layer=38
		projint=1
		New()
			..()
			spawn(12)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(O.aff==D.aff)
					loc=D.loc
					return
				O.faceme(D)
				var/knockback=1
				if(O.level>=16)knockback++
				if(O.level>=72)knockback++
				D.stepback(knockback)
				if(O.tier11)D.snared(O.tier11*0.2,2)
				var/damage=O.pow*0.80
				if(O.level>=44)damage*=1.15
				if(O.tier13)damage*=1+O.tier13*0.04
				D.dmgch(O)
				damage=(damage*D.variable)+D.variable2
				var/critchance=0+(10*O.tier52)
				if(prob(critchance)&&O.tier52)
					if(O.tier62)
						D.stun(2.5*O.tier62)
						D.maimingshock(O)
					D.damage(damage,1.4)
				else
					D.damage(damage)
				D.death(O)
				del src
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(istype(T,/obj/c1bird)||istype(T,/obj/c1bird2)||istype(T,/obj/clayspider))
					loc=T.loc
				else
					if(T.density)
						projduel(A)
		Del()
			new/obj/birdexplosion(loc)
			..()
	c1bird2
		name=""
		icon='c1bird.dmi'
		density=1
		rundelay=0
		layer=38
		projint=1
		New()
			..()
			spawn(12)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(O.aff==D.aff)
					loc=D.loc
					return
				O.faceme(D)
				var/knockback=1
				if(O.level>=16)knockback++
				if(O.level>=72)knockback++
				D.stepback(knockback)
				if(O.tier11)D.snared(O.tier11*0.2,2)
				var/damage=O.pow*(0.25*O.tier33)
				if(O.level>=44)damage*=1.15
				if(O.tier13)damage*=1+O.tier13*0.04
				D.dmgch(O)
				damage=(damage*D.variable)+D.variable2
				var/critchance=0+(10*O.tier52)
				if(prob(critchance)&&O.tier52)
					if(O.tier62)
						D.stun(2.5*O.tier62)
						D.maimingshock(O)
					D.damage(damage,1.4)
				else
					D.damage(damage)
				D.death(O)
				del src
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(istype(T,/obj/c1bird)||istype(T,/obj/c1bird2)||istype(T,/obj/clayspider))
					loc=T.loc
				else
					if(T.density)
						projduel(A)
		Del()
			new/obj/birdexplosion(loc)
			..()
	c2dragon
		icon='C2 Dragon.dmi'
		density=1
		rundelay=0
		layer=38
		New()spawn(30)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(O.aff==D.aff)
					loc=D.loc
					return
				del src
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					loc=T.loc
		Del()
			var/mob/O=owner
			var/obj/K=new/obj/explosion2(loc)
			K.owner=O
			for(var/mob/I in oview(src,3))
				var/mob/M=I
				if(O.inchunin!=4)if(O.aff==M.aff)continue
				if(M.illusion)
					M.illusionhit(O)
					continue
				if(O.tier11)M.snared(O.tier11*0.2,2)
				var/damage=O.pow*1.2
				if(owner.level>=80)damage*=1.05
				M.dmgch(O)
				damage=(damage*M.variable)+M.variable2
				var/critchance=0+(10*O.tier52)
				if(prob(critchance)&&O.tier52)
					if(O.tier62)
						M.stun(2.5*O.tier62)
						M.maimingshock(O)
					M.damage(damage,1.4)
				else
					M.damage(damage)
				M.death(O)
			O.client.eye = O
			O.client.perspective = MOB_PERSPECTIVE
			O.c2dragoning = 0
			O.freeze = 0
			O.invisibility = 1
			O.mybar:invisibility-=20
			O.mybar2:invisibility-=20
			..()
	c2dragonmine
		name=""
		icon='clay mine.dmi'
		density=1
		layer=38
		New()
			..()
			spawn(5)del src
		Del()
			var/mob/O=owner
			var/obj/K=new/obj/explosion2(loc)
			K.owner=O
			for(var/mob/I in oview(src,3))
				var/mob/M=I
				if(O.inchunin!=4)if(O.aff==M.aff)continue
				if(M.illusion)
					M.illusionhit(O)
					continue
				if(O.tier11)M.snared(O.tier11*0.2,2)
				var/damage=O.pow*0.65
				if(O.level>=80)damage*=1.05
				M.dmgch(O)
				damage=(damage*M.variable)+M.variable2
				var/critchance=0+(10*O.tier52)
				if(prob(critchance)&&O.tier52)
					if(O.tier62)
						M.stun(2.5*O.tier62)
						M.maimingshock(O)
					M.damage(damage,1.4)
				else
					M.damage(damage)
				M.death(O)
			..()
	claymine
		name=""
		icon='clay mine.dmi'
	//	layer=38
		New()
			..()
			var/mob/M=owner
			spawn(2400+(1200*M.tier61))if(src)del src
		Crossed(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(O.aff==D.aff)return
				D.stepback(2)
				var/time=20
				if(O.level>=28)time+=5
				D.snared(time,4)
				var/damage=O.pow*0.80
				if(O.level>=84)damage*=1.1
				if(O.tier51)damage*=1+O.tier51*0.10
				D.dmgch(O)
				damage=(damage*D.variable)+D.variable2
				var/critchance=0+(10*O.tier52)
				if(prob(critchance)&&O.tier52)
					if(O.tier62)
						D.stun(2.5*O.tier62)
						D.maimingshock(O)
					D.damage(damage,1.4)
				else
					D.damage(damage)
				D.death(O)
				if(O.tier51)
					for(var/obj/minetelepoint/M in world)if(M.owner==O)del M
					var/obj/K=new/obj/minetelepoint(loc)
					K.owner=O
					if(O.minetelecd||x>405&&y>425&&z==2||x<105&&y>439&&z==2||x>383&&y<60&&z==2)O<<"<center>[D] has tripped one of your mines. He's level [D.level] and is currently at [round((D.hp/D.maxhp)*100)]% hp."
					else	O<<"<b><center>[D] has tripped one of your mines. He's level [D.level] and is currently at [round((D.hp/D.maxhp)*100)]% hp. Press I to teleport to your mine's location within 5 seconds."
				del src
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					T.loc=loc
		Del()
			var/mob/M=owner
			new/obj/claymineexplosion(loc)
			if(M)M.clayminesactive--
			..()
	claymineexplosion
		layer=42
		icon='claymineexplosion.dmi'
		icon_state="null"
		New()
			flick("boom",src)
			spawn(9)del src
	minetelepoint
		New()spawn(50)del src
	c4clone
		layer=45
		icon='C4clone.dmi'
		icon_state="null"
		New()
			flick("boom",src)
			spawn(20)del src
	c4karura
		layer=42
		icon='C4 Karura.dmi'