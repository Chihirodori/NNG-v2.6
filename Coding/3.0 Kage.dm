obj/Kage_Papers
	name="Kage's Papers"
	icon='Inside Konoha.dmi'
	icon_state="paper"
	verb
		zd()
			set name="Write"
			set src in oview(1)
			if(usr.rank=="Hokage"||usr.rank=="Kazekage"||usr.rank=="Sound Leader")
				if(usr.village=="Leaf"&&goldenage=="leaf"||usr.village=="Sand"&&goldenage=="sand"||usr.village=="Sound"&&goldenage=="sound")
					switch(alert(usr,"What would you like to do?","","Change Village Priority","Arrange Meeting","Cancel"))
						if("Change Village Priority")
							var/S=leafpriority
							if(usr.village=="Sand")S=sandpriority
							if(usr.village=="Sound")S=soundpriority
							if(S=="Currently Changing")return
							switch(input(usr,"Which priority do you want to switch into? It's currently [S].") in list("Aggressiveness","Influence","Appearance","Wealth","Training","Missions","Cancel"))
								if("Aggressiveness")
									switch(alert(usr,"Are you sure you want to change the priority to Aggressiveness? It will take 10 minutes to get in effect.","","Yes","No"))
										if("Yes")
											if(usr.village=="Leaf")leafpriority="Aggressiveness"
											if(usr.village=="Sand")sandpriority="Aggressiveness"
											if(usr.village=="Sound")soundpriority="Aggressiveness"
											for(var/mob/Z in world)if(Z.village==usr.village)Z<<"<b><center><font size=2><font color=silver>The village priority is now Aggressiveness(+15% damage to all attacks)."
								if("Wealth")
									switch(alert(usr,"Are you sure you want to change the priority to Wealth? It will take 10 minutes to get in effect.","","Yes","No"))
										if("Yes")
											if(usr.village=="Leaf")leafpriority="Wealth"
											if(usr.village=="Sand")sandpriority="Wealth"
											if(usr.village=="Sound")soundpriority="Wealth"
											for(var/mob/Z in world)if(Z.village==usr.village)Z<<"<b><center><font size=2><font color=silver>The village priority is now Wealth(+30% ryo gained from everything, bountys give +100% influence)."
								if("Influence")
									switch(alert(usr,"Are you sure you want to change the priority to Influence? It will take 10 minutes to get in effect.","","Yes","No"))
										if("Yes")
											if(usr.village=="Leaf")leafpriority="Influence"
											if(usr.village=="Sand")sandpriority="Influence"
											if(usr.village=="Sound")soundpriority="Influence"
											for(var/mob/Z in world)if(Z.village==usr.village)Z<<"<b><center><font size=2><font color=silver>The village priority is now Influence(+20% influence gain)."
								if("Appearance")
									switch(alert(usr,"Are you sure you want to change the priority to Appearance? It will take 10 minutes to get in effect.","","Yes","No"))
										if("Yes")
											if(usr.village=="Leaf")leafpriority="Appearance"
											if(usr.village=="Sand")sandpriority="Appearance"
											if(usr.village=="Sound")soundpriority="Appearance"
											for(var/mob/Z in world)if(Z.village==usr.village)Z<<"<b><center><font size=2><font color=silver>The village priority is now Appearance(-30% influence loss)."
								if("Training")
									switch(alert(usr,"Are you sure you want to change the priority to Training? It will take 10 minutes to get in effect.","","Yes","No"))
										if("Yes")
											if(usr.village=="Leaf")leafpriority="Training"
											if(usr.village=="Sand")sandpriority="Training"
											if(usr.village=="Sound")soundpriority="Training"
											for(var/mob/Z in world)if(Z.village==usr.village)Z<<"<b><center><font size=2><font color=silver>The village priority is now Training(+20% training speed)."
								if("Missions")
									switch(alert(usr,"Are you sure you want to change the priority to Missions? It will take 10 minutes to get in effect.","","Yes","No"))
										if("Yes")
											if(usr.village=="Leaf")leafpriority="Missions"
											if(usr.village=="Sand")sandpriority="Missions"
											if(usr.village=="Sound")soundpriority="Missions"
											for(var/mob/Z in world)if(Z.village==usr.village)Z<<"<b><center><font size=2><font color=silver>The village priority is now Missions(+1 rank mission rewards)."
				else
					switch(alert(usr,"What would you like to do?","","Change Village Priority","Arrange Meeting","Cancel"))
						if("Change Village Priority")
							var/S=leafpriority
							if(usr.village=="Sand")S=sandpriority
							if(usr.village=="Sound")S=soundpriority
							if(S=="Currently Changing")return
							switch(input(usr,"Which priority do you want to switch into? It's currently [S]. Please do not log off when it's changing.") in list("Aggressiveness","Influence","Appearance","Wealth","Training","Missions","Cancel"))
								if("Aggressiveness")
									switch(alert(usr,"Are you sure you want to change the priority to Aggressiveness? It will take 10 minutes to get in effect.","","Yes","No"))
										if("Yes")
											for(var/mob/Z in world)if(Z.village==usr.village)Z<<"<b><center><font size=2><font color=silver>The [usr.rank], [usr] has changed the village priority to Aggressiveness(+15% damage to all attacks). It will take 10 minutes to get in effect."
											if(usr.village=="Leaf")leafpriority="Currently Changing"
											if(usr.village=="Sand")sandpriority="Currently Changing"
											if(usr.village=="Sound")soundpriority="Currently Changing"
											spawn(6000)
												if(usr.village=="Leaf")leafpriority="Aggressiveness"
												if(usr.village=="Sand")sandpriority="Aggressiveness"
												if(usr.village=="Sound")soundpriority="Aggressiveness"
												for(var/mob/Z in world)if(Z.village==usr.village)Z<<"<b><center><font size=2><font color=silver>The village priority is now Aggressiveness(+15% damage to all attacks)."
								if("Wealth")
									switch(alert(usr,"Are you sure you want to change the priority to Wealth? It will take 10 minutes to get in effect.","","Yes","No"))
										if("Yes")
											for(var/mob/Z in world)if(Z.village==usr.village)Z<<"<b><center><font size=2><font color=silver>The [usr.rank], [usr] has changed the village priority to Wealth(+30% ryo gained from everything, bountys give +100% influence). It will take 10 minutes to get in effect."
											if(usr.village=="Leaf")leafpriority="Currently Changing"
											if(usr.village=="Sand")sandpriority="Currently Changing"
											if(usr.village=="Sound")soundpriority="Currently Changing"
											spawn(6000)
												if(usr.village=="Leaf")leafpriority="Wealth"
												if(usr.village=="Sand")sandpriority="Wealth"
												if(usr.village=="Sound")soundpriority="Wealth"
												for(var/mob/Z in world)if(Z.village==usr.village)Z<<"<b><center><font size=2><font color=silver>The village priority is now Wealth(+30% ryo gained from everything, bountys give +100% influence)."
								if("Influence")
									switch(alert(usr,"Are you sure you want to change the priority to Influence? It will take 10 minutes to get in effect.","","Yes","No"))
										if("Yes")
											for(var/mob/Z in world)if(Z.village==usr.village)Z<<"<b><center><font size=2><font color=silver>The [usr.rank], [usr] has changed the village priority to Influence(+20% influence gain). It will take 10 minutes to get in effect."
											if(usr.village=="Leaf")leafpriority="Currently Changing"
											if(usr.village=="Sand")sandpriority="Currently Changing"
											if(usr.village=="Sound")soundpriority="Currently Changing"
											spawn(6000)
												if(usr.village=="Leaf")leafpriority="Influence"
												if(usr.village=="Sand")sandpriority="Influence"
												if(usr.village=="Sound")soundpriority="Influence"
												for(var/mob/Z in world)if(Z.village==usr.village)Z<<"<b><center><font size=2><font color=silver>The village priority is now Influence(+20% influence gain)."
								if("Appearance")
									switch(alert(usr,"Are you sure you want to change the priority to Appearance? It will take 10 minutes to get in effect.","","Yes","No"))
										if("Yes")
											for(var/mob/Z in world)if(Z.village==usr.village)Z<<"<b><center><font size=2><font color=silver>The [usr.rank], [usr] has changed the village priority to Appearance(-30% influence loss). It will take 10 minutes to get in effect."
											if(usr.village=="Leaf")leafpriority="Currently Changing"
											if(usr.village=="Sand")sandpriority="Currently Changing"
											if(usr.village=="Sound")soundpriority="Currently Changing"
											spawn(6000)
												if(usr.village=="Leaf")leafpriority="Appearance"
												if(usr.village=="Sand")sandpriority="Appearance"
												if(usr.village=="Sound")soundpriority="Appearance"
												for(var/mob/Z in world)if(Z.village==usr.village)Z<<"<b><center><font size=2><font color=silver>The village priority is now Appearance(-30% influence loss)."
								if("Training")
									switch(alert(usr,"Are you sure you want to change the priority to Training? It will take 10 minutes to get in effect.","","Yes","No"))
										if("Yes")
											for(var/mob/Z in world)if(Z.village==usr.village)Z<<"<b><center><font size=2><font color=silver>The [usr.rank], [usr] has changed the village priority to Training(+20% training speed). It will take 10 minutes to get in effect."
											if(usr.village=="Leaf")leafpriority="Currently Changing"
											if(usr.village=="Sand")sandpriority="Currently Changing"
											if(usr.village=="Sound")soundpriority="Currently Changing"
											spawn(6000)
												if(usr.village=="Leaf")leafpriority="Training"
												if(usr.village=="Sand")sandpriority="Training"
												if(usr.village=="Sound")soundpriority="Training"
												for(var/mob/Z in world)if(Z.village==usr.village)Z<<"<b><center><font size=2><font color=silver>The village priority is now Training(+20% training speed)."
								if("Missions")
									switch(alert(usr,"Are you sure you want to change the priority to Missions? It will take 10 minutes to get in effect.","","Yes","No"))
										if("Yes")
											for(var/mob/Z in world)if(Z.village==usr.village)Z<<"<b><center><font size=2><font color=silver>The [usr.rank], [usr] has changed the village priority to Missions(+1 rank mission rewards). It will take 10 minutes to get in effect."
											if(usr.village=="Leaf")leafpriority="Currently Changing"
											if(usr.village=="Sand")sandpriority="Currently Changing"
											if(usr.village=="Sound")soundpriority="Currently Changing"
											spawn(6000)
												if(usr.village=="Leaf")leafpriority="Missions"
												if(usr.village=="Sand")sandpriority="Missions"
												if(usr.village=="Sound")soundpriority="Missions"
												for(var/mob/Z in world)if(Z.village==usr.village)Z<<"<b><center><font size=2><font color=silver>The village priority is now Missions(+1 rank mission rewards)."
			else alert(usr,"You can not write on this paper.")
mob/proc
	LeaveAkatsuki()
		if(rank=="Akatsuki Member"&&village=="Akatsuki")
			village="None"
			tmpvillage="None"
			missingrank()
			mouseovername()
			for(var/obj/items/equippable/Pein_Ring/M2 in src)del M2
			for(var/obj/items/equippable/Oro_Ring/M2 in src)del M2
			for(var/obj/items/equippable/Kakazu_Ring/M2 in src)del M2
			for(var/obj/items/equippable/Itachi_Ring/M2 in src)del M2
			for(var/obj/items/equippable/Kisame_Ring/M2 in src)del M2
			for(var/obj/jutsu/Akatsuki_Summon/M2 in src)del M2
			for(var/obj/items/equippable/Akatsuki_Suit/M2 in src)
				overlays -= M2
				del M2
			world<<"<b>[src] has left the Akatsuki!"
			verbs-=typesof(/mob/AkatsukiM/verb)
			akatlist:Remove(name)
			akatsave()
mob/AkatsukiM/verb
	Leave()
		set category="Akatsuki"
		LeaveAkatsuki()
mob/Akatsuki/verb
	Capture()
		set category = "Kage"
		Raid()
	Change_Priority()
		set category="Akatsuki"
		if(rank=="Akatsuki Leader"&&village=="Akatsuki")
			switch(input(usr,"Which priority do you want to switch into? It's currently [akatpriority].") in list("Wealth","Training","Missions","Cancel"))
				if("Wealth")
					switch(alert(usr,"Are you sure you want to change the priority to Wealth? It will take 10 minutes to get in effect.","","Yes","No"))
						if("Yes")
							akatpriority="Aggressiveness"
							for(var/mob/Z in world)if(Z.village==usr.village)Z<<"<b><center><font size=2><font color=silver>The village priority is now Wealth(+30% ryo gained from everything)."
				if("Training")
					switch(alert(usr,"Are you sure you want to change the priority to Training? It will take 10 minutes to get in effect.","","Yes","No"))
						if("Yes")
							akatpriority="Aggressiveness"
							for(var/mob/Z in world)if(Z.village==usr.village)Z<<"<b><center><font size=2><font color=silver>The village priority is now Training(+20% training speed)."
				if("Missions")
					switch(alert(usr,"Are you sure you want to change the priority to Missions? It will take 10 minutes to get in effect.","","Yes","No"))
						if("Yes")
							akatpriority="Aggressiveness"
							for(var/mob/Z in world)if(Z.village==usr.village)Z<<"<b><center><font size=2><font color=silver>The village priority is now Missions(+1 rank mission rewards)."

	Recruit_Into_Akatsuki()
		set category = "Akatsuki"
		var/N=0
		for(var/T in akatlist)N++
		if(N>=6)
			src<<"There can only be 6 people in Akatsuki. The current 6 are:"
			for(var/T in akatlist)src<<"[T]"
			return
		var/list/choose = list()
		for(var/mob/player/M in oview(8))
			if(M.village != "Akatsuki" && M.level>= 100 && M.rank != "ANBU Leader" && M.rank != "Hokage" && M.rank != "Kazekage" && M.rank != "Sound Leader")
				choose.Add(M)
		var/cancel = "Cancel"
		choose += cancel
		var/mob/M=input("Who do you want to recruit into Akatsuki?") as null|anything in choose
		if(M == "Cancel" || !M)
			return
		switch(alert(M,"Would you like to be recruited into Akatsuki?","Recruitment","Yes","No"))
			if("Yes")
				world<<"<b><font color=yellow>[M] is now part of Akatsuki."
				M.pkkills=0
				M.rank="Akatsuki Member"
				M.tmprank="Akatsuki Member"
				M.village="Akatsuki"
				M.tmpvillage="Akatsuki"
				M.pktoggle=0
				M.affcheck()
				M.mouseovername()
				var/S=0
				for(var/obj/jutsu/Advanced_Tracking/M2 in M)S = 1
				if(!S)new/obj/jutsu/Advanced_Tracking(M)
				new/obj/items/equippable/Akatsuki_Suit(M)
				var/G=rand(1,4)
				switch(G)
					if(1)new/obj/items/equippable/Kakazu_Ring(M)
					if(2)new/obj/items/equippable/Itachi_Ring(M)
					if(3)new/obj/items/equippable/Oro_Ring(M)
					if(4)new/obj/items/equippable/Kisame_Ring(M)
				M.verbs+=typesof(/mob/AkatsukiM/verb)
				akatlist:Add(M.name)
				akatsave()
			if("No")
				alert(src,"[M] has refused your offer! Beware!")

	Change_Password()
		set category="Akatsuki"
		var/bs=input("What would you like to change password to?") as text
		akatpass=bs
		src<<"<b>The password is now [bs]."
	Boot_From_Akatsuki()
		set category="Akatsuki"
		var/list/choose=list()
		for(var/mob/player/M in world)if(M.village==village)choose.Add(M)
		var/cancel="Cancel"
		choose+=cancel
		var/mob/M=input("Which character do you want to boot from the Akatsuki?") as null|anything in choose
		if(M=="Cancel"||M==null)return
		world<<"<b><font color=red>Akatsuki Info: <font color=white>[M]<font color=silver> has been kicked out of Akatsuki."
		M.village="None"
		M.tmpvillage="None"
		M.missingrank()
		M.mouseovername()
		for(var/obj/items/equippable/Pein_Ring/M2 in M)del M2
		for(var/obj/items/equippable/Oro_Ring/M2 in M)del M2
		for(var/obj/items/equippable/Kakazu_Ring/M2 in M)del M2
		for(var/obj/items/equippable/Itachi_Ring/M2 in M)del M2
		for(var/obj/items/equippable/Kisame_Ring/M2 in M)del M2
		for(var/obj/jutsu/Akatsuki_Summon/M2 in M)del M2
		for(var/obj/items/equippable/Akatsuki_Suit/M2 in M)
			M.overlays -= M2
			del M2
		M<<"<b>You have been kicked out of your village and is now a [rank]!"
		akatlist:Remove(M.name)
		akatsave()
mob/Kage2/verb
	Promote_To_ANBU_Leader()
		set category="Kage"
		if(village=="Leaf"&&leafanbuleader)
			alert(src,"You already have an ANBU Leader.")
			return
		if(village=="Sand"&&sandanbuleader)
			alert(src,"You already have an ANBU Leader.")
			return
		if(village=="Sound"&&soundanbuleader)
			alert(src,"You already have an ANBU Leader.")
			return
		var/list/choose=list()
		for(var/mob/M in oview(8))if(M.village==village&&M.client&&M.rank=="ANBU")choose.Add(M)
		var/cancel="Cancel"
		choose+=cancel
		var/mob/M=input("Who do you want to promote to ANBU Leader? They must be ANBU. The ANBU Leader will have all your verbs while you are offline. Logging in will return power to you.") as null|anything in choose
		if(M=="Cancel"||M==null)return
		alert(src,"You have sent the invitation to be an ANBU Leader to [M].")
		switch(alert(M,"[M]. Do you want to be an ANBU Leader? Being an ANBU Leader will grant you all the powers of the Kage while he is offline.","ANBU Leader","Yes","No"))
			if("Yes")
				for(var/mob/Z in world)if(Z.village==village)Z<<"<b><font color=silver>Village Info: <font color=white>[M]<font color=silver> has been promoted to ANBU Leader by <font color=white>the [rank], [usr]<font color=silver>."
				M<<"<b><font color=yellow><font size=3>Congratulations! You have been promoted to ANBU Leader!"
				M.rank="ANBU Leader"
				M.tmprank="ANBU Leader"
				if(M.village=="Leaf")leafanbuleader=1
				if(M.village=="Sand")sandanbuleader=1
				if(M.village=="Sound")soundanbuleader=1
				if(M.rankup<4)
					M.rankup=4
					M.medal(2,15)
			if("No")
				alert(src,"[M] refused your offer.")
	Demote_An_ANBU_Leader()
		set category="Kage"
		var/list/choose=list()
		for(var/mob/M in world)if(M.village==village&&M.client&&M.rank=="ANBU Leader")choose.Add(M)
		var/cancel="Cancel"
		choose+=cancel
		var/mob/M=input("Who do you want to demote from ANBU Leader to ANBU?") as null|anything in choose
		if(M=="Cancel"||M==null)return
		for(var/mob/Z in world)if(Z.village==village)Z<<"<b><font color=silver>Village Info: <font color=white>[M]<font color=silver> has been demoted to ANBU by <font color=white>the [rank], [usr]<font color=silver>."
		M<<"<b><font color=silver><font size=3>You have been demoted to ANBU."
		M.rank="ANBU"
		M.tmprank="ANBU"
		if(M.village=="Leaf")leafanbuleader=0
		if(M.village=="Sand")sandanbuleader=0
		if(M.village=="Sound")soundanbuleader=0
mob/Kage/verb
	Capture()
		set category = "Kage"
		Raid()
	Mute()
		set category="Kage"
		var/list/choose=list()
		for(var/mob/M in world)if(village==M.village)choose.Add(M)
		var/cancel="Cancel"
		choose+=cancel
		var/mob/M=input("Which character do you want to mute?") as null|anything in choose
		if(!M)return
		var/input=input("Why are you muting [M]? You may skip this if you want.")as null|text
		if(!input)input="not stated"
		var/input2=input("How many seconds do you want to mute him for?(Maximum 1200 second)")as num
		if(input2<=0||input2==null)return
		if(input2>=1)input2=input2
		if(input2>1200)input2=1200
		if(input2<=1200)
			if(!M.muted)
				world<<"<b><font color=white>[M]<font color=red> has been muted by <font color=white>[usr]<font color=red>. He is muted for <font color=white>[input2]<font color=red> seconds and the reason is <font color=white>[input]<font color=red>."
				M.muted=input2
				spawn()M.muteproc()
			else
				M.muted+=input2
				world<<"<b><font color=white>[M]<font color=red>'s mute time has been extended by <font color=white>[usr]<font color=red>. He has <font color=white>[M.muted]<font color=red> seconds of being muted left and the reason for the extension is <font color=white>[input]<font color=red>."
		else
			M.muted=1
			world<<"<b><font color=white>[M]<font color=red> has been muted by <font color=white>[usr]<font color=red>. He is muted for an indefinite amount of time and the reason is <font color=white>[input]<font color=red>."
	Unmute()
		set category="Kage"
		var/list/choose=list()
		for(var/mob/M in world)if(village==M.village)if(M.muted)choose.Add(M)
		var/cancel="Cancel"
		choose+=cancel
		var/mob/M=input("Which character do you want to unmute?") as null|anything in choose
		if(!M)return
		M.muted=0
		for(var/mob/M2 in world)if(village==M2.village)M2<<"<b><font color=white>[M]<font color=red> has been unmuted by <font color=white>[usr]<font color=red>."
	Boot_From_Village()
		set category="Kage"
		if(goldenage=="leaf"&&village!="Leaf"||goldenage=="sand"&&village!="Sand"||goldenage=="sound"&&village!="Sound")
			src<<"<b>You can not recruit or boot during a rival golden age."
			return
		var/list/choose=list()
		for(var/mob/M in world)if(M.village==village&&M!=src)if(M.client)if(M.rank!="ANBU Leader"&&M.rank!="Hokage"&&M.rank!="Kazekage"&&M.rank!="Sound Leader")choose.Add(M)
		var/cancel="Cancel"
		choose+=cancel
		var/mob/M=input("Which character do you want to boot from the village? Make sure you have a good reason for this as this costs 2.5 influence unless influence is below 90%.") as null|anything in choose
		if(M=="Cancel"||M==null)return
		var/T="not stated"
		T=input("Why are you booting [M] from the village?","Boot") as text|null
		for(var/mob/Z in world)if(Z.village==village)Z<<"<b><font color=silver>Village Info: <font color=white>[M]<font color=silver> has been booted from the village by <font color=white>the [rank], [usr]<font color=silver>. The reason is <font color=white>[T]"
		M.village="None"
		M.tmpvillage="None"
		M.mouseovername()
		if(village=="Leaf")leafrec()
		if(village=="Sand")sandrec()
		if(village=="Sound")soundrec()
		M.missingrank()
		spawn()
			var/before=world.GetMedal("Traitor",M)
			if(!before)
				spawn()world.SetMedal("Traitor",M)
				world<<"<b><font color=yellow>Medal Info: [M]([M.key]) has earned the Traitor medal!"
		M<<"<b>You have been kicked out of your village and is now a [M.rank]!"
		if(village=="Leaf"&&leafrep>100||village=="Sand"&&sandrep>100||village=="Sound"&&soundrep>100)reploss(2.5,"Created a missing-nin")
	Promote_To_ANBU()
		set category="Kage"
		var/list/choose=list()
		for(var/mob/M in oview(8))if(M.village==village&&M.client&&M.rank=="Jounin")choose.Add(M)
		var/cancel="Cancel"
		choose+=cancel
		var/mob/M=input("Who do you want to promote to ANBU? They must be Jounins. Their sole job is to ensure your safety and do what you instruct them to(assassinations). They need to obey your commands. You may have a maximum of 3 ANBUs.") as null|anything in choose
		if(M=="Cancel"||M==null)return
		alert(src,"You have sent the invitation to be an ANBU to [M].")
		switch(alert(M,"[M]. Do you want to be an ANBU? As an member of ANBU your job is to follow the Kage's orders directly and ensure his protection. You will receive a mask that renders you anonymous.","Joining ANBU","Yes","No"))
			if("Yes")
				for(var/mob/Z in world)if(Z.village==village)Z<<"<b><font color=silver>Village Info: <font color=white>[M]<font color=silver> has been promoted to ANBU by <font color=white>the [rank], [usr]<font color=silver>."
				M<<"<b><font color=yellow><font size=3>Congratulations! You have been promoted to ANBU!"
				M.rank="ANBU"
				M.tmprank="ANBU"
				if(M.rankup<4)
					M.rankup=4
					M.medal(2,15)
				new/obj/items/equippable/ANBU_Armor(M)
				if(village=="Leaf")new/obj/items/equippable/Leaf_Anbu_Mask(M)
				if(village=="Sand")new/obj/items/equippable/Sand_Anbu_Mask(M)
				if(village=="Sound")new/obj/items/equippable/Sound_Anbu_Mask(M)
				for(var/obj/jutsu/Kage_Powered/M2 in M)del M2
				var/S=0
				for(var/obj/jutsu/Advanced_Tracking/M2 in M)S=1
				if(!S)
					new/obj/jutsu/Advanced_Tracking(M)
					M<<"<b><font color=lime>You have learned Advanced Tracking!"
			if("No")
				alert(src,"[M] refused your offer.")
	Demote_An_ANBU()
		set category="Kage"
		var/list/choose=list()
		for(var/mob/M in world)if(M.village==village&&M.client&&M.rank=="ANBU")choose.Add(M)
		var/cancel="Cancel"
		choose+=cancel
		var/mob/M=input("Who do you want to demote from ANBU to Jounin?") as null|anything in choose
		if(M=="Cancel"||M==null)return
		for(var/mob/Z in world)if(Z.village==village)Z<<"<b><font color=silver>Village Info: <font color=white>[M]<font color=silver> has been demoted to Jounin by <font color=white>the [rank], [usr]<font color=silver>."
		M<<"<b><font color=silver><font size=3>You have been demoted to Jounin."
		M.rank="Jounin"
		M.tmprank="Jounin"
		for(var/obj/items/equippable/ANBU_Armor/M2 in M)del M2
		for(var/obj/items/equippable/Leaf_Anbu_Mask/M2 in M)del M2
		for(var/obj/items/equippable/Sand_Anbu_Mask/M2 in M)del M2
		for(var/obj/items/equippable/Sound_Anbu_Mask/M2 in M)del M2
		for(var/obj/jutsu/Advanced_Tracking/M2 in M)del M2
		for(var/obj/jutsu/Advanced_Tracking/M2 in M.client.screen)del M2
		for(var/obj/jutsu/Kage_Powered/M2 in M)del M2
		for(var/obj/jutsu/Kage_Powered/M2 in M.client.screen)del M2
		M.powered=0
		M<<"<b><font color=lime>You have lost the ability to use Advanced Tracking!"
	Recruit_Missing_Nin()
		set name="Recruit Missing-Nin"
		set category="Kage"
		if(village=="Leaf"&&leafrec||village=="Sand"&&sandrec||village=="Sound"&&soundrec)
			src<<"<b>You must wait 10 minutes in between recruitments and promotions."
			return
		var/list/choose=list()
		for(var/mob/M in oview(8))if(M.village=="None")choose.Add(M)
		var/cancel="Cancel"
		choose+=cancel
		var/mob/M=input("Which missing-nin would you like to recruit? Make sure they are worthy as recruiting costs 5 influence.") as null|anything in choose
		switch(alert(M,"Would you like to be recruited to the [village] village as a Chunin?","Recruitment","Yes","No"))
			if("Yes")
				if(M&&M.village=="None")
					for(var/mob/Z in world)if(Z.village==village)Z<<"<b><font color=silver>Village Info: <font color=white>[M]<font color=silver> has been recruited into the village by <font color=white>the [rank], [usr]<font color=silver>."
					reploss(5,"Recruiting a missing-nin")
					world<<"<b><font color=yellow>[M] has been recruited to the [village] village by the [rank], [src]!"
					M.pkkills=0
					M.rank = "Genin"
					if(M.level >= 60)
						M.rank = "Chunin"
					M.tmprank=M.rank
					M.village=village
					M.tmpvillage=tmpvillage
					M.checkjounin()
					M.mouseovername()
					M.pktoggle=0
					M.affcheck()
			if("No")
				alert(src,"[M] has refused your offer! Beware!")
	Request_ANBU_Assistance()
		set category="Kage"
		usr<<"<b>You have called the ANBUs for help."
		for(var/mob/M in world)if(M.village==village&&M.rank=="ANBU")M<<"<b><font color=red><font size=3>The [rank], [usr] requires your assistance. Use your advanced tracking on him."
	Request_Owner_Assistance()
		set category="Kage"
		usr<<"<b>You have called Dante for help."
		for(var/mob/M in world)if(M.GM>=3)M<<"<b><font color=white><font size=2><center>The [rank], [usr] requires your assistance."
mob/proc/missingrank()
	if(village=="None")
		if(level<20)
			rank="D-Ranked Criminal"
			tmprank="D-Ranked Criminal"
		if(level>=20&&level<40)
			rank="C-Ranked Criminal"
			tmprank="C-Ranked Criminal"
		if(level>=40&&level<60)
			rank="B-Ranked Criminal"
			tmprank="B-Ranked Criminal"
		if(level>=60&&level<80)
			rank="A-Ranked Criminal"
			tmprank="A-Ranked Criminal"
		if(level>=80)
			rank="S-Ranked Criminal"
			tmprank="S-Ranked Criminal"
proc
	leafrec()
		leafrec=1
		spawn(6000)leafrec=0
	sandrec()
		sandrec=1
		spawn(6000)sandrec=0
	soundrec()
		soundrec=1
		spawn(6000)soundrec=0