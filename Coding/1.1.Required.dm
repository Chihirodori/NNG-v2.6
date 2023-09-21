#define DEBUG
#define SAVEFILE_PATH(i) "Saves/[copytext(ckey,1,2)]/[ckey]/[i].sav"
#define MAX_SAVE_FILES 5
//world/map_format = SIDE_MAP
client
	control_freak=CONTROL_FREAK_SKIN
	//preload_rsc=0
	script = "<STYLE>BODY {font: 12pt 'Calibri';}</STYLE>"
	New()
		..()
var/sanding=1
var/testserver=0

world
	//From Dante: You have my permission to host your server on my hub. It is already established. Please name your server something other than "Naruto: Next Generation".
	mob=/mob/charactermenu
	hub = "Sstrunks9999.NarutoNextGeneration" //if you want this hosted on the NNG hub, don't touch this
	status = "" //CONFIG: put the name of your server right here
	hub_password= "NNG2020" //if you want this hosted on the NNG hub, don't touch this
	name = "" //CONFIG: put the name of your server right here as well
	tick_lag=1
	loop_checks=0
var/log_xml = TRUE

world
	New()
		log = file("error.txt")
		SpeechBubble.font = new /Font/TrebuchetMS()
		..()
		//record("Server_Startup",notes="---------------------------------------------------------------------------------")
		spawn(14)
			world<<"<center>_______________"
			spawn()afkchecker()
			world<<"<center>afkcheck() loaded"
			spawn()geninexam()
			world<<"<center>geninexam() loaded"
			spawn()chunincountdown()
			world<<"<center>chunincountdown() loaded"
			spawn()sandstormz()
			world<<"<center>sandstormz() loaded"
			spawn()afkcheck()
			world<<"<center>afkcheck() loaded"
			spawn()autosave()
			akatload()
			world<<"<center>autosave() loaded"
			banlistload()
			world<<"<center>banlistload() loaded"
			subscriberload()
			world<<"<center>subscriberload() loaded"
			gmlistload()
			world<<"<center>gmlistload() loaded"
			repload()
			world<<"<center>repload() loaded"
			territoryload()
			world<<"<center>territoryload() loaded"
			if(leafpriority=="Currently Changing")leafpriority="None"
			if(sandpriority=="Currently Changing")sandpriority="None"
			if(soundpriority=="Currently Changing")soundpriority="None"
			spawn()savestuff()
			world<<"<center>savestuff() loaded"
			spawn()scoreboard()
			world<<"<center>scoreboard() loaded"
			var/T=new/obj/items/Secret_Scroll_I
			var/list/K=list()
			for(var/obj/Spawn_Point/scroll1spawn/M in world)K+=M
			var/S=pick(K)
			T:loc=S:loc
			world<<"<center>secret scrolls placed"
			world<<"<center>_______________"
			world<<"<center>game booted correctly"
			secrettimer()
		//spawn(1)if(!bldlin)del world
	Del()
		for(var/mob/M in world)
			if(M.client)del M.client
			del M
		record("Server_Shutdown",notes="---------------------------------------------------------------------------------")
		..()
	proc
		sandstormz()
			set background=1
			sleep(3000)
			sanding=0
			sleep(3000)
			sanding=1
			sandstormz()
		autosave()
			set background=1
			sleep(1800)
			for(var/mob/player/M in world)
				if(M.client)
					M.client.SaveMob()
			autosave()
		rebootready()spawn(7)world.Reboot()
		scoreboard()
			set background=1
			sleep(18000)
			for(var/mob/player/M in world)if(M.client)
				if(M.GM)continue
				var/scoreset[0]
				scoreset["Kills"]=M.kills
				scoreset["Senryo"]=realnum(M.senryo)
				scoreset["Influence Contribution"]=realnum(M.repcontribute)
				scoreset["Reputation"]=realnum(M.reputation)
				scoreset["Banners Captured"]=realnum(M.flagcapture	)
				scoreset["A Ranks"]=realnum(M.mranka)
				scoreset["B Ranks"]=realnum(M.mrankb)
				scoreset["C Ranks"]=realnum(M.mrankc)
				scoreset["D Ranks"]=realnum(M.mrankd)
				scoreset["Bounty Collected"]=realnum(M.maxbounty)
				scoreset=list2params(scoreset)
				spawn()world.SetScores(M.key,scoreset)
			scoreboard()
		secrettimer()
			set background=1
			sleep(18000)
			secrettimer++
			secrettimer()
var
	passwordopen=0
	globalcap=120
	ooc=1
	idcount=0
	secrettimer=0
mob/var
	subscriber=0
	level=1
	Sta=1
	Hsl=1
	Tai=1
	Nin=1
	Str=1
	Int=1
	Spd=1
	hp=350
	maxhp=350
	cha=100
	maxcha=80
	basehp=350
	basecha=80
	energy=100
	maxenergy=100
	regenhp=1
	regene=7
	regencha=1
	atk=100
	atkstr=100
	def=0
	con=0
	handseals=1.5
	apow=30
	projspeed=1
	accuracy=85
	dodge=10
	attackdelay=70
	cdapow=110
	hsp=0
	pow=30
	proficiency=0
	cdpow=110
	trainingspeed=100
	ryomulti=60
	genlevel=0
	genresist=0
	rundelay=4
	flagcapture=0
	ninprojspeed=1
	weights=0
	imperialpierce=0
	exp=0
	relentless=0
	savedrelent=0
	gmhosp=0
	inzone=0
	staexp=0
	intexp=0
	hslexp=0
	taiexp=0
	apowexp=0
	ninexp=0
	spdexp=0
	staexpm=20
	intexpm=20
	hslexpm=20
	taiexpm=20
	apowexpm=20
	ninexpm=20
	spdexpm=20
	stundelay=0
	critrate=2
	critdef=0
	//karma=100
	//statsend
	secretlevel=0
	secretpower=0
	goldscroll=0
	blockspar=0
	sparpartner=null
	spardelay=0
	rank="Academy Student"
	clan="None"
	village="None"
	status="Newbie"
	sandarmor=0
	tmp/tmpclan=""
	tmp/tmpvillage=""
	tmp/tmpstatus="Newbie"
	tmp/tmprank=""
	tmp/attacked=0
	tmp/cantmission=0
	tmp/meditating=0
	tmp/meditdir=null
	bountytoggle=1
	tmp/intense=0
	tmp/collision=0
	hstyle=/obj/headband
	ambush = 0
	jailtime=0
	hosptime=0
	mission=null
	missiond=null
	maxbounty=0
	bountyget=0
	bountyannounce=0
	mranks=0
	named=0
	mranka=0
	mrankb=0
	sclonelearned=0
	mrankc=0
	mrankd=0
	tmp/mag=0
	smokeamount=0
	fireamount=0
	graffiti=0
	tmp/fast=0
	senryo=0
	kills=0
	deaths=0
	bountyhead=0
	bountyby=null
	bountytimes=0
	bountyhosp=0
	bountykills=0
	bountycant=0
	repcontribute=0
	wdmg=0
	dead=0
	npc=0
	GM=0
	disruption=0
	targethyug=null
	pktoggle=0
	tmp/cloaking=0
	tmp/cdelay1=0
	tmp/cdelay2=0
	tmp/cdelay3=0
	tmp/cdelay4=0
	tmp/cdelay5=0
	tmp/cdelay6=0
	tmp/vdelay1=0
	tmp/vdelay2=0
	tmp/vdelay3=0
	tmp/vdelay4=0
	tmp/rasengandelay=0
	gotcust=0
	tmp/sclonedelay=0
	tmp/busy=null
	tmp/flicked=0
	tmp/substitution=0
	tmp/attacking=0
	tmp/shadow=0
	tmp/imitation=null
	tmp/imitated=null
	tmp/sewing=0
	tmp/paralysed=0
	tmp/freeze=0
	tmp/shadowdir
	tmp/teleport=0
	tmp/seals=0
	tmp/hyugdelay=0
	ingenin=0
	inchunin=0
	tmp/sealpass=0
	tmp/whod=0
	tmp/afkcheck=0
	tmp/disabledelay=0
	weapon
	weaponsh
	pant2
	shirt2
	armor
	initialized=0
	tmp/rebirthing=0
	headgear
	headband
	cloak
	shirt
	track=null
	missioned=0
	amissioned=0
	updated=0
	mask
	pant
	shoes
	gloves
	ancestorboost=0
	shrinecd=0
	kunaipouch
	belt
	fullbody
	special
	hair_red=0
	hair_green=0
	winddebuff=0
	hair_blue=0
	oldtrack
	onwater=0
	swim=0
	blind=0
	tmp/resting=0
	tmp/talknum=0
	tmp/moving=0
	tmp/clonedelay=0
	tmp/clonedelay2=0
	tmp/clone=0
	muted=0
	tmp/caught=0
	tmp/caughtby
	tmp/stun=0
	tmp/henge=0
	tmp/dous=0
	sharingan=0
	byakugan=0
	hair="Bald"
	eye="Brown"
	icon_name='base.dmi'
	savedloc
	list/savedoverlays
	savedname
	tmp/cloned=0
	tmp/shadowdelay=0
	tmp/sandshield=0
	amissionreq=20
	equipping=null
	screener=new/list()
	slot1
	slot2
	slot3
	slot4
	slot5
	slot6
	slot7
	slot8
	slot9
	slot10
	slot11
	slot12
	slot13
	slot14
	slot15
	slot16
	rebirthed=0
	onsand=0
	tmp/karmaloss=0
	kstoggle="Shuriken"
	var/shield=0
	var/pines=0
	smite=0
	clouding=0
	clouded=0
	pkkills=0
	reputation=0
	repdelay=180
	rchannel=null
	tapping=0
	tmp/testing=0
	variable
	variable2
	variable3
	saidstuff=0
	tmp/vilc=0
	tmp/pill=""
	tmp/subinvis=0
	tmp/illusion=0
	jutsutoggle=0
	perk1=null
	perk2=null
	perk3=null
	perk4=null
	perk5=null
	perk6=null
	perk7=null
	wpalm=0
	haircutting=0
	tmp/tmphair=null
	powered=0
	id=0
	aff = 0
mob/var/tmp
	aggro=null
	restdef=0
	aggroed=0
	target=null
	criticalroll=0
	disabled=0
	silenced=0
	disruptiondelay=0
	debuffa=0
	snared=0
	bleeding=0
	debuff1=0
	debuff2=0
	debuff3=0
	debuff4=0
	superholy=0
	wpalming=0
	lusted=0
	stance="None"
	marked=0
	mark=null
	marking=0
	nervous=0
	cansnake=1
	windshield=0
mob/var
	skillpoint=0
	skilltotal=0
	mangtype=0
	cleartime=0
	clearcap=100000000
	tier11=0
	tier12=0
	tier13=0
	tier21=0
	tier22=0
	tier23=0
	tier31=0
	tier32=0
	tier33=0
	tier41=0
	tier42=0
	tier43=0
	tier51=0
	tier52=0
	tier53=0
	tier61=0
	tier62=0
	tier63=0
	tier11max=5
	tier12max=5
	tier13max=5
	tier21max=5
	tier22max=5
	tier23max=5
	tier31max=5
	tier32max=5
	tier33max=5
	tier41max=5
	tier42max=5
	tier43max=5
	tier51max=5
	tier52max=5
	tier53max=5
	tier61max=5
	tier62max=5
	tier63max=5
	rapidkilling=0
	frostmark=0
	preserve=0
	critcon=0
	pinked=0
	kusan=0
	hyuugableed=0
	bleedtotal=0
mob/var
	tmp/mob/cloneowner=null
	tmp/mob/edoowner=null
obj/var
	tmp/mob/owner=null
	tmp/freeze=0
	deflectable=0
	equipped=0
	//tmp/moving=0
	pdamage=0
	destro=0
	buildup=0
	rundelay=2
	deletable=0
	newy=0
	armor
	newshur=0
	shadowstep=0
	isweap=0
	turns=0
	shadowturns=0
	sewingturns=0
	level=0
	projint=0

client/var
	tracked=0
	seconds=0
	minutes=0
	hours=0
	days=0
	weeks=0
	heartofgold
	NNGcredits=0
	customtext=0
//atom/movable/var/tmp/owner=null
var
	tmp/worldpeace=0
	tmp/geninexam=0
	tmp/chuninexam=0
	tmp/privacy=0
	tmp/redbutton=null
	leafrep=100
	sandrep=100
	soundrep=100
	leafrec=0
	worldexprate=300
	sandrec=0
	soundrec=0
	akatpass="none"
	goldenage="none"
	favor="none"
	leafpriority="None"
	soundpriority="None"
	sandpriority="None"
	leafunder=1
	sandunder=1
	soundunder=1
	akatpriority="None"
	akatloyalty=null
	kyuubimode=0

mob/Bump(M)
	if(istype(M,/obj/Tumbleweed))
		loc=M:loc
		del M
	..()
obj/Bump(M)
	if(istype(M,/obj/smokebomb))loc=M:loc
	if(istype(M,/obj/Tumbleweed))
		loc=M:loc
		del M
	..()
proc
	repsave()
		var/savefile/F = new("Worldsaves/Reputation.sav")
		F["chunintime"] << chunintime
		F["leafrep"] << leafrep
		F["sandrep"] << sandrep
		F["soundrep"] << soundrep
		F["leafunder"] << leafunder
		F["sandunder"] << sandunder
		F["soundunder"] << soundunder
		F["akatpass"] << akatpass
		F["idcount"] << idcount
		F["secrettimer"] << secrettimer
		F["leafpriority"] << leafpriority
		F["soundpriority"] << soundpriority
		F["sandpriority"] << sandpriority
		F["akatpriority"] << akatpriority
	repload()
		if(fexists("Worldsaves/Reputation.sav"))
			var/savefile/load = new("Worldsaves/Reputation.sav")
			load["chunintime"] >> chunintime
			if(chunintime==null||chunintime<650)chunintime=650
			load["leafrep"] >> leafrep
			load["sandrep"] >> sandrep
			load["soundrep"] >> soundrep
			load["akatpass"] >> akatpass
			load["leafunder"] >> leafunder
			load["idcount"] >> idcount
			load["sandunder"] >> sandunder
			load["secrettimer"] >> secrettimer
			load["soundunder"] >> soundunder
			if(leafunder==null)leafunder=1
			if(sandunder==null)sandunder=1
			if(soundunder==null)soundunder=1
			load["leafpriority"] >> leafpriority
			load["soundpriority"] >> soundpriority
			load["sandpriority"] >> sandpriority
			load["akatpriority"] >> akatpriority
	territorysave()
		var/savefile/F = new("Worldsaves/territory.sav")
		F["flag1"] << f1:nationality
		F["flag1timer"] << f1:timerstat
		F["flag2"] << f2:nationality
		F["flag2timer"] << f2:timerstat
		F["flag3"] << f3:nationality
		F["flag3timer"] << f3:timerstat
		F["flag4"] << f4:nationality
		F["flag4timer"] << f4:timerstat
		F["flag5"] << f5:nationality
		F["flag5timer"] << f5:timerstat
		F["flag6"] << f6:nationality
		F["flag6timer"] << f6:timerstat
		F["flag7"] << f7:nationality
		F["flag7timer"] << f7:timerstat
		F["flag8"] << f8:nationality
		F["flag8timer"] << f8:timerstat
		F["flag9"] << f9:nationality
		F["flag9timer"] << f9:timerstat
		F["flag10"] << f10:nationality
		F["flag10timer"] << f10:timerstat
		F["flag11"] << f11:nationality
		F["flag11timer"] << f11:timerstat
		F["flag12"] << f12:nationality
		F["flag12timer"] << f12:timerstat
		F["flag13"] << f13:nationality
		F["flag13timer"] << f13:timerstat
		F["flag14"] << f14:nationality
		F["flag14timer"] << f14:timerstat
		F["flag15"] << f15:nationality
		F["flag15timer"] << f15:timerstat
		F["flag16"] << f16:nationality
		F["flag16timer"] << f16:timerstat
		F["flag17"] << f17:nationality
		F["flag17timer"] << f17:timerstat
		F["flag18"] << f18:nationality
		F["flag18timer"] << f18:timerstat
		F["flag19"] << f19:nationality
		F["flag19timer"] << f19:timerstat
		F["flag20"] << f20:nationality
		F["flag20timer"] << f20:timerstat
		F["leafter"] << leafter
		F["sandter"] << sandter
		F["soundter"] << soundter
		F["akatter"] << akatter
		F["leafban"]<< leafban
		F["sandban"] << sandban
		F["soundban"] << soundban
	territoryload()
		if(fexists("Worldsaves/territory.sav"))
			var/savefile/load = new("Worldsaves/territory.sav")
			load["flag1"] >> f1:nationality
			load["flag1timer"] >> f1:timerstat
			load["flag2"] >> f2:nationality
			load["flag2timer"] >> f2:timerstat
			load["flag3"] >> f3:nationality
			load["flag3timer"] >> f3:timerstat
			load["flag4"] >> f4:nationality
			load["flag4timer"] >> f4:timerstat
			load["flag5"] >> f5:nationality
			load["flag5timer"] >> f5:timerstat
			load["flag6"] >> f6:nationality
			load["flag6timer"] >> f6:timerstat
			load["flag7"] >> f7:nationality
			load["flag7timer"] >> f7:timerstat
			load["flag8"] >> f8:nationality
			load["flag8timer"] >> f8:timerstat
			load["flag9"] >> f9:nationality
			load["flag9timer"] >> f9:timerstat
			load["flag10"] >> f10:nationality
			load["flag10timer"] >> f10:timerstat
			load["flag11"] >> f11:nationality
			load["flag11timer"] >> f11:timerstat
			load["flag12"] >> f12:nationality
			load["flag12timer"] >> f12:timerstat
			load["flag13"] >> f13:nationality
			load["flag13timer"] >> f13:timerstat
			load["flag14"] >> f14:nationality
			load["flag14timer"] >> f14:timerstat
			load["flag15"] >> f15:nationality
			load["flag15timer"] >> f15:timerstat
			load["flag16"] >> f16:nationality
			load["flag16timer"] >> f16:timerstat
			load["flag17"] >> f17:nationality
			load["flag17timer"] >> f17:timerstat
			load["flag18"] >> f18:nationality
			load["flag18timer"] >> f18:timerstat
			load["flag19"] >> f19:nationality
			load["flag19timer"] >> f19:timerstat
			load["flag20"] >> f20:nationality
			load["flag20timer"] >> f20:timerstat
			load["leafter"] >> leafter
			load["sandter"] >> sandter
			load["soundter"] >> soundter
			load["leafban"] >> leafban
			load["sandban"] >> sandban
			load["soundban"] >> soundban
			load["akatter"] >> akatter
mob
	proc
		idproc()
			id=idcount
			idcount++
/*If you somehow got this source from someone, please don't leak it. I have worked quite hard on it by my own over months.

- Berlin*/