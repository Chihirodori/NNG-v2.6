mob
	proc
		sexy()
			if(vdelay1||dead||resting||swim||stun||imitated||paralysed||imitation||caught||seals||busy)return
			prejutsu()
			handseals(5,30)
			if(!sealpass)return
			stun=1
			for(var/obj/jutsu/leaf/Sexy_Jutsu/M in src)M.overlays+='timer.dmi'
			var/sdelay=500

			if(curseseal==2)sdelay=sdelay/1.5
			if(curseseal==3)sdelay=sdelay/2
			spawn(sdelay*(cdpow/100))
				for(var/obj/jutsu/leaf/Sexy_Jutsu/M in src)M.overlays-='timer.dmi'
				vdelay1=0
			vdelay1=1
			variable3=1
			spawn(70)variable3=0
			spawn(27)stun=0
			flick('sexy jutsu.dmi',src)
			for(var/mob/player/M in oview(3))if(!M.stun)
				new/obj/heart(M.loc)
				M.stun=1
				spawn(46)M.stun=0
		shadowclonecombo()
			prejutsu()
			if(cdelay2||swim||dead||stun||resting||caught||seals||busy||imitated)return
			if(pow<70||con<50)
				handseals(25,50)
				if(!sealpass)return
			view(8)<<"<b><font color=red>[usr]: Shadow Clone Combo!"
			cdelay2=1
			for(var/obj/jutsu/leafnon/Shadow_Clone_Combo/M in src)M.overlays+='timer.dmi'
			var/sdelay=100

			if(curseseal==2)sdelay=sdelay/1.5
			if(curseseal==3)sdelay=sdelay/2
			spawn(sdelay*(cdpow/100))
				for(var/obj/jutsu/leafnon/Shadow_Clone_Combo/M in src)M.overlays-='timer.dmi'
				cdelay2=0
			for(var/mob/M in get_step(src,dir))
				if(village==M.village&&!M.pktoggle&&!pktoggle&&village!="None")return
				if(M.illusion)
					M.illusionhit(src)
					continue
				M.freeze=1
				freeze=1
				busy="stun"
				faceme(M)
				var/obj/himage/a=new(loc)
				var/obj/himage/aa=new(loc)
				var/obj/himage/aaa=new(loc)
				var/obj/himage/aaaa=new(loc)
				for(var/obj/himage/A in loc)
					A.overlays=overlays
					A.icon=icon
					A.loc=M.loc
					new/obj/smoke(A.loc)
					spawn(1)flick("attack",A)
				a.pixel_x=-12
				aa.pixel_x=-8
				aaa.pixel_x=12
				aaaa.pixel_x=8
				a.dir=EAST
				aa.dir=EAST
				aaa.dir=WEST
				aaaa.dir=WEST
				var/damage=0
				if(pow<50)damage=round(apow/2.5+rand(7,12))
				else damage=round(apow/2+rand(12,16))
				if(M.clan=="Taijutsu Specialist")
					if(M.tier32)damage*=1-(M.tier32*0.05)
				var/T=0
				while(T<3)
					T++
					var/obj/kimage/image=new(M.loc)
					image.dir=M.dir
					image.icon=M.icon
					image.overlays=M.overlays
					image.pixel_y=M.pixel_y
					M.pixel_y+=32
					sleep(1)
				var/obj/kimage/image3=new(loc)
				image3.dir=dir
				image3.icon=icon
				image3.overlays=overlays
				loc=M.loc
				pixel_y=80
				flick("attack",src)
				M.hp-=damage
				sleep(5)
				T=0
				while(T<3)
					T++
					var/obj/kimage/image=new(M.loc)
					image.dir=M.dir
					image.icon=M.icon
					image.overlays=M.overlays
					image.pixel_y=M.pixel_y
					M.pixel_y-=32
					var/obj/kimage/image2=new(M.loc)
					image2.dir=dir
					image2.icon=icon
					image2.overlays=overlays
					image2.pixel_y=pixel_y
					pixel_y-=27
					sleep(1)
				new/obj/crater(M.loc)
				new/obj/hit(M.loc)
				freeze=0
				M.freeze=0
				M.pixel_y=0
				pixel_y=0
				for(var/obj/himage/A in loc)
					new/obj/smoke(A.loc)
					del A
				stepback(3)
				M.stepback(3)
				sleep(3)
				busy=null
				M.death(src)
		firedragonflameblast()
			hengeback()
			cloakoff()
			if(cdelay3||swim||dead||stun||resting||caught||seals||busy||imitated)return
			handseals(35,80)
			if(!sealpass)return
			cdelay3=1
			for(var/obj/jutsu/leafnon/Fire_Dragon_Flame_Blast/M in src)M.overlays+='timer.dmi'
			stun=1
			icon_state="blast"
			busy="stun"
			var/K=new/obj/zankuuha(loc)
			K:owner=usr
			var/N=4
			K:powmin=4
			K:powmax=8
			if(pow>=65)N++
			if(pow>=80)
				N++
				K:powmin=8
				K:powmax=12
			if(pow>=100)
				N++
				K:powmin=16
				K:powmax=20
			if(pow>=120)
				N++
				K:powmin=30
				K:powmax=30
			K:dir=dir
			while(N>0)
				N--
				if(K)
					step(K,dir)
			for(var/obj/zankuuhat/M in loc)del M
			for(var/obj/zankuuhat/M in get_step(usr,dir))M.icon_state="blast"
			var/sdelay=100

			if(curseseal==2)sdelay=sdelay/1.5
			if(curseseal==3)sdelay=sdelay/2
			spawn(sdelay*(cdpow/100))
				for(var/obj/jutsu/leafnon/Fire_Dragon_Flame_Blast/M in src)M.overlays-='timer.dmi'
				cdelay3=0
			spawn(34)
				busy=null
				icon_state=""
				stun=0