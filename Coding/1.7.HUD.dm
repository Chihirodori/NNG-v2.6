obj/jutsu
	layer=95
	icon='Jutsus Y.dmi'
	MouseDrag()
		mouse_drag_pointer=src
	MouseDrop(obj/overobject,srclocation,overlocation)
		if(istype(overobject,/obj/hotslot/))
			screen_loc=overobject.screen_loc
			usr.client.screen+=src
			if(name==usr.slot1)usr.slot1=null
			if(name==usr.slot2)usr.slot2=null
			if(name==usr.slot3)usr.slot3=null
			if(name==usr.slot4)usr.slot4=null
			if(name==usr.slot5)usr.slot5=null
			if(name==usr.slot6)usr.slot6=null
			if(name==usr.slot7)usr.slot7=null
			if(name==usr.slot8)usr.slot8=null
			if(name==usr.slot9)usr.slot9=null
			if(name==usr.slot10)usr.slot10=null
			if(name==usr.slot11)usr.slot11=null
			if(name==usr.slot12)usr.slot12=null
			if(name==usr.slot13)usr.slot13=null
			if(name==usr.slot14)usr.slot14=null
			if(name==usr.slot15)usr.slot15=null
			if(name==usr.slot16)usr.slot16=null
			switch(overobject.icon_state)
				if("1")usr.slot1=name
				if("2")usr.slot2=name
				if("3")usr.slot3=name
				if("4")usr.slot4=name
				if("5")usr.slot5=name
				if("6")usr.slot6=name
				if("7")usr.slot7=name
				if("8")usr.slot8=name
				if("9")usr.slot9=name
				if("10")usr.slot10=name
				if("11")usr.slot11=name
				if("12")usr.slot12=name
				if("13")usr.slot13=name
				if("14")usr.slot14=name
				if("15")usr.slot15=name
				if("16")usr.slot16=name
		else
			usr.client.screen-=src
			if(name==usr.slot1)usr.slot1=null
			if(name==usr.slot2)usr.slot2=null
			if(name==usr.slot3)usr.slot3=null
			if(name==usr.slot4)usr.slot4=null
			if(name==usr.slot5)usr.slot5=null
			if(name==usr.slot6)usr.slot6=null
			if(name==usr.slot7)usr.slot7=null
			if(name==usr.slot8)usr.slot8=null
			if(name==usr.slot9)usr.slot9=null
			if(name==usr.slot10)usr.slot10=null
			if(name==usr.slot11)usr.slot11=null
			if(name==usr.slot12)usr.slot12=null
			if(name==usr.slot13)usr.slot13=null
			if(name==usr.slot14)usr.slot14=null
			if(name==usr.slot15)usr.slot15=null
			if(name==usr.slot16)usr.slot16=null
	Click()
		if(loc!=usr)del src
		..()
	Transformation
		icon='Jutsus G.dmi'
		icon_state="transformation"
		Click()usr.transformation()
	Body_Flicker_Technique
		icon='Jutsus A.dmi'
		icon_state="body flicker"
		Click()usr.bodyflickertechnique()
	Substitution
		icon='Jutsus A.dmi'
		icon_state="substitution"
		Click()usr.substitution()
	Assassinate
		icon='Jutsus H.dmi'
		icon_state="assassinate"
		Click()usr.assassinate()
	Backdash
		icon='Jutsus A.dmi'
		icon_state="backdash"
		Click()usr.backdash()
	Tracking
		icon='Jutsus A.dmi'
		icon_state="tracking"
		//Click()usr.tracking()
	Mastered_Substitution
		icon='Jutsus A.dmi'
		icon_state="mastered substitution"
		Click()usr.substitutionmast()
	Clone_Jutsu
		icon='Jutsus C.dmi'
		icon_state="clone"
		Click()usr.clonejutsu()
	Akatsuki_Summon
		icon='Jutsus B.dmi'
		icon_state="akat summon"
		Click()usr.akatsummon()
	Shadow_Clone_Jutsu
		icon='Jutsus C.dmi'
		icon_state="shadow clone"
		Click()usr.shadowclonejutsu()
	Rasengan
		icon='Jutsus R.dmi'
		icon_state="rasengan"
		Click()usr.rasengan()
	Advanced_Tracking
		icon='Jutsus A.dmi'
		icon_state="advanced tracking"
		Click()usr.advancedtracking()
	Shuriken_Clone_Jutsu
		icon='Jutsus C.dmi'
		icon_state="shuriken clone"
		Click()usr.shurikenclonejutsu()
	Kage_Powered
		name="Powered"
		icon='Jutsus T.dmi'
		icon_state="Kage Powered"
		Click()usr.powered()
	custom
		icon='Jutsus Custom.dmi'
		Kirin
			icon_state="kirin"
			Click()usr.kirin()
	taijutsu
		Whirlwind_Kick
			icon_state="whirlwind kick"
			icon='Jutsus Tai.dmi'
			Click()usr.whirlwindkick()
		Dancing_Leaf_Shadow
			icon_state="dancing leaf shadow"
			icon='Jutsus Tai.dmi'
			Click()usr.dancingleafshadow()
		Rising_Wind
			icon_state="rising wind"
			icon='Jutsus Tai.dmi'
			Click()usr.risingwind()
		Dynamic_Entry
			icon_state="dynamic entry"
			icon='Jutsus Tai.dmi'
			Click()usr.dynamicentry()
		Primary_Lotus
			icon_state="primary lotus"
			icon='Jutsus Tai.dmi'
			Click()usr.primarylotus()
		Morning_Peacock
			icon_state="morning peacock"
			icon='Jutsus Tai.dmi'
			Click()usr.morningpeacock()
		Hidden_Lotus
			icon_state="hidden lotus"
			icon='Jutsus Tai.dmi'
			Click()usr.hiddenlotus()
	inuzuka
		Fang_Over_Fang
			icon_state="blank1"
			icon='Jutsus Copy Ninja.dmi'
			Click()usr.fangoverfang()
	copynin
		Blank_Jutsu_1
			icon_state="blank1"
			icon='Jutsus Copy Ninja.dmi'
			Click()usr.blankjutsu1()
		Blank_Jutsu_2
			icon_state="blank2"
			icon='Jutsus Copy Ninja.dmi'
			Click()usr.blankjutsu2()
		Blank_Jutsu_3
			icon_state="blank3"
			icon='Jutsus Copy Ninja.dmi'
			Click()usr.blankjutsu3()
		Blank_Jutsu_4
			icon_state="blank4"
			icon='Jutsus Copy Ninja.dmi'
			Click()usr.blankjutsu4()
		Blank_Jutsu_5
			icon_state="blank5"
			icon='Jutsus Copy Ninja.dmi'
			Click()usr.blankjutsu5()
		Rally
			icon_state="rally"
			icon='Jutsus Copy Ninja.dmi'
			Click()usr.rally()
		Raiden
			icon_state="raiden"
			icon='Jutsus Copy Ninja.dmi'
			Click()usr.raiden()
		Raikiri
			icon='Jutsus R.dmi'
			icon_state="lightning blade"
			Click()usr.raikiri()
	yuki
		icon='Jutsus Haku.dmi'
		Senbon_Wave
			icon_state="senbon wave"
			Click()usr.senbonwave()
		A_Thousand_Needles_of_Death
			icon_state="a thousand needles of death"
			Click()usr.onekdeath()
		Demon_Ice_Mirrors
			icon_state="crystal ice mirrors"
			Click()usr.demonicemirrors()
		Ice_Mirrors
			icon_state="crystal ice mirrors"
			Click()usr.icemirrors()
		Ice_Dome
			icon_state="ice dome"
			Click()usr.icedome()
		Iceberg_Breaker
			icon_state="iceberg breaker"
			Click()usr.icebreaker()
		Water_Clone
			icon_state="water clone"
			Click()usr.waterclone()
		Ice_Prison
			icon_state="ice prison"
			Click()usr.iceprison()
		Hidden_Mist_Jutsu
			icon_state="hidden mist jutsu"
			Click()usr.mistjutsu()
		False_Mirror
			icon_state="false mirror"
			Click()usr.falsemirror()
	troj
		Lightning_Spear
			icon='Jutsus R.dmi'
			icon_state="lightning spear"
			Click()usr.lightningspear()
		Shadow_Word_Pain
			icon='Jutsus R.dmi'
			name="Shadow Word: Pain"
			icon_state="shadowwordpain"
			Click()
				usr.shadowwordpain()
				usr.shadowwordpain()
				usr.shadowwordpain()
				usr.shadowwordpain()
		Demon_Soul_Transfer
			icon='Jutsus R.dmi'
			icon_state="demon soul transfer"
			Click()usr.demonsoultransfer()
		Lightning_Flash
			icon='Jutsus A.dmi'
			icon_state="lightning flash"
			Click()usr.lightningflash()
		Consecrate
			name="Radiate"
			icon='Jutsus R.dmi'
			icon_state="consecrate"
			Click()usr.radiation()
		Heal
			icon='Jutsus B.dmi'
			icon_state="heal"
			Click()usr.heal()
		Lockdown
			icon='Jutsus B.dmi'
			icon_state="lockdown"
			Click()usr.lockdown()
		Landmine
			icon='Jutsus R.dmi'
			icon_state="landmine"
			Click()usr.landmine()
	leaf
		Fuuma_Shuriken
			icon='Jutsus R.dmi'
			icon_state="fuuma shuriken"
			Click()usr.fuumashuriken()
		One_Thousand_Years_of_Death
			icon='Jutsus H.dmi'
			icon_state="one thousand years of death"
			Click()usr.constipation()
		Twin_Dragon_Weapon_Barrage
			icon='Jutsus R.dmi'
			icon_state="twin dragon weapon barrage"
			Click()usr.dragonweapon()
		Sexy_Jutsu
			icon='Jutsus G.dmi'
			icon_state="sexy"
			Click()usr.sexy()
	hyuuga
		Byakugan
			icon='Jutsus T.dmi'
			icon_state="byakugan"
			Click()usr.byakugan()
		Rotation
			icon='Jutsus H.dmi'
			icon_state="kaiten"
			Click()usr.kaiten()
		Lion_Palm
			icon='Jutsus H.dmi'
			icon_state="lion palm"
			Click()usr.lionpalm()
		Sixty_Four_Palms
			icon='Jutsus R.dmi'
			icon_state="64 strikes"
			Click()usr.sixtyfour()
		One_Twenty_Eight_Palms
			icon='Jutsus R.dmi'
			icon_state="128 strikes"
			name="One Hundred and Twenty Eight Palms"
			Click()usr.onetwentyeight()
		Empty_Palm
			icon='Jutsus H.dmi'
			icon_state="empty palm"
			Click()usr.empty()
		Mountain_Crusher
			icon='Jutsus R.dmi'
			icon_state="mountain crusher"
			Click()usr.mountain()
		Precise_Striking
			icon='Jutsus T.dmi'
			icon_state="precise striking"
			Click()usr.precisestriking()
		Rapid_Palms
			icon='Jutsus T.dmi'
			icon_state="rapid palms"
			Click()usr.rapidpalms()
	wind
		Sickling_Wind
			icon='Jutsus R.dmi'
			icon_state="sickling wind"
			Click()usr.sicklingwind()
		Whirlwind_Palm
			icon='Jutsus H.dmi'
			icon_state="whirlwind palm"
			Click()usr.whirlwindpalm()
		Wind_Shield
			icon='Jutsus T.dmi'
			icon_state="wind shield"
			Click()usr.windshield()
		Condensed_Wind
			icon='Jutsus T.dmi'
			icon_state="condensed wind"
			Click()usr.condensedwind()
		Hurricane
			icon='Jutsus T.dmi'
			icon_state="hurricane"
			Click()usr.hurricane()
		Mark_of_Death
			icon='Jutsus B.dmi'
			icon_state="mark of death"
			Click()usr.markofdeath()
		Sandstorm
			icon='Jutsus H.dmi'
			icon_state="sandstorm"
			Click()usr.sandstorm()
		Air_Bullet
			icon='Jutsus R.dmi'
			icon_state="air bullet"
			Click()usr.airbullet()
		Great_Sickling_Wind
			icon='Jutsus R.dmi'
			icon_state="great sickling wind"
			Click()usr.greatsicklingwind()
		Ripping_Gale_Jutsu
			icon='Jutsus R.dmi'
			icon_state="ripping gale jutsu"
			Click()usr.rippinggalejutsu()
		Dragons_Storm
			icon='Jutsus R.dmi'
			name="Dragon's Storm"
			icon_state="dragons storm"
			Click()usr.dragonsstorm()
	rebirth
		Sharingan_Implant
			icon='Jutsus Uchiha.dmi'
			icon_state="sharingan3"
			Click()usr.sharingan()
	uchiha
		icon='Jutsus Uchiha.dmi'
		Fireball_Jutsu
			icon_state="fireball"
			Click()usr.fireballjutsu()
		Sharingan
			icon_state="sharingan"
			Click()usr.sharingan()
		Mangekyou_Sharingan
			icon_state="mangekyou"
			Click()usr.mangekyou()
		Eternal_Mangekyou_Sharingan
			icon_state="mangekyou"
			Click()usr.emangekyou()
		Chidori_Current
			icon_state="current"
			Click()usr.chidoricurrent()
		Vengeance
			icon_state="vengeance"
			Click()usr.vengeance()
		Piercing_Gaze
			icon_state="piercing gaze"
			Click()usr.piercinggaze()
		Body_Illusion
			icon_state="body illusion"
			Click()usr.bodyillusion()
		Triple_Windmill
			icon_state="triplewindmill"
			Click()usr.triplewindmill()
		Phoenix_Flower_Jutsu
			icon_state="phoenix flower"
			Click()usr.phoenixflower()
		Chidori
			icon_state="chidori"
			Click()usr.chidori()
		Disperse
			icon_state="disperse"
			Click()usr.disperse()
		Dragon_Flames_Jutsu
			icon_state="dragon flames"
			Click()usr.dragonflames()
		Great_Dragon_Flames
			icon_state="great dragon flames"
			Click()usr.greatdragonflames()
		Peregrine_Falcon_Drop
			name="Falcon Drop"
			icon_state="peregrine falcon drop"
			Click()if(usr.GM)usr.falcondrop()
		Ephemeral
			icon_state="ephemeral"
			Click()usr.ephemeral()
		Clone_Explosion
			icon_state="clone explosion"
			Click()usr.cloneexplosion()
	leafnon
		Shadow_Clone_Combo
			icon='Jutsus R.dmi'
			icon_state="shadow clone combo"
			Click()usr.shadowclonecombo()
		Fire_Dragon_Flame_Blast
			icon='Jutsus R.dmi'
			icon_state="fire dragon flame blast"
			Click()usr.firedragonflameblast()
	nara
		Shadow_Strangle
			icon='Jutsus Nara.dmi'
			icon_state="shadow neck bind"
			Click()usr.neckbind()
		Shadow_Imitation
			icon='Jutsus Nara.dmi'
			icon_state="shadow imitation"
			Click()usr.imitation()
		Shadow_Sewing_Jutsu
			icon='Jutsus Nara.dmi'
			icon_state="shadow sewing"
			Click()usr.shadowsewing()
		Shadow_Endgame
			icon='Jutsus Nara.dmi'
			icon_state="shadow summoning"
			Click()usr.shadowsummoning()
		Strategic_Bombing
			icon='Jutsus Nara.dmi'
			icon_state="strategic bombing"
			Click()usr.strategicbombing()
		Shadow_Gathering
			icon='Jutsus Nara.dmi'
			icon_state="shadow gathering"
			Click()usr.shadowgathering()
		Shadow_Clutch
			icon='Jutsus Nara.dmi'
			icon_state="shadow clutch"
			Click()usr.shadowclutch()
		Shadow_Possession_Shuriken
			icon='Jutsus Nara.dmi'
			icon_state="shadow possession shuriken"
			Click()usr.shadowshuriken()
		Shadow_Fists
			icon='Jutsus Y.dmi'
			icon_state="shadow fists"
			Click()usr.shadowfists()
	kaguya
		Dance_of_the_Camellia
			icon_state="camellia"
			icon='Jutsus R.dmi'
			Click()usr.camellia()
		Dance_of_the_Willow
			icon_state="willow"
			icon='Jutsus R.dmi'
			Click()usr.willow()
		Dance_of_the_Pines
			icon_state="pines"
			icon='Jutsus H.dmi'
			Click()usr.pines()
		Snap_Regeneration
			icon_state="snap regeneration"
			icon='Jutsus B.dmi'
			Click()usr.snapregen()
		Dance_of_the_Clematis
			icon_state="clematis"
			icon='Jutsus R.dmi'
			Click()usr.clematis()
		Dance_of_the_Seedling_Ferns
			icon_state="seedling ferns"
			icon='Jutsus H.dmi'
			Click()usr.seedlingferns()
		Bone_Golem
			icon_state="bone golem"
			icon='Jutsus T.dmi'
			Click()usr.bonegolem()
		Bloodlust
			icon_state="bloodlust"
			icon='Jutsus B.dmi'
			Click()usr.bloodlust()
		Extreme_Condensing
			icon_state="extreme condensing"
			icon='Jutsus T.dmi'
			Click()usr.extremecondensing()
		Double_Blades
			icon_state="double blades"
			icon='Jutsus T.dmi'
			Click()usr.doubleblades()
	sound
		Shuriken_Barrage
			icon_state="shuriken barrage"
			icon='Jutsus R.dmi'
			Click()usr.shurikenbarrage()
		Massacre_Shadow_Snakes
			icon_state="massacresnakes"
			icon='Jutsus R.dmi'
			Click()usr.massacresnakes()
		Death_Viewing_Technique
			icon_state="deathviewing"
			icon='Jutsus G.dmi'
			Click()usr.deathviewing()
		Rashoumon
			icon_state="rashoumon"
			icon='Jutsus H.dmi'
			Click()usr.rashoumon()
		Curse_Seal
			icon_state="curse seal"
			icon='Jutsus T.dmi'
			Click()usr.curseseal()
	snake
		icon='Jutsus Snake.dmi'
		Striking_Shadow_Snake
			icon_state="shadow snake"
			Click()usr.strikingsnake()
		Chakra_Absorption
			icon_state="chakra absorption"
			Click()usr.chakraabs()
		Sky_Blade
			icon_state="sky blade"
			Click()usr.skyblade()
		Binding_Snake_Glare
			icon_state="snake glare"
			Click()usr.snakeglare()
		Immortality_Jutsu
			icon_state="immortality"
			Click()usr.immortality()
		Edo_Tensei
			icon_state="edo tensei"
			Click()usr.edotensei()
		Shed_Skin
			icon_state="shed skin"
			Click()usr.shedskin()
	medic
		icon='Jutsus Medic.dmi'
		Healing_Jutsu
			icon_state="healing jutsu"
			Click()usr.healingjutsu()
		Poison_Needle_Barrage
			icon_state="poison needle barrage"
			Click()usr.poisonneedlebarrage()
		PreHealing_Jutsu
			name="Pre-Healing Jutsu"
			icon_state="prehealing jutsu"
			Click()usr.prehealingjutsu()
		Nervous_System_Rupture
			icon_state="nervous system rupture"
			Click()usr.nervoussystemrupture()
		Chakra_Transfer
			icon_state="chakra transfer"
			Click()usr.chakratransfer()
		Poison_Fog
			icon_state="poison fog"
			Click()usr.poisonfog()
		Chakra_Enhanced_Strength
			icon_state="chakra enhanced strength"
			Click()usr.chakraenhancedstrength()
		Mitotic_Regeneration
			icon_state="mitotic regeneration"
			Click()usr.mitoticregeneration()
		Chakra_Scalpel
			icon_state="chakra scalpel"
			Click()usr.chakrascalpel()
	iron
		icon='Jutsus Iron.dmi'
		Iron_Sand_Spike
			icon_state="iron spike"
			Click()usr.ironspike()
		Scattered_Showers
			icon_state="iron shower"
			Click()usr.ironshower()
		Toxic_Shock
			icon_state="toxic shock"
			Click()usr.toxicshock()
		Iron_Sand_Gathering
			icon_state="iron gathering"
			Click()usr.irongathering()
		Iron_Sand_Rain
			icon_state="iron rain"
			Click()usr.ironrain()
		Iron_Sand_Unleash
			icon_state="iron world"
			Click()usr.ironunleash()
		Golden_Sand
			name="Magnet Release: Golden Sand"
			icon_state="golden sand"
			Click()usr.goldensand()
		Iron_Sand_Cluster
			icon_state="iron cluster"
			Click()usr.ironcluster()
	soundnon
		Multiple_Attacks
			icon_state="multiattack"
			icon='Jutsus R.dmi'
			Click()usr.multiattack()
	spider
		Spider_Sticking_Spit
			icon_state="spiderspit"
			icon='Jutsus Y.dmi'
			Click()usr.spiderspit()
		Spider_Cocoon
			icon_state="spidercocoon"
			icon='Jutsus Y.dmi'
			Click()usr.spidercocoon()
		Spider_War_Bow
			icon_state="spiderbow"
			icon='Jutsus T.dmi'
			Click()usr.spiderbow()
		Golden_Spider_Spike
			icon_state="spiderspikes"
			icon='Jutsus R.dmi'
			Click()usr.spiderspikes()
		Rain_Of_Spiders
			icon_state="rain of spiders"
			icon='Jutsus H.dmi'
			Click()usr.rainofspiders()
	soundc
		Air_Blast
			icon_state="airblast"
			icon='Jutsus R.dmi'
			Click()usr.airblast()
		Splicing_Sound_Wave
			icon_state="splicing"
			icon='Jutsus R.dmi'
			Click()usr.zankuuha()
		Chakra_Barrier
			icon_state="chakra barrier"
			icon='Jutsus B.dmi'
			Click()usr.chakrabarrier()
		Super_Sonic_Splicing_Wave
			icon_state="super sonic splicing"
			icon='Jutsus H.dmi'
			Click()usr.superzankuuha()
	sand
		Sand_Clone_Jutsu
			icon_state="sand clone"
			icon='Jutsus C.dmi'
			Click()usr.sandclone()
		Wind_Pressure_Blast
			icon_state="wind pressure blast"
			icon='Jutsus R.dmi'
			Click()usr.windpressureblast()
		Wind_Sword
			icon_state="wind sword"
			icon='Jutsus R.dmi'
			Click()usr.windsword()
		Violent_Wind_Palm
			icon='Jutsus R.dmi'
			icon_state="violent wind palm"
			Click()usr.violentwindpalm()
	sandc
		Sand_Shield
			icon_state="sand shield"
			icon='Jutsus B.dmi'
			Click()usr.sandshell()
		Tap_Sand_Reserve
			icon_state="tap sand reserve"
			icon='Jutsus B.dmi'
			Click()usr.sandreserve()
		Sand_Armour
			icon_state="sand armour"
			icon='Jutsus B.dmi'
			Click()usr.sandarmour()
		Shukakus_Pike
			name="Shukaku's Pike"
			icon_state="shukakusspear"
			icon='Jutsus R.dmi'
			Click()usr.shukakusspear()
		Sand_Tsunami
			icon_state="sand tsunami"
			icon='Jutsus H.dmi'
			Click()usr.sandtsunami()
		Sand_Coffin
			icon_state="sand coffin"
			icon='Jutsus Y.dmi'
			Click()usr.sandcoffin()
		Sand_Shower
			icon_state="sand shower"
			icon='Jutsus Y.dmi'
			Click()usr.sandshower()
		Sand_Burial
			icon_state="sand burial"
			icon='Jutsus R.dmi'
			Click()usr.sandburial()
		Sand_Barrage
			icon_state="sand barrage"
			icon='Jutsus H.dmi'
			Click()usr.sandshower()
	clay
		C1_Spiders
			icon_state="clay spider"
			icon='Jutsus Clay.dmi'
			Click()usr.c1spider()
		C1_Bird
			icon_state="clay bird"
			icon='Jutsus Clay.dmi'
			Click()usr.c1bird()
		C3
			icon='Jutsus B.dmi'
			icon_state="magnetic suffering"
			Click()usr.c3()
		Clay_Clone
			icon='Jutsus Clay.dmi'
			icon_state="clay clone"
			Click()usr.clayclone()
		C2_Dragon
			icon='Jutsus Clay.dmi'
			icon_state="clay dragon"
			Click()usr.c2dragon()
		Clay_Mines
			icon='Jutsus Clay.dmi'
			icon_state="clay mines"
			Click()usr.claymines()
		Clay_Mines_Detonate
			icon='Jutsus Clay.dmi'
			icon_state="clay mines detonate"
			Click()usr.clayminesdetonate()
		C4_Karura
			icon='Jutsus Clay.dmi'
			icon_state="c4 karura"
			Click()usr.c4karura()
		Last_Resort
			icon='Jutsus Clay.dmi'
			icon_state="last resort"
			Click()usr.lastresort()

	senju
		Tree_Roots
			icon_state = "tree roots"
			icon = 'Jutsus Senju.dmi'
			Click()
				..()
				usr.treeroots()
		Tree_Bind_Burial
			icon_state = "tree bind burial"
			icon = 'Jutsus Senju.dmi'
			Click()
				..()
				usr.treebindburial()
		Trees_of_Life
			icon_state = "trees of life"
			icon = 'Jutsus Senju.dmi'
			Click()
				..()
				usr.treesoflife()
		Wood_Grave
			icon_state = "wood grave"
			icon = 'Jutsus Senju.dmi'
			Click()
				..()
				usr.woodgrave()
		Wood_Drill_Barrage
			icon_state = "drill barrage"
			icon = 'Jutsus Senju.dmi'
			Click()
				..()
				usr.wooddrillbarrage()
		Four_Pillars_Prison
			icon_state = "four pillars prison"
			icon = 'Jutsus Senju.dmi'
			Click()
				..()
				usr.fourpillarsprison()
		Deep_Forest_Emergence
			icon_state = "great forest emergence"
			icon = 'Jutsus Senju.dmi'
			Click()
				..()
				usr.deepforestemergence()
		Stump_Stance
			icon_state = "stump stance"
			icon = 'Jutsus Senju.dmi'
			Click()
				..()
				usr.stumpstance()
		Thorn_Stance
			icon_state = "thorn stance"
			icon = 'Jutsus Senju.dmi'
			Click()
				..()
				usr.thornstance()
		Growth_Stance
			icon_state = "growth stance"
			icon = 'Jutsus Senju.dmi'
			Click()
				..()
				usr.growthstance()
		Sage_Mode
			icon_state = "sage mode"
			icon = 'Jutsus Senju.dmi'
			Click()
				..()
				usr.sagemode()
		Thorn_Outburst
			icon_state = "thorn outburst"
			icon = 'Jutsus Senju.dmi'
			Click()
				..()
				usr.thornoutburst()
obj/byakugan
	icon='HUDbyakugan.dmi'
	name="Byakugan"
	layer=93
	screen_loc="17,17"

obj/hudbars
	layer=101
	health
		screen_loc="2:22,21:8"
		icon='hudhpbar.dmi'
	chakra
		screen_loc="2:22,20:29"
		icon='hudchabar.dmi'
	energy
		screen_loc="1:3,18:1"
		icon='hudebar.dmi'

obj/hudbuttons
	layer=99
	icon='hudbuttons.dmi'
	Relentless
		screen_loc="19,18"
	Mission
		name="A mission is available."
		icon='hudbuttons2.dmi'
		screen_loc = "20,16"
		icon_state = "mission"
		Click()
			alert("A mission is available at a mission billboard.","Mission Available")
			..()
	boost
		name="Ancestor Boost"
		icon='hudbuttons2.dmi'
		screen_loc = "20,18"
		icon_state = "boost"
	superboost
		name="Super Boost"
		icon='hudbuttons2.dmi'
		screen_loc = "18,18"
		icon_state = "superboost"
	hidable
		Rest
			icon='hudbuttons2.dmi'
			screen_loc = "20,6"
			icon_state = "rest"
			Click()
				usr.rest()
				..()
		help
			icon='hudbuttons2.dmi'
			screen_loc = "20,3"
			icon_state = "help"
			Click()
				usr.help()
				..()
		Hide
			icon='hudbuttons2.dmi'
			screen_loc = "20,8"
			icon_state = "hide"
			Click()
				usr.hide()
				..()
		Skill_Tree
			icon='hudbuttons2.dmi'
			screen_loc = "20,4"
			icon_state = "skill tree"
			Click()
				usr.skilltree()
				..()
		Who
			screen_loc = "17,2"
			icon_state = "who"
			Click()
				if(usr.whod)return
				usr.whod=1
				spawn(140)if(usr)usr.whod=0
				..()
				var/tmp/C=0
				usr <<"<b><font color=red><center>-----------WHO-----------"
				for(var/mob/player/M in world)if(M.village=="None")if(M.client)
					C++
					usr<<"<b><font color=white>[M.name]([M.key])-[M.clan]-[M.rank]"
				for(var/mob/player/M in world)if(M.village=="Leaf")if(M.client)
					C++
					usr<<"<b><font color=lime>[M.name]([M.key])-[M.clan]-[M.rank]"
				for(var/mob/player/M in world)if(M.village=="Sand")if(M.client)
					C++
					usr<<"<b><font color='#f4a460'>[M.name]([M.key])-[M.clan]-[M.rank]"
				for(var/mob/player/M in world)if(M.village=="Sound")if(M.client)
					C++
					usr<<"<b><font color=silver>[M.name]([M.key])-[M.clan]-[M.rank]"
				for(var/mob/player/M in world)if(M.village=="Akatsuki")if(M.client)
					C++
					usr<<"<b><font color=gray>[M.name]([M.key])-[M.clan]-[M.rank]"
				usr<<"<b><font color=red>Total of [C] players online at this moment."
				usr<<"<b><font color=red><center>-----------WHO-----------"
				..()
		Betrayal
			screen_loc = "13,4"
			Click()
				usr.betrayal()
				..()
		Throwing_Weapon_Toggle
			icon='hudbuttons2.dmi'
			screen_loc = "20,12"
			Click()
				usr.throwingtoggle()
				..()
	hidehud
		icon='hudbuttons2.dmi'
		screen_loc = "20,14"
		icon_state = "hidehud"
		Click()
			usr.hidehud()
			..()


obj/hotslot
	name="Hotslots - Click to set a Jutsus on this slot."
	icon='HUDnumbers.dmi'
	layer=94
	hotslot1
		screen_loc="1:3,17:-1"
		icon_state = "1"
	hotslot2
		screen_loc="1:3,16:-1"
		icon_state = "2"
	hotslot3
		icon_state = "3"
		screen_loc="1:3,15:-1"
	hotslot4
		icon_state = "4"
		screen_loc="1:3,14:-1"
	hotslot5
		icon_state = "5"
		screen_loc="1:3,13:-1"
	hotslot6
		icon_state = "6"
		screen_loc="1:3,12:-1"
	hotslot7
		icon_state = "7"
		screen_loc="1:3,11:-1"
	hotslot8
		icon_state = "8"
		screen_loc="1:3,10:-1"
	hotslot9
		icon_state = "9"
		screen_loc="1:3,9:-1"
	hotslot10
		icon_state = "10"
		screen_loc="1:3,8:-1"
	hotslot11
		icon_state = "11"
		screen_loc="1:3,7:-1"
	hotslot12
		icon_state = "12"
		screen_loc="1:3,6:-1"
	hotslot13
		icon_state = "13"
		screen_loc="1:3,5:-1"
	hotslot14
		icon_state = "14"
		screen_loc="1:3,4:-1"
	hotslot15
		icon_state = "15"
		screen_loc="1:3,3:-1"
	hotslot16
		icon_state = "16"
		screen_loc="1:3,2:-1"
obj/ach
	icon='achievebar.dmi'
	layer=97
	screen_loc="4,17"
	New()
		..()
		spawn(50)del src
	achievebar1
		New()
			..()
			flick("1",src)
	achievebar2
		New()
			..()
			flick("2",src)
	achievebar3
		New()
			..()
			flick("3",src)
obj/achieve
	icon='achieve.dmi'
	layer=98
	screen_loc="5,18"
	New()
		spawn(30)del src
obj/hotslotnum
	icon_state = "1"
	name = ""
	icon = 'HUDnumbers.dmi'
	layer = 98
	hotslot1
		screen_loc="1:3,17:-1"
		icon_state = "h1"
	hotslot2
		screen_loc="1:3,16:-1"
		icon_state = "h2"
	hotslot3
		icon_state = "h3"
		screen_loc="1:3,15:-1"
	hotslot4
		icon_state = "h4"
		screen_loc="1:3,14:-1"
	hotslot5
		icon_state = "h5"
		screen_loc="1:3,13:-1"
	hotslot6
		icon_state = "h6"
		screen_loc="1:3,12:-1"
	hotslot7
		icon_state = "h7"
		screen_loc="1:3,11:-1"
	hotslot8
		icon_state = "h8"
		screen_loc="1:3,10:-1"
	hotslot9
		icon_state = "h9"
		screen_loc="1:3,9:-1"
	hotslot10
		icon_state = "h10"
		screen_loc="1:3,8:-1"
	hotslot11
		icon_state = "h11"
		screen_loc="1:3,7:-1"
	hotslot12
		icon_state = "h12"
		screen_loc="1:3,6:-1"
	hotslot13
		icon_state = "h13"
		screen_loc="1:3,5:-1"
	hotslot14
		icon_state = "h14"
		screen_loc="1:3,4:-1"
	hotslot15
		icon_state = "h15"
		screen_loc="1:3,3:-1"
	hotslot16
		icon_state = "h16"
		screen_loc="1:3,2:-1"
obj/mischud
	icon='HUD.dmi'
	name="HUD"
	screen_loc="1,1"
	layer=90
/*client/proc/addmischud()
	var/C=0
	var/X=0
	var/Y=0
	while(C<544)
		sleep(-1)
		if(X>16)
			X=0
			Y++
		var/obj/mischud/A=new
		A.layer=100
		if(X>16)X=16
		if(Y>16)Y=16
		A.screen_loc="[X+1],[Y+1]"
		A.icon_state="[X],[Y]"
		screen+=A
		X++
		C++*/
mob/verb
	hotslot1()
		set hidden=1
		if(slot1)hotslotproc(slot1)
	hotslot2()
		set hidden=1
		if(slot2)hotslotproc(slot2)
	hotslot3()
		set hidden=1
		if(slot3)hotslotproc(slot3)
	hotslot4()
		set hidden=1
		if(slot4)hotslotproc(slot4)
	hotslot5()
		set hidden=1
		if(slot5)hotslotproc(slot5)
	hotslot6()
		set hidden=1
		if(slot6)hotslotproc(slot6)
	hotslot7()
		set hidden=1
		if(slot7)hotslotproc(slot7)
	hotslot8()
		set hidden=1
		if(slot8)hotslotproc(slot8)
	hotslot9()
		set hidden=1
		if(slot9)hotslotproc(slot9)
	hotslot10()
		set hidden=1
		if(slot10)hotslotproc(slot10)
	hotslot11()
		set hidden=1
		if(slot11)hotslotproc(slot11)
	hotslot12()
		set hidden=1
		if(slot12)hotslotproc(slot12)
	hotslot13()
		set hidden=1
		if(slot13)hotslotproc(slot13)
	hotslot14()
		set hidden=1
		if(slot14)hotslotproc(slot14)
	hotslot15()
		set hidden=1
		if(slot15)hotslotproc(slot15)
	hotslot16()
		set hidden=1
		if(slot16)hotslotproc(slot16)
mob
	proc
		hotslotproc(var/A)
			var/k="[A]"
			switch(k)
				if("Whirlwind Kick")whirlwindkick()
				if("Dancing Leaf Shadow")dancingleafshadow()
				if("Rising Wind")risingwind()
				if("Dynamic Entry")dynamicentry()
				if("Primary Lotus")primarylotus()
				if("Morning Peacock")morningpeacock()
				if("Hidden Lotus")hiddenlotus()
				//
				if("Fang Over Fang")fangoverfang()
				//
				if("Tree Roots")treeroots()
				if("Tree Bind Burial")treebindburial()
				if("Trees of Life")treesoflife()
				if("Wood Grave")woodgrave()
				if("Wood Drill Barrage")wooddrillbarrage()
				if("Four Pillars Prison")fourpillarsprison()
				if("Deep Forest Emergence")deepforestemergence()
				if("Thorn Stance")thornstance()
				if("Growth Stance")growthstance()
				if("Stump Stance")stumpstance()
				if("Sage Mode")sagemode()
				if("Thorn Outburst")thornoutburst()
				//
				if("Rally")rally()
				if("Raiden")raiden()
				if("Raikiri")raikiri()
				if("Blank Jutsu 1")blankjutsu1()
				if("Blank Jutsu 2")blankjutsu2()
				if("Blank Jutsu 3")blankjutsu3()
				if("Blank Jutsu 4")blankjutsu4()
				if("Blank Jutsu 5")blankjutsu5()
				if("Sharingan Implant")sharingan()
				//
				if("Clone Jutsu")clonejutsu()
				if("Transformation")transformation()
				if("Body Flicker Technique")bodyflickertechnique()
				if("Substitution")substitution()
				if("False Mirror")falsemirror()
				//
				if("Fuuma Shuriken")fuumashuriken()
				if("Fireball Jutsu")fireballjutsu()
				if("One Thousand Years of Death")constipation()
				if("Twin Dragon Weapon Barrage")dragonweapon()
				if("Akatsuki Summon")akatsummon()
				//
				if("Sixty Four Palms")sixtyfour()
				if("One Hundred and Twenty Eight Palms")onetwentyeight()
				if("Empty Palm")empty()
				if("Byakugan")byakugan()
				if("Wind Shield")windshield()
				if("Precise Striking")precisestriking()
				if("Rapid Palms")rapidpalms()
				if("Mountain Crusher")mountain()
				if("Lion Palm")lionpalm()
				if("Rotation")kaiten()
				//
				if("Dance of the Seedling Ferns")seedlingferns()
				if("Dance of the Camellia")camellia()
				if("Dance of the Willow")willow()
				if("Dance of the Pines")pines()
				if("Dance of the Clematis")clematis()
				//
				if("Sickling Wind")sicklingwind()
				if("Sandstorm")sandstorm()
				if("Bloodlust")bloodlust()
				if("Air Bullet")airbullet()
				if("Powered")powered()
				if("Bone Golem")bonegolem()
				if("Double Blades")doubleblades()
				if("Extreme Condensing")extremecondensing()
				if("Chidori Current")chidoricurrent()
				if("Great Sickling Wind")greatsicklingwind()
				if("Dragon's Storm")dragonsstorm()
				if("Whirlwind Palm")whirlwindpalm()
				if("Hurricane")hurricane()
				if("Condensed Wind")condensedwind()
				if("Ripping Gale Jutsu")rippinggalejutsu()
				//
				if("Kirin")kirin()
				//
				if("Shadow Clone Jutsu")shadowclonejutsu()
				if("Advanced Tracking")advancedtracking()
				if("Shuriken Clone Jutsu")shurikenclonejutsu()
				if("Lightning Spear")lightningspear()
				if("Rasengan")rasengan()
				if("Lightning Flash")lightningflash()
				if("Mastered Substitution")substitutionmast()
				//
				if("Shadow Imitation")imitation()
				if("Shadow Strangle")neckbind()
				if("Shadow Sewing Jutsu")shadowsewing()
				if("Shadow Endgame")shadowsummoning()
				if("Strategic Bombing")strategicbombing()
				if("Shadow Gathering")shadowgathering()
				if("Shadow Clutch")shadowclutch()
				if("Shadow Possession Shuriken")shadowshuriken()
				if("Shadow Fists")shadowfists()
				//
				if("C1 Spiders")c1spider()
				if("C1 Bird")c1bird()
				if("C3")c3()
				if("Clay Clone")clayclone()
				if("C2 Dragon")c2dragon()
				if("Clay Mines")claymines()
				if("C4 Karura")c4karura()
				if("Last Resort")lastresort()
				if("Clay Mines Detonate")clayminesdetonate()
				//
				if("Sand Shield")sandshell()
				if("Sand Tsunami")sandtsunami()
				if("Sand Barrage")sandshower()
				if("Sand Shower")sandshower()
				if("Sand Burial")sandburial()
				if("Tap Sand Reserve")sandreserve()
				if("Sand Armour")sandarmour()
				if("Sand Coffin")sandcoffin()
				if("Shukaku's Pike")shukakusspear()
				if("Shadow Word: Pain")
					shadowwordpain()
					shadowwordpain()
					shadowwordpain()
					shadowwordpain()
				//
				if("Senbon Wave")senbonwave()
				if("A Thousand Needles of Death")onekdeath()
				if("Demon Ice Mirrors")demonicemirrors()
				if("Ice Mirrors")icemirrors()
				if("Ice Dome")icedome()
				if("Water Clone")waterclone()
				if("Iceberg Breaker")icebreaker()
				if("Ice Prison")iceprison()
				if("Hidden Mist Jutsu")mistjutsu()
				//
				if("Striking Shadow Snake")strikingsnake()
				if("Chakra Absorption")chakraabs()
				if("Sky Blade")skyblade()
				if("Binding Snake Glare")snakeglare()
				if("Immortality Jutsu")immortality()
				if("Edo Tensei")edotensei()
				if("Shed Skin")shedskin()
				if("Healing Jutsu")healingjutsu()
				if("Poison Needle Barrage")poisonneedlebarrage()
				if("Pre-Healing Jutsu")prehealingjutsu()
				if("Nervous System Rupture")nervoussystemrupture()
				if("Chakra Transfer")chakratransfer()
				if("Poison Fog")poisonfog()
				if("Chakra Enhanced Strength")chakraenhancedstrength()
				if("Mitotic Regeneration")mitoticregeneration()
				if("Chakra Scalpel")chakrascalpel()
				//
				if("Susanoo")chidoricurrent()
				if("Tsukuyome")piercinggaze()
				if("Yasaka Magatama")phoenixflower()
				if("Amaterasu Unleash")chidori()
				if("Kagutsuchi")bodyillusion()
				if("Amaterasu")fireballjutsu()
				if("Phoenix Flower Jutsu")phoenixflower()
				if("Disperse")disperse()
				if("Sharingan")sharingan()
				if("Chidori")chidori()
				if("Mangekyou Sharingan")mangekyou()
				if("Eternal Mangekyou Sharingan")emangekyou()
				if("Triple Windmill")triplewindmill()
				if("Falcon Drop")falcondrop()
				if("Ephemeral")ephemeral()
				if("Snap Regeneration")snapregen()
				if("Lockdown")lockdown()
				if("Heal")heal()
				if("Landmine")landmine()
				if("Body Illusion")bodyillusion()
				if("Clone Explosion")cloneexplosion()
				if("Dragon Flames Jutsu")dragonflames()
				if("Great Dragon Flames")greatdragonflames()
				if("Backdash")backdash()
				//if("Tracking")tracking()
				if("Assassinate")assassinate()
				//
				if("Shadow Clone Combo")shadowclonecombo()
				if("Sexy Jutsu")sexy()
				if("Fire Dragon Flame Blast")firedragonflameblast()
				if("Lightning Blade")raikiri()
				//
				if("Rashoumon")rashoumon()
				if("Striking Shadow Snake")strikingsnake()
				if("Piercing Gaze")piercinggaze()
				if("Vengeance")vengeance()
				if("Shuriken Barrage")shurikenbarrage()
				if("Death Viewing Technique")deathviewing()
				if("Massacre Shadow Snakes")massacresnakes()
				//
				if("Multiple Attacks")multiattack()
				//
				if("Spider Sticking Spit")spiderspit()
				if("Golden Spider Spike")spiderspikes()
				if("Demon Soul Transfer")demonsoultransfer()
				if("Spider Cocoon")spidercocoon()
				if("Spider War Bow")spiderbow()
				if("Rain Of Spiders")rainofspiders()
				//
				if("Sand Clone Jutsu")sandclone()
				if("Wind Sword")windsword()
				if("Wind Pressure Blast")windpressureblast()
				if("Violent Wind Palm")violentwindpalm()
				//
				if("Air Blast")airblast()
				if("Splicing Sound Wave")zankuuha()
				if("Chakra Barrier")chakrabarrier()
				if("Super Sonic Splicing Wave")superzankuuha()
				//
				if("Iron Sand Spike")ironspike()
				if("Mark of Death")markofdeath()
				if("Scattered Showers")ironshower()
				if("Toxic Shock")toxicshock()
				if("Iron Sand Gathering")irongathering()
				if("Iron Sand Rain")ironrain()
				if("Iron Sand Unleash")ironunleash()
				if("Magnet Release: Golden Sand")goldensand()
				if("Iron Sand Cluster")ironcluster()
				if("Radiate")radiation()
				//
				if("Curse Seal")curseseal()
				//items
				if("Blood Pill")zbloodpill()
				if("Chakra Pill")zchakrapill()
				if("Hero's Water")heroswater()
				if("Smoke Bomb")smokebombthrow()
				if("Chakra Tracker")advancedtracker()
				if("Fire Bomb")firebombthrow()
				if("Bee Killing Blaze Bomb")blazebombthrow()
				if("Radio")radio()
				if("Bingo Book")bingobook()
