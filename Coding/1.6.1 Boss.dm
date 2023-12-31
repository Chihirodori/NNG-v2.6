mob
	boss
		Kyuubi
			icon='kyuubi.dmi'
			bound_width=96
			bound_height=96
			pixel_x=-174
			pixel_y=-115
			layer=30
			New()
				name="Kyuubi"
				hair='sasukehair.dmi'
				Str=250
				Tai=130
				Nin=400
				Hsl=30
				Int=300
				Sta=380
				Spd=82
				level=1895
				village="Chaos"
				clan="Nine Tails"
				rank="Bijuu"
				statset()
				maxhp=750000
				hp=maxhp
				cha=maxcha
				var/B1=new/obj/kyuubibar(loc)
				B1:barowner=src
				mybar=B1
				B1:updatebar()
				..()
				spawn(2)kyuubiproc()
			Del()
				invisibility=100
				hp=1000000
				world<<"<b>Kyuubi is terminated. The world returned to normal."
				kyuubimode=0
				kyuubidie()
				spawn(26)
				..()
			proc
				kyuubiproc()
					if(dead)return
					if(busy!="beaming")
						if(prob(30))
							dir=pick(NORTH,SOUTH,EAST,WEST)
						if(prob(92)&&hp>200000||prob(82)&&hp<200000)
							kyuubiswipe()
							if(prob(10)&&hp>600000&&hp||prob(25)&&hp>200000&&hp<600000||prob(50)&&hp<200000)
								spawn(2)
									kyuubiswipe()
								spawn(4)
									dir=pick(NORTH,SOUTH,EAST,WEST)
									kyuubiswipe()
								spawn(6)
									kyuubiswipe()
								spawn(8)
									kyuubiswipe()
								spawn(10)
									dir=pick(NORTH,SOUTH,EAST,WEST)
									kyuubiswipe()
								spawn(12)
									dir=pick(NORTH,SOUTH,EAST,WEST)
									kyuubiswipe()
								spawn(14)
									kyuubiswipe()
								spawn(16)
									kyuubiswipe()
								spawn(18)
									dir=pick(NORTH,SOUTH,EAST,WEST)
									kyuubiswipe()
						else
							if(prob(20)&&hp>300000||prob(35)&&hp<300000)
								dir=pick(NORTH,SOUTH,EAST,WEST)
								kyuubitbeam()
							else
								kyuubigroundburst()
						if(prob(60))
							if(hp>800000)
								if(prob(50))
									kyuubibomb()
							else
								kyuubibomb()
								if(hp<400000)
									spawn(4)kyuubibomb()
									spawn(8)kyuubibomb()
									spawn(12)kyuubibomb()
									spawn(16)kyuubibomb()
					spawn(20)kyuubiproc()
obj
	tbomb
		layer=60
		icon='tbomb.dmi'
		var/doomloc
		New()
			..()
			flick("charge",src)
			spawn(200)del src
		Move()
			..()
			if(doomloc)if(doomloc==loc)
				walk(src,0)
				icon=null
				new/obj/explosion2(loc)
				//new/obj/tbombboom(loc)
				//new/obj/tbombboomfade/one(loc)
				//new/obj/tbombboomfade/two(loc)
				//new/obj/tbombboomfade/three(loc)
				//new/obj/tbombboomfade/four(loc)
				for(var/mob/M in range(src,2))
					if(M==owner)continue
					var/damage=1400
					M.dmgch(owner)
					damage=(damage*M.variable)+M.variable2
					M.damage(damage)
					M.death(owner)
				for(var/mob/M in range(src,1))
					if(M==owner)continue
					var/damage=2500
					M.dmgch(owner)
					damage=(damage*M.variable)+M.variable2
					M.damage(damage)
					M.death(owner)
				/*var/D=10
				while(D)
					D--
					sleep(10)
					for(var/mob/M in range(src,2))
						if(M==owner)continue
						var/damage=1000
						M.dmgch(owner)
						damage=(damage*M.variable)+M.variable2
						M.damage(damage)
						M.death(owner)*/
				del src
	tbombboom
		icon='tbombboom.dmi'
		layer=41
		pixel_y=-64
		pixel_x=-64
		New()
			..()
			spawn(15)del src
	tbombboomfade
		icon='tbombboom.dmi'
		icon_state="fade"
		layer=40
		pixel_y=-64
		pixel_x=-64
		one
			New()
				..()
				spawn(140)del src
		two
			New()
				..()
				spawn(100)del src
		three
			New()
				..()
				spawn(70)del src
		four
			New()
				..()
				spawn(30)del src
	kyuubitarget
		layer=50
		icon='kyuubitarget.dmi'
		New()
			..()
			spawn(7)del src
	tbeamcharge
		icon='tbomb.dmi'
		icon_state="charge"
		layer=50
		New()
			..()
			spawn(rand(2,12))del src
	tbombtarget
		layer=50
		icon='tbombtarget.dmi'
		New()
			..()
			spawn(30)del src
	tbeam
		layer=50
		icon='tbeam.dmi'
		pixel_x=-96
		pixel_y=-96
		var/harmless=0
		var/lawdy=0
		var/suckedydoo=0
		New()
			..()
			spawn(40)del src
			spawn(2)
				if(!harmless)
					loop
						if(suckedydoo)
							for(var/mob/M in range(src,16))
								if(M==owner)continue
								step_to(M,src)
								spawn(7)step_to(M,src)
						for(var/mob/M in range(src,3))
							if(M==owner)continue
							var/damage=2500
							M.dmgch(owner)
							damage=(damage*M.variable)+M.variable2
							M.damage(damage)
							M.death(owner)
						spawn(14)goto loop

		Move()
			var/D=new/obj/tbeam(loc)
			D:owner=owner
			D:dir=dir
			D:icon=icon
			D:icon_state=icon_state
			lawdy++
			if(lawdy==5)D:suckedydoo=1
			..()
	kyuubiboom
		rundelay=0
		density=0
		New()spawn(34)del src
		Move()
			for(var/mob/M in loc)
				if(M==owner)continue
				var/damage=owner.pow
				M.dmgch(owner)
				damage=(damage*M.variable)+M.variable2
				M.damage(damage)
				M.death(owner)
			for(var/mob/M in range(src,1))
				if(M==owner)continue
				var/damage=owner.pow*0.3
				M.dmgch(owner)
				damage=(damage*M.variable)+M.variable2
				M.damage(damage)
				M.death(owner)
			var/K=new/obj/medic/groundcrack(loc)
			K:dir=dir
			..()

	kyuubibar
		icon='kyuubibar.dmi'
		pixel_x=-50
		pixel_y=-30
		var/mob/barowner=null
		animate_movement=2
		layer=31
		rundelay=0
		proc/updatebar()
			if(barowner==null||!barowner)del src
			invisibility=barowner.invisibility
			loc=barowner.loc
			var/percent=round((barowner.hp/barowner.maxhp)*100)
			if(percent>100)percent=100
			if(percent<0)percent=0
			icon_state=num2text(round(percent))
		proc/check()
			spawn(5)
				if(barowner==null)del src
				loc=barowner.loc
				check()
	kyuubiswipe
		pixel_x=-100
		pixel_y=-100
		layer=50
		New()
			flick('swipe.dmi',src)
			spawn(10)del src
			..()
mob
	Owner
		verb
			makekyuubi()
				set category = "Owner"
				if(GM<3)
					src<<"naw bitch you aint got the power"
					return
				new/mob/boss/Kyuubi(locate(x,y+5,z))
			kyuubidiee()
				set category = "Owner"
				if(GM<3)
					src<<"naw bitch you aint got the power"
					return
				kyuubidie()
			kyuubigroundbursto()
				set category = "Owner"
				if(GM<3)
					src<<"naw bitch you aint got the power"
					return
				kyuubigroundburst()
			kyuubiswipo()
				set category = "Owner"
				if(GM<3)
					src<<"naw bitch you aint got the power"
					return
				kyuubiswipe()
			kyuubibombadier()
				set category = "Owner"
				if(GM<3)
					src<<"naw bitch you aint got the power"
					return
				kyuubibomb()
			kyuubitbeamo()
				set category = "Owner"
				if(GM<3)
					src<<"naw bitch you aint got the power"
					return
				kyuubitbeam()
mob
	proc
		kyuubitbeam()
			busy="beaming"
			spawn(50)busy=null
			var/R=25
			while(R)
				sleep(1)
				R--
				var/obj/D=new/obj/tbeamcharge(loc)
				if(dir==NORTH)
					D.x+=rand(-2,2)
					D.y+=8
					walk(D,SOUTH)
				if(dir==EAST)
					D.y+=rand(-2,2)
					D.x+=8
					walk(D,WEST)
				if(dir==SOUTH)
					D.x+=rand(-2,2)
					D.y-=8
					walk(D,NORTH)
				if(dir==WEST)
					D.y+=rand(-2,2)
					D.x-=8
					walk(D,EAST)
			var/obj/D=new/obj/tbeam(loc)
			D:harmless=1
			D.icon=null
			D.owner=src
			D.icon=null
			step(D,dir)
			step(D,dir)
			step(D,dir)
			D.icon='tbeam.dmi'
			D.dir=dir
			step(D,dir)
			D.icon=null
			step(D,dir)
			step(D,dir)
			step(D,dir)
			D.icon='tbeam.dmi'
			D.icon_state="trail"
			D.movequicklong(dir)
		kyuubibomb()
			var/T=new/obj/tbomb(loc)
			T:owner=src
			T:x+=1
			T:y+=3
			var/dx=rand(-8,8)
			var/dy=rand(-8,8)
			if(dx<4&&dx>-4&&dy<4&&dy>-4)
				if(prob(50))
					dx+=2
					dx*=2
				else
					dy+=2
					dy*=2
			var/F=new/obj/tbombtarget(locate(x+dx+1,y+dy,z))
			if(prob(25))
				for(var/mob/player/G in range(12))
					if(prob(25))F:loc=G:loc
			T:doomloc=F:loc
			spawn(18)
				walk_to(T,T:doomloc)
		kyuubidie()
			var/F=25
			while(F)
				spawn(F)
					new/obj/explosion2(locate(x+rand(-8,8),y+rand(-8,8),z))
					new/obj/explosion2(locate(x+rand(-8,8),y+rand(-8,8),z))
					new/obj/explosion(locate(x+rand(-9,9),y+rand(-9,9),z))
					new/obj/explosion(locate(x+rand(-9,9),y+rand(-9,9),z))
					new/obj/medic/groundcrack(locate(x+rand(-9,9),y+rand(-9,9),z))
					new/obj/medic/groundcrack(locate(x+rand(-9,9),y+rand(-9,9),z))
					new/obj/fire(locate(x+rand(-9,9),y+rand(-9,9),z))
					new/obj/fire(locate(x+rand(-9,9),y+rand(-9,9),z))
					new/obj/fire(locate(x+rand(-9,9),y+rand(-9,9),z))
					new/obj/fire(locate(x+rand(-9,9),y+rand(-9,9),z))
					new/obj/fire(locate(x+rand(-9,9),y+rand(-9,9),z))
					new/obj/fire(locate(x+rand(-9,9),y+rand(-9,9),z))
					if(prob(25))soundeff('explosion4.wav',70,0)
				F--
		kyuubiswipe()
			var/F=new/obj/kyuubiswipe(locate(x+1,y,z))
			step(F,dir)
			step(F,dir)
			step(F,dir)
			if(prob(20))step(F,dir)
			if(prob(20))step(F,dir)
			if(prob(20))step(F,dir)
			if(prob(20))step(F,dir)
			if(prob(20))step(F,dir)
			if(prob(20))step(F,dir)
			if(prob(20))step(F,dir)
			if(prob(20))step(F,dir)
			for(var/mob/M in range(F,2))
				if(M==src)continue
				M.damage(420)
				M.death(src)
		kyuubigroundburst()
			var/obj/T=new/obj/kyuubitarget(locate(x+1,y+1,z))
			T.movequick(NORTH)
			var/obj/T2=new/obj/kyuubitarget(locate(x+1,y+1,z))
			T2.movequick(SOUTH)
			var/obj/T3=new/obj/kyuubitarget(locate(x+1,y+1,z))
			T3.movequick(EAST)
			var/obj/T4=new/obj/kyuubitarget(locate(x+1,y+1,z))
			T4.movequick(WEST)
			spawn(14)
				var/obj/D1=new/obj/kyuubiboom(locate(x+1,y+1,z))
				var/obj/D2=new/obj/kyuubiboom(locate(x+1,y+1,z))
				var/obj/D3=new/obj/kyuubiboom(locate(x+1,y+1,z))
				var/obj/D4=new/obj/kyuubiboom(locate(x+1,y+1,z))
				D1.owner=src
				D2.owner=src
				D3.owner=src
				D4.owner=src
				walk(D1,WEST)
				walk(D2,EAST)
				walk(D3,SOUTH)
				walk(D4,NORTH)
				var/obj/W=new/obj/kyuubitarget(locate(x+1,y+1,z))
				W.movequicklong(NORTHWEST)
				var/obj/W2=new/obj/kyuubitarget(locate(x+1,y+1,z))
				W2.movequicklong(NORTHEAST)
				var/obj/W3=new/obj/kyuubitarget(locate(x+1,y+1,z))
				W3.movequicklong(SOUTHEAST)
				var/obj/W4=new/obj/kyuubitarget(locate(x+1,y+1,z))
				W4.movequicklong(SOUTHWEST)
				spawn(14)
					var/obj/S1=new/obj/kyuubiboom(locate(x+1,y+1,z))
					var/obj/S2=new/obj/kyuubiboom(locate(x+1,y+1,z))
					var/obj/S3=new/obj/kyuubiboom(locate(x+1,y+1,z))
					var/obj/S4=new/obj/kyuubiboom(locate(x+1,y+1,z))
					S1.owner=src
					S2.owner=src
					S3.owner=src
					S4.owner=src
					S1.movequicklong(NORTHWEST)
					S2.movequicklong(NORTHEAST)
					S3.movequicklong(SOUTHEAST)
					S4.movequicklong(SOUTHWEST)
