mob/var
	goldsand=0

mob/proc
	ironleveling()
		if(level==2)
			src<<"<b><font color=cyan>You coat your throwing weapons and melee weapon with lethal poison, damaging the enemy for 5 seconds. Can stack up to 4 times. Any new applications of this debuff resets the timer."
			src<<"<b><font color=cyan>You have learned Iron Sand Spike. You form iron sand into a deadly spike, impaling the enemy and inflicting a stack of poison debuff. Automatically tracks the closest magnetised target."
			new/obj/jutsu/iron/Iron_Sand_Spike(src)
		if(level==6)
			src<<"<b><font color=cyan>You have learned Scattered Showers. Fires a wave of iron particles, magnetising the enemy and putting 2 stacks of poison on the enemy."
			new/obj/jutsu/iron/Scattered_Showers(src)
		if(level==10)
			src<<"<b><font color=cyan>You have learned Toxic Shock. Stimulate the poison in enemies bodies, causing 0.35*power damage and slowing them for 0.5 second for each stack of poison in their body. Clears poison stacks on affected targets and make them immune to poison for the next 5 seconds."
			new/obj/jutsu/iron/Toxic_Shock(src)
		if(level==15)
			src<<"<b><font color=cyan>You have learned Iron Sand Gathering. Fires a huge triangular block of iron, dealing 1.8*power damage."
			new/obj/jutsu/iron/Iron_Sand_Gathering(src)
		if(level==24)
			src<<"<b><font color=cyan>You have learned Iron Sand Rain. Create a cloud of iron sand around you for 5 seconds, slowing down, dealing 0.1*power damage, magnetising and putting a stack of poison on them for every 0.5 second they are in the cloud."
			new/obj/jutsu/iron/Iron_Sand_Rain(src)
		if(level==32)
			src<<"<b><font color=cyan>You have learned Iron Sand Unleash. After a short delay, many spikes rise from the ground in a massive area around you. These spikes last 8 seconds and passing through the spikes will stun the enemy briefly and causing five stacks of poison."
			new/obj/jutsu/iron/Iron_Sand_Unleash(src)
		if(level==45)
			src<<"<b><font color=cyan>You have learned Magnet Release: Golden Sand. For the next 12 seconds, your iron sand becomes gold, dealing 40% increased damage. Your throwing weapons deal double damage and use power in its damage formula. Your poison also stacks twice as fast and you can have up to 8 stacks of poison while this ability is active."
			new/obj/jutsu/iron/Golden_Sand(src)
		if(level==55)
			src<<"<b><font color=cyan>You have learned Iron Sand Cluster. Spikes grow on the ground in a circle, impaling anyone hit for 1*power damage and putting 2 stacks of poison on the enemy. The spikes last for 1.5 second, trapping anyone inside. A huge metal block falls from the sky after, crushing everyone in the area for 1.2*power damage."
			new/obj/jutsu/iron/Iron_Sand_Cluster(src)
	ironcluster()
		prejutsu()
		if(cdelay6||swim||dead||stun||resting||caught||seals||busy||imitated||paralysed)return
		handseals(80,5,65)
		if(!sealpass)return
		cdelay6=1
		var/sdelay=400*cdpow/100
		for(var/obj/jutsu/iron/Iron_Sand_Cluster/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay6=0
		stun=1
		icon_state="jutsu"
		if(goldsand)
			var/obj/V=new/obj/goldworldc(loc)
			V.owner=src
			step(V,dir)
			step(V,dir)
			step(V,dir)
		else
			var/obj/V=new/obj/ironworldc(loc)
			V.owner=src
			step(V,dir)
			step(V,dir)
			step(V,dir)
		spawn(5)
			stun=0
			icon_state=0
	goldensand()
		prejutsu()
		if(wpalming||swim||dead||stun||caught||seals||busy||imitated||paralysed)return
		view(10)<<"<b><center>[src] released golden dust!"
		wpalming=1
		var/sdelay=900*cdpow/100
		for(var/obj/jutsu/iron/Golden_Sand/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)wpalming=0
		goldsand=1
		atkdef()
		for(var/obj/jutsu/iron/Iron_Sand_Spike/M in src)M.icon_state="gold spike"
		for(var/obj/jutsu/iron/Toxic_Shock/M in src)M.icon_state="gold shock"
		for(var/obj/jutsu/iron/Iron_Sand_Gathering/M in src)M.icon_state="gold gathering"
		for(var/obj/jutsu/iron/Iron_Sand_Rain/M in src)M.icon_state="gold rain"
		for(var/obj/jutsu/iron/Iron_Sand_Unleash/M in src)M.icon_state="gold world"
		for(var/obj/jutsu/iron/Iron_Sand_Cluster/M in src)M.icon_state="gold cluster"
		for(var/obj/jutsu/iron/Scattered_Showers/M in src)M.icon_state="gold shower"
		spawn(168+tier41*21)
			goldsand=0
			atkdef()
			for(var/obj/jutsu/iron/Iron_Sand_Spike/M in src)M.icon_state="iron spike"
			for(var/obj/jutsu/iron/Toxic_Shock/M in src)M.icon_state="toxic shock"
			for(var/obj/jutsu/iron/Iron_Sand_Gathering/M in src)M.icon_state="iron gathering"
			for(var/obj/jutsu/iron/Iron_Sand_Rain/M in src)M.icon_state="iron rain"
			for(var/obj/jutsu/iron/Iron_Sand_Unleash/M in src)M.icon_state="iron world"
			for(var/obj/jutsu/iron/Iron_Sand_Cluster/M in src)M.icon_state="iron cluster"
			for(var/obj/jutsu/iron/Scattered_Showers/M in src)M.icon_state="iron shower"
	irongathering()
		prejutsu()
		if(amatcd||swim||dead||stun||resting||caught||seals||busy||imitated||paralysed)return
		handseals(60,15,50)
		if(!sealpass)return
		amatcd=1
		var/sdelay=400*cdpow/100
		for(var/obj/jutsu/iron/Iron_Sand_Gathering/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)amatcd=0
		stun=1
		icon_state="jutsu"
		sleep(2)
		spawn(8)
			stun=0
			icon_state=""
		if(!goldsand)
			var/obj/L=new/obj/irontriangle(loc)
			L.owner=usr
			walk(L,dir)
		else
			var/obj/L=new/obj/goldtriangle(loc)
			L.owner=usr
			walk(L,dir)
	toxicshock()
		prejutsu()
		if(cdelay3||swim||dead||caught||seals||stun||imitated||paralysed)return
		var/T=0
		for(var/mob/M in oview(10))if(M.poisonstack)T=1
		if(!T)return
		handseals(30,10,30)
		if(!sealpass)return
		cdelay3=1
		var/sdelay=350*cdpow/100
		if(tier43)sdelay*=1-tier42*0.1
		spawn(sdelay)cdelay3=0
		for(var/obj/jutsu/iron/Toxic_Shock/M in src)timerjutsu(sdelay,M)
		for(var/mob/M in oview(10))
			if(aff==M.aff)continue
			if(M.poisonstack)
				var/damage=round(pow*0.25*M.poisonstack)
				M.dmgch(src)
				new/obj/toxic(M.loc)
				damage=(damage*M.variable)+M.variable2
				M.damage(damage)
			//	M.stun(M.poisonstack)
				M.snared(M.poisonstack*5,2)
				if(tier52)M.numb(15*tier52)
				if(tier31)M.silenced(tier31*7)
				M.death(src)
	ironunleash()
		prejutsu()
		if(cdelay5||seals||swim||dead||resting||stun||busy||moving||imitated||paralysed)return
		handseals(80,20-6*tier62,75)
		if(!sealpass)return
		cdelay5=1
		var/sdelay=600*cdpow/100
		spawn(sdelay)cdelay5=0
		for(var/obj/jutsu/iron/Iron_Sand_Unleash/M in src)timerjutsu(sdelay,M)
		icon_state="trigram"
		freeze=1
		sleep(15-4*tier62)
		freeze=0
		icon_state=""
		var/createx=-8
		var/createy=-8
		while(createy<=8)
			if(createx>8)
				createx=-8
				createy++
			if(prob(30))
				for(var/obj/G in locate(x+createx,y+createy,z))
					if(G:density)
						createx++
						if(createx==0&&createy==0)createx++
						continue
				if(goldsand)
					var/obj/V=new/obj/goldworld(locate(x+createx,y+createy,z))
					V.owner=src
					for(var/mob/M in V.loc)
						if(aff==M.aff)break
						M.poisoned(src,5)
						M.stun(10)
						M.snared(20,2)
				else
					var/obj/V=new/obj/ironworld(locate(x+createx,y+createy,z))
					V.owner=src
					for(var/mob/M in V.loc)
						if(aff==M.aff)break
						M.poisoned(src,5)
						M.stun(6)
						M.snared(20,2)
			createx++
			if(createx==0&&createy==0)createx++
	ironregen()
		while(rainingmen&&!dead)
			if(hp<maxhp)
				hp+=round((maxhp-hp)*0.005*tier33)
				new/obj/heal(loc)
			sleep(10)
	irondeath()
		while(rainingmen&&!dead)
			hp-=hp/100
			mybar:updatebar()
			sleep(10)
	ironrain()
		if(kyuubimode)
			src<<"<center>Kyuubi locks the usage of this jutsu with his dark power."
			return
		prejutsu()
		if(cdelay4||freeze||seals||swim||dead||resting||stun||busy||moving||imitated||paralysed)return
		handseals(60,15)
		if(!sealpass)return
		cdelay4=1
		var/sdelay=600*cdpow/100
		spawn(sdelay)cdelay4=0
		for(var/obj/jutsu/iron/Iron_Sand_Rain/M in src)timerjutsu(sdelay,M)
		rainingmen=1
		atkdef()
		if(tier33)spawn()ironregen()
		if(tier42)spawn()irondeath()
		spawn(70)
			rainingmen=0
			atkdef()
		var/tmp/createx=-3
		var/tmp/createy=-3
		while(createy<=3)
			if(createx>3)
				createx=-3
				createy++
			if(goldsand)
				var/obj/V=new/obj/goldrain(locate(x+createx,y+createy,z))
				V.owner=src
				V.xfire=createx
				V.yfire=createy
				V.ironstay(src)
			else
				var/obj/V=new/obj/ironrain(locate(x+createx,y+createy,z))
				V.owner=src
				V.xfire=createx
				V.yfire=createy
				V.ironstay(src)
			createx++
	ironshower()
		prejutsu()
		if(cdelay2||swim||seals||dead||resting||stun||busy||moving||imitated||paralysed)return
		handseals(30,5,0)
		if(!sealpass)return
		cdelay2=1
		var/sdelay=40*cdpow/100
		spawn(sdelay)cdelay2=0
		for(var/obj/jutsu/iron/Scattered_Showers/M in src)timerjutsu(sdelay,M)
		flick("attack",usr)
		new/obj/ironshower(loc)
		var/obj/L2=new/obj/ironshower(loc)
		var/obj/L3=new/obj/ironshower(loc)
		L2.icon_state="1"
		L3.icon_state="2"
		if(dir==NORTH||dir==SOUTH)
			L2.loc=locate(x+1,y,z)
			L3.loc=locate(x-1,y,z)
		if(dir==EAST||dir==WEST)
			L2.loc=locate(x,y-1,z)
			L3.loc=locate(x,y+1,z)
		for(var/obj/ironshower/M in view(2))if(!M.owner)
			M.dir=dir
			M.owner=usr
			if(goldsand)
				M.icon='goldshower.dmi'
			if(tier21)
				M.icon='ironshards.dmi'
				M:shard=1
				if(goldsand)
					M:shard=2
					M.icon='goldshards.dmi'
			walk(M,dir)
	ironspike()
		prejutsu()
		if(cdelay1||swim||dead||resting||stun||seals||busy||freeze||moving||imitated||paralysed)return
		handseals(40,5,20)
		if(!sealpass)return
		cdelay1=1
		var/sdelay=150*cdpow/100
		for(var/obj/jutsu/iron/Iron_Sand_Spike/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay1=0
		flick("attack",src)
		if(level>=100)
			if(goldsand)
				var/obj/L=new/obj/goldbigironspear(loc)
				var/obj/L2=new/obj/gspeardamage(loc)
				var/obj/L3=new/obj/gspeardamage(loc)
				L.owner=src
				L2.owner=src
				L3.owner=src
				L.dir=dir
				L2.dir=dir
				L3.dir=dir
				if(dir==NORTH||dir==SOUTH)
					L.pixel_x-=52
					L2.x--
					L3.x++
				if(dir==EAST||dir==WEST)
					L2.y--
					L3.y++
				walk(L,dir)
				walk(L2,dir)
				walk(L3,dir)
			else
				var/obj/L=new/obj/bigironspear(loc)
				var/obj/L2=new/obj/speardamage(loc)
				var/obj/L3=new/obj/speardamage(loc)
				L.owner=src
				L2.owner=src
				L3.owner=src
				L.dir=dir
				L2.dir=dir
				L3.dir=dir
				if(dir==NORTH||dir==SOUTH)
					L.pixel_x-=52
					L2.x--
					L3.x++
				if(dir==EAST||dir==WEST)
					L2.y--
					L3.y++
				walk(L,dir)
				walk(L2,dir)
				walk(L3,dir)
			return
		if(goldsand)
			var/obj/L=new/obj/goldspear(loc)
			L.owner=src
			L.dir=dir
			step(L,dir)
			if(L)
				var/obj/L2=new/obj/goldspear/tail(loc)
				L2.owner=src
				L2.dir=dir
				L:t=L2
				walk(L,dir,1)
				walk(L2,dir,1)
				spawn(1)if(L)L:aim()
		else
			var/obj/L=new/obj/ironspear(loc)
			L.owner=src
			L.dir=dir
			step(L,dir)
			if(L)
				var/obj/L2=new/obj/ironspear/tail(loc)
				L2.owner=src
				L2.dir=dir
				L:t=L2
				walk(L,dir,1)
				walk(L2,dir,1)
				spawn(1)if(L)L:aim()
	corrupt(var/mob/M)
		if(!corrupt)
			corrupt = 1
			M.poisoned(src, 5)
			cha += M.maxcha * 0.08
			new/obj/curse(M.loc)
			M.soundeff('substitution.wav', 40, 0)
			M.cha -= M.maxcha * 0.08
			if(M.cha < 0)
				M.cha = 0
			if(cha > maxcha)
				cha = maxcha
			if(mybar2)
				mybar2:updatebar()
			if(M.mybar2)
				M.mybar2:updatebar()
			sleep(550 - tier61 * 150)
			corrupt = 0
			src<< "<center>Your corruption is ready."

	magnet()
		mag ++
		if(mag == 1)
			magov()
		spawn(50)
			mag --
			if(mag == 0)
				magov()

	poisoned(mob/M,var/stacks=1)
		if(!M)return
		if(aff==M.aff||M.shield)return
		if(M.tier61&&!M.corrupt)spawn()M.corrupt(src)
		poisonstack+=stacks
		if(poisonstack>5)poisonstack=5
		poisonov()
		if(poisontime<=0)
			poisonproc(M)
		poisontime=5
	hardhit()
		hardhit=1
		spawn(5)
			hardhit=0
	numb(var/F)
		numb++
		if(numb==1)ovcheck()
		spawn(F)
			numb--
			if(numb==0)
				ovcheck()
	poisonproc(mob/M)
		spawn(14)
			if(!M)
				poisontime=0
				poisonstack=0
			else
				var/damage=M.pow*0.02*poisonstack
				if(M.tier13)damage*=1+0.2*M.tier13
				if(damage<1)damage=1
				M.criticalroll=0
				if(M.tier22)
					M.critroll(src)
					var/random=rand(1,100-M.tier22*10)
					if(M.criticalroll>=random)
						damage(damage,1.5)
					else damage(damage)
				else damage(damage)
				new/obj/statuspop/poison(loc)
				death(M)
				poisontime--
				if(poisontime>0)
					poisonproc(M)
				else
					poisonstack=0
					poisontime=0
					poisonov()
	neuropoisoned(mob/M)
		if(!M)return
		if(aff==M.aff)return
		if(neuropoison<=0)
			neuropoisonproc(M)
		neuropoison=5
	neuropoisonproc(mob/M)
		spawn(14)
			if(!M)
				neuropoison=0
			else
				var/damage=M.maxhp/100
				if(damage<1)damage=1
				damage(damage,0,1,M)
				new/obj/statuspop/poison(loc)
				death(M)
				neuropoison--
				if(neuropoison>0)
					neuropoisonproc(M)
				else
					neuropoison=0
obj/var
	tmp/xfire=0
	tmp/yfire=0
obj/proc
	ironstay(var/mob/M)
		loop
			if(M.rainingmen)
				loc=locate(M.x+xfire,M.y+yfire,M.z)
				spawn(3)goto loop
mob/var
	neuropoison=0
	poisontime=0
	poisonstack=0
	rainingmen=0
	hardhit=0
	numb=0
	corrupt=0
obj
	bigironspear
		icon='big iron spear.dmi'
		layer=40
		density=1
		pixel_y=-48
		projint=3
		New()
			..()
			spawn(30)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				D.poisonproc(O)
				projectilep(O,D,O.pow*0.9*(1+0.05*O.tier11))
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)
	speardamage
		density=1
		projint=3
		New()
			..()
			spawn(30)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				D.poisonproc(O)
				projectilep(O,D,O.pow*0.9*(1+0.05*O.tier11))
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)
	goldbigironspear
		icon='big iron spear.dmi'
		icon_state="gold"
		layer=40
		density=1
		pixel_y=-48
		projint=3
		New()
			..()
			spawn(30)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				D.poisonproc(O)
				projectilep(O,D,O.pow*1.3*(1+0.05*O.tier11))
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)
	gspeardamage
		density=1
		projint=3
		New()
			..()
			spawn(30)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				D.poisonproc(O)
				projectilep(O,D,O.pow*1.3*(1+0.05*O.tier11))
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)
	irontriangle
		icon='irongathering.dmi'
		icon_state="middle"
		layer=40
		density=1
		pixel_y=-36
		pixel_x=-32
		projint=3
		New()
			..()
			flick("iron",src)
			spawn(7)freeze=1
			spawn(30)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/M=A
				loc=M.loc
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)
		Move()
			..()
			if(!owner)del src
			if(!freeze)
				for(var/mob/M in range(src,1))
					var/mob/O=owner
					var/mob/D=M
					if(D.hardhit)continue
					if(O.aff==D.aff)continue
					D.magnet()
					D.hardhit()
					D.soundeff('mountain.wav',40,0)
					D.poisoned(O)
					var/damage=O.pow*0.7
					var/extradmg=O.cha*0.2
					O.cha-=extradmg
					O.mybar2:updatebar()
					damage+=extradmg*2
					if(O.tier11)damage*=1+0.05*O.tier11
					if(O.tier51)
						D.snared(14*O.tier51,3)
						damage*=1+0.05*O.tier51
					D.dmgch(O)
					damage=(damage*D.variable)+D.variable2
					D.damage(damage)
					D.death(O)
	ironworld
		name="Iron World"
		icon='ironworld.dmi'
		layer=40
		var/fa=1
		Crossed(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(O.aff==D.aff)return
				D.magnet()
				D.poisoned(O,5)
				D.stun(5)
				D.snared(20,2)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					T.loc=loc
		New()
			..()
			spawn(120)del src
			fa="[rand(1,8)]"
			icon_state="[fa]"
			flick("[fa]a",src)
			spawn(112)
				flick("[fa]b",src)
				icon_state=""
				spawn(5)
					del src
	ironworldc
		New()
			..()
			spawn(1)
				var/obj/F=new/obj/cluster1(locate(x-2,y-1,z))
				F.owner=owner
				var/obj/F1=new/obj/cluster1(locate(x-2,y,z))
				F1.owner=owner
				var/obj/F2=new/obj/cluster1(locate(x-2,y+1,z))
				F2.owner=owner
				var/obj/F3=new/obj/cluster1(locate(x-1,y+2,z))
				F3.owner=owner
				var/obj/F4=new/obj/cluster1(locate(x-1,y-2,z))
				F4.owner=owner
				F4.layer=42
				var/obj/F5=new/obj/cluster1(locate(x,y+2,z))
				F5.owner=owner
				var/obj/F6=new/obj/cluster1(locate(x,y-2,z))
				F6.owner=owner
				F6.layer=42
				var/obj/F7=new/obj/cluster1(locate(x+1,y+2,z))
				F7.owner=owner
				var/obj/F8=new/obj/cluster1(locate(x+1,y-2,z))
				F8.owner=owner
				F8.layer=42
				var/obj/F9=new/obj/cluster1(locate(x+2,y,z))
				F9.owner=owner
				var/obj/F10=new/obj/cluster1(locate(x+2,y+1,z))
				F10.owner=owner
				var/obj/F11=new/obj/cluster1(locate(x+2,y-1,z))
				F11.owner=owner
				var/obj/F12=new/obj/cluster1(locate(x-2,y-2,z))
				F12.owner=owner
				var/obj/F13=new/obj/cluster1(locate(x-2,y+2,z))
				F13.owner=owner
				var/obj/F14=new/obj/cluster1(locate(x+2,y-2,z))
				F14.owner=owner
				var/obj/F15=new/obj/cluster1(locate(x+2,y+2,z))
				F15.owner=owner
			spawn(5)
				var/obj/G=new/obj/cluster2(loc)
				G.owner=owner
			spawn(120)del src
	cluster1
		name="Iron World"
		icon='ironworld.dmi'
		layer=40
		var/fa=1
		density=1
		New()
			..()
			spawn(1)
				for(var/mob/M in loc)
					var/mob/O=owner
					var/mob/D=M
					if(O.aff==D.aff)break
					var/damage=round(O.pow*0.45)
					if(O.tier11)damage*=1+0.05*O.tier11
					D.dmgch(O)
					damage=(damage*D.variable)+D.variable2
					D.damage(damage)
					D.poisoned(O,2)
					D.stun(20)
					D.death(O)
			spawn(60)del src
			fa="[rand(1,8)]"
			icon_state="[fa]"
			flick("[fa]a",src)
			spawn(45)
				flick("[fa]b",src)
				icon_state=""
				spawn(5)
					del src
	cluster2
		name="Iron Sand Cluster"
		icon='ironcluster.dmi'
		density=0
		layer=41
		pixel_x=-64
		New()
			..()
			spawn(30)del src
			flick("begin",src)
			pixel_y=17
			spawn(10)
				flick("anim",src)
				pixel_y=-35
				spawn(5)
					var/mob/O=owner
					if(O.tier63)
						for(var/mob/M in range(src,1+2*O.tier63))
							var/mob/I=M
							if(O.aff==I.aff)continue
							I.stun(16)
					O.soundeff('crash.wav',40,0)
					for(var/mob/M in range(src,1))
						var/mob/D=M
						if(O.aff==D.aff)continue
						D.magnet()
						D.poisoned(O)
						var/damage=O.pow*1
						var/extradmg=O.cha*0.2
						O.cha-=extradmg
						O.mybar2:updatebar()
						damage+=extradmg*2
						if(O.tier11)damage*=1+0.05*O.tier11
						if(O.tier51)
							D.snared(14*O.tier51,3)
							damage*=1+0.05*O.tier51
						D.dmgch(O)
						D.soundeff('mountain.wav',40,0)
						damage=(damage*D.variable)+D.variable2
						D.damage(damage,1)
						D.death(O)
				spawn(12)
					flick("end",src)
	ironrain
		name="Iron Sand Rain"
		icon='ironrain.dmi'
		density=0
		layer=45
		New()
			..()
			flick("begin",src)
			icon_state=pick("1","2","3","4")
			iconshift()
			spawn(66)
				flick("end",src)
			spawn(71)del src
			spawn(1)while(src&&owner)
				sleep(5)
				if(!owner)del src
				for(var/mob/M in loc)
					if(owner:aff==M.aff)continue
					M.magnet()
					M.poisoned(owner)
					var/damage=owner:pow*0.1
					if(owner:tier11)damage*=1+0.05*owner:tier11
					if(owner:tier42)damage+=owner:hp/100*(1+(0.2*owner:tier42))
					M.dmgch(owner)
					damage=(damage*M.variable)+M.variable2
					M.damage(damage)
					M.death(owner)
		proc
			iconshift()
				spawn(rand(1,7))
					pixel_x=rand(-64,64)
					pixel_y=rand(-64,64)
					iconshift()
	ironshower
		icon='ironshower.dmi'
		density=1
		var/shard=0
		projint=1
		New()
			..()
			spawn(100)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				loc=D.loc
				if(O.aff==D.aff)return
				if(!shard)D.soundeff('sandshower.wav',30,0)
				else D.soundeff('slash2.wav',40,0)
				D.magnet()
				D.poisoned(O,2)
				if(shard)
					var/d=O.pow*0.15*O.tier21
					if(O.tier11)d*=1+0.05*O.tier11
					if(shard==2)d*=1.4
					projectilep(O,D,d)
				else
					del src
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)
		Move()
			if(!shard)
				var/obj/F=new/obj/ironshowertrail(loc)
				F.icon=icon
			..()
	ironshowertrail
		icon_state="clear"
		layer=30
		New()
			..()
			flick("trail",src)
			spawn(5)del src
	goldtriangle
		icon='irongathering.dmi'
		icon_state="middle"
		layer=40
		density=1
		pixel_y=-36
		pixel_x=-32
		projint=4
		New()
			..()
			flick("gold",src)
			spawn(7)freeze=1
			spawn(30)del src
		Move()
			..()

			if(!owner)del src
			if(!freeze)
				var/mob/O=owner
				for(var/mob/M in range(src,1))
					var/mob/D=M
					if(D.hardhit)continue
					if(O.aff==D.aff)continue
					D.magnet()
					D.hardhit()
					D.poisoned(O)
					var/damage=O.pow*0.7*1.4
					var/extradmg=O.cha*0.2
					O.cha-=extradmg
					O.mybar2:updatebar()
					damage+=extradmg*2
					if(O.tier11)damage*=1+0.05*O.tier11
					if(O.tier51)
						D.snared(14*O.tier51,3)
						damage*=1+0.05*O.tier51
					D.dmgch(O)
					D.soundeff('mountain.wav',40,0)
					damage=(damage*O.variable)+O.variable2
					D.damage(damage,1)
					D.death(O)
		Bump(A)
			if(istype(A,/mob))
				var/mob/D=A
				loc=D.loc
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)
	goldworld
		name="Gold World"
		icon='goldworld.dmi'
		layer=40
		var/fa=1
		Crossed(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(O.aff==D.aff)return
				D.magnet()
				D.poisoned(O,5)
				D.stun(8)
				D.snared(20,2)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					T.loc=loc
		New()
			..()
			spawn(120)del src
			fa="[rand(1,8)]"
			icon_state="[fa]"
			flick("[fa]a",src)
			spawn(112)
				icon_state=""
				flick("[fa]b",src)
				spawn(5)
					del src
	goldworldc
		New()
			..()
			spawn(1)
				var/obj/F=new/obj/gcluster1(locate(x-2,y-1,z))
				F.owner=owner
				var/obj/F1=new/obj/gcluster1(locate(x-2,y,z))
				F1.owner=owner
				var/obj/F2=new/obj/gcluster1(locate(x-2,y+1,z))
				F2.owner=owner
				var/obj/F3=new/obj/gcluster1(locate(x-1,y+2,z))
				F3.owner=owner
				var/obj/F4=new/obj/gcluster1(locate(x-1,y-2,z))
				F4.owner=owner
				F4.layer=42
				var/obj/F5=new/obj/gcluster1(locate(x,y+2,z))
				F5.owner=owner
				var/obj/F6=new/obj/gcluster1(locate(x,y-2,z))
				F6.owner=owner
				F6.layer=42
				var/obj/F7=new/obj/gcluster1(locate(x+1,y+2,z))
				F7.owner=owner
				var/obj/F8=new/obj/gcluster1(locate(x+1,y-2,z))
				F8.owner=owner
				F8.layer=42
				var/obj/F9=new/obj/gcluster1(locate(x+2,y,z))
				F9.owner=owner
				var/obj/F10=new/obj/gcluster1(locate(x+2,y+1,z))
				F10.owner=owner
				var/obj/F11=new/obj/gcluster1(locate(x+2,y-1,z))
				F11.owner=owner
				var/obj/F12=new/obj/gcluster1(locate(x-2,y-2,z))
				F12.owner=owner
				var/obj/F13=new/obj/gcluster1(locate(x-2,y+2,z))
				F13.owner=owner
				var/obj/F14=new/obj/gcluster1(locate(x+2,y-2,z))
				F14.owner=owner
				var/obj/F15=new/obj/gcluster1(locate(x+1,y+2,z))
				F15.owner=owner
			spawn(5)
				var/obj/G=new/obj/gcluster2(loc)
				G.owner=owner
			spawn(120)del src
	gcluster1
		name="Gold World"
		icon='goldworld.dmi'
		layer=40
		var/fa=1
		density=1
		New()
			..()
			spawn(1)
				for(var/mob/M in loc)
					var/mob/O=owner
					var/mob/D=M
					if(O.aff==D.aff)break
					var/damage=round(O.pow*0.45*1.4)
					if(O.tier11)damage*=1+0.05*O.tier11
					D.dmgch(O)
					damage=(damage*D.variable)+D.variable2
					D.damage(damage)
					D.poisoned(O,2)
					D.stun(20)
					D.death(O)
			spawn(60)del src
			fa="[rand(1,8)]"
			icon_state="[fa]"
			flick("[fa]a",src)
			spawn(45)
				icon_state=""
				flick("[fa]b",src)
				spawn(5)
					del src
	gcluster2
		name="Gold Sand Cluster"
		icon='goldcluster.dmi'
		density=0
		layer=41
		pixel_x=-64
		New()
			..()
			spawn(30)del src
			flick("begin",src)
			pixel_y=17
			spawn(10)
				flick("anim",src)
				pixel_y=-35
				spawn(5)
					var/mob/O=owner
					if(O.tier63)
						for(var/mob/M in range(src,1+2*O.tier63))
							var/mob/I=M
							if(O.aff==I.aff)continue
							I.stun(16)
					O.soundeff('crash.wav',40,0)
					for(var/mob/M in range(src,1))
						var/mob/D=M
						if(O.aff==D.aff)continue
						D.magnet()
						D.poisoned(O)
						var/damage=O.pow*1.4
						var/extradmg=O.cha*0.2
						O.cha-=extradmg
						O.mybar2:updatebar()
						damage+=extradmg*2
						if(O.tier11)damage*=1+0.05*O.tier11
						if(O.tier51)
							D.snared(14*O.tier51,3)
							damage*=1+0.05*O.tier51
						D.dmgch(O)
						D.soundeff('mountain.wav',40,0)
						damage=(damage*D.variable)+D.variable2
						D.damage(damage,1)
						D.death(O)
				spawn(12)
					flick("end",src)
	goldrain
		name="Gold Sand Rain"
		icon='goldrain.dmi'
		density=0
		layer=45
		New()
			..()
			flick("begin",src)
			icon_state=pick("1","2","3","4")
			iconshift()
			spawn(66)
				flick("end",src)
			spawn(71)del src
			var/mob/O=owner
			spawn(1)while(src)
				sleep(5)
				for(var/mob/M in loc)
					var/mob/D=M
					if(O.aff==D.aff)continue
					D.magnet()
					D.poisoned(O)
					var/damage=O.pow*0.1*1.4
					if(O.tier11)damage*=1+0.05*O.tier11
					if(O.tier42)damage+=O.hp/100*(1+(0.5*O.tier42))
					D.dmgch(O)
					damage=(damage*D.variable)+D.variable2
					D.damage(damage)
					D.death(O)
		proc
			iconshift()
				spawn(rand(1,7))
					pixel_x=rand(-64,64)
					pixel_y=rand(-64,64)
					iconshift()