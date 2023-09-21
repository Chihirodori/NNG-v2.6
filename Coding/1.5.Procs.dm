proc/expgainscale(var/basegain,var/profl)
	if(profl<0)profl=0
	if(profl>20)profl=20
	var/amtf=1-profl*0.0375
	return basegain*amtf
mob/proc
	setUpMenus()
		winset(src, "NNG", "parent=menu;name=NNG")
		//
		//
		winset(src, "donation", "parent=NNG;name=Donations")
		//
		winset(src, "info", "parent=donation;name=Information;command=Donationinfo")
		winset(src, "store", "parent=donation;name=Credit+Store;command=creditstore")
		winset(src, "credits", "parent=donation;name=Give+Credits;command=givecredits")
		//
		//
		winset(src, "villagewar", "parent=NNG;name=Village+Wars;command=ToggleWar")
		winset(src, "forums", "parent=NNG;name=Forums;command=Forums")
		winset(src, "save", "parent=NNG;name=Save;command=Save")
		//
		//
		winset(src, "chat", "parent=NNG;name=Chat")
		//
		winset(src, "saychat", "parent=chat;name=Say;command=Say")
		winset(src, "villagechat", "parent=chat;name=Village;command=VillageSay")
		winset(src, "worldchat", "parent=chat;name=World;command=OOCSay")
		//
		//
		winset(src, "reputation", "parent=NNG;name=Reputation")
		//
		winset(src, "give", "parent=reputation;name=Give;command=GiveReputation")
		winset(src, "take", "parent=reputation;name=Take;command=TakeReputation")
		//
		//
		winset(src, "chatbox", "parent=NNG;name=Chatbox")
		//
		winset(src, "clear", "parent=chatbox;name=Clear;command=ClearChatbox")
		winset(src, "automated", "parent=chatbox;name=Set+Automated;command=SetChatboxAutomatedClear")
		//
		//
		winset(src, "FAQ", "parent=NNG;name=FAQ")
		//
		winset(src, "rank", "parent=FAQ;name=Rank;command=RankFAQ")
		winset(src, "training", "parent=FAQ;name=Training;command=TrainingFAQ")
mob/proc
	summonspawn()
		switch(village)
			if("Leaf")loc=locate(263,80,2)
			if("Sand")loc=locate(30,27,2)
			if("Sound")loc=locate(461,300,3)
			if("None")loc=locate(202,220,2)
			if("Akatsuki")loc=locate(202,220,2)
		onwater=0
		onsand=0
		inzone=0
		atkdef()
		for(var/area/A in oview(0,x))A.Entered(x)
	damage(var/damage,var/crit=0)
		if(damage < 5)
			damage = 5
		if(busy=="mirror"||shield||godmode||kyuubimode&&damage==5&&rank!="Bijuu")
			new/obj/invinc(loc)
			return
		if(z == 5)
			damage /= 2
		if(crit)
			damage *= crit
			if(tier23 && clan == "Snake" && !regencd)snakeregen(damage*(0.05*tier23))
		if(veng)
			veng += damage
			damage = 0
			new/obj/invinc(loc)
		if(sandarmor)
			var/t=sandarmor
			sandarmor-=damage
			new/obj/armor(loc)
			if(sandarmor<=0)
				sandarmor=0
				damage-=t
				if(clan=="Sand")
					if(key=="JillyBear")new/obj/armordownb(loc)
					else
						new/obj/armordown(loc)
				if(clan=="Yuki")
					new/obj/waterdown(loc)
					waterc(0)
			else
				damage=0
				if(clan=="Yuki")
					waterc(sandarmor)
		if(matarmor)
			var/t=matarmor
			matarmor-=damage
			new/obj/armor(loc)
			if(matarmor<=0)
				damage-=t
				matarmor=0
				new/obj/armordown(loc)
			else
				damage=0
		if(clan=="Senju"&&fourpillars)createprison()
		if(damage)
			if(clan=="Kaguya"&&tier22)
				if(relentless<10)
					relentless(1)
					atkdef()
					spawn(70)
						relentless(-1)
						atkdef()
			if(rank=="Bijuu")
				if(damage>=100)damage=100
			hp-=damage
			var/amountdmg=damage/maxhp
			if(amountdmg>0.03&&amountdmg<0.1)
				if(crit)new/obj/crithit(loc)
				else new/obj/hit(loc)
			else
				if(amountdmg>=0.1&&amountdmg<0.5)
					if(crit)new/obj/crithit2(loc)
					else new/obj/hit2(loc)
				else
					if(amountdmg>=0.5)
						new/obj/crithit3(loc)
			if(clan=="Sand"&&tier61&&!ultimatedefense&&hp<=maxhp/5)ultimatedefense()
	wired(var/time)
		if(time>=50)time=50
		freeze++
		busy="windmill"
		spawn(time)
			freeze--
			for(var/obj/wirebind/M in loc)del M
			busy=null
	imperialpierce(var/time)
		if(imperialpierce)return
		imperialpierce++
		atkdef()
		regenupdate()
		while(time&&!dead)
			new/obj/bloodstep(loc)
			sleep(3)
			new/obj/bloodstep(loc)
			sleep(3)
			new/obj/bloodstep(loc)
			time--
			sleep(4)
		regenupdate()
		imperialpierce--
		atkdef()
	bleeding(var/time,var/damage,var/mob/M)
		bleeding++
		regenupdate()
		while(time&&M&&!dead&&!shield&&!sandshield&&!sandarmor)
			hp-=damage/10
			new/obj/bleed(loc)
			death(M)
			time--
			sleep(10)
		bleeding--
		regenupdate()
	bleeding2(var/time,var/damage,var/mob/M)
		bleeding ++
		regenupdate()
		loop
			if(time && !dead && !shield && !sandshield && !sandarmor)
				hp -= round(damage)
				new/obj/bleed(loc)
				death(M)
				time --
				spawn(10)goto loop
			else
				bleeding --
				regenupdate()
	bleedingkag(var/mob/M)
		kagcleave=1
		spawn(84)kagcleave=0
		var/time=1+M.tier13
		var/damage=maxhp/100
		if(M.tier63)
			damage*=1+(0.5*M.tier63)
		bleeding++
		regenupdate()
		while(time&&M&&!dead&&!shield&&!sandshield&&!sandarmor)
			damage(damage)
			new/obj/bleed(loc)
			death(M)
			time--
			sleep(10)
		bleeding--
		regenupdate()
	deathview(var/tz)
		range(12)<<"<b>[src] has been caught in a death viewing technique!"
		if(client)
			client.perspective=EYE_PERSPECTIVE
			client.eye=locate(187,231,5)
			var/K=new/obj/deadbody(locate(187,231,5))
			K:overlays+=overlays
			K:icon=icon
			spawn(tz)
				client.perspective=MOB_PERSPECTIVE
				client.eye=client.mob
				del K
		else
			freeze++
			spawn(tz)freeze--
	rundown()
		while(src)
			while(runstep)
				var/T=delay
				if(running)T++
				else T+=2
				if(T<=1)T=2
				sleep(T)
				if(runstep>0)runstep--
				if(running&&runstep<4)
					if(icon_state=="run")icon_state=null
					running=0
			sleep(30)
	confusion(var/time)
		confused=1
		spawn(time)confused=0
	markdeath(var/mob/M)
		if(!M)return
		if(client)
			var/obj/statuseffect/t=new/obj/statuseffect/markofdeath
			debuffcount(120)
			t.screen_loc="[7+debuffa],16"
			client.screen+=t
			seffect(120,t)
		marked=M.tier42
		M.mark(src)
		ovcheck()
		spawn(120)
			marked=0
			ovcheck()
	markfrost()
		if(!npc)
			frostmark=1
			ovcheck()
			spawn(140)
				if(frostmark)
					frostmark=0
				ovcheck()
	skilltree()
		if(initialized)
			if(cdelay1)return
			cdelay1=1
			spawn(42)cdelay1=0
			if(client.eye==client.mob)
				client.perspective=EYE_PERSPECTIVE
				switch(clan)
					if("Hyuuga")
						client.eye=locate(29,112,1)
					if("Uchiha")
						client.eye=locate(79,175,1)
					if("Senju")
						client.eye=locate(100,175,1)
					if("Taijutsu Specialist")
						client.eye=locate(121,175,1)
					if("Fan")
						client.eye=locate(56,136,1)
					if("Sand")
						client.eye=locate(79,112,1)
					if("Yuki")
						client.eye=locate(79,133,1)
					if("Medic")
						client.eye=locate(100,112,1)
					if("Kaguya")
						client.eye=locate(56,112,1)
					if("Iron")
						client.eye=locate(100,154,1)
					if("Snake")
						client.eye=locate(100,133,1)
					if("Clay")
						client.eye=locate(121,133,1)
					if("Copy Ninja")
						client.eye=locate(121,154,1)
					if("Nara")
						client.eye=locate(142,154,1)
					else
						client.eye=locate(79,154,1)
				if(clan=="Kaguya"||clan=="Fan"||clan=="Hyuuga")
					if(skilltotal<4)
						client.screen+=new/obj/skilldark/tier21
						client.screen+=new/obj/skilldark/tier22
						client.screen+=new/obj/skilldark/tier23
					if(skilltotal<8)
						client.screen+=new/obj/skilldark/tier31
						client.screen+=new/obj/skilldark/tier32
						client.screen+=new/obj/skilldark/tier33
					if(skilltotal<12)
						client.screen+=new/obj/skilldark/tier41
						client.screen+=new/obj/skilldark/tier42
						client.screen+=new/obj/skilldark/tier43
					if(skilltotal<16)
						client.screen+=new/obj/skilldark/tier51
						client.screen+=new/obj/skilldark/tier52
						client.screen+=new/obj/skilldark/tier53
					if(skilltotal<20)
						client.screen+=new/obj/skilldark/tier61
						client.screen+=new/obj/skilldark/tier62
						client.screen+=new/obj/skilldark/tier63
				else
					if(skilltotal<5)
						client.screen+=new/obj/skilldark/tier21/sand
						client.screen+=new/obj/skilldark/tier22/sand
						client.screen+=new/obj/skilldark/tier23/sand
					if(skilltotal<10)
						client.screen+=new/obj/skilldark/tier31/sand
						client.screen+=new/obj/skilldark/tier32/sand
						client.screen+=new/obj/skilldark/tier33/sand
					if(skilltotal<15)
						client.screen+=new/obj/skilldark/tier41/sand
						client.screen+=new/obj/skilldark/tier42/sand
						client.screen+=new/obj/skilldark/tier43/sand
					if(skilltotal<20)
						client.screen+=new/obj/skilldark/tier51/sand
						client.screen+=new/obj/skilldark/tier52/sand
						client.screen+=new/obj/skilldark/tier53/sand
					if(skilltotal<25)
						client.screen+=new/obj/skilldark/tier61/sand
						client.screen+=new/obj/skilldark/tier62/sand
						client.screen+=new/obj/skilldark/tier63/sand
				if(skilltotal>=15&&clan=="Fan"&&!tier31)client.screen+=new/obj/skilldark/tier41
				skilllevel()
			else
				for(var/obj/skilldark/T in client.screen)del T
				client.perspective=MOB_PERSPECTIVE
				client.eye=client.mob
	skillcheck()
		if(skilltotal==5)
			for(var/obj/skilldark/tier21/M in usr.client.screen)del M
			for(var/obj/skilldark/tier22/M in usr.client.screen)del M
			for(var/obj/skilldark/tier23/M in usr.client.screen)del M
		if(skilltotal==10)
			for(var/obj/skilldark/tier31/M in usr.client.screen)del M
			for(var/obj/skilldark/tier32/M in usr.client.screen)del M
			for(var/obj/skilldark/tier33/M in usr.client.screen)del M
		if(skilltotal==15)
			for(var/obj/skilldark/tier41/M in usr.client.screen)del M
			for(var/obj/skilldark/tier42/M in usr.client.screen)del M
			for(var/obj/skilldark/tier43/M in usr.client.screen)del M
		if(skilltotal==20)
			for(var/obj/skilldark/tier51/M in usr.client.screen)del M
			for(var/obj/skilldark/tier52/M in usr.client.screen)del M
			for(var/obj/skilldark/tier53/M in usr.client.screen)del M
		if(skilltotal==25)
			for(var/obj/skilldark/tier61/M in usr.client.screen)del M
			for(var/obj/skilldark/tier62/M in usr.client.screen)del M
			for(var/obj/skilldark/tier63/M in usr.client.screen)del M
	jailtime()
		loc=locate(100,268,1)
		barloc()
		src<<"<b>You are jailed. You will be free after [jailtime] seconds."
		while(jailtime>0)
			jailtime-=1
			sleep(10)
		if(rebirthing)return
		src<<"<b>Your time is up. You are brought to a safe zone."
		var/list/K=list()
		if(village=="Leaf")for(var/obj/Spawn_Point/leaf/M in world)K+=M
		if(village=="Sand")for(var/obj/Spawn_Point/sand/M in world)K+=M
		if(village=="Sound")for(var/obj/Spawn_Point/sound/M in world)K+=M
		if(village=="None")for(var/obj/Spawn_Point/missing/M in world)K+=M
		if(village=="Akatsuki")for(var/obj/Spawn_Point/akatsuki/M in world)K+=M
		var/S=pick(K)
		loc=S:loc
		barloc()
	hosptime()
		if(hosptime<5)
			hosptime=5
		if(hosptime>20)
			hosptime=20
		if(GM&&gmhosp)
			hosptime=0
		invisibility=1
		intense=0
		if(village=="Sound")src<<"<b><center>You have died. Your new body will be ready in [hosptime] seconds."
		if(village=="Akatsuki")
			src<<"<b><center>You have died. You will be able to leave your base after [hosptime] seconds."
		else
			src<<"<b><center>You are hospitalized. You will recover after [hosptime] seconds."
		overlay()
		var/list/K=list()
		if(village=="Leaf")for(var/obj/Spawn_Point/leaf/M in world)K+=M
		if(village=="Sand")for(var/obj/Spawn_Point/sand/M in world)K+=M
		if(village=="Sound")
			for(var/obj/Spawn_Point/sound/M in world)K+=M
			dir=SOUTH
			freeze++
		if(village=="Akatsuki")for(var/obj/Spawn_Point/akatsuki/M in world)K+=M
		var/S=pick(K)
		loc=S:loc
		barloc()
		while(hosptime>0)
			hosptime-=1
			sleep(10)
		if(rebirthing)return
		overlay()
		if(village=="Sound")
			src<<"<b><center>You have fully recovered."
			freeze--
			y--
			pixel_y=0
		if(village=="Akatsuki")
			src<<"<b><center>You have fully recovered. You may leave your base now."
		else
			src<<"<b><center>You have fully recovered. You may leave the hospital now."

	hospjailtime()
		if(hosptime<5)hosptime=5
		if(hosptime>20)hosptime=20
		if(GM&&gmhosp)hosptime=0
		invisibility=1
		src<<"<b><center>You are jailed. You will be set free after [hosptime] seconds."
		while(hosptime>0)
			hosptime-=1
			sleep(10)
		if(rebirthing)return
		src<<"<b><center>You have been set free."
		summonspawn()
	amissioned()
		if(amissioned>0)
			amissioned-=1
			spawn(14)amissioned()
		else src<<"<b>There are now new missions availible."
	repdelay()
		if(repdelay>0)
			repdelay-=1
			spawn(840)repdelay()
		else
			src<<"<b>You can now give or reduce the reputation of someone."
	muteproc()
		src<<"<b>You are muted. You will be unmuted after [muted] seconds."
		overhead()
		while(muted>0)
			if(muted>=100000)return
			muted-=1
			sleep(10)
		world<<"<b><font color=white>[src]<font color=red> has been unmuted because his time was up."
		overhead()
	//skilllevel
	skilllevel()
		for(var/obj/skilllevel/M in client.screen)del M
		var/A1=new/obj/skilllevel/tier11
		var/A2=new/obj/skilllevel/tier12
		var/A3=new/obj/skilllevel/tier13
		var/B1=new/obj/skilllevel/tier21
		var/B2=new/obj/skilllevel/tier22
		var/B3=new/obj/skilllevel/tier23
		var/C1=new/obj/skilllevel/tier31
		var/C2=new/obj/skilllevel/tier32
		var/C3=new/obj/skilllevel/tier33
		var/D1=new/obj/skilllevel/tier41
		var/D2=new/obj/skilllevel/tier42
		var/D3=new/obj/skilllevel/tier43
		var/E1=new/obj/skilllevel/tier51
		var/E2=new/obj/skilllevel/tier52
		var/E3=new/obj/skilllevel/tier53
		var/F1=new/obj/skilllevel/tier61
		var/F2=new/obj/skilllevel/tier62
		var/F3=new/obj/skilllevel/tier63
		A1:icon_state="[clan][tier11]"
		A2:icon_state="[clan][tier12]"
		A3:icon_state="[clan][tier13]"
		B1:icon_state="[clan][tier21]"
		B2:icon_state="[clan][tier22]"
		B3:icon_state="[clan][tier23]"
		C1:icon_state="[clan][tier31]"
		C2:icon_state="[clan][tier32]"
		C3:icon_state="[clan][tier33]"
		D1:icon_state="[clan][tier41]"
		D2:icon_state="[clan][tier42]"
		D3:icon_state="[clan][tier43]"
		E1:icon_state="[clan][tier51]"
		E2:icon_state="[clan][tier52]"
		E3:icon_state="[clan][tier53]"
		F1:icon_state="[clan][tier61]"
		F2:icon_state="[clan][tier62]"
		F3:icon_state="[clan][tier63]"
		if(clan=="Yuki"||clan=="Iron"||clan=="Snake"||clan=="Uchiha")
			A1:icon_state="[clan][tier11][tier11max]"
			A2:icon_state="[clan][tier12][tier12max]"
			A3:icon_state="[clan][tier13][tier13max]"
			B1:icon_state="[clan][tier21][tier21max]"
			B2:icon_state="[clan][tier22][tier22max]"
			B3:icon_state="[clan][tier23][tier23max]"
			C1:icon_state="[clan][tier31][tier31max]"
			C2:icon_state="[clan][tier32][tier32max]"
			C3:icon_state="[clan][tier33][tier33max]"
			D1:icon_state="[clan][tier41][tier41max]"
			D2:icon_state="[clan][tier42][tier42max]"
			D3:icon_state="[clan][tier43][tier43max]"
			E1:icon_state="[clan][tier51][tier51max]"
			E2:icon_state="[clan][tier52][tier52max]"
			E3:icon_state="[clan][tier53][tier53max]"
			F1:icon_state="[clan][tier61][tier61max]"
			F2:icon_state="[clan][tier62][tier62max]"
			F3:icon_state="[clan][tier63][tier63max]"
		if(clan!="Kaguya"&&clan!="Fan"&&clan!="Hyuuga")
			A1:screen_loc="9,16"
			B1:screen_loc="9,14"
			C1:screen_loc="9,12"
			D1:screen_loc="9,10"
			E1:screen_loc="9,8"
			F1:screen_loc="9,6"
			A3:screen_loc="15,16"
			B3:screen_loc="15,14"
			C3:screen_loc="15,12"
			D3:screen_loc="15,10"
			E3:screen_loc="15,8"
			F3:screen_loc="15,6"
		client.screen+=A1
		client.screen+=A2
		client.screen+=A3
		client.screen+=B1
		client.screen+=B2
		client.screen+=B3
		client.screen+=C1
		client.screen+=C2
		client.screen+=C3
		client.screen+=D1
		client.screen+=D2
		client.screen+=D3
		client.screen+=E1
		client.screen+=E2
		client.screen+=E3
		client.screen+=F1
		client.screen+=F2
		client.screen+=F3
		skillcheck()
		statset()
	sslow()
		if(substitution==2)return
		sandstormslow++
		snared(70,1)
		spawn(70)
			sandstormslow--
			if(sandstormslow<0)sandstormslow=0
	sshake()
		client.lazy_eye++
		spawn(140)client.lazy_eye--
	sshake2()
		if(see_invisible==3)
			see_invisible-=2
			spawn(14)if(see_invisible==1)see_invisible+=2
	aggro(var/mob/M)
		if(aff==M.aff)return
		if(!dead)
			if(!aggroed)
				aggroed=1
				aggro=M
				spawn(50)
					aggroed=0
			M.target=src
			spawn()while(intense)
				sleep(100)
				if(!intense)
					aggro=null
					target=null
	//death
	death(mob/M,bury=0)
		cloudoff()
		snakeoff()
		if(npc==3)
			hp=maxhp
			if(!src:dying)mybar:updatebar()
			return
		if(busy=="trigram")
			if(hp<1)hp=1
			return
		if(istype(src,/mob/charactermenu))
			del src
			return
		if(mybar)mybar:updatebar()
		if(busy=="frozen")
			busy=""
			freeze--
			for(var/obj/iceprison/G in loc)del G
			frozenhit(frozenby)
		if(safezone)
			for(var/mob/NPC/Samurai/F in range(16))
				F:aggro(M)
		if(!src||!M)return
		if(M.clan=="Uchiha"&&M.tier51&&!M.corrupt)M.hatred(src)
		if(M.clan=="Yuki"&&M.tier31)
			deadliness(M)
		if(istype(src,/mob/Kid)&&M.mission=="Babysitting (D Rank)")
			if(M.savedloc)M.loc=M.savedloc
			M.missionfail("Babysitting","D")
			M.barloc()
			return
		if(isanimal)
			if(name=="Deer(Animal)")step_rand(src,3)
			deathanimal(M)
			return
		if(rank=="Bijuu"&&hp<=0)
			del src
			return
		if(running)
			icon_state=""
			running=0
			runstep=0
		if(npc>=2||ingenin||jailtime||hosptime||intut||inchunin>0&&inchunin<4||worldpeace||mask==/obj/spiralmask&&GM==3)
			hp=maxhp
			if(mybar)mybar:updatebar()
		for(var/obj/Safe_Zone/M2 in loc)
			hp=maxhp
			if(mybar)mybar:updatebar()
		if(!src||!M||dead||npc==2||ingenin||intut)return
		if(clone||istype(src,/mob/Clone/sandclone)&&hp<=0||istype(src,/mob/Clone/shadowclone)&&hp<=0||istype(src,/mob/Clone/waterclone)&&hp<=0)del src
		cloakoff()
		hengeback()
		if(resting==2)
			hp=0
			if(mybar)mybar:updatebar()
		breakresting()
		exp(1)
		aggro(M)
		if(hp<=0||swim)
			if(istype(src,/mob/edo))
				src:edoowner.edol=0
				src:edoowner.edo=0
				src:atkdef()
				src:edoowner<<"<center><b>Your edo tensei has been slain!"
				del src
				return
			if(defendraid>=1)
				defenders--
				defendraid=0
			if(helpraid>=1)
				raiders--
				helpraid=0
			aggro=null
			target=null
			if(M.aggro==src)
				M.aggro=null
			if(M.target==src)
				M.target=null
			if(hostamount&&!amatcd)
				amatcd=1
				var/sdelay=2520-tier53*28
				for(var/obj/jutsu/uchiha/Mangekyou_Sharingan/Mz in src)timerjutsu(sdelay,Mz)
				spawn(sdelay)
					amatcd=0
				immortalitya()
				if(tier62)
					M.stun(8.4*tier62)
				return
			dead=1
			ovcheck()
			if(inchunin==4)
				M<<"<b>You've defeated [src]!"
				src<<"<b>You have been defeated by [M]!"
				for(var/obj/usable/Heaven_Scroll/M3 in src)
					M3.loc=loc
					M3:t=0
					range(16)<<"<b>[src] dropped a Heaven Scroll!"
				for(var/obj/usable/Earth_Scroll/M3 in src)
					M3.loc=loc
					M3:t=0
					range(16)<<"<b>[src] dropped a Earth Scroll!"
				hengeback()
				if(byakugan)
					byakugan=0
				for(var/mob/Clone/clone/MT in world)if(MT.cloneowner==src)del MT
				for(var/mob/Clone/shadowclone/MT in world)if(MT.cloneowner==src)del MT
				for(var/obj/neckbind/MT in loc)del MT
				if(!swim&&!smite&&!bury)
					ovcheck()
					var/K=new/obj/deadbody(loc)
					K:level=level
					K:name=name
					K:overlays+=overlays
					K:icon=icon
				cha=0
				shadowoff()
				shadowsewingoff()
				density=0
				deathclean(1)
				summonspawn()
				barloc()
			else
				if(mission=="Defeat Bandits (C Rank)")
					weedpick=0
					if(istype(M,/mob/NPC/mission/Bandit))missionfail("Defeat Bandits","C")
				if(weedpick>0&&mission=="Missing-Nin Hideout (B Rank)")
					weedpick=0
					if(istype(M,/mob/NPC/killable/unique/roguedude))
						missionfail("Missing-Nin Hideout","B")
				for(var/obj/items/Captured_Boar/M2 in src)
					src<<"<b>The boar escaped!"
					del M2
				for(var/obj/items/Full_Water_Container/M2 in src)
					src<<"<b>Your water container spilled!"
					del M2
					new/obj/items/Half_Full_Water_Container(src)
				hengeback()
				if(byakugan)
					byakugan=0
				for(var/mob/Clone/clone/MT in world)if(MT.cloneowner==src)del MT
				for(var/mob/Clone/shadowclone/MT in world)if(MT.cloneowner==src)del MT
				for(var/obj/neckbind/MT in loc)del MT
				if(!swim&&!smite&&!bury)
					ovcheck()
					var/K=new/obj/deadbody(loc)
					if(istype(src,/mob/NPC/mission))K:z=2
					K:name=name
					K:level=level
					K:overlays+=overlays
					K:icon=icon
				cha=0
				if(bury)new/obj/buryend(loc)
				shadowoff()
				shadowsewingoff()
				freeze=5
				density=0
				defeatmessage(M)
				var/jailed=0
				if(client)deathexp(M)
				if(bountyhead)
					M.bountyget+=bountyhead
					M.maxbounty+=bountyhead
					M.bountykills++
					if(M.bountykills==1)M.medal(1,11)
					if(M.bountykills==10)M.medal(1,12)
					if(M.bountykills==50)M.medal(2,16)
					if(M.bountykills==500)M.medal(3,8)
					M<<"<b><font color=red><center>You have collected [realnum(bountyhead)] ryo. ([realnum(M.bountyget)])"
					bountytimes--
					for(var/mob/player/Mz in world)if(Mz.bountytoggle)
						Mz<<"<b><font color=red>Bounty Info:<font color=white> [src] has been slain by [M]. ([realnum(bountyhead)] ryo)"
					if(bountytimes<=0)
						bountyhead=0
						bountyannounce=0
						bountyby=null
						bountytimes=0
						for(var/mob/player/Mz in world)if(Mz.bountytoggle)
							Mz<<"<b><font color=red>Bounty Info:<font color=white> The bounty on [src] is off."
				if(client)for(var/obj/statuseffect/stance/F in client.screen)del F
				deaths++
				if(M.GM==3)deaths--
				else
					if(prob(5))
						M.sneakybounty()
				stance="None"
				genesis=0
				M.kills ++
				if(istype(src,/mob/NPC/killable/unique/roguedude))
					M.kills--
					M.weedpick++
					if(M.weedpick<15)M<<"<b>[15-M.weedpick] rogue shinobis left to defeat."
					else
						M<<"You have completed the mission. Go to your Kage house to get your reward."
						M.z=2
					del src
				if(M.mission=="Leaf Village Assassination (B Rank)"&&village=="Leaf"||M.mission=="Sand Village Assassination (B Rank)"&&village=="Sand"||M.mission=="Sound Village Assassination (B Rank)"&&village=="Sound")
					if(M.weedpick<3&&rank!="Academy Student")
						M.weedpick++
						if(M.weedpick<3)M<<"<b>[3-M.weedpick] [village] shinobis left to defeat."
						else
							M<<"You have defeated 3 [village] shinnobis."
							M<<"You have completed the mission. Go to your Kage house without dying to get your reward."
				if(M.mission=="Assassinate the Hokage (S Rank)"&&rank=="Hokage")
					if(M.weedpick<1)
						M.weedpick++
						M<<"You have completed the mission. Fall back to your base and claim your reward."
				if(M.mission=="Assassinate the Kazekage (S Rank)"&&rank=="Kazekage")
					if(M.weedpick<1)
						M.weedpick++
						M<<"You have completed the mission. Fall back to your base and claim your reward."
				if(M.mission=="Assassinate the Sound Leader (S Rank)"&&rank=="Sound Leader")
					if(M.weedpick<1)
						M.weedpick++
						M<<"You have completed the mission. Fall back to your base and claim your reward."
				if(village == M.village && M.pktoggle && M.intourn != 2)
					M.pkkills ++
					if(M.pkkills>=3&&M.village!="None"&&M.village!="Akatsuki")
						for(var/mob/Z in world)if(Z.village==M.village)Z<<"<b><font color=silver>Village Info: <font color=white>[M]<font color=silver>'s crimes of betrayal is now unforgivable. His status is now to kill on sight."
						if(M.village=="Leaf"&&M.rank=="ANBU Leader")
							leafanbuleader=0
							world<<"<b><center><font color=silver>Leaf ANBU Leader is now open!"
						if(M.village=="Sand"&&M.rank=="ANBU Leader")
							sandanbuleader=0
							world<<"<b><center><font color=silver>Sand ANBU Leader is now open!"
						if(M.village=="Sound"&&M.rank=="ANBU Leader")
							soundanbuleader=0
							world<<"<b><center><font color=silver>Sound ANBU Leader is now open!"
						M.verbs-=typesof(/mob/Kage/verb)
						M.verbs-=typesof(/mob/Kage2/verb)
						M.verbs-=typesof(/mob/Akatsuki/verb)
						M.village="None"
						M.tmpvillage="None"
						M.mouseovername()
						for(var/obj/items/equippable/ANBU_Armor/M2 in M)del M2
						for(var/obj/items/equippable/Leaf_Anbu_Mask/M2 in M)del M2
						for(var/obj/items/equippable/Sand_Anbu_Mask/M2 in M)del M2
						for(var/obj/items/equippable/Sound_Anbu_Mask/M2 in M)del M2
						M.missingrank()
						M<<"<b>You have been kicked out of your village and is now a [M.rank]!"
				M.missingrank()
				if(intourn == 2)
					intourn = 0
					M.intourn = 1
					var/FZ = 0
					for(var/mob/player/Mz in world)
						if(Mz.intourn)
							FZ ++
					src.betrayal(1)
					M.betrayal(1)
					world << "<font color=red><center><b><font size=4>[M] has defeated [src]!"
					M.summonspawn()
					if(FZ <= 1)
						world << "<u><font color=red><center><b><font size=4>[M] is the winner of the tournament!"
						if(!M.tourneywin)
							M.tourneywin = 1
							M.medal(2, 19)
				if(istype(src,/mob/NPC/killable/random))
					M.kills--
					M.exp(rand(15,30))
					del src
					return
				if(istype(src,/mob/NPC/mission))
					M.exp(rand(30,50))
					if(M.mission=="Defeat Sasuke Uchiha (A Rank)"&&istype(src,/mob/NPC/mission/Sasuke))
						M.weedpick++
						M.z=2
					if(M.mission=="Defeat Bandits (C Rank)"&&istype(src,/mob/NPC/mission/Bandit))
						M.weedpick++
						M.kills--
						if(M.weedpick==3)M<<"<b>You have completed your mission. You may now claim your reward."
					del src
					return
				if(istype(M,/mob/NPC/mission))del M
				if(M)
					if(M.kills==1)M.medal(1,15)
					if(M.kills==50)M.medal(1,16)
					if(M.kills==200)M.medal(2,12)
					if(M.kills==1000)M.medal(2,13)
					if(M.kills==5000)M.medal(3,1)
				if(clan=="Clay"&&tier41)
					lastlaugh()
					sleep(30)
				if(clan=="Senju"&&tier32)
					finaldraw()
					sleep(13)
				if(!jailed)
					if(M)
						if(M.GM&&M.gmhosp)
							deathclean(6)
							return
					invisibility=10
					spawn(70)deathclean()
				else
					deathclean(2)
	sneakybounty()
		spawn(rand(600,6000))
			if(!bountyhead)
				bountyhead=rand(1,level/10)
				if(bountyhead>12)bountyhead=rand(3,12)
				bountyhosp=rand(0,100)
				bountyannounce=0
				bountycant=1
				bountytimes=1
				src<<"<b><font color=red>Bounty Info:<font color=white> Someone has placed a [realnum(bountyhead)] senryo reward on your head for a total of [bountytimes] times.(extra [bountyhosp] second of hospital time)"
				src<<"<b><font color=red>Your bounty has been set to unclearable and untraceable!"
				bountyby="Tobi"
				for(var/mob/player/Fz in world)
					if(Fz!=src&&Fz.bountytoggle||Fz==src)
						Fz<<"<b><font color=red>Bounty Info:<font color=white> A [realnum(bountyhead)] senryo reward has been placed on [src]'s head for a total of [bountytimes] times."
	deathexp(var/mob/killer)
		if(killer.GM==3)return
		if(exp>200)
			if(rank=="Chunin"||rank=="C-Ranked Criminal")
				var/h=exp*0.05
				if(h>=30)h=30
				if(h>=exp)h=exp
				h=round(h)
				exp-=h
				src<<"<center><font color=red>-[h] exp([exp] exp)"
			if(rank=="Jounin"||rank=="ANBU"||rank=="B-Ranked Criminal")
				var/h=exp*0.05
				if(h>=150)h=150
				if(h>=exp)h=exp
				h=round(h)
				exp-=h
				src<<"<center><font color=red>-[h] exp([exp] exp)"
			if(rank=="S-Ranked Criminal"||rank=="A-Ranked Criminal")
				var/h=exp*0.1
				if(h>=300)h=300
				if(h>=exp)h=exp
				h=round(h)
				exp-=h
				src<<"<center><font color=red>-[h] exp([exp] exp)"
			if(rank=="Hokage"||rank=="Kazekage"||rank=="Sound Leader")
				var/h=exp*0.1
				if(h>=500)h=500
				if(h>=exp)h=exp
				h=round(h)
				exp-=h
				src<<"<center><font color=red>-[h] exp([exp] exp)"
				if(!killer:kagekill)
					killer:kagekill=1
					killer:medal(2,14)
		var/expgain=level
		//var/karmaz=35
		if(level>killer.level)expgain+=3*(level-killer.level)
		if(level<killer.level)
			expgain-=killer.level-level
			//karmaz-=3*(killer.level-level)*(killer.hp/killer.maxhp)
		if(expgain>500)expgain=500
		if(rank=="Chunin"||rank=="C-Ranked Criminal")expgain+=40
		if(rank=="Jounin"||rank=="ANBU"||rank=="B-Ranked Criminal")expgain+=100
		if(rank=="A-Ranked Criminal")expgain+=150
		if(rank=="S-Ranked Criminal")expgain+=300
		if(rank=="Hokage"||rank=="Kazekage"||rank=="Sound Leader"||rank=="Akatsuki Leader")expgain+=500
		if(bountyhead)
			expgain *= 3
			if(killer.village=="None"||killer.village=="Akatsuki")expgain*=2
		else expgain/=2
		if(expgain<5)
			expgain=5
		if(killer.clan=="Yuki"&&killer.tier62&&killer.level-30<level)
			killer.rapidkilling()
		//if(!pktoggle&&!killer.inzone)
		//	if(killer.karma<karma)
		//		killer.karma(karmaz)
		killer.exp(expgain)
	deathanimal(mob/M)
		if(name=="Void Animal")return
		if(npc>=2)
			hp=maxhp
			if(mybar)mybar:updatebar()
			stepup(3)
			return
		if(!aggressive)stepup(3)
		if(!src||!M||dead)return
		if(mybar)mybar:updatebar()
		if(hp<=0)
			if(istype(src,/mob/Animal/Demon_Boar))
				M<<"<b>You have received a Red Katana."
				new/obj/items/equippable/Red_Katana(M)
			if(M.mission=="Capture A Boar (C Rank)")
				if(istype(src,/mob/Animal/Boar))
					for(var/obj/items/Captured_Boar/N in M)goto no
					M<<"<b>You have captured the Boar!"
					new/obj/items/Captured_Boar(M)
					loc=null
					barloc()
					del src
					return
			no
			if(M.mission=="Hunting (C Rank)")
				if(istype(src,/mob/Animal/Deer)&&M.weedpick<3)
					M.weedpick++
					new/obj/items/Deer_Pelt(M)
					if(M.weedpick<3)M<<"<b>You skinned the deer. [3-M.weedpick] deers left to hunt."
					else
						M<<"You have hunted 3 deers."
						M<<"You have completed the mission. Go to your Kage house to get your reward."
					loc=null
					barloc()
					del src
					return
			if(!smite)
				var/K=new/obj/deadbodychaless(loc)
				K:icon=icon
				K:level=level
				K:name=name
			var/I=copytext("[src]",1,length("[src]")-7)
			M<<"<b>You have killed a [I]."
			loc=null
			barloc()
			M.exp(expdrop)
			if(istype(src,/mob/Animal/Boar))
				M.boarkill++
				if(M.boarkill==1000)
					M.medal(1,22)
			if(istype(src,/mob/Animal/Deer))
				M.deerkill++
				if(M.deerkill==1000)
					M.medal(1,21)
			del src
	tutdeath()
		if(hp<=0)
			hengeback()
			if(byakugan)
				byakugan=0
			for(var/mob/Clone/clone/MT in world)if(MT.cloneowner==src)del MT
			dead=1
			density=0
			src<<"<b>You have been knocked out!"

			spawn(70)deathclean()
	cloakoff()
		if(cloaking&&!GM&&!gmhosp)
			invisibility=1
			if(Spd<9)
				soundeff('dodge6.wav',10,0)
				new/obj/cloakingend(loc)
			else
				soundeff(pick('puff.wav','puff2.wav','puff3.wav','puff4.wav','puff5.wav'),25,0)
				new/obj/smoke(loc)
			if(Spd>=12)
				ambush = 1
				spawn(34)
					ambush = 0
			cloaking = 0
	cloudoff()
		if(clouded)
			clouded=0
			if(icon_state=="sand")icon_state=""
			new/obj/sandcloud/end(loc)
			moving++
			overlay()
			pixel_y=17
			sleep(1)
			pixel_y=7
			sleep(1)
			pixel_y=0
			moving=0
	snakeoff()
		if(insnake)
			hp*=0.6+0.1*tier42
			snared(42-14*tier42,4)
			insnake=0
			iconrefresh()
			overlay()
			if(mybar)mybar:updatebar()
			if(mybar2)mybar2:updatebar()
	minedeath()
		if(hp<=0&&!dead)
			if(isanimal)
				del src
				return
			if(hostamount)
				immortalitya()
				return
			world<<"<b><font color=red>[src] got blown up by a landmine!"
			for(var/obj/usable/Heaven_Scroll/M3 in src)
				M3.loc=loc
				M3:t=0
				range(16)<<"<b>[src] dropped a Heaven Scroll!"
			for(var/obj/usable/Earth_Scroll/M3 in src)
				M3.loc=loc
				M3:t=0
				range(16)<<"<b>[src] dropped a Earth Scroll!"
			hengeback()
			if(byakugan)
				byakugan=0
			for(var/mob/Clone/clone/MT in world)if(MT.cloneowner==src)del MT
			for(var/mob/Clone/shadowclone/MT in world)if(MT.cloneowner==src)del MT
			for(var/obj/neckbind/MT in loc)del MT
			if(!swim&&!smite)
				var/K=new/obj/deadbody(loc)
				cha=0
				K:name=name
				K:level=level
				K:overlays+=overlays
				K:icon=icon
			shadowoff()
			shadowsewingoff()
			dead=1
			density=0
			if(inchunin)
				deathclean(1)
				summonspawn()
				barloc()
			else

				spawn(70)deathclean()
	herodeath()
		if(pill=="hero")
			for(var/obj/items/Captured_Boar/M in src)
				src<<"<b>The boar escaped!"
				del M
			for(var/obj/items/Full_Water_Container/M in src)
				src<<"<b>Your water container spilled!"
				del M
				new/obj/items/Half_Full_Water_Container(src)
			if(!src||dead||npc==2)return
			hengeback()
			cloakoff()
			breakresting()
			if(byakugan)
				byakugan=0
			for(var/mob/Clone/clone/MT in world)if(MT.cloneowner==src)del MT
			for(var/mob/Clone/shadowclone/MT in world)if(MT.cloneowner==src)del MT
			for(var/obj/neckbind/MT in loc)del MT
			var/K=new/obj/deadbody(loc)
			K:overlays+=overlays
			K:icon=icon
			K:level=level
			K:name=name
			shadowoff()
			shadowsewingoff()
			dead=1
			density=0
			sight=0
			world<<"<b><font color=red>[src] from the [village] died from the Hero's Water's effect!"
			deaths++
			spawn(70)deathclean()
	cursedeath()
		if(curseseal)
			for(var/obj/items/Captured_Boar/M in src)
				src<<"<b>The boar escaped!"
				del M
			for(var/obj/items/Full_Water_Container/M in src)
				src<<"<b>Your water container spilled!"
				del M
				new/obj/items/Half_Full_Water_Container(src)
			if(!src||dead||npc==2)return
			hengeback()
			cloakoff()
			breakresting()
			if(byakugan)
				byakugan=0
			for(var/mob/Clone/clone/MT in world)if(MT.cloneowner==src)del MT
			for(var/mob/Clone/shadowclone/MT in world)if(MT.cloneowner==src)del MT
			for(var/obj/neckbind/MT in loc)del MT
			var/K=new/obj/deadbody(loc)
			K:overlays+=overlays
			K:icon=icon
			K:level=level
			K:name=name
			shadowoff()
			shadowsewingoff()
			dead=1
			density=0
			sight=0
			src<<"<b>You have died from the curse seal ripping your body apart."
			deaths++
			invisibility=10
			spawn(70)deathclean()

	deathdrown()
		if(energy<=0&&icon_state=="swim")
			if(isanimal)
				del src
				return
			for(var/obj/items/Captured_Boar/M in src)
				src<<"<b>The boar drowned along with you!"
				del M
			for(var/obj/items/Full_Water_Container/M in src)
				src<<"<b>Your water container spilled!"
				del M
				new/obj/items/Half_Full_Water_Container(src)
			if(!src||dead||npc==2)return
			hengeback()
			cloakoff()
			breakresting()
			if(byakugan)
				byakugan=0
			for(var/mob/Clone/clone/MT in world)if(MT.cloneowner==src)del MT
			for(var/mob/Clone/shadowclone/MT in world)if(MT.cloneowner==src)del MT
			for(var/obj/neckbind/MT in loc)del MT
			shadowoff()
			shadowsewingoff()
			dead=1
			density=0
			sight=0
			world<<"<b><font color=red>[src] from the [village] drowned from swimming!"
			deaths++
			invisibility=10
			spawn(70)deathclean()

	defeatmessage(var/mob/M)
		if(istype(src,/mob/NPC/killable/unique/roguedude))return
		if(M.isanimal&&level>=15&&rank!="Genin"&&rank!="Academy Student")
			var/T=copytext("[M]",1,length("[M]")-7)
			for(var/mob/player/G in oview(16))if(G.village==village)G<<"<b><font color=red>[src] has been mauled by a [T]!"
			return
		if(rank=="Hokage"||rank=="Kazekage"||rank=="Sound Leader")
			if(intourn != 2)
				if(village == M.village)
					reploss(5,"[rank] [src] Betrayed")
				else
					M.repgain2(5, src, "[rank] [src] Defeated")
		if(village=="Akatsuki")
			if(intourn != 2)
				if(rank=="Akatsuki Leader")
					M.repgain2(3, src, "[rank] [src] Defeated")
				if(rank=="Akatsuki Member")
					M.repgain2(1.5, src, "[rank] [src] Defeated")
		if(M.village!="None")
			if(village == M.village)
				if(pktoggle)
					for(var/mob/G in world)
						if(G.village == village)
							G<<"<b><font color=red>[M] from the [M.village] has defeated the traitor [src]!"
				else
					if(intourn != 2)
						reploss(1.5,"Villager betrayal")
						for(var/mob/player/G in world)if(G.village==village)G<<"<b><font color=red>[M] from the [M.village] has betrayed [src], a shinobi also from [village]!"
			else if(level>=15||rank!="Genin"&&rank!="Academy Student")
				if(village=="None"&&client)for(var/mob/player/G in world)G<<"<b><font color=red>[M] from the [M.village] has defeated the missing-nin [src]!"
				else
					if(M.level>=level)if(prob(25))M.repgain2(0.5,src,"Villager defeated")
					else M.repgain2(0.5,src,"Villager defeated")
					if(client)for(var/mob/player/G in world)G<<"<b><font color=red>[M] from the [M.village] has defeated [src] from the [village]!"
		else if(client)for(var/mob/player/G in world)G<<"<b><font color=red>[M], the Missing-Nin has defeated [src] from the [village]!"
		M<<"<b>You have defeated [src]!"
		src<<"<b>You have been defeated by [M]!"

	stun(var/T)
		if(shield)return
		stun++
		var/tenacity=1
		if(windshield)tenacity=0.5
		spawn(T*tenacity)
			stun--
			if(stun<0)stun=0
	winddebuff(var/T,var/wimp=0)
		winddebuff++
		if(wimp&&winddebuff==4)winddebuff=3
		if(winddebuff>8)winddebuff=8
		wrefresh++
		atkdef()
		winddebuffc()
		spawn(T)
			wrefresh--
			if(!wrefresh)
				winddebuff=0
				winddebuffc()
				atkdef()
	refreshword()
		if(client&&src)
			winset(src,"default.exp","text='[round(exp)]'")
			winset(src,"default.level","text='[level]'")
			winset(src,"default.sp","text='SP: [skillpoint]'")
			winset(src,"default.hp","text='[round(hp)]'")
			winset(src,"default.cha","text='[round(cha)]'")
	energyrefresh()if(client&&src)
		var/percent=round((energy/maxenergy)*100,10)
		if(percent>100)percent=100
		if(percent<0)percent=0
		eupdatebar()
	deathclean(E=0)
		if(istype(src,/mob/NPC/killable)||istype(src,/mob/special/Pumpkin))
			del src
			return
		if(!client&&E!=3)
			del src
			return
		hp=maxhp
		spawn(2)barloc()
		if(cha<maxcha/2)cha=round(maxcha/2)
		sharingan=0
		overlay()
		icon_state=""
		layer=3
		density=1
		dead=0
		invisibility=1
		resting=0
		freeze=0
		coffined=0
		coffinby=null
		pill=""
		pixel_y=0
		curseseal=0
		intense=0
		onwater=0
		onsand=0
		inzone=0
		clonedelay=0
		resting=0
		sandshield=0
		outburst=0
		caught=0
		substitution=0
		smite=0
		cdelay1=0
		cdelay2=0
		cdelay3=0
		cdelay4=0
		cdelay5=0
		cdelay6=0
		vdelay1=0
		vdelay2=0
		vdelay3=0
		vdelay4=0
		rasengandelay=0
		sclonedelay=0
		busy=null
		moving=0
		swim=0
		forceupdate()
		attacking=0
		flicked=0
		resting=0
		if(E==1)
			src<<"<b>You have failed the Chunin Exam."
			inchunin=0
			pktoggle=0
			affcheck()
		if(E==5)
			loc=locate(41,223,1)
			dir=NORTH
		if(E==6)
			summonspawn()
		if(E==0||E==3)
			if(buffed)
				if(buffdeath == 0)
					buffedtime = 0
			if(village == "Leaf" || village == "Sand" || village == "Sound" || village == "Akatsuki")
				var/h = round(level/3) + 10
				if(rank == "Academy Student" || rank == "Genin")
					h += 10
				if(rank == "Chunin")
					h += 20
				if(rank == "Jounin")
					h += 30
				if(rank == "ANBU")
					h += 40
				if(rank == "Hokage" || rank == "Kazekage" || rank == "Sound Leader" || rank == "Akatsuki Leader")
					h += 50
				if(village=="Leaf" && leafban!="Leaf"||village=="Sand"&&sandban!="Sand"||village=="Sound"&&soundban!="Sound")
					h *= 1.25
				if("Leaf")
					hosptime *= 1-(leafter*1.5)
				if("Sand")
					hosptime *= 1-(sandter*1.5)
				if("Sound")
					hosptime *= 1-(soundter*1.5)
				if("Akatsuki")
					hosptime *= 1-(akatter*1.5)
				hosptime = round(h)
				if(!kyuubimode)
					//hosptime=round(h-karma/2)
					//if(karma<-100)karma/=2
					if(bountyhosp)
						hosptime += bountyhosp
						if(bountyhead == 0)
							bountyhosp=0
				spawn()
					hosptime()
			else
				loc=locate(100, 268, 1)
				barloc()
				var/h = level / 1.8
				hosptime = round(h)
				spawn()
					hospjailtime()
			if(intut)
				loc = locate(109, 80, 2)
			if(testing)
				loc = locate(294, 264, 2)

	betrayal(var/tournykilled = 0)
		if(tournykilled)
			pktoggle = 0
			affcheck()
			atkdef()
			return
		if(intourn == 2)
			pktoggle = 1
			affcheck()
			atkdef()
			return
		if(clickedplayer)
			return
		clickedplayer = 1
		spawn(140)
		if(level<15)
			alert(src,"Betraying your fellow village members is unwise at your current level.")
			goto end
		//if(bounty&&pktoggle)
		//	alert(src,"You must have no bounty to toggle your betrayal.")
		//	goto end
		if(pktoggle==1)
			switch(input("Do you want to toggle betrayal off? This will disallow you to attack your own village members and the village will not have a hostile status against you.")in list("Yes","No"))
				if("Yes")
					src<<"You have toggled your betrayal off."
					for(var/obj/hudbuttons/hidable/Betrayal/M in client.screen)M.icon_state="betrayaloff"
					pktoggle=0
					affcheck()
					atkdef()
				if("No")goto end
		else
			switch(input("Do you want to toggle betrayal on? This will allow you to attack your own village members. Doing so however will reduce your village's influence heavily and you if are killed while in betrayal status by a fellow villager you will get sent to jail. Also your village Kage can boot you out of the village.")in list("Yes","No"))
				if("Yes")
					src<<"You have toggled your betrayal on."
					for(var/obj/hudbuttons/hidable/Betrayal/M in client.screen)M.icon_state="betrayalon"
					for(var/mob/player/M in world)if(M.village==village)M<<"<font color=red>[src] has gone rogue."
					pktoggle=1
					affcheck()
					atkdef()
				if("No")goto end
		overhead()
		return
		end
		clickedplayer=0
	throwingtoggle()
		if(intut)if(intut!=7||kstoggle=="Kunai")return
		if(clan=="Snake"&&tier42)
			if(insnake)
				insnake=0
				iconrefresh()
				overlay()
				if(mybar)mybar:updatebar()
				if(mybar2)mybar2:updatebar()
				return
			else
				if(!cansnake)
					src<<"<center>You must rest to recover."
					return
				insnake=1
				cansnake=0
				new/obj/shed(loc)
				soundeff('snake.wav',40,0)
				immuneslow=1
				overlays=0
				spawn(14*tier42)immuneslow=0
				iconrefresh()
				if(mybar)mybar:updatebar()
				if(mybar2)mybar2:updatebar()
				return
		if(clan=="Sand"&&level>1)
			if(clouded)
				cloudoff()
				return
			else
				if(moving||dead||stun||freeze||stun||busy||snared||sandstormslow||attacking)return
				var/T=loc
				attacking=1
				var/obj/t=new/obj/sandcloud/begin(loc)
				t.cloudbreak=0
				pixel_y=2
				spawn(2)
					if(loc==T)pixel_y=4
					else goto end
					spawn(5)
						if(loc==T)pixel_y=5
						else goto end
						spawn(1)
							if(loc==T)pixel_y=6
							else goto end
							spawn(2)
								if(loc==T)pixel_y=7
								else goto end
								spawn(2)
									loop
										if(pixel_y<23)
											spawn(1)
												if(loc==T)pixel_y++
												else goto end
												goto loop
										else
											if(t)del t
											clouded=1
											spawn(34)attacking=0
											overlay()
				return
				end
				if(t)t.cloudbreak=1
				pixel_y=0
				spawn(34)attacking=0
		else
			if(kstoggle=="Shuriken")
				kstoggle="Kunai"
				for(var/obj/hudbuttons/hidable/Throwing_Weapon_Toggle/M in client.screen)M.icon_state="kunai"
				usr<<"Your throwing weapon is now set to Kunai."
				if(intut==7)client.screen+=new/obj/tutobj/Gbut
			else
				kstoggle="Shuriken"
				for(var/obj/hudbuttons/hidable/Throwing_Weapon_Toggle/M in client.screen)M.icon_state="shuriken"
				usr<<"Your throwing weapon is now set to Shuriken."

	windshieldc()
		set background=1
		spawn(14)
			if(!windshield||dead)return
			var/threshold=0.8-0.2*tier21
			for(var/mob/M in oview(1))
				if(aff==M.aff)continue
				if(M.hp<M.maxhp*threshold)continue
				M.damage(M.maxhp*0.035)
				new/obj/willowslash(M.loc)
				M.death(usr)
			spawn()windshieldc()
	windguardian()
		spawn(14)
			var/g=maxcha*0.02
			if(hp<maxhp/3)g*=2
			for(var/mob/M in oview(1))
				if(aff==M.aff)continue
				var/damage=g
				if(damage<3)damage=3
				if(M.shield||M.sandshield&&M.clan=="Sand")damage=0
				new/obj/willowslash(M.loc)
				M.hp-=damage
				M.death(usr)
			windguardian()
	kagregen()
		set background=1
		spawn(14)
			var/egain=round(regene)
			if(stance=="Extreme Condensing")egain*=0.7
			if(stance=="Double Blades")egain*=1+(tier42*0.1)
			if(energy<maxenergy&&cha>=(15+level)/28)
				cha-=round((15+level/2)/35)
				energy+=egain
				if(mybar2)mybar2:updatebar()
				energyrefresh()
			spawn()kagregen()
	genesisregen()
		set background=1
		spawn(14)
			if(!genesis||dead)return
			cha-=30-5*tier51+maxcha*0.03
			genesistime++
			if(mybar2)
				mybar2:updatebar()
			if(cha<=0)
				genesis=0
				genesisweaken=genesistime
				spawn(420)
					genesisweaken=0
					atkdef()
				bonegolemdelay=1
				atkdef()
				regenupdate()
				ovcheck()
				for(var/obj/jutsu/medic/Mitotic_Regeneration/M in src)timerjutsu(800,M)
				spawn(800)bonegolemdelay=0
				src<<"<center><b>You don't have enough chakra to sustain your mitotic regeneration."
				for(var/obj/statuseffect/stance/mitoticregeneration/M in client.screen)del M
				return
			spawn()genesisregen()
	regenupdate()
		regenhp=0.2+Sta*0.4
		regene=5+Sta*0.5
		regencha=0.2+Int*0.3
		if(clan=="Hyuuga"&&tier31)regencha*=1+tier31/2
		if(clan=="Clay"&&tier21)regencha*=1+tier21/4
		if(clan=="Kaguya"&&tier31)regenhp+=2*tier31
		if(clan=="Copy Ninja"&&tier31)regenhp+=2*tier31
		if(clan=="Medic"&&tier41)
			regenhp+=2*tier41
			regencha+=2*tier41
		if(clan=="Senju"&&growthstance)
			regenhp*=1+(tier11*0.05)
			regencha*=1+(tier11*0.05)
		if(clan=="Sand"&&tier21)regencha*=1+tier21/2
		if(clan=="Uchiha"&&tier43)regencha*=1+tier43/2
		if(clan=="Copy Ninja"&&tier41)regencha*=1+tier43/2
		if(clan=="Yuki"&&tier41)regencha*=1+tier41/2
		if(clan=="Iron")
			regencha*=1+tier32/2
		if(powered&&rank=="Sound Leader")
			regencha*=2
			regenhp*=2
		if(rank!="Academy Student"&&rank!="Genin")regenhp+=0.5
		if(pill=="blood")regenhp*=1.5
		if(pill=="chakra")regencha*=3
		if(regenhp>30)regenhp=30
		if(bonegolem&&tier61)regenhp=40
		if(resting)
			regencha+=maxcha*0.05
			regenhp+=maxhp*0.05
			regene+=30
		if(icon_state=="swim")regene/=2
		if(buffed>=3)
			regenhp*=1.25
			regencha*=1.25
		atkdef()
		if(bleeding||imperialpierce)regenhp=0
		if(genesis)
			regenhp = 60
			regencha=0
		if(windshield)
			regencha=0
		if(deadlyshadows)
			regenhp=0
	regen()
		set background=1
		spawn(28)
			cha += regencha*2
			var/F = regenhp*2
			if(clan == "Snake" && tier33)
				F *= 1+(tier33*0.05)
				var/missinghp=(maxhp-hp)/50
				F *= 1+(missinghp*0.01)
			if(inmist < 0)
				F += maxhp * 0.03
			if(outburst)F+=maxhp*0.10
			if(special==/obj/ororing)F*=1.5
			if(special==/obj/peinring)F*=1.05
			if(clan=="Senju"&&tier62)F*=1+(tier62*0.04)
			hp+=F
			if(icon_state=="swim")
				if(energy<=0)deathdrown()
			if(clan!="Kaguya")
				energy+=regene
				energyrefresh()
			if(energy>=maxenergy)energy=maxenergy
			if(hp>maxhp)hp=maxhp
			if(cha<0)cha=0
			if(hp*1.2<maxhp)exp(0.1)
			if(cha>maxcha)cha=maxcha
			else exp(0.1)
			if(critcon)bloodstep()
			if(sharingan)
				if(clan=="Copy Ninja")
					if(!selfrally)cha-=closs
				else	cha-=closs*2
				if(cha<=0||dead)
					new/obj/eyeac(loc)
					sharingan=0
					forceupdate()
					overlay()
					view(8)<<"<font color=red>[usr] deactivates his Sharingan."
				if(cha<0)cha=0
			if(hp<maxhp)
				if(mybar)mybar:updatebar()
			if(cha<maxcha)
				if(mybar2)mybar2:updatebar()
			if(resting&&blind)
				blind-=2
				if(blind<0)blind=0
				blindrefresh()
			refreshword()
			regen()
	intense()
		set background = 1
		if(intense == 0 && weapon)
			overlay()
		intense++
		spawn(140)
			intense--
			if(intense<=0&&weapon)
				overlay()
	updatechar()
		set background=1
		spawn(140)
			if(client&&mission=="Defeat Bandits (C Rank)"&&z==2&&weedpick==0&&headgear==/obj/merchantshat&&!dead)
				var/FF=0
				for(var/mob/M in oview(10))
					if(M.clone||M.isanimal||M.dead)continue
					FF=1
				if(!FF)
					weedpick=1
					soundeff(pick('puff.wav','puff2.wav','puff3.wav','puff4.wav','puff5.wav'),25,0)
					var/mob/NPC/mission/Bandit/t=new(loc)
					t.owner=src
					t.fast=1
					step(t,WEST)
					step(t,WEST)
					step(t,WEST)
					step(t,WEST)
					t.fast=0
					var/mob/NPC/mission/Bandit/t2=new(loc)
					t2.owner=src
					t2.fast=1
					step(t2,EAST)
					step(t2,EAST)
					step(t2,EAST)
					step(t2,EAST)
					t2.fast=0
			if(freeze<0)freeze=0
			if(intense)
				if(dead||hosptime)
					intense=0
				else
					var/T=0
					for(var/mob/M in oview(12))if(aff==M.aff)T=1
					if(T==0)
						intense=0
						overlay()
			/*else
				if(karma<0)
					karma+=karmaloss
					karmaloss+=0.25
					if(karma>0)karma=0*/
			if(blind)
				blind-=1
				if(blind<0)blind=0
				blindrefresh()
			if(tier32&&clan=="Yuki")
				if(hp<maxhp*0.25-(0.05*tier32))
					critcon=1
				else
					critcon=0
			else
				if(hp<maxhp/4)
					critcon=1
				else
					critcon=0
			if(preserve)preserve--
			if(hp<maxhp/5&&clan=="Yuki"&&tier61&&!preserve&&!sandarmor)
				preserve=2
				sandarmor=maxhp*0.12
			if(relentless&&clan=="Sand")
				if(savedrelent)
					savedrelent--
				else
					relentless--
					for(var/obj/hudbuttons/Relentless/M in client.screen)
						M.icon_state="[relentless]x"
			if(z==2)
				if(onsand)
					soundeff(pick('onsand.wav','onsand2.wav','onsand3.wav','onsand4.wav'),30,0)
				else
					if(!onwater&&prob(30))soundeff(pick('amb.wav','amb2.wav','amb3.wav','amb4.wav','amb5.wav'),20,0)
			spawn()updatechar()
	bloodstep()
		set background = 1
		new/obj/bloodstep(loc)
		runstep=0
		if(running)
			icon_state=""
			running=0
	pkkills()
		set background = 1
		if(pkkills)pkkills--
		spawn(2520)pkkills()
	handseals(var/U,var/speed,var/C,var/M=0,var/freezese=0)
		sealpass=0
		if(npc==4||shield||caught||godmode||freeze||silenced)return
		if(imitated&&M)return
		var/D=con
		if(disruption)
			U*=1+0.25*disruption
			D*=1-0.15*disruption
		if(speed>0)
			speed+=handseals
			speed-=sharingan/2
			if(weapon)
				speed+=1.5
			if(silenced)speed*=1.3
			if(speed>0)
				seals=1
				if(freezese)stun(freezese)
				exp(0.1)
				icon_state="seals"
				sleep(speed)
				soundeff('seal.wav',25,0)
				icon_state=""
				seals=0
		if(D>=C+5||pill=="control"||powered&&rank=="Hokage"||powered&&rank=="Kazekage")
			if(U<=5)U=0
			U=round(U*0.75)
			if(cha<U)
				if(clan=="Uchiha"&&tier53)
					hp-=hp*(0.35-0.05*tier53)
					new/obj/demonic(loc)
					cha+=maxcha/2
					mybar:updatebar()
					mybar2:updatebar()
				else
					src<<"You do not have enough chakra!"
					return
			cha-=U
			if(mybar2)mybar2:updatebar()
			sealpass=1
			return
		if(D<C)
			var/Z=round(U/2)
			var/H=Z
			if(D>C/2)
				Z=round(Z/1.5)
				H=-round(H/2.5)
			if(D>C/1.7)
				Z=round(Z/1.5)
				H=-round(H/3.5)
			if(D>C/1.4)
				Z=round(Z/1.5)
				H=0
			if(D>C/1.2)Z=round(Z/1.5)
			var/B=U+rand(-H,Z)
			if(B<1)B=1
			if(cha<B)
				if(clan=="Uchiha"&&tier53)
					hp-=hp*(0.35-0.05*tier53)
					new/obj/demonic(loc)
					cha+=maxcha/2
					mybar:updatebar()
					mybar2:updatebar()
				else
					src<<"You do not have enough chakra!"
					return
			if(B>=U)
				if(B>U)
					src<<"You executed your jutsu but wasted some chakra."
				cha-=B
				if(mybar2)mybar2:updatebar()
				sealpass=1
			else
				if(M)src<<"You failed to control your chakra."
				else src<<"You failed to control your chakra."
			return
		if(D>=C&&D<C+5)
			if(cha<U)
				src<<"You do not have enough chakra!"
				return
			cha-=U
			if(mybar2)mybar2:updatebar()
			sealpass=1
	shellchakra()
		set background = 1
		spawn(14)
			if(busy!="shield"||!sandshield)
				shelloff()
				return
			if(level<100)cha-=20-(tier22*5)+maxcha*(0.05-tier22*0.01)
			else cha-=(20-(tier22*5)+maxcha*(0.05-tier22*0.01))*0.7
			if(cha<0)cha=0
			if(mybar2)mybar2:updatebar()
			if(cha==0)
				shelloff()
				return
			spawn()shellchakra()
	//shelloff
	shelloff()
		busy=null
		for(var/obj/sandbarrier/M in range(8))if(M.owner==src)del M
		sandshield=0
		atkdef()
		spawn(60-tier41-10)cdelay1=0

mob/proc
	prejutsu()
		if(intense<3)intense()
		if(running)
			icon_state=""
			running=0
			runstep=0
		hengeback()
		cloakoff()
		cloudoff()
		snakeoff()
		if(subinvis)
			subinvis=0
	stepback(K,G=1,I=0)
		fast=1
		if(!I)
			if(critcon)K-=3
			if(sandstormslow||snared)K-=4
		loop
			if(!src||imitated||paralysed||npc==2||rank=="Bijuu"||imitation)return
			if(K>0)
				K--
				if(G!=3)
					var/image=new/obj/kimage(loc)
					image:dir=dir
					image:icon=icon
					image:overlays=overlays
					image:invisibility=invisibility
				moving=0
				var/P=dir
				if(dir==NORTH)
					step(src,SOUTH)
					goto tisk
				if(dir==SOUTH)
					step(src,NORTH)
					goto tisk
				if(dir==EAST)
					step(src,WEST)
					goto tisk
				if(dir==WEST)
					step(src,EAST)
					goto tisk
				tisk
				dir=P
				runstep=0
				spawn(1)goto loop
		fast=0
	magnetic(K,loopz,var/T=0)
		if(npc>=2||rank=="Bijuu")return
		loop
			if(T)density=0
			if(loopz>0)
				loopz--
				var/image=new/obj/kimage(loc)
				image:dir=dir
				image:icon=icon
				image:overlays=overlays
				image:invisibility=invisibility
				moving=0
				step_towards(src,K)
				goto loop
			else
				if(T)density=1
	stepup(K,I)
		fast = 1
		if(!I)
			if(critcon)
				K-=3
			if(snared)
				K-=4
		loop
			if(!src||imitated||paralysed||npc==2||rank=="Bijuu"||imitation)return
			if(K > 0)
				K --
				if(!istype(src,/mob/Animal))
					var/image = new/obj/kimage(loc)
					image:dir = dir
					image:icon = icon
					image:overlays = overlays
					image:invisibility = invisibility
				moving = 0
				step(src, dir)
				spawn(1)
					goto loop
		fast = 0
	chidorimove()
		if(!src||imitated||paralysed||imitation||busy!="chidori"&&busy!="raikiri")return
		step(src,dir)
		moving=0
		spawn(1)chidorimove()
	timer()
		set background=1
		while(src&&client)
			if(afkcheck)
				if(client.inactivity<1000)
					afkcheck=0
					overhead()
			client.seconds++
			cleartime++
			if(scorchedcd>0)scorchedcd--
			if(kusan&&kusan<11)
				kusan++
				relentless(1)
			if(cleartime>=clearcap)
				cleartime=0
				src<<output(null,"output1")
				src<<"<center>Your screen has been cleared."
			if(ancestorboost>0)
				ancestorboost--
				if(ancestorboost==0)
					for(var/obj/hudbuttons/boost/G in usr.client.screen)del G
			if(secretpower>0)
				secretpower--
				if(secretpower==0)
					for(var/obj/hudbuttons/superboost/G in usr.client.screen)del G
			if(goldscroll>0)
				goldscroll--
				if(goldscroll==0)
					for(var/obj/hudbuttons/superboost/G in usr.client.screen)del G
			if(shrinecd>0)shrinecd--
			if(missioned>0)
				missioned--
				if(missioned==0)
					client.screen+=new/obj/hudbuttons/Mission
					src<<"<font color=coral><center>________________________________"
					src<<"<br>"
					src<<"<font color=coral><center>You have a new mission available"
					src<<"<br>"
					src<<"<font color=coral><center>________________________________"
			if(client.seconds>=60)
				client.seconds=0
				client.minutes++
			if(client.minutes>=60)
				client.minutes=0
				client.hours++
			if(client.hours>=24)
				client.hours=0
				client.days++
			if(client.days>=7)
				client.days=0
				client.weeks++
			if(client.minutes==15&&client.hours==0&&client.seconds==0&&client.days==0&&client.weeks==0)medal(1,8)
			if(client.minutes==0&&client.hours==1&&client.seconds==0&&client.days==0&&client.weeks==0)medal(1,9)
			if(client.minutes==0&&client.hours==6&&client.seconds==0&&client.days==0&&client.weeks==0)medal(1,10)
			if(client.minutes==0&&client.hours==0&&client.seconds==0&&client.days==1&&client.weeks==0)medal(2,6)
			if(client.minutes==0&&client.hours==0&&client.seconds==0&&client.days==0&&client.weeks==1)medal(2,7)
			if(client.minutes==0&&client.hours==0&&client.seconds==0&&client.days==0&&client.weeks==3)medal(3,4)
			sleep(10)
	breakresting()
		if(resting)
			src<<"<b>Someone interupted your rest!"
			resting=0
			spawn(70)
				restdef=0
				atkdef()
			attacking=0
			freeze=0
			stun=0
			icon_state=""
			regenupdate()
			moving=0
			see_invisible+=3
			if(see_invisible>3)see_invisible=3
			if(blind)blindrefresh()
		if(meditating)
			src<<"<b>You broke your meditation!"
			meditating=0
			attacking=0
			freeze=0
			stun=0
			icon_state=""
			moving=0
			for(var/obj/chakraarrow/M in world)if(M.owner==src)del M
			for(var/obj/chakraball/M in world)if(M.owner==src)del M
	breakmed()
		src<<"<b>You broke your meditation!"
		meditating=0
		attacking=0
		freeze=0
		stun=0
		icon_state=""
		moving=0
		for(var/obj/chakraarrow/M in world)if(M.owner==src)del M
		for(var/obj/chakraball/M in world)if(M.owner==src)del M
	faceme(var/mob/M)
		if(M.rank=="Bijuu")return
		if(dir==NORTH)M.dir=SOUTH
		if(dir==SOUTH)M.dir=NORTH
		if(dir==EAST)M.dir=WEST
		if(dir==WEST)M.dir=EAST
	faceme2(var/mob/M)
		if(M.rank=="Bijuu")return
		if(y<M.y)M.dir=SOUTH
		if(y>M.y)M.dir=NORTH
		if(x<M.x)M.dir=WEST
		if(x>M.x)M.dir=EAST
	strikeblow(var/mob/M,var/damage)
		if(dead)return
		if(M.clan=="Taijutsu Specialist")
			if(M.tier32)damage*=1-(M.tier32*0.05)
		M.dmgch(src,1)
		damage=(damage*M.variable)+M.variable2
		if(prob(50))flick("attack",src)
		else flick("attack",src)
		moving=0
		loc=M.loc
		barloc()
		step_rand(src)
		moving=0
		if(M)
			step_towards(src,M)
			M.damage(damage)
			if(M.mybar)M.mybar:updatebar()
			if(M.mybar2)M.mybar2:updatebar()
			if(tier21)
				M.disabled(src,0.5*tier21*2)
			M.silenced(30)
			if(level>=80)M.snared(60,1)
	hengeback()
		if(henge)
			new/obj/smoke(loc)
			soundeff(pick('puff.wav','puff2.wav','puff3.wav','puff4.wav','puff5.wav'),25,0)
			overlays=null
			overlays=savedoverlays
			icon=icon_name
			if(bonegolem)icon='basebone.dmi'
			tmpclan=clan
			tmpstatus=status
			tmpvillage=village
			tmprank=rank
			icon_state=""
			name=savedname
			henge=0
			mouseovername()
	blindrefresh()
		if(sharingan==4)
			fade.Map(src, -50+blind*2.55, 255, 1)
		else
			fade.Map(src, blind*2.55, 255, 1)
		if(blind>=255)blind=255
	coffinoff()
		freeze=0
		busy=""
		icon_state=""
		for(var/obj/coffinmove/M in world)if(M.owner==src)del M
		for(var/obj/coffinmovetrail/T in world)if(T.owner==src)del T
	firecharge(var/K)
		var/I=0
		loop
			if(I<K)
				spawn(1)
					I++
					var/J=new/obj/fireballcharge(loc)
					spawn(1)
					step(J,dir)
					goto loop
	repgain(var/repamount,var/reason="Unknown",var/chance=100)
		if(goldenage!="none")return
		if(village=="Leaf"&&leafpriority=="Influence"||village=="Sand"&&sandpriority=="Influence"||village=="Sound"&&soundpriority=="Influence")repamount=repamount*1.2
		if(clan=="Copy Ninja"&&tier21)repamount*=1+(tier21*0.05)
		var/appearrep=repamount*0.7
		if(village=="None"||village=="Akatsuki")return
		if(village=="Leaf")
			repamount*=leafunder
			leafrep+=repamount
			if(sandrep>80)
				if(sandpriority=="Appearance")sandrep-=appearrep/2
				else sandrep-=repamount/2
			if(soundrep>80)
				if(soundpriority=="Appearance")soundrep-=appearrep/2
				else soundrep-=repamount/2
		if(village=="Sand")
			repamount*=sandunder
			sandrep+=repamount
			if(leafrep>80)
				if(leafpriority=="Appearance")leafrep-=appearrep/2
				else leafrep-=repamount/2
			if(soundrep>80)
				if(soundpriority=="Appearance")soundrep-=appearrep/2
				else soundrep-=repamount/2
		if(village=="Sound")
			repamount*=soundunder
			soundrep+=repamount
			if(leafrep>80)
				if(leafpriority=="Appearance")leafrep-=appearrep/2
				else leafrep-=repamount/2
			if(sandrep>80)
				if(sandpriority=="Appearance")sandrep-=appearrep/2
				else sandrep-=repamount/2
		repcontribute+=repamount
		if(repamount>=1.5)
			for(var/mob/M in world)
				if(M.village==village)M<<"<b><font color=lime>Village Info: [village] has gained [repamount] influence!([reason])"
				else
					if(M.village=="Leaf")
						if(leafpriority=="Appearance")M<<"<b><font color=lime>Village Info: [M.village] has lost [round(appearrep/2,0.05)] influence!([village] gained influence)"
						else M<<"<b><font color=lime>Village Info: [M.village] has lost [round(repamount/2,0.05)] influence!([village] gained influence)"
					if(M.village=="Sand")
						if(sandpriority=="Appearance")M<<"<b><font color=lime>Village Info: [M.village] has lost [round(appearrep/2,0.05)] influence!([village] gained influence)"
						else M<<"<b><font color=lime>Village Info: [M.village] has lost [round(repamount/2,0.05)] influence!([village] gained influence)"
					if(M.village=="Sound")
						if(soundpriority=="Appearance")M<<"<b><font color=lime>Village Info: [M.village] has lost [round(appearrep/2,0.05)] influence!([village] gained influence)"
						else M<<"<b><font color=lime>Village Info: [M.village] has lost [round(repamount/2,0.05)] influence!([village] gained influence)"
		else src<<"<b><font color=lime>Village Info: [village] has gained [repamount] influence!([reason])"
		goldenage(src)
	repgain2(var/repamount,var/mob/M,var/reason="Unknown",var/reason2="Unknown")
		if(goldenage!="none")return
		if(village=="Leaf"&&leafpriority=="Influence"||village=="Sand"&&sandpriority=="Influence"||village=="Sound"&&soundpriority=="Influence")repamount=repamount*1.2
		if(clan=="Copy Ninja"&&tier21)repamount*=1+(tier21*0.05)
		var/appearrep=repamount*0.7
		if(village=="None"||village=="Akatsuki")return
		if(M.village=="None"||M.village=="Akatsuki")
			repgain(repamount,reason,reason2)
			return
		if(village=="Leaf")
			leafrep+=repamount
			if(M.village=="Sand"&&sandrep>80)
				if(sandpriority=="Appearance")sandrep-=appearrep
				else sandrep-=appearrep
			if(M.village=="Sound"&&soundrep>80)
				if(soundpriority=="Appearance")soundrep-=appearrep
				else soundrep-=appearrep
		if(village=="Sand")
			sandrep+=repamount
			if(M.village=="Leaf"&&leafrep>80)
				if(leafpriority=="Appearance")leafrep-=appearrep
				else leafrep-=appearrep
			if(M.village=="Sound"&&soundrep>80)
				if(soundpriority=="Appearance")soundrep-=appearrep
				else soundrep-=appearrep
		if(village=="Sound")
			soundrep+=repamount
			if(M.village=="Sand"&&sandrep>80)
				if(sandpriority=="Appearance")sandrep-=appearrep
				else sandrep-=appearrep
			if(M.village=="Leaf"&&leafrep>80)
				if(leafpriority=="Appearance")leafrep-=appearrep
				else leafrep-=appearrep
		repcontribute+=repamount
		M.repcontribute-=repamount
		if(repamount>=1.5)
			for(var/mob/M2 in world)if(M2.village==village)M2<<"<b><font color=lime>Village Info: [village] has gained [repamount] influence!([reason])"
			for(var/mob/M2 in world)if(M2.village==M.village)M2<<"<b><font color=lime>Village Info: [M.village] has lost [repamount] influence!([reason])"
		else
			src<<"<b><font color=lime>Village Info: [village] has gained [repamount] influence!([reason])"
			M<<"<b><font color=lime>Village Info: [M.village] has lost [repamount] influence!([reason])"
		goldenage(src)
	reploss(var/repamount,var/reason="Unknown")
		if(goldenage!="none")return
		if(village=="Leaf"&&leafpriority=="Appearance"||village=="Sand"&&sandpriority=="Appearance"||village=="Sound"&&soundpriority=="Appearance")repamount=round(repamount*0.7,0.25)
		var/appearrep=repamount*1.2
		if(village=="None"||village=="Akatsuki")return
		if(village=="Leaf")
			if(leafrep<80)return
			leafrep-=repamount
			if(sandpriority=="Influence")sandrep+=appearrep/2
			else sandrep+=repamount/2
			if(soundpriority=="Influence")soundrep+=appearrep/2
			else soundrep+=repamount/2
		if(village=="Sand")
			if(sandrep<80)return
			sandrep-=repamount
			if(leafpriority=="Influence")leafrep+=appearrep/2
			else leafrep+=repamount/2
			if(soundpriority=="Influence")soundrep+=appearrep/2
			else soundrep+=repamount/2
		if(village=="Sound")
			if(soundrep<80)return
			soundrep-=repamount
			if(leafpriority=="Influence")leafrep+=appearrep/2
			else leafrep+=repamount/2
			if(sandpriority=="Influence")sandrep+=appearrep/2
			else sandrep+=repamount/2
		if(repamount>=1.5)
			for(var/mob/M in world)
				if(M.village==village)M<<"<b><font color=lime>Village Info: [village] has lost [repamount] influence!([reason])"
				else
					if(M.village=="Leaf")
						if(leafpriority=="Appearance") M<<"<b><font color=lime>Village Info: [M.village] has gained [round(appearrep/2,0.05)] influence!([village] lost influence)"
						else M<<"<b><font color=lime>Village Info: [M.village] has gained [round(repamount/2,0.05)] influence!([village] lost influence)"
					if(M.village=="Sand")
						if(sandpriority=="Appearance") M<<"<b><font color=lime>Village Info: [M.village] has gained [round(appearrep/2,0.05)] influence!([village] lost influence)"
						else M<<"<b><font color=lime>Village Info: [M.village] has gained [round(repamount/2,0.05)] influence!([village] lost influence)"
					if(M.village=="Sound")
						if(soundpriority=="Appearance") M<<"<b><font color=lime>Village Info: [M.village] has gained [round(appearrep/2,0.05)] influence!([village] lost influence)"
						else M<<"<b><font color=lime>Village Info: [M.village] has gained [round(repamount/2,0.05)] influence!([village] lost influence)"
		else src<<"<b><font color=lime>Village Info: [village] has lost [round(repamount,0.05)] influence!([reason])"
		goldenage(src)
	rapidkilling()
		hp+=maxhp/4
		cha+=maxcha/4
		if(hp>maxhp)hp=maxhp
		if(cha>maxcha)cha=maxcha
		rapidkilling++
		atkdef()
		ovcheck()
		spawn(70)
			rapidkilling--
			atkdef()
			ovcheck()
	didyouknow()
		var/g=rand(1,48)
		switch(g)
			if(1)g="You deal 15% more damage and take 10% less damage when fighting in your village territory. The exception is Sand villagers, who take 20% less damage."
			if(2)g="You take 80% less damage if you are under level 10, don't have betrayal turned on and is in your own village territory."
			if(3)g="You can move around in your dance of the seedling ferns."
			if(4)g="Uchihas can deal respectable damage with their melee and taijutsu skills even if they focus on ability power with the tier 5 skill Sharingan Mastery."
			if(5)g="Using Clone jutsu then using substitution when the illusion is almost over can cover a lot of distance against a chasing enemy."
			if(6)g="You can use transformation jutsu on dead bodies."
			if(7)g="You can transform into an inanimate object to get wild animals off your back."
			if(8)g="Snake users' Immortality Jutsu has a lengthy cooldown when they revive and when they take a new body. While it is on cooldown they can not revive.."
			if(9)g="You can shoot sand shurikens while you are using sand suspension and sand shield."
			if(10)g="The official forum for NNG is http://narutonextgen.forumotion.com/"
			if(11)g="The more karma you have, the less time you have to spend in a hospital. The opposite applies as well."
			if(12)g="Karma is capped at -300 and +300."
			if(13)g="You can be transformed while you are sabotaging an enemy mission billboard."
			if(14)g="You gain a base amount of 3 health and 2 chakra per level."
			if(15)g="You should always keep track of the question number when you're doing the Chunin exam."
			if(16)g="You gain a skill point every 3 levels."
			if(17)g="The level cap starts at 60, and increases by 20 every rebirth up to a maximum of 120."
			if(18)g="You can hold the direction you're going while in Chidori or Raikiri to charge even faster."
			if(19)g="The more intelligence you have, the lower the cost for maintaining Sharingan."
			if(20)g="You gain a extra skill point when you rebirth."
			if(21)g="For every golden age a village doesn't get, their influence gains are increased by 25%."
			if(22)g="It is more efficient to store experience while your village influence is high and then train when it's low."
			if(23)g="You can respec your skill tree at the iron village for a hefty price."
			if(24)g="Clothing merchants update their inventory every 5 minutes."
			if(25)g="Yuki's hidden mist jutsu dissipates as you walk around them. Try to clear it and fight defensively while it is up."
			if(26)g="Shurikens, kunais, bone bullet, sand shuriken, fuuma shuriken, senbons and senbon wave deals up to 300% damage based on how far they have been thrown. The further it has been thrown, the more damage will be dealt."
			if(27)g="Banners spawn a Chunin NPC after 5 minutes of capture, another after 20 minutes, a ANBU at 60 minutes and another at 120 minutes."
			if(28)g="Banners give up to 300 experience, depending on how long it has been since it was last captured(0.5 exp a second)."
			if(29)g="Capturing a bandum gives the capturer's village 10% experience as long as it remain captured."
			if(30)g="If your village has its bandum controlled by another village, your hospital time will be 25% longer."
			if(31)g="You can not use advanced tracking to return to your village if your bandum is captured."
			if(32)g="Capturing a bandum puts a 30 minute cooldown on the bandum being captured again."
			if(33)g="The NPC outside Genin exam tells you the timer on next Genin exam."
			if(34)g="The Chunin instructor tells you the timer on next Chunin exam."
			if(35)g="Getting 30 reputation changes the color of your text to gold."
			if(36)g="You can get a bingo book from any supply NPC."
			if(37)g="A chakra tracker helps with bounty hunting immensely."
			if(38)g="A hidden secret society places bounties occasionally to people who have slain another player."
			if(39)g="Chidori transforms into Amaterasu Unleash when Mangekyou Sharingan is activated. While landing Chidori deals more upfront damage, Amaterasu Unleash has 3 times less cooldown and has massive damage potential."
			if(40)g="Slowing a enemy Uchiha dramatically increases the amount of time it takes to charge Chidori up."
			if(41)g="Be wary of high level Uchihas with a purple aura as they are using the skill Vengeance. While this ability is activated all damage dealt to them will not only be largely mitigated, but will only take effect after Vengeance ends."
			if(42)g="Know when to fight and when to run. Also know when to turn around and surprise the enemy."
			if(43)g="Iron clan deals a lot of damage and can quickly whittle you down, but are susceptible to getting bursted down when their iron rain is on cooldown."
			if(44)g="The iron clan gets a lot of passive buffs while their iron rain is up. It would be wise to wait until the opportune moment to attack them."
			if(45)g="It is imperative to dodge the abilities of sand manipulators, as skilled sand users can hit you with all their abilities if even one lands."
			if(46)g="Mangekyou Sharingan cuts 2% of the user's maximum health and reduces the user's defense by 1% every second. The debuff lasts until 30 seconds after Mangekyou is deactivated."
			if(47)g="It is imperative to not have extended close ranged trades with high leveled Hyuugas, as their sustained damage is massive."
			if(48)g="The damage boost from Hurricane on dragon storm is activated when the tornado appears, and deactivating the stance afterwards will not reduce the damage of the storm."
		src<<"<font size=2><center><b><i><u>Did You Know:</u> [g]"

var/goldenagetime=0
proc
	goldenage(var/M)
		if(goldenage=="none")
			if(leafrep>=140)
				world<<"<b><font color=yellow><font size=3><center>[M] has triggered a Leaf golden age for 20 minutes!"
				world<<"<b><font color=yellow><font size=2><center>Leaf villagers will now gain 50% more experience! Leaf villagers are also worth 20% more experience on kill."
				if(!M:goldenagetrig)
					M:goldenagetrig=1
					M:medal(1,20)
				goldenage="leaf"
				leafrep=150
				sandrep=80
				soundrep=80
				leafunder=1
				sandunder+=0.25
				soundunder+=0.25
				goldenagetime=20
				for(var/mob/player/Mz in world)if(Mz.client)Mz.goldenaging()
				spawn(840)goldenagetime=19
				spawn(840*2)goldenagetime=18
				spawn(840*3)goldenagetime=17
				spawn(840*4)goldenagetime=16
				spawn(840*5)goldenagetime=15
				spawn(840*6)goldenagetime=14
				spawn(840*7)goldenagetime=13
				spawn(840*8)goldenagetime=12
				spawn(840*9)goldenagetime=11
				spawn(840*10)goldenagetime=10
				spawn(840*11)goldenagetime=9
				spawn(840*12)goldenagetime=8
				spawn(840*13)goldenagetime=7
				spawn(840*14)goldenagetime=6
				spawn(840*15)goldenagetime=5
				spawn(840*16)goldenagetime=4
				spawn(840*17)goldenagetime=3
				spawn(840*18)goldenagetime=2
				spawn(840*19)goldenagetime=1
				spawn(16800)
					goldenagetime=0
					world<<"<b><font color=silver><font size=3><center>The Leaf golden age is over!"
					goldenage="none"
					leafrep=95
					sandrep=105
					soundrep=105
			else if(sandrep>=140)
				world<<"<b><font color=yellow><font size=3><center>[M] has triggered a Sand golden age for 20 minutes!"
				world<<"<b><font color=yellow><font size=2><center>Sand villagers will now gain 50% more experience! Sand villagers are also worth 20% more experience on kill."
				goldenage="sand"
				leafrep=80
				sandrep=150
				soundrep=80
				sandunder=1
				leafunder+=0.25
				for(var/mob/player/Mz in world)if(Mz.client)Mz.goldenaging()
				soundunder+=0.25
				goldenagetime=20
				spawn(840)goldenagetime=19
				spawn(840*2)goldenagetime=18
				spawn(840*3)goldenagetime=17
				spawn(840*4)goldenagetime=16
				spawn(840*5)goldenagetime=15
				spawn(840*6)goldenagetime=14
				spawn(840*7)goldenagetime=13
				spawn(840*8)goldenagetime=12
				spawn(840*9)goldenagetime=11
				spawn(840*10)goldenagetime=10
				spawn(840*11)goldenagetime=9
				spawn(840*12)goldenagetime=8
				spawn(840*13)goldenagetime=7
				spawn(840*14)goldenagetime=6
				spawn(840*15)goldenagetime=5
				spawn(840*16)goldenagetime=4
				spawn(840*17)goldenagetime=3
				spawn(840*18)goldenagetime=2
				spawn(840*19)goldenagetime=1
				spawn(16800)
					goldenagetime=0
					world<<"<b><font color=silver><font size=3><center>The Sand golden age is over!"
					goldenage="none"
					leafrep=105
					sandrep=95
					soundrep=105
			else if(soundrep>=140)
				world<<"<b><font color=yellow><font size=3><center>[M] has triggered a Sound golden age for 20 minutes!"
				world<<"<b><font color=yellow><font size=2><center>Sound villagers will now gain 50% more experience! Sound villagers are also worth 20% more experience on kill."
				goldenage="sound"
				leafrep=80
				sandrep=80
				soundrep=150
				soundunder=1
				leafunder+=0.25
				sandunder+=0.25
				for(var/mob/player/Mz in world)if(Mz.client)Mz.goldenaging()
				goldenagetime=20
				spawn(840)goldenagetime=19
				spawn(840*2)goldenagetime=18
				spawn(840*3)goldenagetime=17
				spawn(840*4)goldenagetime=16
				spawn(840*5)goldenagetime=15
				spawn(840*6)goldenagetime=14
				spawn(840*7)goldenagetime=13
				spawn(840*8)goldenagetime=12
				spawn(840*9)goldenagetime=11
				spawn(840*10)goldenagetime=10
				spawn(840*11)goldenagetime=9
				spawn(840*12)goldenagetime=8
				spawn(840*13)goldenagetime=7
				spawn(840*14)goldenagetime=6
				spawn(840*15)goldenagetime=5
				spawn(840*16)goldenagetime=4
				spawn(840*17)goldenagetime=3
				spawn(840*18)goldenagetime=2
				spawn(840*19)goldenagetime=1
				spawn(16800)
					goldenagetime=0
					world<<"<b><font color=silver><font size=3><center>The Sound golden age is over!"
					goldenage="none"
					leafrep=105
					sandrep=105
					soundrep=95
obj/proc
	projduel(var/obj/M)
		if(!M.projint)
			del src
		if(M.projint<0)
			loc=M.loc
			return
		if(!M.owner||!owner)
			del src
		M.projint*=M.owner.proficiency
		projint*=owner.proficiency
		if(M.projint>projint)
			M.projint--
			if(M.projint<0.5)M.projint=0.5
			del src
		if(M.projint==projint)
			del M
			del src
		if(M.projint<projint)
			loc=M.loc
			projint--
			if(projint<0.5)projint=0.5
			del M
	collision(var/mob/M,var/iconstate,var/northy,var/southy,var/westx,var/eastx)
		if(!M)return
		var/K=new/obj/collision
		K:icon_state="[iconstate]"
		K:name=name
		K:dir=dir
		if(K:dir==NORTH)K:pixel_y+=-northy
		if(K:dir==SOUTH)
			K:layer=2
			K:pixel_y+=southy
		if(K:dir==EAST)K:pixel_x+=-eastx
		if(K:dir==WEST)K:pixel_x+=westx
		K:owner=M
		K:loc=M.loc
		M.collision++
	projectile(var/mob/O,var/mob/M,var/G,var/C,perko2=0)
		if(!O||!M)
			del src
			return
		if(O.inchunin!=4)if(M==O||O.aff==M.aff)
			loc=M.loc
			return
		if(M.illusion)
			M.illusionhit(O)
			return
		O.critroll(M)
		var/damage=G
		M.dmgch(O)
		if(M.pines)if(M.pines==1)damage*=0.6
		var/random=rand(1,100-C)
		if(istype(src,/obj/icenee))
			M.needlehit()
			if(M.frostmark)M.frostmarktrigger(O)
		if(perko2&&O.perk3==4)
			if(!O.hyugdelay)
				O.hyugdelay(120)
				if(M.snared)
					M.stun(10)
				else
					M.snared(30,1)
		if(O.criticalroll>=random)
			if(O.clan=="Yuki"&&O.tier33)
				if(istype(src,/obj/proj/breakable/Senbon)||istype(src,/obj/senbonwave)||istype(src,/obj/Mirror_Senbon))
					M.snared(30,3)
			M.damage(damage,1.5)
		else
			M.damage(damage)
		M.death(O)
		del(src)
	projectilef(var/mob/O,var/mob/M,var/G,var/T)
		if(!O||!M)
			del src
			return
		if(O.inchunin!=4)if(M==O||O.aff==M.aff)
			loc=M.loc
			return
		if(M.illusion)
			M.illusionhit(O)
			return
		var/damage=G
		M.dmgch(O)
		damage=(damage*M.variable)+M.variable2
		M.damage(damage)
		if(!M.busy)
			M.busy="frozen"
			spawn(T)M.busy=""
		M.death(O)
		loc=locate(0,0,0)
		spawn(T*2)del(src)
	projectilep(var/mob/O,var/mob/M,var/G,var/C,perko2=0)
		if(!O||!M)
			del src
			return
		if(O.inchunin!=4)if(M==O||O.aff==M.aff)
			loc=M.loc
			return
		if(M.illusion)
			M.illusionhit(O)
			return
		loc=M.loc
		var/damage=G
		M.dmgch(O)
		damage=(damage*M.variable)+M.variable2
		O.critroll(M)
		var/random=rand(1,100-C)
		if(perko2&&O.perk3==4)
			if(!O.hyugdelay)
				O.hyugdelay(120)
				if(M.snared)
					M.stun(10)
				else
					M.snared(30,1)
		if(O.criticalroll>=random)
			if(O.clan=="Yuki"&&O.tier33)
				if(istype(src,/obj/proj/breakable/Senbon)||istype(src,/obj/senbonwave)||istype(src,/obj/Mirror_Senbon))
					M.snared(30,3)
			M.damage(damage,1.5)
		else
			M.damage(damage)
		M.death(O)
		if(M)if(M.rank=="Bijuu")del src
	barrageproc(var/time)
		var/times=0
		density=1
		loop
			if(times<time)
				times++
				var/L=new/obj/proj/breakable/Kunai(loc)
				L:owner=owner
				walk(L,dir)
				spawn(3)goto loop
			else
				spawn(21)
				del src
	burn(var/mob/M,var/sec,var/third,rad)
		for(var/turf/T in oview(src,rad))
			for(var/obj/fire/G in oview(T,0))continue
			var/V=new/obj/fire(locate(T.x,T.y,T.z))
			V:fire(sec)
			T.burning(M,third)
		del src
	blackburn(var/mob/M,var/sec,var/third,rad)
		for(var/turf/T in oview(src,rad))
			for(var/obj/blackfire/G in oview(T,0))continue
			var/V=new/obj/blackfire(locate(T.x,T.y,T.z))
			V:fire(sec)
			T.burning(M,third)
		del src
	burntroj(var/mob/M,var/sec,var/third,rad)
		for(var/turf/T in oview(src,rad))
			for(var/obj/fire/G in oview(T,0))continue
			var/V=new/obj/fire(locate(T.x,T.y,T.z))
			V:fire(sec)
			T.burning(M,third)
	burnharmless(var/mob/M)
		for(var/obj/beenest/T in oview(src,2))
			if(T.icon_state=="")
				var/mob/Bees/B=new(T.loc)
				B.owner=owner
				owner<<"<b>You have startled the swarm! Use the bomb when the nest is idle!"
			else
				for(var/obj/usable/Bee_Killing_Blaze_Bomb/M2 in owner)del M2
				owner<<"<b>You have burned the bee nest! Return to kage house to get your reward!"
				new/obj/items/Burned_Bee_Nest(owner)
				var/G=T.loc
				T.loc=locate(0,0,0)
				spawn(420)T.loc=G
		for(var/turf/T in oview(src,2))
			var/V=new/obj/fire(locate(T.x,T.y,T.z))
			V:fire(10)
	burngreat(var/mob/M)
		for(var/mob/A in oview(src,3))
			if(M.inchunin!=4)if(M==A||A.aff==M.aff)continue
			var/damage=M.pow*1.2
			if(M.clan=="Copy Ninja")damage*=0.85
			A.dmgch(M)
			damage=(damage*A.variable)+A.variable2
			A.damage(damage)
			A.ignite(owner)
			A.death(M)
		for(var/turf/T in oview(src,3))
			for(var/obj/fire/G in oview(T,0))continue
			var/V=new/obj/fire(locate(T.x,T.y,T.z))
			V:fire(50)
			T.burning(M,10)
		del src
obj/blackfire
	icon='amaterasu.dmi'
	layer=50
	proc/fire(var/T)spawn(T)del src
	New()
		..()
		icon_state=pick("1","2")
		new/obj/bfire2(loc)
		if(prob(40))new/obj/bfire2(loc)
		if(prob(40))
			new/obj/bfire2(loc)
			new/obj/bfire2(loc)
		spawn(rand(40,120))del src
obj/blackfdmg
	New()
		spawn(rand(40,120))del src
		spawn(1)
			loop
				if(!owner)del src
				for(var/mob/M in loc)if(M!=owner&&!M.dead)
					if(owner.aff==M.aff||M.amathit)continue
					var/damage=owner.pow*1.3
					M.dmgch(owner)
					damage=(damage*M.variable)+M.variable2
					if(owner.clan=="Uchiha"&&owner.tier31)damage*=1.05+0.05*owner.tier31
					M.damage(damage)
					M.amathit()
					M.ignite(owner)
					if(M)M.death(owner)
				spawn(rand(5,12))goto loop
//mob/verb/amaterasujutsu()
	//var/T1=new/obj/amaterasu(loc)
	//T1:owner=src
turf/proc/burning(var/mob/owner,var/time)
	var/times=0
	spawn(5)
	loop
		if(times<time)
			if(!owner)return
			times++
			for(var/mob/M in locate(x,y,z))if(M!=owner)
				if(owner.inchunin!=4)if(owner.aff==M.aff)continue
				var/damage=round(owner.pow*0.15)
				if(owner.clan!="Copy Ninja")damage*=1+(owner.tier22*0.08)
				M.dmgch(owner)
				damage=(damage*M.variable)+M.variable2
				if(owner.level>=70&&owner.clan=="Uchiha")damage*=1.25
				if(owner.clan=="Uchiha"&&owner.tier31)damage*=1.05+0.05*owner.tier31
				M.damage(damage)
				M.death(owner)
				if(M)M.ignite(owner)
			spawn(5)goto loop
obj/fire
	icon='flame.dmi'
	layer=15
	pixel_y=-16
	pixel_x=-16
	proc/fire(var/T)spawn(T)del src
	New()
		flick("spawn",src)
		pixel_y-=rand(-6,6)
		pixel_x-=rand(-6,6)
		icon_state=pick("1","2","3","4")
		spawn(140)del src
obj/bfire2
	icon='amaterasu.dmi'
	layer=15
	New()
		pixel_y=rand(-16,16)
		pixel_x=rand(-16,16)
		spawn(rand(80,145))del src

world/proc
	afkcheck()
		set background=1
		while(src)
			sleep(100)
			for(var/mob/charactermenu/M in world)
				if(!M.client)
					del M
					continue
				if(M.client.inactivity>=3000)
					M<<"<b><font color=red><center>You have been booted off the server for inactivity."
					del M
			for(var/mob/player/M in world)
				if(!M.client||M.GM>=50)continue
				if(!M.afkcheck)
					if(M.client.inactivity>=600)
						M.afkcheck=1
						M.overhead()
				else
					if(M.client.inactivity>=18000&&!M.GM)
						M<<"<b><font color=red><center>You have been booted off the server for inactivity."
						M.client.SaveMob()
						spawn(3)del M
mob/proc/relentless(var/stacks,var/sett=0)
	relentless+=stacks
	if(relentless>10)
		savedrelent+=relentless-10
		relentless=10
	if(sett)relentless=sett
	if(client)
		for(var/obj/hudbuttons/Relentless/M in client.screen)
			M.icon_state="[relentless]x"
mob/var
	tmp/helpassist=0
	tmp/hudon=1
mob/proc
	hidehud()
		if(cdelay1)return
		cdelay1=1
		spawn(42)cdelay1=0
		if(hudon)
			hudon=0
			for(var/obj/hudbuttons/hidable/G in client.screen)del G
		else
			hudon=1
			client.screen+=new/obj/hudbuttons/hidable/Rest
			client.screen+=new/obj/hudbuttons/hidable/Hide
			client.screen+=new/obj/hudbuttons/hidable/Skill_Tree
			client.screen+=new/obj/hudbuttons/hidable/Who
			client.screen+=new/obj/hudbuttons/hidable/help
			var/obj/hudbuttons/hidable/Throwing_Weapon_Toggle/A=new()
			if(kstoggle=="Kunai")A.icon_state="kunai"
			else A.icon_state="shuriken"
			var/C=new/obj/hudbuttons/hidable/Betrayal
			if(pktoggle==1)C:icon_state="betrayalon"
			else C:icon_state="betrayaloff"
			client.screen+=A
			client.screen+=C
	help()
		if(name=="File in Title Screen")return
		var/V=0
		for(var/mob/M in world)if(M.GM)V++
		var/say
		hengeback()
		if(!GM)say=input("What would you like to say to all the Admins online([V] admins online)? (Abusing this function is punishable)") as text
		else
			var/list/choose=list()
			for(var/mob/player/M in world)if(M.helpassist)choose.Add(M)
			var/cancel="Cancel"
			choose+=cancel
			var/M=input("Who do you want to respond to?)") as null|anything in choose
			if(!M||choose==cancel)return
			say=input("What would you like to say? ([M])") as text
			if(M)redbutton=M
			else return
		if(say=="")return
		if(length(say)>=500)
			usr<<"Your message is too long."
			usr<<"You tried to say [say]"
			return
		if(!GM)
			helpassist++
			spawn(900)helpassist--
			for(var/mob/player/M in world)if(M.GM)M<<"<font color=red><b>Admin Assistant: [src]([client]) - [html_encode(say)]"
			src<<"<font color=red><b>Admin Assistant: You - [html_encode(say)]"
		else
			for(var/mob/player/M in world)if(M.GM||M==redbutton)M<<"<font color=red><u><b>Admin Reply: [src] to [redbutton] - [html_encode(say)]"
obj
	heatherspark
		icon='heather.dmi'
		icon_state="poop"
		New()
			..()
			flick("heart",src)
			spawn(5)del src
	berlinspark
		icon='berlindog.dmi'
		icon_state="poop"
		New()
			..()
			flick("heart",src)
			spawn(5)del src
client/proc
	screenproc()
		screen+=new/obj/mischud
		screen+=new/obj/hotslot/hotslot1
		screen+=new/obj/hotslot/hotslot2
		screen+=new/obj/hotslot/hotslot3
		screen+=new/obj/hotslot/hotslot4
		screen+=new/obj/hotslot/hotslot5
		screen+=new/obj/hotslot/hotslot6
		screen+=new/obj/hotslot/hotslot7
		screen+=new/obj/hotslot/hotslot8
		screen+=new/obj/hotslot/hotslot9
		screen+=new/obj/hotslot/hotslot10
		screen+=new/obj/hotslot/hotslot11
		screen+=new/obj/hotslot/hotslot12
		screen+=new/obj/hotslot/hotslot13
		screen+=new/obj/hotslot/hotslot14
		screen+=new/obj/hotslot/hotslot15
		screen+=new/obj/hotslot/hotslot16
		screen+=new/obj/hotslotnum/hotslot1
		screen+=new/obj/hotslotnum/hotslot2
		screen+=new/obj/hotslotnum/hotslot3
		screen+=new/obj/hotslotnum/hotslot4
		screen+=new/obj/hotslotnum/hotslot5
		screen+=new/obj/hotslotnum/hotslot6
		screen+=new/obj/hotslotnum/hotslot7
		screen+=new/obj/hotslotnum/hotslot8
		screen+=new/obj/hotslotnum/hotslot9
		screen+=new/obj/hotslotnum/hotslot10
		screen+=new/obj/hotslotnum/hotslot11
		screen+=new/obj/hotslotnum/hotslot12
		screen+=new/obj/hotslotnum/hotslot13
		screen+=new/obj/hotslotnum/hotslot14
		screen+=new/obj/hotslotnum/hotslot15
		screen+=new/obj/hotslotnum/hotslot16
		screen+=new/obj/hudbuttons/Relentless
		screen+=new/obj/hudbars/health
		screen+=new/obj/hudbars/chakra
		screen+=new/obj/hudbars/energy
		screen+=new/obj/achievementhud
		if(mob:ancestorboost>0)screen+=new/obj/hudbuttons/boost
		if(mob:secretpower>0)screen+=new/obj/hudbuttons/superboost
		if(mob:goldscroll>0)screen+=new/obj/hudbuttons/superboost
		if(mob:hudon)
			screen+=new/obj/hudbuttons/hidable/Rest
			screen+=new/obj/hudbuttons/hidable/Hide
			screen+=new/obj/hudbuttons/hidable/Skill_Tree
			screen+=new/obj/hudbuttons/hidable/Who
			screen+=new/obj/hudbuttons/hidable/help
			var/obj/hudbuttons/hidable/Throwing_Weapon_Toggle/A=new()
			if(mob.kstoggle=="Kunai")A.icon_state="kunai"
			else A.icon_state="shuriken"
			var/C=new/obj/hudbuttons/hidable/Betrayal
			if(mob.pktoggle==1)C:icon_state="betrayalon"
			else C:icon_state="betrayaloff"
			screen+=A
			screen+=C
		if(mob:missioned==0)
			screen+=new/obj/hudbuttons/Mission
		screen+=new/obj/hudbuttons/hidehud
		screen+=new/obj/repbar/leaf
		screen+=new/obj/repbar/sand
		screen+=new/obj/repbar
		screen+=new/obj/repbartime
		screen+=new/obj/repbar/sound
		if(mob:mybar)mob:mybar:updatebar()
		if(mob:mybar2)mob:mybar2:updatebar()
mob/var
	genesis=0
	genesisweaken=0
	wrefresh=0

mob/proc/restart()
	loc=locate(486,14,1)
	missioned=-1
	switch(rebirthed)
		if(0)exp=20*level
		if(1)exp=40*level+1000
		if(2)exp=70*level+2500
		if(3)exp=100*level+4000
	if(level>120)exp+=(level-120)*500
	level=1
	Sta=1
	Hsl=1
	Tai=1
	Nin=1
	Str=1
	Int=1
	Spd=1
	amissionreq=20
	vilc=0
	sclonelearned=0
	bountyhead=0
	maxbounty=0
	bountyget=0
	staexp=0
	intexp=0
	wpalm=0
	hslexp=0
	taiexp=0
	apowexp=0
	ninexp=0
	spdexp=0
	intexp=0
	flashing=0
	staexpm=20
	intexpm=20
	energy=100
	maxenergy=100
	hslexpm=20
	taiexpm=20
	powered=0
	apowexpm=20
	ninexpm=20
	spdexpm=20
	skillpoint=1
	senryo=0
	skilltotal=0
	verbs-=typesof(/mob/Kage/verb)
	verbs-=typesof(/mob/Kage2/verb)
	verbs-=typesof(/mob/Akatsuki/verb)
	icon=null
	overlays=null
	for(var/obj/items/equippable/M in usr)if(M.equipped)M:Use()
	for(var/obj/M in usr)del M
	rank="Academy Student"
	clan="None"
	tmprank="Academy Student"
	jailtime=0
	hosptime=0
	mission=null
	missiond=null
	graffiti=0
//	karma=150
	repcontribute=0
	wdmg=0
	dead=0
	pktoggle=0
	affcheck()
	initialized=0
	onwater=0
	onsand=0
	inzone=0
	swim=0
	blind=0
	muted=0
	sharingan=0
	sandarmor=0
	byakugan=0
	slot1=null
	slot2=null
	slot3=null
	slot4=null
	slot5=null
	slot6=null
	slot7=null
	slot8=null
	slot9=null
	slot10=null
	slot11=null
	slot12=null
	slot13=null
	slot14=null
	slot15=null
	slot16=null
	smite=0
	pkkills=0
	tier11=0
	tier12=0
	tier13=0
	tier21=0
	tier22=0
	tier23=0
	tier31=0
	tier32=0
	tier33=0
	tier41=0
	tier42=0
	tier43=0
	tier51=0
	tier52=0
	tier53=0
	tier61=0
	tier62=0
	tier63=0
	tier11max=5
	tier12max=5
	tier13max=5
	tier21max=5
	tier22max=5
	tier23max=5
	tier31max=5
	tier32max=5
	tier33max=5
	tier41max=5
	tier42max=5
	tier43max=5
	tier51max=5
	tier52max=5
	tier53max=5
	tier61max=5
	tier62max=5
	tier63max=5
	rchannel=null
	jutsutoggle=0
	skilltotal=0
	statset()
	refreshword()
	for(var/obj/M in client.screen)del M
	if(mybar)del mybar
	if(mybar2)del mybar2
	winset(usr, "default.exp", "is-visible=false")
	winset(usr, "default.level", "is-visible=false")
	winset(usr, "default.cha", "is-visible=false")
	winset(usr, "default.hp", "is-visible=false")
	winset(usr, "default.input1", "pos=32,685")
	for(var/obj/jutsu/G in usr)del G
	for(var/obj/jutsu/G in client.screen)del G
	client.screen+=new/obj/newchar/claninfo
	client.screen+=new/obj/newchar/village/leaf
	client.screen+=new/obj/newchar/village/sand
	client.screen+=new/obj/newchar/village/sound
	client.screen+=new/obj/newchar/clan/uchiha
	client.screen+=new/obj/newchar/clan/nara
	client.screen+=new/obj/newchar/clan/hyuuga
	client.screen+=new/obj/newchar/clan/sand
	client.screen+=new/obj/newchar/clan/iron
	client.screen+=new/obj/newchar/clan/wind
	client.screen+=new/obj/newchar/clan/snake
	client.screen+=new/obj/newchar/clan/spider
	client.screen+=new/obj/newchar/clan/kaguya
	client.screen+=new/obj/newchar/clan/tai
	client.screen+=new/obj/newchar/clan/copy
	client.screen+=new/obj/newchar/clan/yuki
	client.screen+=new/obj/newchar/clan/senju
	client.screen+=new/obj/newchar/clan/medic
	client.screen+=new/obj/newchar/clan/clay
	loc=locate(119,15,1)
	client.perspective=EYE_PERSPECTIVE
	client.eye=locate(121,11,1)
	clan="None"
	icon='base.dmi'
	icon_name='base.dmi'
	eye='blackeyes.dmi'
	hair='berlinhair2.dmi'
	initialized=0
	name=key
	invisibility=10
	sight|=SEE_SELF
	overlay()
	var/image/I=image('clanscreen.dmi',locate(128,18,1),"arrow",63)
	I.vtype="hair"
	client.images+=I
	var/image/I2=image('clanscreen.dmi',locate(126,12,1),"arrow",63)
	I2.vtype="eye"
	I2.pixel_y=6
	client.images+=I2
	var/image/I3=image('clanscreen.dmi',locate(126,13,1),"1",30)
	I3.vtype="hairc"
	I3.pixel_y=6
	client.images+=I3
	var/image/I4=image('clanscreen.dmi',locate(127,11,1),"arrow",63)
	I4.vtype="skin"
	I4.pixel_y=6
	client.images+=I4
	new/obj/ryo(src)
	ryorefresh()
	alert("A new big update has occured. There is a 'soft' pwipe where you get bonus experience based on your previous character's power.")
var/textafk=null
mob/var/notafk=0
world/proc
	afkchecker()
		spawn(rand(12000,18000))
			var/playersonline=0
			for(var/mob/player/M in world)playersonline++
			if(playersonline>=50)
				textafk=pick("yolo","butt slave","Makenshi sucks","french toast mafia","bamboo protector","Amerika","rape box","Europe sucks USA#1")
				world<<"<big><center><b><font color=silver>AFK check! Say the word(s) '[textafk]' in village chat!"
				spawn(300)
					world<<"<b><center><font color=silver>The following people have been kicked for being AFK:"
					for(var/mob/player/M in world)
						if(!M.notafk&&!M.GM)
							world<<"<b><center><font color=silver>[M]"
							M.client.SaveMob()
							del M
						else
							M.notafk=0
							textafk=null
					spawn(rand(12000,18000))afkchecker()
			else
				world<<"<b><center><font color=silver>AFK check skipped! Less than 50 players on!"
				spawn(rand(12000,18000))afkchecker()
obj/proc
	faceme(var/mob/M)
		if(M.rank=="Bijuu")return
		if(dir==NORTH)M.dir=SOUTH
		if(dir==SOUTH)M.dir=NORTH
		if(dir==EAST)M.dir=WEST
		if(dir==WEST)M.dir=EAST
