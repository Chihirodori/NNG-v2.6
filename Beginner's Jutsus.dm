mob/var/tmp/transbusy=0
mob/var/tmp/transdelay=0
mob/var/tmp/cloneused=0
mob/var/tmp/transused=0
mob
	proc
		transformation()
			if(henge&&!transbusy)
				hengeback()
				return
			if(transdelay||transbusy||dead||resting||swim||stun||imitated||imitation||caught||seals||busy)return
			prejutsu()
			handseals(5,5,35)
			if(!sealpass)return
			transdelay=1
			for(var/obj/jutsu/Transformation/M in src)timerjutsu(60,M)
			spawn(60)transdelay=0
			transbusy=1
			var/list/choose = list()
			for(var/mob/M in oview(12))if(M.client||!M.npc==2||M.name=="Iruka")choose.Add(M)
			for(var/obj/deadbody/M in oview(12))choose.Add(M)
			var/list/inanim=list("Tree","Cactus","Dummy","Scarecrow","Banner")
			var/cancel="Cancel"
			choose+=cancel
			choose+=inanim
			var/mob/M=input("Who do you want to use this jutsu on?","") as null|anything in choose
			transused=1
			spawn(14)transbusy=0
			if(M=="Tree")
				var/F=new/obj/smoke(loc)
				F:layer=85
				henge=1
				savedoverlays=overlays.Copy()
				icon=null
				soundeff(pick('puff.wav','puff2.wav','puff3.wav','puff4.wav','puff5.wav'),25,0)
				overlays=null
				overlays+=/obj/Tree/tree
				name="Tree"
				return
			if(M=="Banner")
				var/F=new/obj/smoke(loc)
				F:layer=85
				henge=1
				soundeff(pick('puff.wav','puff2.wav','puff3.wav','puff4.wav','puff5.wav'),25,0)
				savedoverlays=overlays.Copy()
				icon=null
				overlays=null
				if(village=="Leaf")icon_state="Leaf"
				if(village=="Sand")icon_state="Sand"
				if(village=="Sound")icon_state="Sound"
				if(village=="None")icon_state=""
				if(village=="Akatsuki")icon_state="Akatsuki"
				overlays+=/obj/Flag
				name="Banner"
				return
			if(M=="Cactus")
				var/F=new/obj/smoke(loc)
				F:layer=85
				henge=1
				soundeff(pick('puff.wav','puff2.wav','puff3.wav','puff4.wav','puff5.wav'),25,0)
				savedoverlays=overlays.Copy()
				icon=null
				overlays=null
				overlays+=/obj/Cactus
				name="Cactus"
				return
			if(M=="Dummy")
				var/F=new/obj/smoke(loc)
				F:layer=85
				henge=1
				soundeff(pick('puff.wav','puff2.wav','puff3.wav','puff4.wav','puff5.wav'),25,0)
				savedoverlays=overlays.Copy()
				icon=null
				overlays=null
				overlays+=/obj/dummy
				name="Dummy"
				return
			if(M=="Scarecrow")
				var/F=new/obj/smoke(loc)
				F:layer=85
				henge=1
				soundeff(pick('puff.wav','puff2.wav','puff3.wav','puff4.wav','puff5.wav'),25,0)
				savedoverlays=overlays.Copy()
				icon=null
				overlays=null
				overlays+=/obj/Scarecrow
				name="Scarecrow"
				return
			else
				var/O=0
				for(var/mob/G in oview(8))if(G==M)O=1
				for(var/obj/deadbody/G in oview(8))if(G==M)O=1
				spawn(14)transbusy=0
				if(M&&O)
					new/obj/smoke(loc)
					henge=1
					soundeff(pick('puff.wav','puff2.wav','puff3.wav','puff4.wav','puff5.wav'),25,0)
					savedoverlays=overlays.Copy()
					icon=M.icon
					//icon_state=M.icon_state
					overlays=M.overlays
					name=M.name
					if(ismob(M))
						tmpvillage=M.village
						tmpstatus=M.status
						tmprank=M.rank
						tmpclan=M.clan
					mouseovername()
					if(intut==12)
						tj1=1
						if(tj1&&tj2&&tj3&&tj4)intut=13
		bodyflickertechnique()
			prejutsu()
			if(clan=="Sand"&&cdelay1||flicked||snared||critcon||resting||freeze||dead||caught||seals||stun||swim||imitated||imitation||busy)return
			handseals(5,0,20,1)
			if(!sealpass)return
			flicked=1
			intense--
			if(clan=="Yuki"&&tier52)
				fast=1
				new/obj/icetele(loc)
				step(src,dir)
				step(src,dir)
				step(src,dir)
				step(src,dir)
				fast=0
				if(prob(1+tier52*33))
					quickwave(1)
			else
				new/obj/flashstep(loc)
				fast=1
				step(src,dir)
				step(src,dir)
				step(src,dir)
				step(src,dir)
				fast=0
			var/sdelay=200*cdpow/100
			for(var/obj/jutsu/Body_Flicker_Technique/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)flicked=0
		substitution()
			prejutsu()
			if(clan=="Sand"&&cdelay1||numb||substitution||dead||caught||seals||stun||imitated||imitation||busy)return
			handseals(10,5,20,1)
			if(!sealpass)return
			substitution=1
			stun=0
			freeze=0
			snared=0
			sandstormslow=0
			for(var/obj/wirebind/M in loc)del M
			new/obj/log(loc)
			soundeff('substitution.wav',30,01)
			invisibility=10
			stepback(5)
			subinvis=1
			spawn(4)
				subinvis=0
				invisibility=1
			var/sdelay=500*cdpow/100
			for(var/obj/jutsu/Mastered_Substitution/M in src)timerjutsu(sdelay,M)
			for(var/obj/jutsu/Substitution/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)substitution=0
		substitutionmast()
			prejutsu()
			if(clan=="Sand"&&cdelay1||substitution||dead||caught||seals||numb||stun||imitated||imitation||busy)return
			substitution=1
			stun=0
			freeze=0
			snared=0
			sandstormslow=0
			new/obj/smoke(loc)
			soundeff(pick('puff.wav','puff2.wav','puff3.wav','puff4.wav','puff5.wav'),25,0)
			var/t=new/obj/log(loc)
			t:invisibility=50
			stepback(5)
			invisibility=10
			subinvis=1
			spawn(21)
				subinvis=0
				invisibility=1
			var/sdelay=400*cdpow/100
			for(var/obj/jutsu/Mastered_Substitution/M in src)timerjutsu(sdelay,M)
			for(var/obj/jutsu/Substitution/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)substitution=0
		clonejutsu()
			if(swim)return
			prejutsu()
			if(dead||stun||imitated||resting||caught||seals||clonedelay2)return
			handseals(5,5,15)
			if(!sealpass)return
			clonedelay2=1
			if(intut==12)
				tj4=1
				if(tj1&&tj2&&tj3&&tj4)intut=13
			var/mob/Clone/clone/K=new(loc)
			cloneused=1
			K.cloneowner=usr
			K.icon=icon
			K.dir=dir
			K.overlays=overlays
			K.village=village
			K.name=name
			var/obj/bars/healthbar/B1=new(K.loc)
			B1.barowner=K
			B1.copy(src)
			var/obj/bars/chakrabar/B2=new(K.loc)
			B2.barowner=K
			B2.copy(src)
			walk(K,dir,1)
			walk(B2,dir,1)
			walk(B1,dir,1)
			invisibility+=3
			var/image/I=image('baseinvis.dmi',src)
			src<<I
			barloc()
			spawn(14)
				invisibility-=3
				if(B1)del B1
				if(B2)del B2
				if(I)del I
				barloc()
				new/obj/smoke(loc)
				soundeff(pick('puff.wav','puff2.wav','puff3.wav','puff4.wav','puff5.wav'),25,0)
				if(K)del K
			for(var/obj/jutsu/Clone_Jutsu/M in client.screen)timerjutsu(420,M)
			spawn(420)
				clonedelay2=0
mob/proc
	timerjutsu(var/ttime,var/obj/M)
		var/obj/I=new/obj/timershade(src)
		client.screen+=I
		I.screen_loc=M.screen_loc
		I.icon_state="1"
		var/Y=round(ttime/28,1)
		var/G=ttime/28
		var/F
		if(G>Y)F=(G-Y)*28
		else F=(G-Y)*28
		var/Z=1
		loop
			if(F<0&&Z==14)
				spawn(Y+F)
					Z++
					if(I)I.icon_state="[Z]"
					goto loop
			else
				spawn(Y)
					Z++
					if(I)I.icon_state="[Z]"
					if(Z<28)
						if(Z==14&&F>0)
							spawn(F)
							goto loop
						else
							goto loop
					else
						if(I)del I
obj/timershade
	icon='timer.dmi'
	layer=96
obj/treeo
	layer=30
	icon='treetr.dmi'
	t1
		icon_state="1"
		pixel_x=-32
		layer=14
	t2
		layer=14
		icon_state="2"
	t3
		layer=14
		icon_state="3"
		pixel_x=32
	t4
		icon_state="4"
		pixel_x=-32
		pixel_y=32
	t5
		icon_state="5"
		pixel_y=32
	t6
		icon_state="6"
		pixel_x=32
		pixel_y=32
	t7
		icon_state="7"
		pixel_x=-32
		pixel_y=64
	t8
		icon_state="8"
		pixel_y=64
	t9
		icon_state="9"
		pixel_x=32
		pixel_y=64
	t10
		icon_state="10"
		pixel_x=-32
		pixel_y=96
	t11
		icon_state="11"
		pixel_y=96
	t12
		icon_state="12"
		pixel_x=32
		pixel_y=96
	t13
		icon_state="13"
		pixel_x=-32
		pixel_y=128
	t14
		icon_state="14"
		pixel_y=128
	t15
		icon_state="15"
		pixel_x=32
		pixel_y=128