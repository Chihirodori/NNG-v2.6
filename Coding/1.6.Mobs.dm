mob
	layer=4
	invisibility=1
	see_invisible=1
	var
		notooc = 1
	Move()
		if(loc == null)
			del src
			return
		..()
		barloc()
	charzom
		icon='base.dmi'
		npc=2
		mouse_opacity=0
		freeze=1
		slot1
			pixel_x=-10
			New()
				..()
				loginbase1=src
		slot2
			pixel_x=-5
			New()
				..()
				loginbase2=src
		slot3
			New()
				..()
				loginbase3=src
		slot4
			pixel_x=5
			New()
				..()
				loginbase4=src
		slot5
			pixel_x=10
			New()
				..()
				loginbase5=src
		New()
			..()
			icon=null
	var/clickedplayer=0
	Click()
		..()
		if(name=="Tree"||name=="Scarecrow"||name=="Banner"||name=="Cactus"||name=="Dummy")return
		if(istype(src,/mob/player))goto skip
		if(usr.clickedplayer)return
		usr.clickedplayer=1
		spawn(70)if(usr)usr.clickedplayer=0
		usr<<"-----------------------------------"
		usr<<"<b>[src]"
		if(!isanimal)usr<<"A [rank] of the [clan] clan from the [village] village."
		usr<<"Level: [level]"
		usr<<"Village: [village]"
		usr<<"Rank: [rank]"
		usr<<"-----------------------------------"
		skip
	Del()
		if(mybar)del mybar
		if(mybar2)del mybar2
		..()
	player
		animate_movement=2
		icon='base.dmi'
		Login()
			while(!initialized)sleep(34)
			if(client)
				client.view=10
				name=savedname
				if(rank=="Hokage")world<<"<B><font color=silver>The Hokage is now online."
				if(rank=="Kazekage")world<<"<B><font color=silver>The Kazekage is now online."
				if(rank=="Sound Leader")world<<"<B><font color=silver>The Sound Leader is now online."
				if(key=="Chihirodori")//CONFIG: put your key here to get Owner privileges. You should also do a Find and Replace of my key with your key.
					verbs+=typesof(/mob/Owner/verb)
					verbs+=typesof(/mob/Admin/verb)
					verbs+=typesof(/mob/GM/verb)
					verbs+=typesof(/mob/HeadGM/verb)
					verbs+=typesof(/mob/Mod/verb)
					record("Login",user=usr.key,notes=client.address)
					GM=3
					status = "Owner"
					overlays += /obj/GM/Owner
					world<<"<font color=red><B>Info:<font color=silver> [usr.status] [usr] has logged on the server."
				if(gmlist.Find(client.key))spawn()
					GM=2
					verbs+=typesof(/mob/GM/verb)
					verbs+=typesof(/mob/Mod/verb)
					if(key=="")verbs+=typesof(/mob/HeadGM/verb)
					overlays+=/obj/GM/GM
					status="Game Master"
					record("Login",user=usr.key,notes=client.address)
					world<<"<font color=red><B>Info:<font color=silver> [usr.status] [usr] has logged on the server."
				if(modlist.Find(client.key))spawn()
					GM=1
					status="Enforcer"
					verbs+=typesof(/mob/Mod/verb)
					overlays+=/obj/GM/Mod
					record("Login",user=usr.key,notes=client.address)
					world<<"<font color=red><B>Info:<font color=silver> [usr.status] [usr] has logged on the server."
				if(client.tracked)
					record("Login",user=usr.key,notes=client.address)
				tmpstatus=status
				spawn()timer()
				spawn()setUpMenus()
				if(!henge)
					overlay()
					iconrefresh()
				tmpclan=clan
				tmpvillage=village
				tmprank=rank
				if(weights)
					specmove=1
				if(haircutting)
					loc=savedloc
					haircutting=0
				if(jailtime)spawn()jailtime()
				if(hosptime)
					if(village=="None")spawn()hospjailtime()
					else spawn()hosptime()
				//if(rank=="Academy Student"||rank=="Genin")rank="Chunin"
				if(repdelay==null)repdelay=0
				if(repdelay>0&&GM<3)repdelay()
				if(mask==/obj/spiralmask&&GM==3)density=0
				if(muted)spawn()muteproc()
				if(rank=="Hokage"||rank=="Kazekage"||rank=="Sound Leader")
					verbs+=typesof(/mob/Kage/verb)
					verbs+=typesof(/mob/Kage2/verb)
					if(rank=="Hokage")for(var/mob/player/M in world)if(M.rank=="ANBU Leader"&&M.village=="Leaf")M.verbs-=typesof(/mob/Kage/verb)
					if(rank=="Kazekage")for(var/mob/player/M in world)if(M.rank=="ANBU Leader"&&M.village=="Sand")M.verbs-=typesof(/mob/Kage/verb)
					if(rank=="Sound Leader")for(var/mob/player/M in world)if(M.rank=="ANBU Leader"&&M.village=="Sound")M.verbs-=typesof(/mob/Kage/verb)
				if(rank=="ANBU Leader")
					var/T=0
					if(village=="Leaf")for(var/mob/player/M in world)if(M.rank=="Hokage")T=1
					if(village=="Sand")for(var/mob/player/M in world)if(M.rank=="Kazekage")T=1
					if(village=="Sound")for(var/mob/player/M in world)if(M.rank=="Sound Leader")T=1
					if(!T)verbs+=typesof(/mob/Kage/verb)
				if(squadrank=="Squad Leader")
					verbs+=typesof(/mob/squad/leader/verb)
					verbs+=typesof(/mob/squad/member/verb)
				if(squadrank=="Squad Member")verbs+=typesof(/mob/squad/member/verb)
				if(!insquad)verbs+=typesof(/mob/squad/nothing/verb)
				if(loc==null||ingenin)
					usr.summonspawn()
				if(blind)blindrefresh()
				affcheck()
				winset(src, "default.exp", "is-visible=true")
				winset(src, "default.level", "is-visible=true")
				winset(src, "default.cha", "is-visible=true")
				winset(src, "default.hp", "is-visible=true")
				winset(src, "default.input1", "pos=32,645")
				refreshword()
				spawn()rundown()
				if(intourney)
					verbs += typesof(/mob/Tournament/verb)
				pkkills()
				barloc()
				if(!id)idproc()
				spawn(50)goldenaging()
				if(!clearcap)clearcap=30000000
				if(!mangtype&&clan=="Uchiha")
					mangtype=pick(/obj/mangekyousharingan/t1,/obj/mangekyousharingan/t2,/obj/mangekyousharingan/t3,/obj/mangekyousharingan/t4)
				if(updated<15)
					updated=18
					restart()
					return
				if(updated<18)
					updated=18
					new/obj/usable/Scroll_of_Secrets(src)
					src<<"<b>You have received a scroll of secrets for being a loyal player."
					if(client.heartofgold)
						new/obj/usable/Scroll_of_Gold(src)
						src<<"<b><font color=yellow>You have received a scroll of gold for being a benefactor."
				if(npc==4)
					icon='dog.dmi'
				mouseovername()
				statset()
				if(weapon==/obj/kusanagi)
					kusan=1
					relentless=1
					relentless(0)
				if(mission=="Defeat Bandits (C Rank)")weedpick=0
				if(clan=="Snake"&&level>=28)
					amatcd=1
					var/sdelay=2520-tier53*28
					for(var/obj/jutsu/snake/Immortality_Jutsu/Ms in src)timerjutsu(sdelay,Ms)
					spawn(sdelay)
						amatcd=0
				if(clan=="Uchiha"&&tier63)
					lusted=1
					for(var/obj/jutsu/uchiha/Vengeance/Ms in src)timerjutsu(2520,Ms)
					spawn(2520)
						lusted=0
				if(clan=="Taijutsu Specialist")icon_name='base.dmi'
				if(x>422&&y<44&&z==2||x<79&&y>454&&z==2||x>425&&y>462&&z==2)summonspawn()
				didyouknow()
				src<<"<b><u><font color=silver><big><center>Announcement!"
				src<<"<b><font color=silver><center>Hello, and welcome back. This is the 2015 version of NNG. Invite your friends and enjoy!"
				src<<"<b><font color=silver><center>~Dante"
				var/G=0
				for(var/obj/ryo/D in src)G=1
				if(!G)
					new/obj/ryo(src)
					ryorefresh()
				if(sublist.Find(client.key))
					subscriber=1
					switch(input("Thank you for purchasing one of the credits packages! Would you like your status to be set to Subscriber?") in list("Yes","No"))
						if("Yes")
							status="Subscriber"
							alert(src,"Okay. You have +5% training speed and you can talk with other Subscribers in a private chat(hot keyed to =).")
						if("No")
							alert(src,"Okay. You have +5% training speed and you can talk with other Subscribers in a private chat(hot keyed to =).")
				if(akatlist.Find(name))
					if(rank=="Akatsuki Leader")
						verbs+=typesof(/mob/Akatsuki/verb)
						world<<"<B><font color=silver>The Akatsuki Leader is now online."
					else
						verbs+=typesof(/mob/AkatsukiM/verb)
				else
					if(village=="Akatsuki")
						village="None"
						tmpvillage="None"
						missingrank()
						mouseovername()
						for(var/obj/items/equippable/Pein_Ring/M in src)del M
						for(var/obj/items/equippable/Oro_Ring/M in src)del M
						for(var/obj/items/equippable/Kakazu_Ring/M in src)del M
						for(var/obj/items/equippable/Itachi_Ring/M in src)del M
						for(var/obj/items/equippable/Kisame_Ring/M in src)del M
						for(var/obj/jutsu/Akatsuki_Summon/M in src)del M
						for(var/obj/items/equippable/Akatsuki_Suit/M in src)
							overlays -= M
							del M
						src<<"<b>You have been removed from the Akatsuki."
			..()
		New()
			spawn()
				regen()
				updatechar()
				if(clan=="Kaguya")kagregen()
			..()
		MouseEntered()
			if(tmpvillage=="Leaf")mouse_over_pointer='cursorleaf.dmi'
			if(tmpvillage=="Sand")mouse_over_pointer='cursorsand.dmi'
			if(tmpvillage=="Sound")mouse_over_pointer='cursorsound.dmi'
			if(tmpvillage=="None")mouse_over_pointer='cursormiss.dmi'
			if(tmpvillage=="Akatsuki")mouse_over_pointer='cursorakat.dmi'
			for(var/obj/Max_Obj_Letters in src.Max_Name)
				var/image/Max_Image = image(Max_Obj_Letters,src)
				usr.client.images += Max_Image
				spawn(usr.Max_Wait_Time)if(usr)if(usr.client)usr.client.images -= Max_Image
		Click()
			..()
			if(name=="Tree"||name=="Scarecrow"||name=="Banner"||name=="Cactus"||name=="Dummy")return
			if(usr.clickedplayer)return
			usr.clickedplayer=1
			spawn(70)if(usr)usr.clickedplayer=0
			usr<<"-----------------------------------"
			usr<<"<b>[src]"
			usr<<"A [tmprank] of the [tmpclan] clan from the [tmpvillage] village."
			usr<<"Status: [tmpstatus]"
			if(bountyhead)usr<<"Bounty: [realnum(bountyhead)] Ryo"
			usr<<"-----------------------------------"
			if(reputation<=-10)usr<<"Reputation: <font color=red>[reputation]"
			if(reputation>-10&&reputation<10)usr<<"Reputation: [reputation]"
			if(reputation>=10)usr<<"Reputation: <font color=lime>[reputation]"
			usr<<"-----------------------------------"
			usr<<"Kills: [kills]"
			usr<<"Deaths: [deaths]"
			usr<<"Total Bounty Collected: [realnum(maxbounty)] Ryo"
			usr<<"Village Influence Contribution: [repcontribute]%"
			usr<<"Banners Captured: [flagcapture]"
			usr<<"-----------------------------------"
			var/T=usr.level-level
			switch(T)
				if(40 to 200)usr<<"Killing him would be dishonorable."
				if(25 to 39)usr<<"He is far weaker than you."
				if(15 to 24)usr<<"He is weaker than you."
				if(5 to 14)usr<<"He is slightly weaker than you."
				if(-4 to 4)usr<<"He is about the same strength as you."
				if(-14 to -5)usr<<"He is slightly stronger than you."
				if(-15 to -24)usr<<"He is stronger than you."
				if(-25 to -39)usr<<"He is far stronger than you."
				else usr<<"Do not try to fight him."
			if(usr.GM)
				usr<<"Name: [name]"
				usr<<"Key: [key]"
				usr<<"Player ID: [id]"
				usr<<"IP: [client.address]"
				usr<<"Level: [level]"
				usr<<"Stamina. [Sta]([staexp]/[staexpm])"
				usr<<"Intelligence: [Int]([intexp]/[intexpm])"
				usr<<"Handseals: [Hsl]([hslexp]/[hslexpm])"
				usr<<"Strength: [Str]([apowexp]/[apowexpm])"
				usr<<"Taijutsu: [Tai]([taiexp]/[taiexpm])"
				usr<<"Ninjutsu: [Nin]([ninexp]/[ninexpm])"
				usr<<"Speed: [Spd]([spdexp]/[spdexpm])"
				usr<<"Senryo: [realnum(senryo)]"
				usr<<"Melee Damage: [atkstr]%"
				usr<<"Jutsu Damage: [atk]%"
				usr<<"Defense: [def]%"
				//usr<<"KarmA. [karma]"
				usr<<"Banners Captured: [flagcapture]"
			usr<<"Age: [client.hours] hr, [client.minutes] min, [client.seconds] sec - [client.days] d, [client.weeks] wk"
			usr<<"-----------------------------------"
		Bump(Q)
			..()
			if(running)
				icon_state=null
				runstep=0
				running=0
			if(imitation||imitated)
				if(istype(Q,/mob/Clone))
					loc=Q:loc
				else
					shadowoff()
		Bump(mob/A)
			..()
			if(ismob(A))
				if(A.henge&&A.aff!=aff)A.hengeback()
				if(A.cloaking&&A.aff!=aff)A.cloakoff()
				if(istype(A,/mob/player))
					if(intut||!initialized)
						var/D=A.loc
						A.loc=loc
						loc=D
						barloc()
						A.barloc()
				if(istype(A,/mob/edo))
					if(A.edoowner==src)
						var/D=A.loc
						A.loc=loc
						loc=D
						barloc()
						A.barloc()
				if(istype(A,/mob/Clone))
					if(A.cloneowner==src)
						var/D=A.loc
						A.loc=loc
						loc=D
						barloc()
						A.barloc()
				switch(busy)
					if("mirroring")
						if(aff==A.aff)
							loc=A.loc
							return
						freeze=1
						new/obj/mirrorbreak(loc)
						target=A
						invisibility+=20
						density=0
						busy="mirror"
						if(mybar)mybar:updatebar()
						if(mybar2)mybar2:updatebar()
						var/checka=30
						if(level>=85)checka=50
						spawn(checka)
							if(busy=="mirror")
								freeze--
								invisibility-=20
								density=1
								busy=null
								if(mybar)mybar:updatebar()
								if(mybar)mybar2:updatebar()
						var/T=new/obj/hakumirror(locate(x,y-5,z))
						var/T2=new/obj/hakumirror(locate(x-2,y-5,z))
						var/T3=new/obj/hakumirror(locate(x+2,y-5,z))
						var/T4=new/obj/hakumirror(locate(x+3,y-4,z))
						var/T5=new/obj/hakumirror(locate(x-3,y-4,z))
						var/T6=new/obj/hakumirror(locate(x+4,y-3,z))
						var/T7=new/obj/hakumirror(locate(x-4,y-3,z))
						var/T8=new/obj/hakumirror(locate(x+5,y-2,z))
						var/T9=new/obj/hakumirror(locate(x-5,y-2,z))
						var/T10=new/obj/hakumirror(locate(x+5,y,z))
						var/T11=new/obj/hakumirror(locate(x-5,y,z))
						var/T12=new/obj/hakumirror(locate(x+5,y+2,z))
						var/T13=new/obj/hakumirror(locate(x-5,y+2,z))
						var/T14=new/obj/hakumirror(locate(x+4,y+3,z))
						var/T15=new/obj/hakumirror(locate(x-4,y+3,z))
						var/T16=new/obj/hakumirror(locate(x+3,y+4,z))
						var/T17=new/obj/hakumirror(locate(x-3,y+4,z))
						var/T18=new/obj/hakumirror(locate(x,y+5,z))
						var/T19=new/obj/hakumirror(locate(x+2,y+5,z))
						var/T20=new/obj/hakumirror(locate(x-2,y+5,z))
						T:dir=NORTH
						T2:dir=NORTH
						T3:dir=NORTH
						T4:dir=NORTHWEST
						T5:dir=NORTHEAST
						T6:dir=NORTHWEST
						T7:dir=NORTHEAST
						T8:dir=WEST
						T9:dir=EAST
						T10:dir=WEST
						T11:dir=EAST
						T12:dir=WEST
						T13:dir=EAST
						T14:dir=SOUTHWEST
						T15:dir=SOUTHEAST
						T16:dir=SOUTHWEST
						T17:dir=SOUTHEAST
						T18:dir=SOUTH
						T19:dir=SOUTH
						T20:dir=SOUTH
						T:owner=src
						T2:owner=src
						T3:owner=src
						T4:owner=src
						T5:owner=src
						T6:owner=src
						T7:owner=src
						T8:owner=src
						T9:owner=src
						T10:owner=src
						T11:owner=src
						T12:owner=src
						T13:owner=src
						T14:owner=src
						T15:owner=src
						T16:owner=src
						T17:owner=src
						T18:owner=src
						T19:owner=src
						T20:owner=src
						for(var/mob/M in range(4))
							if(aff==M.aff)continue
							M.snared(checka,5+tier41*2)
						for(var/obj/hakumirror/M in oview(5))
							if(M:owner==src)
								M:mirrorproc()
					if("rising wind")
						if(aff==A.aff)
							loc=A.loc
							return
						if(A.illusion)
							A.illusionhit(src)
							return
						if(tier63&&A.hp<A.maxhp*(0.05*tier63))
							view(12)<<"<b><center><font color=silver>[src] executed [A] with Rising Wind!"
							A.damage(A.hp)
							A.death(src)
							return
						if(level>=9)
							if(istype(A,/mob/player))
								if(strongfist==A)
									if(crippled=="")
										strongfistc++
										relentless(1)
										if(strongfistc==3)
											strongfistc=0
											relentless(-3)
											crippled(A)
								else
									strongfistc=1
									relentless(0,1)
									strongfist=A
						var/damage=round(apow*0.7)
						if(level>=60)damage*=1.1
						if(A.clan=="Taijutsu Specialist")
							if(A.tier32)damage*=1-(A.tier32*0.05)
						A.dmgch(src,1)
						damage=(damage*A.variable)+A.variable2
						critroll(A)
						var/random = rand(1, 100)
						if(criticalroll >= random)
							A.damage(damage, 1.4)
						else
							A.damage(damage)
						flick("rising wind",src)
						faceme(A)
						A.goup(src)
						spawn(6)
							if(A)
								A.death(src)
						busy=null
						icon_state=""
					if("lotushit")
						if(aff==A.aff)
							loc=A.loc
							return
						lotushit = 1
						busy=null
						icon_state=""
						for(var/obj/bandage/M in world)if(M.owner==src)del M
						for(var/obj/bandagetrail/M in world)if(M.owner==src)del M
						flick("rising wind",src)
						faceme(A)
						A.lotusup(src)
					if("hiddenlotus")
						if(aff==A.aff)
							loc=A.loc
							return
						if(A.illusion)
							A.illusionhit(src)
							return
						busy=null
						icon_state=""
						hiddenlotuss(A)
					if("raikiri")
						if(aff==A.aff)
							loc=A.loc
							return
						if(A.illusion)
							A.illusionhit(src)
							return
						new/obj/crater(A.loc)
						var/damage
						if(apow>pow)
							damage=round(apow*1.4)
							if(A.clan=="Taijutsu Specialist")
								if(A.tier32)damage*=1-(A.tier32*0.05)
							A.dmgch(src,1)
						else
							damage=round(pow*1.4)
							A.dmgch(src)
						if(tier43)damage*=1+(tier43*0.10)
						if(level>=52)damage*=1.1
						damage=(damage*A.variable)+A.variable2
						var/critchance=0+(tier43*5)
						if(prob(critchance))
							A.damage(damage,1.3)
						else
							A.damage(damage)
						faceme(A)
						A.stepback(6,1)
						spawn(6)
							if(A)
								if(level>=120)A.snared(10,1)
								A.death(src)
						busy=null
						icon_state=""
						overlays-=/obj/chidori
					if("chidori")
						if(aff==A.aff)
							loc=A.loc
							return
						if(A.illusion)
							A.illusionhit(src)
							return
						busy=null
						new/obj/crater(A.loc)
						var/damage=round(pow*1.8)
						if(level>=120)damage*=1.2
						if(tier23)damage+=(A.maxhp-A.hp)*0.04*tier23
						A.dmgch(src)
						damage=(damage*A.variable)+A.variable2
						A.damage(damage,1)
						new/obj/crater(A.loc)
						faceme(A)
						soundeff('mountain.wav',40,0)
						A.stepback(4,1)
						stepback(3)
						spawn(7)if(A)A.death(src)
						stun=0
						icon_state=""
						overlays-=/obj/chidori
					if("drill")
						if(aff == A.aff)
							loc = A.loc
							return
						if(A.illusion)
							A.illusionhit(src)
							return
						var/damage = usr.apow*1.1
						if(level>=75 && A.hp < A.maxhp*0.65)
							damage = apow*1.5
						if(level>=110 && A.hp < A.maxhp*0.35)
							damage= apow*2
						if(A.clan=="Taijutsu Specialist")
							if(A.tier32)damage*=1-(A.tier32*0.05)
						A.dmgch(src,1)
						damage=(damage*A.variable)+A.variable
						critroll(A)
						soundeff('mountain.wav',40,0)
						A.damage(damage,1)
						loc = A.loc
						A.death(src)
						busy = null
						icon_state=""
						stepup(1)
						if(tier13&&A)
							new/obj/statuspop/cleave(A.loc)
							spawn()if(!A.kagcleave)A.bleedingkag(src)
					if("rasenganhit")
						if(aff==A.aff)
							loc=A.loc
							return
						if(A.illusion)
							A.illusionhit(src)
							return
						new/obj/crater(A.loc)
						var/J=0
						if(apow>=20)J++
						if(apow>=40)J++
						if(apow>=60)J++
						if(apow>=80)J++
						var/damage=round(apow*1.5)
						if(A.clan=="Taijutsu Specialist")
							if(A.tier32)damage*=1-(A.tier32*0.05)
						A.dmgch(src,1)
						damage=(damage*A.variable)+A.variable2
						A.damage(damage)
						faceme(A)
						A.stepback(1+J,1)
						sleep(5)
						A.death(src)
		Stat()
			statpanel("Main")
			if(statpanel("Main"))
				stat("-----------------------------------")
				stat("[src]")
				stat("Rank: [tmprank]")
				stat("Status: [tmpstatus]")
				if(village=="Leaf")stat("Village Priority: [leafpriority]")
				if(village=="Sand")stat("Village Priority: [sandpriority]")
				if(village=="Sound")stat("Village Priority: [soundpriority]")
				stat("-----------------------------------")
				stat("Kills: [kills]")
				stat("Deaths: [deaths]")
				stat("-----------------------------------")
				stat("Banners Captured: [flagcapture]")
				stat("-----------------------------------")
				//stat("KarmA. [karma]")
				stat("Reputation: [reputation]")
				stat("Acheivement Points: [AP]")
				stat("-----------------------------------")
				stat("Bounty: [realnum(bountyhead*usr.bountytimes)]")
				stat("Collectable Bounty: [realnum(bountyget)]")
				stat("Total Bounty Collected: [realnum(maxbounty)]")
				stat("Character Age: [client.hours] hours, [client.minutes] minutes and [client.seconds] seconds - [client.days] days, [client.weeks] weeks")
				stat("Village Influence Contribution: [repcontribute]%")
				stat("-----------------------------------")

			statpanel("Stats")
			if(statpanel("Stats"))
				stat("-----------------------------------")
				stat("Melee Damage: [atkstr]%")
				stat("Jutsu Damage: [atk]%")
				stat("Defense: [def]%")
				if(host1eff)stat("Body Host Quality #1: [host1eff]%")
				if(host2eff)stat("Body Host Quality #2: [host2eff]%")
				if(host3eff)stat("Body Host Quality #3: [host3eff]%")
				stat("-----------------------------------")
				stat("Strength: [Str]([round(apowexp)]/[apowexpm])")
				stat("Stamina. [Sta]([round(staexp)]/[staexpm])")
				stat("Handseals: [Hsl]([round(hslexp)]/[hslexpm])")
				stat("Ninjutsu: [Nin]([round(ninexp)]/[ninexpm])")
				stat("Taijutsu: [Tai]([round(taiexp)]/[taiexpm])")
				stat("Speed: [Spd]([round(spdexp)]/[spdexpm])")
				stat("Intelligence: [Int]([round(intexp)]/[intexpm])")
				stat("-----------------------------------")
				stat("Maximum HP: [maxhp]")
				stat("Maximum Chakra. [maxcha]")
				stat("HP Regen: [regenhp]")
				stat("Energy Regen: [regene]")
				stat("Chakra Regen: [regencha]")
				stat("Chakra Control: [con]")
				stat("Handseal Speed: [round(handseals,0.1)](+[hsp]%)")
				stat("Attack Power: [apow]")
				stat("Ninjutsu Power: [pow]")
				stat("Critical Strike Rate: [critrate]%")
				stat("Critical Strike Defense: [critdef]%")
				stat("Melee Accuracy: [accuracy]%")
				stat("Dodge: [dodge]%")
				stat("Attack Speed: [attackdelay]%")
				stat("Ninjutsu Cooldown: [round(cdpow,0.1)]%")
				stat("Taijutsu Cooldown: [round(cdapow,0.1)]%")
				stat("Run Speed: Rank [rundelay]")
				stat("Throwing Speed: Level [projspeed]")
				stat("Proficiency: [proficiency]")
				var/tspeed=trainingspeed
				if(rank=="Hokage"||rank=="Kazekage"||rank=="Sound Leader")tspeed-=40
				if(sharingan>=2)tspeed+=10
				if(village=="Akatsuki"&&akatpriority=="Training"||village=="Leaf"&&leafpriority=="Training"||village=="Sand"&&sandpriority=="Training"||village=="Sound"&&soundpriority=="Training")tspeed+=20
				if(goldenage==lowertext("[village]"))tspeed*=1.5
				stat("Training Speed: [round(tspeed)]([trainingspeed])")
				stat("Business Skill: [ryomulti]%")
				stat("Genjutsu Resistance: [genresist]")
				stat("-----------------------------------")
				stat("Strength: +4 health, +1.5 attack power")
				stat("Stamina. +15 health, +0.2 energy regen per second, +0.4 health per second")
				stat("Intelligence: +6 chakra, +0.3 chakra regen per second, +4 chakra control, -1% genjutsu cooldown, +2% training speed, +4% business skill, +1 genjutsu proficiency, +1 genjutsu resistance, +0.5% critical rate ")
				stat("Speed: learn agility jutsus, +1% critical defense, +1% critical rate, -0.5% ninjutsu cooldown, -1.2% taijutsu cooldown, +2% attack speed, +3% dodge")
				stat("Taijutsu: +6% attack speed, +3% dodge, +4% accuracy, +0.5 attack power, +1 proficiency")
				stat("Ninjutsu:  +2 ninjutsu power, +1 proficiency")
				stat("Handseals: +2 chakra control, +0.33 second handseal speed, -0.75% ninjutsu cooldown")
				stat("-----------------------------------")
			statpanel("Missions")
			if(statpanel("Missions"))
				if(mission)
					stat("-----------------------------------")
					stat("Current Mission: [mission]")
					stat("Objective: [missiond]")
				stat("-----------------------------------")
				stat("Mission Record")
				stat("")
				stat("D Rank: [mrankd]")
				stat("C Rank: [mrankc]")
				stat("B Rank: [mrankb]")
				stat("A Rank: [mranka]")
				stat("S Rank: [mranks]")
				stat("-----------------------------------")
			statpanel("War Villages")
			if(statpanel("War Villages"))
				stat("-----------------------------------")
				stat("Grass: [grassTV]")
				if(grasswar)stat("[grasswar] seconds of immunity left")
				stat("")
				stat("Rain: [rainTV]")
				if(rainwar)stat("[rainwar] seconds of immunity left")
				stat("")
				stat("Snow: [snowTV]")
				if(snowwar)stat("[snowwar] seconds of immunity left")
				stat("")
				stat("-----------------------------------")
			statpanel("Inventory")
			if(statpanel("Inventory"))
				for(var/obj/ryo/O in contents)stat(O)
				for(var/obj/usable/O in contents)stat(O)
				for(var/obj/items/O in contents)stat(O)
			if(src.GM)
				statpanel("IP")
				if(statpanel("IP"))
					stat("World IP",world.address)
					stat("World Port",world.port)
					for(var/client/C)
						stat("[C]",C.address)
			statpanel("Jutsus")
			if(statpanel("Jutsus"))for(var/obj/jutsu/O in contents)stat(O)
		Del()
			for(var/obj/bars/M in world)if(M.barowner==src)del M
			..()
	NPC
		Samurai
			name="(NPC)Samurai(Guard)"
			village="Iron"
			rank="Elite Guard"
			level=185
			Sta=60
			Hsl=1
			Tai=50
			Nin=4
			Str=50
			Int=16
			Spd=30
			hp=18000
			maxhp=18000
			regenhp=100
			apow=1060
			accuracy=585
			dodge=421
			attackdelay=3
			genresist=16
			critrate=60
			critdef=1000
			rundelay=0
			var/g
			var/r
			south/dir=SOUTH
			north/dir=NORTH
			west/dir=WEST
			east/dir=EAST
			New()
				..()
				g=loc
				r=dir
				samuraiproc()
			icon='samurai.dmi'
			New()
				hp=maxhp
				var/B1=new/obj/bars/healthbar(loc)
				B1:barowner=src
				mybar=B1
				B1:updatebar()
				aff=250000
				..()
			Bump(mob/A)
				..()
				if(ismob(A))
					if(istype(A,/mob/NPC/Samurai)||attacking)return
					var/damage=round(apow/3)+rand(30,55)
					A.damage(damage)
					flick("attack",src)
					A.death(src)
					attacking=1
					spawn(9)
					attacking=0
			proc
				samuraiproc()
					if(dead)return
					walk(src,0)
					if(aggro||target)
						for(var/mob/M in oview(16,src))
							if(M.npc==2||M.mask==/obj/spiralmask&&M.GM==3)continue
							walk_to(src,M,1)
							for(var/mob/E in oview(1,src))if(E==M)walk_towards(src,M)
							break
						spawn(7)samuraiproc()
					else
						if(loc!=g)
							new/obj/tele(loc)
							loc=g
						else dir=r
						hp=18000
						barloc()
						spawn(20)samuraiproc()
		StandNPC
			npc=2
			mouse_opacity=2
			freeze=1
			icon='NPCs.dmi'
			New()
				..()
				var/B1=new/obj/bars/healthbar(loc)
				B1:barowner=src
				B1:standnpc()
				var/B2=new/obj/bars/chakrabar(loc)
				B2:barowner=src
				B2:standnpc()
			Diana
				name="Diana(Title NPC)"
				icon_state="Diana"
				village="Mist"
				rank="ANBU"
				mouse_over_pointer='cursormist.dmi'
				Click()
					..()
					switch(input("What is it?")in list("I would like to change my title.","I would like to change my name. (60 Senryo)","Nevermind"))
						if("I would like to change my title.")
							var/list/choose=list()
							choose+="Newbie"
							if(usr.AP>=1)choose+="The Meek"
							if(usr.AP>=3)choose+="Player"
							if(usr.AP>=5)choose+="The Dutiful"
							if(usr.AP>=7)choose+="The Cruel"
							if(usr.AP>=10)choose+="Regular"
							if(usr.AP>=12)choose+="The Patient"
							if(usr.AP>=15)choose+="Warrior"
							if(usr.AP>=18)choose+="The Shadow"
							if(usr.AP>=20)choose+="Veteran"
							if(usr.AP>=23)choose+="The Darkness"
							if(usr.AP>=25)choose+="The Deadly"
							if(usr.AP>=30)choose+="The Righteous"
							if(usr.AP>=35)choose+="Berserker"
							if(usr.AP>=40)choose+="The Merciless"
							if(usr.AP>=45)choose+="Warlord"
							if(usr.AP>=50)choose+="Elite"
							if(usr.AP>=60)choose+="Lightning Flash"
							if(usr.AP>=70)choose+="The Immortal"
							if(usr.AP>=80)choose+="The Feared"
							if(usr.AP>=90)choose+="Legendary"
							if(usr.AP>=100)choose+="Custom"
							var/ss=input("What will you change your title to?") as null|anything in choose
							if(ss=="Custom")
								loop
								var/say=input("What would you like your title to be?") as text
								if(length(say)>=300)
									usr<<"Your title is too long."
									goto loop
								ss = say
							usr.status = ss
							usr.tmpstatus = ss
							usr<<"<b>Your title is now [usr.status]."
						if("I would like to change my name. (60 Senryo)")
							switch(input("Would you like to spend 60 senryo to change your name?")in list("Yes","No"))
								if("Yes")
									if(usr.senryo < 60)
										return
									usr.senryo -= 60
									var/newn = input("What do you want to change your name to?") as text
									if(newn == "")
										usr.senryo += 60
										return
									usr.ryorefresh()
									world << "<b><font color=red>Name Change: <font color=white>[usr]<font color=red>'s name is now <font color=white>[newn].<font color=red>"
									var/firstletter = copytext(ckey(usr.key), 1, 2)
									var/savefile/F = new("Saves/[firstletter]/[ckey(usr.key)].sav")
									F.cd = "/[ckey(key)]"
									F.dir.Remove(ckeyEx(savedname))
									if(usr.village=="Akatsuki")
										akatlist.Remove(usr.name)
										akatsave()
									usr.name = newn
									usr.savedname = usr.name
									usr.mouseovername()
									if(usr.village=="Akatsuki")
										akatlist.Add(usr.name)
										akatsave()
			Heather
				name="Heather(Transport NPC)"
				icon_state="Heather"
				village="Sound"
				rank="ANBU"
				mouse_over_pointer='cursorsound.dmi'
				Click()
					if(usr.cdelay1||usr.village!="Sound"&&usr.GM==0||hosptime)return
					usr.cdelay1=1
					spawn(70)usr.cdelay1=0
					usr<<"<font color=cyan>Heather: Herpa derpa hokus pokus!"
					var/g=new/obj/derpa(usr.loc)
					var/count=6
					var/Y=usr.hp
					var/X=usr.loc
					while(count)
						sleep(5)
						if(usr.hp<Y||X!=usr.loc)
							usr.busy=null
							usr.cdelay1=0
							if(g)del g
							return
						count--
					usr.cdelay1=0
					usr.z=2
					usr.inzone=0
					usr.atkdef()
					usr.zonedelay()
					for(var/mob/Clone/M2 in world)if(M2.cloneowner==usr)del M2

			haircutter
				Sakura
					name="Sakura(Haircutter NPC)"
					icon_state="Sakura"
					village="Leaf"
					rank="Chunin"
					mouse_over_pointer='cursorleaf.dmi'
				Kin
					name="Kin(Haircutter NPC)"
					icon_state="Kin"
					village="Sound"
					rank="Genin"
					mouse_over_pointer='cursorsound.dmi'
				Lulu
					name="Lulu(Haircutter NPC)"
					icon_state="Lulu"
					village="Sand"
					rank="Special Jounin"
				verb
					Haircut()
						set src in oview(3)
						/*
						usr.savedloc=usr.loc
						usr.loc=locate(26,71,1)
						usr.haircutting=1
						usr.client.eye=locate(26,66,1)
						usr.sight+=SEE_SELF
						var/T3=new/obj/square/hairbox(locate(29,43,1))
						var/T4=new/obj/square/haircbox(locate(29,40,1))
						var/image/I3=image('select.dmi',T3)
						var/image/I4=image('select.dmi',T4)
						usr<<I3
						usr<<I4
						T3:owner=usr
						T4:owner=usr
						usr.tmphair="Generic"*/
						switch(input("Hair? Some hair are incomplete. Cut again if you get an unlucky pick.","Temporary Character Screen") in list ("afrohair","asumahair","berlinhair","berlinhair2","buzzhair","byakuyahair","cloudhair","clownhair","dbzhair","gaarahair","generichair","gokuhair","irukahair","itachihair","kakashihair","kimimarohair","leehair","longhair","madarahair","mohawkhair","nejihair","ninjahair","orochimaruhair","sasukehair","tayuyahair","trunkshair","vegetahair","weirdhair","windyhair","womanhair"))
							if("afrohair")usr.hair='afrohair.dmi'
							if("asumahair")usr.hair='asumahair.dmi'
							if("berlinhair")usr.hair='berlinhair.dmi'
							if("berlinhair2")usr.hair='berlinhair2.dmi'
							if("buzzhair")usr.hair='buzzhair.dmi'
							if("byakuyahair")usr.hair='byakuyahair.dmi'
							if("cloudhair")usr.hair='cloudhair.dmi'
							if("clownhair")usr.hair='clownhair.dmi'
							if("dbzhair")usr.hair='dbzhair.dmi'
							if("gaarahair")usr.hair='gaarahair.dmi'
							if("generichair")usr.hair='generichair.dmi'
							if("gokuhair")usr.hair='gokuhair.dmi'
							if("irukahair")usr.hair='irukahair.dmi'
							if("itachihair")usr.hair='itachihair.dmi'
							if("kakashihair")usr.hair='kakashihair.dmi'
							if("kimimarohair")usr.hair='kimimarohair.dmi'
							if("leehair")usr.hair='leehair.dmi'
							if("longhair")usr.hair='longhair.dmi'
							if("madarahair")usr.hair='madarahair.dmi'
							if("mohawkhair")usr.hair='mohawkhair.dmi'
							if("nejihair")usr.hair='nejihair.dmi'
							if("ninjahair")usr.hair='ninjahair.dmi'
							if("orochimaruhair")usr.hair='orochimaruhair.dmi'
							if("sasukehair")usr.hair='sasukehair.dmi'
							if("tayuyahair")usr.hair='tayuyahair.dmi'
							if("trunkshair")usr.hair='trunkshair.dmi'
							if("vegetahair")usr.hair='vegetahair.dmi'
							if("weirdhair")usr.hair='weirdhair.dmi'
							if("windyhair")usr.hair='windyhair.dmi'
							if("womanhair")usr.hair='womanhair.dmi'
						switch(input("Hair color?","Temporary Haircut Screen") in list ("Red","Blonde","Yellow","Blue","Green","Black","Brown","White","Custom"))
							if("Red")usr.haircolor(200,30,30)
							if("Brown")usr.haircolor(100,50,30)
							if("Blonde")usr.haircolor(220,180,40)
							if("Yellow")usr.haircolor(200,200,30)
							if("Blue")usr.haircolor(20,60,180)
							if("Green")usr.haircolor(30,200,30)
							if("Black")usr.haircolor(0,0,0)
							if("White")usr.haircolor(200,200,200)
							if("Custom")usr.haircolorc()
						usr.overlay()
			geninexaminer
				Iruka
					name="Iruka(NPC)"
					icon_state="Iruka"
					village="Leaf"
					rank="Chunin"
					mouse_over_pointer='cursorleaf.dmi'
				Matsuri
					name="Matsuri(NPC)"
					icon_state="Matsuri"
					village="Sand"
					rank="Genin"
					mouse_over_pointer='cursorsand.dmi'
				Tayuya
					name="Tayuya(NPC)"
					icon_state="Tayuya"
					village="Sound"
					rank="Genin"
					mouse_over_pointer='cursorsound.dmi'
				Click()
					if(village!=usr.village)return
					if(geninexam==0)
						if(usr.rank=="Academy Student")
							alert(usr,"[src]: The next Genin exam is in [round(genintime/60)] minutes.")
					..()
			chuninexaminer1
				Ibiki
					name="Ibiki(Chunin Examiner NPC)"
					icon_state="ibiki"
					village="Leaf"
					rank="Special Jounin"
					mouse_over_pointer='cursorleaf.dmi'
				Baki
					name="Baki(Chunin Examiner NPC)"
					icon_state="Baki"
					village="Sand"
					rank="Jounin"
					mouse_over_pointer='cursorsand.dmi'
				Parapa
					name="Parapa(Chunin Examiner NPC)"
					icon_state="Parapa"
					village="Sound"
					rank="Jounin"
					mouse_over_pointer='cursorsound.dmi'
				Click()
					if(village!=usr.village)return
					if(chuninexam==1)if(usr.rank=="Genin")
						switch(alert(usr,"[src]: You. Genin. Are you here for the Chunin Exam?","Chunin Exam","Yes","No"))
							if("Yes")
								fade.MapLayer(usr,255)
								fade.Map(usr, 255, 10, 20)
								spawn(34)
									usr.inchunin=1
									var/list/K2=list()
									for(var/obj/Spawn_Point/newspawn4/A in world)K2+=A
									var/S2=pick(K2)
									usr.loc=S2:loc
									fade.Map(usr, 0, 1, 70)
									alert(usr,"[src]: Sit down and wait for the written exam to begin.")
					if(chuninexam>=2)
						if(usr.rank=="Genin")
							alert(usr,"[src]: Sorry. You're too late. I can't let you in.")
					if(chuninexam==0)
						if(usr.rank=="Genin")
							alert(usr,"[src]: The next Chunin exam is in [round(chunintime/60)] minutes.")
			chuninexaminer2
				name="Ibiki"
				village="Leaf"
				rank="ANBU"
				mouse_over_pointer='cursorleaf.dmi'
				icon_state="ibiki"
				verb
					Talk()
						set src in oview(3)
						switch(alert(usr,"Ibiki: What? Do you want to quit the Chunin Exam?","Chunin Exam","Yes","No"))
							if("Yes")
								usr.inchunin=0
								usr.summonspawn()
								alert(usr,"Ibiki: Very well. ")
			sakumohatake
				name="Sakumo Hatake(Rebirth NPC)"
				village="Leaf"
				rank="Jounin"
				mouse_opacity=2
				mouse_over_pointer='cursorleaf.dmi'
				icon_state="Sakumo Hatake"
				Click()
				/*	if(usr.level>=usr.levelcap)
						alert(usr,"[src]: Hey there.")
						alert(usr,"[src]: This is the place in between the living and the dead.")
						alert(usr,"[src]: I guess you can call this Limbo.")
						alert(usr,"[src]: Don't worry. You're not dead yet.")
						alert(usr,"[src]: As for me, I'm waiting for my son.")
						alert(usr,"[src]: You have a choice, however.")
						alert(usr,"[src]: You can move on, and let the next generation surpass the previous.")
						alert(usr,"[src]: Or, you can leave this place and return to the living.")
						z
						switch(input("[src]: So what is your choice, [usr]?")in list("Yes. I would like to rebirth.","No. I am not ready yet.","Never!","Tell me more about rebirth."))
							if("Yes. I would like to rebirth.")
								if(usr.rebirthto)return
								usr.loc=locate(486,14,1)
								usr.rebirthed++
								switch(usr.rebirthed)
									if(1)
										usr.medal(1,14)
										usr.rebirth1=usr.clan
									if(2)
										usr.medal(2,11)
										usr.rebirth2=usr.clan
									if(3)
										usr.medal(3,2)
										usr.rebirth3=usr.clan
								usr.rebirthto=1
								usr.rebirthing=1
								usr.level=1
								usr.Sta=1
								usr.Hsl=1
								usr.Tai=1
								usr.Nin=1
								usr.Str=1
								usr.Int=1
								usr.Spd=1
								usr.amissionreq=3
								usr.vilc=0
								usr.staexp=0
								usr.intexp=0
								usr.wpalm=0
								usr.hslexp=0
								usr.taiexp=0
								usr.apowexp=0
								usr.ninexp=0
								usr.spdexp=0
								usr.intexp=0
								usr.flashing=0
								usr.exp=usr.exp/10
								usr.staexpm=100+rebirthed*100
								usr.intexpm=100+rebirthed*100
								usr.energy=100
								usr.maxenergy=100
								usr.hslexpm=100+rebirthed*100
								usr.taiexpm=100+rebirthed*100
								usr.powered=0
								usr.apowexpm=100+rebirthed*100
								usr.ninexpm=100+rebirthed*100
								usr.spdexpm=100+rebirthed*100
								usr.skillpoint=1
								usr.skilltotal=0
								usr.verbs-=typesof(/mob/Kage/verb)
								usr.verbs-=typesof(/mob/Kage2/verb)
								usr.verbs-=typesof(/mob/Akatsuki/verb)
								usr.icon=null
								usr.overlays=null
								usr.levelcap+=20
								if(usr.rebirthed==3)usr.levelcap+=300
								for(var/obj/items/equippable/M in usr)if(M.equipped)M:Use()
								for(var/obj/items/equippable/Bone_Sword/M in usr)del M
								for(var/obj/items/equippable/Sand_Gourd/M in usr)del M
								for(var/obj/items/equippable/Fan/M in usr)del M
								for(var/obj/items/equippable/Mask_of_the_Mist/M in usr)del M
								for(var/obj/items/equippable/Serpent_Belt/M in usr)del M
								for(var/obj/items/equippable/Hokage_Suit/M in usr)del M
								for(var/obj/items/equippable/Hokage_Hat/M in usr)del M
								for(var/obj/items/equippable/Akatsuki_Suit/M in usr)del M
								for(var/obj/items/equippable/Kazekage_Suit/M in usr)del M
								for(var/obj/items/equippable/Sword_of_Kusanagi/M in usr)del M
								for(var/obj/items/equippable/Kazekage_Hat/M in usr)del M
								for(var/obj/items/equippable/Sound_Leader_Suit/M in usr)del M
								for(var/obj/items/equippable/Leaf_Anbu_Mask/M in usr)del M
								for(var/obj/items/equippable/Sand_Anbu_Mask/M in usr)del M
								for(var/obj/items/equippable/Sound_Anbu_Mask/M in usr)del M
								for(var/obj/items/equippable/ANBU_Armor/M in usr)del M
								usr.rank="Academy Student"
								usr.clan="None"
								usr.tmprank="Academy Student"
								usr.jailtime=0
								usr.hosptime=0
								usr.mission=null
								usr.missiond=null
								usr.graffiti=0
								usr.karma=150
								usr.repcontribute=0
								usr.wdmg=0
								usr.dead=0
								usr.pktoggle=0
								usr.affcheck()
								usr.initialized=0
								usr.onwater=0
								usr.onsand=0
								usr.inzone=0
								usr.swim=0
								usr.blind=0
								usr.muted=0
								usr.sharingan=0
								usr.sandarmor=0
								usr.byakugan=0
								usr.slot1=null
								usr.slot2=null
								usr.slot3=null
								usr.slot4=null
								usr.slot5=null
								usr.slot6=null
								usr.slot7=null
								usr.slot8=null
								usr.slot9=null
								usr.slot10=null
								usr.slot11=null
								usr.slot12=null
								usr.slot13=null
								usr.slot14=null
								usr.slot15=null
								usr.slot16=null
								usr.smite=0
								usr.pkkills=0
								usr.tier11=0
								usr.tier12=0
								usr.tier13=0
								usr.tier21=0
								usr.tier22=0
								usr.tier23=0
								usr.tier31=0
								usr.tier32=0
								usr.tier33=0
								usr.tier41=0
								usr.tier42=0
								usr.tier43=0
								usr.tier51=0
								usr.tier52=0
								usr.tier53=0
								usr.tier61=0
								usr.tier62=0
								usr.tier63=0
								usr.tier11max=5
								usr.tier12max=5
								usr.tier13max=5
								usr.tier21max=5
								usr.tier22max=5
								usr.tier23max=5
								usr.tier31max=5
								usr.tier32max=5
								usr.tier33max=5
								usr.tier41max=5
								usr.tier42max=5
								usr.tier43max=5
								usr.tier51max=5
								usr.tier52max=5
								usr.tier53max=5
								usr.tier61max=5
								usr.tier62max=5
								usr.tier63max=5
								usr.rchannel=null
								usr.jutsutoggle=0
								usr.skilltotal=0
								usr.statset()
								usr.refreshword()
								for(var/obj/M in usr.client.screen)del M
								if(usr.mybar)del usr.mybar
								if(usr.mybar2)del usr.mybar2
								winset(usr, "default.exp", "is-visible=false")
								winset(usr, "default.level", "is-visible=false")
								winset(usr, "default.cha", "is-visible=false")
								winset(usr, "default.hp", "is-visible=false")
								winset(usr, "default.input1", "pos=32,685")
								for(var/obj/jutsu/G in usr)del G
								for(var/obj/jutsu/G in usr.client.screen)del G
								if(usr.sclonelearned)
									new/obj/jutsu/Shadow_Clone_Jutsu(usr)
								usr.client.screen+=new/obj/newchar/claninfo
								usr.client.screen+=new/obj/newchar/village/leaf
								usr.client.screen+=new/obj/newchar/village/sand
								usr.client.screen+=new/obj/newchar/village/sound
								usr.client.screen+=new/obj/newchar/clan/uchiha
								usr.client.screen+=new/obj/newchar/clan/nara
								usr.client.screen+=new/obj/newchar/clan/hyuuga
								usr.client.screen+=new/obj/newchar/clan/sand
								usr.client.screen+=new/obj/newchar/clan/iron
								usr.client.screen+=new/obj/newchar/clan/wind
								usr.client.screen+=new/obj/newchar/clan/snake
								usr.client.screen+=new/obj/newchar/clan/spider
								usr.client.screen+=new/obj/newchar/clan/kaguya
								usr.client.screen+=new/obj/newchar/clan/tai
								usr.client.screen+=new/obj/newchar/clan/copy
								usr.client.screen+=new/obj/newchar/clan/yuki
								usr.client.screen+=new/obj/newchar/clan/senju
								usr.client.screen+=new/obj/newchar/clan/medic
								usr.client.screen+=new/obj/newchar/clan/clay
								usr.loc=locate(119,15,1)
								usr.client.perspective=EYE_PERSPECTIVE
								usr.client.eye=locate(121,11,1)
								usr.clan="None"
								usr.icon='base.dmi'
								usr.icon_name='base.dmi'
								usr.eye='blackeyes.dmi'
								usr.hair='berlinhair2.dmi'
								usr.initialized=0
								usr.name=key
								usr.invisibility=10
								usr.sight|=SEE_SELF
								usr.overlay()
								var/image/I=image('clanscreen.dmi',locate(128,18,1),"arrow",63)
								I.vtype="hair"
								usr.client.images+=I
								var/image/I2=image('clanscreen.dmi',locate(126,12,1),"arrow",63)
								I2.vtype="eye"
								I2.pixel_y=6
								usr.client.images+=I2
								var/image/I3=image('clanscreen.dmi',locate(126,13,1),"1",30)
								I3.vtype="hairc"
								I3.pixel_y=6
								usr.client.images+=I3
								var/image/I4=image('clanscreen.dmi',locate(127,11,1),"arrow",63)
								I4.vtype="skin"
								I4.pixel_y=6
								usr.client.images+=I4
							if("No. I am not ready yet.")
								alert(usr,"[src]: Alright. I see you still has more things to do in this world.")
								alert(usr,"[src]: I'll see you again in a while.")
								usr.deathclean()
								usr.rebirthto=rand(5,10)
							if("Never!")
								alert(usr,"[src]: I see... You're quite power hungry.")
								alert(usr,"[src]: But who knows? I might see you again.")
								usr.deathclean()
								usr.rebirthto=rand(20,30)
							if("Tell me more about rebirth.")
								var/window = {"
<STYLE>BODY {background: black; color: white}</STYLE>
<html>
<body>
<font size=1>
<font face=verdana>
<b><center>What Is Rebirth?</b>
<br>-------------------</center>
<br>Rebirthing lets you start at level 1 again with any clan from any village, but you have to start in the same village you were before you rebirthed. The only exception is if you are a missing-nin. Then you have to choose a new village. You can rebirth a maximum of 3 times.
<br>
<br> Effects of Rebirth
<br> Increases your level cap by 20. (Max level cap of 120 at 3 rebirths)
<br> Increases maximum health by 250 per rebirth
<br> Increases maximum chakra by 100 per rebirth
<br> Increases health, mana and energy regen by 20% per rebirth
<br> Increases damage dealt by 5% per rebirth
<br> Decreases damage taken by 5% per rebirth
<br> Increases death hospitalization penalty by 50 seconds per rebirth
<br> Increases exp required for stats by 100 per rebirth
<br>
<br>
<br> *note: stat bonuses also increase the stat cap. so if you rebirth for the first time from a Kaguya you will start with 6 Taijutsu and it can go up to 35.
<br>
<br>
<br> <center>First Rebirth Bonuses
<br> _____________________</center>
<br>
<br> <b>Kaguya</b> - +5 Taijutsu and take 10% less damage.
<br>
<br> <b>Hyuuga</b> - +5 Taijutsu and 10% evasion chance(reduce damage by 90%).
<br>
<br> <b>Uchiha</b> - +12 Handseals
<br>
<br> <b>Iron</b> - +10 Ninjutsu
<br>
<br> <b>Wind</b> - +10 Speed, -10% all cooldowns
<br>
<br> <b>Sand</b> - 10% evasion chance(reduce damage by 90%), deal 20% more damage with projectile weapons(shurikens, kunais, bone bullets etc)
<br>
<br>
<br> <center>Second Rebirth Bonuses
<br> _____________________</center>
<br>
<br> <b>Kaguya</b> - Penetration(passive) - Deals 12 true damage on all attacks(op on multihits such as rasengan)
<br>
<br> <b>Yuki</b> - Deadly Frost(passive) - Slow the enemy for 3 seconds after a melee or ability critical strike. Increase critical strike chance by 25%.
<br>
<br> <b>Iron</b> - Neurotoxin(passive) - Deals 5% of the enemy's maximum health over 5 seconds after any attack. Additional neurotoxin does not stack but refreshes duration.
<br>
<br> <b>Hyuuga</b> - Deadly Flow(passive) - Deal 30% more damage with basic attacks to target's back. Instantly dashes to the enemy when punching if they are within 2 squares range.
<br>
<br> <b>Wind</b> - Wind Guardian - Creates a wind shield shredding for 2% of your maximum chakra in damage to everyone around you every second. Effect doubled when you are under 33% health.
<br>
<br> <b>Sand</b> - Maternal Protection(passive) - You gain a armor of sand with a durability of 15% of your maximum health. When you reach 20% health the armor of sand regenerates with a cooldown of 120 seconds.
<br>
<br> <b>---Uchiha---
<br> Sharingan Implants</b> - Starts with a eyepatch that you can take off to reveal your sharingan, increasing critical rate, dodge, damage and accuracy by 15% and decreasing ninjutsu cooldown by 20%. Drains 30 chakra per second.
<br>
<br>Opens clan choice: Copy Ninja
<br>
<br> <b>---if rebirthing into Uchiha/Hyuuga---
<br> Doujutsu Mastery(passive)</b> - Reduce blindness rate by 50%(Uchiha), taijutsu cooldown by 35%(Hyuuga) and ninjutsu cooldown by 20%.
<br>
<br>
<br>
<br> <center>Third Rebirth Bonuses
<br> _____________________</center>
<br>
<br> <b>Yuki</b> - Quicksilver -  You start with 10 stacks of quicksilver buff. As long as you have a quicksilver buff on you will take 60% less damage, removing a stack after every hit. You gain 3.5% damage for every quicksilver buff that is on you. Quicksilver regenerates every 10 seconds and instantly regenerate 5 stacks once you hit 30% health.
<br>
<br> <b>Copy Ninja
<br> Kamui</b> - Click with your mouse to activate mangekyou sharingan and deal extreme damage to an area after a 1 second delay. Cripples the user for 30 seconds after 30 seconds of its first use. Can be used up to 3 times before going on cooldown.
<br>
<br> <b>Sand</b> - Desolation(Passive) - You do 1% more damage to a enemy per 2% hp missing. (enemy at 80% hp you go 10% more damage. enemy at 20% hp you do 40% more damage.)
<br>
<br> <b>Iron</b> - Chakra Sickle(Passive) - Drains 2% of the enemy's current chakra and 0.5% of the amount of their maximum chakra from every enemy around you. You take 0.3% less damage for every 1% chakra you have.
<br>
<br> <b>Kaguya</b> - When your health reaches 0, you remain invincible for 8 seconds while gaining 40% increased damage, immunity to slows and stuns and 1000% chakra, energy and any other resource regeneration. This effect can only occur once every 200 seconds.
<br>
<br> <b>Hyuuga</b> - Strength +10, You smash the enemy into the ground, stunning then for 2 seconds when you basic attack the enemy. This effect can only occur once every 8 seconds on the same enemy.
<br>
<br> <b>Wind</b> - Start with lightning flash with a 8 second cooldown.
<br>
<br> <b>---Uchiha---
<br> if rebirthing into a non-uchiha
<br> Susanoo Sword</b> - You obtain a Susanoo chakra sword, which deals damage based on both your attack power and ninjutsu power and fires a chakra wave in front of you. Strongest weapon in the game.
<br>
<br> <b>if rebirthing into uchiha
<br> Eternal Mangekyou Sharingan</b> - Counts as a ultimate.
<br>
<br> <b>if rebirthing into hyuuga
<br> Martyr</b> - You and your allies(if applicable) restores health equal to the amount of chakra you disrupt.</font>
</body>
</html>
"}
								usr << browse(window,"window=Stats;size=600x550")
								goto z */
			SupplySeller
				Genma
					name="Genma(Supply NPC)"
					icon_state="Genma"
					village="Leaf"
					rank="Special Jounin"
					mouse_over_pointer='cursorleaf.dmi'
				Steve
					name="Stephany(Supply NPC)"
					icon_state="Steve"
					village="Sand"
					rank="Chunin"
					mouse_over_pointer='cursorsand.dmi'
				Tsukasa
					name="Tsukasa(Supply NPC)"
					icon_state="Tsukasa"
					village="Sound"
					rank="ANBU"
					mouse_over_pointer='cursorsound.dmi'

				Vladimir
					name="Vladimir(Supply NPC)"
					icon_state="Vladimir"
					village="None"
					rank="S-Ranked Criminal"
					mouse_over_pointer='cursormiss.dmi'
				Click()
					..()
					switch(input("What would you like to buy?")in list("Radio - 3 Senryo","Bingo Book - 10 Senryo","Chakra Tracker - 100 Senryo","Smoke Bomb - 4 Senryo","Handheld Kunai - 1 Senryo","Boxing Gloves - 15 Senryo","Katana - 60 Senryo","Shadow Katana - 80 Senryo","Blood Pill - 2 Senryo","Chakra Pill - 8 Senryo","Nevermind"))
						if("Radio - 3 Senryo")
							var/K=0
							for(var/obj/usable/Radio/M in usr)K++
							if(K>=1)
								usr<<"<font color=silver>[src]: You can only hold one radio at a time."
								return
							if(usr.senryo>=3)
								usr.senryo-=3
								new/obj/usable/Radio(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if("Chakra Tracker - 100 Senryo")
							var/K=0
							for(var/obj/usable/Chakra_Tracker/M in usr)K++
							if(K>=1)
								usr<<"<font color=silver>[src]: You can only hold one tracker at a time."
								return
							if(usr.senryo>=100)
								usr.senryo-=100
								new/obj/usable/Chakra_Tracker(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if("Bingo Book - 10 Senryo")
							var/K=0
							for(var/obj/usable/Bingo_Book/M in usr)K++
							if(K>=1)
								usr<<"<font color=silver>[src]: You can only hold one bingo book at a time."
								return
							if(usr.senryo>=10)
								usr.senryo-=10
								new/obj/usable/Bingo_Book(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if("Handheld Kunai - 1 Senryo")
							if(usr.senryo>=1)
								usr.senryo-=1
								new/obj/items/equippable/Handheld_Kunai(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if("Boxing Gloves - 15 Senryo")
							if(usr.senryo>=15)
								usr.senryo-=15
								new/obj/items/equippable/Boxing_Gloves(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if("Katana - 60 Senryo")
							if(usr.senryo>=60)
								usr.senryo-=60
								new/obj/items/equippable/Katana(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if("Shadow Katana - 80 Senryo")
							if(usr.senryo>=80)
								usr.senryo-=80
								new/obj/items/equippable/Shadow_Katana(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if("Smoke Bomb - 4 Senryo")
							if(usr.smokeamount>=10)
								usr<<"<font color=silver>[src]: You can only hold 10 smoke bombs at the same time!"
								return
							var/T=10-usr.smokeamount
							if(T<=0)
								usr<<"<font color=silver>[src]: You can only hold 10 smoke bombs at the same time!"
								return
							var/U=input(usr,"How many smoke bombs do you want to buy?(Can buy [T] max)","Smoke Bombs") as num
							if(U<=0||U>T)return
							if(U*4>usr.senryo)
								alert(usr,"[src]: You don't have enough ryo.")
								return
							else
								switch(alert(usr,"Are you sure you want to buy [U] smoke bombs?([U*4] ryo)","Smoke Bombs","Yes","No"))
									if("Yes")
										usr.senryo-=4*U
										if(usr.smokeamount<=0)new/obj/usable/Smoke_Bomb(usr)
										usr.smokeamount+=U
										usr<<"You bought [U] smoke bombs. You have [senryo] senryo left."
						if("Blood Pill - 3 Senryo")
							var/K=0
							for(var/obj/usable/Blood_Pill/M in usr)K++
							if(K>=3)
								usr<<"<font color=silver>[src]: You can only hold 3 blood pill at the same time!"
								return
							if(usr.senryo>=2)
								usr.senryo-=2
								new/obj/usable/Blood_Pill(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if("Chakra Pill - 35 Senryo")
							var/K=0
							for(var/obj/usable/Chakra_Pill/M in usr)K++
							if(K>=2)
								usr<<"<font color=silver>[src]: You can only hold 2 chakra pills at the same time!"
								return
							if(usr.senryo>=35)
								usr.senryo-=35
								new/obj/usable/Chakra_Pill(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if("Nevermind")return
					usr.ryorefresh()
					usr<<"<font color=silver>[src]: Here you go."
			ClothingSeller
				var/F=0
				New()
					..()
					spawn()VarietyBitch()
				proc
					VarietyBitch()
						F=pick(1,2,3,4,5)
						sleep(3000)
						VarietyBitch()
				Ino
					name="Ino(Clothing NPC)"
					icon_state="Ino"
					village="Leaf"
					rank="Chunin"
					mouse_over_pointer='cursorleaf.dmi'
				Zabu
					name="Zabu(Clothing NPC)"
					icon_state="Zabu"
					village="Sand"
					rank="ANBU"
					mouse_over_pointer='cursorsand.dmi'
				Menik
					name="Menik(Clothing NPC)"
					icon_state="Menik"
					village="Sound"
					rank="Special Jounin"
					mouse_over_pointer='cursorsound.dmi'
				verb
					Buy()
						set src in oview(3)
						if(usr.village!=village)
							if(usr.tmpvillage==village)
								for(var/obj/items/Fake_Cheque/M in usr)
									del M
									alert(usr,"[src]: Are you here to pick up the new shipment of vests?")
									alert(usr,"You place the fake cheque on the table.")
									alert(usr,"[src]: Here you go.")
									new/obj/items/Vest_Shipment(usr)
							return
						if(usr.cloaking)return
						var/list/equip=list()
						equip.Add("Shirt - 2 Senryo")
						equip.Add("Pants - 2 Senryo")
						equip.Add("Shoes - 1 Senryo")
						equip.Add("Gloves - 2 Senryo")
						equip.Add("Kunai Pouch - 2 Senryo")
						equip.Add("Plated Gloves - 5 Senryo")
						if(F!=4&&F!=3)
							equip.Add("Glasses - 2 Senryo")
							equip.Add("Face Mask - 12 Senryo")
						if(F!=3&&F!=2)equip.Add("Green Jump Suit - 90 Senryo")
						if(F!=2)
							equip.Add("Shoes With Socks - 8 Senryo")
							equip.Add("Cloth Mask - 5 Senryo")
						if(F!=1)
							equip.Add("Hunters Cap - 8 Senryo")
							equip.Add("Blue Undershirt - 12 Senryo")
						if(F!=3&&F!=1)
							equip.Add("Orange Jacket - 22 Senryo")
							equip.Add("Sunglasses - 8 Senryo")
							equip.Add("Combat Armor - 50 Senryo")
							equip.Add("Blue Coat - 20 Senryo")
							equip.Add("Half Helmet - 35 Senryo")
							equip.Add("Ember Cloak - 80 Senryo")
						if(F!=2&&F!=4)
							equip.Add("Black Cloak - 35 Senryo")
							equip.Add("Red Coat - 20 Senryo")
							equip.Add("Sombraro - 4 Senryo")
							equip.Add("Beige Jacket - 25 Senryo")
							equip.Add("Mist Demon Suit - 75 Senryo")
						if(F!=1&&F!=4)
							equip.Add("Waist Scarf - 10 Senryo")
							equip.Add("Straw Hat - 2 Senryo")
							equip.Add("Black Shinobi Headband - 8 Senryo")
							equip.Add("Black Cloth Mask - 5 Senryo")
							equip.Add("Shadow Pact Gear - 125 Senryo")
						if(F==1)
							equip.Add("Bandages - 6 Senryo")
							equip.Add("Green Coat - 20 Senryo")
							equip.Add("Blood Exile Armor - 120 Senryo")
							equip.Add("Blue Mist Coat - 30 Senryo")
						if(F==3)
							equip.Add("Spiral Mask - 60 Senryo")
							equip.Add("Warbringer - 120 Senryo")
						if(F==5)
							equip.Add("Black Shorts - 7 Senryo")
							equip.Add("Blue Vest - 30 Senryo")
							equip.Add("Black Coat - 20 Senryo")
							equip.Add("Ice Wolf Armor - 150 Senryo")
							if(clan=="Uchiha")equip.Add("Uchiha Shirt - 25 Senryo")
							equip.Add("Combat Helmet - 40 Senryo")
						if(rank!="Genin"&&rank!="Academy Student")equip.Add("Village Flak Jacket - 15 Senryo")
						equip.Add("Nevermind")
						var/G=input("[src]: What clothing do you want to buy? We get a new shipment of clothings every 5 minutes.)") as null|anything in equip
						if(G=="Black Shinobi Headband - 8 Senryo")
							if(usr.senryo>=8)
								usr.senryo-=8
								new/obj/items/equippable/Black_Shinobi_Headband(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Sombraro - 4 Senryo")
							if(usr.senryo>=4)
								usr.senryo-=4
								new/obj/items/equippable/Sombraro(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Ember Cloak - 80 Senryo")
							if(usr.senryo>=80)
								usr.senryo-=80
								new/obj/items/equippable/Ember_Cloak(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Warbringer - 120 Senryo")
							if(usr.senryo>=120)
								usr.senryo-=120
								new/obj/items/equippable/Warbringer(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Shadow Pact Gear - 125 Senryo")
							if(usr.senryo>=125)
								usr.senryo-=125
								new/obj/items/equippable/Shadow_Pact_Gear(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Ice Wolf Armor - 150 Senryo")
							if(usr.senryo>=150)
								usr.senryo-=150
								new/obj/items/equippable/Ice_Wolf_Armor(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Half Helmet - 35 Senryo")
							if(usr.senryo>=35)
								usr.senryo-=35
								new/obj/items/equippable/Half_Helmet(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Blood Exile Armor - 120 Senryo")
							if(usr.senryo>=120)
								usr.senryo-=120
								new/obj/items/equippable/Blood_Exile_Armor(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Mist Demon Suit - 75 Senryo")
							if(usr.senryo>=75)
								usr.senryo-=75
								new/obj/items/equippable/Mist_Demon_Suit(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Combat Armor - 50 Senryo")
							if(usr.senryo>=50)
								usr.senryo-=50
								new/obj/items/equippable/Combat_Armor(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Kunai Pouch - 2 Senryo")
							if(usr.senryo >= 2)
								usr.senryo -= 2
								new/obj/items/equippable/Kunai_Pouch(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Shoes With Socks - 8 Senryo")
							if(usr.senryo>=8)
								usr.senryo-=8
								new/obj/items/equippable/Shoes_With_Socks(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Blue Vest - 30 Senryo")
							if(usr.senryo>=30)
								usr.senryo-=30
								new/obj/items/equippable/Blue_Vest(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Gloves - 2 Senryo")
							if(usr.senryo>=2)
								usr.senryo-=2
								new/obj/items/equippable/Gloves(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Plated Gloves - 5 Senryo")
							if(usr.senryo>=5)
								usr.senryo-=5
								new/obj/items/equippable/Plated_Gloves(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Beige Jacket - 25 Senryo")
							if(usr.senryo>=25)
								usr.senryo-=25
								new/obj/items/equippable/Beige_Jacket(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Black Cloak - 35 Senryo")
							if(usr.senryo>=35)
								usr.senryo-=35
								new/obj/items/equippable/Black_Cloak(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Bandages - 6 Senryo")
							if(usr.senryo>=6)
								usr.senryo-=6
								new/obj/items/equippable/Bandages(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Waist Scarf - 10 Senryo")
							if(usr.senryo>=10)
								usr.senryo-=10
								new/obj/items/equippable/Waist_Scarf(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Orange Jacket - 22 Senryo")
							if(usr.senryo>=22)
								usr.senryo-=22
								new/obj/items/equippable/Narutos_Jacket(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Spiral Mask - 60 Senryo")
							if(usr.senryo>=60)
								usr.senryo-=60
								new/obj/items/equippable/Spiral_Mask(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Hunters Cap - 8 Senryo")
							if(usr.senryo>=8)
								usr.senryo-=8
								new/obj/items/equippable/Hunters_Cap(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Blue Mist Coat - 30 Senryo")
							if(usr.senryo>=30)
								usr.senryo-=30
								new/obj/items/equippable/Blue_Mist_Coat(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Blue Coat - 20 Senryo")
							if(usr.senryo>=20)
								usr.senryo-=20
								new/obj/items/equippable/Blue_Coat(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Black Coat - 20 Senryo")
							if(usr.senryo>=20)
								usr.senryo-=20
								new/obj/items/equippable/Black_Coat(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Green Coat - 20 Senryo")
							if(usr.senryo>=20)
								usr.senryo-=20
								new/obj/items/equippable/Green_Coat(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Red Coat - 20 Senryo")
							if(usr.senryo>=20)
								usr.senryo-=20
								new/obj/items/equippable/Red_Coat(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Black Shorts - 7 Senryo")
							if(usr.senryo>=7)
								usr.senryo-=7
								new/obj/items/equippable/Black_Shorts(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Cloth Mask - 5 Senryo")
							if(usr.senryo>=5)
								usr.senryo-=5
								new/obj/items/equippable/Cloth_Mask(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Black Cloth Mask - 5 Senryo")
							if(usr.senryo>=5)
								usr.senryo-=5
								new/obj/items/equippable/Black_Cloth_Mask(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Face Mask - 12 Senryo")
							if(usr.senryo>=12)
								usr.senryo-=12
								new/obj/items/equippable/Face_Mask(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Green Jump Suit - 90 Senryo")
							if(usr.senryo>=90)
								usr.senryo-=90
								new/obj/items/equippable/Green_Jump_Suit(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Straw Hat - 2 Senryo")
							if(usr.senryo>=2)
								usr.senryo-=2
								new/obj/items/equippable/Straw_Hat(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Shirt - 2 Senryo")
							if(usr.senryo>=2)
								usr.senryo-=2
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
							switch(input("[src]: Which colour?")in list("Red","Tan","White","Black","Green","Blue","Grey","Orange","Nevermind"))
								if("Orange")new/obj/items/equippable/Orange_Shirt(usr)
								if("Blue")new/obj/items/equippable/Blue_Shirt(usr)
								if("Black")new/obj/items/equippable/Black_Shirt(usr)
								if("White")new/obj/items/equippable/White_Shirt(usr)
								if("Green")new/obj/items/equippable/Green_Shirt(usr)
								if("Grey")new/obj/items/equippable/Grey_Shirt(usr)
								if("Red")new/obj/items/equippable/Red_Shirt(usr)
								if("Tan")new/obj/items/equippable/Tan_Shirt(usr)
							return
						if(G=="Pants - 2 Senryo")
							if(usr.senryo>=2)
								usr.senryo-=2
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
							switch(input("[src]: Which colour?")in list("White","Black","Green","Blue","Grey","Orange","Nevermind"))
								if("Orange")new/obj/items/equippable/Orange_Pants(usr)
								if("Blue")new/obj/items/equippable/Blue_Pants(usr)
								if("Black")new/obj/items/equippable/Black_Pants(usr)
								if("White")new/obj/items/equippable/White_Pants(usr)
								if("Green")new/obj/items/equippable/Green_Pants(usr)
								if("Grey")new/obj/items/equippable/Grey_Pants(usr)
							return
						if(G=="Shoes - 1 Senryo")
							if(usr.senryo>=5)
								usr.senryo-=5
								new/obj/items/equippable/Shoes(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Glasses - 2 Senryo")
							if(usr.senryo>=2)
								usr.senryo-=2
								new/obj/items/equippable/Glasses(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Sunglasses - 8 Senryo")
							if(usr.senryo>=8)
								usr.senryo-=8
								new/obj/items/equippable/Sunglasses(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Uchiha Shirt - 25 Senryo")
							if(usr.clan!="Uchiha")
								alert(usr,"[src]: Uhh. You don't seem like a Uchiha.")
								return
							if(usr.senryo>=25)
								usr.senryo-=25
								new/obj/items/equippable/Uchiha_Shirt(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Combat Helmet - 40 Senryo")
							if(usr.senryo>=40)
								usr.senryo-=40
								new/obj/items/equippable/Combat_Helmet(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Village Flak Jacket - 15 Senryo")
							if(usr.rank=="Genin"||usr.rank=="Academy Student")
								alert(usr,"[src]: You must be at least a Chunin like me to buy this.")
								return
							if(usr.senryo>=15)
								usr.senryo-=15
								if(village=="Leaf")new/obj/items/equippable/Leaf_Flak_Jacket(usr)
								if(village=="Sand")new/obj/items/equippable/Sand_Flak_Jacket(usr)
								if(village=="Sound")new/obj/items/equippable/Sound_Flak_Jacket(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Blue Undershirt - 12 Senryo")
							if(usr.senryo>=12)
								usr.senryo-=12
								new/obj/items/equippable/Blue_Shinobi_Shirt(usr)
							else
								alert(usr,"[src]: You don't have enough ryo.")
								return
						if(G=="Nevermind")return
						usr.ryorefresh()
						usr<<"<font color=silver>[src]: Here you go."
			Jiraiya
				name="(NPC)Jiraiya(Leaf/Neutral)"
				village="Leaf"
				rank="Sage"
				mouse_over_pointer='cursorleaf.dmi'
				icon_state="Jiraiya"
				clan=""
				level=73
				question
			Respec
				name="Tsunade (Respec NPC)"
				village="Tsunade"
				level=144
				icon='NPCs.dmi'
				icon_state="Tsunade"
				clan="Medical-Nin"
				rank="Sannin"
				Click()
					switch(input("[src]: Would you like to respec?")in list("Yea bitch.","Nay."))
						if("Yea bitch.")
							if(usr.freerespec)
								usr.freerespec--
								usr<<"Thank you for your contribution to the game! Free respec redeemed."
								if(!usr.respecced)
									usr.respecced=1
									usr.medal(2,9)
								usr.respecced=1
								usr.medal(2,9)
								usr.tier11=0
								usr.tier12=0
								usr.tier13=0
								usr.tier21=0
								usr.tier22=0
								usr.tier23=0
								usr.tier31=0
								usr.tier32=0
								usr.tier33=0
								usr.tier41=0
								usr.tier42=0
								usr.tier43=0
								usr.tier51=0
								usr.tier52=0
								usr.tier53=0
								usr.tier61=0
								usr.tier62=0
								for(var/obj/jutsu/hyuuga/Rapid_Palms/G in usr)del G
								for(var/obj/jutsu/hyuuga/Precise_Striking/G in usr)del G
								for(var/obj/jutsu/kaguya/Bloodlust/G in usr)del G
								for(var/obj/jutsu/kaguya/Extreme_Condensing/G in usr)del G
								for(var/obj/jutsu/kaguya/Double_Blades/G in usr)del G
								for(var/obj/jutsu/kaguya/Bone_Golem/G in usr)del G
								for(var/obj/jutsu/snake/Shed_Skin/G in usr)del G
								for(var/obj/jutsu/medic/Chakra_Enhanced_Strength/G in usr)del G
								for(var/obj/jutsu/uchiha/Vengeance/G in usr)del G
								for(var/obj/jutsu/uchiha/Disperse/G in usr)del G
								for(var/obj/jutsu/medic/Chakra_Scalpel/G in usr)del G
								for(var/obj/jutsu/medic/Mitotic_Regeneration/G in usr)del G
								for(var/obj/jutsu/wind/Whirlwind_Palm/G in usr)del G
								for(var/obj/jutsu/wind/Mark_of_Death/G in usr)del G
								for(var/obj/jutsu/wind/Wind_Shield/G in usr)del G
								for(var/obj/jutsu/sandc/Tap_Sand_Reserve/M in usr)del M
								for(var/obj/jutsu/sandc/Sand_Barrage/M in usr)
									new/obj/jutsu/sandc/Sand_Shower(usr)
									del M
								usr.skilltotal=0
								usr.tier63=0
								usr.skillpoint=0
								var/g=usr.level
								usr.statset()
								usr.refreshword()
								if(usr.level>1)usr.skillpoint++
								loop
									if(g%3==0)usr.skillpoint++
									if(g==0)return
									g--
									goto loop
								return
							if(usr.senryo<30)
								alert("[src]: You need 30 senryo to respec.")
								alert("[usr]: I dont got no dough. I'm a broke ass nigga. brb hustling")
							else
								switch(input("[src]: 30 senryo. Cough it up.")in list("k.","Da fuck this bitch been smokin."))
									if("k.")
										if(!usr.respecced)
											usr.respecced=1
											usr.medal(2,9)
										usr.senryo-=30
										usr.ryorefresh()
										usr.tier11=0
										usr.tier12=0
										usr.tier13=0
										usr.tier21=0
										usr.tier22=0
										usr.tier23=0
										usr.tier31=0
										usr.tier32=0
										usr.tier33=0
										usr.tier41=0
										usr.tier42=0
										usr.tier43=0
										usr.tier51=0
										usr.tier52=0
										usr.tier53=0
										usr.tier61=0
										usr.tier62=0
										for(var/obj/jutsu/hyuuga/Rapid_Palms/G in usr)del G
										for(var/obj/jutsu/hyuuga/Precise_Striking/G in usr)del G
										for(var/obj/jutsu/kaguya/Bloodlust/G in usr)del G
										for(var/obj/jutsu/kaguya/Extreme_Condensing/G in usr)del G
										for(var/obj/jutsu/kaguya/Double_Blades/G in usr)del G
										for(var/obj/jutsu/kaguya/Bone_Golem/G in usr)del G
										for(var/obj/jutsu/snake/Shed_Skin/G in usr)del G
										for(var/obj/jutsu/medic/Chakra_Enhanced_Strength/G in usr)del G
										for(var/obj/jutsu/uchiha/Vengeance/G in usr)del G
										for(var/obj/jutsu/uchiha/Disperse/G in usr)del G
										for(var/obj/jutsu/medic/Chakra_Scalpel/G in usr)del G
										for(var/obj/jutsu/medic/Mitotic_Regeneration/G in usr)del G
										for(var/obj/jutsu/wind/Whirlwind_Palm/G in usr)del G
										for(var/obj/jutsu/wind/Mark_of_Death/G in usr)del G
										for(var/obj/jutsu/wind/Wind_Shield/G in usr)del G
										for(var/obj/jutsu/sandc/Tap_Sand_Reserve/M in usr)del M
										for(var/obj/jutsu/sandc/Sand_Barrage/M in usr)
											new/obj/jutsu/sandc/Sand_Shower(usr)
											del M
										usr.skilltotal=0
										usr.tier63=0
										usr.skillpoint=0
										var/g=usr.level
										usr.statset()
										usr.refreshword()
										if(usr.level>1)usr.skillpoint++
										loop
											if(g%3==0)usr.skillpoint++
											if(g==0)return
											g--
											goto loop
			Konohamaru
				name="(NPC)Konohamaru(Leaf/Neutral)"
				village="Leaf"
				mouse_over_pointer='cursorleaf.dmi'
				icon_state="Konohamaru"
				clan="Sarutobi"
				rank="Academy Student"
				level=6
				verb/Talk()
					set src in oview(3)
					var/t=0
					for(var/obj/jutsu/Shuriken_Clone_Jutsu/M in usr)t=1
					if(!t)
						alert(usr,"Konohamaru: I just learned this awesome new jutsu.")
						alert(usr,"Konohamaru: I'll teach it to you if you admit that I'm better than you.")
						switch(input("[usr]:")in list("You are better than me.","Piss off, kid.","Uhh...No."))
							if("You are better than me.")
								alert(usr,"Konohamaru: Yes, I know.")
								alert(usr,"Konohamaru: Anyways. You basically throw a shuriken like this...")
								usr.sight|=BLIND
								sleep(34)
								alert(usr,"Konohamaru: And then as soon as you do that...")
								sleep(34)
								alert(usr,"Konohamaru: See! It's a good way to save weaponry too.")
								sleep(34)
								alert(usr,"Konohamaru: Handseals are like this...")
								sleep(34)
								usr.sight&=~BLIND
								alert(usr,"Konohamaru: Ok. I think you got it.")
								alert(usr,"Konohamaru: You better thank me later when this saves your ass!")
								usr<<"<b><font color=lime>You have learned Shuriken Clone Jutsu. When you use a shuriken type jutsu, you can press this jutsu quickly to make a duplicate of the projectile. At higher levels the range increases and it spreads more."
								new/obj/jutsu/Shuriken_Clone_Jutsu(usr)
							if("Piss off, kid.")
								alert(usr,"Konohamaru: Screw you! Wait until my bodyguard hears about this!")
								alert(usr,"[src]: ...Bodyguard?")
							if("Uhh...No.")
								alert(usr,"Konohamaru: Fine. You'll regret it.")
			Teuchi
				name="(NPC)Teuchi(Leaf)"
				village="Leaf"
				mouse_over_pointer='cursorleaf.dmi'
				icon_state="Teuchi"
				clan="None"
				rank="Civilian"
				level=8
			Ayame
				name="(NPC)Ayame(Leaf)"
				village="Leaf"
				mouse_over_pointer='cursorleaf.dmi'
				icon_state="Ayame"
				clan="None"
				rank="Civilian"
				level=3
			Kakuzu
				name="(NPC)Kakuzu(Akatsuki)"
				village="Akatsuki"
				clan="Grudge"
				icon='Akatsuki.dmi'
				icon_state="Kakuzu"
				rank="S-Ranked Criminal"
				level=79
			Hidan
				name="(NPC)Hidan(Akatsuki)"
				village="Akatsuki"
				clan="Jashin"
				icon='Akatsuki.dmi'
				icon_state="Hidan"
				rank="S-Ranked Criminal"
				level=64
			Kisame
				name="(NPC)Kisame(Akatsuki)"
				village="Akatsuki"
				clan="Shark"
				icon='Akatsuki.dmi'
				icon_state="Kisame"
				rank="S-Ranked Criminal"
				level=81
			Itachi
				name="(NPC)Itachi(Akatsuki)"
				village="Akatsuki"
				clan="Uchiha"
				icon='Akatsuki.dmi'
				icon_state="Itachi"
				rank="S-Ranked Criminal"
				level=87
			Pein
				name="(NPC)Pein(Akatsuki)"
				village="Akatsuki"
				clan="Six Paths"
				icon='Akatsuki.dmi'
				icon_state="Pein"
				rank="S-Ranked Criminal"
				level=118
			Konan
				name="(NPC)Konan(Akatsuki)"
				village="Akatsuki"
				clan="Origami"
				icon='Akatsuki.dmi'
				icon_state="Konan"
				rank="S-Ranked Criminal"
				level=83
			Sasori
				name="(NPC)Sasori(Akatsuki)"
				village="Akatsuki"
				clan="Puppeteer"
				icon='Akatsuki.dmi'
				icon_state="Sasori"
				rank="S-Ranked Criminal"
				level=77
			Deidara
				name="(NPC)Deidara(Akatsuki)"
				village="Akatsuki"
				clan="Clay"
				icon='Akatsuki.dmi'
				icon_state="Diedera"
				rank="S-Ranked Criminal"
				level=71
			Tobi
				name="(NPC)Tobi(Akatsuki)"
				village="Akatsuki"
				clan="Uchiha"
				icon='Akatsuki.dmi'
				icon_state="Tobi"
				rank="S-Ranked Criminal"
				density=0
				level=121
				New()
					..()
					loop
						invisibility=1
						loc=locate(rand(100,500),rand(100,500),pick(1,2))
						spawn(42)
							invisibility=10
							spawn(6000)goto loop
		mission
			Bump(mob/A)
				..()
				if(ismob(A))
					if(attacking)return
					if(aff==A.aff)return
					if(A.illusion)
						A.illusionhit(src)
						return
					var/damage=round(apow/3)+rand(3,5)
					A.dmgch(src,1)
					damage=(damage*A.variable)+A.variable2
					A.damage(damage)
					if(prob(50))flick("attack",src)
					else flick("attack",src)
					A.soundeff(pick('punch.wav','punch2.wav','punch3.wav'),35,0)
					A.death(src)
					attacking=1
					spawn(15/(attackdelay/100))
					attacking=0
			Sasuke
				icon='base.dmi'
				var/chidori=0
				var/mob/owner=null
				Move()
					..()
					if(chidori)moving=0
				New()
					name="Uchiha Sasuke"
					hair='sasukehair.dmi'
					Str=8
					Tai=12
					Nin=15
					Hsl=12
					Int=10
					Sta=10
					Spd=13
					level=73
					village="None"
					clan="Uchiha"
					rank="A-Ranked Criminal"
					sharingan=3
					statset()
					hp=maxhp
					cha=maxcha
					barset()
					shoes+=/obj/shoes
					shirt+=/obj/uchihashirt
					pant+=/obj/blackshorts
					headband+=/obj/headbando
					overlay()
					..()
					spawn(2)sasukeproc()
				Bump()
					..()
					if(chidori==1)
						for(var/mob/M in get_step(src,dir))
							if(M.illusion)
								M.illusionhit(src)
								return
							new/obj/crater(M.loc)
							var/damage=round(pow*2)
							M.dmgch(src,1)
							damage=(damage*M.variable)+M.variable2
							M.damage(damage,1)
							new/obj/crater(M.loc)
							faceme(M)
							M.stepback(4,1)
							M.soundeff('mountain.wav',40,0)
							stepback(3)
							spawn(7)if(M)M.death(src)
						chidori=2
						spawn(200)chidori=0
						icon_state=""
						overlays-=/obj/chidori
				proc
					sasukeproc()
						if(dead)return
						if(!owner)del src
						if(owner.z!=5)del src
						walk(src,0)
						if(hp<maxhp/2&&!curseseal)
							curseseal=3
							range(12)<<"<b><font color='#990099'>Sasuke's curse seal activated."
							pow+=25
							apow+=25
							hp+=150
							maxhp+=75
							range(src,10)<<"<font color=silver>[src]: With this power...I will avenge my clan!"
							overlay()
						if(chidori==1)
							walk_towards(src,owner)
							spawn(7)sasukeproc()
							return
						var/Z=0
						if(y==owner.y||x==owner.x)Z=1
						if(Z&&prob(80))
							owner.faceme2(src)
							if(prob(50))
								if(prob(50))flick("attack",src)
								else flick("attack",src)
								var/L=new/obj/proj/breakable/Shuriken(loc)
								L:owner=src
								walk(L,dir)
							else
								var/G=pick(1,2,3,4,5)
								switch(G)
									if(1)
										range(src,10)<<"<font color=silver>[src]: Vengeance is mine!"
										sasukechidori()
									if(2,3)fireballjutsu()
									if(4)
										phoenixflower()
										spawn(3)stepback(5)
									if(5)
										dragonflames()
										spawn(3)stepback(5)
						else
							var/c=75
							for(var/mob/G in oview(2,src))if(G==owner)c=80
							if(prob(c))
								walk_to(src,owner,1)
								for(var/mob/G in oview(1,src))
									if(G==owner)
										if(prob(80))
											walk_towards(src,owner)
										else
											range(src,10)<<"<font color=silver>[src]: I will destroy you!"
											stepup(3)
											spawn(3)falcondrop()
							else
								new/obj/flashstep(loc)
								invisibility+=5
								spawn(3)
									invisibility-=5
								stepback(3)
						spawn(7)sasukeproc()
			Bandit
				icon='baseblacker.dmi'
				var/mob/owner=null
				New()
					name="Bandit"
					hair='afrohair.dmi'
					Str=3
					Tai=4
					Nin=1
					Hsl=1
					Int=1
					Sta=3
					Spd=4
					level=11
					village="None"
					clan="None"
					rank="D-Ranked Criminal"
					statset()
					hp=maxhp
					cha=maxcha
					var/B1=new/obj/bars/healthbar(loc)
					B1:barowner=src
					mybar=B1
					B1:updatebar()
					shoes+=/obj/shoes
					shirt+=/obj/shirtgrey
					gloves+=/obj/platedgloves
					pant+=/obj/pantsblack
					kunaipouch=/obj/kunaipouch
					weapon=/obj/kunaiweap
					overlay()
					..()
					spawn(0)new/obj/smoke(loc)
					spawn(2)banditproc()
				proc
					banditproc()
						if(dead)return
						if(!owner)del src
						if(owner.z!=z)del src
						walk(src,0)
						walk_to(src,owner,1)
						for(var/mob/G in oview(1,src))
							if(G==owner)
								walk_towards(src,owner)
						spawn(7)banditproc()
		killable
			var
				stat1
				stat2
				bannerman=0
				movedyea=0
				Z2
				szx
				szy
				mob/owner=null
			random
				Move()
					if(stun||freeze)return
					..()
					movedyea=1
				New()
					var/insertname=pick("Sakurasou","Otonabi","Suzaku","Sasami","Karuji","Kureno","Watanabe","Masaki","Ryuujin","Naritada","Mokuba","Kaiba","Matsushita","Daishichirou","Myouji","Toshiyuki","Nikaidou","Kazutsune","Togourou","Jou","Kyosuke","Suzuku","Ryosuke","Kai","Ishida","Rai","Ingram","Daisuke","Kirigaya")
					name="(NPC)[insertname]([village])"
					hair=pick('womanhair.dmi','windyhair.dmi','weirdhair.dmi','vegetahair.dmi','tayuyahair.dmi','nejihair.dmi','longhair.dmi','ninjahair.dmi','afrohair.dmi','asumahair.dmi','cloudhair.dmi','deidarahair.dmi','irukahair.dmi','itachihair.dmi','mohawkhair.dmi','kakashihair.dmi')
					icon=pick('base.dmi','basetan.dmi','baseblack.dmi','baseblacker.dmi')
					eye=pick('blackeyes.dmi','blueeyes.dmi','ambereyes.dmi','greeneyes.dmi','browneyes.dmi')
					hair_red=rand(0,150)
					hair_green=rand(0,150)
					hair_blue=rand(0,150)
					Str=rand(stat1,stat2)
					Tai=rand(stat1,stat2)
					Nin=rand(stat1,stat2)
					Hsl=rand(stat1,stat2)
					Int=rand(stat1,stat2)
					Sta=rand(stat1,stat2)
					Spd=rand(stat1,stat2)+6
					level=Str+Tai+Nin+Hsl+Int+Sta+Spd-8
					statset()
					affcheck()
					cha=maxcha
					hp=maxhp
					..()
					spawn(1)
						Z2=0
						szx=x
						szy=y
				Bump(mob/A)
					..()
					if(ismob(A))
						if(attacking)return
						if(aff==A.aff)return
						if(A.illusion)
							A.illusionhit(src)
							return
						var/damage=round(apow/3)+rand(3,5)
						A.dmgch(src,1)
						damage=(damage*A.variable)+A.variable2
						A.damage(damage)
						A.soundeff(pick('punch.wav','punch2.wav','punch3.wav'),35,0)
						if(prob(50))flick("attack",src)
						else flick("attack",src)
						A.death(src)
						attacking=1
						spawn(15/(attackdelay/100))
						attacking=0
				Del()
					if(spawnowner)spawnowner:spawnproc()
					..()
				leafcombatelite
					icon='base.dmi'
					village="Leaf"
					stat1=20
					stat2=30
					rundelay=2
					rank="ANBU"
					mouse_over_pointer='cursorleaf.dmi'
					New()
						..()
						mask=/obj/anbuleaf
						fullbody=/obj/anbusuit
						gloves=/obj/platedgloves
						weapon=/obj/katana
						usr.weaponsh=/obj/katanash
						overlay()
						spawn(7)
							if(!bannerman)
								combatproc()
							else
								combatbannerproc()
				sandcombatelite
					icon='base.dmi'
					village="Sand"
					stat1=20
					stat2=30
					rank="ANBU"
					mouse_over_pointer='cursorsand.dmi'
					New()
						..()
						mask=/obj/anbusand
						fullbody=/obj/anbusuit
						gloves=/obj/platedgloves
						weapon=/obj/katana
						usr.weaponsh=/obj/katanash
						overlay()
						spawn(7)
							if(!bannerman)
								combatproc()
							else
								combatbannerproc()
				soundcombatelite
					icon='base.dmi'
					village="Sound"
					stat1=20
					stat2=30
					rank="ANBU"
					mouse_over_pointer='cursorsound.dmi'
					New()
						..()
						mask=/obj/anbusound
						fullbody=/obj/anbusuit
						gloves=/obj/platedgloves
						weapon=/obj/katana
						belt=/obj/serpentbelt
						usr.weaponsh=/obj/katanash
						overlay()
						spawn(7)
							if(!bannerman)
								combatproc()
							else
								combatbannerproc()
				leafcombatguy
					icon='base.dmi'
					village="Leaf"
					stat1=5
					stat2=10
					rundelay=2
					rank="Chunin"
					mouse_over_pointer='cursorleaf.dmi'
					New()
						..()
						shirt=/obj/leafunderup
						armor=/obj/leafjacket
						pant=/obj/pantsblue
						gloves=/obj/platedgloves
						shoes=/obj/shoes2
						kunaipouch=/obj/kunaipouch
						overlay()
						spawn(7)
							if(!bannerman)
								combatproc()
							else
								combatbannerproc()
				sandcombatguy
					icon='base.dmi'
					village="Sand"
					stat1=5
					stat2=10
					rank="Chunin"
					mouse_over_pointer='cursorsand.dmi'
					New()
						..()
						shirt=/obj/shirtblack
						armor=/obj/sandjacket
						pant=/obj/pantsblack
						gloves=/obj/platedgloves
						shoes=/obj/shoes2
						kunaipouch=/obj/kunaipouch
						overlay()
						spawn(7)
							if(!bannerman)
								combatproc()
							else
								combatbannerproc()
				soundcombatguy
					icon='base.dmi'
					village="Sound"
					stat1=6
					stat2=13
					rank="Chunin"
					mouse_over_pointer='cursorsound.dmi'
					New()
						..()
						shirt=/obj/shirtblack
						armor=/obj/soundjacket
						pant=/obj/pantsblack
						gloves=/obj/platedgloves
						shoes=/obj/shoes2
						belt=/obj/serpentbelt
						kunaipouch=/obj/kunaipouch
						overlay()
						spawn(7)
							if(!bannerman)
								combatproc()
							else
								combatbannerproc()
				proc
					combatbannerproc()
						if(dead)return
						if(z==1)del src
						walk(src,0)
						if(aggro||target)
							for(var/mob/M in oview(12,src))
								if(M==aggro||M==target)
									if(aff==M.aff)continue
									Z2=3
									var/Z=0
									if(y==M.y||x==M.x)Z=1
									if(Z&&prob(50))
										M.faceme2(src)
										if(prob(60))
											if(prob(50))flick("attack",src)
											else flick("attack",src)
											var/L=new/obj/proj/breakable/Kunai(loc)
											L:owner=src
											walk(L,dir)
										else
											if(prob(75))
												if(village=="Leaf")fuumashuriken()
												if(village=="Sand")windpressureblast()
												if(village=="Sound")strikingsnake()
												//if(village=="None")
											else
												if(prob(75))
													if(village=="Leaf")fireballjutsu()
													if(village=="Sound")shurikenbarrage()
													if(village=="Sand")sandstorm()
													//if(village=="None")
												else substitution()
									else
										var/c=100
										for(var/mob/G in oview(2,src))if(G==M)c=80
										if(prob(c))
											walk_to(src,M,1)
											for(var/mob/G in oview(1,src))if(G==M)walk_towards(src,M)
										else stepback(5)
									break
							spawn(7)combatbannerproc()
						else
							if(movedyea)
								if(x==szx&&y==szy)
									dir=SOUTH
									hp=maxhp
									cha=maxcha
									movedyea=0
									spawn(30)combatbannerproc()
								else
									Z2--
									if(Z2<=0)
										new/obj/tele(loc)
										x=szx
										y=szy
										new/obj/tele(loc)
										barloc()
									spawn(35)combatbannerproc()
							else
								spawn(30)combatbannerproc()
					combatproc()
						if(dead)return
						if(z==1)del src
						walk(src,0)
						if(aggro||target)
							for(var/mob/M in oview(12,src))
								if(M==aggro||M==target)
									if(M.npc>=2||aff==M.aff)continue
									Z2=3
									var/Z=0
									if(y==M.y||x==M.x)Z=1
									if(Z&&prob(50))
										M.faceme2(src)
										if(prob(60))
											if(prob(50))flick("attack",src)
											else flick("attack",src)
											var/L=new/obj/proj/breakable/Kunai(loc)
											L:owner=src
											walk(L,dir)
										else
											if(prob(75))
												if(village=="Leaf")fuumashuriken()
												if(village=="Sand")windpressureblast()
												if(village=="Sound")strikingsnake()
												//if(village=="None")
											else
												if(prob(75))
													if(village=="Leaf")fireballjutsu()
													if(village=="Sound")shurikenbarrage()
													if(village=="Sand")sandstorm()
													//if(village=="None")
												else substitution()
									else
										var/c=100
										for(var/mob/G in oview(2,src))if(G==M)c=80
										if(prob(c))
											walk_to(src,M,1)
											for(var/mob/G in oview(1,src))if(G==M)walk_towards(src,M)
										else stepback(5)
									break
							spawn(7)combatproc()
						else
							for(var/mob/M in oview(4))
								if(M.npc>=2||aff==M.aff)continue
								M.aggro(src)
								break
							if(target)
								spawn(7)combatproc()
							else
								if(spawnowner&&movedyea)
									if(loc==spawnowner.loc)
										dir=SOUTH
										hp=maxhp
										cha=maxcha
										movedyea=0
										spawn(30)combatproc()
									else
										Z2--
										if(Z2<=0)
											new/obj/tele(loc)
											loc=spawnowner.loc
											new/obj/tele(loc)
											barloc()
										spawn(35)combatproc()
								else
									spawn(30)combatproc()
			unique
				Move()
					if(stun||freeze)return
					..()
				New()
					icon=pick('base.dmi','basetan.dmi','baseblack.dmi','baseblacker.dmi')
					..()
				Bump(mob/A)
					..()
					if(ismob(A))
						if(attacking)return
						if(aff==A.aff)return
						if(A.illusion)
							A.illusionhit(src)
							return
						var/damage=round(apow/3)+rand(3,5)
						A.dmgch(src,1)
						damage=(damage*A.variable)+A.variable2
						A.damage(damage)
						if(prob(50))flick("attack",src)
						else flick("attack",src)
						A.death(src)
						attacking=1
						spawn(15/(attackdelay/100))
						attacking=0
				roguedude
					village="Rock"
					rank="C-Ranked Criminal"
					demon=1
					New()
						..()
						name="Rogue Shinobi(NPC)"
						icon=pick('base.dmi','basetan.dmi','baseblack.dmi','baseblacker.dmi')
						overlays+=/obj/blackclothmask
						overlays+=/obj/facemask
						overlays+=/obj/shirtblack
						overlays+=/obj/pantsblack
						overlays+=/obj/shoes2
						overlays+=/obj/platedgloves
						overlays+=/obj/kunaipouch
						barset()
						affcheck()
						spawn(7)rogueproc()
				proc
					rogueproc()
						if(dead)return
						if(!owner||owner.weedpick>=15||owner.mission!="Missing-Nin Hideout (B Rank)")del src
						walk(src,0)
						for(var/mob/M in oview(16,src))
							if(M!=owner)continue
							var/Z=0
							if(y==M.y||x==M.x)Z=1
							if(Z&&prob(50))
								M.faceme2(src)
								if(prob(65))
									if(prob(50))flick("attack",src)
									else flick("attack",src)
									var/L=new/obj/proj/breakable/Shuriken(loc)
									L:owner=src
									walk(L,dir)
								else
									var/G=pick(1,2,4,5,6)
									switch(G)
										if(1)strikingsnake()
										if(2)fireballjutsu()
										if(4)sandstorm()
										if(5)airblast()
										if(6)dragonflames()
							else
								var/c=100
								for(var/mob/G in oview(2,src))if(G==M)c=80
								if(prob(c))
									walk_to(src,M,1)
									for(var/mob/G in oview(1,src))if(G==M)walk_towards(src,M)
								else stepback(3)
							break
						spawn(7)rogueproc()
	Clone
		icon='base.dmi'
		animate_movement=2
		clayclone
			hp=1
			maxhp=1
			clone=1
			rundelay=0
			Move()
				return
				..()
			New()
				..()
				spawn(20)if(src)del src
			Bump()
				..()
				del src
			Del()
				if(mybar)del mybar
				if(mybar2)del mybar2
				var/obj/K=new/obj/explosion2(loc)
				K.owner=cloneowner
				if(!cloneowner)
					..()
					return
				for(var/mob/M in oview(src,3))
					if(M==cloneowner||M.clone)continue
					if(cloneowner.aff==M.aff)continue
					if(M.illusion)
						M.illusionhit(src)
						continue
					if(cloneowner.tier11)M.snared(cloneowner.tier11*0.2,2)
					var/damage=cloneowner.pow*1.20
					if(cloneowner.level>=48)damage*=1.1
					M.dmgch(cloneowner)
					damage=(damage*M.variable)+M.variable2
					var/critchance=0+(10*cloneowner.tier52)
					if(prob(critchance)&&cloneowner.tier52)
						if(cloneowner.tier62)
							M.stun(2.5*cloneowner.tier62)
							M.maimingshock(cloneowner)
						M.damage(damage,1.4)
					else
						M.damage(damage)
					M.death(cloneowner)
				..()
		boomclone
			hp=1
			maxhp=1
			clone=1
			rundelay=0
			Move()
				if(stun||freeze)return
				..()
			New()
				..()
				spawn(34)del src
			Bump()
				..()
				del src
			Del()
				if(mybar)del mybar
				if(mybar2)del mybar2
				new/obj/explosion(loc)
				var/F=new/obj/explosion(loc)
				if(!cloneowner)
					..()
					return
				if(cloneowner.tier51)if(prob(1+cloneowner.tier51*33))
					F:burn(cloneowner,25,5,2)
				for(var/mob/M in oview(src,2))
					if(M==cloneowner||M.clone)continue
					if(cloneowner.inchunin!=4)if(aff==M.aff)continue
					if(M.illusion)
						M.illusionhit(src)
						continue
					var/damage=cloneowner.pow*0.8
					M.dmgch(cloneowner)
					damage=(damage*M.variable)+M.variable2
					if(cloneowner.level>=75)damage*=1.25
					if(cloneowner.level>=120)M.stun(20)
					cloneowner.critroll(M)
					if(cloneowner.tier52)
						M.confusion(cloneowner.tier52*30)
					M.damage(damage)
					M.death(cloneowner)
				for(var/mob/M in oview(src,1))
					if(M.cloneowner==cloneowner||M==cloneowner||M.clone)continue
					if(cloneowner.inchunin!=4)if(aff==M.aff)continue
					if(M.illusion)
						M.illusionhit(src)
						continue
					var/damage=cloneowner.pow*0.5
					M.dmgch(cloneowner)
					damage=(damage*M.variable)+M.variable2
					if(cloneowner.level>=75)damage*=1.2
					if(cloneowner.level>=120)M.stun(20)
					cloneowner.critroll(M)
					if(cloneowner.tier52)
						M.confusion(cloneowner.tier52*30)
					M.damage(damage)
					M.death(cloneowner)
				..()
		clone
			hp=1
			maxhp=1
			clone=1
			rundelay=0
			icon_state="run"
			New()
				..()
				spawn(12)del src
			Bump(var/M)
				..()
				if(M==cloneowner)
					loc=M:loc
					return
				del src
			Del()
				if(mybar)del mybar
				if(mybar2)del mybar2
				if(cloneowner.clan=="Clay"&&cloneowner.tier42)
					var/obj/K=new/obj/explosion2(loc)
					K.owner=cloneowner
					for(var/mob/M in oview(src,3))
						if(M==cloneowner||M.clone)continue
						if(cloneowner.aff==M.aff)continue
						if(M.illusion)
							M.illusionhit(src)
							continue
						if(cloneowner.tier11)M.snared(cloneowner.tier11*0.2,2)
						var/damage=cloneowner.pow*(0.4*cloneowner.tier42)
						M.dmgch(cloneowner)
						damage=(damage*M.variable)+M.variable2
						var/critchance=0+(10*cloneowner.tier52)
						if(prob(critchance)&&cloneowner.tier52)
							if(cloneowner.tier62)
								M.stun(2.5*cloneowner.tier62)
								M.maimingshock(cloneowner)
							M.damage(damage,1.4)
						else
							M.damage(damage)
						M.death(cloneowner)
				else
					new/obj/smoke(loc)
				..()
		shadowclone
			hp=1
			maxhp=1
			New()new/obj/smoke(loc)
			Bump(mob/A)
				..()
				if(ismob(A))
					if(attacking)return
					if(aff==A.aff)return
					if(A.illusion)
						A.illusionhit(src)
						return
					var/damage=round(apow/3)
					A.dmgch(src,1)
					damage=(damage*A.variable)+A.variable2
					A.damage(damage)
					if(prob(50))flick("attack",src)
					else flick("attack",src)
					A.soundeff(pick('punch.wav','punch2.wav','punch3.wav'),35,0)
					A.death(cloneowner)
					attacking=1
					spawn(15/(attackdelay/rand(70,120)))
					attacking=0
			Del()
				if(mybar)del mybar
				if(mybar2)del mybar2
				if(cloneowner.clan=="Clay"&&cloneowner.tier42)
					var/obj/K=new/obj/explosion2(loc)
					K.owner=cloneowner
					for(var/mob/M in oview(src,3))
						if(M==cloneowner||M.clone)continue
						if(cloneowner.inchunin!=4)if(aff==M.aff)continue
						if(M.illusion)
							M.illusionhit(src)
							continue
						if(cloneowner.tier11)M.snared(cloneowner.tier11*0.2,2)
						var/damage=cloneowner.pow*(0.1*cloneowner.tier42)
						M.dmgch(cloneowner)
						damage=(damage*M.variable)+M.variable2
						var/critchance=0+(10*cloneowner.tier52)
						if(prob(critchance)&&cloneowner.tier52)
							if(cloneowner.tier62)
								M.stun(2.5*cloneowner.tier62)
								M.maimingshock(cloneowner)
							M.damage(damage,1.4)
						else
							M.damage(damage)
						M.death(cloneowner)
				else
					new/obj/smoke(loc)
				..()
		waterclone
			hp=1
			maxhp=1
			New()
				..()
				spawn(140)del src
			Move()
				..()
				barloc()
			Bump(mob/A)
				..()
				if(ismob(A))
					if(attacking||aff==A.aff)return
					if(A.illusion)
						A.illusionhit(src)
						return
					var/damage=round(apow/3)
					A.dmgch(src,1)
					damage=(damage*A.variable)+A.variable2
					A.damage(damage)
					if(prob(50))flick("attack",src)
					else flick("attack",src)
					A.death(cloneowner)
					attacking=1
					spawn(15/(attackdelay/100))
					attacking=0
			Del()
				if(mybar)del mybar
				if(mybar2)del mybar2
				new/obj/waterdown(loc)
				..()
		sandclone
			hp=25
			maxhp=25
			New()new/obj/sandup(loc)
			Bump(mob/A)
				..()
				if(ismob(A))
					if(attacking)return
					if(aff==A.aff)return
					if(A.illusion)
						A.illusionhit(src)
						return
					var/damage=round((apow+pow)*0.20)+rand(6,11)
					A.dmgch(src,1)
					damage=(damage*A.variable)+A.variable2
					if(A.shield)damage=0
					A.damage(damage)
					flick("attack",src)
					A.death(cloneowner)
					attacking=1
					spawn(rand(15,20))
					attacking=0
			Del()
				if(mybar)del mybar
				if(mybar2)del mybar2
				new/obj/sanddown(loc)
				..()
		raidenclone
			hp=99999
			maxhp=99999
			Bump(mob/A)
				..()
				if(ismob(A))
					if(aff==A.aff)
						loc=A.loc
						return
					loc=A.loc
					var/damage
					if(cloneowner.apow>cloneowner.pow)
						damage=round(cloneowner.apow*1.1)
						A.dmgch(cloneowner,1)
					else
						damage=round(cloneowner.pow*1.1)
						A.dmgch(cloneowner)
					if(cloneowner.tier43)damage*=1+(cloneowner.tier43*0.10)
					if(cloneowner.level>=85)damage*=1.1
					damage=(damage*A.variable)+A.variable2
					if(A.shield)damage=0
					var/critchance=0+(cloneowner.tier43*5)
					if(prob(critchance))
						A.damage(damage,1.3)
					else
						A.damage(damage)
					if(cloneowner.level>=110)A.stun(7)
					A.death(cloneowner)
				if(isobj(A))loc=A.loc
				if(isturf(A))loc=A.loc
			Del()
				if(mybar)del mybar
				if(mybar2)del mybar2
				..()
		vwpclone
			hp=99999
			maxhp=99999
			New()spawn(12)if(src)del src
			Del()
				if(mybar)del mybar
				if(mybar2)del mybar2
				..()
	proc
		shadowclone()
			if(!cloneowner)del src
			walk(src,0)
			if(cloneowner.aggro||cloneowner.target)
				for(var/mob/M in oview(14,cloneowner))
					if(M==cloneowner.aggro||M==cloneowner.target)
						if(M.npc==2||aff==M.aff)continue
						walk_to(src,M,1)
						for(var/mob/G in oview(1,src))if(G==M)
							walk(src,0)
							moving=0
							walk_towards(src,M)
						continue
				spawn(7)shadowclone()
			else
				var/G=0
				for(var/mob/H in oview(2,src))if(H==cloneowner)
					G=1
					walk(src,0)
					dir=cloneowner.dir
				if(!G)walk_to(src,cloneowner,1)
				spawn(7)shadowclone()
obj
	Spawn_Point
		icon='spawnpoint.dmi'
		icon_state="new spawn"
		layer=150
		invisibility=10
		New()invisibility=10
		newspawn/icon_state="new spawn"
		newspawn2/icon_state="new spawn"
		newspawn3/icon_state="new spawn"
		newspawn4/icon_state="new spawn"
		missingnin/icon_state="new spawn2"
		leafcombatspawn
			New()

				..()
				var/mob/NPC/killable/random/leafcombatguy/T=new(loc)
				T.spawnowner=src
				T.barset()
			proc/spawnproc()
				spawn(3000)
					var/mob/NPC/killable/random/leafcombatguy/T=new(loc)
					T.spawnowner=src
					T.barset()
		sandcombatspawn
			New()

				..()
				var/mob/NPC/killable/random/sandcombatguy/T=new(loc)
				T.spawnowner=src
				T.barset()
			proc/spawnproc()
				spawn(3000)
					var/mob/NPC/killable/random/sandcombatguy/T=new(loc)
					T.spawnowner=src
					T.barset()
		soundcombatspawn
			New()

				..()
				var/mob/NPC/killable/random/soundcombatguy/T=new(loc)
				T.spawnowner=src
				T.barset()
			proc/spawnproc()
				spawn(3000)
					var/mob/NPC/killable/random/soundcombatguy/T=new(loc)
					T.spawnowner=src
					T.barset()
		leafelitespawn
			icon_state="new spawn2"
			New()

				..()
				var/mob/NPC/killable/random/leafcombatelite/T=new(loc)
				T.spawnowner=src
				T.barset()
			proc/spawnproc()
				spawn(3000)
					var/mob/NPC/killable/random/leafcombatelite/T=new(loc)
					T.spawnowner=src
					T.barset()
		sandelitespawn
			icon_state="new spawn2"
			New()

				..()
				var/mob/NPC/killable/random/sandcombatelite/T=new(loc)
				T.spawnowner=src
				T.barset()
			proc/spawnproc()
				spawn(3000)
					var/mob/NPC/killable/random/sandcombatelite/T=new(loc)
					T.spawnowner=src
					T.barset()
		soundelitespawn
			icon_state="new spawn2"
			New()

				..()
				var/mob/NPC/killable/random/soundcombatelite/T=new(loc)
				T.spawnowner=src
				T.barset()
			proc/spawnproc()
				spawn(3000)
					var/mob/NPC/killable/random/soundcombatelite/T=new(loc)
					T.spawnowner=src
					T.barset()
		leaf/icon_state="leaf"
		sand/icon_state="sand"
		sound/icon_state="sound"
		missing/icon_state="missing"
		akatsuki/icon_state="akatsuki"
		scroll1spawn/icon_state="scroll1spawn"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------------------------------------------------------------------------------//
///////////////////////////////////////////////Animals//////////////////////////////////////////////////////////////
//----------------------------------------------------------------------------------------------------------------//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
mob/var
	aggressive=0
	isanimal=0
	charge=0
	expdrop=0
	obj/spawnowner=null
mob
	Bees
		icon='bees.dmi'
		npc=2
		rundelay=0
		var/mob/owner=null
		New()
			..()
			spawn(140)del src
			loop
				spawn(1)
					step_towards(src,owner)
					goto loop
		Bump(T)
			..()
			if(istype(T,/mob/player))
				if(T==owner)
					faceme(T)
					T:stepback(6)
		Move()
			..()
			var/T=0
			for(var/obj/beenest/F in oview(16))T=1
			if(!T)del src
	Animal
		village="None"
		var
			hp1
			attack1=null
			attack2=null
			hp2
			movedyea=0
		isanimal=1
		New()
			statset()
			hp=maxhp
			affcheck()
			level=Str+Sta+Nin+Hsl+Tai+Spd+Int-6
			if(!istype(src,/mob/Animal/Lost_Cat))
				var/B1=new/obj/bars/healthbar(loc)
				B1:barowner=src
				mybar=B1
				B1:updatebar()
			..()
		Move()
			..()
			movedyea=1
		Bump(mob/A)
			..()
			if(ismob(A))
				if(!aggressive||attacking)return
				var/damage=apow/3
				if(charge)damage=apow/1.5
				if(A.illusion)
					A.illusionhit(src)
					return
				A.dmgch(src,1)
				damage=(damage*A.variable)+A.variable2
				A.soundeff('punch2.wav',40,0)
				A.damage(damage)
				A.death(src)
				attacking=1
				spawn(15/(attackdelay/100))attacking=0

			else
				moving=0
				spawn(1)
					if(dir==NORTH||dir==SOUTH)step(src,pick(EAST,WEST))
					else step(src,pick(NORTH,SOUTH))
		Del()
			if(name=="Boar(Animal)")soundeff('boardie.wav',40,0)
			name="Void Animal"
			if(spawnowner)spawnowner:spawnproc()
			..()
		Lost_Cat
			name="Lost Cat(Animal)"
			icon='cat.dmi'
			village="None"
			npc=2
			Sta=1
			Hsl=1
			Tai=1
			Nin=1
			Str=1
			Int=4
			Spd=7
			mouse_opacity=2
			rank="Weak Passive Animal"
			mouse_over_pointer='cursoranimal.dmi'
			Leaf
				Click()
					..()
					for(var/mob/player/Mz in range(src,1))
						if(Mz==usr)
							if(usr.mission=="Finding Lost Cat (D Rank)"&&usr.weedpick==0)
								usr.weedpick=1
								usr<<"<center><font color=yellow>You have caught the lost cat! Return to the kage house to get your reward."
								var/list/K=list()
								for(var/obj/Animal_Spawn_Point/runcatspawnleaf/M in world)K+=M
								var/S=pick(K)
								loc=S:loc
			Sand
				Click()
					..()
					for(var/mob/player/Mz in range(src,1))
						if(Mz==usr)
							if(usr.mission=="Finding Lost Cat (D Rank)"&&usr.weedpick==0)
								usr.weedpick=1
								usr<<"<center><font color=yellow>You have caught the lost cat! Return to the kage house to get your reward."
								var/list/K=list()
								for(var/obj/Animal_Spawn_Point/runcatspawnsand/M in world)K+=M
								var/S=pick(K)
								loc=S:loc
			Sound
				Click()
					..()
					for(var/mob/player/Mz in range(src,1))
						if(Mz==usr)
							if(usr.mission=="Finding Lost Cat (D Rank)"&&usr.weedpick==0)
								usr.weedpick=1
								usr<<"<center><font color=yellow>You have caught the lost cat! Return to the kage house to get your reward."
								var/list/K=list()
								for(var/obj/Animal_Spawn_Point/runcatspawnsound/M in world)K+=M
								var/S=pick(K)
								loc=S:loc
		Boar
			name="Boar(Animal)"
			icon='boar.dmi'
			village="None"
			Sta=7
			Hsl=1
			Tai=6
			Nin=1
			Str=8
			Int=2
			expdrop=20
			Spd=6
			aggressive=1
			rundelay=3
			rank="Strong Aggressive Animal"
			mouse_over_pointer='cursoranimal.dmi'
			New()
				..()
				spawn(70)
				boarproc()
		Demon_Boar
			name="Demon_Boar(Animal)"
			icon='demonboar.dmi'
			village="None"
			Sta=57
			Hsl=1
			Tai=36
			Nin=1
			Str=85
			Int=2
			expdrop=1500
			Spd=30
			aggressive=1
			rank="Demonic Aggressive Animal"
			mouse_over_pointer='cursoranimal.dmi'
			New()
				..()
				spawn(70)boarproc()
		Deer
			name="Deer(Animal)"
			icon='deer.dmi'
			Sta=3
			Hsl=1
			Tai=2
			Nin=1
			Str=2
			Int=6
			Spd=8
			expdrop=10
			rank="Medium Passive Animal"
			mouse_over_pointer='cursoranimal.dmi'
			rundelay=2
			var/DX
			var/DY
			var/DZ
			New()
				..()
				DX=x
				DY=y
				DZ=z
				spawn(70)
					maxhp/=2
					hp/=2
					deerproc()
		proc
			boarproc()
				if(dead)return
				walk(src,0)
				if(z==1)z=2
				if(aggro||target)
					for(var/mob/M in oview(12))
						if(M!=aggro&&M!=target)continue
						if(M.isanimal&&!M.aggressive||M.insnake||M.name=="Scarecrow"||M.name=="Banner"||M.name=="Cactus"||M.name=="Dummy"||M.npc)continue
						var/Z=0
						if(y==M.y||x==M.x)Z=1
						if(Z&&prob(20))
							M.faceme2(src)
							freeze=1
							flick("attack",src)
							spawn(7)
								freeze=0
								charge=1
								stepup(8)
								spawn(8)charge=0
						else
							walk_to(src,M,1)
							for(var/mob/G in oview(1))if(G==M)
								flick("attack",src)
								walk_towards(src,M)
						break
					spawn(7)boarproc()
				else
					for(var/mob/M in oview(6))
						if(M.isanimal&&!M.aggressive||M.name=="Scarecrow"||M.name=="Banner"||M.name=="Cactus"||M.name=="Dummy"||M.npc)continue
						M.aggro(src)
						break
					if(!target)
						if(spawnowner)
							if(movedyea)
								walk_to(src,spawnowner)
								if(loc==spawnowner.loc)
									movedyea=0
						else del src
					else
						walk_towards(src,target)
					spawn(20)boarproc()
			deerproc()
				if(dead)return
				step_rand(src)
				if(z==1)loc=locate(src:DX,src:DY,2)
				spawn(30)deerproc()


obj
	catimage
		icon='cat.dmi'
		icon_state="image"
		layer=60
	Animal_Spawn_Point
		icon='spawnpoint.dmi'
		icon_state="animalspawn"
		layer=150
		New()invisibility=10
		runcatspawnleaf
			icon_state="runcat"
		runcatspawnsand
			icon_state="runcat"
		runcatspawnsound
			icon_state="runcat"
		deerspawn
			icon_state="deer"
			New()
				..()
				var/T=new/mob/Animal/Deer(loc)
				T:spawnowner=src
			proc/spawnproc()
				spawn(rand(600,800))
					var/T=new/mob/Animal/Deer(loc)
					T:spawnowner=src
		boarspawn
			icon_state="boar"
			New()
				..()
				var/T=new/mob/Animal/Boar(loc)
				T:spawnowner=src
			proc/spawnproc()
				spawn(rand(800,1000))
					if(prob(99))
						var/T=new/mob/Animal/Boar(loc)
						T:spawnowner=src
					else
						var/T=new/mob/Animal/Demon_Boar(loc)
						T:spawnowner=src
		demonboarspawn
			icon_state="demonboar"
			New()
				..()
				var/T=new/mob/Animal/Deer(loc)
				T:spawnowner=src
			proc/spawnproc()
				spawn(9000)
					world<<"<b><font color=red><center>The demon boar has resurrected."
					var/T=new/mob/Animal/Demon_Boar(loc)
					T:spawnowner=src

//mob/proc/interact()
	//for(var/mob/M in )
mob/special
	Pumpkin
		name="Pumpkin"
		level=1
		village="None"
		maxhp=100000
		hp=100000
		icon='Pumpkin.dmi'
		New()
			..()
			var/B1=new/obj/bars/healthbar(loc)
			B1:barowner=src
			mybar=B1
			B1:updatebar()
		Del()
			new/obj/items/equippable/Pumpkin_Sword(loc)
			..()