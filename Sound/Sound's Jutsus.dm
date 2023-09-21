mob
	var
		curseseal=0
		cursedelay=0
		curselevel=0

	proc

		curseseal()
			prejutsu()
			if(curseseal)
				range(12)<<"<b><font color='#990099'>[src]'s curse seal deactivated!"
				curseseal=0
				return
			if(cursedelay||swim||dead||stun||resting||caught||seals||busy)return
			cursedelay=1
			for(var/obj/jutsu/sound/Curse_Seal/M in src)M.overlays+='timer.dmi'
			curseseal=2
			range(12)<<"<b><font color='#990099'>[src]'s curse seal activated."
			overlay()
			spawn(2520)
				for(var/obj/jutsu/sound/Curse_Seal/M in src)M.overlays-='timer.dmi'
				cursedelay=0

		massacresnakes()

		deathviewing()
			prejutsu()
			if(vdelay2||swim||dead||stun||resting||caught||seals||busy||imitated||paralysed)return
			handseals(25,10)
			if(!sealpass)return
			vdelay2=1
			for(var/obj/jutsu/sound/Death_Viewing_Technique/M in src)M.overlays+='timer.dmi'
			stun=1
			icon_state="jutsu"
			busy="stun"
			new/obj/proj/Death_Viewing(loc)
			var/obj/L2=new/obj/proj/Death_Viewing(loc)
			var/obj/L3=new/obj/proj/Death_Viewing(loc)
			if(dir==NORTH||dir==SOUTH)
				L2.loc=locate(x+1,y,z)
				L3.loc=locate(x-1,y,z)
			if(dir==EAST||dir==WEST)
				L2.loc=locate(x,y-1,z)
				L3.loc=locate(x,y+1,z)
			for(var/obj/proj/Death_Viewing/M in view(1))
				M.dir=dir
				M.owner=usr
				walk(M,dir)
			var/sdelay=600
			if(curseseal==2)sdelay=sdelay/1.5
			if(curseseal==3)sdelay=sdelay/2
			spawn(sdelay*(cdpow/100))
				for(var/obj/jutsu/sound/Death_Viewing_Technique/M in src)M.overlays-='timer.dmi'
				vdelay2=0
			spawn(34)
				busy=null
				icon_state=""
				stun=0
		shurikenbarrage()
			prejutsu()
			if(vdelay3||swim||dead||stun||resting||caught||seals||busy||imitated||paralysed)return
			vdelay3=1
			var/F=0
			var/T=3
			loop
				F++
				var/obj/L=new/obj/proj/breakable/Shuriken(loc)
				L.owner=usr
				var/obj/L2=new/obj/proj/breakable/Shuriken(loc)
				L2.owner=usr
				var/obj/L3=new/obj/proj/breakable/Shuriken(loc)
				L3.owner=usr
				var/obj/L4=new/obj/proj/breakable/Shuriken(loc)
				L4.owner=usr
				var/obj/L5=new/obj/proj/breakable/Shuriken(loc)
				L5.owner=usr
				if(dir==NORTH||dir==SOUTH)
					L2.x++
					L3.x+=2
					L4.x--
					L5.x-=2
				if(dir==EAST||dir==WEST)
					L2.y++
					L3.y+=2
					L4.y--
					L5.y-=2
				walk(L,dir)
				walk(L2,dir)
				walk(L3,dir)
				walk(L4,dir)
				walk(L5,dir)
				if(F<T)spawn(2)goto loop
			spawn(150)
				for(var/obj/jutsu/sound/Shuriken_Barrage/M in src)M.overlays-='timer.dmi'
				vdelay3=0
		rashoumon()
			prejutsu()
			if(vdelay4||swim||dead||stun||caught||seals||busy||imitated||paralysed)return
			handseals(40,80)
			if(!sealpass)return
			vdelay4=1
			for(var/obj/jutsu/sound/Rashoumon/M in src)M.overlays+='timer.dmi'
			view(8)<<"<b><font color=silver>[usr]: Rashoumon!"
			var/obj/rashoumon/A=new(loc)
			step(A,usr.dir)
			if(A.dir==NORTH)A.layer=3
			var/obj/A1=new/obj/proj/rashoumonshield(loc)
			var/obj/A2=new/obj/proj/rashoumonshield(loc)
			var/obj/A3=new/obj/proj/rashoumonshield(loc)
			for(var/obj/proj/rashoumonshield/M in loc)M.owner=usr
			if(dir==NORTH||dir==SOUTH)
				A2.loc=locate(x+1,y,z)
				A3.loc=locate(x-1,y,z)
			if(dir==EAST||dir==WEST)
				A2.loc=locate(x,y+1,z)
				A3.loc=locate(x,y-1,z)
			for(var/obj/proj/rashoumonshield/M in oview(2))if(M.owner==usr)step(M,dir)
			spawn(150)
				if(A)del A
				if(A1)del A1
				if(A2)del A2
				if(A3)del A3
			var/sdelay=600
			//if(skillspeedplus&&!skilldelayhalf)sdelay=(sdelay*0.8)
			//if(skilldelayhalf)sdelay=(sdelay/2)
			spawn(sdelay*(cdpow/100))
				for(var/obj/jutsu/sound/Rashoumon/M in src)M.overlays-='timer.dmi'
				vdelay4=0