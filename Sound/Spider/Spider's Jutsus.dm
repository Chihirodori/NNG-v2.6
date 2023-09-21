mob/var
	spidering=0
	webcaught=""

mob/proc
	spiderspit()
		prejutsu()
		if(cdelay1||cdelay6==2||swim||dead||stun||resting||caught||imitated||paralysed||seals||busy)return
		handseals(15,5,10)
		if(!sealpass)return
		cdelay1=1
		for(var/obj/jutsu/spider/Spider_Sticking_Spit/M in src)M.overlays+='timer.dmi'
		var/obj/Spider_Sticking_Spit/L=new(loc)
		L.dir=dir
		L.owner=usr
		walk(L,dir)
		var/sdelay=50
		spawn(sdelay*(cdpow/100))
			for(var/obj/jutsu/spider/Spider_Sticking_Spit/M in src)M.overlays-='timer.dmi'
			cdelay1=0
	webcaught(var/mob/M)
		webcaught=M
		overlays += /obj/webbed
		snared(28,2)
		spawn(28)
			webcaught=""
			overlays -= /obj/webbed
	spiderspikes()
		prejutsu()
		if(cdelay3||swim||dead||stun||resting||caught||seals||busy||imitated||paralysed)return
		handseals(20,5,20)
		if(!sealpass)return
		cdelay3=1
		for(var/obj/jutsu/spider/Golden_Spider_Spike/M in src)M.overlays+='timer.dmi'
		flick("attack",usr)
		var/obj/Golden_Spider_Spike/L=new(loc)
		var/obj/Golden_Spider_Spike/L1=new(loc)
		var/obj/Golden_Spider_Spike/L2=new(loc)
		L.owner=src
		L1.owner=src
		L2.owner=src
		if(dir==NORTH)
			L.dir=NORTH
			L1.dir=NORTHEAST
			L2.dir=NORTHWEST
		if(dir==SOUTH)
			L.dir=SOUTH
			L1.dir=SOUTHEAST
			L2.dir=SOUTHWEST
		if(dir==WEST)
			L.dir=WEST
			L1.dir=SOUTHWEST
			L2.dir=NORTHWEST
		if(dir==EAST)
			L.dir=EAST
			L1.dir=NORTHEAST
			L2.dir=SOUTHEAST
		L.boomerang(8)
		L1.boomerang(8)
		L2.boomerang(8)
		var/sdelay=100
		if(curseseal==2)sdelay=sdelay/1.5
		if(curseseal==3)sdelay=sdelay/2
		spawn(sdelay*(cdpow/100))
			for(var/obj/jutsu/spider/Golden_Spider_Spike/M in src)M.overlays-='timer.dmi'
			cdelay3=0
	spiderbow()
		prejutsu()
		if(cdelay5||swim||dead||resting||stun||busy||freeze||moving||imitated||paralysed)return
		handseals(35,10,20)
		if(!sealpass)return
		cdelay5=1
		range(12)<<"<b><font color='#996633'>[src]: Golden War Bow!"
		for(var/obj/jutsu/spider/Spider_War_Bow/M in src)M.overlays+='timer.dmi'
		icon_state="spear"
		freeze=1
		var/obj/spiderwarbow/L=new(loc)
		L.dir=dir
		var/wait=10
		var/fires=0
		spawn(wait)
			while(fires<3)
				fires++
				icon_state=""
				flick("attack",src)
				var/K=new/obj/spiderarrow(loc)
				K:damagee=fires
				K:owner=usr
				var/N=12
				K:dir=dir
				loop
					if(N>0)
						N--
						if(K)
							step(K,dir)
							goto loop
				for(var/obj/spiderarrowt/M in loc)del M
				icon_state="spear"
				sleep(4)
				if(fires>=3)
					for(var/obj/spiderwarbow/M in loc)del M
					icon_state=""
					freeze=0
		var/sdelay=120
		if(curseseal==2)sdelay=sdelay/1.5
		if(curseseal==3)sdelay=sdelay/2
		spawn(sdelay*(cdpow/100))
			for(var/obj/jutsu/spider/Spider_War_Bow/M in src)M.overlays-='timer.dmi'
			cdelay5=0
	spidercocoon()
		prejutsu()
		if(swim||cdelay4||dead||caught||seals||busy||imitated||paralysed)return
		var/T=0
		for(var/mob/M in oview(8))if(M.busy=="webbed"||M.busy=="webbed2")T=1
		if(T)
			handseals(55,85)
			if(!sealpass)return
			cdelay4=1
			for(var/obj/jutsu/spider/Spider_Cocoon/M in src)M.overlays+='timer.dmi'
			view(8)<<"<b><font color=white>[usr]: Spider Cocoon!"
			for(var/mob/M in oview(8))
				if(M.busy=="webbed"||M.busy=="webbed2")
					M.busy="cocoon"
					overlays-=/obj/webbed
					spawn(140)if(M)
						M.stun=0
						M.busy=null
		var/sdelay=300
		if(curseseal==2)sdelay=sdelay/1.5
		if(curseseal==3)sdelay=sdelay/2
		spawn(sdelay*(cdpow/100))
			for(var/obj/jutsu/spider/Spider_Cocoon/M in src)M.overlays-='timer.dmi'
			cdelay4=0
	rainofspiders()
		prejutsu()
		if(cdelay6||swim||dead||stun||resting||caught||seals||busy||imitated||paralysed)return
		var/waves=10
		var/position=0
		while(src&&waves)
			if(waves==10||waves==8||waves==6|waves==4||waves==2)position=1
			else	position=0
			waves--
			var/obj/spider/V=new(loc)
			var/obj/spider/V1=new(loc)
			var/obj/spider/V2=new(loc)
			if(dir==NORTH||dir==SOUTH)
				V1.x--
				if(position)V1.x--
				V2.x++
				if(position)V2.x++
			if(dir==EAST||dir==WEST)
				V1.y--
				if(position)V1.y--
				V2.y++
				if(position)V2.y++
			V.owner=src
			V1.owner=src
			V2.owner=src
			V.dir=dir
			V1.dir=dir
			V2.dir=dir
			walk(V,dir)
			walk(V1,dir)
			walk(V2,dir)
			sleep(2)
obj/var/damagee=0
obj/proc/boomerang(var/K)
	var/T=0
	damagee=1
	loop
		if(T<K)
			T++
			step(src,dir)
			spawn(1)goto loop
		else
			T=0
			damagee=2
			loop2
				step_towards(src,owner)
				spawn(1)goto loop2
obj
	spidernet
		icon='spider net.dmi'
		pixel_y=-32
		pixel_x=-32
		New()
			..()
			spawn(50)if(src)del src
		proc
			spiderproc()
				while(src)
					var/obj/spider/V=new(loc)
					V.owner=owner
					V.dir=pick(NORTH,SOUTH,EAST,WEST,NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST)
					walk(V,V.dir)
					sleep(3)
	spider
		icon='spider.dmi'
		density=1
		layer=38
		projint=1
	//	animate_movement=2
		New()
			..()
			spawn(25)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/Owner=owner
				var/mob/Damaged=A
				if(Owner.aff==Damaged.aff)
					loc=Damaged.loc
					return
				new/obj/birdexplosion(Damaged.loc)
				var/damage=Owner.apow*0.65
				Damaged.dmgch(Owner)
				damage=(damage*Damaged.variable)+Damaged.variable2
				Damaged.damage(damage)
				Damaged.death(Owner)
				del src
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)
	Spider_Sticking_Spit
		icon='spiderspit.dmi'
		density=1
		layer=10
		rundelay=0
		New()
			..()
			spawn(20)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(D.aff==O.aff)return
				var/damage=O.apow*0.25
				D.dmgch(O)
				damage=(damage*D.variable)+D.variable2
				D.damage(damage)
				D.death(O)
				if(D.webcaught=="")D.webcaught(O)
				del src
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					del T
	spiderwebbed
		layer=42
		icon='spiderspit.dmi'
		icon_state="caught"
	Golden_Spider_Spike
		icon='spiderspike.dmi'
		animate_movement=2
		density=1
		New()
			..()
			spawn(30)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(D==O)
					del src
					return
				loc=D.loc
				if(O.aff==D.aff)return
				var/damage=O.apow*0.40
				if(damagee==1)damage+=D.maxhp*0.05
				if(damagee==2)damage+=D.hp*0.05
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
	spiderwarbow
		icon='spiderwarbow.dmi'
		layer=100
	spiderarrow
		rundelay=0
		density=1
		name="Golden Spider Arrow"
		animate_movement=0
		New()spawn(7)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				loc=D.loc
				if(O.aff==D.aff)return
				new/obj/crater(D.loc)
			//	if(dir==D.dir)projectilep(O,D,O.pow*3.5)
				var/damage=O.apow*(0.50*damagee)
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
					loc=T.loc
		Move()
			var/obj/K=new/obj/spiderarrowt(loc)
			K.dir=dir
			..()
	spiderarrowt
		layer=15
		New()
			..()
			flick('spiderarrow.dmi',src)
			spawn(7)del src
obj/webbed
	layer=30
	icon='spiderspit.dmi'
	icon_state="caught"