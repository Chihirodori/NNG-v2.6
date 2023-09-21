mob/proc
	windleveling()
		if(level==2)
			src<<"<b><font color=lime>You have learned your first wind move, Sickling Wind. With this move you will swing your fan and create powerful gusts of wind that deals damage and blows them away."
			new/obj/jutsu/wind/Sickling_Wind(src)
		if(level==5)
			src<<"<b><font color=lime><b>You have learned Sandstorm! This move allows you to create a sand filled gust of wind that deals damage and slows down everyone in a wide area!"
			new/obj/jutsu/wind/Sandstorm(src)
		if(level==8)src<<"<b><font color=lime>Your Sickling Wind is now level 2! It can now apply a stack of 5% defense debuff up to 3 times!"
		if(level==10&&tier12)src<<"<b><font color=lime>Your Whirlwind Palm is now level 2! It now knocks the enemy back further!"
		if(level==15)
			src<<"<b><font color=lime>You have learned Air Bullet! You use your chakra to create a homing blast of wind that bombards the enemy for heavy damage."
			new/obj/jutsu/wind/Air_Bullet(src)
		if(level==18)src<<"<b><font color=lime>Your Sickling Wind is now level 3! It now knocks back one tile further!"
		if(level==20)src<<"<b><font color=lime>Your Sandstorm is now level 2! It now slows down more for a longer duration!"
		if(level==25)src<<"<b><font color=lime>You have mastered Whirlwind Palm! The stun time has increased by 100%!"
		if(level==30)
			src<<"<b><font color=lime>You have learned Dragon's Storm! This creates a raging tornado that homes in and destroy enemies as long as they are near it!"
			new/obj/jutsu/wind/Dragons_Storm(src)
		if(level==32)src<<"<b><font color=lime>Your Air Bullet is now level 2! It now smashes the enemy with more force, dealing more damage."
		if(level==40)
			src<<"<b><font color=lime>You have learned your fifth clan move, Great Sickling Wind! This powerful version of sickling wind causes a massive hurricane that buffets everyone in your sight!"
			new/obj/jutsu/wind/Great_Sickling_Wind(src)
		if(level==45)src<<"<b><font color=lime>Your Air Bullet is now level 3! It can now smash through multiple enemies!"
		if(level==50)src<<"<b><font color=lime>You have mastered Sandstorm! It now deals 30% more damage!"
		if(level==55)src<<"<b><font color=lime>You have mastered Sickling Wind! The defense debuff can stack up to 8 times now!"
		if(level==60)src<<"<b><font color=lime>Your Great Sickling Wind is now level 2! It now deals more damage!"
		if(level==65)
			src<<"<b><font color=lime><b>You have learned your final clan jutsu, Ripping Gale Jutsu! This jutsu lets you fire a slicing blade of wind that deals massive damage while piercing. Not only that, but you can use it two more times quickly to deal even more damage."
			new/obj/jutsu/wind/Ripping_Gale_Jutsu(src)
		if(level==70)src<<"<b><font color=lime>Your Dragon's Storm is now level 2! The direct hit is now higher!"
		if(level==75)src<<"<b><font color=lime>You have mastered Great Sickling Wind! It now deals more damage!"
		if(level==78)src<<"<b><font color=lime>Your Air Bullet is now level 4! Your mastery of this jutsu allows you to fire it more often!"
		if(level==80)src<<"<b><font color=lime>Your Ripping Gale Jutsu is now level 2! You can now fire up to five!"
		if(level==85)src<<"<b><font color=lime>You have mastered Air Bullet! The damage of this jutsu is increased even more!"
		if(level==90)src<<"<b><font color=lime>You have mastered Dragon's Storm! It's indirect damage is now higher and it moves faster!"
		if(level==100)src<<"<b><font color=lime>You have mastered Ripping Gale Jutsu! The extra slashes now take less chakra!"
	sicklingwind()
		prejutsu()
		if(cdelay1||copydelay1||swim||dead||resting||stun||busy||moving||imitated||paralysed)return
		if(clan=="Copy Ninja")copydelay1=1
		else	cdelay1=1
		handseals(40*(1-(tier11*0.08)),0,15)
		if(!sealpass)
			cdelay1=0
			copydelay1=0
			return
		var/sdelay=60*cdpow/100
		if(clan=="Copy Ninja")sdelay+=20
		if(tier31&&clan!="Copy Ninja")sdelay-=5*tier31
		if(stance=="hurricane")sdelay-=sdelay*0.1*tier23
		for(var/obj/jutsu/wind/Sickling_Wind/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)
			cdelay1=0
			copydelay1=0
		flick("attack",usr)
		soundeff(pick('wind.wav','wind2.wav','wind3.wav'),40,0)
		if(clan!="Copy Ninja")
			new/obj/sicklewind(loc)
			var/obj/L2=new/obj/sicklewind(loc)
			var/obj/L3=new/obj/sicklewind(loc)
			var/obj/L4=new/obj/sicklewind(loc)
			var/obj/L5=new/obj/sicklewind(loc)
			if(dir==NORTH||dir==SOUTH)
				L2.loc=locate(x+1,y,z)
				L3.loc=locate(x-1,y,z)
				L4.loc=locate(x+2,y,z)
				L5.loc=locate(x-2,y,z)
			if(dir==EAST||dir==WEST)
				L2.loc=locate(x,y+1,z)
				L3.loc=locate(x,y-1,z)
				L4.loc=locate(x,y+2,z)
				L5.loc=locate(x,y-2,z)
			if(stance!="hurricane")
				del L4
				del L5
			for(var/obj/sicklewind/M in view(3))
				M.dir=dir
				M.owner=usr
				if(tier13&&clan!="Copy Ninja")M:projint+=0.4*tier13
				if(stance!="condensedwind")
					walk(M,dir)
				else
					M.movequick(dir)
		else
			tactics()
			new/obj/sicklewind2(loc)
			var/obj/L2=new/obj/sicklewind2(loc)
			var/obj/L3=new/obj/sicklewind2(loc)
			var/obj/L4=new/obj/sicklewind2(loc)
			var/obj/L5=new/obj/sicklewind2(loc)
			if(dir==NORTH||dir==SOUTH)
				L2.loc=locate(x+1,y,z)
				L3.loc=locate(x-1,y,z)
				L4.loc=locate(x+2,y,z)
				L5.loc=locate(x-2,y,z)
			if(dir==EAST||dir==WEST)
				L2.loc=locate(x,y+1,z)
				L3.loc=locate(x,y-1,z)
				L4.loc=locate(x,y+2,z)
				L5.loc=locate(x,y-2,z)
			for(var/obj/sicklewind2/M in view(3))
				M.dir=dir
				M.owner=usr
				M.movequick(dir)
	greatsicklingwind()
		prejutsu()
		if(cdelay5||swim||dead||resting||stun||seals||busy||moving||imitated||paralysed)return
		cdelay5=1
		handseals(80*(1-(tier11*0.08)),10,50)
		if(!sealpass)
			cdelay5=0
			return
		var/sdelay=300*cdpow/100
		if(tier31)sdelay-=5*tier31
		for(var/obj/jutsu/wind/Great_Sickling_Wind/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay5=0
		flick("attack",usr)
		range(12)<<"<b><font color=silver>[src]: Great Sickling Wind!"
		for(var/mob/M in oview(8))
			if(aff==M.aff)continue
			if(M.illusion)
				M.illusionhit(src)
				continue
			var/distance=get_dist(src,M)
			var/knockback=0
			if(distance<=1)knockback=5
			if(distance>=2&&distance<=3)knockback=4
			if(distance>=4&&distance<=5)knockback=3
			if(distance>=6&&distance<=7)knockback=2
			if(distance>=8)knockback=1
			M.faceme(src)
			M.stepback(knockback)
			var/damage=(pow*1.4)-0.05*distance
			if(tier31)damage*=0.85
			if(tier41)damage*=1+(0.08*tier41)
			if(level>=60)damage*=1.05
			if(level>=75)damage*=1.05
			if(stance=="hurricane")damage*=1+(0.08*tier23)
			if(tier63)M.twistered(src)
			dmgch(M)
			damage=(damage*M.variable)+M.variable2
			M.damage(damage)
			new/obj/willowslash(M.loc)
			if(prob(tier51*15))
				new/obj/gustreaper(M.loc)
				M.damage(damage*0.5)
			M.death(src)
		var/obj/L=new/obj/gsickling(locate(x+1,y,z))
		var/obj/L6=new/obj/gsickling(locate(x-1,y,z))
		var/obj/L7=new/obj/gsickling(locate(x,y+1,z))
		var/obj/L10=new/obj/gsickling(locate(x,y-1,z))
		for(var/obj/gsickling/M in view(2))
			M.dir=dir
			M.owner=usr
		walk(L,EAST)
		walk(L6,WEST)
		walk(L7,NORTH)
		walk(L10,SOUTH)
		spawn(1)
			var/obj/L13=new/obj/gsickling(locate(x-1,y-1,z))
			var/obj/L14=new/obj/gsickling(locate(x-1,y+1,z))
			var/obj/L15=new/obj/gsickling(locate(x+1,y-1,z))
			var/obj/L16=new/obj/gsickling(locate(x+1,y+1,z))
			for(var/obj/gsickling/M in view(2))
				M.dir=dir
				M.owner=usr
			walk(L13,SOUTHWEST)
			walk(L14,NORTHWEST)
			walk(L15,SOUTHEAST)
			walk(L16,NORTHEAST)
		spawn(2)
			var/obj/L8=new/obj/gsickling(locate(x+1,y+1,z))
			var/obj/L9=new/obj/gsickling(locate(x-1,y+1,z))
			var/obj/L2=new/obj/gsickling(locate(x+1,y-1,z))
			var/obj/L3=new/obj/gsickling(locate(x+1,y+1,z))
			var/obj/L4=new/obj/gsickling(locate(x-1,y-1,z))
			var/obj/L5=new/obj/gsickling(locate(x-1,y+1,z))
			var/obj/L11=new/obj/gsickling(locate(x+1,y-1,z))
			var/obj/L12=new/obj/gsickling(locate(x-1,y-1,z))
			for(var/obj/gsickling/M in view(2))
				M.dir=dir
				M.owner=usr
			walk(L2,EAST)
			walk(L3,EAST)
			walk(L4,WEST)
			walk(L5,WEST)
			walk(L8,NORTH)
			walk(L9,NORTH)
			walk(L11,SOUTH)
			walk(L12,SOUTH)
	airbullet()
		prejutsu()
		if(cdelay3||swim||dead||resting||stun||busy||seals||moving||imitated||paralysed)return
		handseals(45*(1-(tier11*0.08)),5,30)
		if(!sealpass)return
		cdelay3=1
		flick("attack",usr)
		var/obj/L=new/obj/Air_Bullet(loc)
		L.owner=src
		if(tier33)L:aim()
		walk(L,dir)
		var/sdelay=220*cdpow/100
		if(tier33)sdelay-=20*tier33
		if(level>=78)sdelay*=0.5
		for(var/obj/jutsu/wind/Air_Bullet/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay3=0
	dragonsstorm()
		prejutsu()
		if(seals||copydelay5||cdelay4||swim||dead||resting||stun||busy||moving||imitated||paralysed)return
		if(clan=="Copy Ninja")copydelay5=1
		else	cdelay4=1
		handseals(120*(1-(tier11*0.08)),20,50)
		if(!sealpass)
			cdelay4=0
			copydelay5=0
			return
		var/sdelay=470*cdpow/100
		for(var/obj/jutsu/wind/Dragons_Storm/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)
			cdelay4=0
			copydelay5=0
		freeze=1
		icon_state="spear"
		var/g=5
		if(tier61&&clan=="Fan")g-=tier61
		sleep(g)
		freeze=0
		range(12)<<"<b><font color=silver>[src]: Dragon's Storm!"
		icon_state=""
		soundeff('dstorm.wav',30,1)
		flick("attack",usr)
		var/obj/K=new/obj/dragonsstorm(loc)
		K.owner=src
		K:damagesz=pow*0.8
		if(stance=="hurricane")K:damagesz*=1+(0.08*tier23)
		if(level>=70&&clan=="Fan")K:damagesz=pow*1.2
		var/d=2
		if(level>=90||clan=="Copy Ninja")
			K:maxmove=16
			d--
		K:tmoving(d)
		spawn(7)
		if(prob(20+tier62*10)&&tier62&&clan=="Fan")
			range(12)<<"<b><font color=silver>[src]: Twin Dragoons!"
			var/obj/K2=new/obj/dragonsstorm(loc)
			K2.owner=src
			K2:damagesz=K:damagesz/2
			var/d2=2
			if(level>=90)
				K2:maxmove=16
				d2--
			K2:tmoving(d2)
		if(clan=="Copy Ninja")tactics()
	sandstorm()
		prejutsu()
		if(cdelay2||swim||dead||resting||stun||busy||moving||seals||imitated||paralysed)return
		handseals(50*(1-(tier11*0.08)),5,35)
		if(!sealpass)return
		cdelay2=1
		var/sdelay=150*cdpow/100
		if(tier31)sdelay-=5*tier31
		if(tier23)sdelay*=(1.25-tier23*0.05)
		if(stance=="hurricane")sdelay-=sdelay*0.1*tier23
		for(var/obj/jutsu/wind/Sandstorm/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)cdelay2=0
		flick("attack",usr)
		soundeff('wind.wav',40,0)
		soundeff('sandshower.wav',40,0)
		new/obj/sandstormwind(loc)
		var/obj/L2=new/obj/sandstormwind(loc)
		var/obj/L3=new/obj/sandstormwind(loc)
		var/obj/L4=new/obj/sandstormwind(loc)
		var/obj/L5=new/obj/sandstormwind(loc)
		if(dir==NORTH||dir==SOUTH)
			L2.loc=locate(x+1,y,z)
			L3.loc=locate(x-1,y,z)
			L4.loc=locate(x+2,y,z)
			L5.loc=locate(x-2,y,z)
		if(dir==EAST||dir==WEST)
			L2.loc=locate(x,y-1,z)
			L3.loc=locate(x,y+1,z)
			L4.loc=locate(x,y+2,z)
			L5.loc=locate(x,y-2,z)
		if(stance!="hurricane")
			del L4
			del L5
		for(var/obj/sandstormwind/M in view(3))
			M.owner=usr
			M.dir=dir
			walk(M,dir)
	rippinggalejutsu()
		prejutsu()
		if(cdelay6==1||swim||attacking||dead||resting||stun||busy||moving||seals||imitated)return
		if(cdelay6==0)
			handseals(60*(1-(tier11*0.08)),0,40,1)
			if(!sealpass)return
			spawn(56)cdelay6=1
			soundeff(pick('wind.wav','wind2.wav','wind3.wav'),40,0)
			var/sdelay=550*cdpow/100
			for(var/obj/jutsu/wind/Ripping_Gale_Jutsu/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)cdelay6=0
			flick("attack",usr)
			attacking=1
			variable3=1
			spawn(7)attacking=0
			stepback(1)
			var/obj/T=new/obj/galeslice(loc)
			T.owner=src
			T.dir=dir
			T:overlayyes()
			walk(T,dir)
		else
			if(variable3>=3&&level<80||variable3>=5)return
			if(level<100)handseals(40,0,1)
			else handseals(25,0,1)
			if(!sealpass)return
			flick("attack",usr)
			soundeff(pick('wind.wav','wind2.wav','wind3.wav'),40,0)
			attacking=1
			variable3++
			spawn(7)attacking=0
			stepback(1)
			var/obj/T=new/obj/galeslice(loc)
			T.owner=src
			T.dir=dir
			T:overlayyes()
			walk(T,dir)
	whirlwindp()
		prejutsu()
		if(swim||dead||stun||wpalming||imitated||paralysed||resting||caught||seals||busy)return
		handseals(12,0,1)
		if(!sealpass)return
		wpalming=1
		var/obj/L=new/obj/wpalm/one(loc)
		L.dir=dir
		step(L,dir)
		step(L,dir)
		var/obj/L2=new/obj/wpalm/two(loc)
		L2.dir=dir
		step(L2,dir)
		step(L2,dir)
		var/obj/L3=new/obj/wpalm/three(loc)
		L3.dir=dir
		step(L3,dir)
		step(L3,dir)
		var/obj/L4=new/obj/wpalm/four(loc)
		L4.dir=dir
		step(L4,dir)
		step(L4,dir)
		var/obj/L5=new/obj/wpalm/five(loc)
		L5.dir=dir
		step(L5,dir)
		step(L5,dir)
		var/obj/L6=new/obj/wpalm/six(loc)
		L6.dir=dir
		step(L6,dir)
		step(L6,dir)
		var/obj/L7=new/obj/wpalm/seven(loc)
		L7.dir=dir
		step(L7,dir)
		step(L7,dir)
		var/obj/L8=new/obj/wpalm/eight(loc)
		L8.dir=dir
		step(L8,dir)
		step(L8,dir)
		var/obj/L9=new/obj/wpalm/nine(loc)
		L9.dir=dir
		step(L9,dir)
		step(L9,dir)
		flick("attack",src)
		soundeff(pick('wind.wav','wind2.wav','wind3.wav'),40,0)
		for(var/mob/M in view(1,L5))
			if(M==src)continue
			if(aff==M.aff)continue
			if(M.illusion)
				M.illusionhit(src)
				continue
			if(!npc)faceme2(M)
			if(M)
				var/tj=4
				if(level>=10)tj++
				var/p=5
				if(level>=25)p+=5
				new/obj/stun(M.loc)
				if(M.client)
					var/obj/statuseffect/t=new/obj/statuseffect/stun
					M.debuffcount(p)
					t.screen_loc="[3+M.debuffa],5"
					M.client.screen+=t
					M.seffect(p,t)
				M.stun(p)
				M.stepback(tj)
				var/damage=pow*0.6
				if(level>=25)damage*=1.3
				M.dmgch(src,1)
				damage=(damage*M.variable)+M.variable2
				critroll(M)
				var/random=rand(1,100)
				if(criticalroll>=random)
					M.stepback(1)
					var/g=1.5
					if(M.stance=="Bone Golem")g-=0.2*M.tier53
					M.damage(damage*g)
				else
					M.damage(damage)
				M.death(usr)
		var/sdelay=120-tier12*10
		for(var/obj/jutsu/wind/Whirlwind_Palm/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)wpalming=0
	whirlwindpalm()
		if(!wpalm)
			wpalm=1
			usr<<"You are now using whirlwind palm."
		else
			wpalm=0
			usr<<"You have stopped using whirlwind palm."
	markofdeath()
		if(dead||marking||imitated||paralysed||caught||seals||busy)return
		marking++
		spawn(14)marking--
		for(var/mob/player/M in oview(6))
			if(aff==M.aff)continue
			new/obj/eyeac(loc)
			var/sdelay=300
			soundeff('seal2.wav',40,0)
			marking++
			spawn(sdelay*(cdpow/100))
				for(var/obj/jutsu/wind/Mark_of_Death/M2 in src)timerjutsu(300,M2)
				marking--
			M.markdeath(src)
			return
	hurricane()
		if(stancing||dead||imitated||paralysed||caught||seals||busy)return
		if(stance)
			stance=null
			regenupdate()
			src<<"<b><center>You are normalized."
			forceupdate()
			new/obj/statuspop/normalstance(loc)
			for(var/obj/statuseffect/stance/M in client.screen)del M
			return
		stance="hurricane"
		forceupdate()
		view(8)<<"<b><center>You are now using hurricane."
		var/obj/statuseffect/t=new/obj/statuseffect/stance/hurricane
		t.screen_loc="15,16"
		client.screen+=t
		stancing=1
		ovcheck()
		spawn(14)stancing=0
	condensedwind()
		if(stancing||dead||imitated||paralysed||caught||seals||busy)return
		if(stance)
			stance=null
			regenupdate()
			src<<"<b><center>You are normalized."
			forceupdate()
			new/obj/statuspop/normalstance(loc)
			for(var/obj/statuseffect/stance/M in client.screen)del M
			return
		stance="condensedwind"
		forceupdate()
		src<<"<b><center>You are now using condensed wind."
		var/obj/statuseffect/t=new/obj/statuseffect/stance/condensedwind
		t.screen_loc="15,16"
		client.screen+=t
		stancing=1
		ovcheck()
		spawn(14)stancing=0
	windshield()
		if(stancing||dead||imitated||paralysed||caught||seals||busy)return
		if(windshield)
			windshield=0
			src<<"<b><center>You stop using wind shield."
			regenupdate()
			new/obj/statuspop/normalstance(loc)
			for(var/obj/statuseffect/stance/M in client.screen)del M
			return
		windshield=1
		regenupdate()
		windshieldc()
		src<<"<b><center>You are now using wind shield."
		var/obj/statuseffect/t=new/obj/statuseffect/stance/windshield
		t.screen_loc="16,16"
		client.screen+=t
		stancing=1
		ovcheck()
		spawn(14)stancing=0
mob/var/tmp/stancing=0

obj
	dragonsstorm
		icon='dragonsstorm.dmi'
		density=1
		layer=45
		rundelay=0
		var/maxmove=12
		var/damagesz=null
		proc
			tmoving(var/speed)
				loop
					walk(src,0)
					var/K=0
					for(var/mob/M in oview(14,src))if(M.invisibility!=10)
						if(!owner)del src
						if(owner.mark)
							if(M!=owner.mark)continue
						else
							if(owner.aff==M.aff)continue
						K=1
						walk_to(src,M,1,speed)
						for(var/mob/G in oview(1,src))if(G==M)walk_towards(src,M,speed)
						break
					if(K)spawn(speed)goto loop
					else
						step_rand(src)
						spawn(speed)goto loop
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(D.illusion)
					D.illusionhit(O)
					return
				if(D.aff==O.aff)return
				D.stepback(5)
				var/damage=damagesz
				if(O.clan=="Copy Ninja")damage*=0.85
				D.dmgch(O)
				damage=(damage*D.variable)+D.variable2
				D.damage(damage)
				D.death(O)
				damagesz*=0.6
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					loc=T.loc
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					loc=T.loc
		Move()
			..()
			var/mob/O=owner
			if(!O)del src
			for(var/mob/M in oview(1))
				var/mob/D=M
				if(D.illusion)
					D.illusionhit(O)
					return
				if(O.aff==D.aff)continue
				var/damage=damagesz/3
				if(O.clan=="Copy Ninja")damage*=0.85
				if(O.level>=90)damage=damagesz/2
				D.dmgch(O)
				damage=(damage*D.variable)+D.variable2
				if(O.tier53&&O.clan!="Copy Ninja")damage*=1+(O.tier53*0.1)
				D.damage(damage)
				D.death(O)
			maxmove--
			if(maxmove<=0)del src
		Del()
			var/obj/a1=new/obj/sicklewind(loc)
			var/obj/a2=new/obj/sicklewind(loc)
			var/obj/a3=new/obj/sicklewind(loc)
			var/obj/a4=new/obj/sicklewind(loc)
			var/obj/a5=new/obj/sicklewind(loc)
			var/obj/a6=new/obj/sicklewind(loc)
			var/obj/a7=new/obj/sicklewind(loc)
			var/obj/a8=new/obj/sicklewind(loc)
			for(var/obj/sicklewind/M in loc)M.owner=owner
			walk(a1,NORTHEAST)
			walk(a2,NORTHWEST)
			walk(a3,SOUTHWEST)
			walk(a4,SOUTHEAST)
			walk(a5,WEST)
			walk(a6,EAST)
			walk(a7,SOUTH)
			walk(a8,NORTH)
			..()
	dragonsstormtop
		icon='dragonsstorm.dmi'
		density=1
		icon_state="2"

		layer=20
	dragonssstormtop
		icon='dragonsstorm.dmi'
		density=1
		icon_state="3"

		layer=20
	ssov
		icon='sandstormwind.dmi'
		layer=45
		pixel_x=-16
		pixel_y=-16
	sicklewindov
		density=1
		icon='sickling.dmi'
		pixel_x=-16
		layer=45
		pixel_y=-16
		New()
			..()
			pixel_x+=rand(-8,8)
			pixel_y+=rand(-8,8)
	sicklewind2
		density=1
		icon='sickling.dmi'
		var/bkthr=0
		pixel_x=-16
		pixel_y=-16
		layer=45
		rundelay=0
		New()
			..()
			spawn(1)overlays+=new/obj/sicklewindov
			spawn(2)overlays+=new/obj/sicklewindov
			spawn(3)overlays+=new/obj/sicklewindov
			spawn(4)overlays+=new/obj/sicklewindov
			spawn(60)del src
		Move()
			..()
			if(!owner)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(O.aff==D.aff)
					loc=D.loc
					return
				O.faceme2(D)
				D.twistered(O)
				D.stepback(1)
				projectile(O,D,round(O.pow*0.5),20)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					bkthr=1
					icon_state="bk"
					projduel(T)
	sicklewind
		density=1
		icon='sickling.dmi'
		var/bkthr=0
		pixel_x=-16
		pixel_y=-16
		layer=45
		rundelay=0
		New()
			..()
			spawn(1)overlays+=new/obj/sicklewindov
			spawn(2)overlays+=new/obj/sicklewindov
			spawn(3)overlays+=new/obj/sicklewindov
			spawn(4)overlays+=new/obj/sicklewindov
			spawn(60)del src
		Move()
			..()
			var/mob/x=owner
			if(x.tier52&&x.clan!="Copy Ninja")buildup++
			if(buildup==4)new/obj/buildup(src)
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(O.aff==D.aff)
					loc=D.loc
					return
				var/knockback=1
				if(O.level>=18)knockback++
				O.faceme2(D)
				D.stepback(knockback)
				var/damage=O.pow*0.40
				if(O.tier31)damage*=0.85
				if(O.tier13)damage*=1+(0.03*O.tier13)
				if(O.tier13&&bkthr)damage*=1+(0.03*O.tier13)
				if(O.stance=="condensedwind")damage*=1+(0.1*O.tier22)
				if(O.tier41)damage*=1+(0.08*O.tier41)
				if(buildup>=4)damage*=1+(0.1*O.tier52)
				if(O.tier63)D.twistered(O)
				if(O.level>=8&&O.level<55)D.winddebuff(70,1)
				if(O.level>=55)D.winddebuff(70)
				D.dmgch(O)
				damage=(damage*D.variable)+D.variable2
				D.damage(damage)
				if(prob(O.tier51*15))
					new/obj/gustreaper(D.loc)
					D.damage(damage*0.5)
				D.death(O)
				del src
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					bkthr=1
					icon_state="bk"
					projduel(T)
	fanwind
		density=1
		icon='sickling.dmi'
		pixel_x=-16
		pixel_y=-16
		layer=45
		animate_movement=2
		rundelay=0
		projint=0
		New()
			..()
			spawn(1)overlays+=new/obj/sicklewindov
			spawn(2)
				overlays+=new/obj/sicklewindov
			spawn(3)
				overlays+=new/obj/sicklewindov
			spawn(4)
				overlays=0
			spawn(14)del src
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(!D.fanhit)
					D.fanhit()
					projectilep(O,D,round(O.pow*0.5)+12)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(T)
	gsicklingtrail
		icon='gsickling.dmi'
		density=0
		layer=3
		New()
			..()
			flick("2",src)
			spawn(7)del src
	gsickling
		icon='gsickling.dmi'
		icon_state="1"
		rundelay=0
		layer=3
		animate_movement=2
		density=0
		New()
			..()
			spawn(14)del src
		Move()
			new/obj/gsicklingtrail(loc)
			..()
	sandstormwind
		icon='sandstormwind.dmi'
		density=1
		projint=1
		rundelay=0
		pixel_x=-16
		layer=45
		pixel_y=-16
		New()
			var/obj/T=new/obj/ssov
			T:pixel_y+=rand(-8,8)
			T:pixel_x+=rand(-8,8)
			var/obj/T2=new/obj/ssov
			T2:pixel_y+=rand(-8,8)
			T2:pixel_x+=rand(-8,8)
			overlays+=T
			overlays+=T2
			var/obj/T3=new/obj/ssov
			T3:pixel_y+=rand(-8,8)
			T3:pixel_x+=rand(-8,8)
			overlays+=T3
			..()
			spawn(60)del src
		Move()
			..()
			var/mob/x=owner
			if(!x)del src
			if(x.tier52)buildup++
			if(buildup==4)new/obj/buildup(src)
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				if(O.aff==D.aff)
					loc=D.loc
					return
				if(O.level<20)D.sandslow(20,2+O.tier22)
				else D.sandslow(40,4+O.tier22)
				var/t=1
				if(O.level>=50)t+=0.3
				if(O.tier22)t+=0.1*O.tier22
				if(O.tier31)t-=0.15
				if(O.tier41)t+=0.08*O.tier41
				if(O.stance=="condensedwind")t+=(0.1*O.tier22)
				if(buildup>=4)t+=0.10*O.tier52
				if(O.tier63)D.twistered(O)
				if(!O.tier43)projectilep(O,D,round(round(O.pow/1.4)*t),-100)
				else projectilep(O,D,round(round(O.pow/1.4)*t),O.tier43*5)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(T)
	sandstormslow
		icon='sandstormslow.dmi'
		layer=15
		New()
			..()
			spawn(120)del src
	Air_Bullet
		icon='airbullet.dmi'
		density=1
		projint=2
		rundelay=0
		New()
			..()
			spawn(1)aim()
			spawn(70)del src
		proc/aim()
			loop
				var/odir=dir
				for(var/mob/M in oview(src,4))
					if(M!=owner&&M.aff!=owner.aff)
						if(dir==SOUTH||dir==NORTH)
							if(M.x>x)
								x++
								goto here
							if(M.x<x)
								x--
								goto here
						if(dir==EAST||dir==WEST)
							if(M.y>y)
								y++
								goto here
							if(M.y<y)
								y--
								goto here
				here
				dir=odir
				spawn(2)goto loop
		Move()
			..()
			var/mob/x=owner
			if(!x)del src
			if(x.tier52)buildup++
			if(buildup==4)new/obj/buildup(src)
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				var/t=1
				if(O.tier33)t+=O.tier33*0.1
				if(buildup>=4)t+=O.tier52/10
				if(O.stance=="condensedwind")t+=0.1*O.tier22
				if(O.tier63)D.twistered(O)
				if(O.level<32)projectile(O,D,round(O.pow*0.75)*t)
				else
					if(O.level<45)projectile(O,D,round(O.pow)*t)
					else projectilep(O,D,round(O.pow)*t)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)
mob/var/tmp/sandstormslow=0
mob/var/tmp/fanhit=0
mob/proc/sandslow(var/N,var/S)
	overlays+=/obj/sandstormslow
	sandstormslow+=S
	snared(N,S)
	if(client)
		var/obj/statuseffect/t=new/obj/statuseffect/sandstorm
		debuffcount(N)
		t.screen_loc="[7+debuffa],16"
		client.screen+=t
		seffect(N,t)
	spawn(N)
		sandstormslow-=S
		overlays-=/obj/sandstormslow
mob/proc/mark(var/mob/M)
	mark=M
	spawn(120)
		if(!M)
			mark=null
		else
			if(mark==M)mark=null
mob/proc/fanhit()
	fanhit=1
	spawn(7)
		fanhit=0
obj
	galeslice
		name="Ripping Gale"
		icon='gale.dmi'
		density=1
		rundelay=0
		layer=12
		projint=2
		var
			leftie
			rightie
		proc/overlayyes()
			var/Q=new/obj/gale1
			var/W=new/obj/gale2
			Q:owner=owner
			W:owner=owner
			if(dir==NORTH||dir==SOUTH)
				Q:loc=locate(x-1,y,z)
				W:loc=locate(x+1,y,z)
			if(dir==EAST||dir==WEST)
				Q:loc=locate(x,y-1,z)
				W:loc=locate(x,y+1,z)
			Q:orig=src
			W:orig=src
			rightie=W
			leftie=Q
			Q:rightie=W
			W:leftie=Q
			walk(Q,dir)
			walk(W,dir)
		New()
			..()
			spawn(70)del src
		Del()
			if(rightie)del rightie
			if(leftie)del leftie
			..()
		Move()
			..()
			var/mob/x=owner
			if(!x)del src
			if(x.tier52)buildup++
			if(buildup==4)new/obj/buildup(src)
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				var/t=1
				if(buildup>=4)t+=O.tier52/10
				if(prob(O.tier51*15))
					new/obj/gustreaper(D.loc)
					D.damage(O.pow*0.7)
				if(O.tier63)D.twistered(O)
				projectilep(O,D,round(O.pow*t),O.tier43*5)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)
	gale1
		name="Ripping Gale"
		icon='gale.dmi'
		icon_state="2"
		rundelay=0
		density=1
		layer=10
		projint=2
		var/orig
		var/rightie
		New()
			..()
			spawn(70)del src
		Move()
			..()
			if(owner.tier52)buildup++
			if(buildup==4)new/obj/buildup(src)
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				var/t=1
				if(buildup>=4)t+=O.tier52/10
				if(prob(O.tier51*15))
					new/obj/gustreaper(D.loc)
					D.damage(round(O.pow/2)+10)
				if(O.tier63)D.twistered(O)
				projectilep(O,D,round(O.pow*t),O.tier43*5)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)
		Del()
			if(orig)del orig
			if(rightie)del rightie
			..()
	gale2
		name="Ripping Gale"
		icon='gale.dmi'
		icon_state="1"
		layer=10
		density=1
		rundelay=0
		projint=2
		var/orig
		var/leftie
		New()
			..()
			spawn(70)del src
		Move()
			..()
			if(owner.tier52)buildup++
			if(buildup==4)new/obj/buildup(src)
		Bump(A)
			if(istype(A,/mob))
				var/mob/O=owner
				var/mob/D=A
				var/t=1
				if(buildup>=4)t+=O.tier52/10
				if(prob(O.tier51*15))
					new/obj/gustreaper(D.loc)
					D.damage(round(O.pow/2)+10)
				if(O.tier63)D.twistered(O)
				projectilep(O,D,round(O.pow*t),O.tier43*5)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj))
				var/obj/T = A
				if(T.density)
					projduel(A)
		Del()
			if(orig)del orig
			if(leftie)del leftie
			..()
	wpalm
		layer=35
		rundelay=0
		icon='wpalm.dmi'
		New()
			..()
			flick("[src]",src)
			name="Whirlwind Palm"
			spawn(8)del src
		one
			name="1"
			pixel_y=32
			pixel_x=-32
		two
			name="2"
			pixel_y=32
		three
			name="3"
			pixel_y=32
			pixel_x=32
		four
			name="4"
			pixel_x=-32
		five/name="5"
		six
			name="6"
			pixel_x=32
		seven
			name="7"
			pixel_x=-32
			pixel_y=-32
		eight
			name="8"
			pixel_y=-32
		nine
			name="9"
			pixel_y=-32
			pixel_x=32