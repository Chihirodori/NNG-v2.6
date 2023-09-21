mob
	proc
		//atkdef
		atkdef()
			atk=100
			def=1
			if(restdef)
				def=5
			if(inzone&&!pktoggle)
				if(inzone==2)
					atk+=50
					def*=0.5
				else
					atk+=15
					def*=0.9
				if(rank=="Academy Student"&&level<15)
					def*=0.25
			if(village=="Akatsuki")
				if(rank=="Akatsuki Leader")
					def*=0.90
					atk+=10
				else
					def*=0.95
					atk+=5
				for(var/mob/player/M in oview(10))if(M.village=="Akatsuki")
					def*=0.97
					atk+=3
				if(special==/obj/kakazuring)def*=0.80
				if(special==/obj/peinring)def*=0.95
			if(clan=="Taijutsu Specialist")
				if(Debuff=="Muscle Tear")atk-=25
				if(Gate=="View")atk+=25+(5*tier51)
			if(recurrence)atk+=recurrence*(2*tier63)
			if(imitationdebuff)atk-=30
			if(purolin)
				if(purolin==1)atk-=10
				else	atk+=10
			if(village=="[grassTV]")
				def*=0.95
				atk+=5
				if(x<79&&y>454&&z==2)
					def*=0.95
					atk+=5
			if(village=="[snowTV]")
				def*=0.95
				atk+=5
				if(x>425&&y>462&&z==2)
					def*=0.95
					atk+=5
			if(village=="[rainTV]")
				def*=0.95
				atk+=5
				if(x>422&&y<44&&z==2)
					def*=0.95
					atk+=5
			if(inmist<0&&level>=35)
				def*=0.8
			if(pines)
				if(pines==1)def*=0.70
				if(pines==2)def*=0.60
			if(buffed>=2)
				def*=0.95
			if(genesis)
				def*=0.7
			if(crowed)
				def*=0.6
			if(relentless && clan=="Kaguya")
				def *= 1-(0.01*tier22*relentless)
			if(superholy)
				atk+=superholy
			if(genesisweaken)
				def*=1+(0.01*genesisweaken)
			if(buffed)
				atk+=10
			if(clan == "Uchiha")
				if(corrupt == 2)
					atk += 10
			if(hatred)
				atk -= 10
			if(clan=="Medic")
				atk+=4*tier12
				def*=1-0.04*tier13
				if(level>=120)
					atk+=10
					def*=0.95
				if(tier43&&buffcan)
					atk+=0.3*tier43*buffcan
					def*=1-0.03*tier43*buffcan
			if(rally)
				def*=0.9
				atk+=10
			if(selfrally)atk+=10
			if(tactics)
				atk+=tactics*5
				def*=1-0.03*tactics
			if("Leaf")
				atk+=leafter
				def*=1-(0.01*leafter)
			if("Sand")
				atk+=sandter
				def*=1-(0.01*sandter)
			if("Sound")
				atk+=soundter
				def*=1-(0.01*soundter)
			if("Akatsuki")
				atk+=akatter
				def*=1-(0.01*akatter)
			if(stance=="fmirror")
				def*=0.2
			switch(sharingan)
				if(2)
					atk+=5
					def*=0.95
				if(3)
					atk+=8
					def*=0.92
				if(4)
					atk+=15
					def*=0.85
				if(5)
					atk+=10
					def*=0.9
			if(rapidkilling)
				atk+=40
			if(clan=="Snake")
				atk+=3*tier12
			if(clan=="Yuki")
				atk+=2*tier62
			if(inbarrier==2)
				if(level<75)
					def*=0.8
				atk+=15
				if(level>=75)
					def*=0.8
				if(level>=120)
					atk+=30
			if(perk1==1)
				atk+=10
			if(coffinshield)
				def*=0.6
			if(treecaught)
				def*=0.5
			if(susanoo)
				def*=0.5
			if(preheal)
				def*=1-0.01*preheal
			if(lusted==3)
				atk+=tier43*10
			if(bonegolem)
				def*=0.75
			if(clan=="Sand")
				atk+=4*tier13
			if(clan=="Nara")
				atk+=4*tier12
			if(clan=="Clay")
				atk+=4*tier12
				if(tier31==1&&hp<maxhp*0.15||tier31==2&&hp<maxhp*0.30||tier31==3&&hp<maxhp*0.45)
					def*=0.6
				if(tier43&&hp<maxhp*0.50)
					atk+=10*tier43
				if(c4defense)
					def*=1-(0.25*tier63)
			if(clan=="Senju")
				if(tier31&&hp>=maxhp*0.50)def*=1-(0.05*tier31)
				if(stumpstance)
					def*=1-(0.05*tier13)
				if(prisonup)
					def*=1-(0.03*tier51)
					atk+=3*tier51
				if(sagemode)
					def*=1-(0.03*tier63)
					atk+=3*tier63
			if(clan=="Fan")
				def*=1-(0.02*tier12)
				atk+=3*tier53
			if(marked)
				def*=1+(0.1*marked)
			if(crippledd)
				def*=1+(0.05*crippledd)
			if(edo&&tier61)
				def*=1-(0.08*tier61)
			if(powered)
				if(rank=="Hokage"||rank=="Kazekage"||rank=="Sound Leader")
					def*=0.9
					atk+=15
			if(imperialpierce)
				def*=1.2
			if(windshield)
				def*=1-(0.05*tier21)
			if(village=="Leaf"&&leafpriority=="Aggressiveness"||village=="Sand"&&sandpriority=="Aggressiveness"||village=="Sound"&&soundpriority=="Aggressiveness")
				atk += 15
			if(weapon == /obj/bonesword)
				atk += wdmg * 2
			atkstr = atk
			if(clan=="Kaguya")
				if(stance=="Extreme Condensing")atkstr+=12*tier51
				atkstr+=4*tier33
				def*=1-(0.04*tier11)
				if(lusted>=2)
					def*=1.3
			if(clan=="Hyuuga")
				atkstr+=6*tier12
				def*=1-(0.04*tier11)
			if(goldsand)
				def*=1-(0.1*tier53)
			if(rainingmen)
				def*=1-(0.1*tier33)
			if(clan=="Medic"&&tier32&&preheal)
				atkstr+=15*tier32
			if(clan=="Uchiha")
				atk+=4*tier11
				if(tier53)atk+=30
			if(mask==/obj/gilgamesh)def=0
			def=round((1-def)*100,0.1)
			if(mangdef)
				def-=mangdef
			if(winddebuff)def-=winddebuff*5
			if(superholy)def+=superholy
			if(def>80)def=80
			if(sandshield)def=95
		//statset
		statset()
			basecha=80+Int*6+level*3
			switch(clan)
				if("Clay","Yuki","Senju","Nara","Fan","Copy Ninja")
					basehp=512+Sta*15+Str*4+level*4
				if("Iron","Uchiha","Spider","Sand")
					basehp=556+Sta*15+Str*4+level*5
				if("Taijutsu Specialist","Medic","Hyuuga")
					basehp=584+Sta*15+Str*4+level*5
				if("Snake","Kaguya")
					basehp=625+Sta*15+Str*4+level*7
			maxhp=basehp
			maxcha=basecha
			if(perk1==2)maxhp=round(maxhp*1.1)
			if(clan=="Hyuuga")
				if(tier13)maxcha=round(maxcha*(1+0.1*tier13))
				if(tier22)maxhp=round(maxhp*(1+0.05*tier22))
			if(clan=="Fan")
				maxhp+=tier12*25
				if(tier32)maxcha=round(maxcha*(1+0.1*tier32))
			if(clan=="Sand")maxcha=round(maxcha*(1+0.1*tier12))
			if(clan=="Uchiha"&&tier41)maxcha=round(maxcha*(1+0.1*tier41))
			if(clan=="Uchiha")if(tier32)maxhp=round(maxhp*(1+0.05*tier32))
			if(clan=="Kaguya")
				if(tier12)maxhp=round(maxhp*(1+0.05*tier12))
				if(tier61)maxhp+=300
			if(clan=="Copy Ninja")
				if(tier32)maxhp=round(maxhp*(1+0.05*tier32))
				if(tier22)maxcha=round(maxcha*(1+0.1*tier22))
			if(clan=="Nara")
				if(tier21)maxhp=round(maxhp*(1+0.05*tier21))
				if(tier22)maxcha=round(maxcha*(1+0.1*tier22))
			if(clan=="Iron")
				if(tier12)maxhp=round(maxhp*(1+0.05*tier12))
			if(clan=="Medic")
				if(tier23)maxhp=basehp*(1+usr.tier23*0.05)
				if(tier33)maxcha=basecha*(1+usr.tier33*0.1)
			if(clan=="Taijutsu Specialist")
				if(tier23)maxhp=round(maxhp*(1+0.05*tier23))
			regenupdate()
			con=Hsl*2+Int*4
			if(buffed>=3)con*=1.25
			handseals=1.5-Hsl/3
			switch(Str)
				if(1 to 4)projspeed=1
				if(5 to 9)projspeed=2
				if(10 to 14)projspeed=3
				else projspeed=4
			if(Tai>=Hsl)proficiency=Tai*2+Int
			else proficiency=Hsl*2+Int
			trainingspeed=100+Int*2
			if(clan=="Uchiha")
				trainingspeed+=tier13*4
			if(clan=="Snake")trainingspeed+=3*tier12
			ryomulti = Int*4
			genlevel=Int
			genresist=Int
			switch(Spd)
				if(1 to 9)rundelay=4
				if(10 to 19)rundelay=3
				if(20 to 29)rundelay=2
				if(30 to 39)rundelay=1
				else rundelay=0
			if(buffed>=4)rundelay--
			switch(Spd)
				if(1 to 4)ninprojspeed=1
				if(5 to 9)ninprojspeed=2
				if(10 to 14)ninprojspeed=3
				else ninprojspeed=4
			critdef=Spd
			if(clan=="Snake")
				if(tier13)maxhp=round(maxhp*(1+0.05*tier13))
			forceupdate()
		//forceupdate
		forceupdate()
			critrate=2+Spd+Int/2
			if(byakugan)critrate+=5+byakugan*5
			switch(Spd)
				if(10 to 20)critrate+=3
				if(21 to 28)critrate+=7
				if(28 to 40)critrate+=10
			cdapow=110-Spd*1.2
			cdpow=110-Hsl*0.75-Int/4-Spd/2
			if(recurrence)cdpow-=recurrence*(tier63*2)
			if(perk1==4)
				cdapow-=10
				cdpow-=10
			if(treehealed)
				cdapow-=10
				cdpow-=10
			accuracy=85+Tai*4+Spd*3
			dodge=10+Tai*3+Spd*3
			attackdelay=70+Tai*6+Spd*2
			if(clan=="Hyuuga")
				critrate+=tier52*3
				attackdelay+=8*tier52
			if(clan=="Iron")
				critrate+=5*tier22
			if(stance=="hurricane")
				cdpow+=45-15*tier23
			if(clan=="Copy Ninja" && tier11)
				cdpow -= 4 * tier11
				cdapow -= 4 * tier11
			handseals=1.5-Hsl/3
			apow=30+Str*1.5+Tai*0.5
			pow=30+Nin*2
			if(byakugan)apow+=round(level*0.15)
			if(stance=="Rapid Palms")
				//apow+=0.5*tier53*Spd  //removed because OP
				attackdelay+=15*tier53*rapidstack
			if(clan=="Senju"&&thornstance)pow+=tier12*7
			if(clan=="Uchiha")
				pow+=tier13*2
				dodge+=5+5*tier21
				attackdelay+=15*tier21
				cdpow-=5*tier33
			if(clan=="Snake"&&tier43)
				apow=30+tier43*15+Str*1.5*(1-(0.1+0.1*tier43))+Tai*0.5*(1-(0.1+0.1*tier43))
				pow=30+tier43*15+Nin*2*(1-(0.1+0.1*tier43))
			if(stance=="Chakra Enhanced Strength")
				apow += tier22*10
			if(clan=="Taijutsu Specialist")
				if(tier11)apow+=3*tier11
				if(tier13)accuracy+=20*tier13
				if(Gate=="Opening")attackdelay+=100+(5*tier51)
				if(Debuff=="Tired")attackdelay-=50
				if(hundredfists)attackdelay+=50*tier53
			if(clan=="Copy Ninja")
				if(tier23)apow+=5*tier23
				if(tier33)pow+=5*tier33
			if(clan=="Iron")
				if(tier23)
					cdpow-=3*tier23
					cdapow-=3*tier23
				if(tier23)handseals-=tier23*0.3
			if(clan=="Yuki")
				handseals-=tier11*0.3
				cdpow-=tier11*3
				cdapow-=tier11*3.
				if(tier43)
					apow+=tier43*0.2*Nin
					pow+=tier43*(Str+Tai)*0.1
				attackdelay+=10*tier12
			if(clan=="Senju"&&sagemode)attackdelay+=50*tier63
			if(clan=="Kaguya")
				attackdelay+=9*tier23
				if(stance=="Extreme Condensing")
					critrate+=25*tier51
					attackdelay-=30
				if(stance=="Double Blades")
					apow+=0.4*tier42*Spd
					attackdelay+=15*tier42
			if(disabledelay)
				attackdelay-=30
				handseals+=1.5
			if(weapon!=/obj/kusanagi&&clan=="Snake")
				kusan=0
				relentless=0
				relentless(0)
			switch(nervous)
				if(1)
					handseals+=2.5
				if(2)
					handseals+=2.5
					attackdelay*=0.5
			switch(byakugan)
				if(1)
					accuracy+=30
					dodge+=10
					handseals-=1.5
					cdapow-=4
				if(2)
					attackdelay+=15
					accuracy+=60
					cdapow-=8
				if(3)
					accuracy+=250
					dodge+=40
					attackdelay+=30
					cdapow-=12
			switch(sharingan)
				if(1)
					accuracy+=15
					dodge+=10
					handseals-=1.5
				if(2)
					accuracy+=25
					dodge+=20
					cdpow-=15
					cdapow-=15
					handseals-=2.5
				if(3)
					accuracy+=50
					dodge+=40
					cdpow-=15
					cdapow-=15
					handseals-=3.5
				if(4)
					accuracy+=250
					dodge+=100
					cdpow-=25
					cdapow-=25
					handseals-=6
				if(5)
					accuracy+=50
					dodge+=40
					cdpow-=15
					cdapow-=15
					handseals-=4.5
			if(clan=="Copy Ninja"&&tier12)
				cdpow-=4*tier12
				cdapow-=4*tier12
			if(stance=="Precise Striking")
				attackdelay=100+50*tier33
			if(GM<3)
				if(cdpow<50)
					var/Z=50-cdpow
					pow+=Z
					cdpow=50
				if(cdapow<50)
					var/Z=50-cdapow
					apow+=Z
					cdapow=50
			if(maimingshock)
				handseals*=2
				attackdelay*=0.50
			atkdef()
