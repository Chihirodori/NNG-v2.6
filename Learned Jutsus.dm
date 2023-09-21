mob/var/tmp/advtrack=0
mob/var/akatsummondelay=0
mob
	proc
		powered()
			if(powered)
				powered=0
				src<<"<b>You deactivated your powers."
				overhead()
				statset()
			else
				powered=1
				if(village!="Akatsuki")
					if(rank=="Sound Leader")
						src<<"<b>You have now powered.(+15% damage, -10% incoming damage, +100% regeneration)"
					else
						src<<"<b>You have now powered.(+15% damage, -10% incoming damage, -50% chakra cost)"
				else
					src<<"<b>You have now powered.(+15% damage, -15% incoming damage)"
				overhead()
			regenupdate()
		akatsummon()
			prejutsu()
			if(akatsummondelay||rank!="Akatsuki Leader"||dead||caught||hosptime||seals||stun||jailtime||stun||imitated||imitation||busy)return
			akatsummondelay=1
			var/sdelay=1200
			for(var/obj/jutsu/Akatsuki_Summon/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)akatsummondelay=0
			for(var/mob/player/M in world)if(M!=src&&M.village==village&&!M.jailtime&&!M.hosptime&&!M.intourn)spawn()
				view(8)<<"<b>[src]: Summoning Jutsu!"
				switch(alert(M, "[src] is trying to summon you, would you like to be summoned?", "Summoning Jutsu", "Be summoned", "Decline"))
					if("Be summoned")
						if(M)
							M.loc=loc
							new/obj/smoke(M.loc)
							new/obj/smoke(M.loc)
					if("Decline")
						src << "[M] ignored your jutsu."
		advancedtracking()
			prejutsu()
			if(advtrack||dead||caught||hosptime||seals||stun||jailtime||stun||imitated||imitation||busy)return
			if(rank!="ANBU"&&rank!="Hokage"&&rank!="Kazekage"&&rank!="Sound Leader"&&village!="Akatsuki"&&rank!="ANBU Leader")return
			for(var/mob/M in oview(14))if(village!=M.village)
				usr<<"<b>You must be away from danger to use this."
				return
			advtrack=1
			var/list/choose=list()
			if(village!="Akatsuki")for(var/mob/M in world)if(M.village==village&&M.client&&M.level>=3&&!M.jailtime&&!M.inchunin&&!M.GM&&!M.helpraid&&!M.defendraid)choose.Add(M)
			else
				var/base="Home Base"
				choose+=base
				for(var/mob/M in world)if(M.village==village&&M.client)choose.Add(M)
			var/cancel="Cancel"
			choose+=cancel
			var/M=input("Which villager would you like to track?") as null|anything in choose
			if(M=="Cancel")
				advtrack=0
				return
			if(M=="Home Base")
				if(village=="Leaf"&&leafban!="Leaf"||village=="Sand"&&sandban!="Sand"||village=="Sound"&&soundban!="Sound")
					advtrack=0
					src<<"<b>Your bandum is being controlled."
				busy="tracking"
				usr<<"<b>You are now returning to your home base! Do not move for 5 seconds!"
				var/X=loc
				var/Y=hp
				var/g=new/obj/hideanim(loc)
				var/count=10
				while(count)
					sleep(5)
					if(hp<Y||X!=loc)
						busy=null
						advtrack=0
						if(g)del g
						return
					count--
				new/obj/smoke(loc)
				soundeff(pick('puff.wav','puff2.wav','puff3.wav','puff4.wav','puff5.wav'),25,0)
				summonspawn()
				busy=null
				new/obj/smoke(loc)
				for(var/obj/jutsu/Advanced_Tracking/Ma in src)timerjutsu(100,Ma)
				spawn(140)advtrack=0
			else
				busy="tracking"
				usr<<"<b>You are now tracking [M]! Do not move for 5 seconds!"
				var/X=loc
				var/Y=hp
				var/g=new/obj/hideanim(loc)
				var/count=10
				while(count)
					sleep(5)
					if(hp<Y||X!=loc)
						busy=null
						advtrack=0
						if(g)del g
						return
					count--
				new/obj/smoke(loc)
				soundeff(pick('puff.wav','puff2.wav','puff3.wav','puff4.wav','puff5.wav'),25,0)
				if(M)loc=M:loc
				step(src,dir)
				onwater=0
				onsand=0
				for(var/area/A in oview(0,src))A.Entered(src)
				new/obj/smoke(loc)
				soundeff(pick('puff.wav','puff2.wav','puff3.wav','puff4.wav','puff5.wav'),25,0)
				busy=null
				for(var/obj/jutsu/Advanced_Tracking/Ma in src)timerjutsu(700,Ma)
				spawn(700)advtrack=0
		shadowclonejutsu()
			if(swim)return
			prejutsu()
			if(dead||stun||resting||meditating||seals||busy||imitated)return
			if(cloned)
				var/T=0
				for(var/mob/Clone/O in world)if(O.cloneowner==usr)
					T++
					del O
				if(!T)goto cloneless
				cloned=0
				usr<<"You have destroyed your clones."
				return
			cloneless
			if(clonedelay)return
			for(var/turf/T in oview(2))if(T.density)
				usr<<"The space is too cramped to use."
				return
			handseals(20,5,40)
			if(!sealpass)return
			clonedelay=1
			view(8)<<"<b>[usr]: Shadow Clone Jutsu!"
			cloned=1
			stun=1
			spawn(14)stun=0
			new/obj/smoke(loc)
			soundeff(pick('puff.wav','puff2.wav','puff3.wav','puff4.wav','puff5.wav'),25,0)
			var/mob/Clone/shadowclone/K=new(locate(x-2,y,z))
			K.cloneowner=usr
			var/mob/Clone/shadowclone/K2=new(locate(x+2,y,z))
			K2.cloneowner=usr
			if(level>=50)
				var/mob/Clone/shadowclone/K3=new(locate(x,y+2,z))
				K3.cloneowner=usr
				var/mob/Clone/shadowclone/K4=new(locate(x,y-2,z))
				K4.cloneowner=usr
			if(level>=70)
				var/mob/Clone/shadowclone/K5=new(locate(x,y-1,z))
				K5.cloneowner=usr
				var/mob/Clone/shadowclone/K6=new(locate(x,y+1,z))
				K6.cloneowner=usr
			for(var/mob/Clone/shadowclone/M in oview(2))
				if(M.cloneowner==usr)
					M.icon=icon
					M.dir=dir
					M.aff=aff
					M.moving=0
					M.overlays=overlays
					M.animate_movement=2
					M.name=name
					M.village=village
					M.rundelay=2
					M.apow=round(apow/2)
					M.shadowclone()
					var/obj/bars/healthbar/B1=new(M.loc)
					B1.barowner=M
					B1.copy(src)
					M.mybar=B1
					var/obj/bars/chakrabar/B2=new(M.loc)
					B2.barowner=M
					B2.copy(src)
					M.mybar2=B2
			var/sdelay=400*cdpow/100
			for(var/obj/jutsu/Shadow_Clone_Jutsu/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)clonedelay=0
		shurikenclonejutsu()
			prejutsu()
			if(sclonedelay||swim||dead||stun||caught||seals||busy)return
			handseals(10,0,25,1)
			if(!sealpass)return
			sclonedelay=1
			for(var/obj/proj/breakable/Shuriken/M in oview(8))if(M.owner==usr&&!M.newshur)
				var/L=new/obj/proj/breakable/Shuriken(loc)
				L:owner=usr
				L:newshur=1
				var/L2=new/obj/proj/breakable/Shuriken(loc)
				L2:owner=usr
				L2:newshur=1
				if(M.dir==NORTH||M.dir==SOUTH)
					L:loc=locate(M.x-1,M.y,M.z)
					L2:loc=locate(M.x+1,M.y,M.z)
				if(M.dir==EAST||M.dir==WEST)
					L:loc=locate(M.x,M.y+1,M.z)
					L2:loc=locate(M.x,M.y-1,M.z)
				walk(L,M.dir)
				walk(L2,M.dir)
			for(var/obj/proj/ShurikenF/M in oview(8))if(M.owner==usr&&!M.newshur)
				var/L=new/obj/proj/ShurikenF(loc)
				L:owner=usr
				L:newshur=1
				var/L2=new/obj/proj/ShurikenF(loc)
				L2:owner=usr
				L2:newshur=1
				if(M.dir==NORTH||M.dir==SOUTH)
					L:loc=locate(M.x-1,M.y,M.z)
					L2:loc=locate(M.x+1,M.y,M.z)
				if(M.dir==EAST||M.dir==WEST)
					L:loc=locate(M.x,M.y+1,M.z)
					L2:loc=locate(M.x,M.y-1,M.z)
				walk(L,M.dir)
				walk(L2,M.dir)
			var/sdelay=100*cdpow/100
			for(var/obj/jutsu/Shuriken_Clone_Jutsu/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)sclonedelay=0
		rasengan()
			if(busy=="rasengan")
				view(8)<<"<font color=aqua><b>[usr]: Rasengan!"
				busy="rasenganhit"
				stun=1
				stepup(4)
				spawn(4)
					stun=0
					busy=null
					overlays-=/obj/rasengan
				return
			prejutsu()
			if(rasengandelay||copydelay4||swim||dead||stun||caught||seals||busy)return
			handseals(120,0,90,1)
			if(!sealpass)return
			if(clan=="Copy Ninja")copydelay4=1
			else	rasengandelay=1
			stun=1
			busy="stun"
			var/ltime=60
			if(con<100)
				dir=SOUTH
				var/obj/rasenclone1/a=new(loc)
				var/obj/rasenclone2/aa=new(loc)
				a.overlays=overlays
				aa.icon=icon
				a.icon=icon
				aa.overlays=overlays
				overlays+=/obj/rasengan
				sleep(10)
				del a
				del aa
				goto skip
			else
				ltime=60
				overlays+=/obj/rasengan
				goto skip
			skip
			stun=0
			busy="rasengan"
			sleep(ltime)
			overlays-=/obj/rasengan
			if(busy=="rasengan")
				overlays-=/obj/rasengan
				busy=null
				src<<"<b>You lost control of your Rasengan!"
			var/sdelay=600*cdpow/100
			for(var/obj/jutsu/Rasengan/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)
				rasengandelay=0
				copydelay4=0
			if(clan=="Copy Ninja")tactics()