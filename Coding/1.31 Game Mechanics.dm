client/mouse_pointer_icon = /obj/arrowcursor
obj/arrowcursor
	icon='cursor.dmi'
	name=""
	layer=FLY_LAYER
	mouse_over_pointer=MOUSE_ACTIVE_POINTER
mob/var/tmp/barrierhold=0
mob/var/tmp/specmove=0
mob/player/Move()
	if(dead||resting||shield||sandshield||freeze&&!godmode||ingenin==2||!fast&&moving||weights&&energy<=0||npc==3)return
	var/fasting=0
	if(fast)fasting=1
	if(!fasting&&!demon)moving=1
	..()
	if(specmove)
		if(weights)
			if(!hyugdelay)
				exp(1)
				if(missioned&&!mission)exp(rand(1,4))
				if(ancestorboost)exp(10)
				if(secretpower)exp(40)
				if(goldscroll)exp(20)
				spdexp()
				hyugdelay(expgainscale(12,Spd))
			energy-=1
			eupdatebar()
			delay=expgainscale(18,Spd)
		if(saidstuff)for(var/obj/text/C in oview(2))if(C.owner==src)C.loc=loc
		if(collision)for(var/obj/collision/C in oview(2))if(C.owner==src)C.loc=loc
	if(onwater)
		var/t=loc
		spawn(3)new/obj/waterstep(t)
	delay()
	runstep++
	if(runstep>=4)
		if(client&&!snared)
			if(onwater&&con<40||clouded)goto norun
			runstep=5
			running=1
			icon_state="run"
	norun
	if(runstep>6)runstep=6
	if(icon_state=="swim")
		var/c=(100-Sta*10)/10
		if(c<1)c=1
		energy-=rand(1,c)
		eupdatebar()
		if(energy<0)deathdrown()
	if(!fasting)spawn(delay)moving=0
mob/NPC/Move()
	if(caught||imitated||paralysed||dead||shield||freeze||!fast&&moving)return
	var/fasting=0
	if(fast)fasting=1
	if(!fasting)moving=1
	..()
	if(collision)for(var/obj/collision/C in oview(2))if(C.owner==src)C.loc=loc
	delay=rundelay
	delay+=snared
	if(!fasting)spawn(delay)moving=0
mob/Animal/Move()
	if(caught||stun||imitated||paralysed||dead||freeze||moving)return
	moving=1
	..()
	var/deed=rundelay
	if(icon_state=="swim")deed+=3
	if(collision)for(var/obj/collision/C in oview(1))if(C.owner==src)C.loc=loc
	spawn(deed)moving=0
mob/var
	runstep=0
	running=0
	delay=1
	runamount=0
mob/proc/delay()
	delay=rundelay
	if(onwater&&con<40||seals)delay++
	if(cloaking)if(Spd<13)delay+=2
	if(running)delay-=2
	if(icon_state=="swim")delay+=2
	if(critcon)delay+=3
	if(insnake)delay=1
	if(!immuneslow&&!godmode&&stance!="fmirror")
		if(slow)
			var/R=slow
			if(preheal&&tier61)
				R-=tier61+1
				if(R<0)R=0
			delay+=R
	if(clouded||Gate=="Pain"||Gate=="View")delay=0
obj/Move()
	if(freeze)return
	..()
obj/proc/moveslow(var/zdir)
	..()
	step(src,zdir)
	spawn(3)
		step(src,zdir)
		spawn(3)
			step(src,zdir)
			spawn(3)
				step(src,zdir)
				spawn(3)
					step(src,zdir)
					spawn(3)
						step(src,zdir)
						spawn(3)
							step(src,zdir)
							if(!freeze)
								del src
obj/proc/moveslowlong(var/zdir)
	..()
	step(src,zdir)
	spawn(2)
		step(src,zdir)
		spawn(2)
			step(src,zdir)
			spawn(2)
				step(src,zdir)
				spawn(2)
					step(src,zdir)
					spawn(2)
						step(src,zdir)
						spawn(2)
							step(src,zdir)
							spawn(2)
								step(src,zdir)
								spawn(2)
									step(src,zdir)
									spawn(2)
										step(src,zdir)
										spawn(2)
											step(src,zdir)
											spawn(2)
												step(src,zdir)
												if(!freeze)del src

obj/proc/movequick(var/zdir)
	..()
	step(src,zdir)
	spawn(1)
		step(src,zdir)
		step(src,zdir)
		spawn(1)
			step(src,zdir)
			step(src,zdir)
			spawn(1)
				step(src,zdir)
				step(src,zdir)
				spawn(1)
					step(src,zdir)
					step(src,zdir)
					spawn(1)
						step(src,zdir)
						step(src,zdir)
						spawn(1)
							step(src,zdir)
							if(!freeze)
								del src
obj/proc/gathermove(var/zdir)
	..()
	if(src)
		step(src,zdir)
		spawn(1)
			if(src)
				step(src,zdir)
				step(src,zdir)
				spawn(1)
					if(src)
						step(src,zdir)
						step(src,zdir)
						spawn(1)
							if(src)
								step(src,zdir)
								step(src,zdir)
								spawn(1)
									if(src)
										step(src,zdir)
										if(!freeze)
											del src
obj/proc/movequicklong(var/zdir)
	..()
	step(src,zdir)
	spawn(1)
		step(src,zdir)
		step(src,zdir)
		spawn(1)
			step(src,zdir)
			step(src,zdir)
			spawn(1)
				step(src,zdir)
				step(src,zdir)
				spawn(1)
					step(src,zdir)
					step(src,zdir)
					spawn(1)
						step(src,zdir)
						step(src,zdir)
						spawn(1)
							step(src,zdir)
							step(src,zdir)
							spawn(1)
								step(src,zdir)
								step(src,zdir)
								spawn(1)
									step(src,zdir)
									step(src,zdir)
									spawn(1)
										step(src,zdir)
										step(src,zdir)
										spawn(1)
											step(src,zdir)
											step(src,zdir)
											spawn(1)
												step(src,zdir)
												if(!freeze)del src

obj/var/firstsand=0
obj
	collision
		icon='collision.dmi'
		animate_movement=2
		New()
			..()
			pixel_y=rand(-6,6)
			layer=30
			spawn(15)del src
		Del()
			if(owner)if(owner.collision)owner.collision--
			..()
	bloodstep
		icon='bloodstep.dmi'
		New()
			..()
			flick(pick("1","2","3","4","5"),src)
			spawn(50)del src
	repbartime
		layer=83
		icon='rephelp.dmi'
		screen_loc="18,4"
	repbar
		icon='rephelp.dmi'
		screen_loc="18,4"
		layer=79
		Click()
			if(goldenage!="none")usr<<"<b><font color=yellow>A [goldenage] golden age is occuring."
			usr<<"<b><font color=lime>Leaf Influence: [leafrep]%"
			usr<<"<b><font color='#E0A175'>Sand Influence: [sandrep]%"
			usr<<"<b><font color=silver>Sound Influence: [soundrep]%"
			usr<<"<b><font color=lime>Leaf Banners: [leafter]"
			usr<<"<b><font color='#E0A175'>Sand Banners: [sandter]"
			usr<<"<b><font color=silver>Sound Banners: [soundter]"
			usr<<"<b><font color=lime>Leaf bandum is being controlled by [leafban]."
			usr<<"<b><font color='#E0A175'>Sand bandum is being controlled by [sandban]."
			usr<<"<b><font color=silver>Sound bandum is being controlled by [soundban]."
		leaf
			icon='leafrep.dmi'
			layer=80
			New()
				refresh()
				..()
			proc/refresh()
				var/percent=round(leafrep,5)
				if(percent>=140)
					layer=81
					percent=150
				else
					layer=80
				if(percent<80)percent=80
				icon_state=num2text(percent)
				spawn(200)refresh()
		sand
			icon='sandrep.dmi'
			layer=80
			New()
				refresh()
				..()
			proc/refresh()
				var/percent=round(sandrep,5)
				if(percent>=140)
					layer=81
					percent=150
				else
					layer=80
				if(percent<80)percent=80
				icon_state=num2text(percent)
				spawn(200)refresh()
		sound
			icon='soundrep.dmi'
			layer=80
			New()
				refresh()
				..()
			proc/refresh()
				var/percent=round(soundrep,5)
				if(percent>=140)
					layer=81
					percent=150
				else
					layer=80
				if(percent<80)percent=80
				icon_state=num2text(percent)
				spawn(200)refresh()

mob
	var
		mybar=null
		mybar2=null
	proc
		barloc()
			if(mybar)
				mybar:loc=loc
				mybar:invisibility=invisibility
				if(insnake||lotus)mybar:invisibility+=20
			if(mybar2)
				mybar2:invisibility=invisibility
				mybar2:loc=loc
				if(insnake||lotus)mybar2:invisibility+=20
obj/bars
	var/mob/barowner=null
	animate_movement=2
	layer=30
	rundelay=0
	healthbar
		icon='healthbar.dmi'
		pixel_y=-3
		proc/updatebar()
			if(barowner==null||!barowner)del src
			invisibility=barowner.invisibility
			if(barowner.insnake)invisibility=20
			if(barowner.name=="Tree"||barowner.name=="Scarecrow"||barowner.name=="Banner"||barowner.name=="Cactus"||barowner.name=="Dummy")invisibility=20
			loc=barowner.loc
			var/percent=round((barowner.hp/barowner.maxhp)*100)
			if(percent>100)percent=100
			if(percent<0)percent=0
			icon_state=num2text(round(percent,2))
			if(barowner.client)
				for(var/obj/hudbars/health/M in barowner.client.screen)M.icon_state="[round(percent,5)]"
				barowner.refreshword()
		proc/copy(var/O)
			spawn(1)
				if(barowner==null||!barowner||!O)del src
				invisibility=barowner.invisibility
				loc=barowner.loc
				var/percent=round((O:hp/O:maxhp)*100,2)
				if(percent>100)percent=100
				if(percent<0)percent=0
				icon_state=num2text(percent)
				check()
		proc/check()
			spawn(5)
				if(barowner==null)del src
				loc=barowner.loc
				check()
		proc/standnpc()
			spawn(rand(50,200))
				if(barowner==null)del src
				loc=barowner.loc
				icon_state=100
				standnpc()
	chakrabar
		icon='chakrabar.dmi'
		pixel_y=-5
		proc/updatebar()
			if(barowner==null||!barowner)del src
			invisibility=barowner.invisibility
			if(barowner.insnake)invisibility=20
			if(barowner.name=="Tree"||barowner.name=="Scarecrow"||barowner.name=="Banner"||barowner.name=="Cactus"||barowner.name=="Dummy")invisibility=20
			loc=barowner.loc
			var/percent=round((barowner.cha/barowner.maxcha)*100)
			if(percent>100)percent=100
			if(percent<0)percent=0
			icon_state=num2text(round(percent,2))
			if(barowner.client)
				for(var/obj/hudbars/chakra/M in barowner.client.screen)M.icon_state="[round(percent,5)]"
				barowner.refreshword()
		proc/copy(var/O)
			spawn(1)
				if(barowner==null||!barowner||!O)del src
				invisibility=barowner.invisibility
				loc=barowner.loc
				var/percent=round((O:cha/O:maxcha)*100,10)
				if(percent>100)percent=100
				if(percent<0)percent=0
				icon_state=num2text(percent)
				check()
		proc/check()
			spawn(5)
				if(barowner==null)del src
				loc=barowner.loc
				check()
		proc/standnpc()
			spawn(rand(50,200))
				if(barowner==null)del src
				loc=barowner.loc
				icon_state=100
				standnpc()
mob/var/tmp/confused=0
mob/proc
	eupdatebar()
		if(!client)return
		var/percent=round((energy/maxenergy)*100,10)
		if(clan=="Uchiha"&&level>=95)percent=100-blind
		if(percent>100)percent=100
		if(percent<0)percent=0
		for(var/obj/hudbars/energy/M in client.screen)M.icon_state="[round(percent,10)]"
	goldenaging()
		if(goldenagetime>0)
			for(var/obj/repbartime/G in client.screen)
				G:icon_state="[goldenagetime]"
			spawn(840)goldenaging()
		else
			for(var/obj/repbartime/G in client.screen)
				G:icon_state="0"
client
	North()
		if(mob.fanging||mob.busy=="rising wind"||mob.winded||mob.lotus)return
		if(mob.meditating)
			for(var/obj/chakraarrow/M in oview(mob,1))if(M.dir==NORTH)
				if(!mob.hyugdelay)
					var/t=0
					for(var/obj/Waterfall/G in oview(1,mob))
						t=1
					if(t)
						mob.hyugdelay(expgainscale(16,mob.Sta))
						mob.exp(1)
						if(mob.missioned&&!mob.mission)mob.exp(rand(1,4))
						if(mob.ancestorboost)mob.exp(10)
						if(mob.secretpower)mob.exp(40)
						if(mob.goldscroll)mob.exp(20)
						if(mob.village=="Sand")mob.exp(0.3)
						mob.staexp()
					else
						mob.hyugdelay(expgainscale(16,mob.Int))
						mob.exp(1)
						if(mob.missioned&&!mob.mission)mob.exp(rand(1,4))
						if(mob.ancestorboost)mob.exp(10)
						if(mob.secretpower)mob.exp(40)
						if(mob.goldscroll)mob.exp(20)
						mob.intexp()
				for(var/obj/chakraarrow/M1 in oview(mob,1))M1.dir=pick(SOUTH,EAST,WEST)
			return
		if(mob.busy=="coffin")
			for(var/obj/coffinmove/M in oview(12))
				if(M.owner==mob)
					if(M.dir!=SOUTH)
						M.dir=NORTH
		if(mob.c2dragoning)for(var/obj/c2dragon/M in world)if(M.owner==mob)
			M.dir=NORTH
			walk(M,M.dir)
		if(mob.freeze&&mob.shadow)for(var/obj/imitation/M in oview(12))if(M.owner==mob)if(M.dir!=SOUTH&&!M.freeze)if(M.icon_state!="struggle")if(M.turns<M.shadowturns)
			M.dir=NORTH
			M.turns++
		if(mob.freeze&&mob.sewing)for(var/obj/shadowsewing/M in oview(12))if(M.owner==mob)if(M.dir!=SOUTH)if(M.turns<M.sewingturns)
			M.dir=NORTH
			M.turns++
		if(!mob.godmode)if(mob.caught||mob.stun&&mob.stance!="fmirror"||mob.freeze||mob.imitated)return
		if(mob.imitation)for(var/mob/M in world)if(mob.imitation==M)
			if(mob.moving||mob.resting||mob.freeze||M.freeze)return
			M.moving=0
			for(var/obj/imitationt/T in world)if(T.owner==mob)step(T,NORTH)
			step(mob,NORTH)
			step(M,NORTH)
			mob.dir=mob.shadowdir
			M.dir=M.shadowdir
		else
			if(mob.confused)
				mob.dir=SOUTH
				step(mob,SOUTH)
			else
				if(mob.spidering||mob.busy=="fflower")
					var/T=mob.dir
					..()
					mob.dir=T
					return
				mob.dir=NORTH
				..()
	South()
		if(mob.fanging||mob.busy=="rising wind"||mob.winded||mob.lotus)return
		if(mob.meditating)
			for(var/obj/chakraarrow/M in oview(mob,1))if(M.dir==SOUTH)
				if(!mob.hyugdelay)
					var/t=0
					for(var/obj/Waterfall/G in oview(1,mob))
						t=1
					if(t)
						mob.hyugdelay(expgainscale(16,mob.Sta))
						mob.exp(1)
						if(mob.missioned&&!mob.mission)mob.exp(rand(1,4))
						if(mob.ancestorboost)mob.exp(10)
						if(mob.secretpower)mob.exp(40)
						if(mob.goldscroll)mob.exp(20)
						if(mob.village=="Sand")mob.exp(0.3)
						mob.staexp()
					else
						mob.hyugdelay(expgainscale(16,mob.Int))
						mob.exp(1)
						if(mob.missioned&&!mob.mission)mob.exp(rand(1,4))
						if(mob.ancestorboost)mob.exp(10)
						if(mob.secretpower)mob.exp(40)
						if(mob.goldscroll)mob.exp(20)
						mob.intexp()
				for(var/obj/chakraarrow/M1 in oview(mob,1))M1.dir=pick(NORTH,EAST,WEST)
			return
		if(mob.busy=="coffin")
			for(var/obj/coffinmove/M in oview(12))
				if(M.owner==mob)
					if(M.dir!=NORTH)
						M.dir=SOUTH
		if(mob.c2dragoning)for(var/obj/c2dragon/M in world)if(M.owner==mob)
			M.dir=SOUTH
			walk(M,M.dir)
		if(mob.freeze&&mob.shadow)for(var/obj/imitation/M in oview(12))if(M.owner==mob)if(M.dir!=NORTH&&!M.freeze)if(M.icon_state!="struggle")if(M.turns<M.shadowturns)
			M.dir=SOUTH
			M.turns++
		if(mob.freeze&&mob.sewing)for(var/obj/shadowsewing/M in oview(12))if(M.owner==mob)if(M.dir!=NORTH)if(M.turns<M.sewingturns)
			M.dir=SOUTH
			M.turns++
		if(!mob.godmode)if(mob.caught||mob.stun&&mob.stance!="fmirror"||mob.freeze||mob.imitated)return
		if(mob.imitation)for(var/mob/M in world)if(mob.imitation==M)
			if(mob.moving||mob.resting||mob.freeze||M.freeze)return
			M.moving=0
			for(var/obj/imitationt/T in world)if(T.owner==mob)step(T,SOUTH)
			step(mob,SOUTH)
			step(M,SOUTH)
			mob.dir=mob.shadowdir
			M.dir=M.shadowdir
		else
			if(mob.confused)
				mob.dir=NORTH
				step(mob,NORTH)
			else
				if(mob.spidering||mob.busy=="fflower")
					var/T=mob.dir
					..()
					mob.dir=T
					return
				mob.dir=SOUTH
				..()
	East()
		if(mob.fanging||mob.busy=="rising wind"||mob.winded||mob.lotus)return
		if(mob.meditating)
			for(var/obj/chakraarrow/M in oview(mob,1))if(M.dir==EAST)
				if(!mob.hyugdelay)
					var/t=0
					for(var/obj/Waterfall/G in oview(1,mob))
						t=1
					if(t)
						mob.hyugdelay(expgainscale(16,mob.Sta))
						mob.exp(1)
						if(mob.missioned&&!mob.mission)mob.exp(rand(1,4))
						if(mob.ancestorboost)mob.exp(10)
						if(mob.secretpower)mob.exp(40)
						if(mob.goldscroll)mob.exp(20)
						if(mob.village=="Sand")mob.exp(0.3)
						mob.staexp()
					else
						mob.hyugdelay(expgainscale(16,mob.Int))
						mob.exp(1)
						if(mob.missioned&&!mob.mission)mob.exp(rand(1,4))
						if(mob.ancestorboost)mob.exp(10)
						if(mob.secretpower)mob.exp(40)
						if(mob.goldscroll)mob.exp(20)
						mob.intexp()
				for(var/obj/chakraarrow/M1 in oview(mob,1))M1.dir=pick(SOUTH,NORTH,WEST)
			return
		if(mob.busy=="coffin")
			for(var/obj/coffinmove/M in oview(12))
				if(M.owner==mob)
					if(M.dir!=WEST)
						M.dir=EAST
		if(mob.c2dragoning)for(var/obj/c2dragon/M in world)if(M.owner==mob)
			M.dir=EAST
			walk(M,M.dir)
		if(mob.freeze&&mob.shadow)for(var/obj/imitation/M in oview(12))if(M.owner==mob)if(M.dir!=WEST&&!M.freeze)if(M.icon_state!="struggle")if(M.turns<M.shadowturns)
			M.dir=EAST
			M.turns++
		if(mob.freeze&&mob.sewing)for(var/obj/shadowsewing/M in oview(12))if(M.owner==mob)if(M.dir!=WEST)if(M.turns<M.sewingturns)
			M.dir=EAST
			M.turns++
		if(!mob.godmode)if(mob.caught||mob.stun&&mob.stance!="fmirror"||mob.freeze||mob.imitated)return
		if(mob.imitation)for(var/mob/M in world)if(mob.imitation==M)
			if(mob.moving||mob.resting||mob.freeze||M.freeze)return
			M.moving=0
			for(var/obj/imitationt/T in world)if(T.owner==mob)step(T,EAST)
			step(mob,EAST)
			step(M,EAST)
			mob.dir=mob.shadowdir
			M.dir=M.shadowdir
		else
			if(mob.confused)
				mob.dir=WEST
				step(mob,WEST)
			else
				if(mob.spidering||mob.busy=="fflower")
					var/T=mob.dir
					..()
					mob.dir=T
					return
				mob.dir=EAST
				..()
	West()
		if(mob.fanging||mob.busy=="rising wind"||mob.winded||mob.lotus)return
		if(mob.meditating)
			for(var/obj/chakraarrow/M in oview(mob,1))if(M.dir==WEST)
				if(!mob.hyugdelay)
					var/t=0
					for(var/obj/Waterfall/G in oview(1,mob))
						t=1
					if(t)
						mob.hyugdelay(expgainscale(16,mob.Sta))
						mob.exp(1)
						if(mob.missioned&&!mob.mission)mob.exp(rand(1,4))
						if(mob.ancestorboost)mob.exp(10)
						if(mob.secretpower)mob.exp(40)
						if(mob.goldscroll)mob.exp(20)
						if(mob.village=="Sand")mob.exp(0.3)
						mob.staexp()
					else
						mob.hyugdelay(expgainscale(16,mob.Int))
						mob.exp(1)
						if(mob.missioned&&!mob.mission)mob.exp(rand(1,4))
						if(mob.ancestorboost)mob.exp(10)
						if(mob.secretpower)mob.exp(40)
						if(mob.goldscroll)mob.exp(20)
						mob.intexp()
				for(var/obj/chakraarrow/M1 in oview(mob,1))M1.dir=pick(SOUTH,EAST,NORTH)
			return
		if(mob.busy=="coffin")
			for(var/obj/coffinmove/M in oview(12))
				if(M.owner==mob)
					if(M.dir!=EAST)
						M.dir=WEST
		if(mob.c2dragoning)for(var/obj/c2dragon/M in world)if(M.owner==mob)
			M.dir=WEST
			walk(M,M.dir)
		if(mob.freeze&&mob.shadow)for(var/obj/imitation/M in oview(12))if(M.owner==mob)if(M.dir!=EAST&&!M.freeze)if(M.icon_state!="struggle")if(M.turns<M.shadowturns)
			M.dir=WEST
			M.turns++
		if(mob.freeze&&mob.sewing)for(var/obj/shadowsewing/M in oview(12))if(M.owner==mob)if(M.dir!=EAST)if(M.turns<M.sewingturns)
			M.dir=WEST
			M.turns++
		if(!mob.godmode)if(mob.caught||mob.stun&&mob.stance!="fmirror"||mob.freeze||mob.imitated)return
		if(mob.imitation)for(var/mob/M in world)if(mob.imitation==M)
			if(mob.moving||mob.resting||mob.freeze||M.freeze)return
			M.moving=0
			for(var/obj/imitationt/T in world)if(T.owner==mob)step(T,WEST)
			step(mob,WEST)
			step(M,WEST)
			mob.dir=mob.shadowdir
			M.dir=M.shadowdir
		else
			if(mob.confused)
				mob.dir=EAST
				step(mob,EAST)
			else
				if(mob.spidering||mob.busy=="fflower")
					var/T=mob.dir
					..()
					mob.dir=T
					return
				mob.dir=WEST
				..()
	Northwest()return
	Northeast()return
	Southwest()return
	Southeast()return
mob/proc
	Northwest()
		var/G=pick(NORTH,WEST)
		var/T
		if(G==NORTH)T=WEST
		else T=NORTH
		for(var/atom/M in get_step(src,G))if(density)
			step(src,T)
			return
		step(src,G)
	Northeast()
		var/G=pick(NORTH,EAST)
		var/T
		if(G==NORTH)T=EAST
		else T=NORTH
		for(var/atom/M in get_step(src,G))if(density)
			step(src,T)
			return
		step(src,G)
	Southwest()
		var/G=pick(SOUTH,WEST)
		var/T
		if(G==SOUTH)T=WEST
		else T=SOUTH
		for(var/atom/M in get_step(src,G))if(density)
			step(src,T)
			return
		step(src,G)
	Southeast()
		var/G=pick(SOUTH,EAST)
		var/T
		if(G==SOUTH)T=EAST
		else T=SOUTH
		for(var/atom/M in get_step(src,G))if(density)
			step(src,T)
			return
		step(src,G)
proc
	realnum(num=0)
		if(!isnum(num)) return 0
		var/num_text = "[num]"
		var/newNum = ""
		var/e_loc = findtext(num_text,"e")
		if(!e_loc) return num
		var/num_1 = copytext(num_text,1,e_loc)
		var/num_2 = copytext(num_text,e_loc+2,length(num_text)+1)
		var/newNum_1 = text2num(num_1)
		var/newNum_2 = text2num(num_2)
		var/multiply = ""
		for(var/loop = 1 to newNum_2)
			multiply += "0"
		multiply = text2num("1[multiply]")
		newNum = num2text(newNum_1*multiply,newNum_2+1)
		return newNum

///////////////////////Critical Hits/////////////////////////////

mob/proc/critroll(var/mob/M)
	criticalroll = critrate - M.critdef
	if(stance == "Precise Striking")
		criticalroll += M.critdef
	if(stance == "Rapid Palms")
		criticalroll = criticalroll/2
	if(criticalroll < 1)
		criticalroll = 1

mob/proc/debuffcount(var/time,var/w=1)
	debuffa=0
	if(debuff1)
		debuffa++
		if(debuff2)
			debuffa++
			if(debuff3)
				debuffa++
				if(debuff4)debuffa++
				else
					debuff4=w
					spawn(time)debuff4=0
			else
				debuff3=w
				spawn(time)debuff3=0
		else
			debuff2=w
			spawn(time)debuff2=0
	else
		debuff1=w
		spawn(time)debuff1=0
//damage change

mob/proc
	dmgch(var/mob/attacker, var/melee = 0, var/element = null)
		if(!attacker || !src)
			return
		variable = 1
		variable2 = 0
		if(melee)
			variable *= attacker.atkstr/100-def/100
		else
			variable *= attacker.atk/100-def/100
		if(attacker.clan == "Yuki" && attacker.tier53)
			var/capd = def/100
			var/defdam = 0.2 * attacker.tier53
			if(defdam > capd)
				defdam = capd
			variable += defdam
		if(attacker.clan == "Taijutsu Specialist" && attacker.tier42)
			var/capd = def/100
			var/defdam = 0.03 * attacker.tier42
			if(defdam > capd)
				defdam = capd
			variable += defdam
		if(attacker.special==/obj/itachiring)
			var/capd = def/100
			var/defdam = 0.15
			if(defdam > capd)
				defdam = capd
			variable += defdam
		if(attacker.special==/obj/peinring)
			var/capd = def/100
			var/defdam = 0.05
			if(defdam > capd)
				defdam = capd
			variable += defdam
		if(Debuff=="Body Destruction")
			variable += 0.2
		if(attacker.lusted == 3)
			variable += attacker.tier43 * 0.1
		if(tier32 && clan == "Yuki")
			variable += (1-(hp/maxhp))
		if(clan == "Uchiha" && tier32 && maxhp/4 >= hp)
			variable -= 0.1 * tier32
		if(attacker.tier11 && attacker.clan == "Uchiha" && freeze)
			variable += 0.05 + 0.05 * attacker.tier11
		if(attacker.tier53 && attacker.clan == "Copy Ninja" && hp < maxhp*0.30)
			variable += attacker.tier53*0.10
		if(selfrally&&clan=="Copy Ninja"&&prob(20))
			variable-=0.20
		if(attacker.tier33 && attacker.clan == "Senju" && hp < maxhp*0.50)
			variable += attacker.tier33*0.04
		if(attacker.tier23 && attacker.clan == "Nara" && hp < maxhp*0.25)
			variable += attacker.tier23*0.10
		if(kyuubimode && attacker.rank != "Bijuu")
			variable = 0
		if(clan=="Senju"&&tier23)
			if(!repercussivecd)
				repercussivecd=1
				spawn(290-40*tier23)repercussivecd=0
				for(var/mob/M in range(src,3))
					if(M.aff==aff)return
					M.rootcaught(src,1)
		if(clan=="Clay"&&tier22)
			if(!repercussioncd)
				repercussioncd=1
				spawn(100)repercussioncd=0
				new/obj/claymineexplosion(attacker.loc)
				if(tier11)attacker.snared(tier11*0.2,2)
				var/damage=round(pow*(0.15*tier22))
				attacker.dmgch(src,1)
				damage=(damage*attacker.variable)+attacker.variable2
				var/critchance=0+(10*tier52)
				if(prob(critchance)&&tier52)
					if(tier62)
						attacker.stun(2.5*tier62)
						attacker.maimingshock(src)
					attacker.damage(damage,1.4)
				else
					attacker.damage(damage)
				attacker.death(src)
	soundeff(var/S,var/vol,var/typ=0)
		if(kyuubimode)return
		if(typ==0)
			src<<sound(S,volume=vol)
			oview(src,10)<<sound(S,volume=vol*0.7)
		if(typ==1)
			src<<sound(S,volume=vol)