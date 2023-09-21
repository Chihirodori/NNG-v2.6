mob/var
	shadowed=0
	shadowed2=0
	neckbound=0
	clutchcd=0
	clutches=0
	possessiondelay=0
	fistdelay=0
	tmp/shurikensdelay=0
	tmp/assurancecd=0
	tmp/assurance=0
	deadlyshadows=0
	imitationdebuff=0
	recurrence=0
mob/proc
	naraleveling()
		if(level==2)
			src<<"<b><font color=cyan>You have learned Shadow Imitation. This jutsu allows you to manipulate your shadow into a binding projectile. Anyone caught in your shadow imitation will be unable to move, and you will control their movement. Lasts 5 seconds."
			new/obj/jutsu/nara/Shadow_Imitation(src)
		if(level==6)
			src<<"<b><font color=cyan>You have learned Strategic Bombing. This jutsu arms several bombs in front of you that will explode when people step on them. They deal extra damage if they are walked onto them in your shadow imitation."
			new/obj/jutsu/nara/Strategic_Bombing(src)
		if(level==10)
			src<<"<b><font color=cyan>You have learned Shadow Strangle. This jutsu strangles anyone caught in your shadow imitation. It releases them and deals damage over 3 seconds that ramps up. Enemies are slowed for the duration."
			new/obj/jutsu/nara/Shadow_Strangle(src)
		if(level==15)
			src<<"<b><font color=cyan>You have learned Shadow Gathering. This jutsu fires fast moving tentacles out of the end of your shadow imitation. If they collide with an enemy, they are pulled to you, stunned briefly, and are damaged. You must be in mid imitation to use this."
			new/obj/jutsu/nara/Shadow_Gathering(src)
		if(level==24)
			src<<"<b><font color=cyan>You have learned Shadow Sewing. This jutsu fires needles made from your shadows that can be turned once. The needles pierce through enemies, stunning them briefly and dealing massive damage. Cannot be used during imitation."
			new/obj/jutsu/nara/Shadow_Sewing_Jutsu(src)
		if(level==32)
			src<<"<b><font color=cyan>You have learned Shadow Endgame Jutsu. This jutsu rips apart anyone caught in your shadow imitation with their own shadows. The damage increased by 1% for every 50 hp they have, and applies movement confusion for 3 seconds."
			new/obj/jutsu/nara/Shadow_Endgame(src)
		if(level==45)
			src<<"<b><font color=cyan>You have learned Shadow Clutch. This jutsu draws in all left over bombs from strategic bombing, and fires them in random directions."
			new/obj/jutsu/nara/Shadow_Clutch(src)
		if(level==55)
			src<<"<b><font color=cyan>You have learned Shadow Possession Shuriken. This jutsu fires a fast moving shuriken made of your shadows. If it hits someone, it will damage and slow them, and then bounce to a nearby enemy. It can bounce up to 4 times, and the damage and slow length increases by 50% each bounce."
			new/obj/jutsu/nara/Shadow_Possession_Shuriken(src)
		if(level==11)src<<"<b><font color=cyan>Your Shadow Imitation is level 2. It now lasts 1 second longer."
		if(level==31)src<<"<b><font color=cyan>Your Shadow Imitation is now mastered. It can now turn 3 times."
		if(level==13)src<<"<b><font color=cyan>Your Strategic Bombing is now level 2. The cooldown has decreased by 5 seconds."
		if(level==34)src<<"<b><font color=cyan>Your Strategic Bombing is now mastered. The damage has increased by 10%."
		if(level==19)src<<"<b><font color=cyan>Your Shadow Strangle is now level 2. The damage has increased by 5%."
		if(level==37)src<<"<b><font color=cyan>Your Shadow Strangle is now mastered. The cooldown has decreased by 5 seconds."
		if(level==20)src<<"<b><font color=cyan>Your Shadow Gathering is now level 2. The damage has increased by 10%."
		if(level==39)src<<"<b><font color=cyan>Your Shadow Gathering is now mastered. The cooldown has decreased by 5 seconds."
		if(level==28)src<<"<b><font color=cyan>Your Shadow Sewing is now level 2. The damage has increased by 10%."
		if(level==44)src<<"<b><font color=cyan>Your Shadow Sewing is now mastered. It can now be turned twice."
		if(level==33)src<<"<b><font color=cyan>Your Shadow Endgame Jutsu is now level 2. The damage now increased by 1% for every 40 hp they have."
		if(level==52)src<<"<b><font color=cyan>Your Shadow Endgame Jutsu is now mastered. The cooldown has decreased by 5 seconds."
		if(level==38)src<<"<b><font color=cyan>Your Shadow Clutch is now level 2. The cooldown has decreased by 5 seconds."
		if(level==60)src<<"<b><font color=cyan>Your Shadow Clutch is now mastered. The cooldown has decreased by 5 seconds."
		if(level==42)src<<"<b><font color=cyan>Your Shadow Possession Shuriken is now level 2. The cooldown has decreased by 5 seconds."
		if(level==72)src<<"<b><font color=cyan>Your Shadow Possession Shuriken is now mastered. Damage increased by 10% more each bounce."
	shadowshuriken()
		prejutsu()
		if(possessiondelay||swim||dead||stun||resting||caught||seals||busy||imitated||paralysed)return
		handseals(40,5,20)
		if(!sealpass)return
		possessiondelay=1
		var/sdelay=300*(cdapow/100)
		if(level>=42)sdelay-=50
		if(tier41)sdelay*=1-(tier41*0.05)
		for(var/obj/jutsu/nara/Shadow_Possession_Shuriken/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)possessiondelay=0
		range(8)<<"<font color=silver><b>[src]: Shadow Possession Shuriken!"
		flick("attack",src)
		var/obj/shadowshuriken/F=new(loc)
		F.owner=src
		F.dir=dir
		walk(F,dir)
		if(tier63)recurrence()
	neckbind()
		prejutsu()
		if(cdelay3||swim||attacking||dead||resting||stun||busy||moving||seals||imitated)return
		if(imitation)
			cdelay3=1
			var/sdelay=200*cdpow/100
			if(level>=37)sdelay-=50
			if(tier41)sdelay*=1-(tier41*0.05)
			handseals(35,10,20)
			if(!sealpass)
				cdelay3=0
				return
			if(tier63)recurrence()
			for(var/obj/jutsu/nara/Shadow_Strangle/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)cdelay3=0
			for(var/mob/M in range(12))if(imitation==M)
				view(8)<<output("<b>[src]: Shadow Strangle!","infobox")
				M.freeze=1
				freeze=1
				spawn(10)shadowoff()
				for(var/obj/imitationt/T in world)if(T.owner==src)T.icon='shadowneck.dmi'
				M.neckbound(src)
	neckbound(var/mob/M)
		neckbound=1
		overlay()
		snared(30,2)
		var/Z=10
		var/heal=0
		var/damage=M.pow*0.20
		if(level>=19)damage*=1.05
		dmgch(M)
		damage=(damage*variable)+variable2
		loop
			if(Z)
				Z--
				heal+=damage
				damage(damage)
				death(M)
				spawn(3)goto loop
			else
				if(M.tier31)
					new/obj/heal(M.loc)
					M.hp+=heal*(0.04*M.tier31)
					if(M.hp>M.maxhp)M.hp=M.maxhp
					if(M.mybar)M.mybar:updatebar()
				neckbound=0
				overlay()
	strategicbombing()
		prejutsu()
		if(cdelay2||swim||attacking||dead||resting||stun||busy||moving||seals||imitated)return
		cdelay2=1
		var/sdelay=250*cdpow/100
		if(level>=13)sdelay-=50
		if(tier41)sdelay*=1-(tier41*0.05)
		handseals(25,6,15)
		if(!sealpass)
			cdelay2=0
			return
		for(var/obj/jutsu/nara/Strategic_Bombing/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay2=0
		freeze=1
		icon_state="jutsu"
		spawn(5)
			freeze=0
			icon_state=""
		var/obj/K=new/obj/bombing(loc)
		K.owner=usr
		var/obj/K1=new/obj/bombing(loc)
		K1.owner=usr
		var/obj/K2=new/obj/bombing(loc)
		K2.owner=usr
		var/obj/K3=new/obj/bombing(loc)
		K3.owner=usr
		var/obj/K4=new/obj/bombing(loc)
		K4.owner=usr
		var/obj/K5=new/obj/bombing(loc)
		K5.owner=usr
		if(tier32)
			var/obj/K6=new/obj/bombing(loc)
			K6.owner=usr
			if(dir==NORTH)K6.loc=locate(x,y+2,z)
			if(dir==SOUTH)K6.loc=locate(x,y-2,z)
			if(dir==EAST)K6.loc=locate(x+2,y,z)
			if(dir==WEST)K6.loc=locate(x-2,y,z)
			if(tier32>=2)
				var/obj/K7=new/obj/bombing(loc)
				K7.owner=usr
				if(dir==NORTH)K7.loc=locate(x,y+4,z)
				if(dir==SOUTH)K7.loc=locate(x,y-4,z)
				if(dir==EAST)K7.loc=locate(x+4,y,z)
				if(dir==WEST)K7.loc=locate(x-4,y,z)
			if(tier32>=3)
				var/obj/K8=new/obj/bombing(loc)
				K8.owner=usr
				if(dir==NORTH)K8.loc=locate(x,y+6,z)
				if(dir==SOUTH)K8.loc=locate(x,y-6,z)
				if(dir==EAST)K8.loc=locate(x+6,y,z)
				if(dir==WEST)K8.loc=locate(x-6,y,z)
		if(dir==NORTH)
			K.loc=locate(x+1,y+6,z)
			K1.loc=locate(x+1,y+4,z)
			K2.loc=locate(x+1,y+2,z)
			K3.loc=locate(x-1,y+6,z)
			K4.loc=locate(x-1,y+4,z)
			K5.loc=locate(x-1,y+2,z)
		if(dir==SOUTH)
			K.loc=locate(x+1,y-6,z)
			K1.loc=locate(x+1,y-4,z)
			K2.loc=locate(x+1,y-2,z)
			K3.loc=locate(x-1,y-6,z)
			K4.loc=locate(x-1,y-4,z)
			K5.loc=locate(x-1,y-2,z)
		if(dir==EAST)
			K.loc=locate(x+6,y+1,z)
			K1.loc=locate(x+4,y+1,z)
			K2.loc=locate(x+2,y+1,z)
			K3.loc=locate(x+6,y-1,z)
			K4.loc=locate(x+4,y-1,z)
			K5.loc=locate(x+2,y-1,z)
		if(dir==WEST)
			K.loc=locate(x-6,y+1,z)
			K1.loc=locate(x-4,y+1,z)
			K2.loc=locate(x-2,y+1,z)
			K3.loc=locate(x-6,y-1,z)
			K4.loc=locate(x-4,y-1,z)
			K5.loc=locate(x-2,y-1,z)
		if(tier63)recurrence()
	shadowclutch()
		prejutsu()
		if(clutchcd||swim||attacking||dead||resting||stun||busy||moving||seals||imitated)return
		clutchcd=1
		var/sdelay=300*cdpow/100
		if(level>=38)sdelay-=50
		if(level>=60)sdelay-=50
		if(tier41)sdelay*=1-(tier41*0.05)
		handseals(20,5,15)
		if(!sealpass)
			clutchcd=0
			return
		for(var/obj/jutsu/nara/Shadow_Clutch/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)clutchcd=0
		new/obj/clutch(loc)
		clutches=0
		for(var/obj/bombing/M in oview(4))if(M.owner==src)
			M.density=1
			walk_towards(M,src)
			M.dontdelete=1
			clutches++
			spawn(10)if(clutches)clutch()
		if(tier63)recurrence()
	clutch()
		var/list/Directions
		Directions = list(NORTH,SOUTH,WEST,EAST,NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST)
		while(src&&clutches)
			var/direction=pick(Directions)
			Directions.Remove(direction)
			clutches--
			var/obj/p = new/obj/bombingprojectile(loc)
			p.owner=src
			p.movequick(direction)
	shadowsummoning()
		prejutsu()
		if(swim||!imitated&&cdelay6||dead||caught||seals||busy)return
		if(imitation)
			for(var/mob/M in world)if(imitation==M)
				if(M.freeze)return
				handseals(100,15,40)
				if(!sealpass)
					shadowoff()
					return
				if(tier63)recurrence()
				M.freeze=1
				cdelay6=1
				var/sdelay=300*cdpow/100
				if(level>=52)sdelay-=50
				if(tier41)sdelay*=1-(tier41*0.05)
				for(var/obj/jutsu/nara/Shadow_Endgame/U in src)timerjutsu(sdelay,U)
				spawn(sdelay)cdelay6=0
				view(8)<<"[src]: Shadow Endgame Jutsu!"
				sleep(10)
				view(8)<<"[src]: Shadow Summoning!"
				for(var/obj/imitationt/T in world)if(T.owner==src)del T
				new/obj/shadowsummon(M.loc)
				new/obj/shadowsummontop(M.loc)
				M.confusion(30)
				if(tier51)M.snared(10+(tier51*5),2)
				M.freeze=0
				shadowoff()
				var/damage=pow*1.5
				var/tmp/hpextra=50
				if(level>=33)hpextra=40
				var/extra=round((M.maxhp-M.hp)/hpextra)
				damage*=1+(0.01*extra)
				M.dmgch(src)
				damage=(damage*M.variable)+M.variable2
				M.damage(damage)
				M.death(src)
	shadowsewing()
		if(shadowed2)
			shadowsewingoff()
			return
		prejutsu()
		if(cdelay5||swim||attacking||dead||resting||stun||busy||moving||seals||imitated||shadow)return
		cdelay5=1
		var/sdelay=250*cdpow/100
		if(tier41)sdelay*=1-(tier41*0.05)
		handseals(15,4,10)
		if(!sealpass)
			cdelay5=0
			return
		if(tier63)recurrence()
		for(var/obj/jutsu/nara/Shadow_Sewing_Jutsu/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay5=0
		view(8)<<"[usr]: Shadow Sewing Jutsu!"
		freeze=1
		sewing=1
		spawn(5)shadowed2=1
		icon_state="jutsu"
		var/K=new/obj/shadowsewing(loc)
		K:dir=SOUTH
		if(dir==NORTH)del K
		var/K2=new/obj/shadowsewing(loc)
		K2:dir=NORTH
		if(dir==SOUTH)del K2
		var/K3=new/obj/shadowsewing(loc)
		K3:dir=EAST
		if(dir==WEST)del K3
		var/K4=new/obj/shadowsewing(loc)
		K4:dir=WEST
		if(dir==EAST)del K4
		for(var/obj/shadowsewing/U in loc)
			U.sewingturns++
			if(level>=44)U.sewingturns++
			U.owner=usr
			U.icon_state=""
			U.shadowstep=U.dir
		if(K)step(K,K:dir)
		if(K2)step(K2,K2:dir)
		if(K3)step(K3,K3:dir)
		if(K4)step(K4,K4:dir)
		for(var/obj/shadowsewing/M in loc)M.icon_state="begin"
		var/N=16
		loop
			if(N>0)
				N--
				if(K)step(K,K:dir)
				if(K2)step(K2,K2:dir)
				if(K3)step(K3,K3:dir)
				if(K4)step(K4,K4:dir)
				spawn(1)goto loop
			else
				sleep(14)
				shadowsewingoff()
				del K
	imitation()
		if(shadowed)
			shadowoff()
			return
		prejutsu()
		if(shadowdelay||swim||attacking||dead||resting||stun||busy||moving||seals||imitated)return
		shadowdelay=1
		var/sdelay=100*cdpow/100
		if(tier41)sdelay*=1-(tier41*0.05)
	/*	handseals(15,4,10)
		if(!sealpass)
			shadowdelay=0
			return */
		if(tier63)recurrence()
		for(var/obj/jutsu/nara/Shadow_Imitation/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)shadowdelay=0
		for(var/mob/player/M in get_step(src,dir))
			faceme(M)
			M.stepback(2)
		range(8)<<"<font color=silver><b>[src]: Shadow Imitation!"
		freeze=1
		shadow=1
		icon_state="jutsu"
		spawn(5)shadowed=1
		var/obj/K=new/obj/imitation(loc)
		K.shadowturns=2
		if(level>=31)K.shadowturns++
		K.owner=usr
		K.dir=dir
		K.shadowstep=K.dir
		step(K,dir)
		for(var/obj/imitationt/M in loc)M.icon_state="begin"
		var/N=16
		loop
			if(K.freeze)return
			if(N>0)
				N--
				if(K)
					step(K,K.dir)
					if(get_dist(src,K)>=12&&K)
						del K
						shadowoff()
						return
					spawn(2)goto loop
			else
				K:icon_state="struggle"
				sleep(14)
				shadowoff()
				del K
	shadowgathering()
		prejutsu()
		if(cdelay4||swim||attacking||dead||resting||stun||busy||moving||seals||imitated)return
		if(shadow&&!imitation)
			cdelay4=1
			var/sdelay=300*cdpow/100
			if(level>=39)sdelay-=50
			if(tier41)sdelay*=1-(tier41*0.05)
			for(var/obj/jutsu/nara/Shadow_Gathering/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)cdelay4=0
			if(tier63)recurrence()
			range(8)<<"<font color=silver><b>[src]: Shadow Gathering!"
			for(var/obj/imitation/M in oview(12))
				if(M.owner==src)
					M.freeze=1
					var/obj/K=new/obj/shadowgathering(M.loc)
					var/obj/K1=new/obj/shadowgathering(M.loc)
					var/obj/K2=new/obj/shadowgathering(M.loc)
					K.owner=src
					K1.owner=src
					K2.owner=src
					K.dir=M.dir
					if(M.dir==NORTH)
						step(K1,EAST)
						K1.dir=SOUTHWEST
						step(K2,WEST)
						K2.dir=SOUTHEAST
						step(K1,NORTH)
						step(K2,NORTH)
					if(M.dir==EAST)
						step(K1,NORTH)
						K1.dir=NORTHEAST
						step(K2,SOUTH)
						K2.dir=SOUTHEAST
						step(K1,EAST)
						step(K2,EAST)
					if(M.dir==SOUTH)
						step(K1,EAST)
						K1.dir=NORTHWEST
						step(K2,WEST)
						K2.dir=NORTHEAST
						step(K1,SOUTH)
						step(K2,SOUTH)
					if(M.dir==WEST)
						step(K1,NORTH)
						K1.dir=NORTHWEST
						step(K2,SOUTH)
						K2.dir=SOUTHWEST
						step(K1,WEST)
						step(K2,WEST)
					step(K,K.dir)
					for(var/obj/shadowgathering/M2 in M.loc)M2.icon_state="begin"
					K.gathermove(K.dir)
					K1.gathermove(K1.dir)
					K2.gathermove(K2.dir)
	shadowsewingoff()
		if(sewing)
			if(shadowed2)shadowed2=0
			if(!shadow)freeze=0
			sewing=0
			for(var/obj/shadowsewing/M in world)if(M.owner==src)del M
			for(var/obj/shadowsewingt/T in world)if(T.owner==src)del T
			shadowdir=null
	shadowoff()
		if(imitated||imitation||shadowdir||shadow||shadowed)
			if(shadowed)shadowed=0
			if(shadow)shadow=0
			for(var/mob/G in world)if(imitation==G)
				G.imitated=0
				G.freeze=0
				G.shadowdir=null
				if(tier62)G.imitationdebuff(20*tier62)
			if(imitated)for(var/mob/G in world)if(G.imitation==src)
				G.imitation=null
				G.freeze=0
				for(var/obj/imitation/M in world)if(M.owner==G)del M
				for(var/obj/imitationt/T in world)if(T.owner==G)del T
				G.shadowdir=null
				if(G.tier62)imitationdebuff(20*G.tier62)
			imitation=null
			imitated=0
			if(!sewing)freeze=0
			for(var/obj/imitation/M in world)if(M.owner==src)del M
			for(var/obj/imitationt/T in world)if(T.owner==src)del T
			shadowdir=null
	shadowcaught(var/mob/M,var/obj/T)
		range(src,10)<<"<b>[M] has been caught by [src]'s Shadow Imitation!"
		M.breakresting()
		M.imitated=1
		imitation=M
		shadowdir=dir
		shadow=0
		T.faceme(M)
		M.shadowdir=M.dir
		var/obj/K=new/obj/imitationt(M.loc)
		K.dir=T.dir
		K.owner=src
		K.icon_state=""
		K.shadowstep=K.dir
		icon_state=""
		shadowchakra()
		shadowtimer(M)
		del T
	shadowtimer(var/mob/T)
		var/shadowtimer=5
		if(tier11)shadowtimer+=tier11
		if(level>=11)shadowtimer++
		loop
			if(imitation)
				shadowtimer--
				if(tier53&&hp<maxhp)
					new/obj/heal(loc)
					hp+=maxhp*(0.01*tier53)
					if(hp>maxhp)hp=maxhp
					if(mybar)mybar:updatebar()
				if(!shadowtimer)
					shadowoff()
					return
			else
				return
			spawn(14)goto loop
	shadowchakra()
		set background = 1
		var/cost=round(maxcha*0.05)
		spawn(14)
			if(imitation)
				cha-=cost
				if(cha<0)cha=0
				if(cha==0)
					src<<"You have ran out of chakra!"
					shadowoff()
					return
				spawn()shadowchakra()
	deadlyshadows(var/T=0)
		if(deadlyshadows)return
		deadlyshadows=1
		regenupdate()
		spawn(T)
			deadlyshadows=0
			regenupdate()
	imitationdebuff(var/T=0)
		if(imitationdebuff)return
		imitationdebuff=1
		atkdef()
		spawn(T)
			imitationdebuff=0
			atkdef()
	shadowfists()
		prejutsu()
		if(fistdelay||swim||dead||stun||resting||caught||seals||busy||imitated||paralysed)return
		handseals(40,8,30)
		if(!sealpass)return
		fistdelay=1
		var/sdelay=200*(cdapow/100)
		for(var/obj/jutsu/nara/Shadow_Fists/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)
			fistdelay=0
		if(tier63)recurrence()
		freeze=1
		icon_state="jutsu"
		spawn(6)
			freeze=0
			icon_state=""
		var/waves=3
		while(waves)
			waves--
			var/obj/F=new/obj/shadowfist(loc)
			var/obj/F2=new/obj/shadowfist(loc)
			var/obj/F3=new/obj/shadowfist(loc)
			for(var/obj/shadowfist/M in loc)
				M.owner=src
				M.dir=dir
			if(dir==NORTH||dir==SOUTH)
				F2.x--
				F3.x++
			if(dir==EAST||dir==WEST)
				F2.y--
				F3.y++
			walk(F,F.dir)
			walk(F2,F2.dir)
			walk(F3,F3.dir)
			sleep(2)
	recurrence()
		if(recurrence<5)
			recurrence++
			relentless(1)
			atkdef()
			forceupdate()
			spawn(50)
				recurrence--
				relentless(-1)
				atkdef()
				forceupdate()
				if(recurrence<0)recurrence=0
obj/var
	dontdelete=0
	bounces=0
	bouncess = list()
obj/proc
	bounce(var/mob/D,var/mob/O)
		loc=D.loc
		bouncess:Add(D)
		var/T=0
		for(var/mob/player/M in range(4,src))
			if(O.aff==M.aff)continue
			if(M==D)continue
			if(M in bouncess)continue
			T=1
			bounces++
			walk(src,0)
			walk_towards(src,M)
		if(T==0)del src

obj
	imitation
		icon = 'shadowtrail.dmi'
		name="Shadow Imitation"
		animate_movement=0
		pixel_y=-5
		density=1
		rundelay=0
		var/oldtrack=null
		Bump(A)
			if(istype(A,/mob/player))
				var/mob/O=owner
				var/mob/D=A
				if(O.aff==D.aff||D.imitated||D.imitation||D.shield)
					loc=D.loc
					return
				if(O.tier42)D.deadlyshadows(20*O.tier42)
				O.shadowcaught(D,src)
			else
				if(istype(A,/mob))
					var/mob/D=A
					loc=D.loc
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					owner.shadowoff()
					del src
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					loc=T.loc
		Move()
			if(!freeze)
				var/K=new/obj/imitationt(loc)
				K:dir=dir
				sleep(-1)
				if(oldtrack==NORTH)
					if(K:dir==EAST)K:dir=NORTHEAST
					if(K:dir==WEST)K:dir=NORTHWEST
				if(oldtrack==SOUTH)
					if(K:dir==EAST)K:dir=SOUTHEAST
					if(K:dir==WEST)K:dir=SOUTHWEST
				if(oldtrack==EAST)
					if(K:dir==NORTH)K:dir=SOUTHWEST
					if(K:dir==SOUTH)K:dir=NORTHWEST
				if(oldtrack==WEST)
					if(K:dir==NORTH)K:dir=SOUTHEAST
					if(K:dir==SOUTH)K:dir=NORTHEAST
				oldtrack=dir
				K:owner=owner
				K:shadowstep=K:dir
			..()
		Del()
			if(owner&&!owner.sewing)
				owner.freeze=0
				owner.icon_state=""
			..()
	shadowsewing
		icon = 'shadowsew.dmi'
		name="Shadow Sewing"
		animate_movement=0
		pixel_y=-5
		density=1
		rundelay=0
		var/oldtrack=null
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(D.clone)
					loc=D.loc
					del D
					return
				loc=D.loc
				if(O.aff==D.aff)return
				if(D.illusion)
					D.illusionhit(O)
					return
				var/damage=O.pow*0.85
				if(O.level>=28)damage*=1.1
				if(O.tier42)D.deadlyshadows(20*O.tier42)
				D.stun(28)
				D.dmgch(O)
				damage=(damage*D.variable)+D.variable2
				if(O.tier43)
					O.cha+=damage*(0.1*O.tier43)
					if(O.cha>O.maxcha)O.cha=O.maxcha
					if(O.mybar2)O.mybar2:updatebar()
				D.damage(damage)
				D.death(O)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					loc=T.loc
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					loc=T.loc
		Move()
			var/K=new/obj/shadowsewingt(loc)
			K:dir=dir
			sleep(-1)
			if(oldtrack==NORTH)
				if(K:dir==EAST)K:dir=NORTHEAST
				if(K:dir==WEST)K:dir=NORTHWEST
			if(oldtrack==SOUTH)
				if(K:dir==EAST)K:dir=SOUTHEAST
				if(K:dir==WEST)K:dir=SOUTHWEST
			if(oldtrack==EAST)
				if(K:dir==NORTH)K:dir=SOUTHWEST
				if(K:dir==SOUTH)K:dir=NORTHWEST
			if(oldtrack==WEST)
				if(K:dir==NORTH)K:dir=SOUTHEAST
				if(K:dir==SOUTH)K:dir=NORTHEAST
			oldtrack=dir
			K:owner=owner
			K:shadowstep=K:dir
			..()
		Del()
			if(owner)
				owner.shadowsewingoff()
				owner.icon_state=""
			..()
	shadowsewingt
		name=""
		icon = 'shadowsew.dmi'
		icon_state="trail"
		pixel_y=-5
		rundelay=0
		animate_movement=2
		Move()
			..()
			dir=shadowstep
	imitationt
		name=""
		icon = 'shadowtrail.dmi'
		icon_state="trail"
		pixel_y=-5
		rundelay=0
		animate_movement=2
		Move()
			..()
			dir=shadowstep
	shadowshuriken
		icon='shadow shuriken.dmi'
		layer=5
		density=1
		New()
			..()
			spawn(50)if(src)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(O.aff==D.aff)
					loc=D.loc
					return
				var/slow=20
				var/damage=O.pow
				var/bouncedamage=0.5
				if(O.level>=72)bouncedamage=0.6
				if(bounces>=1)
					damage*=1+(bounces*bouncedamage)
					slow*=1+(bounces*0.5)
				if(O.tier42)D.deadlyshadows(20*O.tier42)
				D.snared(slow,2)
				D.dmgch(O)
				damage=(damage*D.variable)+D.variable2
				D.damage(damage)
				D.death(O)
				if(bounces>=4)
					del src
					return
				bounce(D,O)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					loc=T.loc
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					loc=T.loc
	shadowfist
		icon='shadowfist.dmi'
		layer=5
		density=1
		New()
			..()
			spawn(20)if(src)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				loc=D.loc
				if(O.aff==D.aff)return
				var/damage=O.pow*0.25
				damage+=(D.maxhp-D.hp)*0.03
				if(O.imitation==D)damage*=1.2
				if(O.tier42)D.deadlyshadows(20*O.tier42)
				D.dmgch(O)
				damage=(damage*D.variable)+D.variable2
				D.damage(damage)
				D.death(O)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					loc=T.loc
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)
	shadowshurikens
		icon='shadowshurikens.dmi'
		layer=5
		density=1
		var/intensity=1
		New()
			..()
			spawn(20)if(src)del src
		Move()
			..()
			intensity+=0.10
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(O.aff==D.aff)
					loc=D.loc
					return
				var/damage=O.pow*(0.3+(0.1*O.tier13))
				if(O.tier42)D.deadlyshadows(20*O.tier42)
				damage+=round(O.cha*(O.tier13*0.02))
				damage*=intensity
				D.dmgch(O)
				damage=(damage*D.variable)+D.variable2
				D.damage(damage)
				D.death(O)
				del src
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					loc=T.loc
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)
	clutch
		layer=15
		icon='clutch.dmi'
		pixel_x=-144
		pixel_y=-144
		New()
			..()
			flick("wave",src)
			spawn(15)del src
	bombing
		icon='landmine.dmi'
		icon_state="armed"
		New()
			..()
			spawn(50)if(src&&!dontdelete)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(D==O)
					del src
					return
				loc=D.loc
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					loc=T.loc
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					loc=T.loc
		Crossed(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(O.aff==D.aff)return
				var/damage=O.pow*0.30
				if(O.level>=34)damage*=1.1
				if(O.imitation==D)damage+=O.pow*0.15
				if(O.tier42)D.deadlyshadows(20*O.tier42)
				D.dmgch(O)
				damage=(damage*D.variable)+D.variable2
				D.damage(damage)
				D.death(O)
				del src
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					T.loc=loc
		Del()
			if(!dontdelete)new/obj/claymineexplosion(loc)
			..()
	bombingprojectile
		icon='landmine.dmi'
		icon_state="armed"
		density=1
		New()
			..()
			spawn(25)if(src)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(O.aff==D.aff)
					loc=D.loc
					return
				D.dir = get_dir(D, src)
				if(D.dir == NORTHEAST)
					if(src.dir == SOUTH)
						D.dir = NORTH
					if(src.dir == EAST)
						D.dir = EAST
					if(src.dir == WEST)
						D.dir = EAST
				if(D.dir == NORTHWEST)
					if(src.dir == SOUTH)
						D.dir = NORTH
					if(src.dir == EAST)
						D.dir = WEST
					if(src.dir == WEST)
						D.dir = WEST
				if(D.dir == SOUTHEAST)
					if(src.dir == NORTH)
						D.dir = SOUTH
					if(src.dir == EAST)
						D.dir = EAST
					if(src.dir == WEST)
						D.dir = EAST
				if(D.dir == SOUTHWEST)
					if(src.dir == NORTH)
						D.dir = SOUTH
					if(src.dir == EAST)
						D.dir = WEST
					if(src.dir == WEST)
						D.dir = WEST
				D.stepback(3)
				var/damage=O.pow*1.2
				if(O.tier52)
					var/extra=(D.maxhp-D.hp)*(O.tier52*0.04)
					damage+=extra
				if(O.tier42)D.deadlyshadows(20*O.tier42)
				D.dmgch(O)
				damage=(damage*D.variable)+D.variable2
				D.damage(damage)
				D.death(O)
				del src
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					loc=T.loc
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					loc=T.loc
		Del()
			new/obj/claymineexplosion(loc)
			..()
	shadowgathering
		icon = 'shadowsew.dmi'
		animate_movement=0
		pixel_y=-5
		density=1
		rundelay=0
		New()
			..()
			spawn(20)if(src)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(D.clone)
					loc=D.loc
					del D
					return
				loc=D.loc
				if(O.aff==D.aff)return
				if(O.tier33)O.assurance=1
				var/damage=O.pow
				if(O.level>=20)damage*=1.1
				if(O.tier42)D.deadlyshadows(20*O.tier42)
				D.stun(20)
				D.magnetic(O,get_dist(D,O)-1,1)
				D.dmgch(O)
				damage=(damage*D.variable)+D.variable2
				D.damage(damage)
				D.death(O)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del src
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					del src
		Move()
			if(!freeze)
				var/obj/K=new/obj/shadowgatheringt(loc)
				K.dir=dir
				K.owner=src
			..()
		Del()
			for(var/obj/shadowgatheringt/M in world)if(M.owner==src)del M
			if(owner)
				owner.shadowoff()
				owner.icon_state=""
			..()
	shadowgatheringt
		name=""
		icon = 'shadowsew.dmi'
		icon_state="trail"
		pixel_y=-5
		rundelay=0
		animate_movement=2
obj/Shadow_Blade
	icon='blade.dmi'
	density=1

	rundelay=0
	deflectable=1
	New()
		..()
		spawn(7)del src
	Bump(A)
		if(istype(A,/mob))
			var/mob/Owner=owner
			var/mob/Damaged=A
			if(Owner.aff==Damaged.aff)
				loc=Damaged.loc
				return
			projectile(Owner,Damaged,round(round(Owner.apow/1.4)+rand(12,22)))
		if(istype(A,/turf))
			var/turf/T = A
			if(T.density)
				del(src)
		if(istype(A,/obj))
			var/obj/T = A
			if(T.density)
				projduel(A)
	Del()
		var/G=new/obj/shadowground(loc)
		G:owner=owner
		..()
obj/shadowground
	icon='blade.dmi'
	icon_state="stuck"
	density=0
	layer=23
	New()
		..()
		spawn(200)del src
		spawn(1)
		loop
			if(!owner)del src
			for(var/mob/M in loc)
				if(!M.paralysed&&M!=owner)
					if(owner.aff==M.aff)continue
					M.paralysed=1
					icon_state="stuckc"
					sleep(70)
					M.paralysed=0
					del src
			spawn(1)goto loop