world/fps=14
mob/var/tmp
	backdash=0
	assassinate=0
obj
	assassinate
		New()spawn(10)del src
mob/proc
	backdash()
		prejutsu()
		if(backdash||freeze||dead||caught||seals||stun||imitated||imitation||busy)return
		handseals(10,0,20,1)
		if(!sealpass)return
		backdash=1
		stepback(5,3)
		spawn(1)pixel_y=6
		spawn(2)pixel_y=9
		spawn(3)
			if(clan=="Yuki"&&tier52)if(prob(1+tier52*33))quickwave()
			pixel_y=11
		spawn(4)pixel_y=8
		spawn(6)pixel_y=4
		spawn(7)pixel_y=0
		var/sdelay=200*cdpow/100
		for(var/obj/jutsu/Backdash/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)backdash=0
	assassinate()
		prejutsu()
		if(assassinate||snared||freeze||dead||caught||seals||stun||imitated||imitation||busy)return
		var/obj/assassinate/F=new(loc)
		step(F,dir)
		step(F,dir)
		step(F,dir)
		spawn()
			for(var/mob/player/M in range(3,F))
				if(aff==M.aff)continue
				new/obj/tele(loc)
				loc=M.loc
				moving=0
				if(M.dir==NORTH)step(src,SOUTH)
				if(M.dir==SOUTH)step(src,NORTH)
				if(M.dir==EAST)step(src,WEST)
				if(M.dir==WEST)step(src,EAST)
				dir=M.dir
				M.stun(5)
				assassinate++
				var/sdelay=350
				for(var/obj/jutsu/Assassinate/T in src)timerjutsu(sdelay,T)
				spawn(sdelay)assassinate--
				return
		assassinate++
		spawn(14)assassinate--