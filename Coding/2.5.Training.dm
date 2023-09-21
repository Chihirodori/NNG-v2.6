turf
	hospitalizedline
		Enter()
			if(ismob(usr))
				if(!usr:hosptime)
					usr.y--
				return
			..()
turf
	hospitalizedlinesound
		Entered()
			if(ismob(usr))
				if(usr:hosptime)usr.y++
				else usr.y-=6
			..()
proc/getmax(var/olevel)
	var/increment=15
	if(olevel>=10)
		increment+=round(olevel*1.3)
	return increment
proc/increasemain(var/olevel)
	switch(olevel)
		if(2 to 20)
			return 10+olevel*10
		if(21 to 29)return 10+olevel*18
		if(30 to 34)return olevel*25
		if(35 to 39)return olevel*40
		if(40 to 60)return olevel*60
mob/proc
	exp(var/g)
		if(level>=globalcap)
			exp=0
			refreshword()
			return
		if(hosptime||jailtime)return
		variable=trainingspeed/100
		if(village=="Akatsuki"&&akatpriority=="Training"||village=="Leaf"&&leafpriority=="Training"||village=="Sand"&&sandpriority=="Training"||village=="Sound"&&soundpriority=="Training")variable+=0.2
		if(goldenage==lowertext("[village]"))
			variable*=1.5
		if(village=="Leaf")
			variable+=leafter/100
			if(favor=="leaf")variable+=0.1
			if(sandban=="Leaf")variable+=0.1
			if(soundban=="Leaf")variable+=0.1
		if(village=="Sand")
			variable+=sandter/100
			if(favor=="sand")variable+=0.1
			if(leafban=="Sand")variable+=0.1
			if(soundban=="Sand")variable+=0.1
		if(village=="Sound")
			variable+=soundter/100
			if(favor=="sound")variable+=0.1
			if(leafban=="Sound")variable+=0.1
			if(sandban=="Sound")variable+=0.1
		if(village=="Akatsuki")
			variable+=akatter/100
		if(rank=="Hokage"||rank=="Kazekage"||rank=="Sound Leader")variable*=0.6
		if(sharingan>=2)variable*=1.1
		if(clan=="Copy Ninja"&&tier11)variable*=1+(0.03*tier11)
		var/h=g*(worldexprate/100)*variable
	//	if(level>=100&&level<=124)h-=h*0.4
	//	if(level>=125)h-=h*0.8
		if(subscriber)h*=1.05
		if(h>=20&&testserver==0&&!secretpower||h>=500&&testserver==1)//10
			if(key!="Chihirodori")
				src<<"<center>+[round(h)] exp([round(h+exp)] exp)"
				if(client)new/obj/expgain(loc)
		exp+=h
		refreshword()
	maxexpgain()
		apowexpm+=getmax(level)
		intexpm+=getmax(level)
		staexpm+=getmax(level)
		taiexpm+=getmax(level)
		ninexpm+=getmax(level)
		hslexpm+=getmax(level)
		spdexpm+=getmax(level)
	apowexp()
		if(jailtime||Str>=40||intut||level>=globalcap)return
		var/U=exp
		if(U>round(apowexpm/10))U=round(apowexpm/10)
		if(U<50&&exp>=50)U=50
		if(exp<50)U=exp
		exp-=U
		apowexp+=U
		if(apowexp>=apowexpm)
			Str++
			apow+=1.5
			apowexp-=apowexpm
			if(clan=="Yuki"&&tier43)pow+=tier43
		//	apowexpm+=increasemain(Str)
			src<<"<b><font color=white><font size=2><center>______________________________"
			src<<"<b><font color=white><font size=2><center>Your strength is now level [Str]"
			src<<"<b><center>+1.5 attack power"
			levelup(3)
	staexp()
		if(jailtime||Sta>=40||intut||level>=globalcap)return
		var/U=exp
		if(U>round(staexpm/10))U=round(staexpm/10)
		if(U<50&&exp>=50)U=50
		if(exp<50)U=exp
		exp-=U
		staexp+=U
		if(staexp>=staexpm)
			Sta++
			regenhp+=0.4
			regene+=0.2
			staexp-=staexpm
		//	staexpm+=increasemain(Sta)
			src<<"<b><font color=white><font size=2><center>______________________________"
			src<<"<b><font color=white><font size=2><center>Your stamina is now level [Sta]"
			src<<"<b><center>+0.2 energy regen per second, +0.4 health per second"
			levelup(2)
	intexp()
		if(jailtime||Int>=40||intut||level>=globalcap)
			return
		var/U = exp
		if(U > round(intexpm / 10))
			U=round(intexpm / 10)
		if(U < 50 && exp >= 50)
			U=50
		if(exp<50)U=exp
		exp -= U
		intexp += U
		if(intexp >= intexpm)
			Int ++
			if(closs > 0)
				closs --
			con += 4
			proficiency ++
			cdpow -= 0.25
			trainingspeed += 2
			ryomulti += 4
			genlevel ++
			genresist ++
			critrate += 0.5
			regencha += 0.3
			intexp -= intexpm
		//	intexpm += increasemain(Int)
			src<<"<b><font color=white><font size=2><center>______________________________"
			src<<"<b><font color=white><font size=2><center>Your intelligence is now level [Int]"
			src<<"<b><center>+0.3 chakra regen per second, +4 chakra control, -1% genjutsu cooldown, +2% training speed, +4% business skill, +1 proficiency, +0.5% critical rate"
			levelup(1)
	spdexp()
		if(jailtime||Spd>=40||intut&&intut!=12||level>=globalcap)return
		var/U=exp
		if(U>round(spdexpm/10))U=round(spdexpm/10)
		if(U<50&&exp>=50)U=50
		if(exp<50)U=exp
		exp-=U
		spdexp+=U
		if(spdexp>=spdexpm)
			Spd++
			critdef++
			accuracy+=3
			critrate++
			if(intut==12)intut=13
			cdpow-=0.5
			cdapow-=1.2
			attackdelay+=2
			dodge+=3
			spdexp-=spdexpm
		//	spdexpm+=increasemain(Spd)
			switch(Spd)
				if(2)
					src<<"<b><font color=lime>You have learned Body Flicker Technique! This move makes you dash forward quickly. This basic but important technique allows you to close the distance, escape, or travel quickly. Can not be used while binded or slowed."
					new/obj/jutsu/Body_Flicker_Technique(src)
				if(3)
					src<<"<b><font color=lime>You have learned Substitution! This move replaces your body with a log and dashes you back, evading any non-piercing projectiles and removing all slows and binds on you except for full body ones like shadow imitation."
					new/obj/jutsu/Substitution(src)
				if(5,11,19)
					ninprojspeed++
					src<<"<b><font color=lime>Your ninjutsu projectile speed has increased!"
				if(10,20)
					rundelay--
					src<<"<b><font color=lime>Your run speed has increased!"
				if(8)
					src<<"<b><font color=lime>You have learned Backdash! You perform a quick leap backwards, quickly getting out of a dangerous area. Does not work while slowed or binded."
					new/obj/jutsu/Backdash(src)
				if(10,28)
					critrate+=3
					src<<"<b><font color=lime>Your critical rate has increased by 3%!"
				if(13)src<<"<b><font color=lime>You have learned Improved Hide(Passive)! You now make a puff instead of a cloak, leave less of a trail when you move and is able to move as normal speed while hiding."
				if(15)
					src<<"<b><font color=lime>You have learned Mastered Substitution! This advanced substitution also makes you invisible for 5 seconds and make you immune to binds/slows for 10 seconds after using it."
					new/obj/jutsu/Mastered_Substitution(src)
				if(17)src<<"<b><font color=lime>You have learned Ambush(Passive)! Your next attack within 2 seconds of coming out of hide will do 30% more damage and has a 30% higher chance to critically strike."
				if(21)
					critrate+=4
					src<<"<b><font color=lime>Your critical rate has increased by 4%"
				//if(23)
				//	src<<"<b><font color=lime>You have learned Assassinate! This move instantly positions you behind a enemy's back and stuns them momentarily, allowing you to execute deadly criticals. Must be facing them and within 4 steps to activate."
				//	new/obj/jutsu/Assassinate(src)
				if(30)
					rundelay=1
					src<<"<b><font color=lime>You have learned Agility Mastery(Passive)! You are now more resistant to slows and move at the maximum speed!"
				if(26)
					src<<"<b><font color=lime>You have learned Lightning Flash! This move when activated lets you teleport to anywhere on the screen unless you are slowed or binded."
					new/obj/jutsu/troj/Lightning_Flash(src)
				if(30)src<<"<b><font color=lime>You have learned Evasion(Passive)! You now have a 12% chance to reduce the damage of any attack by 90%!"
			src<<"<b><font color=white><font size=2><center>______________________________"
			src<<"<b><font color=white><font size=2><center>Your speed is now level [Spd]"
			src<<"<b><center>+1% critical defense, +1% critical rate, -0.5% ninjutsu cooldown, -1.2% taijutsu cooldown, +2% attack speed, +3% dodge"
			levelup()
	taiexp()
		if(jailtime||Tai>=40||intut||level>=globalcap)return
		var/U=exp
		if(U>round(taiexpm/10))U=round(taiexpm/10)
		if(U<50&&exp>=50)U=50
		if(exp<50)U=exp
		exp-=U
		taiexp+=U
		if(taiexp>=taiexpm)
			Tai++
			if(Tai>Hsl)proficiency+=2
			apow+=0.5
			accuracy+=4
			attackdelay+=6
			dodge+=3
			if(clan=="Yuki"&&tier43)pow+=tier43
			taiexp-=taiexpm
		//	taiexpm+=increasemain(Tai)
			src<<"<b><font color=white><font size=2><center>______________________________"
			src<<"<b><font color=white><font size=2><center>Your taijutsu is now level [Tai]"
			src<<"<b><center>+6% attack speed, +3% dodge, +4% accuracy, +0.5 attack power, +2 proficiency"
			levelup()
	ninexp()
		if(jailtime||Nin>=40||intut||level>=globalcap)return
		var/U=exp
		if(U>round(ninexpm/10))U=round(ninexpm/10)
		if(U<50&&exp>=50)U=50
		if(exp<50)U=exp
		exp-=U
		ninexp+=U
		if(ninexp>=ninexpm)
			Nin++
			pow+=2
			ninexp-=ninexpm
			if(clan=="Yuki"&&tier43)apow+=tier43*2
		//	ninexpm+=increasemain(Nin)
			src<<"<b><font color=white><font size=2><center>______________________________"
			src<<"<b><font color=white><font size=2><center>Your ninjutsu is now level [Nin]"
			src<<"<b><center>+2 ninjutsu power"
			levelup()
	hslexp()
		if(jailtime||Hsl>=40||intut||level>=globalcap)return
		var/U=exp
		if(U>round(hslexpm/10))U=round(hslexpm/10)
		if(U<50&&exp>=50)U=50
		if(exp<50)U=exp
		exp-=U
		hslexp+=U
		if(hslexp>=hslexpm)
			Hsl++
			if(Hsl>Tai)proficiency+=2
			con+=2
			cdpow-=0.75
			handseals-=0.33
			hslexp-=hslexpm
		//	hslexpm+=increasemain(Hsl)
			src<<"<b><font color=white><font size=2><center>______________________________"
			src<<"<b><font color=white><font size=2><center>Your handseal is now level [Hsl]"
			src<<"<b><center>+2 chakra control, +0.33 second handseal speed, -0.75% ninjutsu cooldown, +2 proficiency"
			levelup()
	statsupdate()
		spdexp(0)
		hslexp(0)
		ninexp(0)
		staexp(0)
		intexp(0)
		apowexp(0)
		intexp(0)
		taiexp(0)
	levelup(var/S=0)
		if(level>=globalcap)return
		level++
	//	maxexpgain()
		var/MHP=3
		switch(clan)
			if("Yuki","Sand","Fan")
				MHP=3
			if("Nara","Uchiha","Spider","Taijutsu Specialist","Copy Ninja","Medic","Clay")
				MHP=4
			if("Iron","Kaguya","Senju","Hyuuga","Snake")
				MHP=5
		var/MCHA=2
		switch(S)
			if(1)MCHA+=6
			if(2)MHP+=15
			if(3)MHP+=4
		if(level==2)
			missioned=0
			client.screen+=new/obj/hudbuttons/Mission
			src<<"<font color=coral><center>________________________________"
			src<<"<br>"
			src<<"<font color=coral><center>You have a new mission available"
			src<<"<br>"
			src<<"<font color=coral><center>________________________________"
		if(level==20&&rank=="Academy Student")
			rank="Genin"
			tmprank="Genin"
			src<<"<font color=coral><center>________________________________"
			src<<"<br>"
			src<<"<font color=coral><center>You are now a Genin."
			src<<"<br>"
			src<<"<font color=coral><center>________________________________"
			src<<"<b>You have received a Shinobi Headband!"
			new/obj/items/equippable/Shinobi_Headband(src)
		if(rank=="Chunin")
			amissionreq--
			checkjounin()
		basehp+=MHP
		basecha+=MCHA
		if(clan=="Hyuuga"&&tier13)MCHA=round(MCHA*(1+0.1*tier13))
		if(clan=="Fan"&&tier32)MCHA=round(MCHA*(1+0.1*tier32))
		if(clan=="Copy Ninja"&&tier22)MCHA=round(MCHA*(1+0.1*tier22))
		if(clan=="Copy Ninja"&&tier32)MHP=round(MHP*(1+0.05*tier32))
		if(clan=="Sand"&&tier12)MCHA=round(MCHA*(1+0.1*tier12))
		if(clan=="Uchiha"&&tier43)MCHA=round(MCHA*(1+0.1*tier43))
		if(clan=="Hyuuga"&&tier22)MHP=round(MHP*(1+0.05*tier22))
		if(clan=="Uchiha")if(tier32)MHP=round(MHP*(1+0.05*tier32))
		if(clan=="Kaguya"&&tier12)MHP=round(MHP*(1+0.05*tier12+0.03*tier11))
		src<<"<b><center>+[round(MHP)] health, +[round(MCHA)] chakra"
		maxhp+=MHP
		maxcha+=MCHA
		src<<"<b><font color=white><font size=2><center>You have leveled up! You are now level [level]!"
		if(level==2||level%3==0)
			skillpoint++
			src<<"<b><font color=white><center>Skill Point + 1([skillpoint])!"
		src<<"<b><font color=white><font size=2><center>______________________________"
		refreshword()
		if(level==60&&rank=="Genin")
			rank="Chunin"
			tmprank="Chunin"
			src<<"<font color=coral><center>________________________________"
			src<<"<br>"
			src<<"<font color=coral><center>You are now a Chunin."
			src<<"<br>"
			src<<"<font color=coral><center>________________________________"
			if(insquad)
				for(var/mob/player/M in world)
					if(M.squadname==squadname&&M.squadrank=="Squad Leader")
						M.leadershipskill++
						if(M.leadershipskill>=20)M.leadershipskill=20
						world<<"<b><center>[M] has gained a leadership skill!([M.leadershipskill] total)"
				insquad=0
				squadname=""
				squadrank=""
				guildbothoff()
				addnothing()
		switch(clan)
			if("Hyuuga")hyuugaleveling()
			if("Uchiha")uchihaleveling()
			if("Fan")windleveling()
			if("Yuki")yukileveling()
			if("Snake")snakeleveling()
			if("Iron")ironleveling()
			if("Sand")sandleveling()
			if("Kaguya")kaguyaleveling()
			if("Medic")medicleveling()
			if("Clay")clayleveling()
			if("Taijutsu Specialist")taileveling()
			if("Nara")naraleveling()
			if("Copy Ninja")copyninleveling()
			if("Senju")senjuleveling()
		switch(level)
			if(10)medal(1,1)
			if(20)medal(1,2)
			if(30)medal(1,3)
			if(40)medal(1,4)
			if(50)medal(1,5)
			if(60)medal(1,6)
			if(70)medal(1,7)
			if(80)medal(2,1)
			if(90)medal(2,2)
			if(100)medal(2,3)
			if(110)medal(2,4)
			if(120)medal(3,6)