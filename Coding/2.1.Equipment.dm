
obj/deathgod
	icon='deathgod.dmi'
	layer=200
	icon_state="map"
	New()
		icon_state=""
		..()

obj/items
	icon='items.dmi'
	mouse_opacity=2
	Mysterious_Horn
		icon_state="Mysterious Horn"
		Click()
			if(!usr.intut)del src
			if(usr.intut==14)
				usr.intut=16
				usr<<"<font color=red><b>You blow the horn. You feel a sinister sensation in your surroundings."
				fade.Map(usr, 70, 7, 20)
				usr<<"<center><b><u><font color=yellow>Mission Complete"
				usr<<"<center><b><font color=yellow>Blow the Horn (Rank D)"
				usr<<"<center><font color=yellow>You have earned 3 senryo"
				usr.senryo+=3
				usr.exp(30)
				alert(usr,"Alright. We don't have much time left so I'll quickly go over a few other things.")
				usr<<"<b><font color=silver>Minato Namikaze:</b> We don't have much time left so I'll quickly go over a few other things."
				alert(usr,"Right now, you are the most basic rank of Shinobi: an academy student.")
				usr<<"<b><font color=silver>Minato Namikaze:</b> Right now, you are the most basic rank of Shinobi: an academy student."
				alert(usr,"There are several ranks for Shinobis, with each rank receiving more power within the village and more responsibilties.")
				usr<<"<b><font color=silver>Minato Namikaze:</b> There are several ranks for Shinobis, with each rank receiving more power within the village and more responsibilties."
				alert(usr,"For a list of ranks and how to achieve them, press the Rank FAQ in your command tab.")
				usr<<"<b><font color=silver>Minato Namikaze:</b> For a list of ranks and how to achieve them, press the Rank FAQ in your command tab."
				var/T=new/obj/tutobj/arrowpointing
				T:screen_loc="3,4"
				T:dir=SOUTH
				usr.client.screen+=T
				alert(usr,"Whenever you do missions, defeat enemy villagers or contribute to your village in any way, you gain influence for your village.")
				usr<<"<b><font color=silver>Minato Namikaze: </b>Whenever you do missions, defeat enemy villagers or contribute to your village in any way, you gain influence for your village. "
				if(usr.village=="Leaf")
					alert(usr,"Your village is Leaf. The green bar to the left shows Leaf village's influence. It's currently at [leafrep]. When it hits 140%, your village will be in a golden age, and you will gain 50% more experience. ")
					usr<<"<b><font color=silver>Minato Namikaze: </b>Your village is Leaf. The grey bar to the right shows Leaf village's influence. It's currently at [leafrep], When it hits 140%, your village will be in a golden age, and you will gain 50% more experience. "
				if(usr.village=="Sand")
					alert(usr,"Your village is Sand. The brown bar in the middle shows Sand village's influence. It's currently at [sandrep]. When it hits 140%, your village will be in a golden age, and you will gain 50% more experience.")
					usr<<"<b><font color=silver>Minato Namikaze: </b>Your village is Sand. The grey bar to the right shows Sand village's influence. When it hits 140%, your village will be in a golden age, and you will gain 50% more experience. "
				if(usr.village=="Sound")
					alert(usr,"Your village is Sound. The grey bar to the right shows Sound village's influence. It's currently at [soundrep]. When it hits 140%, your village will be in a golden age, and you will gain 50% more experience.")
					usr<<"<b><font color=silver>Minato Namikaze: </b>Your village is Sound. The grey bar to the right shows Sound village's influence. When it hits 140%, your village will be in a golden age, and you will gain 50% more experience. "
				fade.Map(usr, 150, 7, 20)
				spawn()usr.shakedown3()
				del T
				alert(usr,"This place is getting unstable.")
				usr<<"<b><font color=silver>Minato Namikaze: </b>This place is getting unstable. "
				alert(usr,"That horn you blew earlier will send your spirit out of here. Blow it again to leave this place.")
				usr<<"<b><font color=silver>Minato Namikaze: </b>That horn you blew earlier will send your spirit out of here. Blow it again to leave this place. "
				alert(usr,"It's been my pleasure [usr].")
				usr<<"<b><font color=silver>Minato Namikaze: </b>It's been my pleasure [usr]. "
				fade.Map(usr, 200, 7, 20)
				usr.intut=17
				return
			if(usr.intut==17)
				usr.intut=0
				usr.endtut()
				del src
	Empty_Water_Container
		icon='items.dmi'
		icon_state="Empty Water Container"
		Click()
			..()
			if(usr.dead||usr.busy)return
			var/t=0
			for(var/turf/Waterfall/contain/G in range(usr,1))t=1
			if(t)
				var/g=new/obj/hideanim(usr.loc)
				var/count=5
				var/Y=usr.hp
				usr.busy="watertank"
				var/X=usr.loc
				usr<<"<b><center>You begin to fill the water tank"
				while(count)
					sleep(10)
					if(usr.hp<Y||X!=usr.loc)
						usr.busy=null
						if(g)del g
						return
					count--
				usr<<"<b><center>You have filled the water tank."
				new/obj/items/Full_Water_Container(usr)
				usr.busy=null
				del src
			else
				usr.trackwfall()
	Half_Full_Water_Container
		icon='items.dmi'
		icon_state="Half Full Water Container"
		Click()
			..()
			if(usr.dead||usr.busy)return
			var/t=0
			for(var/turf/Waterfall/contain/G in range(usr,1))t=1
			if(t)
				var/g=new/obj/hideanim(usr.loc)
				var/count=5
				var/Y=usr.hp
				usr.busy="watertank"
				var/X=usr.loc
				usr<<"<b><center>You begin to fill the water tank"
				while(count)
					sleep(10)
					if(usr.hp<Y||X!=usr.loc)
						usr.busy=null
						if(g)del g
						return
					count--
				usr<<"<b><center>You have filled the water tank."
				new/obj/items/Full_Water_Container(usr)
				usr.busy=null
				del src
			else
				usr.trackwfall()
	Captured_Boar
		icon='items.dmi'
		icon_state="Captured Boar"
	Full_Water_Container
		icon='items.dmi'
		icon_state="Full Water Container"
	Babysitting_Mission_Proof
		icon='items.dmi'
		icon_state="Mission Proof"
	Fake_Cheque
		icon='items.dmi'
		icon_state="Fake Cheque"
	Vest_Shipment
		icon='items.dmi'
		icon_state="Vest Shipment"
	Burned_Bee_Nest
		icon='items.dmi'
		icon_state="Bee Nest"
	Deer_Pelt
		icon='items.dmi'
		icon_state="Deer Pelt"
	Paint
		icon='items.dmi'
		icon_state="Paint"
	Paint2
		name="Paint"
		icon='items.dmi'
		icon_state="Paint"
	Secret_Scroll_I
		icon='items.dmi'
		icon_state="Secret Scroll I"
		verb
			Use()
				if(usr.sclonelearned)
					usr<<"<b>You already know the contents of this scroll."
					return
				usr<<"<b><font color=lime>You have learned Shadow Clone Jutsu!"
				new/obj/jutsu/Shadow_Clone_Jutsu(usr)
				usr.sclonelearned=1
				usr.exp(500)
				usr.soundeff('scroll.wav',100,1)
				var/list/K=list()
				for(var/obj/Spawn_Point/scroll1spawn/M in world)K+=M
				var/S=pick(K)
				loc=S:loc
				var/D=0
				for(var/obj/items/Secret_Scroll_I/M in world)D++
				if(D>=3)del src
			Drop()
				loc=locate(usr.x,usr.y,usr.z)
				usr.soundeff('scroll.wav',100,1)
			Pick_Up()
				set src in oview(1)
				loc=usr
				usr<<"You picked up a [src]."
				usr.soundeff('scroll.wav',100,1)
	Random_Armor_Scroll
		icon='items.dmi'
		icon_state="Scroll of Secrets"
		verb
			Use()
				var/n=rand(1,10)
				if(n==1)
					new/obj/items/equippable/Shadow_Guard_Armor(usr)
					usr<<"<b>You have obtained a Shadow Guard Armor"
				if(n==2)
					new/obj/items/equippable/Ember_Cloak(usr)
					usr<<"<b>You have obtained a Ember Cloak"
				if(n==3)
					new/obj/items/equippable/Warbringer(usr)
					usr<<"<b>You have obtained a Warbringer"
				if(n==4)
					new/obj/items/equippable/Shadow_Pact_Gear(usr)
					usr<<"<b>You have obtained a Shadow Pact Gear"
				if(n==5)
					new/obj/items/equippable/Ice_Wolf_Armor(usr)
					usr<<"<b>You have obtained a Ice Wolf Armor"
				if(n==6)
					new/obj/items/equippable/Blood_Exile_Armor(usr)
					usr<<"<b>You have obtained a Blood Exile Armor"
				if(n==7)
					new/obj/items/equippable/Mist_Demon_Suit(usr)
					usr<<"<b>You have obtained a Mist Demon Suit"
				if(n==8)
					new/obj/items/equippable/Combat_Armor(usr)
					usr<<"<b>You have obtained a Combat Armor"
				if(n==9)
					new/obj/items/equippable/Black_Cloak(usr)
					usr<<"<b>You have obtained a Black Cloak"
				if(n==10)
					new/obj/items/equippable/Moon_Guard_Armor(usr)
					usr<<"<b>You have obtained a Moon Guard Armor"
				del src
	Coordinates
		icon='items.dmi'
		icon_state="Coordinates"
		Click()
			..()
			usr.trackmnin()
	equippable
		Leaf_Anbu_Mask
			icon='Anbu Mask Leaf.dmi'
			armor="mask"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.rank!="ANBU"||usr.village!="Leaf")
							new/obj/landmine(usr.loc)
							new/obj/landmine(usr.loc)
							new/obj/landmine(usr.loc)
							new/obj/landmine(usr.loc)
							for(var/obj/landmine/M in usr.loc)M:detonate()
							del src
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="mask")
							O.equipped=0
							O.suffix=""
						if(equ)usr.mask=0
						else
							usr.mask=/obj/anbuleaf
							equipped=1
							suffix="Equipped - 10% damage increase"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Sand_Anbu_Mask
			icon='Anbu Mask Sand.dmi'
			armor="mask"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.rank!="ANBU"||usr.village!="Sand")
							new/obj/landmine(usr.loc)
							new/obj/landmine(usr.loc)
							new/obj/landmine(usr.loc)
							new/obj/landmine(usr.loc)
							for(var/obj/landmine/M in usr.loc)M:detonate()
							del src
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="mask")
							O.equipped=0
							O.suffix=""
						if(equ)usr.mask=0
						else
							usr.mask=/obj/anbusand
							equipped=1
							suffix="Equipped - 10% damage increase"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Sound_Anbu_Mask
			icon='Anbu Mask Sound.dmi'
			armor="mask"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.rank!="ANBU"||usr.village!="Sound")
							new/obj/landmine(usr.loc)
							new/obj/landmine(usr.loc)
							new/obj/landmine(usr.loc)
							new/obj/landmine(usr.loc)
							for(var/obj/landmine/M in usr.loc)M:detonate()
							del src
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="mask")
							O.equipped=0
							O.suffix=""
						if(equ)usr.mask=0
						else
							usr.mask=/obj/anbusound
							equipped=1
							suffix="Equipped - 10% damage increase"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Kisame_Ring
			icon='akatrings.dmi'
			icon_state="kisame"
			armor="special"
			proc
				Use()
					if(usr)
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="special")
							O.equipped=0
							O.suffix=""
						if(equ)usr.special=0
						else
							usr.special=/obj/kisamering
							equipped=1
							suffix="Equipped - +20% melee damage increase"
						usr.overlay()
			Click()Use()
		Itachi_Ring
			icon='akatrings.dmi'
			icon_state="itachi"
			armor="special"
			proc
				Use()
					if(usr)
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="special")
							O.equipped=0
							O.suffix=""
						if(equ)usr.special=0
						else
							usr.special=/obj/itachiring
							equipped=1
							suffix="Equipped - +15% defense penetration"
						usr.overlay()
			Click()Use()
		Oro_Ring
			icon='akatrings.dmi'
			icon_state="oro"
			armor="special"
			proc
				Use()
					if(usr)
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="special")
							O.equipped=0
							O.suffix=""
						if(equ)usr.special=0
						else
							usr.special=/obj/ororing
							equipped=1
							suffix="Equipped - +50% regen"
						usr.overlay()
			Click()Use()
		Pein_Ring
			icon='akatrings.dmi'
			icon_state="pein"
			armor="special"
			proc
				Use()
					if(usr)
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="special")
							O.equipped=0
							O.suffix=""
						if(equ)
							usr.special=0
							for(var/obj/jutsu/Akatsuki_Summon/M in usr)del M
						else
							usr.special=/obj/peinring
							equipped=1
							suffix="Equipped - Learned summoning jutsu"
							var/S=0
							for(var/obj/jutsu/Akatsuki_Summon/M in usr)S=1
							if(!S)new/obj/jutsu/Akatsuki_Summon(usr)
						usr.overlay()
			Click()Use()
		Kakazu_Ring
			icon='akatrings.dmi'
			icon_state="kakazu"
			armor="special"
			proc
				Use()
					if(usr)
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="special")
							O.equipped=0
							O.suffix=""
						if(equ)usr.special=0
						else
							usr.special=/obj/kakazuring
							usr.atkdef()
							equipped=1
							suffix="Equipped - +20% defense"
						usr.overlay()
			Click()Use()
		Face_Mask
			icon='Face Mask.dmi'
			armor="mask"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="mask")
							O.equipped=0
							O.suffix=""
						if(equ)usr.mask=0
						else
							usr.mask=/obj/facemask
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Gilgamesh
			icon='Gilgamesh.dmi'
			armor="mask"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="mask")
							O.equipped=0
							O.suffix=""
						if(equ)usr.mask=0
						else
							usr.mask=/obj/gilgamesh
							equipped=1
							suffix="Equipped - 100% damage reduction"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Spiral_Mask
			icon='Spiral Mask.dmi'
			armor="mask"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="mask")
							O.equipped=0
							if(usr.GM==3)usr.density=1
							O.suffix=""
						if(equ)usr.mask=0
						else
							usr.mask=/obj/spiralmask
							if(usr.GM==3)usr.density=0
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Mask_of_the_Mist
			icon='Mask of the Mist.dmi'
			armor="mask"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="mask")
							O.equipped=0
							O.suffix=""
						if(equ)usr.mask=0
						else
							usr.mask=/obj/mistmask
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					if(usr.clan!="Yuki")
						usr<<"<b>The mask disintegrates."
						del src
					loc=usr
					usr<<"You picked up a [src]."
		Shinobi_Headband
			icon='Shinobi Headband.dmi'
			armor="headband"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="headband")
							O.equipped=0
							O.suffix=""
						if(equ)usr.headband=0
						else
							usr.headband=usr.hstyle
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Change_Style()
					switch(input("Where do you want to wrap your shinobi headband around?")in list("Forehead(Under)","Forehead(Over)","Forehead(Sideways)","Left Arm","Right Arm","Right Leg","Waist"))
						if("Forehead(Under)")usr.headband=/obj/headband
						if("Forehead(Over)")usr.headband=/obj/headbando
						if("Forehead(Sideways)")usr.headband=/obj/headbandss
						if("Left Arm")usr.headband=/obj/headbandla
						if("Right Arm")usr.headband=/obj/headbandra
						//if("Right Leg")usr.headband=/obj/headbandrl
						if("Right Leg")usr.headband=/obj/headbandrl
						if("Waist")usr.headband=/obj/headbandws
					usr.hstyle=usr.headband
					usr.overlay()
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Black_Shinobi_Headband
			icon='Black Shinobi Headband.dmi'
			armor="headband"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="headband")
							O.equipped=0
							O.suffix=""
						if(equ)usr.headband=0
						else
							usr.headband=/obj/blackheadband
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Weights
			icon='weights.dmi'
			icon_state="inv"
			proc
				Use()
					if(usr)
						if(usr.henge)return
						if(usr.weights)
							usr.weights=0
							usr.specmove=0
							suffix=""
						else
							usr.weights=1
							usr.specmove=1
							suffix="Equipped - Feeds experience into Speed or Strength"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Combat_Helmet
			icon='Combat Helmet.dmi'
			armor="headgear"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="headgear")
							O.equipped=0
							O.suffix=""
						if(equ)usr.headgear=0
						else
							usr.headgear=/obj/combathelmet
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Hunters_Cap
			icon='Hunters Cap.dmi'
			armor="headgear"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="headgear")
							O.equipped=0
							O.suffix=""
						if(equ)usr.headgear=0
						else
							usr.headgear=/obj/hunterscap
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Straw_Hat
			icon='Straw Hat.dmi'
			armor="headgear"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="headgear")
							O.equipped=0
							O.suffix=""
						if(equ)usr.headgear=0
						else
							usr.headgear=/obj/strawhat
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Half_Helmet
			icon='Half Helmet.dmi'
			armor="headgear"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="headgear")
							O.equipped=0
							O.suffix=""
						if(equ)usr.headgear=0
						else
							usr.headgear=/obj/halfhelmet
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Cloth_Mask
			icon='Cloth Mask.dmi'
			armor="headgear"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="headgear")
							O.equipped=0
							O.suffix=""
						if(equ)usr.headgear=0
						else
							usr.headgear=/obj/clothmask
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Black_Cloth_Mask
			icon='Black Cloth Mask.dmi'
			armor="headgear"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="headgear")
							O.equipped=0
							O.suffix=""
						if(equ)usr.headgear=0
						else
							usr.headgear=/obj/blackclothmask
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Sombraro
			icon='Sombraro.dmi'
			armor="headgear"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="headgear")
							O.equipped=0
							O.suffix=""
						if(equ)usr.headgear=0
						else
							usr.headgear=/obj/sombraro
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Merchants_Hat
			name="Merchant's Hat"
			icon='Merchants Hat.dmi'
			armor="headgear"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="headgear")
							O.equipped=0
							O.suffix=""
						if(equ)usr.headgear=0
						else
							usr.headgear=/obj/merchantshat
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Serpent_Belt
			icon='Serpent Belt.dmi'
			icon_state="inv"
			armor="belt"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="belt")
							O.equipped=0
							O.suffix=""
						if(equ)usr.belt=0
						else
							usr.belt=/obj/serpentbelt
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
		Waist_Scarf
			icon='Waist Scarf.dmi'
			icon_state="inv"
			armor="belt"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="belt")
							O.equipped=0
							O.suffix=""
						if(equ)usr.belt=0
						else
							usr.belt=/obj/waistscarf
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
		Boxing_Gloves
			icon='Boxing Gloves.dmi'
			icon_state="inv"
			armor="weapon"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						if(usr.clan=="Hyuuga")
							usr<<"Gentle palm requires your hands to be unencumbered."
							return
						var/equ=equipped
						usr.wdmg=0
						for(var/obj/items/O in usr.contents)if(O.armor=="weapon")
							O.equipped=0

							O.suffix=""
						if(equ)
							usr.weaponsh=0
							usr.weapon=0
						else
							usr.weapon=/obj/boxinggloves
							usr.weaponsh=/obj/boxinggloves
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
		Handheld_Kunai
			icon='Handheld Kunai.dmi'
			icon_state="inv"
			armor="weapon"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.clan=="Hyuuga")
							usr<<"Gentle palm requires your hands to be unencumbered."
							return
						if(usr.henge)return
						var/equ=equipped
						usr.wdmg=0
						for(var/obj/items/O in usr.contents)if(O.armor=="weapon")
							O.equipped=0

							O.suffix=""
						if(equ)
							usr.weaponsh=0
							usr.weapon=0
						else
							usr.weapon=/obj/kunaiweap
							usr.weaponsh=/obj/kunaiweap
							equipped=1
							suffix="Equipped - +6 attack power, handseal speed(-25%)"
							usr.wdmg=2
						usr.overlay()
			Click()Use()
			verb
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
		Bone_Sword
			icon='bonesword.dmi'
			icon_state="inv"
			armor="weapon"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.clan == "Hyuuga")
							usr << "Gentle palm requires your hands to be unencumbered."
							return
						if(usr.henge)
							return
						var/equ = equipped
						usr.wdmg = 0
						for(var/obj/items/O in usr.contents)
							if(O.armor == "weapon")
								O.equipped = 0

								O.suffix = ""
						if(equ)
							usr.weaponsh = 0
							usr.weapon = 0
						else
							usr.weapon = /obj/bonesword
							usr.weaponsh = /obj/boneswordsh
							equipped = 1
							suffix = "Equipped - +20 attack power, handseal speed(-25%)"
							usr.wdmg = 10
						usr.overlay()
			Click()
				Use()
			verb
				Pick_Up()
					set src in oview(1)
					if(usr.clan == "Kaguya")
						loc = usr
						usr << "You picked up a [src]."

		Bone_Knife
			icon='boneknife.dmi'
			icon_state="inv"
			armor="weapon"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.clan=="Hyuuga")
							usr<<"Gentle palm requires your hands to be unencumbered."
							return
						if(usr.henge)return
						var/equ=equipped
						usr.wdmg=0
						for(var/obj/items/O in usr.contents)if(O.armor=="weapon")
							O.equipped=0

							O.suffix=""
						if(equ)
							usr.weaponsh=0
							usr.weapon=0
						else
							usr.weapon=/obj/boneknife
							usr.weaponsh=null
							equipped=1
							suffix="Equipped - +18 attack power handseal speed(-25%)"
							usr.wdmg=6
						usr.overlay()
			Click()Use()
			verb
				Pick_Up()
					set src in oview(1)
					if(usr.clan=="Kaguya")
						loc=usr
						usr<<"You picked up a [src]."
		Katana
			icon='katana.dmi'
			icon_state="inv"
			armor="weapon"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.clan=="Hyuuga")
							usr<<"Gentle palm requires your hands to be unencumbered."
							return
						if(usr.henge)return
						var/equ=equipped
						usr.wdmg=0
						for(var/obj/items/O in usr.contents)if(O.armor=="weapon")
							O.equipped=0

							O.suffix=""
						if(equ)
							usr.weaponsh=0
							usr.weapon=0
						else
							usr.weapon=/obj/katana
							usr.weaponsh=/obj/katanash
							equipped=1
							suffix="Equipped - +24 attack power, handseal speed(-25%)"
							usr.wdmg=8
						usr.overlay()
			Click()Use()
			verb
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
		Sword_of_Kusanagi
			icon='katana.dmi'
			icon_state="inv"
			armor="weapon"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						usr.wdmg=0
						for(var/obj/items/O in usr.contents)if(O.armor=="weapon")
							O.equipped=0
							O.suffix=""
						if(equ)
							usr.weaponsh=0
							usr.weapon=0
							usr.forceupdate()
						else
							usr.weapon=/obj/kusanagi
							usr.weaponsh=/obj/kusanagish
							equipped=1
							suffix="Equipped - Charge 3% attack damage and 3% ninjutsu damage per second into your next attack(stacks 10 times maximum)"
							usr.kusan=1
							usr.forceupdate()
						usr.overlay()
			Click()Use()
			verb
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Shadow_Katana
			icon='shadowkatana.dmi'
			icon_state="inv"
			armor="weapon"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.clan=="Hyuuga")
							usr<<"Gentle palm requires your hands to be unencumbered."
							return
						if(usr.henge)return
						var/equ=equipped
						usr.wdmg=0
						for(var/obj/items/O in usr.contents)if(O.armor=="weapon")
							O.equipped=0

							O.suffix=""
						if(equ)
							usr.weaponsh=0
							usr.weapon=0
						else
							usr.weapon=/obj/skatana
							usr.weaponsh=/obj/skatanash
							equipped=1
							suffix="Equipped - +30 attack power, handseal speed(-25%)"
							usr.wdmg=10
						usr.overlay()
			Click()Use()
			verb
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
		Red_Katana
			icon='redkatana.dmi'
			icon_state="inv"
			armor="weapon"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						usr.wdmg=0
						for(var/obj/items/O in usr.contents)if(O.armor=="weapon")
							O.equipped=0

							O.suffix=""
						if(equ)
							usr.weaponsh=0
							usr.weapon=0
						else
							name="Flamboyant Blade of Daisies"
							usr.weapon=/obj/redkatana
							usr.weaponsh=/obj/redkatana
							equipped=1
							suffix="Equipped - -15000 attack power"
							usr.wdmg=-5000
						usr.overlay()
			Click()Use()
			verb
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
		Pumpkin_Sword
			icon='halloween.dmi'
			icon_state="inv"
			armor="weapon"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						usr.wdmg=0
						for(var/obj/items/O in usr.contents)if(O.armor=="weapon")
							O.equipped=0

							O.suffix=""
						if(equ)
							usr.weaponsh=0
							usr.weapon=0
						else
							usr.weapon=/obj/pumpkinsword
							usr.weaponsh=/obj/pumpkinsword
							equipped=1
							suffix="Equipped - +42 attack power, handseal speed(-25%)"
							usr.wdmg=14
						usr.overlay()
			Click()Use()
			verb
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
		Sand_Gourd
			icon='Sand Gourd.dmi'
			icon_state="inv"
			armor="weapon"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="weapon")
							O.equipped=0

							O.suffix=""
						if(equ)usr.weapon=0
						else
							usr.weapon=/obj/gourd
							equipped=1
							suffix="Equipped - melee multiplier change(power->strength)"
						usr.overlay()
			Click()Use()
			verb
				Pick_Up()
					set src in oview(1)
					if(usr.clan=="Sand")
						loc=usr
						usr<<"You picked up a [src]."
		Fan
			icon='Fan.dmi'
			icon_state="inv"
			armor="weapon"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="weapon")
							O.equipped=0

							O.suffix=""
						if(equ)usr.weapon=0
						else
							usr.weapon=/obj/fan
							equipped=1
							suffix="Equipped - melee multiplier change(power->strength), -50% attack speed, melee area attack"
						usr.overlay()
			Click()Use()
			verb
				Pick_Up()
					set src in oview(1)
					if(usr.clan=="Fan")
						loc=usr
						usr<<"You picked up a [src]."
		Blue_Shinobi_Shirt
			icon='Leaf Shinobi Shirt.dmi'
			armor="shirt"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="shirt"||O.armor=="fullbody")
							O.equipped=0

							O.suffix=""
						if(equ)usr.shirt=0
						else
							usr.fullbody=0
							usr.shirt=/obj/leafunderup
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Bandages
			icon='Bandages.dmi'
			armor="special"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="special")
							O.equipped=0

							O.suffix=""
						if(equ)usr.shirt=0
						else
							usr.fullbody=0
							usr.shirt=/obj/bandages
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Beige_Jacket
			icon='Beige Jacket.dmi'
			armor="shirt"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="shirt"||O.armor=="fullbody")
							O.equipped=0

							O.suffix=""
						if(equ)usr.shirt=0
						else
							usr.fullbody=0
							usr.shirt=/obj/beigejacket
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Gay_Shirt
			icon='Gay Shirt.dmi'
			name="Shirt of Sacrifice"
			armor="shirt"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="shirt"||O.armor=="fullbody")
							O.equipped=0

							O.suffix=""
						if(equ)usr.shirt=0
						else
							usr.fullbody=0
							usr.shirt=/obj/gayshirt
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Blue_Pants
			icon='Pants Blue.dmi'
			armor="pant"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="pant"||O.armor=="fullbody")
							O.equipped=0

							O.suffix=""
						if(equ)usr.pant=0
						else
							usr.fullbody=0
							usr.pant=/obj/pantsblue
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Black_Cloak
			icon='Black Cloak.dmi'
			armor="cloak"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="cloak")
							O.equipped=0

							O.suffix=""
						if(equ)usr.cloak=0
						else
							usr.fullbody=0
							usr.cloak=/obj/blackcloak
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Ember_Cloak
			icon='Ember Cloak.dmi'
			armor="cloak"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="cloak")
							O.equipped=0
							O.suffix=""
						if(equ)usr.cloak=0
						else
							usr.cloak=/obj/embercloak
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Red_Coat
			icon='Red Coat.dmi'
			armor="cloak"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="cloak")
							O.equipped=0

							O.suffix=""
						if(equ)usr.cloak=0
						else
							usr.fullbody=0
							usr.cloak=/obj/redcoat
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Blue_Coat
			icon='Blue Coat.dmi'
			armor="cloak"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="cloak")
							O.equipped=0

							O.suffix=""
						if(equ)usr.cloak=0
						else
							usr.fullbody=0
							usr.cloak=/obj/bluecoat
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Black_Coat
			icon='Black Coat.dmi'
			armor="cloak"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="cloak")
							O.equipped=0

							O.suffix=""
						if(equ)usr.cloak=0
						else
							usr.fullbody=0
							usr.cloak=/obj/blackcoat
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Green_Coat
			icon='Green Coat.dmi'
			armor="cloak"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="cloak")
							O.equipped=0

							O.suffix=""
						if(equ)usr.cloak=0
						else
							usr.fullbody=0
							usr.cloak=/obj/greencoat
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Blue_Mist_Coat
			icon='Blue Mist Coat.dmi'
			armor="cloak"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="cloak")
							O.equipped=0

							O.suffix=""
						if(equ)usr.cloak=0
						else
							usr.fullbody=0
							usr.cloak=/obj/bluemistcoat
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Black_Pants
			icon='Pants Black.dmi'
			armor="pant"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="pant"||O.armor=="fullbody")
							O.equipped=0

							O.suffix=""
						if(equ)usr.pant=0
						else
							usr.fullbody=0
							usr.pant=/obj/pantsblack
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Black_Shorts
			icon='Black Shorts.dmi'
			armor="pant"
			proc
				Use()
					if(usr)
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="pant"||O.armor=="fullbody")
							O.equipped=0

							O.suffix=""
						if(equ)usr.pant=0
						else
							usr.fullbody=0
							usr.pant=/obj/blackshorts
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Green_Pants
			icon='Pants Green.dmi'
			armor="pant"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="pant"||O.armor=="fullbody")
							O.equipped=0

							O.suffix=""
						if(equ)usr.pant=0
						else
							usr.fullbody=0
							usr.pant=/obj/pantsgreen
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Orange_Pants
			icon='Pants Orange.dmi'
			armor="pant"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="pant"||O.armor=="fullbody")
							O.equipped=0

							O.suffix=""
						if(equ)usr.pant=0
						else
							usr.fullbody=0
							usr.pant=/obj/pantsorange
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Grey_Pants
			icon='Pants Grey.dmi'
			armor="pant"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="pant")
							O.equipped=0

							O.suffix=""
						if(equ)usr.pant=0
						else
							usr.pant=/obj/pantsgrey
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		White_Pants
			icon='Pants White.dmi'
			icon_state=""
			armor="pant"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="pant")
							O.equipped=0

							O.suffix=""
						if(equ)usr.pant=0
						else
							usr.pant=/obj/pantswhite
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Leaf_Flak_Jacket
			icon='Leaf Flak Jacket.dmi'
			icon_state=""
			armor="armor"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge||usr.village=="Sound"||usr.village=="Sand")return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="armor"||O.armor=="fullbody")
							O.equipped=0

							O.suffix=""
						if(equ)usr.armor=0
						else
							if(usr.fullbody==/obj/bloodexilearmor)usr.fullbody=0
							usr.armor=/obj/leafjacket
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Combat_Armor
			icon='Combat Armor.dmi'
			icon_state=""
			armor="armor"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="armor"||O.armor=="fullbody")
							O.equipped=0

							O.suffix=""
						if(equ)usr.armor=0
						else
							if(usr.fullbody==/obj/bloodexilearmor)usr.fullbody=0
							usr.armor=/obj/combatarmor
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Shadow_Guard_Armor
			icon='Shadow Guard Armor.dmi'
			icon_state=""
			armor="armor"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						if(src in usr)
							var/equ=equipped
							for(var/obj/items/O in usr.contents)if(O.armor=="armor"||O.armor=="fullbody")
								O.equipped=0
								O.suffix=""
							if(equ)usr.armor=0
							else
								if(usr.fullbody==/obj/bloodexilearmor)usr.fullbody=0
								usr.armor=/obj/shadowguardarmor
								equipped=1
								suffix="Equipped"
							usr.overlay()
			Click()Use()
		Moon_Guard_Armor
			icon='Moon Guard Armor.dmi'
			icon_state=""
			armor="armor"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="armor"||O.armor=="fullbody")
							O.equipped=0
							O.suffix=""
						if(equ)usr.armor=0
						else
							if(usr.fullbody==/obj/bloodexilearmor)usr.fullbody=0
							usr.armor=/obj/moonguardarmor
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
		Sand_Flak_Jacket
			icon='Sand Flak Jacket.dmi'
			icon_state=""
			armor="armor"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge||usr.village=="Sound"||usr.village=="Leaf")return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="armor"||O.armor=="fullbody")
							O.equipped=0

							O.suffix=""
						if(equ)usr.armor=0
						else
							if(usr.fullbody==/obj/bloodexilearmor)usr.fullbody=0
							usr.armor=/obj/sandjacket
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Blue_Vest
			icon='Blue Vest.dmi'
			icon_state=""
			armor="armor"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="armor"||O.armor=="fullbody")
							O.equipped=0
							O.suffix=""
						if(equ)usr.armor=0
						else
							if(usr.fullbody==/obj/bloodexilearmor)usr.fullbody=0
							usr.armor=/obj/bluevest
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Sound_Flak_Jacket
			icon='Sound Flak Jacket.dmi'
			icon_state=""
			armor="armor"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge||usr.village=="Leaf"||usr.village=="Sand")return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="armor"||O.armor=="fullbody")
							O.equipped=0

							O.suffix=""
						if(equ)usr.armor=0
						else
							if(usr.fullbody==/obj/bloodexilearmor)usr.fullbody=0
							usr.armor=/obj/soundjacket
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Stealth_Suit
			icon='Stealth Suit.dmi'
			armor="fullbody"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="fullbody"||O.armor=="shirt"||O.armor=="pant"||O.armor=="armor")
							O.equipped=0

							O.suffix=""
						if(equ)

							usr.fullbody=0
							usr.shirt=0
							usr.pant=0
						else
							usr.shirt=0
							usr.pant=0
							usr.fullbody=/obj/stealthsuit
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Mist_Demon_Suit
			icon='Mist Demon Suit.dmi'
			armor="fullbody"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="fullbody"||O.armor=="shirt"||O.armor=="pant"||O.armor=="armor")
							O.equipped=0

							O.suffix=""
						if(equ)
							usr.fullbody=0
							usr.shirt=0
							usr.pant=0
						else
							usr.shirt=0
							usr.pant=0
							usr.fullbody=/obj/mistdemonsuit
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Green_Jump_Suit
			icon='Green Jump Suit.dmi'
			armor="fullbody"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="fullbody"||O.armor=="shirt"||O.armor=="pant"||O.armor=="armor")
							O.equipped=0

							O.suffix=""
						if(equ)
							usr.fullbody=0
							usr.shirt=0
							usr.pant=0
						else
							usr.shirt=0
							usr.pant=0
							usr.fullbody=/obj/greenjumpsuit
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Ice_Wolf_Armor
			icon='Ice Wolf Armor.dmi'
			armor="fullbody"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="fullbody"||O.armor=="armor")
							O.equipped=0
							O.suffix=""
						if(equ)
							usr.fullbody=0
							usr.armor=0
						else
							usr.shirt=0
							usr.fullbody=/obj/icewolfarmor
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Blood_Exile_Armor
			icon='Blood Exile Armor.dmi'
			armor="fullbody"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="fullbody"||O.armor=="shirt"||O.armor=="pant"||O.armor=="armor")
							O.equipped=0
							O.suffix=""
						if(equ)
							usr.fullbody=0
							usr.shirt=0
							usr.pant=0
							usr.armor=0
						else
							usr.shirt=0
							usr.pant=0
							usr.armor=0
							usr.fullbody=/obj/bloodexilearmor
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Hokage_Hat
			icon='Hokage Hat.dmi'
			armor="headgear"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="headgear")
							O.equipped=0

							O.suffix=""
						if(equ)usr.headgear=0
						else
							usr.headgear=/obj/hokagehat
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
		Kazekage_Hat
			icon='Kazekage Hat.dmi'
			armor="headgear"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="headgear")
							O.equipped=0

							O.suffix=""
						if(equ)usr.headgear=0
						else
							usr.headgear=/obj/kazekagehat
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
		Hokage_Suit
			icon='Hokage Suit.dmi'
			armor="fullbody"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="fullbody"||O.armor=="shirt"||O.armor=="pant"||O.armor=="armor")
							O.equipped=0

							O.suffix=""
						if(equ)
							usr.fullbody=0
							usr.shirt=0
							usr.pant=0
						else
							usr.shirt=0
							usr.pant=0
							usr.fullbody=/obj/hokagesuit
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
		Warbringer
			icon='Warbringer.dmi'
			armor="fullbody"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="fullbody"||O.armor=="shirt"||O.armor=="pant"||O.armor=="armor")
							O.equipped=0

							O.suffix=""
						if(equ)
							usr.fullbody=0
							usr.shirt=0
							usr.pant=0
						else
							usr.shirt=0
							usr.pant=0
							usr.fullbody=/obj/warbringer
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
		Shadow_Pact_Gear
			icon='Shadow Pact Gear.dmi'
			armor="fullbody"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="fullbody"||O.armor=="shirt"||O.armor=="pant"||O.armor=="armor")
							O.equipped=0

							O.suffix=""
						if(equ)
							usr.fullbody=0
							usr.shirt=0
							usr.pant=0
						else
							usr.shirt=0
							usr.pant=0
							usr.fullbody=/obj/shadowpact
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
		ANBU_Armor
			icon='ANBU Armor.dmi'
			armor="fullbody"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="fullbody"||O.armor=="shirt"||O.armor=="pant"||O.armor=="armor")
							O.equipped=0

							O.suffix=""
						if(equ)
							usr.fullbody=0
							usr.shirt=0
							usr.pant=0
						else
							usr.shirt=0
							usr.pant=0
							usr.fullbody=/obj/anbusuit
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
		Kazekage_Suit
			icon='Kazekage Suit.dmi'
			armor="fullbody"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="fullbody"||O.armor=="shirt"||O.armor=="pant"||O.armor=="armor")
							O.equipped=0

							O.suffix=""
						if(equ)
							usr.fullbody=0
							usr.shirt=0
							usr.pant=0
						else
							usr.shirt=0
							usr.pant=0
							usr.fullbody=/obj/kazekagesuit
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Sound_Leader_Suit
			icon='Sound Leader Suit.dmi'
			armor="fullbody"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="fullbody"||O.armor=="shirt"||O.armor=="pant"||O.armor=="armor")
							O.equipped=0

							O.suffix=""
						if(equ)
							usr.fullbody=0
							usr.shirt=0
							usr.pant=0
						else
							usr.shirt=0
							usr.pant=0
							usr.fullbody=/obj/soundleadersuit
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Akatsuki_Suit
			icon='Akatsuki Suit.dmi'
			armor="fullbody"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="fullbody"||O.armor=="shirt"||O.armor=="pant"||O.armor=="armor")
							O.equipped=0

							O.suffix=""
						if(equ)
							usr.fullbody=0
							usr.shirt=0
							usr.pant=0
						else
							usr.shirt=0
							usr.pant=0
							usr.fullbody=/obj/akatsukisuit
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."

		Glasses
			icon='Glasses.dmi'
			armor="headgear"
			icon_state="inv"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="headgear")
							O.equipped=0

							O.suffix=""
						if(equ)usr.headgear=0
						else
							usr.headgear=/obj/glasses
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Sunglasses
			icon='Sunglasses.dmi'
			armor="headgear"
			icon_state="inv"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="headgear")
							O.equipped=0

							O.suffix=""
						if(equ)usr.headgear=0
						else
							usr.headgear=/obj/sunglasses
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Shoes
			icon='Shoes.dmi'
			icon_state=""
			armor="shoes"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="shoes")
							O.equipped=0

							O.suffix=""
						if(equ)usr.shoes=0
						else
							usr.shoes=/obj/shoes
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Plated_Gloves
			icon='Plated Gloves.dmi'
			icon_state=""
			armor="gloves"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="gloves")
							O.equipped=0

							O.suffix=""
						if(equ)usr.gloves=0
						else
							usr.gloves=/obj/platedgloves
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Gloves
			icon='Gloves.dmi'
			icon_state=""
			armor="gloves"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="gloves")
							O.equipped=0

							O.suffix=""
						if(equ)usr.gloves=0
						else
							usr.gloves=/obj/gloves
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Kunai_Pouch
			icon='Kunai Pouch.dmi'
			icon_state=""
			armor="kunaipouch"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="kunaipouch")
							O.equipped=0

							O.suffix=""
						if(equ)usr.kunaipouch=0
						else
							usr.kunaipouch=/obj/kunaipouch
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Shoes_With_Socks
			icon='Shoes 2.dmi'
			icon_state=""
			name="Shoes"
			armor="shoes"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="shoes")
							O.equipped=0
							O.suffix=""
						if(equ)usr.shoes=0
						else
							usr.shoes=/obj/shoes2
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Black_Shirt
			icon='Shirt Black.dmi'
			armor="shirt"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="shirt"||O.armor=="fullbody")
							O.equipped=0

							O.suffix=""
						if(equ)usr.shirt=0
						else
							usr.fullbody=0
							usr.shirt=/obj/shirtblack
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Green_Shirt
			icon='Shirt Green.dmi'
			armor="shirt"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="shirt"||O.armor=="fullbody")
							O.equipped=0

							O.suffix=""
						if(equ)usr.shirt=0
						else
							usr.fullbody=0
							usr.shirt=/obj/shirtgreen
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Blue_Shirt
			icon='Shirt Blue.dmi'
			armor="shirt"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="shirt"||O.armor=="fullbody")
							O.equipped=0

							O.suffix=""
						if(equ)usr.shirt=0
						else
							usr.fullbody=0
							usr.shirt=/obj/shirtblue
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Uchiha_Shirt
			icon='Uchiha Shirt.dmi'
			armor="shirt"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="shirt"||O.armor=="fullbody")
							O.equipped=0

							O.suffix=""
						if(equ)usr.shirt=0
						else
							usr.fullbody=0
							usr.shirt=/obj/uchihashirt
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Narutos_Jacket
			name="Naruto's Jacket"
			icon='Narutos Jacket.dmi'
			armor="shirt"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="shirt"||O.armor=="fullbody")
							O.equipped=0

							O.suffix=""
						if(equ)usr.shirt=0
						else
							usr.fullbody=0
							usr.shirt=/obj/narutosjacket
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Grey_Shirt
			icon='Shirt Grey.dmi'
			armor="shirt"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="shirt"||O.armor=="fullbody")
							O.equipped=0

							O.suffix=""
						if(equ)usr.shirt=0
						else
							usr.fullbody=0
							usr.shirt=/obj/shirtgrey
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Orange_Shirt
			icon='Shirt Orange.dmi'
			armor="shirt"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="shirt"||O.armor=="fullbody")
							O.equipped=0

							O.suffix=""
						if(equ)usr.shirt=0
						else
							usr.fullbody=0
							usr.shirt=/obj/shirtorange
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Red_Shirt
			icon='Shirt Red.dmi'
			armor="shirt"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="shirt"||O.armor=="fullbody")
							O.equipped=0

							O.suffix=""
						if(equ)usr.shirt=0
						else
							usr.fullbody=0
							usr.shirt=/obj/shirtred
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		Tan_Shirt
			icon='Shirt Tan.dmi'
			armor="shirt"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="shirt"||O.armor=="fullbody")
							O.equipped=0

							O.suffix=""
						if(equ)usr.shirt=0
						else
							usr.fullbody=0
							usr.shirt=/obj/shirttan
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
		White_Shirt
			icon='Shirt White.dmi'
			armor="shirt"
			proc
				Use()
					if(usr)
						if(usr.clan=="Taijutsu Specialist")
							usr<<"Taijutsu Specialists can only use Black Shorts for now."
							return
						if(usr.henge)return
						var/equ=equipped
						for(var/obj/items/O in usr.contents)if(O.armor=="shirt"||O.armor=="fullbody")
							O.equipped=0
							O.suffix=""
						if(equ)usr.shirt=0
						else
							usr.fullbody=0
							usr.shirt=/obj/shirtwhite
							equipped=1
							suffix="Equipped"
						usr.overlay()
			Click()Use()
			verb
				Drop()
					if(equipped==1)usr<<"You must unequip this first."
					else loc=locate(usr.x,usr.y,usr.z)
				Pick_Up()
					set src in oview(1)
					loc=usr
					usr<<"You picked up a [src]."
obj
	shoes
		layer=MOB_LAYER+2
		icon='Shoes.dmi'
	shoes2
		layer=MOB_LAYER+2
		icon='Shoes 2.dmi'
	headband
		layer=MOB_LAYER+2
		icon='Shinobi Headband.dmi'
	facemask
		layer=MOB_LAYER+1
		icon='Face Mask.dmi'
	spiralmask
		layer=MOB_LAYER+1
		icon='Spiral Mask.dmi'
	mistmask
		layer=MOB_LAYER+1
		icon='Mask of the Mist.dmi'
	anbuleaf
		layer=MOB_LAYER+1
		icon='Anbu Mask Leaf.dmi'
	anbusand
		layer=MOB_LAYER+1
		icon='Anbu Mask Sand.dmi'
	anbusound
		layer=MOB_LAYER+1
		icon='Anbu Mask Sound.dmi'
	glasses
		layer=MOB_LAYER+3
		icon='Glasses.dmi'
	combathelmet
		layer=MOB_LAYER+8
		icon='Combat Helmet.dmi'
	hunterscap
		layer=MOB_LAYER+8
		pixel_y=1
		icon='Hunters Cap.dmi'
	strawhat
		layer=MOB_LAYER+8
		icon='Straw Hat.dmi'
	hokagehat
		layer=MOB_LAYER+8
		icon='Hokage Hat.dmi'
	clothmask
		layer=MOB_LAYER+8
		icon='Cloth Mask.dmi'
	blackclothmask
		layer=MOB_LAYER+8
		icon='Black Cloth Mask.dmi'
	halfhelmet
		layer=MOB_LAYER+8
		icon='Half Helmet.dmi'
	kazekagehat
		layer=MOB_LAYER+8
		icon='Kazekage Hat.dmi'
	merchantshat
		layer=MOB_LAYER+8
		pixel_y=2
		icon='Merchants Hat.dmi'
	sombraro
		layer=MOB_LAYER+8
		icon='Sombraro.dmi'
	sunglasses
		layer=MOB_LAYER+3
		icon='Sunglasses.dmi'
	bonesword
		layer=MOB_LAYER+6
		icon='bonesword.dmi'
	boneknife
		layer=MOB_LAYER+6
		icon='boneknife.dmi'
	boneswordsh
		layer=MOB_LAYER+6
		icon='boneswordsh.dmi'
	katana
		layer=MOB_LAYER+6
		icon='katana.dmi'
	kusanagi
		layer=MOB_LAYER+6
		icon='kusanagi.dmi'
	kusanagish
		layer=MOB_LAYER+6
		icon='kusanagish.dmi'

	doubleblades
		layer=MOB_LAYER+5
		icon='doublebone.dmi'
	hardenedbonesword
		layer=MOB_LAYER+6
		icon='hardenedbonesword.dmi'
	redkatana
		layer=MOB_LAYER+6
		icon='redkatana.dmi'
	pumpkinsword
		layer=MOB_LAYER+6
		icon='halloween.dmi'
	skatana
		layer=MOB_LAYER+6
		icon='shadowkatana.dmi'
	katanash
		layer=MOB_LAYER+6
		icon='katanash.dmi'
	skatanash
		layer=MOB_LAYER+6
		icon='shadowkatanash.dmi'
	stealthsuit
		layer=MOB_LAYER+1
		icon='Stealth Suit.dmi'
	gourd
		layer=MOB_LAYER-1
		icon='Sand Gourd.dmi'
	gourdov
		layer=MOB_LAYER+8
		icon='Sand Gourd Overlay.dmi'
	fan
		pixel_x=-32
		pixel_y=-32
		layer=MOB_LAYER-1
		icon='Fan.dmi'
	fanov
		pixel_x=-32
		pixel_y=-32
		layer=MOB_LAYER+8
		icon='Fan Overlay.dmi'
	baseboneov
		layer=MOB_LAYER+7
		icon='baseboneov.dmi'
	leafjacket
		layer=MOB_LAYER+4
		icon='Leaf Flak Jacket.dmi'
	soundjacket
		layer=MOB_LAYER+4
		icon='Sound Flak Jacket.dmi'
	sandjacket
		layer=MOB_LAYER+4
		icon='Sand Flak Jacket.dmi'
	bluevest
		layer=MOB_LAYER+4
		icon='Blue Vest.dmi'
	leafunderup
		layer=MOB_LAYER+1
		icon='Leaf Shinobi Shirt.dmi'
	shirtblack
		layer=MOB_LAYER+1
		icon='Shirt Black.dmi'
	shirtorange
		layer=MOB_LAYER+1
		icon='Shirt Orange.dmi'
	shirtgrey
		layer=MOB_LAYER+1
		icon='Shirt Grey.dmi'
	shirtblue
		layer=MOB_LAYER+1
		icon='Shirt Blue.dmi'
	beigejacket
		layer=MOB_LAYER+1
		icon='Beige Jacket.dmi'
	gayshirt
		layer=MOB_LAYER+1
		icon='Gay Shirt.dmi'
	bandages
		layer=MOB_LAYER+1
		icon='Bandages.dmi'
	kisamering
	ororing
	peinring
	itachiring
	kakazuring
	shirtgreen
		layer=MOB_LAYER+1
		icon='Shirt Green.dmi'
	shirtred
		layer=MOB_LAYER+1
		icon='Shirt Red.dmi'
	shirttan
		layer=MOB_LAYER+1
		icon='Shirt Tan.dmi'
	serpentbelt
		layer=MOB_LAYER+6
		icon='Serpent Belt.dmi'
	waistscarf
		layer=MOB_LAYER+6
		icon='Waist Scarf.dmi'
	shirtwhite
		layer=MOB_LAYER+1
		icon='Shirt White.dmi'
	pantsblue
		layer=MOB_LAYER+1
		icon='Pants Blue.dmi'
	kunaipouch
		layer=MOB_LAYER+3
		icon='Kunai Pouch.dmi'
	pantsorange
		layer=MOB_LAYER+1
		icon='Pants Orange.dmi'
	pantswhite
		layer=MOB_LAYER+1
		icon='Pants White.dmi'
	pantsgrey
		layer=MOB_LAYER+1
		icon='Pants Grey.dmi'
	blackshorts
		layer=MOB_LAYER+1
		icon='Black Shorts.dmi'
	pantsgreen
		layer=MOB_LAYER+1
		icon='Pants Green.dmi'
	pantsblack
		layer=MOB_LAYER+1
		icon='Pants Black.dmi'
	akatsukisuit
		layer=MOB_LAYER+1
		icon='Akatsuki Suit.dmi'
	hokagesuit
		layer=MOB_LAYER+3
		icon='Hokage Suit.dmi'
	blackcloak
		layer=MOB_LAYER+5
		icon='Black Cloak.dmi'
	bluemistcoat
		layer=MOB_LAYER+3
		icon='Blue Mist Coat.dmi'
	bluecoat
		layer=MOB_LAYER+3
		icon='Blue Coat.dmi'
	blackcoat
		layer=MOB_LAYER+3
		icon='Black Coat.dmi'
	redcoat
		layer=MOB_LAYER+3
		icon='Red Coat.dmi'
	greencoat
		layer=MOB_LAYER+3
		icon='Green Coat.dmi'
	embercloak
		layer=MOB_LAYER+3
		icon='Ember Cloak.dmi'
	kazekagesuit
		layer=MOB_LAYER+3
		icon='Kazekage Suit.dmi'
	warbringer
		layer=MOB_LAYER+1
		icon='Warbringer.dmi'
	shadowpact
		layer=MOB_LAYER+1
		icon='Shadow Pact Gear.dmi'
	anbusuit
		layer=MOB_LAYER+3
		icon='ANBU Armor.dmi'
	soundleadersuit
		layer=MOB_LAYER+1
		icon='Sound Leader Suit.dmi'
	kunaiweap
		layer=MOB_LAYER+6
		icon='Handheld Kunai.dmi'
	boxinggloves
		layer=MOB_LAYER+4
		icon='Boxing Gloves.dmi'
	gloves
		layer=MOB_LAYER+4
		icon='Gloves.dmi'
	platedgloves
		layer=MOB_LAYER+4
		icon='Plated Gloves.dmi'
	bloodexilearmor
		layer=MOB_LAYER+4
		icon='Blood Exile Armor.dmi'
	icewolfarmor
		layer=MOB_LAYER+4
		icon='Ice Wolf Armor.dmi'
	gilgamesh
		layer=MOB_LAYER+4
		icon='Gilgamesh.dmi'
	mistdemonsuit
		layer=MOB_LAYER+1
		icon='Mist Demon Suit.dmi'
	greenjumpsuit
		layer=MOB_LAYER+1
		icon='Green Jump Suit.dmi'
	uchihashirt
		layer=MOB_LAYER+1
		icon='Uchiha Shirt.dmi'
	narutosjacket
		layer=MOB_LAYER+1
		icon='Narutos Jacket.dmi'
	weights
		layer=MOB_LAYER
		icon='weights.dmi'
	combatarmor
		layer=MOB_LAYER+3
		icon='Combat Armor.dmi'
	shadowguardarmor
		layer=MOB_LAYER+3
		icon='Shadow Guard Armor.dmi'
	moonguardarmor
		layer=MOB_LAYER+3
		icon='Moon Guard Armor.dmi'
	headbando
		layer=MOB_LAYER+7
		icon='Shinobi Headband.dmi'
	headbandll
		layer=MOB_LAYER+4
		//icon='Left Leg Headband Style.dmi'
	headbandrl
		layer=MOB_LAYER+4
		icon='Right Leg Headband Style.dmi'
	headbandla
		layer=MOB_LAYER+4
		icon='Left Arm Headband Style.dmi'
	headbandra
		layer=MOB_LAYER+4
		icon='Right Arm Headband Style.dmi'
	headbandss
		layer=MOB_LAYER+7
		icon='Sideway Style Headband.dmi'
	blackheadband
		layer=MOB_LAYER+7
		icon='Black Shinobi Headband.dmi'
	headbandws
		layer=MOB_LAYER+4
		icon='Waist Style Headband.dmi'