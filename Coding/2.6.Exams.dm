var/genintime=1550
var/chunintime=5000

world/proc
	geninexam()
		set background=1
		while(genintime>0)
			sleep(10)
			if(genintime==300)
				for(var/mob/G in world)if(G.rank=="Academy Student")G<<"<b><font color=red><u>Exam Info: The Genin Exam is starting in five minutes! The Shinobi Academy has opened up!"
				geninexam=1
			if(genintime==180)
				for(var/mob/G in world)if(G.rank=="Academy Student")G<<"<b><font color=red><u>Exam Info: The Genin Exam is starting in three minutes!"
			if(genintime==120)
				for(var/mob/G in world)if(G.rank=="Academy Student")G<<"<b><font color=red><u>Exam Info: The Genin Exam is starting in two minutes!"
			if(genintime==60)
				for(var/mob/G in world)if(G.rank=="Academy Student")G<<"<b><font color=red><u>Exam Info: The Genin Exam is starting in one minute!"
			if(genintime==10)
				for(var/mob/G in world)if(G.rank=="Academy Student")G<<"<b><font color=red><u>Exam Info: The Genin Exam is starting in 10 seconds!"
			genintime--
		geninexamst()
	geninexamst()
		set background=1
		for(var/mob/player/G in world)if(G.rank=="Academy Student")G<<"<b><font color=red><u>Exam Info: The Genin Exam has started! The Shinobi Academy door is now closed!"
		geninexam=2
		for(var/mob/player/M in world)if(M.ingenin==1)if(M.rank=="Academy Student")M<<"<b>You have one minute to answer all the questions. If you get at least 7 out of 10 questions right you will pass this part of the exam. You may begin."
		sleep(100)
		for(var/mob/player/M in world)if(M.ingenin==2)M<<"<b><font color=red><center>50 seconds remaining."
		sleep(100)
		for(var/mob/player/M in world)if(M.ingenin==2)M<<"<b><font color=red><center>40 seconds remaining."
		sleep(100)
		for(var/mob/player/M in world)if(M.ingenin==2)M<<"<b><font color=red><center>30 seconds remaining."
		sleep(100)
		for(var/mob/player/M in world)if(M.ingenin==2)M<<"<b><font color=red><center>20 seconds remaining."
		sleep(100)
		for(var/mob/player/M in world)if(M.ingenin==2)M<<"<b><font color=red><center>10 seconds remaining."
		sleep(100)
		geninexam=3
		for(var/mob/player/M in world)if(M.ingenin==3)
			M.z=4
			M<<"<b><font size=3>You have passed the written test of the exam. The next task is to transform into the same objects as the instructor in time. This task will start in half a minute."
		sleep(300)
		for(var/mob/player/M in world)if(M.ingenin==3)
			M<<"<b><font size=4><center>The practical test has begun."
			M.ingenin=4
		sleep(90)
		for(var/obj/GeninI/M in world)
			M.overlays=0
			new/obj/smoke(M)
			M.overlays+=/obj/Tree/tree
		sleep(90)
		for(var/mob/player/M in world)if(M.ingenin>=4)if(M.name=="Tree")
			M.ingenin++
			M<<"<b>You gained 1 point."
		for(var/obj/GeninI/M in world)
			M.overlays=0
			new/obj/smoke(M)
		sleep(90)
		for(var/obj/GeninI/M in world)
			M.overlays=0
			new/obj/smoke(M)
			M.overlays+=/obj/Scarecrow
		sleep(90)
		for(var/mob/player/M in world)if(M.ingenin>=4)if(M.name=="Scarecrow")
			M.ingenin++
			M<<"<b>You gained 1 point."
		for(var/obj/GeninI/M in world)
			M.overlays=0
			new/obj/smoke(M)
		sleep(90)
		for(var/obj/GeninI/M in world)
			M.overlays=0
			new/obj/smoke(M)
			M.overlays+=/obj/Cactus
		sleep(90)
		for(var/mob/player/M in world)if(M.ingenin>=4)if(M.name=="Cactus")
			M.ingenin++
			M<<"<b>You gained 1 point."
		for(var/obj/GeninI/M in world)
			M.overlays=0
			new/obj/smoke(M)
		sleep(90)
		for(var/obj/GeninI/M in world)
			M.overlays=0
			new/obj/smoke(M)
			M.overlays+=/obj/Tree/tree
		sleep(90)
		for(var/mob/player/M in world)if(M.ingenin>=4)if(M.name=="Tree")
			M.ingenin++
			M<<"<b>You gained 1 point."
		for(var/obj/GeninI/M in world)
			M.overlays=0
			new/obj/smoke(M)
		sleep(90)
		for(var/obj/GeninI/M in world)
			M.overlays=0
			new/obj/smoke(M)
			M.overlays+=/obj/dummy
		sleep(90)
		for(var/mob/player/M in world)if(M.ingenin>=4)if(M.name=="Dummy")
			M.ingenin++
			M<<"<b>You gained 1 point."
		for(var/obj/GeninI/M in world)
			M.overlays=0
			new/obj/smoke(M)
		sleep(70)
		for(var/mob/player/M in world)if(M.ingenin<8&&M.ingenin>3)
			M<<"<b>You have failed the Genin Exam."
			M.exp(500)
			M.ingenin=0
			M.summonspawn()
		for(var/mob/player/M in world)if(M.ingenin>=8)
			M<<"<b><font color=yellow><font size=3>Congratulations! You have passed the Genin Exam! Your rank is now Genin!"
			for(var/mob/F in world)if(F.village==M.village)F<<"<b><font color=yellow>[M], has passed the Genin Exam!"
			M.ingenin=0
			M.rank="Genin"
			M.tmprank="Genin"
			if(M.rankup<1)
				M.rankup=1
				M.medal(1,13)
			spawn()
				var/beforenone=world.GetMedal("Genin",M)
				if(!beforenone)
					spawn()SetMedal("Genin",M)
					world<<"<b><font color=yellow>Medal Info: [M]([M.key]) has earned the Genin medal!"
			M.overlay()
			M<<"<b>You have received a Shinobi Headband!"
			new/obj/items/equippable/Shinobi_Headband(M)
			M.summonspawn()
			M.exp(500)
		geninexam=0
		genintime=1800
		geninexam()
	chunincountdown()
		set background=1
		while(chunintime>0)
			sleep(10)
			if(chunintime==600)
				for(var/mob/player/G in world)if(G.rank=="Genin")G<<"<b><font color=red><u>Exam Info: The Chunin Exam is starting in ten minutes! Talk to your village chunin examiner to participate!"
				chuninexam=1
			if(chunintime==300)
				for(var/mob/player/G in world)if(G.rank=="Genin")G<<"<b><font color=red><u>Exam Info: The Chunin Exam is starting in five minutes! Talk to your village chunin examiner to participate!"
			if(chunintime==180)
				for(var/mob/player/G in world)if(G.rank=="Genin")G<<"<b><font color=red><u>Exam Info: The Chunin Exam is starting in three minutes!"
			if(chunintime==120)
				for(var/mob/player/G in world)if(G.rank=="Genin")G<<"<b><font color=red><u>Exam Info: The Chunin Exam is starting in two minutes!"
			if(chunintime==60)
				for(var/mob/player/G in world)if(G.rank=="Genin")G<<"<b><font color=red><u>Exam Info: The Chunin Exam is starting in one minute!"
			if(chunintime==10)
				for(var/mob/player/G in world)if(G.rank=="Genin")G<<"<b><font color=red><u>Exam Info: The Chunin Exam is starting in 10 seconds!"
			chunintime--
		chuninexam()
	chuninexam()
		set background=1
		for(var/mob/player/G in world)if(G.rank=="Genin")G<<"<b><font color=red><u>Exam Info: The Chunin Exam has started! The option to enter the exam is now disabled!"
		chuninexam=2
		for(var/mob/player/M in world)if(M.inchunin==1)if(M.rank=="Genin")M<<"<b><font size=3>You have three minutes to answer all the questions. If you get at least 7 out of 10 questions right you will pass this part of the exam. You may begin."
		sleep(1800)
		chuninexam=3
		for(var/mob/player/M in world)if(M.inchunin==3)M<<"<b><font size=3>You have passed the written test of the exam. In 30 seconds you will enter the forest of death. You will be handed either a heaven scroll or a earth scroll. You must defeat and collect both the scrolls and head to a building in the center. There are two rules. Don't go in the building unless you have both the scrolls and do not open the scrolls."
		sleep(300)
		var/R=0
		var/Total=0
		for(var/mob/player/M in world)if(M.inchunin==3)Total++
		if(Total==1)
			for(var/mob/player/M in world)if(M.inchunin==3)
				M<<"Since you are the only one that passed the written exam, you are automatically Chunin."
				world<<"<b><font color=yellow>[M], from the [M.village] has passed the Chunin Exam!"
				M.rank="Chunin"
				M.tmprank="Chunin"
				if(M.rankup<2)
					M.rankup=2
					M.medal(1,18)
				M.repgain(4,src,"Passed the chunin exam.")
				M.inchunin=0
				M.summonspawn()
		for(var/obj/usable/Earth_Scroll/M2 in world)del M2
		for(var/obj/usable/Heaven_Scroll/M2 in world)del M2
		for(var/mob/player/M in world)if(M.inchunin==3)
			if(R==0)
				R=1
				new/obj/usable/Heaven_Scroll(M)
				M.soundeff('scroll.wav',100,1)
				M<<"<b><font size=3>You have been handed a Heaven Scroll. You have another 30 seconds to get ready."
			else
				R=0
				new/obj/usable/Earth_Scroll(M)
				M.soundeff('scroll.wav',100,1)
				M<<"<b><font size=3>You have been handed a Earth Scroll. You have another 30 seconds to get ready."
			M.inchunin=4
			M.pktoggle=1
			M.affcheck()
			var/list/K=list()
			for(var/obj/Spawn_Point/newspawn2/A in world)K+=A
			var/S=pick(K)
			M.loc=S:loc
			M<<"<b><center>Participants"
			for(var/mob/player/M2 in world)if(M2.inchunin)M<<"<center>[M2]"
			spawn(420)if(M)
				M<<"<b>The final part of the exam now begins! The time limit in 10 minutes!"
				var/list/K2=list()
				for(var/obj/Spawn_Point/newspawn3/A in world)K2+=A
				var/S2=pick(K2)
				M.loc=S2:loc
		sleep(6000)
		chuninexam=0
		for(var/mob/player/M in world)if(M.inchunin==4)
			M<<"<b>Time's up. You have failed the Chunin Exam."
			M.inchunin=0
			M.pktoggle=0
			M.affcheck()
			for(var/obj/usable/Earth_Scroll/M2 in world)del M2
			for(var/obj/usable/Heaven_Scroll/M2 in world)del M2
			M.summonspawn()
		chunintime=5000
		chunincountdown()
mob/proc/affcheck()
	switch(village)
		if("Leaf")
			aff=1
		if("Sand")
			aff=2
		if("Sound")
			aff=3
		if("Akatsuki")
			aff=4
		if("None")
			aff=rand(5,100000)
	if(pktoggle)aff=rand(5,100000)
mob/proc/checkjounin()
	if(village!="None"&&amissionreq<=0&&rank=="Chunin")
		src<<"<b><font color=yellow><font size=3><center>You have been promoted to Jounin!"
		for(var/mob/player/F in world)if(F.village==village)F<<"<b><font color=yellow>[src] has been promoted to Jounin!"
		rank="Jounin"
		tmprank="Jounin"
		if(rankup<3)
			rankup=3
			medal(2,5)
		repgain(5,"Became a Jounin.")
		spawn()
			var/beforenone=world.GetMedal("Jounin",src)
			if(!beforenone)
				spawn()world.SetMedal("Jounin",src)
				world<<"<b><font color=yellow>Medal Info: [src]([key]) has earned the Jounin medal!"
turf
	geninpaper
		name="Genin Exam"
		icon='Props.dmi'
		icon_state="paper"
		density=1
		verb
			Take_Exam()
				set src in oview(1)
				if(geninexam==2)
					if(usr.ingenin==1)
						usr.ingenin=2
						var/score=0
						var/Q1=input("Ok, First question. What is your Key?")
						if(Q1==usr.key)score++
						switch(input("Second question. How do you set a jutsu to your hotslot?") in list("You drag the jutsu onto the slot.","You click the slot and set it.","Click the jutsu and it will give you options."))if("You drag the jutsu onto the slot.")score++
						switch(input("What is the button for punch?") in list("~","Esc","F","G"))if("F")score++
						switch(input("What does strength do?") in list("Attack damage only","Attack damage and durability","Durability only","Lifting power"))if("Attack damage and durability")score++
						switch(input("What does more damage? The kunai or the shuriken?") in list("Shuriken.","Kunai.","Depends on the situation.","They're both the same."))if("Kunai.")score++
						switch(input("How do you level up?") in list("Kill 10 people.","Regenerating health and chakra.","Gain stats.","Gaining experience"))if("Gain stats.")score++
						switch(input("If you ran out of chakra while on water, what will happen?") in list("You drown.","You swim.","You teleport to land."))if("You swim.")score++
						if(geninexam==3)goto fail
						switch(input("If you punch a tree what will happen?") in list("You lose some energy.","You gain strength experience.","All of the Above.","Nothing."))if("All of the Above.")score++
						if(geninexam==3)goto fail
						switch(input("What covers the most distance?") in list("Clone jutsu.","Backdash and body flicker at the same time.","Body flicker then clone jutsu.","Substitution then backdash"))if("Substitution then backdash")score++
						if(geninexam==3)goto fail
						switch(input("What stat gives you the most chakra pool?") in list("Handseals.","Intelligence","Ninjutsu.","Stamina."))if("Intelligence")score++
						if(geninexam==3)goto fail
						goto intime
						fail
						usr<<"<b>Sorry, but you are too late to pass this part of the exam."
						usr<<"<b>You have failed the Genin Exam."
						usr.summonspawn()
						usr.ingenin=0
						return
						intime
						usr<<"<b>Your score is [score]/10."
						if(score>=7)
							usr.ingenin=3
							usr<<"<b>Congratulations, you have passed the written exam. Please wait until further instructions."
							usr.exp(50)
						else
							usr<<"<b>You have failed the Genin Exam."
							usr.summonspawn()
							usr.ingenin=0
							usr.exp(50)
	chuninpaper
		name="Chunin Exam"
		icon='Props.dmi'
		icon_state="paper"
		layer=4
		density=1
		verb
			Take_Exam()
				set src in oview(1)
				if(chuninexam==2)
					if(usr.inchunin==1)
						usr.inchunin=2
						var/score=0
						var/Q1=input("First question. What is your chakra control?") as num
						if(Q1==usr.con)score++
						switch(input("What does karma do?") in list("Affects the amount of ryo you get from missions","Affects hospitalization time","A and B","Affects your chance to become Kage"))if("Affects hospitalization time")score++
						switch(input("How do you get Jounin?") in list("Kage can promote Chunins to Jounin","Get recruited as a Missing-Nin","A and B","Do 3 A rank missions"))if("Do 3 A rank missions")score++
						switch(input("What in the forest of death can kill you?") in list("Landmines","Wild Animals","Enemy Shinobi","The scrolls","All of the above","A and C"))if("A and C")score++
						switch(input("What does the Sand Gourd do?") in list("Enables sand abilities.","Change melee attack.","Boosts power.","All of the above."))if("Change melee attack.")score++
						switch(input("How much base chakra do you get per level?") in list("2","3","5","15","30"))if("3")score++
						switch(input("What is your level cap after one rebirth?") in list("65","70","75","80"))if("80")score++
						switch(input("How often do you get a skill point?") in list("per 2 levels","per 3 levels","per 4 levels","20% chance per level","40% chance per level"))if("per 3 levels")score++
						switch(input("What question is this?") in list("6","7","8","9","10"))if("9")score++
						switch(input("Which one of these abilities can you learn with Speed?") in list("Substitution","Hidden Lotus","Flash Step","Double Flicker","Backstep"))if("Substitution")score++
						if(chuninexam==3)
							usr<<"<b>Sorry, but you are too late to pass this part of the exam."
							usr<<"<b>You have failed the Chunin Exam."
							usr.summonspawn()
							usr.inchunin=0
							return
						usr<<"<b>Your score is [score]/10."
						if(score>=7)
							usr.inchunin=3
							usr<<"<b>Congratulations, you have passed the written exam. Please wait until further instructions."
						else
							usr<<"<b>You have failed the Chunin Exam."
							usr.summonspawn()
							usr.inchunin=0
obj/projectiletrainingacad
	icon='training.dmi'
	icon_state="aim"
	density=1
	rundelay=2
	New()walk(src,WEST)
	Bump(A)
		..()
		if(istype(A,/obj/proj/eKunai))del A
		else
			walk(src,0)
			if(dir==WEST)walk(src,EAST)
			else walk(src,WEST)
mob/var/tmp/geninkunaihit=0
turf/Line/icon='training.dmi'
turf/mobblockline
	Entered()
		if(ismob(usr))usr.y--
		..()
turf/LineTraining
	name=""
	icon='training.dmi'
	icon_state="line"
obj/projectiletraining
	icon='training.dmi'
	icon_state="aim"
obj/GeninI
	icon='baseblacker.dmi'
	layer=55
	New()
		..()
		icon=null