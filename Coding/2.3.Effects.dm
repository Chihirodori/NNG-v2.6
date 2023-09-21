mob/proc/tempfreeze(var/A)
	if(!freeze)freeze=1
	spawn(A)freeze=0
obj/var/tmp/cloudbreak=0
obj
	ignite
		icon='ignite.dmi'
		layer=50
	igniteamat
		icon='ignite.dmi'
		icon_state="amat"
		layer=50
	disabledelay
		icon='effect.dmi'
		icon_state="disable"
		layer=50
	highov
		layer=90
		icon='invisibleman.dmi'
	muted
		icon='muted.dmi'
		name="Muted"
		layer=80
	markedeath
		icon='markofdeath.dmi'
		layer=70
		pixel_y=32
	frostmark
		icon='markoffrost.dmi'
		layer=70
	sparpartner
		icon='spar.dmi'
		layer=70
		pixel_y=32
	sandcloud
		icon='sandcloud.dmi'
		pixel_y=-23
		begin
			icon_state="leblanc"
			pixel_y=0
			New()
				..()
				flick("begin",src)
				spawn(22)del src
			Del()
				if(cloudbreak)new/obj/sandcloud/end(loc)
				..()
		end
			pixel_y=0
			icon_state="leblanc"
			New()
				..()
				flick("end",src)
				spawn(6)del src
	barline
		icon='barline.dmi'
		layer=20
		pixel_x=-1
		pixel_y=-3
		r1/icon_state="1"
		r2/icon_state="2"
		r3/icon_state="3"
		stunted
			layer=21
			icon_state="stunted"
	float
		icon='float.dmi'
		name=""
		layer=10
		pixel_y=32
		pk/icon_state="pk"
		afkcheck
			layer=80
			pixel_y=0
			icon_state="afkcheck"
	GM
		icon='GMtitle.dmi'
		pixel_y=32
		layer=50
		Host/icon_state="Host"
		GM/icon_state="GM"
		Mod/icon_state="Mod"
		Owner/icon_state="Owner"
		Dev/icon_state = "Dev"
		Devp/icon_state = "Devp"
		GMp/icon_state="GMp"
		Modp/icon_state="Modp"
		Ownerp/icon_state="Ownerp"
		PK/icon_state="PK"
		rainbowpoop/icon_state="rainbowpoop"
		Kage/icon_state="Kage"
		bounty
			pixel_y=4
			icon_state="bounty"
		Academy_Student
			pixel_y=0
			icon_state="Academy Student"
	himage
		density=0
	snakeclone
		layer=3
		density=1
		New()
			..()
			spawn(150)del src
		Del()
			new/obj/smoke(loc)
			for(var/mob/player/M in range(10))M.soundeff(pick('puff.wav','puff2.wav','puff3.wav','puff4.wav','puff5.wav'),25,1)
			..()
	crowclone
		layer=3
		density=1
		New()
			..()
			spawn(22)del src
		Del()
			new/obj/randraven(loc)
			new/obj/randraven(loc)
			new/obj/randraven(loc)
			new/obj/randraven(loc)
			new/obj/randraven2(loc)
			new/obj/randraven2(loc)
			new/obj/randraven2(loc)
			new/obj/randraven2(loc)
			new/obj/randraven3(loc)
			new/obj/randraven3(loc)
			new/obj/randraven3(loc)
			new/obj/randraven3(loc)
			..()

	skillshadow
		layer=5
		icon='darken.dmi'
	lightningspread
		New()
			..()
			var/adtsd=0
			for(var/mob/M in range(4))
				if(M:key!="Chihirodori"||M:key!="Berlin2222")
					M:snared(20,20)
			while(adtsd<12)
				adtsd++
				new/obj/lightningbolt(loc)
				new/obj/lightningbolt(loc)
				new/obj/lightningbolt(loc)
				sleep(1)
			del src
	lightningbolt
		icon='lightningtrail.dmi'
		New()
			..()
			spawn(rand(5,20))del src
			walk_towards(src,locate(x+rand(-16,16),y+rand(-16,16),z))
		Bump(mob/A)
			if(ismob(A))
				if(A.key=="Chihirodori"||A.key=="Berlin2222")
					del src
					return
				else A.tempfreeze(25)
			del src
	randraven
		icon='raven.dmi'
		density=0
		layer=50
		New()
			..()
			spawn(rand(3,15))del src
			walk_towards(src,locate(x+rand(-16,16),y+rand(-16,16),z))
	randraven3
		icon='raven.dmi'
		density=0
		layer=50
		pixel_y=8
		New()
			..()
			spawn(rand(3,15))del src
			walk_towards(src,locate(x+rand(-16,16),y+rand(-16,16),z))
	randraven2
		icon='raven.dmi'
		density=0
		layer=50
		pixel_y=-8
		New()
			..()
			spawn(rand(3,15))del src
			walk_towards(src,locate(x+rand(-16,16),y+rand(-16,16),z))
	image
		name="Afterimage"
		New()spawn(2)del src
	cloakshadow
		icon='cloakingstep.dmi'
		name="Afterimage"
		New()spawn(3)del src
	runshadow
		icon='sneakrun.dmi'
		name="Sneak"
		layer=8
		New()
			..()
			icon_state=pick("1","2","3","4","5","6","7")
			spawn(3)del src
	burybegin
		icon='sandwavebury.dmi'
		layer=40
	bonedrill
		icon='danceclematis.dmi'
		icon_state="spear"
		layer=20
	buryend
		icon='sandwavebury.dmi'
		icon_state="down"
		layer=3
		New()spawn(25)del src
	kimage
		name="Afterimage"
		icon_state="image"
		New()spawn(2)del src
	windshield
		layer=40
		icon='windshield.dmi'
	scalpel
		layer=16
		icon='scalpel.dmi'
	genesis
		layer=MOB_LAYER+1
		icon='genesis.dmi'
	shadowsummon
		name=""
		layer=80
		New()
			flick('shadowsummon.dmi',src)
			spawn(8)del src
	shadowsummontop
		name=""
		icon='shadowsummon.dmi'
		icon_state="blank"
		layer=80
		pixel_y=32
		New()
			flick("top",src)
			spawn(8)del src

	windswordexp
		name=""
		layer=80
		New()
			flick('windsword.dmi',src)
			spawn(8)del src
	sandfist
		name="Attack"
		layer=30
		New()
			flick('sandfist.dmi',src)
			spawn(8)del src
	ghostevil
		name="Attack"
		layer=30
		New()
			flick('ghostevil.dmi',src)
			spawn(8)del src
	windswordexptop
		name=""
		icon='windsword.dmi'
		icon_state="blank"
		layer=80
		pixel_y=32
		New()
			flick("top",src)
			spawn(8)del src
	rasengan
		icon='rasengan.dmi'
		layer=10
	mangekyousharingan
		icon='mangekyousharingan.dmi'
		layer=35
		pixel_y=26
		t1/icon_state="1"
		t2/icon_state="2"
		t3/icon_state="3"
		t4/icon_state="4"
	chidori
		icon='chidori.dmi'
		layer=10
	chakratarget
		layer=80
		density=0
		rundelay=0
		New()
			spawn(42)del src
	neckbind
		icon='neckbind.dmi'
		layer=50
	waterfallstep
		icon='waterfallstep.dmi'
		layer=55
	wirebind
		icon='wirebind.dmi'
		layer=50
		New()spawn(60)del src
	rasenclone1
		name="Shadow Clone"
		icon_state="jutsu"
		layer=3
		pixel_x=-17
		pixel_y=-5
		dir=EAST
		New()new/obj/smoke(loc)
		Del()
			new/obj/smoke(loc)
			..()
	rasenclone2
		name="Shadow Clone"
		icon_state="jutsu"
		layer=3
		pixel_x=7
		pixel_y=-5
		dir=WEST
		New()new/obj/smoke(loc)
		Del()
			new/obj/smoke(loc)
			..()
	sandbarrier
		name="Sand Shield"
		icon='sandshellf.dmi'
		icon_state=""
		layer=25
		pixel_y=-32
		pixel_x=-32
		New()flick("begin",src)
		Del()
			flick("end",src)
			sleep(4)
			..()

	deadbody
		name="Dead Body"
		layer=4
		icon_state="dead"
		var/B1
		var/B2
		New()
			..()
			B1=new/obj/bars/healthbar(loc)
			B1:icon_state="0"
			B2=new/obj/bars/chakrabar(loc)
			B2:icon_state="0"
			spawn(900)
				del src
		Del()
			if(B1)del B1
			if(B2)del B2
			..()
	deadbodychaless
		name="Dead Body"
		layer=4
		icon_state="dead"
		New()
			..()
			var/B1=new/obj/bars/healthbar(loc)
			B1:icon_state="0"
			spawn(900)
				del B1
				del src
	chakraball
		icon='chakrac.dmi'
		layer=20
		New()
			..()
			loop
				spawn(140)
					if(!owner)del src
					goto loop
	cursechakra
		icon='chakracurse.dmi'
		layer=40
	cursechakram
		icon='chakracursem.dmi'
		layer=40
	mag/icon='maghigh.dmi'
	bind/icon='bind.dmi'
	buff/icon='buff.dmi'
	poisonov
		icon='poisonbar.dmi'
		pixel_y=-8
		z1/icon_state="1"
		z2/icon_state="2"
		z3/icon_state="3"
		z4/icon_state="4"
		z5/icon_state="5"
	disableov
		icon='disablebar.dmi'
		pixel_y=-8
		z1/icon_state="1"
		z2/icon_state="2"
		z3/icon_state="3"
		z4/icon_state="4"
		z5/icon_state="5"
		z6/icon_state="6"
		z7/icon_state="7"
		z8/icon_state="8"
		z9/icon_state="9"
		z10/icon_state="10"
	cursemarks
		icon='curseseal.dmi'
		layer=MOB_LAYER+1
	chakraarrow
		layer=80
		icon='template.dmi'
		New()
			..()
			loop
				spawn(140)
					if(!owner)return
					goto loop
	crater
		name="Crater"
		icon='crater.dmi'
		pixel_y=-4
		layer=2
		New()spawn(900)del src
	bigcrater
		name="Crater"
		icon='craterbig.dmi'
		pixel_y=-12
		pixel_x=-20
		layer=2
		New()spawn(900)del src
	smoke
		layer=30
		name="Smoke"
		New()
			flick('smoke.dmi',src)
			spawn(6)del src
	say
		layer=30
		name="say"
		New()
			flick('say.dmi',src)
			spawn(6)del src
	willowslash
		layer=30
		name="Slash"
		icon='dancewillow.dmi'
		New()
			icon_state=pick("1","2","3","4")
			spawn(4)del src
	pines
		layer=30
		name=""
		icon='dancepine.dmi'
		New()spawn(25)del src
	dancecamellia
		layer=30
		name=""
		icon='dancecamellia.dmi'
		New()spawn(70)del src
	sandup
		layer=30
		name="Sand Clone"
		New()
			flick('sandup.dmi',src)
			spawn(6)del src
	sandupguard
		layer=30
		name="Sand Guard"
		New()
			flick('sandupguard.dmi',src)
			spawn(14)del src
	sanddown
		layer=30
		name="Sand Clone"
		New()
			flick('sandclone.dmi',src)
			spawn(6)del src
	waterup
		layer=30
		icon='waterclone.dmi'
		New()
			flick("begin",src)
			spawn(6)del src
	waterdown
		layer=30
		icon='waterclone.dmi'
		New()
			flick("end",src)
			spawn(6)del src
	venom
		icon='venom.dmi'
	cloakingstart
		layer=40
		name=""
		New()
			flick('cloakingstart.dmi',src)
			spawn(34)del src
	cloakingend
		layer=40
		name=""
		New()
			flick('cloakingend.dmi',src)
			spawn(14)del src
	smokebomb
		layer=50
		name="Smoke"
		density=0
		icon='smokebomb.dmi'
		New()
			spawn(rand(20,50))del src
			loop
				step(src,rand(1,10))
				spawn(rand(2,6))goto loop
		Bump(M)
			..()
			if(ismob(M))loc=M:loc
	eyeac
		layer=20
		name="Doujutsu"
		New()
			flick('eyechange.dmi',src)
			spawn(6)del src

	shadowpunch
		layer=50
		name="Punch"
		pixel_y=-4
		New()
			flick('shadowpunch.dmi',src)
			spawn(14)del src
	disruption
		layer=50
		name="Disruption"
		New()
			flick('disruption.dmi',src)
			spawn(14)del src
	heart
		layer=5
		density=1
		name=""
		New()
			flick('sexyhit.dmi',src)
			spawn(6)del src
	tele
		layer=80
		density=0
		name=""
		icon='tele.dmi'
		New()
			flick("tele",src)
			spawn(6)del src
	icetele
		layer=80
		name=""
		New()
			flick('icetele.dmi',src)
			spawn(12)del src
	log
		layer=5
		density=1
		name="Substitution"
		New()
			flick('log.dmi',src)
			spawn(22)del src
	deflect
		layer=50
		name="Deflection"
		New()
			flick('deflect.dmi',src)
			spawn(22)del src
	heal
		layer=50
		name="heal"
		New()
			flick('heal.dmi',src)
			spawn(22)del src
	hit
		layer=50
		icon='hiteff.dmi'
		name="Hit"
		New()
			..()
			spawn(14)del src
			flick("hit1",src)
	hit2
		layer=50
		icon='hiteff.dmi'
		name="Hit"
		New()
			..()
			spawn(14)del src
			flick("hit2",src)
	bleed
		layer=50
		icon='hit.dmi'
		name="bleed"
		New()
			..()
			spawn(14)del src
			flick("bleed",src)
	heal
		layer=50
		icon='hit.dmi'
		name="heal"
		New()
			..()
			spawn(20)del src
			flick("heal",src)
	invinc
		layer=50
		icon='hit.dmi'
		name="invinc"
		New()
			..()
			spawn(20)del src
			flick("invinc",src)
	armor
		layer=50
		icon='hit.dmi'
		name="Armor"
		New()
			..()
			spawn(14)del src
			flick("armor",src)
	evade
		layer=50
		icon='hit.dmi'
		name="Evade"
		New()
			flick("evade",src)
			spawn(14)del src
	chit
		layer=50
		name="Chakra Hit"
		icon='hit.dmi'
		New()
			flick("chakra",src)
			spawn(14)del src
	crithit
		layer=50
		name="Critical Hit"
		icon='hiteff.dmi'
		New()
			flick("crit1",src)
			spawn(14)del src
	crithit2
		layer=50
		name="Critical Hit"
		icon='hiteff.dmi'
		New()
			flick("crit2",src)
			spawn(14)del src
	crithit3
		layer=50
		name="Critical Hit"
		icon='hiteff.dmi'
		New()
			flick("crit3",src)
			spawn(14)del src
	gustreaper
		layer=50
		name="Gust Reaper"
		icon='hit.dmi'
		New()
			flick("gustreaper",src)
			spawn(14)del src
	buildup
		layer=50
		name="Buildup"
		icon='hit.dmi'
		New()
			flick("buildup",src)
			spawn(14)del src
	stun
		layer=50
		name="Stun"
		icon='hit.dmi'
		New()
			flick("stun",src)
			spawn(14)del src
	demonic
		layer=50
		icon='effect.dmi'
		New()
			flick("demonic",src)
			spawn(24)del src
	slowed
		layer=50
		name="Slowed"
		icon='hit.dmi'
		New()
			flick("slowed",src)
			spawn(20)del src
	phoenix
		layer=80
		icon='effect.dmi'
		name="Flames"
		New()
			flick("phoenix",src)
			spawn(14)del src
	nervous
		icon='effect.dmi'
		layer=50
		New()
			flick("nervous",src)
			spawn(14)del src
	chakratransfer
		layer=80
		icon='effect.dmi'
		New()
			flick("chakratransfer",src)
			spawn(14)del src
	golddust
		layer=80
		icon='effect.dmi'
		name=""
		New()
			flick("goldsand",src)
			spawn(8)del src
	flashstep
		layer=80
		icon='effect.dmi'
		New()
			flick("flashstep",src)
			spawn(7)del src
	phoenix2
		layer=80
		icon='effect.dmi'
		name="Flames"
		New()
			flick("phoenix2",src)
			spawn(14)del src
	sshuriken
		layer=50
		icon='effect.dmi'
		name=""
		New()
			flick("sandss",src)
			spawn(14)del src
	gilgameshtrail
		layer=50
		icon='effect.dmi'
		name=""
		New()
			flick("gilgamesh",src)
			spawn(14)del src
	armorup
		layer=50
		icon='effect.dmi'
		name=""
		New()
			flick("armorup",src)
			spawn(14)del src
	armordown
		layer=50
		icon='effect.dmi'
		name=""
		New()
			flick("armordown",src)
			spawn(14)del src
	armorupb
		layer=50
		icon='effectb.dmi'
		name=""
		New()
			flick("armorup",src)
			spawn(14)del src
	armordownb
		layer=50
		icon='effectb.dmi'
		name=""
		New()
			flick("armordown",src)
			spawn(14)del src
	shed
		layer=50
		icon='effect.dmi'
		name=""
		New()
			flick("shed",src)
			spawn(14)del src
	bite
		layer=50
		icon='effect.dmi'
		name=""
		New()
			flick("bite",src)
			spawn(14)del src
	curse
		layer=50
		icon='effect.dmi'
		name=""
		New()
			flick("curse",src)
			spawn(14)del src
	elet
		layer=80
		icon='effect.dmi'
		name="Elemental"
		New()
			var/t=pick("ele1","ele2","ele3","ele4")
			flick(t,src)
			spawn(14)del src
	waterstep
		layer=MOB_LAYER-1
		icon='effect.dmi'
		name=""
		pixel_y=-8
		New()
			..()
			spawn(1)for(var/turf/Waterfall/T in oview(1))del src
			flick("waterstep",src)
			spawn(14)del src
	hideanim
		layer=80
		icon='effect.dmi'
		name="hide"
		New()
			flick("hide",src)
			spawn(80)del src
	charge10
		layer=80
		icon='effect.dmi'
		name="charge"
		New()
			flick("10charge",src)
			spawn(210)del src
	charge15
		layer=80
		icon='effect.dmi'
		name="charge"
		New()
			flick("15charge",src)
			spawn(360)del src
	charge20
		layer=80
		icon='effect.dmi'
		name="charge"
		New()
			flick("20charge",src)
			spawn(410)del src
	charge30
		layer=80
		icon='effect.dmi'
		name="charge"
		New()
			flick("30charge",src)
			spawn(510)del src
	tankanim
		layer=80
		icon='effect.dmi'
		name="tank"
		New()
			flick("tank",src)
			spawn(350)del src
	derpa
		layer=80
		icon='effect.dmi'
		name="derpa"
		New()
			flick("derpa",src)
			spawn(66)del src
	kunaiash
		layer=80
		icon='effect.dmi'
		name=""
		New()
			flick("kunai",src)
			spawn(14)del src
	bulletash
		layer=80
		icon='effect.dmi'
		name=""
		New()
			flick("bullet",src)
			spawn(14)del src
	senbonash
		layer=80
		icon='effect.dmi'
		name=""
		New()
			flick("senbon",src)
			spawn(14)del src
	sandash
		layer=80
		icon='effect.dmi'
		name=""
		New()
			flick("sands",src)
			spawn(14)del src
	expgain
		layer=80
		icon='effect.dmi'
		name="Expgain"
		New()
			flick("exp",src)
			spawn(14)del src
	airboom
		layer=80
		icon='effect.dmi'
		name="Boom"
		New()
			flick("airboom",src)
			spawn(14)del src
	toxic
		layer=80
		icon='effect.dmi'
		name="toxic"
		New()
			flick("toxic",src)
			spawn(5)del src
	bloodlust
		layer=8
		icon='bloodlust.dmi'
	vengeance
		layer=18
		icon='vengeance.dmi'
	hatred
		layer=20
		pixel_y=8
		icon='hatred.dmi'
	winddebuff
		layer=8
		icon='winddebuff.dmi'
		t1/icon_state="1"
		t2/icon_state="2"
		t3/icon_state="3"
		t4/icon_state="4"
		t5/icon_state="5"
		t6/icon_state="6"
		t7/icon_state="7"
		t8/icon_state="8"
	windpressureexplosion
		layer=80
		name="Explosion"
		icon='effect.dmi'
		New()
			flick("pressureblast",src)
			spawn(14)del src
	statuspop
		icon='hit.dmi'
		layer=50
		disabled
		counterspin
		bloodlust
		cleave
		snapregen
		rapidpalms
		doubleblades
		bonegolem
		extremecondensing
		poison
		precisestriking
		internalbleeding
		normalstance
		New()
			flick("[name]",src)
			spawn(14)del src
obj/var/boner=0
obj/Trigram
	icon='64strikes.dmi'
	name=""
	layer=3
	pixel_x=-100
	pixel_y=-108
	New()
		..()
		spawn(420)del src
	onetwentyeight
		icon='128strikes.dmi'
		pixel_x=-130
		pixel_y=-140

mob/var/tmp/boned=0
obj/var
	powmin=0
	powmax=0
obj
	airblast
		rundelay=0
		density=1
		Bump(mob/A)
			..()
			if(ismob(A))
				owner.faceme(A)
				new/obj/airboom(A.loc)
				A.stepback(1,2)
				if(A)projectile(owner,A,round(owner.pow/3+rand(5,8)))
			if(istype(A,/turf/))del src
			if(istype(A,/obj/))loc=A.loc
	swpain
		rundelay=0
		density=1
		Bump(mob/A)
			..()
			if(ismob(A))
				if(A.client)
					var/obj/statuseffect/t=new/obj/statuseffect/shadowwordpain
					A.debuffcount(100)
					t.screen_loc="[7+A.debuffa],16"
					A.client.screen+=t
					A.seffect(100,t)
				A.swpain()
				del src
			if(istype(A,/turf/))del src
			if(istype(A,/obj/))loc=A.loc
	zankuuha
		icon = 'splicingsoundwave.dmi'
		rundelay=0
		density=1
		name="Splicing Sound Wave"
		animate_movement=0
		New()spawn(34)del src
		Bump(mob/A)
			..()
			if(ismob(A))
				A.zankuuhaed()
				projectilep(owner,A,owner.pow/1.7+rand(powmin,powmax))
			if(istype(A,/turf/))loc=A.loc
			if(istype(A,/obj/))loc=A.loc
		Move()
			var/K=new/obj/zankuuhat(loc)
			K:dir=dir
			..()
	zankuuhat
		icon = 'splicingsoundwave.dmi'
		icon_state="trail"
		layer=15
		New()spawn(34)del src
	wire
		icon = 'wireshuriken.dmi'
		rundelay=0
		density=1
		name="Triple Windmill Blade"
		animate_movement=0
		New()spawn(200)del src
		Move()
			..()
			buildup++
		Bump(mob/A)
			..()
			if(ismob(A))
				if(!A.freeze&&!A.busy&&owner&&buildup>=2)
					loc=locate(0,0,0)
					new/obj/wirebind(A.loc)
					var/g=0
					if(owner.level>=55)g=10
					A.wired(10+g+owner.tier11*10)
				else
					if(owner)projectile(owner,A,owner.pow/1.5)
					else del src
			if(istype(A,/turf/))del src
			if(istype(A,/obj/))del src
obj
	mountainc
		layer=15
		icon='mountainc.dmi'
		rundelay=0
		name="Mountain Crusher"
		New()spawn(8)del src
		Move()
			var/K=new/obj/mountainc(loc)
			K:dir=dir
			K:owner=owner
			..()
obj
	kaiten
		name="Rotation"
		icon='kaiten.dmi'
		layer=40
		icon_state="spin"
		pixel_x=-32
		New()
			flick("begin",src)
			spawn(1000)del src
		Del()
			icon_state=null
			flick("end",src)
			sleep(5)
			..()
	rashoumon
		name="Rashoumon"
		icon='rashoumon.dmi'
		layer=25
		pixel_y=-10
		icon_state="main"
		New()
			overlays+=/obj/rashou1/o1
			overlays+=/obj/rashou1/o2
			overlays+=/obj/rashou1/o3
			overlays+=/obj/rashou1/o4
			overlays+=/obj/rashou1/o5
			overlays+=/obj/rashou1/o6
			overlays+=/obj/rashou1/o7
			overlays+=/obj/rashou1/o8
			spawn(140)if(src)del src
	rashou1
		icon='rashoumon.dmi'
		layer=25

		o1
			icon_state="1"
			pixel_x=-32
			pixel_y=64
		o2
			icon_state="2"
			pixel_y=64
		o3
			icon_state="3"
			pixel_x=32
			pixel_y=64
		o4
			icon_state="4"
			pixel_x=-32
			pixel_y=32
		o5
			icon_state="5"
			pixel_y=32
		o6
			icon_state="6"
			pixel_x=32
			pixel_y=32
		o7
			icon_state="7"
			pixel_x=-32
		o8
			icon_state="9"
			pixel_x=32
