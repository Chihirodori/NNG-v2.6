var
	snowT=0
	snowTV="Neutral"
	rainT=0
	rainTV="Neutral"
	grassT=0
	grassTV="Neutral"
	raiders=0
	defenders=0
	rainwar=0
	grasswar=0
	snowwar=0
	time=0
	warvil=""
	waraga=""
	warinprogress=0

mob
	var
		helpraid=0
		defendraid=0
		capturing=0
obj/warblockrain
obj/warblockgrass
obj/warblocksnow
mob
	verb
		ToggleWar()
			set hidden = 1
			if(intut>=1||ingenin>=1||inchunin>=1||rank=="Academy Student"||rank=="Gennin"||jailtime>=1||hosptime>=1) return
			if(usr.village=="[warvil]")
				if(usr.helpraid==0)
					usr.helpraid=1
					raiders+=1
					usr<<"You are in the war"
				else
					usr.helpraid=0
					raiders-=1
					if(raiders<0)
						raiders=0
					usr<<"You are out the war"
			if(usr.village=="[waraga]")
				if(usr.defendraid==0)
					usr.defendraid=1
					defenders+=1
					usr<<"You are in the war"
				else
					usr.defendraid=0
					defenders-=1
					if(defenders<0)
						defenders=0
					usr<<"You are out the war"


proc
	rainwartimer()
		set background=1
		here
			rainwar--
			if(rainwar<=0)
				rainwar=0
				return
			spawn(10)goto here
	snowwartimer()
		here
			snowwar--
			if(snowwar<=0)
				snowwar=0
				return
			spawn(10)goto here
	grasswartimer()
		here
			grasswar--
			if(grasswar<=0)
				grasswar=0
				return
			spawn(10)goto here
	CheckWar(var/A,var/B,var/C)
		check
			time++
			if(defenders>=1&&raiders<=0)
				world<<"<b><font size=2><center>[A] has remained in control of the [C] village!"
				raiders=0
				defenders=0
				time=0
				warvil=""
				waraga=""
				warinprogress=0
				for(var/mob/player/M in world)
					M.helpraid=0
					M.defendraid=0
				if(C=="Snow")
					for(var/obj/warblocksnow/G in world)G.density=0
				if(C=="Rain")
					for(var/obj/warblockrain/G in world)G.density=0
				if(C=="Grass")
					for(var/obj/warblockgrass/G in world)G.density=0
				return
			if(defenders<=0&&raiders>=1)
				world<<"<b><font size=2><center>[B] has taken over the [C] village!"
				raiders=0
				defenders=0
				time=0
				if(C=="Snow")
					snowTV="[B]"
					for(var/obj/warblocksnow/G in world)G.density=0
				if(C=="Rain")
					rainTV="[B]"
					for(var/obj/warblockrain/G in world)G.density=0
				if(C=="Grass")
					grassTV="[B]"
					for(var/obj/warblockgrass/G in world)G.density=0
				for(var/mob/player/M in world)
					M.helpraid=0
					M.defendraid=0
				warvil=""
				waraga=""
				warinprogress=0
				return
			if(time>=300)
				world<<"<b><font size=2><center>The war has went on for to long. The [C] village is now neutral"
				raiders=0
				defenders=0
				time=0
				if(C=="Snow")
					snowTV="Neutral"
					for(var/obj/warblocksnow/G in world)G.density=0
				if(C=="Rain")
					rainTV="Neutral"
					for(var/obj/warblockrain/G in world)G.density=0
				if(C=="Grass")
					grassTV="Neutral"
					for(var/obj/warblockgrass/G in world)G.density=0
				for(var/mob/player/M in world)
					M.helpraid=0
					M.defendraid=0
				warvil=""
				waraga=""
				warinprogress=0
				return
			sleep(14)
			goto check
	Raid()
		if(usr.capturing)return
		if(usr.rank=="Hokage"||usr.rank=="Kazekage"||usr.rank=="Sound Leader"||usr.rank=="ANBU Leader"||usr.rank=="Akatsuki Leader")
			if(usr.z==2)
				if(usr.x>422&&usr.y<44&&usr.z==2)//Rain Village
					if(rainT==0)
						usr.capturing=1
						var/currenthp=usr.hp
						usr<<"<b>Remain in the village for 60 seconds without taking any damage, and you will capture this village."
						for(var/mob/player/C in world)C<<"<b><center><font color=silver>The [usr.rank] is trying to capture the neutral Rain village!"
						sleep(600)
						usr.capturing=0
						if(usr.x>422&&usr.y<44&&usr.z==2&&usr.hp>=currenthp&&rainT==0)//if Still in Village
							rainT=1
							rainTV="[usr.village]"
							for(var/mob/player/C in world)
								C<<"<b><center><font color=silver>The [usr.rank] has captured the Rain village!"
								C<<"<b><center><font color=silver>+5% damage/defense to [usr.village] villagers(doubled while inside the Rain village)"
								C<<"<b><center><font color=silver>+0.25 influence gain on missions for [usr.village] villagers"
							return
					if(rainTV=="[usr.village]")
						return
					if(rainwar>=1)
						alert(usr,"You cannot contest this village yet.")
						return
					usr.capturing=1
					usr<<"<b>Remain in the village for 60 seconds to go to war with [rainTV]."
					sleep(600)
					usr.capturing=0
					if(warvil!="")
						alert(usr,"Only one war can go on at a time.")
						return
					if(usr.x>422&&usr.y<44&&usr.z==2)//if M is still in the village
						switch(alert(usr,"Do you want to go to war with [rainTV] over the Rain village?",,"Yes","No"))
							if("Yes")
								if(warvil!="")
									alert(usr,"Only one war can go on at a time.")
									return
								warinprogress=1
								warvil="[usr.village]"
								waraga="[rainTV]"
								world<<"<font size=2><center><font color=silver>The [usr.rank] has declared war on [rainTV] over the Rain village!"
								sleep(50)
								world<<"<b><center><font color=silver>The war will begin in 30 seconds. Click on Village Wars under the NNG menu to join!"
								sleep(300)
								world<<"<b><center><font color=silver>Defenders: [defenders] [rainTV] Ninjas --- Attackers: [raiders] [usr.village] Ninjas"
								sleep(50)
								world<<"<b><center><font color=silver>3"
								sleep(18)
								world<<"<b><center><font color=silver>2"
								sleep(18)
								if(defenders==0)
									world<<"<b><center><font color=silver>[usr.village] has captured the Rain village!"
									world<<"<b><center><font color=silver>+5% damage/defense to [usr.village] villagers(doubled while inside the Rain village)"
									world<<"<b><center><font color=silver>+0.25 influence gain on missions for [usr.village] villagers"
									raiders=0
									defenders=0
									rainwar=0
									rainT=1
									rainTV="[usr.village]"
									warvil=""
									waraga=""
									warinprogress=0
									for(var/mob/player/M in world)
										M.helpraid=0
										M.defendraid=0
									return
								for(var/mob/player/Z in world)
									if(!Z.defendraid&&!Z.helpraid&&Z.x>422&&Z.y<44&&Z.z==2)Z.summonspawn()
									if(Z.defendraid>=1)
										if(Z.cloaking)
											Z.invisibility=1
											Z.soundeff(pick('puff.wav','puff2.wav','puff3.wav','puff4.wav','puff5.wav'),25,0)
											new/obj/smoke(Z.loc)
											Z.cloaking=0
										Z.hengeback()
										Z.loc=locate(429,20,2)
										Z.hp=Z.maxhp
										Z.cha=Z.maxcha
										if(Z.mybar)Z.mybar:updatebar()
										if(Z.mybar2)Z.mybar2:updatebar()
										Z<<"<b>Remain in the Rain village until the end of the war or until you're killed."
									if(Z.helpraid>=1)
										if(Z.cloaking)
											Z.invisibility=1
											Z.soundeff(pick('puff.wav','puff2.wav','puff3.wav','puff4.wav','puff5.wav'),25,0)
											new/obj/smoke(Z.loc)
											Z.cloaking=0
										Z.hengeback()
										Z.loc=locate(496,20,2)
										Z.hp=Z.maxhp
										Z.cha=Z.maxcha
										if(Z.mybar)Z.mybar:updatebar()
										if(Z.mybar2)Z.mybar2:updatebar()
										Z<<"<b>Remain in the Rain village until the end of the war or until you're killed."
								world<<"<b><center><font color=silver>1"
								world<<"<b><center><font color=silver>WAR!"
								for(var/obj/warblockrain/G in world)G.density=1
								rainwar=1800
								rainwartimer()
								CheckWar("[rainTV]","[usr.village]","Rain")
				if(usr.x<79&&usr.y>454&&usr.z==2)//Grass Village
					if(grassT==0)
						var/currenthp=usr.hp
						usr<<"<b>Remain in the village for 60 seconds without taking any damage, and you will capture this village."
						for(var/mob/player/C in world)C<<"<b><center><font color=silver>The [usr.rank] is trying to capture the neutral Grass village!"
						usr.capturing=1
						sleep(600)
						usr.capturing=0
						if(usr.x<79&&usr.y>454&&usr.z==2&&usr.hp>=currenthp&&grassT==0)//if Still in Village
							grassT=1
							grassTV="[usr.village]"
							for(var/mob/player/C in world)
								C<<"<b><center><font color=silver>The [usr.rank] has captured the Grass village!"
								C<<"<b><center><font color=silver>+5% damage/defense to [usr.village] villagers(doubled while inside the Grass village)"
								C<<"<b><center><font color=silver>+0.25 influence gain on missions for [usr.village] villagers"
							return
					if(grassTV=="[usr.village]")
						return
					if(grasswar>=1)
						alert(usr,"You cannot contest this village yet.")
						return
					usr<<"<b>Remain in the village for 60 seconds to go to war with [grassTV]."
					usr.capturing=1
					sleep(600)
					usr.capturing=0
					if(warvil!="")
						alert(usr,"Only one war can go on at a time.")
						return
					if(usr.x<79&&usr.y>454&&usr.z==2)//if M is still in the village
						switch(alert(usr,"Do you want to go to war with [grassTV] over the Grass village?",,"Yes","No"))
							if("Yes")
								if(warvil!="")
									alert(usr,"Only one war can go on at a time.")
									return
								warinprogress=1
								warvil="[usr.village]"
								waraga="[grassTV]"
								world<<"<font size=2><center><font color=silver>The [usr.rank] has declared war on [grassTV] over the Grass village!"
								sleep(50)
								world<<"<b><center><font color=silver>The war will begin in 30 seconds. Click on Village Wars under the NNG menu to join!"
								sleep(300)
								world<<"<b><center><font color=silver>Defenders: [defenders] [grassTV] Ninjas --- Attackers: [raiders] [usr.village] Ninjas"
								sleep(50)
								world<<"<b><center><font color=silver>3"
								sleep(18)
								world<<"<b><center><font color=silver>2"
								sleep(18)
								if(defenders==0)
									world<<"<b><center><font color=silver>[usr.village] has captured the Grass village!"
									world<<"<b><center><font color=silver>+5% damage/defense to [usr.village] villagers(doubled while inside the Grass village)"
									world<<"<b><center><font color=silver>+0.25 influence gain on missions for [usr.village] villagers"
									raiders=0
									defenders=0
									grasswar=0
									grassT=1
									grassTV="[usr.village]"
									warvil=""
									waraga=""
									warinprogress=0
									for(var/mob/player/M in world)
										M.helpraid=0
										M.defendraid=0
									return
								for(var/mob/player/Z in world)
									if(!Z.defendraid&&!Z.helpraid&&Z.x<79&&Z.y>454&&Z.z==2)Z.summonspawn()
									if(Z.defendraid>=1)
										if(Z.cloaking)
											Z.invisibility=1
											Z.soundeff(pick('puff.wav','puff2.wav','puff3.wav','puff4.wav','puff5.wav'),25,0)
											new/obj/smoke(Z.loc)
											Z.cloaking=0
										Z.hengeback()
										Z.loc=locate(6,473,2)
										Z.hp=Z.maxhp
										Z.cha=Z.maxcha
										if(Z.mybar)Z.mybar:updatebar()
										if(Z.mybar2)Z.mybar2:updatebar()
										Z<<"<b>Remain in the Grass village until the end of the war or until you're killed."
									if(Z.helpraid>=1)
										if(Z.cloaking)
											Z.invisibility=1
											Z.soundeff(pick('puff.wav','puff2.wav','puff3.wav','puff4.wav','puff5.wav'),25,0)
											new/obj/smoke(Z.loc)
											Z.cloaking=0
										Z.hengeback()
										Z.loc=locate(75,473,2)
										Z.hp=Z.maxhp
										Z.cha=Z.maxcha
										if(Z.mybar)Z.mybar:updatebar()
										if(Z.mybar2)Z.mybar2:updatebar()
										Z<<"<b>Remain in the Grass village until the end of the war or until you're killed."
								world<<"<b><center><font color=silver>1"
								world<<"<b><center><font color=silver>WAR!"
								for(var/obj/warblockgrass/G in world)G.density=1
								grasswar=1800
								grasswartimer()
								CheckWar("[grassTV]","[usr.village]","Grass")
				if(usr.x>425&&usr.y>462&&usr.z==2)//Snow Village
					if(snowT==0)
						var/currenthp=usr.hp
						usr<<"<b>Remain in the village for 60 seconds without taking any damage, and you will capture this village."
						for(var/mob/player/C in world)C<<"<b><center><font color=silver>The [usr.rank] is trying to capture the neutral Snow village!"
						usr.capturing=1
						sleep(600)
						usr.capturing=0
						if(usr.x>425&&usr.y>462&&usr.z==2&&usr.hp>=currenthp&&snowT==0)//if Still in Village
							snowT=1
							snowTV="[usr.village]"
							for(var/mob/player/C in world)
								C<<"<b><center><font color=silver>The [usr.rank] has captured the Snow village!"
								C<<"<b><center><font color=silver>+5% damage/defense to [usr.village] villagers(doubled while inside the Snow village)"
								C<<"<b><center><font color=silver>+0.25 influence gain on missions for [usr.village] villagers"
							return
					if(snowTV=="[usr.village]")
						return
					if(snowwar>=1)
						alert(usr,"You cannot contest this village yet.")
						return
					usr<<"<b>Remain in the village for 60 seconds to go to war with [snowTV]."
					usr.capturing=1
					sleep(600)
					usr.capturing=0
					if(warvil!="")
						alert(usr,"Only one war can go on at a time.")
						return
					if(usr.x>425&&usr.y>462&&usr.z==2)//if M is still in the village
						switch(alert(usr,"Do you want to go to war with [snowTV] over the Snow village?",,"Yes","No"))
							if("Yes")
								if(warvil!="")
									alert(usr,"Only one war can go on at a time.")
									return
								warinprogress=1
								warvil="[usr.village]"
								waraga="[snowTV]"
								world<<"<font size=2><center><font color=silver>The [usr.rank] has declared war on [snowTV] over the Snow village!"
								sleep(50)
								world<<"<b><center><font color=silver>The war will begin in 30 seconds. Click on Village Wars under the NNG menu to join!"
								sleep(300)
								world<<"<b><center><font color=silver>Defenders: [defenders] [snowTV] Ninjas --- Attackers: [raiders] [usr.village] Ninjas"
								sleep(50)
								world<<"<b><center><font color=silver>3"
								sleep(18)
								world<<"<b><center><font color=silver>2"
								sleep(18)
								if(defenders==0)
									world<<"<b><center><font color=silver>[usr.village] has captured the Snow village!"
									world<<"<b><center><font color=silver>+5% damage/defense to [usr.village] villagers(doubled while inside the Snow village)"
									world<<"<b><center><font color=silver>+0.25 influence gain on missions for [usr.village] villagers"
									raiders=0
									defenders=0
									snowwar=0
									snowT=1
									snowTV="[usr.village]"
									warvil=""
									waraga=""
									warinprogress=0
									for(var/mob/player/M in world)
										M.helpraid=0
										M.defendraid=0
									return
								for(var/mob/player/Z in world)
									if(!Z.defendraid&&!Z.helpraid&&Z.x>425&&Z.y>462&&Z.z==2)Z.summonspawn()
									if(Z.defendraid>=1)
										if(Z.cloaking)
											Z.invisibility=1
											Z.soundeff(pick('puff.wav','puff2.wav','puff3.wav','puff4.wav','puff5.wav'),25,0)
											new/obj/smoke(Z.loc)
											Z.cloaking=0
										Z.hengeback()
										Z.loc=locate(437,483,2)
										Z.hp=Z.maxhp
										Z.cha=Z.maxcha
										if(Z.mybar)Z.mybar:updatebar()
										if(Z.mybar2)Z.mybar2:updatebar()
										Z<<"<b>Remain in the Snow village until the end of the war or until you're killed."
									if(Z.helpraid>=1)
										if(Z.cloaking)
											Z.invisibility=1
											Z.soundeff(pick('puff.wav','puff2.wav','puff3.wav','puff4.wav','puff5.wav'),25,0)
											new/obj/smoke(Z.loc)
											Z.cloaking=0
										Z.hengeback()
										Z.loc=locate(488,483,2)
										Z.hp=Z.maxhp
										Z.cha=Z.maxcha
										if(Z.mybar)Z.mybar:updatebar()
										if(Z.mybar2)Z.mybar2:updatebar()
										Z<<"<b>Remain in the Snow village until the end of the war or until you're killed."
								world<<"<b><center><font color=silver>1"
								world<<"<b><center><font color=silver>WAR!"
								for(var/obj/warblocksnow/G in world)G.density=1
								snowwar=1800
								snowwartimer()
								CheckWar("[snowTV]","[usr.village]","Snow")

