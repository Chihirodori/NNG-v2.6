turf
	testtube
		layer=50
		icon='testtube.dmi'
		density=1
	flatrock
		icon='flatrock.dmi'
	sanddune
		icon='sanddune.dmi'
	shadowsandgate
		layer=38
		icon='shadowsandgate.dmi'
	Arena
		icon='arena.dmi'
		layer=9
		mouse_opacity=0
		wall222
			icon_state=  "wall222"
			density = 1
		wall2222
			icon_state=  "wall2222"
			density = 1
		wall22222
			icon_state=  "wall22222"
			density = 1
		wall222222
			icon_state=  "wall222222"
			density = 1
		wall2222222
			icon_state=  "wall2222222"
			density = 1
		wall22222222
			icon_state=  "wall22222222"
			density = 1
		wall222222222
			icon_state=  "wall222222222"
			density = 1
		wall2222222222
			icon_state=  "wall2222222222"
			density = 1
		wall22222222222
			icon_state=  "wall22222222222"
			density = 1
		wall222222222222
			icon_state=  "wall222222222222"
			density = 1
	soundmanhole/icon='soundmanhole.dmi'
	bcliff
		name=""
		icon='bcliff.dmi'
	bcliff2
		name=""
		icon='bcliff2.dmi'
	gcliff
		name=""
		icon='gcliff.dmi'
	gcliff2
		name=""
		icon='gcliff2.dmi'
	cliffshad
		name=""
		icon='cliffshad.dmi'
	tree
		name=""
		//icon='tree.dmi'
	tree2
		name=""
		icon='tree2.dmi'
	tallprop
		name=""
		icon='tallprop.dmi'
	Cliff
		icon='cliff.dmi'
		name = "Cliff"
		density = 1
		mouse_opacity=0
		Middle
			icon_state = "middle"
			New()
				..()
				icon_state=pick("middle","middle2")
		Right/icon_state = "right"
		BottomRight
			density=0
			layer=2
			icon_state = "bottom right"
		Bottom
			density=0
			layer=2
			icon_state = "bottom"
		Left/icon_state = "left"
		BottomLeft
			density=0
			layer=2
			icon_state = "bottom left"
		Other/density=0
		cave/icon_state = "cave"
		cave2/icon_state = "cave2"
		cave3/icon_state = "cave3"
		HokageFaces
			icon='hokage mountin.png'
			layer = 5
			density=1
		Hokage2
			icon='hokage2.png'
			layer = 5
		Hand1
			icon='hand1.png'
			density = 1
			layer=50
		Hand2
			icon='hand2.png'
			density = 1
			layer=50
		AkatHands
			icon='AkatsukiSealHands.png'
			density = 1
			layer=50
		AkatStatue
			icon='AkatsukiSealStatue.png'
			density = 1
			layer=50
	Cliff2
		icon='cliff2.dmi'
		name = "Cliff"
		density = 1
		mouse_opacity=0
		Middle
			icon_state = "middle"
			New()
				..()
				icon_state=pick("middle","middle2")
		nondenselowlayer
			density=0
			layer=2
		dense
		nondense/density=0
	Grass
		icon = 'Grass.dmi'
		Middle
			icon_state = "Middle"
			New()
				..()
				if(icon_state=="Middle")icon_state=pick("Middle","Middle1","Middle2","Middle3","Middle4")
	scareyou/icon='scareyou.jpg'
	scareyou2/icon='scareyou2.jpg'
	scareyou3/icon='scarethem.png'
	Grass2
		icon = 'Grass 2.dmi'
		name="Grass"
	Snow
		icon='Snow.dmi'
		name = "Snow"
		Middle/icon_state = "Middle"
		Right/icon_state = "Right"
		Left/icon_state = "Left"
		Bottom/icon_state = "Bottom"
		Top/icon_state = "Top"
		TopRight/icon_state = "Top Right"
		BottomRight/icon_state = "Bottom Right"
		TopLeft/icon_state = "Top Left"
		BottomLeft/icon_state = "Bottom Left"
	Ricefield/icon='ricefield.dmi'
	Ground/icon='Ground.dmi'
	AkatFloor/icon='akat floor.dmi'
	Dirt
		icon='Dirt.dmi'
		name = "Dirt"
		Middle
			icon_state = "Middle"
			New()
				..()
				if(icon=="Middle")
					icon_state=pick("Middle","Middle2","Middle3","Middle4")
	Waterfall
		icon='Water.dmi'
		name = "Waterfall"
		contain
			icon=null
			layer=90
		Waterfall
			icon_state = "Waterfall"
		Waterfall1/icon_state = "Waterfall1"
		Waterfall2/icon_state = "Waterfall2"
	mobblock
		Entered(var/mob/M)
			if(M.dir==NORTH)M.y--
			if(M.dir==SOUTH)M.y++
			if(M.dir==EAST)M.x++
			if(M.dir==WEST)M.x--
			..()
	GrassTall
		icon='GrassDeep.dmi'
		name = "Grass"
		Middle
			icon_state = "Middle"
			New()
				..()
				icon_state=pick("Middle","Middle1","Middle2")
		Right/icon_state = "Right"
		Right_Bottom/icon_state = "Right Bottom"
		Right_Top/icon_state = "Right Top"
		Bottom/icon_state = "Bottom"
		Top/icon_state = "Top"
		Left/icon_state = "Left"
		Left_Bottom/icon_state = "Left Bottom"
		Left_Top/icon_state = "Left Top"
	Canoe
		name="Canoe"
		density=0
		layer=2
		one/icon='Canoe1.png'
		two/icon='Canoe3.png'
	Log
		icon='logt.dmi'
		name="Log"
		layer=45
	counter1
		layer=70
		icon='counter1.dmi'
	counter2
		layer=70
		icon='counter2.dmi'
	sunacliff
		icon='sunacliff.dmi'
		layer=70
	Outside_Props
		icon='Outside Props.dmi'
		dense/density=1
	KonohaGround
		icon='KonohaGround.dmi'
		dense/density=1
	Sand
		icon='Sand.dmi'
		name = "Sand"
		Middle/icon_state = "Middle"
		Other/icon_state = "other sand"
		Middle3
			icon_state = "s1"
			New()
				..()
				icon_state=pick("s1","s2","s3","s4","s5","s6","s7","s8","s9")
	Sand_Edge
		icon='Sand Edge.dmi'
		name="Sand"
	Water_Shallow
		icon='Water Shallow.dmi'
		name="Water"
	Sand2
		icon='Sand.dmi'
		layer=2
		density = 1
		Mountain/icon_state = "Mountin"
		Rock/icon_state = "rock"
		Rock2
			icon_state = "rock2"
			density = 0
		Rock3
			icon_state = "rock3"
			density = 0
	tBuildings
		mouse_opacity=0
		name = "Building"
		layer = 40
		density = 0
		cover
			layer=70
			icon='cover.dmi'
		bridgec/icon='bridgec.png'
		bridge
			layer=2
			icon='bridge.png'
		house1/icon='house1.png'
		house2/icon='house2.png'
		house3/icon='house3.png'
		soundentrance/icon='soundentrance.png'
		ramen/icon='ramen.png'
		academy/icon='acadamy.png'
		sandacademy
			layer=2
			icon='sand acadamy.png'
		sandacademyov/icon='sand acadamyov.png'
		police/icon='Police.png'
		house4/icon='house4.png'
		hokagehouse1/icon='hokagehouse1.png'
		grassleader/icon='GrassLeaderHouse.png'
		kazekagehouse
			layer=2
			icon='kazekagehouse.png'
		kazekagehouseov
			icon='kazekagehouseov.png'
		house5/icon='house5.png'
		house6/icon='house6.png'
		hospital1/icon='hospital1.png'
		billboard1/icon='billboard1.png'
		billboard2/icon='billboard2.png'
		billboard3/icon='billboard3.png'
		Poster1/icon='Poster 1.png'
		arena/icon='arena.png'
		sandarena/
			layer=2
			icon='sand arena.png'
		sunabuilding01
			layer=2
			icon='sunabuilding01.png'
		sunabuilding01ov
			icon='sunabuilding01ov.png'
		leafhouse
			icon='leafhouse.png'
		leafhouse2
			icon='leafhouse2.png'
		sandhouse1
			layer=2
			icon='sand house 1.png'
		sandhouse2
			layer=2
			icon='sand house 2.png'
		sandhouse1ov/icon='sand house 1ov.png'
		sandhouse2ov/icon='sand house 2ov.png'
		sandhosp
			layer=2
			icon='sunahospital.png'
		sandhospov/icon='sunahospitalov.png'
		Memorial
			icon='Memorial.png'
			layer = 3
		Memorial2/icon='Memorial2.png'
		houseFOD/icon='fod house.png'
		Soundhouse1/icon='Sound house 1.png'
		Soundhouse2/icon='Sound house 2.png'
		bountyleaf/icon='bountyleaf.png'
		bounty/icon='bounty.png'
		Soundhouse3/icon='Sound house 3.png'
		Soundhouse4/icon='Sound house 4.png'
		Soundhouse5/icon='Sound house 5.png'
		SoundAcademy/icon='Sound Academy.png'
		Soundequipment/icon='Sound equipment house.png'
		Soundhospital/icon='Sound hospital.png'
		Soundarena/icon='Sound arena.png'
		SoundkageMansion/icon='Soundkage Mansion.png'
	Darkness
		icon='Darknes.dmi'
		name = " "
		layer = 55
		alpha1501
			icon_state = "alpha1501"
	Town_Objects
		icon='Town Objects.dmi'
		name = " "
		density = 0
		layer = 15
		UchihaSymbol
			icon_state = "uchiha symbol"
			density = 1
			layer = 51
		UchihaSymbol2
			icon_state = "uchiha symbol2"
			density = 1
			layer = 15
		konentrance
			icon='kon entrance.png'
			layer = 16
		konentrance2
			icon='kon entrance2.png'
			layer = 16
		konentrance3
			icon='kon entrance3.png'
			layer = 16
	Water
		icon='Water.dmi'
		icon_state="Water"
		Water2/icon_state="Water2"
		New()
			..()
			dir=pick(NORTH,SOUTH,EAST,WEST)
	Void
		icon='Void.dmi'
		name = ""
		density = 1
		opacity = 1
		Void1/icon_state = "1"
		Void2
			opacity=0
			icon_state = "2"
	Darkness
		icon='Darknes.dmi'
		name = " "
		layer = 55
		alpha1501
			icon_state = "alpha1501"
	InsideKonoha
		icon='Inside Konoha.dmi'
		name = ""
		layer=20
		Dense/density=1
		Object_Layer2/layer=3
		Object_Dense_Layer
			density=1
			layer=2
	Wall_Sand
		icon='Wall Sand.dmi'
		name = ""
		layer=20
		Dense/density=1
		Object_Layer2/layer=3
		Object_Dense_Layer
			density=1
			layer=2
	Wall_Leaf
		icon='Wall Leaf.dmi'
		name = ""
		layer=20
		Dense/density=1
		Object_Layer2/layer=3
		Object_Dense_Layer
			density=1
			layer=2
	Flooring
		icon='Flooring.dmi'
		layer=1
	Props
		icon='Props.dmi'
		layer=2
		Dense/density=1
		layer/layer=25
	Darkness
		icon='Darknes.dmi'
		name=""
		layer=90
		handdark
			icon = 'hand shadow.png'
			layer = 35
	GM_House
		icon='GM House.dmi'
		name=""
		a1/icon_state="1"
		a2/icon_state="2"
		a3/icon_state="3"
		a4/icon_state="4"
		a5/icon_state="5"
		a6/icon_state="6"
		a7/icon_state="7"
		a8/icon_state="8"
		aladder
			icon_state="ladder"
			Entered(M)
				if(ismob(M))
					M:swim=1
					M:icon_state="swim"
				..()
		teleport
			icon_state="portal"
			layer=50
			Entered(M)
				if(ismob(M))
					M:loc=locate(rand(200,400),rand(200,400),2)
					M:density=0
					M:icon_state="image"
					spawn(70)
						M:density=1
						M:icon_state=""
				..()
		heal
			icon_state="heal"
			layer=2
			Entered(M)
				if(ismob(M))
					M:blind=0
					M:hp=M:maxhp
					M:cha=M:maxcha
					M:energy=M:maxenergy
				..()
		reset
			icon='tempdummy.dmi'
			icon_state="reset"
			layer=2
			Entered(var/mob/player/M)
				M:level=1
				M.Sta=1
				M.Hsl=1
				M.Tai=1
				M.Nin=1
				M.Str=1
				M.Int=1
				M.Spd=1
				M.staexp=0
				M.intexp=0
				M.hslexp=0
				M.taiexp=0
				M.apowexp=0
				M.ninexp=0
				M.spdexp=0
				M.intexp=0
				M.staexpm=100
				M.intexpm=100
				M.energy=100
				M.maxenergy=20
				M.hslexpm=20
				M.taiexpm=20
				M.apowexpm=20
				M.ninexpm=20
				M.spdexpm=20
				M.intexpm=20
				M.skillpoint=1
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
				M.slot1=null
				M.slot2=null
				M.slot3=null
				M.slot4=null
				M.slot5=null
				M.slot6=null
				M.slot7=null
				M.slot8=null
				M.slot9=null
				M.slot10=null
				M.slot11=null
				M.slot12=null
				M.slot13=null
				M.slot14=null
				M.slot15=null
				M.slot16=null
				M.skilltotal=0
				M.tier63=0
				M.overlay()
				M.statset()
				for(var/obj/jutsu/Mastered_Substitution/G in M)del G
				for(var/obj/jutsu/Backdash/G in M)del G
				for(var/obj/jutsu/Assassinate/G in M)del G
				for(var/obj/jutsu/troj/Lightning_Flash/G in M)del G
				for(var/obj/jutsu/kaguya/G in M)del G
				for(var/obj/jutsu/hyuuga/G in M)del G
				for(var/obj/jutsu/wind/G in M)del G
				for(var/obj/jutsu/uchiha/G in M)del G
				M.refreshword()
				world<<"<font color=red><b>Stat Notice: [M] resetted!"
				..()
obj
	Waterfall
		Crossed(M)
			..()
			if(ismob(M))
				var/odir=M:dir
				M:fast=1
				if(prob(100-M:level))
					step(M,SOUTH)
				if(!M)return
				M:fast=0
				M:waterfallsplash()
				M:dir=odir
				M:cha-=4
				if(M:cha<=0)
					M:cha=0
					M:energy-=rand(5,10)
					if(M:energy<0)M:deathdrown()
	Props2
		icon='Props2.dmi'
		layer=2
		correctpixel
		Dense/density=1
		layer/layer=25
		sixteenkayer
			pixel_y=16
			layer=25
		sixteen
			pixel_y=16
	soundgate
		pixel_y=10
		icon='soundgate.png'
	sunacliffrock
		layer=20
		icon='sunacliffrock.dmi'
	pylon
		density=1
		name="This map is under construction."
		icon='temp.dmi'
		icon_state="pylon"
	Scarecrow
		icon='scarecrow.dmi'
		density=1
		layer=35
	Cactus
		icon='cactus.dmi'
		layer=20
		density=1
		icon_state="cactus"
		New()
			..()
			icon_state=pick("","2")
	Furnature
		Bed
			icon='Bed.dmi'
			name=""
			pixel_x=-5
			layer=2
			pixel_y=-7
			bed
				icon_state="bed"
			bedc
				icon_state="bedc"
				layer=15
			bed2
				icon_state="1bed"
			bedc2
				icon_state="1bedc"
				layer=15
			bed3
				icon_state="2bed"
			bedc3
				icon_state="2bedc"
				layer=15
	Tree
		name = "Tree"
		layer=40
		density=1
		dense
		log
			density=1
			icon='traininglog.dmi'
		tree
			density=1
			pixel_x=-40
			pixel_y=-26
			icon='tree.png'
			New()
				..()
				if(prob(1))new/obj/Wildlife/Bird_Spawn(locate(x,y+2,z))
		tree2
			pixel_x=-67
			pixel_y=-20
			icon='tree2.dmi'
		tree3
			pixel_x=-92
			pixel_y=-22
			icon='treej.png'
			New()
				..()
				new/obj/Tree/dense(locate(x-1,y+1,z))
				new/obj/Tree/dense(locate(x,y+1,z))
				new/obj/Tree/dense(locate(x+1,y+1,z))
				new/obj/Tree/dense(locate(x-1,y,z))
				new/obj/Tree/dense(locate(x+1,y,z))
		tree4
			pixel_x=-40
			pixel_y=-26
			icon='tree3.png'
		tree5
			pixel_x=-32
			icon='Dead Tree.png'
		tree6
			pixel_x=-22
			icon='treedead.dmi'
	Jiraiya_Memorial
		icon='Jiraiya Memorial.dmi'
		name="Ancestor's Shrine"
		density=1
		layer=40
		Click()
			for(var/mob/player/M in range(src,1))
				if(M==usr)
					if(M.shrinecd)
						M<<"<font color=cyan>You must wait another [M.shrinecd] seconds to pay your respects again."
					else
						M<<"<font color=cyan><b>You pay your respect to your ancestors. You have gained 300% training rate."
						M.ancestorboost=1200
						M.shrinecd=7200
						M.client.screen+=new/obj/hudbuttons/boost
	Object
		name="Naruto: Next Generation"
		icon='Objects.dmi'
		Dense/density=1
	Flag_Pole
		icon='flagpole.dmi'
		density=1
		layer=42
	Flag_PoleS
		icon='flagpole.dmi'
		density=0
		icon_state="shadow"
		layer=42
		pixel_y=-96
	Tumbleweed
		icon='Outside Props.dmi'
		icon_state="tumbleweed"
		New()spawn(1200)del src
		Bump()
			..()
			del src
	tumbleweedmaker
		name=""
		New()
			..()
			spawn()Tumblr()
		proc
			Tumblr()
				sleep(rand(200,23750))
				var/T=new/obj/Tumbleweed(loc)
				walk(T,EAST,2)
				Tumblr()
	Wildlife
		density=0
		Bird_Spawn
			name=""
			New()
				..()
				spawn()Thug_Life()
			proc
				Thug_Life()
					sleep(rand(300,1200))
					var/obj/T
					var/r=rand(1,3)
					if(r==1)T=new/obj/Wildlife/Bird
					if(r==2)T=new/obj/Wildlife/Blue_Bird
					if(r==3)T=new/obj/Wildlife/Raven
					T:loc=loc
					var/G=pick(NORTH,SOUTH,EAST,WEST)
					walk(T,G,2)
					Thug_Life()
		Bird
			layer=70
			icon='birdshadow.dmi'
			New()
				..()
				overlays+=/obj/Wildlife/Overlay/Bird
				spawn(420)del src
		Blue_Bird
			layer=70
			icon='birdshadow.dmi'
			New()
				..()
				overlays+=/obj/Wildlife/Overlay/Blue_Bird
				spawn(420)del src
		Raven
			layer=70
			icon='birdshadow.dmi'
			New()
				..()
				overlays+=/obj/Wildlife/Overlay/Raven
				spawn(420)del src
		Overlay
			pixel_y=150
			layer=71
			Raven/icon='raven.dmi'
			Bird/icon='bird.dmi'
			Blue_Bird/icon='birdblue.dmi'
		Butterfly
			layer=8
			icon='butterfly.dmi'
			rundelay=2
			var/ololoc
			New()
				..()
				ololoc=loc
				spawn()Butterfree()
			proc
				Butterfree()
					walk(src,0)
					walk_rand(src,2)
					sleep(rand(800,1200))
					walk_towards(src,ololoc,2)
					spawn()Butterscotch()
				Butterscotch()
					while(loc!=ololoc)
						sleep(50)
					Butterfree()
	dummy
		icon='dummy.dmi'
		density=1
	tempdummy
		icon='tempdummy.dmi'
		density=1
		exp/icon_state="exp"
	opacity
		layer=100
		opacity=1
	Safe_Zone
		layer=80
		icon='safezone.dmi'
		invisibility=70
		New()
			..()
			icon=null

	NPC_Block
		layer=80
		icon='mapeasy.dmi'
		icon_state="block"
		invisibility=70
		New()
			..()
			icon=null
	DropToAkatsuki
	density
		layer=99
		icon='mapeasy.dmi'
		icon_state="density"
		invisibility=50
		density=1
mob/proc/waterfallsplash()
	overlays+=/obj/waterfallstep
	spawn(2)
		overlays-=/obj/waterfallstep
area
	Weather
		icon='weather.dmi'
		mouse_opacity=0
		layer=74
		Rain/icon_state = "Rain"
		Snowing/icon_state = "Snowing"
	Endtimes
		Enter(mob/M)
			if(istype(M,/mob/Animal))
				walk(M,0)
				if(M:spawnowner)walk_towards(M,M:spawnowner)
				else del M
				return
			..()
	Water
		Entered(mob/M)
			if(istype(M,/mob/Animal))
				M.icon_state="swim"
				return
			..()
			if(ismob(M)&&!M.onwater)
				if(M.running&&M.con<40)
					M.running=0
					M.runstep=0
					M.icon_state=""
				M.onwater=1
				if(M.weights)
					M.swim=1
					M.icon_state="swim"
					M.regenupdate()
		Exited(mob/M)
			..()
			if(ismob(M))
				M.onwater=0
				M.swim=0
				if(M.icon_state=="swim")
					M.icon_state=""
					M.regenupdate()
				return 1
	Sandstorm
		mouse_opacity=0
		layer=74
		icon='Sandstorm.dmi'
		var/savedi
		New()
			..()
			savedi=icon_state
			spawn()stormyday()
		proc
			stormyday()
				sleep(3000)
				icon_state=""
				flick("fade",src)
				sleep(3000)
				icon_state=savedi
				stormyday()
		Entered(mob/M)
			..()
			if(istype(M,/mob/player))
				M.onsand=1
				if(M.village=="Sand")
					M.inzone=1
					M.atkdef()
		Exited(mob/player/M)
			..()
			if(istype(M,/mob/player))
				M:onsand=0
				M:inzone=0
				M:atkdef()
	Leaf_Zone
		mouse_opacity=0
		Entered(mob/M)
			..()
			if(istype(M,/mob/player))
				if(M.village=="Leaf")
					M.inzone=1
					M.atkdef()
		Exited(mob/player/M)
			..()
			if(istype(M,/mob/player))
				M:inzone=0
	Leaf_Super_Zone
		mouse_opacity=0
		Entered(mob/M)
			..()
			if(istype(M,/mob/player))
				if(M.village=="Leaf")
					M.inzone=2
					M.atkdef()
		Exited(mob/player/M)
			..()
			if(istype(M,/mob/player))
				M:inzone=0
	Sand_Super_Zone
		mouse_opacity=0
		Entered(mob/M)
			..()
			if(istype(M,/mob/player))
				if(M.village=="Sand")
					M.inzone=2
					M.atkdef()
		Exited(mob/player/M)
			..()
			if(istype(M,/mob/player))
				M:inzone=0
	Safe_Zone
		mouse_opacity=0
		Entered(mob/M)
			..()
			if(istype(M,/mob/player))
				M.safezone=1
		Exited(mob/player/M)
			..()
			if(istype(M,/mob/player))
				M.safezone=0
	Sandstormwater
		mouse_opacity=0
		layer=89
		icon='Sandstorm.dmi'
		var/savedi
		New()
			..()
			savedi=icon_state
			spawn()stormyday()
		proc
			stormyday()
				sleep(3000)
				icon_state=""
				flick("fade",src)
				sleep(3000)
				icon_state=savedi
				stormyday()
		Entered(mob/M)
			if(istype(M,/mob/Animal))
				M.icon_state="swim"
				return
			..()
			if(ismob(M)&&!M.onwater)
				if(M.running&&M.con<80)
					M.running=0
					M.runstep=0
					M.icon_state=""
				M.onwater=1
		Exited(mob/M)
			..()
			if(ismob(M))
				M.onwater=0
				M.swim=0
				if(M.icon_state=="swim")
					M.icon_state=""
					M.regenupdate()
				return 1
	Water2
		icon='Water.dmi'
		icon_state="Water"
		invisibility=100
		Entered(mob/M)
			if(istype(M,/mob/Animal))
				walk(M,0)
				if(M:spawnowner)walk_towards(M,M:spawnowner)
				else del M
				return
mob/var/safezone=0
obj
	Telesound
		ladderup
			icon='clear.dmi'
			mouse_opacity=2
			Click()
				for(var/mob/player/M in range(src,1))
					if(M==usr)
						if(usr.zonedelay||usr.cdelay1)return
						usr.cdelay1=1
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
						usr.loc=locate(406,297,2)
						usr.zonedelay()
						if(usr.village=="Sound")
							usr.inzone=0
							usr.atkdef()
						for(var/mob/Clone/M2 in world)if(M2.cloneowner==usr)del M2

	MetalFence
		icon='Metal Fence.dmi'
		name = ""
		density = 0
		layer = 45
	DropToDeath
		Crossed(mob/M)
			if(!ismob(M))return
			if(M.mission=="Missing-Nin Hideout (B Rank)"&&M.weedpick==0)
				M.z=5
				M.barloc()
				M<<"<b>The alarm has activated. Prepare for attack."
				for(var/obj/items/Coordinates/G in M)
					del G
				spawn(34)M.missingrampage()
	Mission_Event
		Sasuke
			Crossed(mob/M)
				if(!ismob(M))return
				if(M.mission=="Defeat Sasuke Uchiha (A Rank)"&&M.weedpick==0)
					for(var/mob/NPC/mission/Sasuke/G in world)
						if(G:owner)
							M<<"<b>Someone is currently fighting Sasuke."
							return
						else del G
					M.z=5
					M.barloc()
					var/mob/NPC/mission/Sasuke/t=new(locate(330,212,5))
					t.owner=M
					new/obj/tele(t.loc)