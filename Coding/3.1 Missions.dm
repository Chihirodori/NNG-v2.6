mob/var
	weedpick=0
	tmp/babysat=0
	babysitted=0

mob/proc/babysit()
	babysat=0
	src<<"<b>Stay in this room with the kid for one minutes without getting knocked outside!"
	loop
		if(babysat<=60)
			spawn(14)
				babysat++
				if(sz!=z)goto end
				goto loop
		else
			loc=savedloc
			src<<"<b>You have received a Babysitting Mission Proof! Go back to kage house to receive your reward."
			new/obj/items/Babysitting_Mission_Proof(src)
			babysitted=1
			return
	return
	end
	loc=savedloc
	src<<"<b>You failed! Go back in to try again!"
obj
	beenest
		icon='beehive.dmi'
		layer=50
		New()
			loop
				icon_state=""
				spawn(rand(100,300))
					icon_state="idle"
					spawn(rand(20,50))goto loop
	herbspawner
		icon='tallprop.dmi'
		icon_state="herb"
		pixel_y=-32
		invisibility=100
		New()
			loop
				sleep(rand(1200,6000))
				for(var/obj/herb/M in loc)del M
				new/obj/herb(loc)
				goto loop
	herb
		icon='tallprop.dmi'
		icon_state="herb"
		pixel_y=-32
		layer=30
		var/weeded=0
		mouse_opacity=2
		Del()
			loc=null
			spawn(140)..()
		Click()
			for(src in oview(usr,1))
				if(!usr.freeze&&!weeded)
					if(usr.mission=="Herb Picking (C Rank)")
						usr.freeze=1
						weeded=1
						usr.exp(20)
						usr<<"<b>You are now picking the herb."
						spawn(90-usr.con)
							usr.freeze=0
							usr.weedpick++
							if(usr.weedpick<5)usr<<"<b>You carefully plucked out the right herbs. [5-usr.weedpick] left."
							else
								usr<<"You have picked out 5 herbs."
								usr<<"You have completed the mission. Go to your Kage house to get your reward."
							del src
		verb
			Pick()
				set src in oview(1)
				if(!usr.freeze&&!weeded)
					if(usr.mission=="Herb Picking (C Rank)"&&usr.weedpick<5)
						usr.freeze=1
						weeded=1
						usr.exp(20)
						usr<<"<b>You are now picking the herb."
						spawn(50-usr.con)
							usr.freeze=0
							usr.weedpick++
							if(usr.weedpick<5)usr<<"<b>You carefully plucked out the right herbs. [5-usr.weedpick] left."
							else
								usr<<"You have picked out 5 herbs."
								usr<<"You have completed the mission. Go to your Kage house to get your reward."
							del src
	weedspawner
		icon='tallprop.dmi'
		icon_state="weed"
		pixel_y=-32
		invisibility=100
		New()
			loop
				sleep(rand(600,6000))
				for(var/obj/weed/M in loc)
					del M
				new/obj/weed(loc)
				goto loop
	weed
		icon='tallprop.dmi'
		icon_state="weed"
		pixel_y=-32
		mouse_opacity=2
		layer=10
		var/weeded=0
		proc
			picka()
				if(!usr.freeze&&!weeded&&usr.weedpick<10)
					if(usr.mission=="Weed Picking (D Rank)")
						usr.freeze=1
						weeded=1
						usr.exp(5)
						usr<<"<b>You are now picking the weed."
						spawn(40-usr.Str*3)
							if(usr)
								usr.freeze=0
								usr.weedpick++
								if(usr.weedpick<10)usr<<"<b>[10-usr.weedpick] left."
								else
									usr<<"You have picked out 10 weeds."
									usr<<"You have completed the mission. Go to your Kage house to get your reward."
								del src
		Click()
			for(src in oview(usr,1))
				picka()
		verb
			Pick()
				set src in oview(1)
				picka()
		Del()
			loc=null
			spawn(140)..()
	graffitispawner
		icon='graffiti.dmi'
		invisibility=100
		icon_state="3"
		layer=50
		New()
			loop
				for(var/obj/graffiti/M in loc)goto skip
				var/T=new/obj/graffiti(loc)
				T:pixel_y=pixel_y
				skip
				spawn(500)goto loop
	graffiti
		icon='graffiti.dmi'
		layer=50
		mouse_opacity=2
		var/graffitied=0
		Del()
			loc=null
			spawn(140)..()
		Click()
			for(src in oview(usr,2))
				if(!usr.freeze&&!graffitied)
					if(usr.mission=="Graffiti Removing (D Rank)")
						usr.freeze=1
						graffitied=1
						usr<<"<b>You are now painting over the graffiti."
						spawn(70)
							if(!usr)
								graffitied=0
								return
							usr.freeze=0
							usr.graffiti++
							if(usr.graffiti<5)usr<<"<b>[5-usr.graffiti] left."
							else
								usr<<"You have painted over 5 graffiti."
								for(var/obj/items/Paint/M in usr)
									new/obj/items/Paint2(usr)
									del M
								usr<<"You have completed the mission. Go to your Kage house to get your reward."
							del src
		New()
			..()
			icon_state="[rand(1,4)]"
		verb
			Paint_Over()
				set src in oview(2)
				if(!usr.freeze&&!graffitied)
					if(usr.mission=="Graffiti Removing (D Rank)")
						usr.freeze=1
						graffitied=1
						usr<<"<b>You are now painting over the graffiti."
						spawn(70)
							if(!usr)
								graffitied=0
								return
							usr.freeze=0
							usr.graffiti++
							if(usr.graffiti<5)usr<<"<b>[5-usr.graffiti] left."
							else
								usr<<"You have painted over 5 graffit."
								for(var/obj/items/Paint/M in usr)
									new/obj/items/Paint2(usr)
									del M
								usr<<"You have completed the mission. Go to your Kage house to get your reward."
							del src

	billboard
		icon='sandbill.dmi'
		name="Mission Billboard"
		var/billvillage="None"
		var/sabotaged=null
		layer=25
		leaf/billvillage="Leaf"
		sand
			billvillage="Sand"
		sound/billvillage="Sound"
		akat/billvillage="Akatsuki"
		Click()
			if(usr.village!=billvillage)
				if(usr.mission=="Sabotaging Mission Board (B Rank)"&&!usr.graffiti)
					for(src in oview(usr,3))
						if(usr.moving||usr.dead||usr.stun||usr.freeze||usr.busy)return
						usr.busy="sabotaging"
						usr.freeze=1
						usr.cloakoff()
						usr<<"<b>You are now sabotaging the mission board! Do not move or get hit for 10 seconds!"
						var/X=usr.loc
						var/Y=usr.hp
						var/g=0
						loop
							sleep(10)
							if(!usr)return
							g++
							if(usr.hp<Y||X!=usr.loc)
								usr<<"<b>You have been interupted!"
								usr.busy=null
								usr.hengeback()
								usr.cloakoff()
								usr.freeze=0
								return
							usr<<"<b>[g*10]/100"
							if(g<10)goto loop
						usr<<"<b>You have successfully sabotaged the billboard!"
						usr.freeze=0
						usr.graffiti=1
						sabotaged=usr
						usr.busy=null
						break
			else
				if(usr.mclicked)return
				usr.mclicked=1
				if(usr.village=="None")
					usr.mclicked=0
					return
				if(usr.mission)
					alert(usr,"You already have a mission active. If you can't complete it go to your village kage assistant to cancel them.")
					usr.mclicked=0
					return
				if(usr.missioned)
					alert(usr,"There are no missions available to you right now.")
					usr.mclicked=0
					return
				for(var/obj/hudbuttons/Mission/G in usr.client.screen)del G
				usr.missioned=-1
				var/ch=1
				if(usr.rank=="Genin")
					var/sprob=20+level*1.5
					if(sprob>70)sprob=70
					if(prob(30+level))ch=2
				if(usr.rank=="Chunin")
					ch=2
					var/sprob=30+level/2
					if(sprob>70)sprob=70
					if(prob(30+level))ch=2
					if(prob(5))ch=3
				if(usr.rank=="Jounin"||usr.rank=="ANBU"||usr.rank=="ANBU Leader"||usr.rank=="Hokage"||usr.rank=="Kazekage"||usr.rank=="Sound Leader")
					ch=3
					if(prob(15))ch=4
				if(usr.rank=="Akatsuki Leader"||usr.rank=="Akatsuki Member")
					ch=5
				if(sabotaged)
					usr.sabotaged=sabotaged
					sabotaged=null
				usr.mclicked=0
				switch(ch)
					if(1)
						var/S=rand(1,4)
						switch(S)
							if(1)
								usr.missionreceive("Weed Picking","D","Weeds are a problem for farmers everywhere. Here in [usr.village] village however, they're getting out of control. Weeds is not only annoying to look at, but also slows movement down. Your job is to go around the village and pick and discard 10 patches of weed.")
								usr.weedpick=0
							if(2)
								usr.missionreceive("Finding Lost Cat","D","One of the resident's cat is missing. It was last seen sitting around somewhere in the village. Find it and bring it back to it's owner.")
								usr.weedpick=0
							if(3)
								usr.missionreceive("Bee Nest Burning","D","There are bee nests around the village that gives the villagers a hard time. You will receive specialized fire bombs to take one of the nests out. The bees are not deadly but they are incredibly painful.")
								new/obj/usable/Bee_Killing_Blaze_Bomb(usr)
								alert(usr,"Use the blaze bomb on the nest when it's not shaking and is idle or you'll provoke the bees.")
							if(4)
								usr.missionreceive("Graffiti Removing","D","Those damned kids are ruining historic and important buildings with graffiti. Your job is to paint over five of them and then come back.")
								new/obj/items/Paint(usr)
								usr.graffiti=0
							if(5)
								usr.missionreceive("Butterfly Catching","D","The butterflies in this region is quite rare and can be sold to other countries for a fair amount. Catch 3 butterflies with this butterfly net. Press F to catch butterflies while it is equipped.")
								usr.weedpick=0
							if(6)
								usr.missionreceive("Babysitting","D","There is a kid that needs babysitting. You need to stay with the kid in the same house for a while before his parents come back from a raid. Oh, and don't attack the kid in anger.")
								usr.babysitted=0
					if(2)
						var/S=rand(1,5)
						switch(S)
							if(1)
								usr.missionreceive("Herb Picking","C","There are herbs that grow in the deeper parts of the forests. They have excellent healing properties and it's needed to make things such as blood pills. Find and pick 5 of these herbs.")
								usr.weedpick=0
							if(2)
								usr.missionreceive("Waterfall Water","C","Go to the waterfall in waterfall village and fill the container up without getting interrupted. Once you've got it make your way back to the village. The volume of the tank affects your mission reward. Press the container to track down waterfall village and to fill the water tank up.")
								new/obj/items/Empty_Water_Container(usr)
							if(3)
								usr.missionreceive("Hunting","C","Venison make for excellent food and deer fur is quite valuable. Hunt 3 deers for their meat and pelt and then come back.")
							if(4)
								usr.missionreceive("Capture A Boar","C","A merchant has asked for a boar to be captured. For you to get paid, find and defeat a boar to capture it. Do not get knocked out as the boar will escape. Wild boars are extremely aggresive.")
							if(5)
								usr.missionreceive("Defeat Bandits","C","Bandits are hiding out the village. Wear this Merchants Hat and go somewhere isolated and defeat the two bandits.")
								for(var/obj/items/equippable/Merchants_Hat/G in usr)
									usr.mclicked=0
									return
								new/obj/items/equippable/Merchants_Hat(usr)
								usr<<"<b>You have received a merchants hat."
					if(3)
						var/S=rand(1,5)
						usr.weedpick=0
						switch(S)
							if(1)
								usr.missionreceive("Stealing Enemy Vests","B","You must disguise yourself as a enemy villager and use this fake cheque to buy a shipment of their vests in their village.")
								new/obj/items/Fake_Cheque(usr)
							if(2)
								usr.missionreceive("Sabotaging Mission Board","B","You must go deep within a enemy village and click on their mission board to sabotage it. You will earn the ryo reward from the next person that takes a mission from that board.")
							if(3)
								if(prob(50))
									if(usr.village=="Leaf")
										usr.missionreceive("Sound Village Assassination","B","Take down three non-academy students in Sound village.")
									if(usr.village=="Sand")
										usr.missionreceive("Sound Village Assassination","B","Take down three non-academy students in Sound village.")
									if(usr.village=="Sound")
										usr.missionreceive("Sand Village Assassination","B","Take down three non-academy students in Sand village.")
								else
									if(usr.village=="Leaf")
										usr.missionreceive("Sand Village Assassination","B","Take down three non-academy students in Sand village.")
									if(usr.village=="Sand")
										usr.missionreceive("Leaf Village Assassination","B","Take down three non-academy students in Leaf village.")
									if(usr.village=="Sound")
										usr.missionreceive("Leaf Village Assassination","B","Take down three non-academy students in Leaf village.")
							if(4)
								usr.missionreceive("Missing-Nin Hideout","B","Our intels just got the location of a well known group of missing-nins. The leader and the higher ups are currently away so all that's left are the lower ranked missing-nins. I want you to follow the coordinates and then defeat all the missing-nins that are inside.")
								new/obj/items/Coordinates(usr)
								usr.weedpick=0
							if(5)
								usr.missionreceive("Capture Banner","B","Capture a banners for our village.")
								usr.weedpick=0
					if(4)
						usr.missionreceive("Defeat Sasuke Uchiha","A","Defeat Sasuke Uchiha at the Valley of the End.")
						usr.weedpick=0
					if(5)
						var/S=rand(1,5)
						usr.weedpick=0
						switch(S)
							if(1)
								usr.missionreceive("Assassinate the Hokage","S","Infultrate the Leaf village and kill the Hokage.")
							if(2)
								usr.missionreceive("Assassinate the Kazekage","S","Infultrate the Sand village and kill the Kazekage.")
							if(3)
								usr.missionreceive("Assassinate the Sound Leader","S","Infultrate the Sound village and kill the Sound Leader.")
							if(4)
								usr.missionreceive("Sabotaging Mission Board","B","You must go deep within a enemy village and click on their mission board to sabotage it. You will earn the ryo reward from the next person that takes a mission from that board.")
							if(5)
								var/T=rand(1,3)
								if(T==1)
									usr.missionreceive("Sand Village Assassination","B","Take down three non-academy students in Sand village.")
								if(T==2)
									usr.missionreceive("Leaf Village Assassination","B","Take down three non-academy students in Leaf village.")
								if(T==3)
									usr.missionreceive("Sound Village Assassination","B","Take down three non-academy students in Sound village.")
mob/var
	tmp/mclicked=0
	mzing=0
	sabotaged=null
mob/MissonMob
	name="Mission NPC(Temp)"
	icon='NPCs.dmi'
	layer=15
	npc=2
	mouse_opacity=2
	Shizune
		name="Shizune(Mission NPC)"
		icon_state="Shizune"
		village="Leaf"
		rank="Jounin"
		mouse_over_pointer='cursorleaf.dmi'
	Temari
		name="Temari(Mission NPC)"
		icon_state="Temari"
		village="Sand"
		rank="Jounin"
	Kabuto
		name="Kabuto(Mission NPC)"
		icon_state="Kabuto"
		village="Sound"
		rank="Genin"
	Zetsu
		name="(NPC)Zetsu(Akatsuki)"
		village="Akatsuki"
		clan="Flytrap"
		icon='Akatsuki.dmi'
		icon_state="Zetsu"
		rank="S-Ranked Criminal"
		level=79
	Click()
		if(village!=usr.village||usr.cloaking)return
		if(usr.mzing)return
		usr.mzing=1
		for(src in oview(usr,8))
			switch(input(usr,"[src]: Yes? What do you need?","[src]") in list ("Complete A Mission","Cancel A Mission","Nevermind"))
				if("Complete A Mission")
					if(!usr.mission)
						usr.mzing=0
						return
					usr.mzing=0
					if(usr.weedpick>=10&&usr.mission=="Weed Picking (D Rank)")
						usr.missioncomplete("Weed Picking","D",1)
						usr.exp(400)
						usr.weedpick=0
					if(usr.mission=="Finding Lost Cat (D Rank)"&&usr.weedpick==1)
						if(prob(95))
							usr.missioncomplete("Finding Lost Cat","D",1)
							usr.exp(350)
						else
							usr<<"<b><font size=2><font color=yellow>The mission was requested by a rich feudal lord. You have been given a huge bonus."
							usr.missioncomplete("Finding Lost Cat","D",5)
							usr.exp(1200)
						return
					for(var/obj/items/Babysitting_Mission_Proof/M in usr)
						del M
						usr.missioncomplete("Babysitting","D",1)
						usr.exp(400)
					for(var/obj/items/Paint2/M in usr)
						del M
						usr.missioncomplete("Graffiti Removing","D",1)
						usr.graffiti=0
						usr.exp(400)
					for(var/obj/items/Burned_Bee_Nest/M in usr)
						del M
						usr.missioncomplete("Bee Nest Burning","D",1)
						usr.exp(400)
					for(var/obj/items/Captured_Boar/M in usr)
						del M
						usr.missioncomplete("Capture A Boar","C",3)
						usr.exp(1000)
					for(var/obj/items/Full_Water_Container/M in usr)
						del M
						usr.missioncomplete("Waterfall Water","C",3)
						usr.exp(1000)
					for(var/obj/items/Half_Full_Water_Container/M in usr)
						del M
						usr.missioncomplete("Waterfall Water","C",3)
						usr.exp(600)
					if(usr.weedpick>=3&&usr.mission=="Hunting (C Rank)")
						for(var/obj/items/Deer_Pelt/M in usr)del M
						usr.missioncomplete("Hunting","C",3)
						usr.weedpick=0
						usr.exp(1000)
					if(usr.weedpick>=3&&usr.mission=="Defeat Bandits (C Rank)")
						usr.missioncomplete("Defeat Bandits","C",3)
						usr.weedpick=0
						usr.exp(1000)
					if(usr.weedpick>=3&&usr.mission=="Sound Village Assassination (B Rank)")
						usr.missioncomplete("Sound Village Assassination","B",6)
						usr.weedpick=0
						usr.exp(2000)
					if(usr.weedpick>=3&&usr.mission=="Sand Village Assassination (B Rank)")
						usr.missioncomplete("Sand Village Assassination","B",6)
						usr.weedpick=0
						usr.exp(2000)
					if(usr.weedpick>=1&&usr.mission=="Defeat Sasuke Uchiha (A Rank)")
						usr.missioncomplete("Defeat Sasuke Uchiha","A",10)
						usr.weedpick=0
						usr.exp(4000)
					if(usr.weedpick>=1&&usr.mission=="Assassinate the Hokage (S Rank)")
						usr.missioncomplete("Assassinate the Hokage","S",12)
						usr.weedpick=0
						usr.exp(4500)
					if(usr.weedpick>=1&&usr.mission=="Assassinate the Kazekage (S Rank)")
						usr.missioncomplete("Assassinate the Kazekage","S",12)
						usr.weedpick=0
						usr.exp(4500)
					if(usr.weedpick>=1&&usr.mission=="Assassinate the Sound Leader (S Rank)")
						usr.missioncomplete("Assassinate the Sound Leader","S",12)
						usr.weedpick=0
						usr.exp(4500)
					if(usr.weedpick>=3&&usr.mission=="Leaf Village Assassination (B Rank)")
						usr.missioncomplete("Leaf Village Assassination","B",6)
						usr.weedpick=0
						usr.exp(2000)
					if(usr.weedpick>=15&&usr.mission=="Missing-Nin Hideout (B Rank)")
						usr.missioncomplete("Missing-Nin Hideout","B",6)
						usr.weedpick=0
						usr.exp(2000)
					if(usr.graffiti==1&&usr.mission=="Sabotaging Mission Board (B Rank)")
						usr.missioncomplete("Sabotaging Mission Board","B",6)
						usr.graffiti=0
						usr.exp(2000)
					if(usr.weedpick>=1&&usr.mission=="Capture Banner (B Rank)")
						usr.missioncomplete("Capture Banner","B",6)
						usr.graffiti=0
						usr.exp(2000)
					for(var/obj/items/Vest_Shipment/M in usr)
						usr.missioncomplete("Stealing Enemy Vests","B",6)
						del M
						usr.exp(2000)
					if(usr.weedpick>=5&&usr.mission=="Herb Picking (C Rank)")
						usr.missioncomplete("Herb Picking","C",3)
						usr.weedpick=0
						usr.exp(1000)
					usr.graffiti=0
				if("Cancel A Mission")
					switch(input(usr,"[src]: Are you sure you would like to cancel your current mission? ([usr.mission])") in list ("Yes","No"))
						if("Yes")
							if(!usr.mission)
								alert(usr,"You don't have a active mission.")
								usr.mzing=0
								return
							usr<<"<b>You have canceled [usr.mission]."
							usr.mission=null
							usr.missiond=null
							usr.missioned=rand(240,300)
							usr.weedpick=0
							usr.graffiti=0
							for(var/obj/items/Babysitting_Mission_Proof/M in usr)del M
							for(var/obj/items/Paint2/M in usr)del M
							for(var/obj/items/Burned_Bee_Nest/M in usr)del M
							for(var/obj/items/Captured_Boar/M in usr)del M
							for(var/obj/items/Full_Water_Container/M in usr)del M
							for(var/obj/items/Paint/M in usr)del M
							for(var/obj/usable/Bee_Killing_Blaze_Bomb/M in usr)del M
							for(var/obj/items/Half_Full_Water_Container/M in usr)del M
							for(var/obj/items/Empty_Water_Container/M in usr)del M
							for(var/obj/items/Coordinates/M in usr)del M
							for(var/obj/items/Fake_Cheque/M in usr)del M
							for(var/obj/items/Vest_Shipment/M in usr)del M
							for(var/obj/items/Deer_Pelt/M in usr)del M
							usr.mzing=0
			usr.mzing=0
mob/EliteMissonMob
	name="Elite Mission NPC(Temp)"
	icon='NPCs.dmi'
	layer=15
	npc=2
	mouse_opacity=2
	Kakashi
		name="Kakashi(Elite NPC)"
		icon_state="Kakashi"
		village="Leaf"
		rank="Jounin"
		mouse_over_pointer='cursorleaf.dmi'
		level=125
	Gaara
		name="Gaara(Elite NPC)"
		icon_state="Gaara"
		village="Sand"
		rank="Jounin"
		level=112
	Orochimaru
		name="Orochimaru(Elite NPC)"
		icon_state="Orochimaru"
		village="Sound"
		rank="Sannin"
		level=142
	Click()
		for(src in oview(usr,8))
			if(usr.village!=village)
				alert(usr,"[src]: You got some nerve...")
				return
			if(usr.secretlevel>secrettimer+30)usr.secretlevel=secrettimer
			if(usr.secretlevel<secrettimer)
				usr.secretlevel=secrettimer
			var/cost=findsecretcost(usr.secretlevel-secrettimer)
			switch(input("[src]: Would you like to buy a scroll of secrets for [cost] Senryo?")in list("Yes","No"))
				if("Yes")
					if(usr.secretlevel<secrettimer)
						usr.secretlevel=secrettimer
					cost=findsecretcost(usr.secretlevel-secrettimer)
					if(usr.senryo<cost)
						alert("You don't have enough Senryo.")
						return
					usr.secretlevel+=4
					if(usr.secretlevel>secrettimer+20)usr.secretlevel=secrettimer+20
					usr.senryo-=cost
					usr.ryorefresh()
					usr<<"<font color=yellow><b>You spent [cost] Senryo on a scroll of secrets.([usr.senryo])"
					new/obj/usable/Scroll_of_Secrets(usr)
					usr<<"<b>You received a Scroll of Secrets."

proc/findsecretcost(var/xx)
	if(xx<0)xx=0
	switch(xx)
		if(0)return 10
		if(1 to 4)return 20
		if(5 to 9)return 35
		else return 50

mob/proc
	missioncheck()
		if(mission)
			cantmission=1
			return
		cantmission=0
	missionreceive(F,R,D)
		usr<<"<center><b><u><font color=yellow>Mission Received"
		usr<<"<center><b><font color=yellow>[F] (Rank [R])"
		usr<<"<center><font color=yellow>Objective: [D]"
		mission="[F] ([R] Rank)"
		missiond="[D]"
	missioncomplete(F,R,E)
		if(village=="Leaf"&&leafrec||village=="Sand"&&sandrec||village=="Sound"&&soundrec)E*=1.2
		mission=null
		missiond=null
		src<<"<b><font size=2><center><u>Mission Complete: [F] ([R] Rank)"
		if(village=="Akatsuki"&&akatpriority=="Wealth"||village=="Leaf"&&leafpriority=="Wealth"||village=="Sand"&&sandpriority=="Wealth"||village=="Sound"&&soundpriority=="Wealth")E=round(E*1.3)
		if(sabotaged)
			for(var/mob/player/M in world)if(sabotaged==M)
				M<<"<b><u><center><font color=red>You have received [max(round(E * (M.ryomulti/100)), E)] senryo from [src]'s mission from your sabotage!"
				M.senryo += round(E * (M.ryomulti/100))
				M.ryorefresh()
				src<<"<b><center><u><font color=red>[M] took your [max(round(E * (M.ryomulti/100)), E)] senryo award due to his sabotage of the mission billboard!"
				goto gone
		if(ryomissiongain)
			var/old=E
			E*=2
			src<<"<center><font color=yellow>[old] ==> [E] (100% Bonus)"
		if(E)
			src<<"<center><font color=yellow>You have earned [max(round(E * (src.ryomulti/100)), E)] senryo"
		senryo += max(round(E * (src.ryomulti/100)), E)
		gone
		sabotaged = null
		ryorefresh()
		if(rank!="Hokage"&&rank!="Kazekage"&&!rank=="Sound Leader")
			for(var/mob/player/M in world)
				if(village=="Leaf"&&M.rank=="Hokage")
					var/g=round(E*0.05)
					M<<"<b>You have received [g] senryo for [src]'s mission!"
					M.senryo+=g
					M.ryorefresh()
				if(village=="Sand"&&M.rank=="Kazekage")
					var/g=round(E*0.05)
					M<<"<b>You have received [g] senryo for [src]'s mission!"
					M.senryo+=g
					M.ryorefresh()
				if(village=="Sound"&&M.rank=="Sound Leader")
					var/g=round(E*0.05)
					M<<"<b>You have received [g] senryo for [src]'s mission!"
					M.senryo+=g
					M.ryorefresh()
		if(R=="D")
			var/I=0.25
			if(village=="[grassTV]")I+=0.25
			if(village=="[snowTV]")I+=0.25
			if(village=="[rainTV]")I+=0.25
			mrankd++
			if((mrankd+mrankc+mrankb+mranka+mranks)==1)medal(1,19)
			if((mrankd+mrankc+mrankb+mranka+mranks)==100)medal(2,17)
			if((mrankd+mrankc+mrankb+mranka+mranks)==1000)medal(3,9)
			repgain(I,"Completed D rank mission.")
		if(R=="C")
			var/I=0.75
			if(village=="[grassTV]")I+=0.25
			if(village=="[snowTV]")I+=0.25
			if(village=="[rainTV]")I+=0.25
			mrankc++
			if((mrankd+mrankc+mrankb+mranka+mranks)==1)medal(1,19)
			if((mrankd+mrankc+mrankb+mranka+mranks)==100)medal(2,17)
			if((mrankd+mrankc+mrankb+mranka+mranks)==1000)medal(3,9)
			repgain(I,"Completed C rank mission.")
		if(R=="B")
			var/I=1.25
			if(village=="[grassTV]")I+=0.25
			if(village=="[snowTV]")I+=0.25
			if(village=="[rainTV]")I+=0.25
			mrankb++
			if((mrankd+mrankc+mrankb+mranka+mranks)==1)medal(1,19)
			if((mrankd+mrankc+mrankb+mranka+mranks)==100)medal(2,17)
			if((mrankd+mrankc+mrankb+mranka+mranks)==1000)medal(3,9)
			repgain(I,"Completed B rank mission.")
		if(R=="A")
			var/I=1.75
			if(village=="[grassTV]")I+=0.25
			if(village=="[snowTV]")I+=0.25
			if(village=="[rainTV]")I+=0.25
			mranka++
			if((mrankd+mrankc+mrankb+mranka+mranks)==1)medal(1,19)
			if((mrankd+mrankc+mrankb+mranka+mranks)==100)medal(2,17)
			if((mrankd+mrankc+mrankb+mranka+mranks)==1000)medal(3,9)
			repgain(I,"Completed A rank mission.")
		if(R=="S")
			var/I=2.25
			if(village=="[grassTV]")I+=0.25
			if(village=="[snowTV]")I+=0.25
			if(village=="[rainTV]")I+=0.25
			mranks++
			if((mrankd+mrankc+mrankb+mranka+mranks)==1)medal(1,19)
			if((mrankd+mrankc+mrankb+mranka+mranks)==100)medal(2,17)
			if((mrankd+mrankc+mrankb+mranka+mranks)==1000)medal(3,9)
			repgain(I,"Completed S rank mission.")
		if(!intut)
			missioned=rand(240,300)

	missionfail(F,R)
		if("[F] ([R] Rank)"==mission)
			missiond=null
			mission=null
			missioned=rand(240,300)
		sabotaged=null
		src<<"<b><font size=2><center><font color=red>Mission Fail: [F] ([R] Rank)"
/*
	karma(amount)
		if(amount < 0)
			karma *= (src.hp / src.maxhp)
			karmaloss = 0
		if(karma<0)
			if(karma <= -300)
				karma = -300
				return
		if(amount < -100)
			amount = -100
		if(amount <= -10)
			src << "<font color = red><center>You have lost [amount] karma."
		if(amount > 0)
			if(karma >= 300)
				karma = 300
				return
			src << "<font color = yellow><center>You have gained [amount] karma."
		karma += amount
*/
	terramajor(G)
		var/Z=0
		for(var/mob/player/M in world)
			if(G=="Leaf"&&M.rank=="Hokage")Z=1
			if(G=="Sand"&&M.rank=="Kazekage")Z=1
			if(G=="Sound"&&M.rank=="Sound Leader")Z=1
		var/R="A"
		if(Z)R="S"
		src<<"<b><font size=2><center>Mission Complete: Capture Bandum([R] Rank)"
		src<<"<center><font color=yellow>You have earned 10 senryo"
		senryo+=10
		ryorefresh()
		if(R=="A")
			mranka++
			if(prob(70))
				repgain(2,"Completed A rank mission.")
			else
				repgain(4,"Completed A rank mission.")
		if(R=="S")
			mranks++
			repgain(5,"Completed S rank mission.")

mob/proc/missingrampage()
	var/list/K=list()
	for(var/obj/Spawn_Point/missingnin/F in world)K+=F
	loop
		spawn(14)
			if(weedpick>=15)
				src<<"<b>You have defeated all the missing-nins."
				src.z=2
				return
			var/G=0
			for(var/mob/NPC/killable/unique/roguedude/M in world)if(M.owner==src&&M.z==5)G++
			if(G<3)
				var/obj/S=pick(K)
				var/mob/NPC/killable/unique/roguedude/A=new(S.loc)
				A.owner=src
				A.Str=round(Str/2.5)
				A.Hsl=round(Hsl/2.5)
				A.Nin=round(Nin/2.5)
				A.Tai=round(Tai/2.5)
				A.Sta=round(Sta/2.5)
				A.Spd=round(Spd/2.5)
				A.Int=round(Int/2.5)
				A.statset()
				A.maxhp-=800
				A.hp-=800
			goto loop


mob/Kid
	icon='Kid.dmi'
	village="None"
	level=3
	npc=2
	rank="Child"
	rundelay=0
	New()
		kidproc()
		..()
	proc
		kidproc()
			loop
				walk(src,pick(SOUTH,NORTH,EAST,WEST))
				spawn(rand(3,12))goto loop
	Bump(mob/A)
		if(ismob(A))
			faceme(A)
			A.stepback(4,2)
		walk(src,0)
		walk(src,pick(SOUTH,NORTH,EAST,WEST))
		..()