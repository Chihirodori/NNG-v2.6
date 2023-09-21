mob
	proc
		fuumashuriken()
			prejutsu()
			if(busy||vdelay1||swim||dead||stun||resting||caught||seals||busy||imitated||paralysed)return
			var/L=new/obj/proj/ShurikenF(loc)
			for(var/obj/jutsu/leaf/Fuuma_Shuriken/M in src)M.overlays+='timer.dmi'
			vdelay1=1
			L:owner=usr
			busy=null
			walk(L,dir)
			spawn(35)
				for(var/obj/jutsu/leaf/Fuuma_Shuriken/M in src)M.overlays-='timer.dmi'
				vdelay1=0
			spawn(80)if(L)del L
		dragonweapon()
			prejutsu()
			if(vdelay4||copydelay4||swim||dead||stun||resting||caught||seals||busy||imitated||paralysed)return
			if(imitation)shadowoff()
			view(8)<<"<b><font color=yellow>[usr]: Twin Dragon Weapon Barrage!"
			if(clan=="Copy Ninja")copydelay4=1
			else	vdelay4=1
			var/sdelay=250
			for(var/obj/jutsu/leaf/Twin_Dragon_Weapon_Barrage/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)
				vdelay4=0
				copydelay4=0
			new/obj/weaponscroll(loc)
			var/B=new/obj/weaponscroll(loc)
			var/C=new/obj/weaponscroll(loc)
			B:icon_state="1"
			C:icon_state="2"
			for(var/obj/weaponscroll/M in loc)
				M.owner=usr
				step(M,dir)
			if(dir==NORTH)
				step(B,WEST)
				step(C,EAST)
			if(dir==SOUTH)
				step(B,WEST)
				step(C,EAST)
			if(dir==EAST)
				step(B,NORTH)
				step(C,SOUTH)
			if(dir==WEST)
				step(B,SOUTH)
				step(C,NORTH)
			for(var/obj/weaponscroll/M in oview(1))if(M.owner==usr)M.dir=dir
			if(Spd<10)
				for(var/obj/weaponscroll/M in world)if(M.owner==usr)M.barrageproc(8)
				goto skip
			if(Spd<15||Tai<15)
				for(var/obj/weaponscroll/M in world)if(M.owner==usr)M.barrageproc(12)
				goto skip
			for(var/obj/weaponscroll/M in world)if(M.owner==usr)M.barrageproc(16)
			skip
			if(clan=="Copy Ninja")tactics()
		constipation()
			prejutsu()
			if(vdelay3||copydelay2||swim||dead||stun||imitated||imitation||resting||caught||seals||busy)return
			for(var/mob/player/M in oview(5))
				if(inchunin!=4)if(village==M.village&&!M.pktoggle&&!pktoggle&&village!="None")continue
				if(vdelay3||copydelay2)return
				handseals(10,5,10)
				if(!sealpass)
					vdelay3=0
					copydelay2=0
					return
				if(clan=="Copy Ninja")copydelay2=1
				else	vdelay3=1
				var/sdelay=250*cdapow/100
				for(var/obj/jutsu/leaf/One_Thousand_Years_of_Death/T in src)timerjutsu(sdelay,T)
				spawn(sdelay)
					vdelay3=0
					copydelay2=0
				view(8)<<"<b><font color=silver>[usr]: Secret Jutsu!"
				stun(8)
				busy="teleport"
				new/obj/smoke(loc)
				var/oldloc=loc
				loc=M.loc
				barloc()
				moving=0
				density=0
				teleport=1
				if(M.dir==NORTH)step(usr,SOUTH)
				if(M.dir==SOUTH)step(usr,NORTH)
				if(M.dir==EAST)step(usr,WEST)
				if(M.dir==WEST)step(usr,EAST)
				dir=M.dir
				new/obj/smoke(loc)
				sleep(2)
				for(var/mob/N in get_step(usr,dir))
					if(N.illusion)
						N.illusionhit(src)
						continue
					view(8)<<"<b><font color=silver>[usr]: One Thousand Years of Death!"
					N.stun=1
					flick("attack",usr)
					var/damage=round(apow*0.5)+wdmg+rand(4,9)
					if(N.clan=="Taijutsu Specialist")
						if(N.tier32)damage*=1-(N.tier32*0.05)
					N.dmgch(src,1)
					damage=(damage*N.variable)+N.variable2
					N.damage(damage)
					N.death(usr)
					N.stepup(4)
					spawn(20)N.stun=0
				sleep(5)
				new/obj/smoke(loc)
				loc=oldloc
				barloc()
				busy=null
				teleport=0
				density=1
				if(clan=="Copy Ninja")tactics()
				break