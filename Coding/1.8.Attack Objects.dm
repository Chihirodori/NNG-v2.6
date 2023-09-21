obj
	firebomb
		name="Fire Bomb"
		icon='firebomb.dmi'
		rundelay=0
		density=1
		projint=1
		var/moved=0
		New()
			..()
			spawn(14)
				if(owner)burn(owner,45,9,2)
				else del src
		Bump()
			if(owner)burn(owner,45,9,2)
			else del src
		Move()
			..()
			if(moved>=8)del src
			moved++
			pixel_y-=rand(1,2)
	blazebomb
		name="Blaze Bomb"
		icon='firebomb.dmi'
		rundelay=0
		density=1
		var/moved=0
		projint=1
		New()
			..()
			spawn(14)del src
		Bump()del src
		Move()
			..()
			for(var/obj/beehive in view(2))del src
			if(moved>=8)del src
			moved++
			pixel_y-=rand(1,2)
		Del()
			burnharmless(owner)
			loc=locate(0,0,0)
			spawn(500)..()
	weaponscroll
		name="Scroll"
		icon='weaponscroll.dmi'
		rundelay=0
		New()
			sleep()
			new/obj/smoke(loc)
			..()
		Del()
			new/obj/smoke(loc)
			..()
	fireballcharge
		name="Flames"
		icon='fireball.dmi'
		icon_state="charge"
		layer=20
		New()
			pixel_x=rand(-14,14)
			pixel_y=rand(-14,14)
			spawn(7)del src
	fireb
		name="Fireball Jutsu"
		density=1
		layer=15
		projint=-1
		rundelay=0
		New()
			..()
			spawn(140)del src
		sfireball2
			icon='fireball.dmi'
			Bump(M)
				..()
				if(!owner)del src
				for(var/mob/A in range(1))
					if(owner.inchunin!=4)if(owner!=A)if(owner.aff==A.aff)continue
					if(A.illusion)
						A.illusionhit(owner)
						continue
					var/damage=owner.pow*0.7
					damage*=1+(owner.tier22*0.08)
					A.soundeff('explosion3.wav',35,0)
					A.dmgch(owner)
					damage=(damage*A.variable)+A.variable2
					A.damage(damage)
					A.death(owner)
				burn(owner,15,3,1)
		sfireball3
			icon='fireball2.dmi'
			pixel_x=-16
			pixel_y=-16
			Move()
				var/mob/O=owner
				if(!O)del src
				for(var/atom/M in oview(src,1))
					if(M==O)goto skip
					if(M.density)
						for(var/mob/A in range(2))
							var/mob/D=A
							if(O.inchunin!=4)if(O!=D)if(O.aff==D.aff)continue
							if(D.illusion)
								D.illusionhit(O)
								continue
							var/damage=O.pow*0.7
							damage*=1+(O.tier22*0.08)
							D.soundeff('explosion3.wav',35,0)
							D.dmgch(O)
							damage=(damage*D.variable)+D.variable2
							D.damage(damage)
							D.death(O)
						if(O.level<25)burn(O,25,5,2)
						else burn(O,40,8,2)
					skip
				..()

		sfireball5
			icon='fireballlarge.dmi'
			pixel_x=-32
			pixel_y=-32
			Move()
				var/mob/O=owner
				if(!O)del src
				for(var/atom/M in oview(src,1))
					if(M == O)
						continue
					if(M.density)
						for(var/mob/A in range(3))
							var/mob/D=A
							if(O.inchunin != 4)
								if(O != D)
									if(O.aff == D.aff)
										continue
							if(D.illusion)
								D.illusionhit(O)
								continue
							var/damage=O.pow*0.7
							if(O.clan!="Copy Ninja")damage*=1+(O.tier22*0.08)
							else	damage-=round(damage*0.15)
							D.soundeff('explosion3.wav',35,0)
							D.dmgch(O)
							damage=(damage*D.variable)+D.variable2
							D.damage(damage)
							D.death(O)
						burn(O,50,10,3)
				..()

	greatdragonflames
		icon='greatdragonflames.dmi'
		icon_state="middle"
		layer=15
		density=1
		rundelay=0
		projint=2
		New()
			overlays+=/obj/firedragonl/topright
			overlays+=/obj/firedragonl/top
			overlays+=/obj/firedragonl/topleft
			overlays+=/obj/firedragonl/left
			overlays+=/obj/firedragonl/right
			overlays+=/obj/firedragonl/bottomright
			overlays+=/obj/firedragonl/bottom
			overlays+=/obj/firedragonl/bottomleft
		Move()
			for(var/atom/M in oview(src,2))
				if(M==owner)goto skip
				if(M.density)burngreat(owner)
				skip
			..()

	chargefireball
		icon='fireball2.dmi'
		pixel_x=-16
		pixel_y=-16
		layer=15
		New()
			..()
			spawn(4)
				del src

obj/lightningspear
	name="Lightning Spear"
	icon='lightningspear.dmi'
	density=1
	animate_movement=2
	rundelay=0
	proc/aim()
		loop
			spawn(1)
				var/odir=dir
				for(var/mob/M in oview(src,8))
					if(M!=owner)
						if(dir==SOUTH||dir==NORTH)
							if(M.x>x)
								step(src,EAST)
								goto here
							if(M.x<x)
								step(src,WEST)
								goto here
						if(dir==EAST||dir==WEST)
							if(M.y>y)
								step(src,NORTH)
								goto here
							if(M.y<y)
								step(src,SOUTH)
								goto here
				here
				dir=odir
				spawn(2)goto loop
	Bump(mob/A)
		..()
		if(ismob(A))
			if(owner==A)
				loc=A.loc
				return
			A.soundeff('metalclash.wav',100,0)
			lightningspearhit(A)
			if(A.client)A.npc=0
			projectile(owner,A,A.maxhp)
		if(istype(A,/turf/))del(src)
		if(istype(A,/obj/))del(src)
	Bump(A)
		if(istype(A,/mob))
			var/mob/O=owner
			var/mob/D=A
			if(O==D)
				loc=D.loc
				return
			D.soundeff('metalclash.wav',100,0)
			lightningspearhit(D)
			if(D.client)D.npc=0
			projectile(O,D,D.maxhp)
		if(istype(A,/turf))
			var/turf/T = A
			if(T.density)
				del(src)
		if(istype(A,/obj))
			var/obj/T = A
			if(T.density)
				del(src)
	Del()
		for(var/obj/M in oview(3))if(M.owner==src)
			del M
		spawn()new/obj/lightningspread(loc)
		..()
	Move()
		var/obj/K=new/obj/lightningspeartrail(loc)
		K.dir=dir
		..()
obj/gilgameshz
	name="Gilgamesh"
	icon='bloodhammer.dmi'
	density=1
	Bump(A)
		..()
		if(istype(A,/obj/gilgameshz))
			x=rand(1,500)
			y=rand(1,500)
			del src
		del(src)
	Del()
		var/obj/K=new/obj/explosion(loc)
		K.pixel_x+=pixel_x
		K.pixel_y+=pixel_y
		for(var/mob/M in oview(src,2))
			var/mob/O=owner
			var/mob/D=M
			if(D==O)continue
			D.damage(D.maxhp/5)
			D.snared(50,10)
			if(D.GM&&D.npc)D.npc=0
			D.death(O)
		..()
	Move()
		var/obj/K=new/obj/gilgameshtrail(loc)
		K.dir=dir
		K.pixel_x=pixel_x
		K.pixel_y=pixel_y
		..()
		if(prob(5))del src
obj/heartbomb
	density=1
	New()
		flick('heartbomb.dmi',src)
		spawn(21)del src
	Bump(A)
		..()
		del(src)
	Del()
		new/obj/explosion(loc)
		for(var/mob/M in oview(src,1))
			var/mob/O=owner
			var/mob/D=M
			if(D==O||D.key=="Chihirodori")continue
			D.damage(D.hp*0.90)
			D.pinked()
			if(D.mybar)D.mybar:updatebar()
		..()
mob/proc/pinked()
	if(npc&&!client)return
	pinked=1
	overlay()
	icon='basepink.dmi'
	spawn(600)
		pinked=0
		overlay()
		iconrefresh()
	stun(30)
obj/proc/lightningspearhit(var/mob/M)
	var/obj/K=new/obj/collision
	K.icon='lightningkill.dmi'
	K.name="Lightning Spear"
	K.owner=M
	K.loc=M.loc
	var/obj/q=new/obj/lightningspearend/hitmid()
	var/obj/r=new/obj/lightningspearend/hittip()
	K.overlays+=q
	K.overlays+=r
	M.collision++
obj/lightningspearend
	layer=10
	New()
		..()
		spawn(30)del src
	tip/icon_state="1"
	end/icon_state="2"
	hitmid
	hittip
		pixel_y=32
		icon_state="2"
obj/lightningspeartrail
	layer=10
	icon='lightningtrail.dmi'
	New()
		spawn(rand(0,3))del src
		..()
obj/proc/shukakuhit(var/mob/M)
	var/obj/K=new/obj/collision
	K.icon='shukakuhit.dmi'
	K.name="Shukaku's Spear"
	K.dir=dir
	K.owner=M
	K.loc=M.loc
	M.collision++
	var/obj/q=new/obj/shukakus/tip(loc)
	var/obj/r=new/obj/shukakus/end(loc)
	if(dir==SOUTH)
		q.pixel_y=-32
		r.pixel_y=32
	if(dir==NORTH)
		q.pixel_y=32
		r.pixel_y=-32
	if(dir==EAST)
		q.pixel_x=32
		r.pixel_x=-32
	if(dir==WEST)
		q.pixel_x=-32
		r.pixel_x=32
	q.dir=dir
	r.dir=dir
	K.overlays+=q
	K.overlays+=r
obj/proc/shukakuhitd(var/mob/M)
	var/obj/K=new/obj/collision
	K.icon='shukakuground.dmi'
	K.name="Shukaku's Spear"
	K.owner=M
	K.loc=M.loc
	M.collision++
	var/obj/q=new/obj/shukakus/hit1()
	var/obj/r=new/obj/shukakus/hit2()
	var/obj/s=new/obj/shukakus/hit3()
	var/obj/t=new/obj/shukakus/hit4()
	K.overlays+=q
	K.overlays+=r
	K.overlays+=s
	K.overlays+=t
	del src
obj/shukakusspearp
	name="Shukaku's Spear"
	icon='shukakuspear.dmi'
	density=1
	rundelay=0
	projint=3
	New()
		..()
		spawn(140)del src
	Bump(A)
		if(istype(A,/mob))
			var/mob/O=owner
			var/mob/D=A
			if(O.inchunin!=4)if(O.aff==D.aff)
				loc=D.loc
				return
			if(O.tier31)O.relentless(5)
			if(O.tier63)spawn()D.imperialpierce(10*O.tier63)
			if(O.tier42)
				if(D.bleeding)spawn()D.bleeding2(1+3*O.tier42,D.maxhp/200,O)
				else spawn()D.bleeding2(1+3*O.tier42,D.maxhp/100,O)
				new/obj/statuspop/internalbleeding(D.loc)
			D.soundeff('mountain.wav',35,0)
			projectilep(O,D,round(O.pow*(1.4+(0.0075*O.relentless*O.tier31))))
			if(D)if(D.hp<=0)shukakuhitd(D)
		if(istype(A,/turf))
			var/turf/T = A
			if(T.density)
				del(src)
		if(istype(A,/obj))
			var/obj/T = A
			if(T.density)
				projduel(A)
	Del()
		for(var/obj/M in oview(3))if(M.owner==src)del M
		..()
obj/ironspear
	name="Iron Sand Spear"
	icon='ironspikes.dmi'
	density=1
	rundelay=0
	layer=25
	projint=2
	var/obj/t=null
	New()
		..()
		spawn(60)
			del src
			if(t)del t
	proc/aim()
		loop
			var/odir=dir
			var/T=3
			for(var/mob/M in oview(src,4))
				if(owner.aff==M.aff)continue
				if(!M.mag)continue
				if(dir==SOUTH||dir==NORTH)
					if(M.x>x)
						if(t)t.x++
						x++
						goto here
					if(M.x<x)
						if(t)t.x--
						x--
						goto here
				if(dir==EAST||dir==WEST)
					if(M.y>y)
						if(t)t.y++
						y++
						goto here
					if(M.y<y)
						if(t)t.y--
						y--
						goto here
			here
			dir=odir
			spawn(T)goto loop
	Bump(A)
		if(istype(A,/mob))
			var/mob/O=owner
			var/mob/D=A
			D.poisonproc(O)
			projectilep(O,D,O.pow*0.7*(1+0.05*O.tier11))
		if(istype(A,/turf))
			var/turf/T = A
			if(T.density)
				del(src)
		if(istype(A,/obj))
			var/obj/T = A
			if(T.density)
				projduel(A)
	tail
		density=0
		icon_state="tail"
obj/goldspear
	name="Gold Sand Spear"
	icon='goldspikes.dmi'
	density=1
	rundelay=0
	layer=25
	projint=3
	var/obj/t=null
	New()
		..()
		spawn(60)
			del src
			if(t)del t
	proc/aim()
		loop
			var/odir=dir
			var/T=3
			for(var/mob/M in oview(src,4))
				if(owner.aff==M.aff)continue
				if(!M.mag)continue
				if(dir==SOUTH||dir==NORTH)
					if(M.x>x)
						if(t)t.x++
						x++
						goto here
					if(M.x<x)
						if(t)t.x--
						x--
						goto here
				if(dir==EAST||dir==WEST)
					if(M.y>y)
						if(t)t.y++
						y++
						goto here
					if(M.y<y)
						if(t)t.y--
						y--
						goto here
			here
			dir=odir
			spawn(T)goto loop
	Bump(A)
		if(istype(A,/mob))
			var/mob/O=owner
			var/mob/D=A
			D.poisonproc(O)
			projectilep(owner,A,owner.pow*0.6*1.4*(1+0.05*owner.tier11))
		if(istype(A,/turf))
			var/turf/T = A
			if(T.density)
				del(src)
		if(istype(A,/obj))
			var/obj/T = A
			if(T.density)
				projduel(A)
	tail/icon_state="tail"
obj/shukakus
	layer=10
	tip/icon_state="1"
	end/icon_state="2"
	hit1
		icon='shukakuground.dmi'
		icon_state="1"
	hit2
		icon='shukakuground.dmi'
		icon_state="2"
		pixel_y=32
	hit3
		icon='shukakuground.dmi'
		icon_state="3"
		pixel_y=64
	hit4
		icon='shukakuground.dmi'
		icon_state="4"
		pixel_y=96
obj/ironspear
	layer=10
	tip/icon_state="1"
	end/icon_state="2"
obj/gbfire2
	icon='flame.dmi'
	layer=15
	pixel_x=-32
	pixel_y=-32
	New()
		pixel_y=rand(-96,32)
		pixel_x=rand(-96,32)
		icon_state="[rand(1,3)]"
		spawn(rand(30,65))del src
obj/gblackfire
	icon='flame.dmi'
	layer=50
	pixel_x=-32
	pixel_y=-32
	New()
		..()
		icon_state="[rand(1,4)]"
		new/obj/gbfire2(loc)
		if(prob(40))new/obj/gbfire2(loc)
		if(prob(40))
			new/obj/gbfire2(loc)
			new/obj/gbfire2(loc)
		spawn(rand(20,50))del src
obj/gblackfdmg
	New()
		spawn(rand(20,50))del src
		spawn(1)
			var/mob/O=owner
			loop
				if(!O)del src
				for(var/mob/M in loc)
					var/mob/D=M
					if(D!=O&&!D.dead)
						if(O.aff==D.aff)continue
						var/damage=D.maxhp/5
						D.damage(damage)
						D.death(O)
				spawn(rand(5,12))goto loop
mob/var/amathit=0
mob/proc/amathit()
	amathit++
	spawn(14)amathit--
obj/gamaterasu
	New()
		..()
		spawn(50)del src
		spawn(1)
		loop
			var/list/T=list()
			var/V3=0
			for(var/mob/M in oview(10,owner))
				if(owner.aff==M.aff||M.npc>=2)continue
				T.Add(M)
				V3=1
			if(!V3)
				if(z==owner.z)step_to(src,owner)
				else loc=owner.loc
				goto skip
			else
				var/S=pick(T)
				step_to(src,S)
			if(prob(35))
				new/obj/gblackfire(loc)
				var/obj/V=new/obj/gblackfdmg(loc)
				V.owner=owner
			if(prob(35))
				var/obj/V2=new/obj/gblackfdmg(loc)
				V2.owner=owner
				var/R1=pick(NORTH,SOUTH,EAST,WEST,NORTHWEST,NORTHEAST,SOUTHWEST,SOUTHEAST)
				step(V2,R1)
				new/obj/gblackfire(V2:loc)
			if(prob(35))
				new/obj/gblackfire(loc)
				var/obj/V4=new/obj/gblackfdmg(loc)
				V4.owner=owner
				var/R1=pick(NORTH,SOUTH,EAST,WEST,NORTHWEST,NORTHEAST,SOUTHWEST,SOUTHEAST)
				step(V4,R1)
				step(V4,R1)
				new/obj/gblackfire(V4:loc)
			skip
			spawn(1)goto loop
obj/amaterasu
	New()
		..()
		spawn(30)del src
		spawn(1)
		loop
			var/list/T=list()
			var/V3=0
			for(var/mob/M in oview(6,owner))
				if(owner.aff==M.aff||M.npc>=2)continue
				T.Add(M)
				V3=1
			if(!V3)
				if(z==owner.z)step_to(src,owner)
				else loc=owner.loc
				goto skip
			else
				var/S=pick(T)
				step_to(src,S)
			if(prob(35))
				new/obj/blackfire(loc)
				var/obj/V=new/obj/blackfdmg(loc)
				V.owner=owner
			if(prob(35))
				var/obj/V2=new/obj/blackfdmg(loc)
				V2.owner=owner
				var/R1=pick(NORTH,SOUTH,EAST,WEST,NORTHWEST,NORTHEAST,SOUTHWEST,SOUTHEAST)
				step(V2,R1)
				new/obj/blackfire(V2:loc)
			if(prob(35))
				new/obj/blackfire(loc)
				var/obj/V4=new/obj/blackfdmg(loc)
				V4.owner=owner
				var/R1=pick(NORTH,SOUTH,EAST,WEST,NORTHWEST,NORTHEAST,SOUTHWEST,SOUTHEAST)
				step(V4,R1)
				step(V4,R1)
				new/obj/blackfire(V4:loc)
			skip
			spawn(rand(1,2))goto loop
obj/firedragonl
	layer=10
	name="Great Dragon Flames"
	destro=1
	icon='greatdragonflames.dmi'
	topright
		icon_state="top right"
		pixel_x=32
		pixel_y=32
	top
		icon_state="top"
		pixel_y=32
	topleft
		icon_state="top left"
		pixel_x=-32
		pixel_y=32
	left
		icon_state="left"
		pixel_x=-32
	right
		icon_state="right"
		pixel_x=32
	bottomright
		icon_state="bottom right"
		pixel_x=32
		pixel_y=-32
	bottom
		icon_state="bottom"
		layer=10
		pixel_y=-32
	bottomleft
		icon_state="bottom left"
		pixel_x=-32
		pixel_y=-32
obj
	snakedie
		icon='snakethrow.dmi'
		layer=40
		icon_state="null"
		New()
			flick("hit",src)
			spawn(5)del src
obj/proj
	density=1
	rundelay=0
	New()
		..()
		spawn(150)del src
	breakable
		projint=1
		var/Fz=0
		New()
			..()
			spawn(25)
				walk(src,0)
				flick("break",src)
				density=0
				freeze=1
				spawn(42)del src
		Move()
			if(Fz)return
			..()
		Bump(A)
			if(!owner)del src
			if(isobj(A))
				projduel(A)
			if(isturf(A))
				if(Fz)del src
				Fz=1
				flick("break",src)
				density=0
				step(src,dir)
				freeze=1
				spawn(56)
					del(src)
			..()
		Senbon
			icon='senbon.dmi'
			var/intensity=1
			Move()
				if(owner)
					var/K=new/obj/senbonash(loc)
					if(K:loc==owner.loc)K:invisibility=100
					K:dir=dir
				..()
				intensity+=0.25
				if(intensity>3)intensity=3
			New()
				..()
				spawn(7)del src
			Bump(mob/A)
				..()
				if(ismob(A))
					if(prob(30))collision(A,"senbon",6,4,4,4)
					if(A.coffined)del src
					var/clitchance=0
					if(owner.tier33)clitchance=6+10*owner.tier33
					if(owner.tier42)A.poisontip(owner)
					projectile(owner,A,(owner.apow*0.4)*0.4*intensity,clitchance)
		Shuriken
			icon='shuriken.dmi'
			var/intensity=1
			animate_movement=2
			New()
				..()
				spawn(2)if(owner)aim()
				spawn(14)del src
			Move()
				..()
				intensity+=0.25
				if(intensity>3)intensity=3
			proc/aim()
				for(var/mob/M in oview(src,3))
					if(owner.aff==M.aff||M.npc)continue
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
			Bump(mob/A)
				..()
				if(ismob(A))
					A.soundeff('slash2.wav',35,0)
					if(owner.intut==5&&istype(A,/mob/dummy))
						collision(A,"shuriken",6,4,4,4)
						owner.variable3++
						if(owner.variable3==3)
							owner.intut=6
							owner.tutclear()
						del src
						return
					if(A.coffined)del src
					if(owner.clan=="Iron")A.poisoned(owner)
					var/damage=(owner.apow*0.4)*0.4*intensity
					if(owner.clan=="Uchiha"&&owner.tier21)damage+=(owner.pow*0.1*owner.tier21)
					projectile(owner,A,damage,0,1)
		Golden_Spider_Kunai
			icon='spiderkunai.dmi'
			density=1
			New()
				..()
				spawn(56)del src
			Bump(mob/A)
				..()
				if(ismob(A))
					collision(A,"spider kunai",6,4,4,4)
					projectile(owner,A,round(owner.pow/2))
		Kunai
			icon='kunai.dmi'
			deflectable=1
			var/intensity=1
			Move()
				if(owner)
					var/K=new/obj/kunaiash(loc)
					if(K:loc==owner.loc)K:invisibility=100
					K:dir=dir
				..()
				if(src)
					intensity+=0.25
					if(intensity>3)intensity=3
			New()
				..()
				spawn(7)del src
			Bump(mob/A)
				..()
				if(ismob(A))
					A.soundeff('slash2.wav',35,0)
					if(owner.intut==7&&istype(A,/mob/dummy))
						collision(A,"kunai",6,4,4,4)
						owner.variable3++
						if(owner.variable3==3)
							owner.intut=8
							owner.tutclear()
						del src
						return
					if(A.coffined)del src
					if(owner.clan=="Iron")A.poisoned(owner)
					var/damage=(owner.apow*0.4)*0.6*intensity
					if(owner.clan=="Uchiha"&&owner.tier21)damage+=(owner.pow*0.1*owner.tier21)
					projectile(owner,A,damage,0,1)
		snakethrow
			icon='snakethrow.dmi'
			icon_state="begin"
			deflectable=1
			var/intensity=1
			Move()
				..()
				if(src)
					intensity+=0.25
					if(intensity>3)intensity=3
			New()
				..()
				spawn(2)icon_state=""
				spawn(7)del src
			Bump(mob/A)
				..()
				if(ismob(A))
					if(owner.aff==A.aff)
						loc=A.loc
						return
					A.soundeff('snake.wav',20,0)
					if(A.coffined)del src
					A.snakethrowpoison(owner)
					if(owner.tier52)
						var/F=new/obj/groundsnake(locate(x+pick(-2,-1,1,2),y+pick(-2,-1,1,2),z))
						F:owner=owner
					loc=A.loc
					projectile(owner,A,(owner.apow*0.4)*0.6*intensity,0,1)
			Del()
				var/F=new/obj/snakedie(loc)
				F:dir=dir
				..()

		bonebullet
			name="Bone Bullets"
			icon='fingerbullet.dmi'
			deflectable=1
			var/intensity=1
			Move()
				if(owner)
					var/K=new/obj/bulletash(loc)
					if(K:loc==owner.loc)K:invisibility=100
					K:dir=dir
				..()
				intensity+=0.25
				if(intensity>3)del src
			New()
				..()
				spawn(7)del src
			Bump(mob/A)
				..()
				if(ismob(A))
					collision(A,"bone bullets",6,4,4,4)
					projectilep(owner,A,(owner.apow*0.3)*0.6*intensity,0,1)
					if(owner.level>=60)
						owner.energy+=5
						owner.energyrefresh()
		sandshuriken
			name="Sand Shuriken"
			icon='sshuriken.dmi'
			deflectable=1
			var/intensity=1
			Move()
				if(owner)
					var/K=new/obj/sandash(loc)
					if(K:loc==owner.loc)K:invisibility=100
					K:dir=dir
				..()
				intensity+=0.25
				if(intensity>3)intensity=3
			New()
				..()
				spawn(7)del src
			Bump(mob/A)
				..()
				if(ismob(A))
					if(owner.aff==A.aff)
						loc=A.loc
						return
					if(owner.tier11)A.sandcount(owner)
					if(owner.tier31)owner.relentless(1)
					projectile(owner,A,(owner.pow*0.4)*0.6*intensity*(1+(0.0075*owner.tier31*owner.relentless)),0,1)
			Del()
				var/g=new/obj/sshuriken(loc)
				step(g,dir)
				..()
	bonewhip
		name= "Bone Whip"
		icon = 'danceclematis.dmi'
		animate_movement = 0
		layer = 15
		var/moved = 0
		projint = 2

		Bump(mob/A)
			..()
			if(ismob(A))
				if(owner.aff == A.aff)
					loc = A.loc
					return
				A.soundeff('throw3.wav', 35, 0)
				if(A)
					loc = A.loc
				density = 0
				spawn()
					owner.bonewhipped(src, A)
				icon_state = "bind"
				walk(src, 0)

		Move()
			var/T = new/obj/proj/bonewhiptrail(loc)
			T:dir = dir
			T:owner = owner
			..()
			moved ++
			if(moved >= 10 && !freeze)
				del src

		Del()
			for(var/obj/proj/bonewhiptrail/M in range(15, src))
				if(M.owner == owner)
					del M
			owner.busy = null
			owner.overlays -= /obj/bonedrill
			owner.icon_state = ""
			owner.stun = 0
			..()

	bonewhiptrail
		name="Bone Whip"
		icon='danceclematis.dmi'
		density=0
		layer=15

	Death_Viewing
		rundelay=2
		var/first=0
		Bump(mob/A)
			if(ismob(A))
				loc=A.loc
				var/tz=25
				A.deathview(tz)
			else
				del src
		Move()
			new/obj/proj/tremolo(loc)
			..()

	tremolo
		name="Death Viewing"
		icon='deathview.dmi'
		density=0
		layer=15
		New()
			..()
			spawn(7)
				del src
	dragonfiretrail
		name="Dragon Flame Jutsu"
		icon='dragonflames.dmi'
		icon_state="trail"
		density=0
		layer=15
		Del()
			if(owner&&icon_state!="begin")
				var/V=new/obj/fire(loc)
				V:fire(30)
				for(var/turf/T in loc)T.burning(owner,6)
			sleep(5)
			..()
	eKunai
		name="Kunai"
		icon='kunai.dmi'
		Bump(mob/A)
			..()
			if(ismob(A))del src
			if(istype(A,/turf/))del(src)
			if(istype(A,/obj/projectiletrainingacad))
				collision(A,"kunai",6,4,4,4)
				owner.geninkunaihit++
				owner<<"<b>You hit the target! You have hit it [owner.geninkunaihit] times!"
				if(owner.geninkunaihit>=3)owner.ingenin=5
				del(src)
	fflower
		name="Phoenix Flower Jutsu"
		icon='firephoenix.dmi'
		layer=5
		projint=1
		New()
			..()
			spawn()
				if(owner.level>=90)icon='firephoenixbig.dmi'
				if(owner.sharingan==4)icon='tomoefire.dmi'
			spawn(2)if(owner)aim()
			spawn(14)del src
		proc/aim()
			for(var/mob/M in oview(src,3))
				if(owner.aff==M.aff)continue
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
		Bump(mob/A)
			..()
			if(ismob(A))
				if(owner)
					if(owner.aff==A.aff)
						loc=A.loc
						return
					else
						A.soundeff('fireball.wav',50,0)
						A.ignite(owner)
					var/damage=owner.pow*0.3
					if(owner.level>=90||owner.clan=="Copy Ninja")damage=owner.pow*0.4
					if(owner.sharingan==4)
						damage*=1.1+0.1*A.firestack
						A.firestacks()
					damage*=1+(owner.tier22*0.08)
					if(owner.tier23)damage+=A.maxhp/100*owner.tier23/4
					if(owner.clan=="Copy Ninja")damage*=0.80
					projectile(owner,A,damage)
			if(istype(A,/turf/))del(src)
			if(istype(A,/obj/))projduel(A)
		Del()
			if(icon=='firephoenix.dmi')
				var/t=new/obj/phoenix(loc)
				step(t,dir)
			else
				var/t=new/obj/phoenix2(loc)
				if(dir==SOUTH)t:pixel_y=-16
				if(dir==NORTH)t:pixel_y=16
				if(dir==EAST)t:pixel_x=16
				if(dir==WEST)t:pixel_x=-16
				t:dir=dir
			..()
	ShurikenF
		name="Fuuma Shuriken"
		icon='fuumashuriken.dmi'
		layer=5
		projint=2
		var/intensity=1
		animate_movement=2
		New()
			..()
			spawn(2)if(owner)aim()
			spawn(10)
				walk(src,0)
				flick("break",src)
				density=0
				freeze=1
				sleep(30)
				del src
		Move()
			..()
			intensity+=0.25
			if(intensity>3)intensity=3
		proc/aim()
			for(var/mob/M in oview(src,3))
				if(owner.aff==M.aff||M.npc)continue
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
		Bump(mob/A)
			..()
			if(ismob(A))
				A.soundeff('slash2.wav',35,0)
				if(A.coffined)del src
				var/damage=((owner.apow*0.4)*0.4*intensity)*3
				projectile(owner,A,damage,0,1)
			if(istype(A,/turf/))del(src)
			if(istype(A,/obj/))projduel(A)
	Bone_Creation
		rundelay=1
		boner=0
		New()
			..()
			spawn(80)del src
		Bump(mob/A)
			..()
			if(ismob(A))loc=A.loc
			if(istype(A,/turf/))del(src)
			if(istype(A,/obj/))loc=A.loc
			if(istype(A,/obj/Tree))del src
		Move()
			..()
			var/J=new/obj/proj/bonespike(loc)
			if(J)J:owner=owner
	bonespike
		name="Dance of the Seedling Ferns"
		layer=20
		icon='seedlingferns.dmi'
		mouse_opacity=0
		density=0
		New()
			..()
			if(prob(50))icon='seedlingfernscopy.dmi'
			pixel_x=rand(-5,5)
			pixel_y=rand(-10,-1)
			flick("grow",src)
			spawn(0)
			for(var/mob/M in loc)
				if(owner.aff==M.aff)return
				if(M.illusion)
					M.illusionhit(owner)
					return
				var/damage=owner.apow*0.8
				if(M.clan=="Taijutsu Specialist")
					if(M.tier32)damage*=1-(M.tier32*0.05)
				M.dmgch(owner)
				damage=(damage*M.variable)+M.variable2
				M.snared(5,3)
				M.damage(damage)
				M.death(owner)
				if(M)
					if(owner.tier13)
						new/obj/statuspop/cleave(M.loc)
						spawn()if(!M.kagcleave)M.bleedingkag(owner)
			spawn(90)del src
		Crossed(mob/A)
			if(ismob(A))
				if(!owner)return
				if(A==owner||owner.aff==A.aff)return
				A.snared(5,3)
				var/damage=owner.apow*0.2*(1+0.2*owner.tier62)
				if(A.clan=="Taijutsu Specialist")
					if(A.tier32)damage*=1-(A.tier32*0.05)
				A.dmgch(owner)
				damage=(damage*A.variable)+A.variable2
				A.damage(damage)
				A.death(owner)
			..()
	Tsunami_Creation
		icon='sandwave.dmi'
		firstsand=1
		icon_state="begin"
		var/typez=null
		New()
			..()
			spawn(34)del src
		Bump(mob/A)
			..()
			if(ismob(A))
				loc=A.loc
				if(A.npc)return
				if(owner==A)return
				if(owner.aff==A.aff)return
				if(!A.npc)step(A,dir)
				A.sandwave(owner)
			if(istype(A,/turf/))del(src)
			if(isobj(A))loc=A.loc
		Move()
			var/J=new/obj/proj/sandwave(loc)
			J:icon_state="[typez]"
			J:icon=icon
			J:dir=dir
			if(J)J:owner=owner
			if(firstsand)
				firstsand=0
				J:icon_state="end[typez]"
			..()
	sandwave
		name="Sand Tsunami"
		icon='sandwave.dmi'
		density=0
		New()
			..()
			spawn(140)del src
		Del()
			for(var/mob/M in loc)if(M.coffined==2)
				M.layer=3
				M.busy=null
				M.freeze=0
				M.coffined=0
				M.coffinby=null
				M.overlay()
			icon_state="end"
			spawn(1)..()
		Crossed(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(D.npc||O.aff==D.aff)return
				D.sandwave(O)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					T.loc=loc
		Uncrossed(A)
			if(istype(A,/mob))
				var/mob/D=A
				if(D.coffined==2)
					D.busy=null
					D.freeze=0
					D.coffined=0
					D.coffinby=null
					D.overlay()
	rashoumonshield/New()spawn(140)if(src)del src
obj
	landmine
		name="Mine"
		icon='landmine.dmi'
		icon_state="armed"
		density=0
		var/obj/spawnz=null
		Del()
			if(spawnz)src:spawnz:spawnmine()
			..()
		Crossed(mob/A)
			..()
			if(ismob(A))
				spawn(1)
					if(owner&&owner==A)return
					src:detonate()
		proc/detonate()
			new/obj/explosion(loc)
			for(var/mob/M in range(src,1))
				if(M==owner)continue
				var/damage=M.maxhp/3+200
				if(owner)
					damage=owner.pow*3+100
					M.damage(damage)
					M.death(owner)
				else
					M.damage(damage)
					if(M.mybar)M.mybar:updatebar()
					M.minedeath()
			del src
	Landmine_Spawn
		icon='landmine.dmi'
		icon_state="armed"
		New()
			..()
			invisibility=90
			var/g=new/obj/landmine(loc)
			g:spawnz=src
		proc/spawnmine()
			spawn(3000)
				var/g=new/obj/landmine(loc)
				g:spawnz=src
obj
	GMmine
		name="Mine"
		icon='landmine.dmi'
		icon_state="armed"
		density=0
		Crossed(mob/A)
			..()
			if(ismob(A))
				spawn(1)
				if(A.GM<2)
					new/obj/explosion(loc)
					A.loc=null
					world<<"<b><font color=red>Admin Alert: [A] loves the cock."
					del A