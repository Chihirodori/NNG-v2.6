mob/var
	violentwindpalm=0
mob/proc
	sandclone()
		if(swim)return
		prejutsu()
		if(resting||meditating||dead||stun||seals||busy||imitated||paralysed)return
		if(cloned)
			var/T=0
			for(var/mob/Clone/O in world)if(O.cloneowner==usr)
				T++
				del O
			if(!T)goto cloneless
			cloned=0
			usr<<"You have destroyed your clones."
			return
		cloneless
		if(clonedelay)return
		for(var/turf/T in oview(2))if(T.density)
			usr<<"The space is too cramped to use."
			return
		handseals(20,20)
		if(!sealpass)return
		clonedelay=1
		for(var/obj/jutsu/Clone_Jutsu/M in src)M.overlays+='timer.dmi'
		for(var/obj/jutsu/Shadow_Clone_Jutsu/M in src)M.overlays+='timer.dmi'
		for(var/obj/jutsu/sand/Sand_Clone_Jutsu/M in src)M.overlays+='timer.dmi'
		view(8)<<"<font color='#E0A175'><b>[usr]: Sand Clone Jutsu!"
		cloned=1
		stun=1
		spawn(10)stun=0
		new/obj/smoke(loc)
		var/mob/Clone/sandclone/K=new(locate(x-1,y,z))
		K.cloneowner=usr
		var/mob/Clone/sandclone/K1=new(locate(x+1,y,z))
		K1.cloneowner=usr
		for(var/mob/Clone/sandclone/M in oview(2))
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
				M.apow=round(apow/2)
				M.maxhp=maxhp*0.30
				M.hp=M.maxhp
				M.shadowclone()
				var/obj/bars/healthbar/B1=new(M.loc)
				B1.barowner=M
				B1.copy(src)
				M.mybar=B1
				var/obj/bars/chakrabar/B2=new(M.loc)
				B2.barowner=M
				B2.copy(src)
				M.mybar2=B2
		var/sdelay=400*cdpow/100
		for(var/obj/jutsu/sand/Sand_Clone_Jutsu/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)clonedelay=0
		if(clan=="Copy Ninja")tactics()
	windpressureblast()
		prejutsu()
		if(vdelay2||freeze||swim||dead||seals||resting||stun||busy||moving||imitated||paralysed)return
		handseals(20,5)
		if(!sealpass)return
		vdelay2=1
		for(var/obj/jutsu/sand/Wind_Pressure_Blast/M in src)M.overlays+='timer.dmi'
		var/sdelay=120
		if(curseseal==2)sdelay=sdelay/1.5
		if(curseseal==3)sdelay=sdelay/2
		spawn(sdelay*(cdpow/100))
			for(var/obj/jutsu/sand/Wind_Pressure_Blast/M in src)M.overlays-='timer.dmi'
			vdelay2=0
		var/obj/K=new/obj/windpressureblast(loc)
		K.dir=dir
		K.owner=src
		walk(K,dir)
		var/obj/K2=new/obj/windpressureblast(loc)
		K2.dir=dir
		K2.owner=src
		var/obj/K3=new/obj/windpressureblast(loc)
		K3.dir=dir
		K3.owner=src
		if(dir==NORTH||dir==SOUTH)
			K2.x--
			K3.x++
		if(dir==WEST||dir==EAST)
			K2.y--
			K3.y++
		walk(K2,dir)
		walk(K3,dir)
	windsword()
		prejutsu()
		if(vdelay3||freeze||swim||dead||seals||resting||stun||busy||moving||imitated||paralysed)return
		handseals(35,80,1)
		if(!sealpass)return
		vdelay3=1
		for(var/obj/jutsu/sand/Wind_Sword/M in src)M.overlays+='timer.dmi'
		var/sdelay=300
		if(curseseal==2)sdelay=sdelay/1.5
		if(curseseal==3)sdelay=sdelay/2
		spawn(sdelay*(cdpow/100))
			for(var/obj/jutsu/sand/Wind_Sword/M in src)M.overlays-='timer.dmi'
			vdelay3=0
		var/obj/K=new/obj/windsword(loc)
		K.owner=src
		if(K)step(K,dir)
		if(K)step(K,dir)
		if(K)step(K,dir)
		if(K)step(K,dir)
		if(K)step(K,dir)
		if(K)step(K,dir)
		if(K)step(K,dir)
		if(K)step(K,dir)
		del K
	violentwindpalm()
		prejutsu()
		if(vdelay4||copydelay5||swim||dead||resting||stun||busy||moving||imitated||paralysed)return
		if(clan=="Copy Ninja")copydelay5=1
		else	vdelay4=1
		handseals(40,10,40)
		if(!sealpass)
			vdelay4=0
			copydelay5=0
			return
		var/sdelay=200
		for(var/obj/jutsu/sand/Violent_Wind_Palm/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)
			vdelay4=0
			copydelay5=0
		violentwindpalm=1
		spawn(50)if(violentwindpalm)violentwindpalm=0
		if(clan=="Copy Ninja")tactics()
	viopalm(var/mob/M)
		var/obj/K=new/obj/violentwindpalm(loc)
		K.owner=M
		walk(K,dir)
		var/T=6
		fast=1
		loop
			if(!src)
				del K
				return
			if(T>0)
				T--
				var/obj/image=new/obj/kimage(loc)
				image.dir=dir
				image.icon=icon
				image.overlays=overlays
				image.invisibility=invisibility
				moving=0
				var/obj/K1=new/obj/violenttrail(loc)
				K1.owner=K
				K1.dir=dir
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
				runstep=0
				spawn(2)goto loop
			else
				del K
		fast=0

obj
	windpressureblast
		icon='windpressureblast.dmi'
		density=1
		rundelay=0
		var/T=0
		New()
			..()
			spawn(70)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				D.stepback(3)
				projectile(O,D,O.pow*0.95)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)
		Del()
			new/obj/windpressureexplosion(loc)
			..()
		Move()
			..()
			T++
			if(T>8)del src
	windsword
		density=1
		rundelay=0
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				projectile(O,D,O.pow*0.75)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					loc=T.loc
		Del()
			new/obj/windswordexp(loc)
			new/obj/windswordexptop(loc)
			..()
	violenttrail
		name="Violent Wind Palm"
		icon='violentwindpalm.dmi'
		layer=15
		New()spawn(12)del src
	violentwindpalm
		density=1
		rundelay=0
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(D.aff==O.aff)
					loc=D.loc
					return
				if(D.illusion)
					D.illusionhit(O)
					return
				var/damage=O.pow*0.1
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
					loc=T.loc