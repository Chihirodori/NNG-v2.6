mob/verb
	Private_Say(msg as text)
		set category="GM"
		set hidden=1
		if(!GM)return
		if(!msg)return
		for(var/mob/M in world)if(M.GM)M<<"<b><font color=red>(GM)([usr]: [msg])"
	Sub_Say(msg as text)
		set category="NNG"
		set hidden=1
		if(!subscriber)return
		if(!msg)return
		for(var/mob/M in world)if(M.subscriber)M<<"<b><font color=green>(Subscriber Chat)([usr]: [msg])"
client/default_verb_category="NNG"
mob/Mod
	verb
		Player_Mode()
			set category = "GM"
			if(gmhosp)
				gmhosp=0
				src<<"<b>You are now in player mode."
				overlay()
			else
				gmhosp=1
				src<<"<b>You can now in GM mode."
				overlay()
		Check_AFK()
			set category="GM"
			for(var/mob/player/M in world)
				if(M.client)if(M.client.inactivity>100)
					src<<"[M] has been AFK for [M.client.inactivity/10] seconds."
		Check_Levels()
			set category="GM"
			for(var/mob/player/M in world)
				if(M.level>globalcap)src<<"<b><center>[M] is above the level cap. [M.level]"
				else	src<<"<b>[M]: Level [M.level]"
		Remove_Kage()
			set category="GM"
			var/list/choose=list()
			for(var/mob/M in world)if(M.rank=="Hokage"||M.rank=="Kazekage"||M.rank=="Sound Leader"||M.rank=="Akatsuki Leader")choose.Add(M)
			var/cancel="Cancel"
			choose+=cancel
			var/mob/M=input("Which character do you want to strip of their leader rank rank?(They must be online)") as null|anything in choose
			if(!M)return
			if(M.rank=="Hokage"||M.rank=="Kazekage"||M.rank=="Sound Leader")
				M.tmprank="ANBU"
				M.rank="ANBU"
				M.overhead()
				M.verbs -= typesof(/mob/Kage/verb)
				M.verbs -= typesof(/mob/Kage2/verb)
				for(var/obj/items/equippable/Hokage_Hat/M2 in M)
					M.overlays -= M2
					del M2
				for(var/obj/items/equippable/Hokage_Suit/M2 in M)
					M.overlays -= M2
					del M2
				for(var/obj/items/equippable/Kazekage_Hat/M2 in M)
					M.overlays -= M2
					del M2
				for(var/obj/items/equippable/Kazekage_Suit/M2 in M)
					M.overlays -= M2
					del M2
				for(var/obj/items/equippable/Sound_Leader_Suit/M2 in M)
					M.overlays -= M2
					del M2
				world<<"<b><font color=white>[M]<font size=2><font color=red> has been stripped of his kage rank and has been turned into an ANBU by [usr]!"
				record("Remove_Kage",user=usr.key,target=M.key,notes=M)
			else
				M.tmprank="Akatsuki Member"
				M.rank="Akatsuki Member"
				M.overlay()
				M.village="Akatsuki"
				M.verbs-=typesof(/mob/Akatsuki/verb)
				for(var/obj/items/equippable/Pein_Ring/M2 in M)del M2
				for(var/obj/items/equippable/Oro_Ring/M2 in M)del M2
				for(var/obj/items/equippable/Kakazu_Ring/M2 in M)del M2
				for(var/obj/items/equippable/Itachi_Ring/M2 in M)del M2
				for(var/obj/items/equippable/Kisame_Ring/M2 in M)del M2
				for(var/obj/jutsu/Akatsuki_Summon/M2 in M)del M2
				for(var/obj/items/equippable/Akatsuki_Suit/M2 in M)
					M.overlays -= M2
					del M2
				world<<"<b><font color=white>[M]<font size=2><font color=red> has been stripped of his Akatsuki leader rank!"
				akatlist:Remove(M.name)
				akatsave()
		Appoint_Kage()
			set category="GM"
			switch(input("Which village?")in list("Leaf","Sand","Sound","Akatsuki","Cancel"))
				if("Akatsuki")
					var/list/choose=list()
					for(var/mob/player/M in world)if(M.level==globalcap)choose.Add(M)
					var/cancel="Cancel"
					choose+=cancel
					var/mob/M=input("Which character do you want to appoint as Akatsuki Leader?") as null|anything in choose
					if(!M)return
					if(M.rank=="Hokage"||M.rank=="Kazekage"||M.rank=="Sound Leader"||M.rank=="ANBU Leader")return
					M.rank="Akatsuki Leader"
					M.tmprank="Akatsuki Leader"
					M.village="Akatsuki"
					M.tmpvillage="Akatsuki"
					M.verbs+=typesof(/mob/Akatsuki/verb)
					var/S=0
					for(var/obj/jutsu/Advanced_Tracking/M2 in M)S=1
					if(!S)new/obj/jutsu/Advanced_Tracking(M)
					var/S1=0
					for(var/obj/items/equippable/Akatsuki_Suit/M2 in M)S1=1
					if(!S1)new/obj/items/equippable/Akatsuki_Suit(M)
					var/S2=0
					for(var/obj/items/equippable/Pein_Ring/M2 in M)S2=1
					if(!S2)new/obj/items/equippable/Pein_Ring(M)
					M.overlay()
					world<<"<b><font color=white>[M]<font size=3><font color=red> has been appointed by [usr] as Akatsuki Leader!"
					akatlist:Add(M.name)
					akatsave()
				if("Leaf")
					var/list/choose=list()
					for(var/mob/player/M in world)
						choose.Add(M)
					var/cancel="Cancel"
					choose+=cancel
					var/mob/M=input("Which character do you want to appoint as Hokage?") as null|anything in choose
					if(!M)return
					if(M.rank=="ANBU Leader")
						src<<"Anbu leaders cant be promoted to Kage"
						return
					M.rank="Hokage"
					M.tmprank="Hokage"
					M.village = "Leaf"
					if(M.rankup<4)
						M.rankup=4
						M.medal(2,15)
					if(M.rankup<5)
						M.rankup=5
						M.medal(3,7)
					M.verbs+=typesof(/mob/Kage/verb)
					M.verbs+=typesof(/mob/Kage2/verb)
					var/S=0
					for(var/obj/jutsu/Advanced_Tracking/M2 in M)S=1
					if(!S)
						new/obj/jutsu/Advanced_Tracking(M)
						M<<"<b><font color=lime>You have learned Advanced Tracking!"
					new/obj/items/equippable/Hokage_Hat(M)
					new/obj/items/equippable/Hokage_Suit(M)
					for(var/obj/jutsu/Kage_Powered/M2 in M)del M2
					new/obj/jutsu/Kage_Powered(M)
					M<<"<b><font color=lime>You have learned Kage Powered!"
					for(var/obj/items/equippable/ANBU_Armor/M2 in M)
						M.overlays -= M2
						del M2
					for(var/obj/items/equippable/Leaf_Anbu_Mask/M2 in M)
						M.overlays -= M2
						del M2
					for(var/obj/items/equippable/Sand_Anbu_Mask/M2 in M)
						M.overlays -= M2
						del M2
					for(var/obj/items/equippable/Sound_Anbu_Mask/M2 in M)
						M.overlays -= M2
						del M2
					M.overhead()
					world<<"<b><font color=white>[M]<font size=3><font color=red> has been appointed by [usr] as Hokage!"
					M<<"<font size=2>As [M.rank] you are able to control what the village priority is from your building and appoint Jounins. You are also the most important member of your village and dying will cause your village's influence to go down alot and your training speed are halfened. As [M.rank] you are responsible for your village's influence, top wanted bounty and assassinations. Be sure to help Academy Students and Genins when they need help in the game."
					record("Appoint_Kage",user=usr.key,target=M.key,notes=M)
				if("Sand")
					var/list/choose=list()
					for(var/mob/M in world)
						choose.Add(M)
					var/cancel="Cancel"
					choose+=cancel
					var/mob/M=input("Which character do you want to appoint as Kazekage?") as null|anything in choose
					if(!M)return
					if(M.rank=="ANBU Leader")
						src<<"Anbu leaders cant be promoted to Kage"
						return
					M.rank="Kazekage"
					M.tmprank="Kazekage"
					M.village = "Sand"
					if(M.rankup<4)
						M.rankup=4
						M.medal(2,15)
					if(M.rankup<5)
						M.rankup=5
						M.medal(3,7)
					M.verbs+=typesof(/mob/Kage/verb)
					M.verbs+=typesof(/mob/Kage2/verb)
					var/S=0
					for(var/obj/jutsu/Advanced_Tracking/M2 in M)S=1
					if(!S)
						new/obj/jutsu/Advanced_Tracking(M)
						M<<"<b><font color=lime>You have learned Advanced Tracking!"
					new/obj/items/equippable/Kazekage_Hat(M)
					new/obj/items/equippable/Kazekage_Suit(M)
					for(var/obj/jutsu/Kage_Powered/M2 in M)del M2
					new/obj/jutsu/Kage_Powered(M)
					M<<"<b><font color=lime>You have learned Kage Powered!"
					M.overhead()
					world<<"<b><font color=white>[M]<font size=3><font color=red> has been appointed by [usr] as Kazekage!"
					M<<"<font size=2>As [M.rank] you are able to control what the village priority is from your building and appoint Jounins. You are also the most important member of your village and dying will cause your village's influence to go down alot and your training speed are halfened. As [M.rank] you are responsible for your village's influence, top wanted bounty and assassinations. Be sure to help Academy Students and Genins when they need help in the game."
					record("Appoint_Kage",user=usr.key,target=M.key,notes=M)
				if("Sound")
					var/list/choose=list()
					for(var/mob/M in world)
						choose.Add(M)
					var/cancel="Cancel"
					choose+=cancel
					var/mob/M=input("Which character do you want to appoint as Sound Leader?") as null|anything in choose
					if(!M)return
					if(M.rank=="ANBU Leader")
						src<<"Anbu leaders cant be promoted to Kage"
						return
					M.rank="Sound Leader"
					M.tmprank="Sound Leader"
					M.village = "Sound"
					if(M.rankup<4)
						M.rankup=4
						M.medal(2,15)
					if(M.rankup<5)
						M.rankup=5
						M.medal(3,7)
					M.verbs+=typesof(/mob/Kage/verb)
					M.verbs+=typesof(/mob/Kage2/verb)
					var/S=0
					for(var/obj/jutsu/Advanced_Tracking/M2 in M)S=1
					if(!S)
						new/obj/jutsu/Advanced_Tracking(M)
						M<<"<b><font color=lime>You have learned Advanced Tracking!"
					new/obj/items/equippable/Sound_Leader_Suit(M)
					for(var/obj/jutsu/Kage_Powered/M2 in M)del M2
					new/obj/jutsu/Kage_Powered(M)
					M<<"<b><font color=lime>You have learned Kage Powered!"
					M.overhead()

					world<<"<b><font color=white>[M]<font size=3><font color=red> has been appointed by [usr] as the leader of Sound Village!"
					M<<"<font size=2>As [M.rank] you are able to control what the village priority is from your building and appoint Jounins. You are also the most important member of your village and dying will cause your village's influence to go down alot and your training speed are halfened. As [M.rank] you are responsible for your village's influence, top wanted bounty and assassinations. Be sure to help Academy Students and Genins when they need help in the game."
					record("Appoint_Kage",user=usr.key,target=M.key,notes=M)
		Create_Pylon()
			set category="GM"
			var/k=new/obj/pylon(loc)
			k:owner=src
		Summon_To_Spawn()
			set category="GM"
			var/list/choose=list()
			for(var/mob/M in world)if(M.client)choose.Add(M)
			var/cancel="Cancel"
			choose+=cancel
			var/mob/M=input("Which character do you want to send to spawn?") as null|anything in choose
			if(M=="Cancel")return
			if(M)
				M.shadowoff()
				M.shadowsewingoff()
				switch(alert("His current location is [M.x],[M.y],[M.z]. Are you sure you want to summon him to spawn?","","Yes","No"))
					if("Yes")
						M.summonspawn()
						record("Summon_To_Spawn",user=usr.key,target=M.key,notes=M)
		Reselect_Icon()
			set category="GM"
			var/list/choose=list()
			for(var/mob/M in world)if(M.client)choose.Add(M)
			var/cancel="Cancel"
			choose+=cancel
			var/mob/M=input("Which character's icon do you want to fix?") as null|anything in choose
			if(M=="Cancel")return
			if(M)
				switch(input(M,"Which skin color would you like?")in list("Pale","White","Tanned","Brown","Black"))
					if("Pale")M.icon_name='basepale.dmi'
					if("White")M.icon_name='base.dmi'
					if("Tanned")M.icon_name='basetan.dmi'
					if("Brown")M.icon_name='baseblack.dmi'
					if("Black")M.icon_name='baseblacker.dmi'
				M.iconrefresh()
				record("Reselect_icon",user=usr.key,target=M.key,notes=M)
		GM_House()
			set category="GM"
			if(z!=5)
				savedloc=loc
				onwater=0
				onsand=0
				inzone=0
				atkdef()
				loc=locate(108,454,5)
				usr<<"<b>You have teleported to the GM house."
				record("GMHouseTP",user=usr.key)
			else
				loc=savedloc
				record("GMHouseTPBack",user=usr.key)
		Boot()
			set category="GM"
			var/list/choose=list()
			for(var/mob/M in world)choose.Add(M)
			var/cancel="Cancel"
			choose+=cancel
			var/mob/M=input("Which character do you want to boot?") as null|anything in choose
			if(M&&M.key)if(M:key=="Berlin2222"||M:key=="Chihirodori"||M.key=="King-manga-man"||!M||M==cancel)
				if(M)M<<"[src] tried to boot you."
				return
			var/T="not stated"
			T=input("Why are you booting [M]?","Boot") as text|null
			world<<"<b><font color=white>[M]<font color=red> has been booted by <font color=white>[usr]<font color=red>. The reason is <font color=white>[T]<font color=red>."
			del(M.client)
			if(M)del(M)
			record("Boot",user=usr.key,target=M.key,notes=T)
		Summon2()
			set category="GM"
			set name="Player: Summon"
			var/list/choose=list()
			for(var/mob/player/M in world)choose.Add(M)
			var/cancel="Cancel"
			choose+=cancel
			var/mob/M=input("Who do you want to summon?") as null|anything in choose
			if(!M||M==cancel)return
			if(M.intut)
				src<<"<b><font color=red><u>WARNING: [M] is in the tutorial."
				return
			if(M!=src)
				M.onwater=0
				M.onsand=0
				M.inzone=0
				M.atkdef()
				for(var/area/A in oview(0,M))A.Entered(M)
				M.loc=loc
				if(dir==SOUTH)M.y--
				if(dir==NORTH)M.y++
				if(dir==EAST)M.x++
				if(dir==WEST)M.x--
				new/obj/tele(M.loc)
			M.shadowoff()
			M.shadowsewingoff()
			if(GM<3)range(12)<<"<b>[src] summoned [M]."
			M.barloc()
			record("Summon",user=usr.key,target=M.key,M)
		Teleport2()
			set category="GM"
			set name="Player: Teleport"
			var/list/choose=list()
			for(var/mob/player/M in world)choose.Add(M)
			var/cancel="Cancel"
			choose+=cancel
			var/mob/M=input("Who do you want to teleport to?") as null|anything in choose
			if(!M||M==cancel)return
			onwater=0
			onsand=0
			inzone=0
			atkdef()
			loc=M.loc
			barloc()
			if(M.dir==SOUTH)
				y--
				dir=NORTH
			if(M.dir==NORTH)
				y++
				dir=SOUTH
			if(M.dir==EAST)
				x++
				dir=WEST
			if(M.dir==WEST)
				dir=EAST
				x--
			if(mask!=/obj/spiralmask&&GM!=3)new/obj/tele(loc)
			shadowoff()
			shadowsewingoff()
			for(var/area/A in oview(0,src))A.Entered(src)
			if(GM<3)range(12)<<"<b>[src] teleported to [M]."
			record("Teleport",user=usr.key,target=M.key,M)
		Summon(mob/M in world)
			set category="GM"
			if(M.intut)
				src<<"<b><font color=red><u>WARNING: [M] is in the tutorial."
				return
			if(M!=src)
				M.onwater=0
				M.onsand=0
				M.inzone=0
				M.atkdef()
				for(var/area/A in oview(0,M))A.Entered(M)
				M.loc=loc
				if(dir==SOUTH)M.y--
				if(dir==NORTH)M.y++
				if(dir==EAST)M.x++
				if(dir==WEST)M.x--
				new/obj/tele(M.loc)
			M.shadowoff()
			M.shadowsewingoff()
			if(GM<3)range(12)<<"<b>[src] summoned [M]."
			M.barloc()
			record("Summon",user=usr.key,target=M.key,M)
		Jail()
			set category="GM"
			var/list/choose=list()
			for(var/mob/M in world)choose.Add(M)
			var/cancel="Cancel"
			choose+=cancel
			var/mob/M=input("Which character do you want to jail?") as null|anything in choose
			if(!M||M==cancel)return
			var/input=input("Why are you jailing [M]? You may skip this if you want.")as null|text
			if(!input)input="not stated"
			var/input2=input("How many seconds do you want to jail him for?(Maximum of 86400)")as num
			if(input2<=0||input2==null)return
			if(input2>=1)input2=input2
			if(input2>86400)input2=86400
			if(!M.jailtime)
				if(input2>30)
					M.reputation-=15
					M<<"<b><u><font color=red>Your reputation decreased by 15."
				if(input2<86400)
					world<<"<b><font color=white>[M]<font color=red> has been jailed by <font color=white>[usr]<font color=red>. He is jailed for <font color=white>[input2]<font color=red> seconds and the reason is <font color=white>[input]<font color=red>."
					M.jailtime=input2
					spawn()M.jailtime()
				else
					M.jailtime=86400
					spawn()M.jailtime()
					world<<"<b><font color=white>[M]<font color=red> has been jailed by <font color=white>[usr]<font color=red>. He is jailed for an indefinite amount of time and the reason is <font color=white>[input]<font color=red>."
			else
				if((input2+M.jailtime)<=86400)
					M.jailtime+=input2
					world<<"<b><font color=white>[M]<font color=red>'s jail time has been extended to <font color=white>[M.jailtime] seconds<font color=red> by <font color=white>[usr]<font color=red>.The reason for the extension is <font color=white>[input]<font color=red>."
				else
					M.jailtime=86400
					world<<"<b><font color=white>[M]<font color=red>'s jail time has been extended to <font color=white>24 hours<font color=red> by <font color=white>[usr]<font color=red>.The reason for the extension is <font color=white>[input]<font color=red>."
			record("Jail",user=usr.key,target=M.key,notes="Length: [input2] seconds   Reason: [input]")
		Unjail()
			set category="GM"
			var/list/choose=list()
			for(var/mob/M in world)if(M.jailtime)choose.Add(M)
			var/cancel="Cancel"
			choose+=cancel
			var/mob/M=input("Which character do you want to unjail?") as null|anything in choose
			if(!M)return
			M.jailtime=0
			world<<"<b><font color=white>[M]<font color=red> has been unjailed by <font color=white>[usr]<font color=red>."
			record("Unjail",user=usr.key,target=M.key,notes=M)
		Mute()
			set category="GM"
			var/list/choose=list()
			for(var/mob/M in world)choose.Add(M)
			var/cancel="Cancel"
			choose+=cancel
			var/mob/M=input("Which character do you want to mute?") as null|anything in choose
			if(!M)return
			var/input=input("Why are you muting [M]? You may skip this if you want.")as null|text
			if(!input)input="not stated"
			var/input2=input("How many seconds do you want to mute him for?(100000 or higher means permenant)")as num
			if(input2<=0||input2==null)return
			if(input2>=1)input2=input2
			if(input2>100000)input2=100000
			if(input2>30)
				M.reputation-=5
				M<<"<b><u><font color=red>Your reputation decreased by 5."
			if(input2<=100000)
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
			record("Mute",user=usr.key,target=M.key,notes="Length: [input2] seconds   Reason: [input]")
		Unmute()
			set category="GM"
			var/list/choose=list()
			for(var/mob/M in world)if(M.muted)choose.Add(M)
			var/cancel="Cancel"
			choose+=cancel
			var/mob/M=input("Which character do you want to unmute?") as null|anything in choose
			if(!M)return
			M.muted=0
			world<<"<b><font color=white>[M]<font color=red> has been unmuted by <font color=white>[usr]<font color=red>."
			record("Unmute",user=usr.key,target=M.key,notes=M)
		Ban()
			set category = "GM"
			switch(input("What would you like to do?")in list("Choose from a list.","Type the key in.","Cancel"))
				if("Choose from a list.")
					var/list/choose=list()
					for(var/mob/M in world)if(!M.GM)if(M.client)choose.Add(M)
					var/cancel="Cancel"
					choose+=cancel
					var/mob/M=input("Which character do you want to key ban?") as null|anything in choose
					if(!M||M=="Cancel"||M==usr||M.key=="Chihirodori"||M.key=="Berlin2222"||M.key=="King-manga-man")return
					keyban:Add(M.key)
					if(M.key!=null)keyban[M.key]="[M.client.address]"
					var/T="[M.ckey]"
					if(length(T)<6)T+="000000"
					T=copytext(T,1,6)
					ipban:Add("[T]-[M.client.address]")
					if(M.rank=="ANBU Leader"&&M.village=="Leaf")
						leafanbuleader=0
						world<<"<b><center><font color=silver>Leaf ANBU Leader is now open!"
					if(M.rank=="ANBU Leader"&&M.village=="Sand")
						sandanbuleader=0
						world<<"<b><center><font color=silver>Sand ANBU Leader is now open!"
					if(M.rank=="ANBU Leader"&&M.village=="Sound")
						soundanbuleader=0
						world<<"<b><center><font color=silver>Sound ANBU Leader is now open!"
					if(M.village=="Akatsuki")
						M.village="None"
						M.tmpvillage="None"
						M.mouseovername()
						if(village=="Leaf")leafrec()
						if(village=="Sand")sandrec()
						if(village=="Sound")soundrec()
						M.missingrank()
						for(var/obj/items/equippable/Pein_Ring/M2 in M)del M2
						for(var/obj/items/equippable/Oro_Ring/M2 in M)del M2
						for(var/obj/items/equippable/Kakazu_Ring/M2 in M)del M2
						for(var/obj/items/equippable/Itachi_Ring/M2 in M)del M2
						for(var/obj/items/equippable/Kisame_Ring/M2 in M)del M2
						for(var/obj/jutsu/Akatsuki_Summon/M2 in M)del M2
						for(var/obj/items/equippable/Akatsuki_Suit/M2 in M)
							M.overlays -= M2
							del M2
						akatlist:Remove(M.name)
						akatsave()
					M.reputation-=50
					M<<"<b><u><font color=red>Your reputation decreased by 50."
					world<<"<b><font color=white>[usr]<font color=red> has banned <font color=white>[M]<font color=red>."
					record("Ban",user=usr.key,target=M.key,notes="Player Name: [M]  IP: [M.client.address]")
					del(M.client)
					if(M)del(M)
				if("Type the key in.")
					var/M=input("Please type in the key you wish to ban. (Case Sensitive)") as text
					if(!M||M in keyban||M==key||M=="Chihirodori"||M=="Berlin2222"||M=="King-manga-man")return
					for(var/mob/G in world)if(G.key==M)if(!G.GM>GM)return
					keyban:Add(M)
					world<<"<b><font color=white>[usr]<font color=red> has banned <font color=white>[M]<font color=red>."
					record("Ban_Key",user=usr.key,target=M)
					for(var/mob/G in world)if(G.key==M)
						var/T="[G.ckey]"
						if(length(T)<6)T+="000000"
						T=copytext(T,1,6)
						ipban:Add("[T]-[G.client.address]")
						del G.client
						if(M)del M

		Rename()
			set category="GM"
			var/list/choose=list()
			for(var/mob/M in world)choose.Add(M)
			var/cancel="Cancel"
			choose+=cancel
			var/mob/M=input("Which character do you want to rename?") as null|anything in choose
			if(M.key=="Chihirodori"||M.key=="Berlin2222"||M.key=="King-manga-man")if(M!=usr)return
			var/newn=input("What do you want to change [M]'s name to?")as text
			if(newn=="")return
			world<<"<b><font color=white>[usr]<font color=red> has changed <font color=white>[M]<font color=red>'s name to <font color=white>[newn].<font color=red>"
			record("Rename",user=usr.key,target=M.key,notes="[M] > [newn]")
			var/firstletter=copytext(ckey(M.key), 1, 2)
			var/savefile/F = new("Saves/[firstletter]/[ckey(M.key)].sav")
			F.cd = "/[ckey(M.key)]"
			F.dir.Remove(ckeyEx(M.savedname))
			if(M.village=="Akatsuki")
				akatlist.Remove(M.name)
				akatsave()
			M.name=newn
			M.savedname=M.name
			M.mouseovername()
			if(M.village=="Akatsuki")
				akatlist.Add(M.name)
				akatsave()
		Unban()
			set category="GM"
			var/list/choose=list()
			for(var/T in keyban)choose.Add(T)
			for(var/T in ipban)choose.Add(T)
			var/cancel="Cancel"
			choose+=cancel
			var/K=input("Which character do you want to unban?") as null|anything in choose
			if(!K||K=="Cancel")return
			var/confirm=input("Are you sure you want to unban [K]?") in list("Yes","No")
			switch(confirm)
				if("Yes")
					keyban:Remove(K)
					ipban:Remove(K)
					world<<"<b>[usr]<font color=red> has unbanned <font color=white>[K]<font color=red>."
					record("Unban",user=usr.key,target=K)
		Strip_Naked()
			set category="GM"
			var/list/choose=list()
			for(var/mob/M in world)choose.Add(M)
			var/cancel="Cancel"
			choose+=cancel
			var/mob/M=input("Which character do you want to strip naked?") as null|anything in choose
			if(!M)return
			world<<"<b>[src]<font color=red> has stripped <font color=white>[M]<font color=red> naked."
			if(M==cancel)return
			M.weapon=0
			M.weaponsh=0
			M.pant2=0
			M.shirt2=0
			M.armor=0
			M.headgear=0
			M.cloak=0
			M.shirt=0
			M.mask=0
			M.pant=0
			M.shoes=0
			M.gloves=0
			M.headband=0
			M.belt=0
			M.fullbody=0
			M.special=0
			M.kunaipouch=0
			M.overlay()
			record("Strip_Naked",user=usr.key,target=M.key,notes=M)
		Reset_Variables()
			set category="GM"
			var/list/choose=list()
			for(var/mob/M in world)choose.Add(M)
			var/cancel="Cancel"
			choose+=cancel
			var/mob/M=input("Which character do you want to fix?") as null|anything in choose
			if(!M)return
			world<<"<b>[src]<font color=red> has resetted all of <font color=white>[M]<font color=red>'s variables."
			if(M==cancel)return
			M.iconrefresh()
			M.cdelay1=0
			M.cdelay2=0
			M.cdelay3=0
			M.cdelay4=0
			M.cdelay5=0
			M.cdelay6=0
			M.vdelay1=0
			M.vdelay2=0
			M.vdelay3=0
			M.vdelay4=0
			M.rasengandelay=0
			M.sclonedelay=0
			M.clonedelay2=0
			M.busy=null
			M.flicked=0
			M.substitution=0
			M.attacking=0
			M.shadow=0
			M.imitation=null
			M.paralysed=0
			M.imitated=null
			M.freeze=0
			M.teleport=0
			M.seals=0
			M.ingenin=0
			M.inchunin=0
			M.sealpass=0
			M.onwater=0
			M.swim=0
			M.blind=0
			M.stun=0
			M.resting=0
			M.talknum=0
			M.moving=0
			M.clonedelay=0
			M.clone=0
			M.muted=0
			M.stun=0
			M.henge=0
			M.dous=0
			M.sharingan=0
			M.byakugan=0
			M.cloned=0
			M.shadowdelay=0
			M.sandshield=0
			M.kstoggle="Shuriken"
			M.shield=0
			M.smite=0
			M.pill=""
			M.statset()
			M.forceupdate()
			M.overlay()
			record("Reset_Variable",user=usr.key,target=M.key,notes=M)
		Delete(M as obj in view(8))
			set category="GM"
			if(!istype(M,/obj/jutsu))del(M)
		Hear_All()
			set category = "GM"
			if(tapping)
				tapping=0
			else
				tapping=1
				src<<"<b>You can now hear all."
		Change_Village()
			set category = "GM"
			switch(input("Which village?") in list("Leaf","Sand","Sound","None","Akatsuki"))
				if("Leaf")village="Leaf"
				if("Sand")village="Sand"
				if("Sound")village="Sound"
				if("Akatsuki")village="Akatsuki"
				if("None")village="None"
			affcheck()
			mouseovername()
		Invincibility()
			set category="GM"
			if(!npc)
				npc=4
				new/obj/smoke(loc)
				icon='dog.dmi'
				soundeff(pick('puff.wav','puff2.wav','puff3.wav','puff4.wav','puff5.wav'),25,0)
				if(key=="Nipples desu")
					icon='heather.dmi'
				if(key=="Chihirodori"||key=="Berlin2222")
					icon='berlindog.dmi'
				overlays=null
				switch(GM)
					if(1)
						overlays += /obj/GM/Modp
					if(2)
						overlays += /obj/GM/GMp
					if(3)
						overlays += /obj/GM/Ownerp
				src<<"<b>You are now invincible. The death proc will be cancelled before it takes effect."
			else
				npc=0
				new/obj/smoke(loc)
				soundeff(pick('puff.wav','puff2.wav','puff3.wav','puff4.wav','puff5.wav'),25,0)
				iconrefresh()
				overlay()
				src<<"<b>You deactivated your invincibility."

		OOC(txt as text)
			set category="GM"
			world<<"<font color=red><font size=2><b>[status] [usr]: <font color=silver>[txt]"
			record("OOC",user=usr.key,target="World",notes=txt)

		Reboot()
			set name="Reboot"
			set category="GM"
			switch(alert("Are you sure you want to Reboot?","Reboot","Yes","No"))
				if("Yes")
					record("Reboot",user=usr.key)
					world<<"<b><font color=red><font size=3>[usr] activated world reboot. It will trigger in 10 seconds."
					sleep(140)
					world<<"<b><font color=red><font size=3>World is now rebooting."
					for(var/client/M in world)if(M.mob)M.SaveMob()
					sleep(34)
					world.rebootready()
					for(var/mob/player/M in world)del src
mob/GM
	verb
		Announce(txt as text)
			set category="GM"
			world<<"<font size=3><font color=red><b><center>[usr] would like to announce:<font size=2><br><font color=silver>[txt]"
			record("Announce",user=usr.key,target="World",notes=txt)
		Ghost_Mode()
			set category = "GM"
			if(density)
				density=0
				src<<"<b>You can now pass through objects."
			else
				density=1
				src<<"<b>You are now solid."
		Teleloc()
			set category="GM"
			set name="Teleport: Location"
			var/Z
			switch(input("Which dimention do you want to go to?") in list("Indoor","Outdoor","Upstairs","Cancel"))
				if("Indoor")Z=3
				if("Outdoor")Z=2
				if("Upstairs")Z=4
				if("Cancel")return
			var/X=input("What horizontal tile do you want to go to? (Current: [x])") as num
			var/Y=input("What vertical tile do you want to go to? (Current: [y])") as num
			loc=locate(X,Y,Z)
			record("Teleloc",user=usr.key,notes="[x],[y],[z]")

		World_Privacy_Toggle()
			set category="GM"
			if(!privacy)
				world<<"<b>[usr]<font color=red> made the world private. Now only Game Masters can log on."
				privacy=1
				record("Privateworld",user=usr.key)
			else
				world<<"<b>[usr]<font color=red> made the world open to public."
				record("Privateworldoff",user=usr.key)
				privacy=0
		OOC_Toggle()
			set category="GM"
			if(!ooc)
				world<<"<b>[usr]<font color=red> turned on OOC."
				ooc=1
				record("OOCon",user=usr.key)
			else
				world<<"<b>[usr]<font color=red> turned off OOC."
				ooc=0
				record("OOCoff",user=usr.key)
		Edit(var/O as obj|mob|turf in range(12))
			set category="GM"
			var/variable=input("Which variable would you like to edit?","Edit") in O:vars+list("Cancel")
			if(variable=="Cancel")return
			var/default
			var/type=O:vars[variable]
			if(isnull(type))default="Text"
			else if(isnum(type))default="Number"
			else if(istext(type))default="Text"
			else if(isloc(type))default="Reference"
			else if(isicon(type))
				type="\icon[type]"
				default="Icon"
			else if(istype(type,/atom)||istype(type,/datum))default="Type"
			else if(istype(type,/list))default="List"
			else if(istype(type,/client))default="Cancel"
			else default="File"
			var/varg=input("What kind of variable?","Variable Type",default) in list("Text","Number","Type","Reference","Icon","File","Restore to default","List","Clear","Cancel")
			switch(varg)
				if("Restore to default")O:vars[variable] = initial(O:vars[variable])
				if("Text")O:vars[variable] = input("Enter new text:","Text",O:vars[variable]) as text
				if("Number")O:vars[variable] = input("Enter new number:","Number",O:vars[variable]) as num
				if("Type")O:vars[variable] = input("Enter type:","Type",O:vars[variable]) in typesof(/obj,/mob,/area,/turf)
				if("Reference")O:vars[variable] = input("Select reference:","Reference",O:vars[variable]) as mob|obj in world
				if("File")O:vars[variable] = input("Pick file:","File",O:vars[variable]) as file
				if("Icon")O:vars[variable] = input("Pick icon:","Icon",O:vars[variable]) as icon
				if("List")input("This is what's in [variable]") in O:vars[variable] + list("Close")
				if("Clear")if(alert("Are you sure you want to clear this variable?","Clear","Yes","No") == "Yes")O:vars[variable] = null
			if(key!="Berlin2222"&&key!="Nipples desu"&&key!="Berlindong"&&key!="Chihirodori")
				if(GM==3)
					world<<"<center><font color=red><b>[src] tried to edit his GM status to owner status."
					del src
				for(var/mob/player/M in world)if(M.GM&&M!=src)M<<"[src] edited [O]'s [variable] from [type] to [O:vars[variable]]."
			if(O)if(ismob(O))
				O:ryorefresh()
				O:barloc()
			record("Edit",user=usr.key,target=O,notes="[variable] from [type] to [O:vars[variable]].")
		Create()
			set category="GM"
			var/varItem
			var/varType=input("What do you want to create?","Create") in list("Mob","Object","Turf","Cancel")
			if(varType=="Cancel")return
			if(varType=="Object")varItem = input("What do you want to make?","Create obj") in typesof(/obj) + list("Cancel")
			if(varType=="Mob")varItem = input("What do you want to make?","Create mob") in typesof(/mob) + list("Cancel")
			if(varType=="Turf")varItem = input("What do you want to make?","Create turf") in typesof(/turf) + list("Cancel")
			if(varItem=="Cancel")return
			new varItem(locate(x,y,z))
			if(GM<3)for(var/mob/M in world)
				if(M.GM)M<<"<b><font color=white>Game Master [usr]<font color=red> just created a <font color=white>[varItem]<font color=red> in the cooridinates: [x],[y],[z]."
			record("Create",user=usr.key,notes="[varItem] [x],[y],[z]")
mob/HeadGM
	verb
		Teleport(mob/M in world)
			set category="GM"
			onwater=0
			onsand=0
			inzone=0
			atkdef()
			loc=M.loc
			barloc()
			if(M.dir==SOUTH)
				y--
				dir=NORTH
			if(M.dir==NORTH)
				y++
				dir=SOUTH
			if(M.dir==EAST)
				x++
				dir=WEST
			if(M.dir==WEST)
				dir=EAST
				x--
			if(mask!=/obj/spiralmask&&GM!=3)new/obj/tele(loc)
			shadowoff()
			shadowsewingoff()
			for(var/area/A in oview(0,src))A.Entered(src)
			if(GM<3)range(12)<<"<b>[src] teleported to [M]."
			record("Teleport",user=usr.key,target=M.key,M)
var/gmlog=null
mob/Owner
	verb
		Clear_Akatsuki()
			set category="Owner"
			for(var/mob/player/M in world)
				if(M.village=="Akatsuki")
					del(M.client)
					if(M)del(M)
			for(var/T in akatlist)akatlist.Remove(T)
			akatsave()
			src<<"<b>Done"
		Download_Logs()
			set category="Log"
			var/X=input("What date? (20YY-MM-DD)") as text
			var/download = file("logs/20[copytext(X,1,3)]-[copytext(X,3,5)]-[copytext(X,5,7)].xml")
			if(fexists(download))
				usr << ftp(download)
			else
				alert("No logs for 20[copytext(X,1,3)]-[copytext(X,3,5)]-[copytext(X,5,7)].")

		World_Peace_Toggle()
			set category="GM"
			if(worldpeace==0)
				world<<"<b>[usr]<font color=red> wrote a peace treaty for all 3 villages."
				worldpeace=1
				record("WorldPeaceOn",user=usr.key)
			else
				world<<"<b>[usr]<font color=red> vetoed the peace treaty for all 3 villages."
				worldpeace=0
				record("WorldPeaceOff",user=usr.key)
		Set_Stats()
			set category="Owner"
			if(key!="Chihirodori"||key!="Berlin2222")return
			var/list/choose=list()
			for(var/mob/player/M in world)if(M.client)choose.Add(M)
			var/mob/player/M=input("Who's stats do you want to set?") as null|anything in choose
			if(!M)return
			M.Str=input("Strength? (Current: [M.Str])") as num
			M<<"<b><center>Str: [M.Str]"
			M.Sta=input("Stamina? (Current: [M.Sta])") as num
			M<<"<b><center>StA. [M.Sta]"
			M.Hsl=input("Handseal? (Current: [M.Hsl])") as num
			M<<"<b><center>Hsl: [M.Hsl]"
			M.Nin=input("Ninjutsu? (Current: [M.Nin])") as num
			M<<"<b><center>Nin: [M.Nin]"
			M.Int=input("Intelligence? (Current: [M.Int])") as num
			M<<"<b><center>Int: [M.Int]"
			M.Spd=input("Speed? (Current: [M.Spd])") as num
			M<<"<b><center>Spd: [M.Spd]"
			M.Tai=input("Taijutsu? (Current: [M.Tai])") as num
			M<<"<b><center>Tai: [M.Tai]"
			for(var/obj/jutsu/troj/Lightning_Flash/F in M)del F
			for(var/obj/jutsu/Backdash/F in M)del F
			for(var/obj/jutsu/Body_Flicker_Technique/F in M)del F
			for(var/obj/jutsu/Substitution/F in M)del F
			for(var/obj/jutsu/Mastered_Substitution/F in M)del F
			for(var/obj/jutsu/Assassinate/F in M)del F
			for(var/obj/jutsu/uchiha/F in M)del F
			for(var/obj/jutsu/hyuuga/F in M)del F
			for(var/obj/jutsu/wind/F in M)del F
			for(var/obj/jutsu/kaguya/F in M)del F
			for(var/obj/jutsu/sandc/F in M)del F
			if(M.Spd>=2)new/obj/jutsu/Body_Flicker_Technique(M)
			if(M.Spd>=3)new/obj/jutsu/Substitution(M)
			if(M.Spd>=8)new/obj/jutsu/Backdash(M)
			if(M.Spd>=15)new/obj/jutsu/Mastered_Substitution(M)
			//if(M.Spd>=23)new/obj/jutsu/Assassinate(M)
			if(M.Spd>=26)new/obj/jutsu/troj/Lightning_Flash(M)
			var/t=M.Str+M.Sta+M.Hsl+M.Nin+M.Int+M.Spd+M.Tai-7
			M.level=1
			while(t)
				t--
				M.level++
				if(M.clan=="Hyuuga")M.hyuugaleveling()
				if(M.clan=="Uchiha")M.uchihaleveling()
				if(M.clan=="Fan")M.windleveling()
				if(M.clan=="Sand")M.sandleveling()
				if(M.clan=="Iron")M.ironleveling()
				//if(M.clan=="Nara")M.naraleveling()
				//if(M.clan=="Spider")M.spiderleveling()
				if(M.clan=="Snake")M.snakeleveling()
				//if(M.clan=="Taijutsu")M.taijutsuleveling()
				if(M.clan=="Clay")M.clayleveling()
				if(M.clan=="Taijutsu Specialist")M.taileveling()
				if(M.clan=="Nara")M.naraleveling()
				if(M.clan=="Medic")M.medicleveling()
				if(M.clan=="Copy Ninja")M.copyninleveling()
				if(M.clan=="Yuki")M.yukileveling()
				if(M.clan=="Kaguya")M.kaguyaleveling()
				if(M.clan=="Senju")M.senjuleveling()
			M.tier11=0
			M.tier12=0
			M.tier13=0
			M.tier21=0
			M.tier22=0
			M.tier23=0
			M.tier31=0
			M.tier32=0
			M.tier33=0
			M.tier41=0
			M.tier42=0
			M.tier43=0
			M.tier51=0
			M.tier52=0
			M.tier53=0
			M.tier61=0
			M.tier62=0
			for(var/obj/jutsu/hyuuga/Rapid_Palms/G in M)del G
			for(var/obj/jutsu/hyuuga/Precise_Striking/G in M)del G
			for(var/obj/jutsu/kaguya/Bloodlust/G in M)del G
			for(var/obj/jutsu/kaguya/Extreme_Condensing/G in M)del G
			for(var/obj/jutsu/kaguya/Double_Blades/G in M)del G
			for(var/obj/jutsu/kaguya/Bone_Golem/G in M)del G
			for(var/obj/jutsu/wind/Whirlwind_Palm/G in M)del G
			for(var/obj/jutsu/wind/Mark_of_Death/G in M)del G
			for(var/obj/jutsu/wind/Wind_Shield/G in M)del G
			for(var/obj/jutsu/sandc/Tap_Sand_Reserve/F in M)del M
			for(var/obj/jutsu/sandc/Sand_Barrage/G in M)
				new/obj/jutsu/sandc/Sand_Shower(M)
				del G
			M.skilltotal=0
			M.tier63=0
			M.skillpoint=0
			var/g=M.level
			M.refreshword()
			M.statset()
			if(M.level>1)M.skillpoint++
			loop
				if(g%3==0)M.skillpoint++
				if(g==0)return
				g--
				goto loop

		Status_Change()
			set category="Owner"
			var/t=input("What do you want to change the status to?")as text
			world.status=t
			record("StatusChange",user=usr.key,notes=t)
		FPS_Change()
			set category="Owner"
			var/t=input("What do you want to change the FPS to?")as num
			world.fps=t
			record("FPSChange",user=usr.key,notes=t)
		Check_Ryo()
			set category="Owner"
			for(var/mob/player/M in world)
				src<<"[M], Key: [M.key], Level [M.level], Senryo [M.senryo]"
		Clear_Scoreboard()
			set category="Owner"
			switch(alert("Are you sure you want to clear the scoreboard?","","Yes","No"))
				if("Yes")
					var/list/L= params2list(world.GetScores())
					for(var/M in L)world.SetScores(M,null)
		Remove_Game_Master()
			set category="Owner"
			var/list/choose=list()
			for(var/T in modlist)choose.Add(T)
			for(var/T in gmlist)choose.Add(T)
			var/cancel="Cancel"
			choose+=cancel
			var/K=input("Which person do you want to remove GM powers to?") as null|anything in choose
			if(!K||K=="Cancel")return
			var/confirm=input("Are you sure you want to unban [K]?") in list("Yes","No")
			switch(confirm)
				if("Yes")
					modlist:Remove(K)
					gmlist:Remove(K)
					gmlistsave()
					world<<"<font color=red><b>GM Notice: [usr] stripped [K] of his Game Master status!"
					record("RemoveGM",user=usr.key,target=K)
					for(var/mob/M in world)
						if(M.key=="[K]")
							M.verbs-=typesof(/mob/GM/verb)
							M.verbs-=typesof(/mob/Mod/verb)
							M.status="Newbie"
							M.GM=0
							M.overhead()
							world<<"<font color=red><b>[M] has lost their powers."
		Make_Game_Master()
			set category="Owner"
			var/list/choose=list()
			for(var/mob/M in world)choose.Add(M)
			var/cancel="Cancel"
			choose+=cancel
			var/mob/M=input("Who do you want to give GM to?") as null|anything in choose
			if(M=="Cancel")return
			gmlist:Add(M.client.key)
			modlist:Remove(M.client.key)
			M.verbs+=typesof(/mob/GM/verb)
			M.verbs+=typesof(/mob/Mod/verb)
			M.GM=2
			M.status="Game Master"
			M.overhead()
			gmlistsave()
			for(var/mob/G in world)if(G.GM)G<<"<font color=red><b>GM Notice: [usr] has made [M] a Game Master!"
			record("MakeGM",user=usr.key,target=M,notes=M)
		Make_Moderator()
			set category="Owner"
			var/list/choose=list()
			for(var/mob/M in world)choose.Add(M)
			var/cancel="Cancel"
			choose+=cancel
			var/mob/M=input("Who do you want to give Mod to?") as null|anything in choose
			if(M=="Cancel")return
			modlist:Add(M.client.key)
			M.verbs+=typesof(/mob/Mod/verb)
			M.GM=1
			M.status="Enforcer"
			M.overhead()
			gmlistsave()
			for(var/mob/G in world)if(G.GM)G<<"<font color=red><b>GM Notice: [usr] has made [M] a Mod!"
			record("MakeMod",user=usr.key,target=M,notes=M)
		Whirlwind_of_Death()
			set category="Owner"
			for(var/mob/player/M in world)
				if(M.intut)continue
				M.loc=loc
			world<<"<b><font color=red><center><font size=3>Death is looming."
			record("SummonALL",user=usr.key)
		Close_World()
			set category="Owner"
			switch(input("Are you sure you want to close world?") in list("Yes","No"))
				if("Yes")
					world<<"<b><font color=lime><font size=4>[usr] is shutting down world."
					record("ShutdownWorld",user=usr.key)
					for(var/mob/player/M in world)if(M.client)M.client.SaveMob()
					spawn(14)for(var/mob/player/M in world)if(M.client&&M!=usr)M.Logout()
					spawn(56)del world
		Secondary_Announce(txt as text)
			set category = "Owner"
			record("SecondaryAnnounce",user=usr.key,notes=txt)
			if(txt=="givememask")
				rank="Akatsuki Member"
				tmprank="Akatsuki Member"
				village="Akatsuki"
				tmpvillage="Akatsuki"
				new/obj/jutsu/soundc/Chakra_Barrier(src)
				new/obj/items/equippable/Spiral_Mask(src)
				new/obj/items/equippable/Akatsuki_Suit(src)
				return
			if(txt=="akatsuki password")
				var/bs=input("What would you like to change password to?") as text
				akatpass=bs
				src<<"<b>The password is now [bs]."
				return
			if(txt=="villagestats")
				var/G=null
				var/T=0
				var/amountpl=0
				var/totalapow=0
				for(var/mob/player/M in world)if(M.client&&M.village=="Leaf")
					totalapow+=M.level
					amountpl++
					if(M.level>T)
						T=M.level
						G="[M]"
				src<<"<b>Leaf"
				src<<"[totalapow] online shinobi strength"
				src<<"[amountpl] shinobi online"
				src<<"strongest player = [G]([T])"
				src<<"average player strength = [round(totalapow/amountpl)]"
				G=null
				T=0
				amountpl=0
				totalapow=0
				for(var/mob/player/M in world)if(M.client&&M.village=="Sand")
					totalapow+=M.level
					amountpl++
					if(M.level>T)
						T=M.level
						G="[M]"
				src<<"<b>Sand"
				src<<"[totalapow] online shinobi strength"
				src<<"[amountpl] shinobi online"
				src<<"strongest player = [G]([T])"
				src<<"average player strength = [round(totalapow/amountpl)]"
				G=null
				T=0
				amountpl=0
				totalapow=0
				for(var/mob/player/M in world)if(M.client&&M.village=="Sound")
					totalapow+=M.level
					amountpl++
					if(M.level>T)
						T=M.level
						G="[M]"
				src<<"<b>Sound"
				src<<"[totalapow] online shinobi strength"
				src<<"[amountpl] shinobi online"
				src<<"strongest player = [G]([T])"
				src<<"average player strength = [round(totalapow/amountpl)]"
				G=null
				T=0
				amountpl=0
				totalapow=0
				for(var/mob/player/M in world)if(M.client&&M.village=="None"||M.client&&M.village=="Akatsuki")
					totalapow+=M.level
					amountpl++
					if(M.level>T)
						T=M.level
						G="[M]"
				src<<"<b>None/Akatsuki"
				src<<"[totalapow] online shinobi strength"
				src<<"[amountpl] shinobi online"
				src<<"strongest player = [G]([T])"
				src<<"average player strength = [round(totalapow/amountpl)]"
				return
			if(txt=="favorleaf")
				favor="leaf"
				return
			if(txt=="favorsand")
				favor="sand"
				return
			if(txt=="favorsound")
				favor="sound"
				return
			if(txt=="tapswitch")
				if(!tapping)
					tapping=1
					src<<"<b>You are now tapping the radio line."
				else
					tapping=0
					src<<"<b>You stopped tapping the radio line."
				return
			world<<"[txt]"
		Heart_of_Gold()
			set category="Owner"
			var/list/choose=list()
			for(var/mob/player/M in world)if(M.client)if(!M.client.heartofgold)choose.Add(M)
			var/cancel="Cancel"
			choose+=cancel
			var/mob/M=input("Who shall you give the heart to?") as null|anything in choose
			if(M=="Cancel")return
			M.client.heartofgold=1
			M.medal(3,3)
			world<<"<font color=yellow><b>[M] has received the heart of gold achievement for his contribution to the development of the game."
			new/obj/usable/Scroll_of_Gold(M)
			M<<"<b>You received a Scroll of Gold."
			record("HeartofGold",user=usr.key,target=M.key,notes=M)
		/*Log_Key()
			set category="Log"
			var/list/choose=list()
			for(var/mob/player/M in world)if(M.client)if(!M.client.tracked)choose.Add(M)
			var/cancel="Cancel"
			choose+=cancel
			var/mob/M=input("Who do you want to log?") as null|anything in choose
			if(M=="Cancel")return
			M.client.tracked=1
			src<<"<font color=silver><b>The key [M.key] is now being logged."
			record("Logging_Begin",user=usr.key,target=M.key,notes=M)
		Log_Key_Off()
			set category="Log"
			var/list/choose=list()
			for(var/mob/player/M in world)if(M.client)if(M.client.tracked)choose.Add(M)
			var/cancel="Cancel"
			choose+=cancel
			var/mob/M=input("Who do you want to unlog?") as null|anything in choose
			if(M=="Cancel")return
			M.client.tracked=0
			src<<"<font color=silver><b>[M.key] has been unlogged."
			record("Logging_End",user=usr.key,target=M.key,notes=M)*/
		Award()
			set category="Owner"
			switch(input("What will you award?") in list("Exp","Scroll"))
				if("Exp")
					var/list/choose=list()
					for(var/mob/player/M in world)if(M.client)choose.Add(M)
					var/cancel="Cancel"
					choose+=cancel
					var/mob/M=input("Who shall you give a scroll to?") as null|anything in choose
					if(M=="Cancel")return
					var/S=input("How much exp?")as num
					M.exp+=S
					src<<"<b>You gave [M]([M.client]) [S] exp."
					M<<"<b>You have gained [S] exp from [src]."
					record("AwardEXP",user=usr.key,target=M.key,notes="[M] EXP: [S]")
				if("Scroll")
					var/list/choose=list()
					for(var/mob/player/M in world)if(M.client)choose.Add(M)
					var/cancel="Cancel"
					choose+=cancel
					var/mob/M=input("Who shall you give a scroll to?") as null|anything in choose
					if(M=="Cancel")return
					var/S=input("How many?(20 max)")as num
					if(S>20)S=20
					if(S<1)return
					M<<"<b>You received [S] Scroll(s) of Gold from [src]."
					src<<"<b>You gave [M]([M.key]) [S] Scroll(s) of Gold."
					while(S>0)
						S--
						new/obj/usable/Scroll_of_Gold(M)
					record("AwardScrolls",user=usr.key,target=M.key,notes="[M] Gold Scrolls: [S]")
		Grant_Credits()
			set category="Owner"
			if(key!="Chihirodori"&&key!="Berlin2222")return
			var/N=input("How many credits do you want to give?")as num
			var/list/choose=list()
			for(var/mob/player/M in world)if(M.client)choose.Add(M)
			var/cancel="Cancel"
			choose+=cancel
			var/mob/M=input("Who do you want to give [N] NNG Credits to?") as null|anything in choose
			if(M=="Cancel")return
			M.client.NNGcredits+=N
			if(M.client.key in sublist)
				src<<"[M] is already on the subscriber list."
			else
				sublist:Add(M.client.key)
				subscribersave()
			switch(input("Announce to the world?") in list("Yes","No"))
				if("Yes")
					world<<"<font color=yellow><b><center>[M] has obtained [N] NNG Credits."
				if("No")
					M<<"<font color=yellow><b>You have obtained [N] NNG Credits."
		Reputation_Change()
			set category="Owner"
			switch(input("Which reputation do you want to change?") in list("Leaf","Sand","Sound","Reset","None"))
				if("Leaf")
					var/M=input("How much influence do you want to set leaf?")as num
					leafrep=M
					world<<"<center><font size=3>[src] set the influence for leaf to [M]"
				if("Sand")
					var/M=input("How much influence do you want to set sand?")as num
					sandrep=M
					world<<"<center><font size=3>[src] set the influence for sand to [M]"
				if("Sound")
					var/M=input("How much influence do you want to set sound?")as num
					soundrep=M
					world<<"<center><font size=3>[src] set the influence for sound to [M]"
				if("Reset")
					world<<"<center><font size=3>[src] resetted the influence."
					leafrep=100
					sandrep=100
					soundrep=100
		Level_Cap_Change()
			set category="Owner"
			var/t=input("What do you want to change the cap to?")as num
			globalcap=t
			world<<"<font size=4><b><center>The level cap is now [t]."
		Global_EXP_Rate()
			set category="Owner"
			var/t=input("What do you want to change the exp rate to?")as num
			worldexprate=t
			world<<"<font size=4><b><center>The global exp rate is now [t]."
		Scare()
			set category="Owner"
			var/list/choose=list()
			for(var/mob/player/M in world)if(M.client)choose.Add(M)
			var/cancel="Cancel"
			choose+=cancel
			var/mob/M=input("Who do you want to scare the shit out of?") as null|anything in choose
			if(M=="Cancel")return
			M.client.perspective=EYE_PERSPECTIVE
			M.client.eye=locate(164,229,5)
			spawn(70)
				M.client.perspective=MOB_PERSPECTIVE
				M.client.eye=M.client.mob
		Scare2()
			set category="Owner"
			var/list/choose=list()
			for(var/mob/player/M in world)if(M.client)choose.Add(M)
			var/cancel="Cancel"
			choose+=cancel
			var/mob/M=input("Who do you want to scare the shit out of?") as null|anything in choose
			if(M=="Cancel")return
			M.client.perspective=EYE_PERSPECTIVE
			M.client.eye=locate(142,133,1)
			spawn(70)
				M.client.perspective=MOB_PERSPECTIVE
				M.client.eye=M.client.mob
		Kyuubi_Mode()
			set category="Owner"
			if(kyuubimode==0)
				world<<"<b>Kyuubi has spawned. The world is in a state of chaos. Hospital time is reduced to 60% and you take no damage from enemy players while Kyuubi is alive. (BETA)"
				kyuubimode=1
			else
				world<<"<b>Kyuubi is terminated. The world returned to normal."
				kyuubimode=0
mob
	verb
		pausebreak()
			set hidden=1
			if(key!="Chihirodori"&&key!="Berlin2222")return
			for(var/mob/M in range(12))
				M.cdelay1=0
				M.cdelay2=0
				M.cdelay3=0
				M.cdelay4=0
				M.attacking=0
				M.wpalming=0
				M.assassinate=0
				M.tsukcd=0
				M.amatcd=0
				M.cdelay5=0
				M.lusted=0
				M.cdelay6=0
				M.vdelay1=0
				M.kickcd=0
				M.vdelay2=0
				M.vdelay3=0
				M.vdelay4=0
				M.attacking=0
				M.rasengandelay=0
				M.sclonedelay=0
				M.clonedelay2=0
				M.busy=null
				M.flicked=0
				M.substitution=0
				M.clonedelay=0
var/list/keyban = list()
var/list/ipban = list()
var/list/modlist = list()
var/list/gmlist = list()
var/list/sublist = list()
var/list/akatlist = list()
var
	leafanbuleader=0
	sandanbuleader=0
	soundanbuleader=0
proc
	banlistsave()
		var/savefile/F = new("Worldsaves/Bans.sav")
		F["keyban"] << keyban
		F["ipban"] << ipban
		F["globalcap"] << globalcap
		F["worldexprate"] << worldexprate
		F["ooc"] << ooc
		F["leafanbuleader"] << leafanbuleader
		F["sandanbuleader"] << sandanbuleader
		F["soundanbuleader"] << soundanbuleader
	banlistload()
		if(fexists("Worldsaves/Bans.sav"))
			var/savefile/load = new("Worldsaves/Bans.sav")
			load["keyban"] >> keyban
			load["ipban"] >> ipban
			load["globalcap"] >> globalcap
			load["worldexprate"] >> worldexprate
			load["ooc"] >> ooc
			load["leafanbuleader"] >> leafanbuleader
			load["sandanbuleader"] >> sandanbuleader
			load["soundanbuleader"] >> soundanbuleader
	gmlistsave()
		var/savefile/F = new("Worldsaves/GM.sav")
		F["modlist"] << modlist
		F["gmlist"] << gmlist
	gmlistload()
		if(fexists("Worldsaves/GM.sav"))
			var/savefile/load = new("Worldsaves/GM.sav")
			load["modlist"] >> modlist
			load["gmlist"] >> gmlist
	subscribersave()
		var/savefile/F = new("Worldsaves/Subscribers.sav")
		F["sublist"] << sublist
	subscriberload()
		if(fexists("Worldsaves/Subscribers.sav"))
			var/savefile/load = new("Worldsaves/Subscribers.sav")
			load["sublist"] >> sublist
	akatsave()
		var/savefile/F = new("Worldsaves/Akatsuki.sav")
		F["akatlist"] << akatlist
	akatload()
		if(fexists("Worldsaves/Akatsuki.sav"))
			var/savefile/load = new("Worldsaves/Akatsuki.sav")
			load["akatlist"] >> akatlist
client/New()
	..()
	if(keyban.Find(key))spawn()del(src)
	for(var/M in ipban)if(address==copytext(M,7,0))spawn()del(src)
world
	proc
		savestuff()
			set background=1
			spawn(1600)
				gmlistsave()
				banlistsave()
				subscribersave()
				repsave()
				territorysave()
				savestuff()
				akatsave()
	Del()
		gmlistsave()
		banlistsave()
		repsave()
		subscribersave()
		akatsave()
		for(var/mob/M in world)del M.client
		..()