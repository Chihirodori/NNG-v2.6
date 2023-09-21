mob
	proc
		airblast()
			hengeback()
			cloakoff()
			if(subinvis)
				subinvis=0
			if(cdelay1||swim||dead||stun||resting||caught||seals||busy||imitated)return
			cdelay1=1
			var/obj/K=new/obj/airblast(loc)
			K.owner=usr
			K.dir=dir
			var/N=8
			loop
				if(N>0)
					N--
					step(K,dir)
					if(K)
						goto loop
			del K
			spawn(14)cdelay1=0
		zankuuha()
			prejutsu()
			if(cdelay3||swim||dead||stun||resting||caught||seals||busy||imitated)return
			handseals(15,30,1)
			if(!sealpass)return
			cdelay3=1
			for(var/obj/jutsu/soundc/Splicing_Sound_Wave/M in src)M.overlays+='timer.dmi'
			stun=1
			icon_state="jutsu"
			busy="stun"
			var/obj/K=new/obj/zankuuha(loc)
			K.owner=usr
			var/N=4
			K.powmin=4
			K.powmax=8
			K.dir=dir
			loop
				if(N>0)
					N--
					if(K)
						step(K,dir)
						goto loop
			for(var/obj/zankuuhat/M in loc)M.icon_state="blast"
			var/sdelay=60
			if(curseseal==2)sdelay=sdelay/1.5
			if(curseseal==3)sdelay=sdelay/2
			spawn(sdelay*(cdpow/100))
				for(var/obj/jutsu/soundc/Splicing_Sound_Wave/M in src)M.overlays-='timer.dmi'
				cdelay3=0
			spawn(14)
				busy=null
				icon_state=""
				stun=0
		chakrabarrier()
			prejutsu()
			if(cdelay5||freeze||swim||seals||dead||barrierhold||resting||stun||busy||moving||imitated)return
			handseals(25,50)
			if(!sealpass)return
			cdelay5=1
			for(var/obj/jutsu/soundc/Chakra_Barrier/M in src)M.overlays+='timer.dmi'
			var/sdelay=300
			if(curseseal==2)sdelay=sdelay/1.5
			if(curseseal==3)sdelay=sdelay/2
			spawn(sdelay*(cdpow/100))
				for(var/obj/jutsu/soundc/Chakra_Barrier/M in src)M.overlays-='timer.dmi'
				cdelay5=0
			icon_state="jutsu"
			range(12)<<"<b><font color=silver>[src]: Chakra Barrier!"
			freeze=1
			new/obj/Chakra_Barrier(loc)
			var/obj/L2=new/obj/Chakra_Barrier(loc)
			var/obj/L3=new/obj/Chakra_Barrier(loc)
			var/obj/L4=new/obj/Chakra_Barrier(loc)
			var/obj/L5=new/obj/Chakra_Barrier(loc)
			var/obj/L6=new/obj/Chakra_Barrier(loc)
			var/obj/L7=new/obj/Chakra_Barrier(loc)
			var/obj/L8=new/obj/Chakra_Barrier(loc)
			var/obj/L9=new/obj/Chakra_Barrier(loc)
			if(dir==NORTH||dir==SOUTH)
				L2.loc=locate(x+1,y,z)
				L3.loc=locate(x-1,y,z)
				L4.loc=locate(x+2,y,z)
				L5.loc=locate(x-2,y,z)
				L6.loc=locate(x+3,y,z)
				L7.loc=locate(x-3,y,z)
				L8.loc=locate(x+4,y,z)
				L9.loc=locate(x-4,y,z)
			if(dir==EAST||dir==WEST)
				L2.loc=locate(x,y-1,z)
				L3.loc=locate(x,y+1,z)
				L4.loc=locate(x,y+2,z)
				L5.loc=locate(x,y-2,z)
				L6.loc=locate(x,y-3,z)
				L7.loc=locate(x,y+3,z)
				L8.loc=locate(x,y+4,z)
				L9.loc=locate(x,y-4,z)
			for(var/obj/Chakra_Barrier/M in view(4))
				M.density=0
				M.dir=dir
				step(M,dir)
				M.density=1
				M.owner=usr
				if(M.dir==NORTH||M.dir==SOUTH)M.charod(1)
				else M.charod(2)
			barrierhold=1
			spawn(42)
				freeze=0
				if(!barrierhold)icon_state=""
		superzankuuha()
			prejutsu()
			if(cdelay6||swim||dead||resting||stun||busy||moving||imitated)return
			handseals(80,65,1)
			if(!sealpass)return
			cdelay6=1
			for(var/obj/jutsu/soundc/Super_Sonic_Splicing_Wave/M in src)M.overlays+='timer.dmi'
			var/sdelay=200
			if(curseseal==2)sdelay=sdelay/1.5
			if(curseseal==3)sdelay=sdelay/2
			spawn(sdelay*(cdpow/100))
				for(var/obj/jutsu/soundc/Super_Sonic_Splicing_Wave/M in src)M.overlays-='timer.dmi'
				cdelay6=0
			icon_state="jutsu"
			range(12)<<"<b><font color=silver>[src]: Sound Technique!"
			sleep(34)
			range(12)<<"<b><font color=silver>[src]: Super Sonic Splicing Wave!"
			var/time=80
			var/obj/L=new/obj/zwave/superzleft(loc)
			L.owner=usr
			L.icon_state="1"
			var/obj/L2=new/obj/zwave/superzright(loc)
			L2.owner=usr
			L2.icon_state="2"
			L.dir=dir
			L2.dir=dir
			var/T=0
			freeze=1
			if(dir==NORTH)
				skip
					if(T<12)
						T++
						L.y++
						L.x--
						L2.y++
						L2.x++
						L.ztrail()
						L.ztrail2(T)
						L2.ztrail()
						goto skip
			if(dir==SOUTH)
				skip
					if(T<12)
						T++
						L.y--
						L.x--
						L2.y--
						L2.x++
						L.ztrail()
						L.ztrail2(T)
						L2.ztrail()
						goto skip
			if(dir==EAST)
				skip
					if(T<12)
						T++
						L.y++
						L.x++
						L2.y--
						L2.x++
						L.ztrail()
						L.ztrail2(T)
						L2.ztrail()
						goto skip
			if(dir==WEST)
				skip
					if(T<12)
						T++
						L.y++
						L.x--
						L2.y--
						L2.x--
						L.ztrail()
						L.ztrail2(T)
						L2.ztrail()
						goto skip
			var/e=0
			for(var/obj/zwave/A in loc)
				if(!e)
					A.icon_state="begin"
					e=1
				else del A
			for(var/obj/zwave/M2 in oview(8))if(M2.owner==src)
				for(var/mob/M in M2.loc)
					if(M.illusion)
						M.illusionhit(src)
						continue
					if(aff==M.aff)continue
					var/damage=round(pow*1.6+rand(13,30))
					M.dmgch(src)
					damage=(damage*M.variable)+M.variable2

					if(damage<5)damage=5
					M.hp-=damage
					new/obj/hit(M.loc)
					M.death(usr)
					if(M)M.szankuuhaed(time)
			spawn(35)
				freeze=0
				icon_state=""
obj/proc/ztrail()
	var/obj/T=new/obj/zwave(loc)
	T.icon_state=icon_state
	T.dir=dir
	T.owner=owner
obj/proc/ztrail2(var/X)
	var/E=X*2-1
	var/c=0
	loop
		if(E>0)
			E--
			c++
			if(dir==NORTH)
				var/obj/T=new/obj/zwave(locate(x+c,y,z))
				T.owner=owner
			if(dir==SOUTH)
				var/obj/T=new/obj/zwave(locate(x+c,y,z))
				T.owner=owner
			if(dir==EAST)
				var/obj/T=new/obj/zwave(locate(x,y-c,z))
				T.owner=owner
			if(dir==WEST)
				var/obj/T=new/obj/zwave(locate(x,y-c,z))
				T.owner=owner
			goto loop
obj/zwave
	icon='supersplicingwave.dmi'

	density=0
	layer=50
	New()
		..()
		spawn(35)del src
	superzleft/icon_state="1"
	superzright/icon_state="2"
mob/proc/zankuuhaed()
	if(client)
		client.lazy_eye++
		spawn(70)if(client)client.lazy_eye--
mob/proc/szankuuhaed(var/T)
	if(client)
		client.lazy_eye+=3
		spawn(T)client.lazy_eye-=3
obj/Chakra_Barrier
	icon='chakrabarrier.dmi'
	layer=65
	density=1
	proc/charod(var/G)
		if(G==1)
			new/obj/chaov(loc)
			new/obj/chaov(loc)
			new/obj/chaov(loc)
			for(var/obj/chaov/M in loc)M.pixel_x=rand(-16,16)
		else
			new/obj/chaov(loc)
			new/obj/chaov(loc)
			for(var/obj/chaov/M in loc)
				M.pixel_y=rand(9,-10)
				M.pixel_x=rand(-2,2)
	New()
		overlays+=/obj/barriermid
		overlays+=/obj/barriertop
		..()
		spawn(1)
			var/G=80
			if(!owner)del src
			spawn(G-1)
				loop
					if(!owner||!owner.barrierhold)del src
					else spawn(2)goto loop
	Del()
		for(var/obj/chaov/M in loc)del M
		..()
obj/chaov
	layer=64
	icon='chakrabarrier.dmi'
	New()
		overlays+=/obj/barriermid
		overlays+=/obj/barriertop
obj/barriermid
	icon='chakrabarrier.dmi'
	layer=65
	icon_state="mid"
	pixel_y=32
obj/barriertop
	icon='chakrabarrier.dmi'
	layer=65
	pixel_y=64
	icon_state="top"