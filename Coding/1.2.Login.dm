
client/proc
	SaveMob()
		if(!src||!mob)return
		if(!mob.initialized||!mob.named||mob.rebirthing||!istype(mob,/mob/player))return
		var/savefile/D = new(SAVEFILE_PATH("timer"))
		D["seconds"]<<seconds
		D["tracked"]<<tracked
		D["hours"]<<hours
		D["minutes"]<<minutes
		D["days"]<<days
		D["weeks"]<<weeks
		D["heartofgold"]<<heartofgold
		D["uchiha"]<<uchiha
		D["nara"]<<nara
		D["hyuuga"]<<hyuuga
		D["sand"]<<sand
		D["iron"]<<iron
		D["wind"]<<wind
		D["snake"]<<snake
		D["spider"]<<spider
		D["kaguya"]<<kaguya
		D["tai"]<<tai
		D["copy"]<<copy
		D["yuki"]<<yuki
		D["senju"]<<senju
		D["medic"]<<medic
		D["clay"]<<clay
		D["NNGcredits"]<<NNGcredits
		D["customtext"]<<customtext
		var/savefile/F = new(SAVEFILE_PATH(mob.current_slot))
		if(mob)
			var/mob/x=mob
			var/savex=x.x
			var/savey=x.y
			var/savez=x.z
			//var/list/savedverbs=x.verbs
			var/savefile/Z = new(SAVEFILE_PATH("[x.current_slot]o"))
			Z["copied1"]<<x.copied1
			Z["copied2"]<<x.copied2
			Z["copied3"]<<x.copied3
			Z["copied4"]<<x.copied4
			Z["copied5"]<<x.copied5
			Z["ovlay"]<<x.overlays
			Z["name"]<<x.savedname
			Z["rank"]<<x.rank
			Z["village"]<<x.village
			Z["level"]<<x.level
			Z["icon"]<<x.icon_name
			F["insquad"]<<x.insquad
			F["squadname"]<<x.squadname
			F["squadrank"]<<x.squadrank
			F["leadershipskill"]<<x.leadershipskill
			F["gmhosp"]<<x.gmhosp
			F["level"]<<x.level
			F["repdelay"]<<x.repdelay
			F["ancestorboost"]<<x.ancestorboost
			F["secretlevel"]<<x.secretlevel
			F["secretpower"]<<x.secretpower
			F["goldscroll"]<<x.goldscroll
			F["shrinecd"]<<x.shrinecd
			F["reputation"]<<x.reputation
			F["hp"]<<x.hp
			F["maxhp"]<<x.maxhp
			F["edol"]<<x.edol
			F["hostamount"]<<x.hostamount
			F["host1eff"]<<x.host1eff
			F["host2eff"]<<x.host2eff
			F["host3eff"]<<x.host3eff
			F["edokd"]<<x.edokd
			F["bountyannounce"]<<x.bountyannounce
			F["cha"]<<x.cha
			F["maxenergy"]<<x.maxenergy
			F["wpalm"]<<x.wpalm
			F["maxcha"]<<x.maxcha
			F["updated"]<<x.updated
			F["Sta"]<<x.Sta
			F["Hsl"]<<x.Hsl
			F["flagcapture"]<<x.flagcapture
			F["Nin"]<<x.Nin
			F["Str"]<<x.Str
			F["Int"]<<x.Int
			F["Tai"]<<x.Tai
			F["con"]<<x.con
			F["exp"]<<x.exp
			F["Spd"]<<x.Spd
			F["named"]<<x.named
			F["eye"]<<x.eye
			F["hstyle"]<<x.hstyle
			F["perk1"]<<x.perk1
			F["perk2"]<<x.perk2
			F["perk3"]<<x.perk3
			F["perk4"]<<x.perk4
			F["perk5"]<<x.perk5
			F["gotcust"]<<x.gotcust
			F["perk6"]<<x.perk6
			F["perk7"]<<x.perk7
			F["hudon"]<<x.hudon
			F["staexp"]<<x.staexp
			F["intexp"]<<x.intexp
			F["hslexp"]<<x.hslexp
			F["taiexp"]<<x.taiexp
			F["ninexp"]<<x.ninexp
			F["spdexp"]<<x.spdexp
			F["weights"]<<x.weights
			F["intexp"]<<x.intexp
			F["apowexp"]<<x.apowexp
			F["hslexpm"]<<x.hslexpm
			F["taiexpm"]<<x.taiexpm
			F["apowexpm"]<<x.apowexpm
			F["ninexpm"]<<x.ninexpm
			F["spdexpm"]<<x.spdexpm
			F["intexpm"]<<x.intexpm
			F["staexpm"]<<x.staexpm
			F["smokeamount"]<<x.smokeamount
			F["babysitted"]<<x.babysitted
			F["mission"]<<x.mission
			F["missiond"]<<x.missiond
			F["mranks"]<<x.mranks
			F["mranka"]<<x.mranka
			F["mrankb"]<<x.mrankb
			F["illusionl1"]<<x.illusionl1
			F["illusionl2"]<<x.illusionl2
			F["mrankc"]<<x.mrankc
			F["mrankd"]<<x.mrankd
			F["jutsutoggle"]<<x.jutsutoggle
			F["status"]<<x.status
			F["blind"]<<x.blind
			F["maxbounty"]<<x.maxbounty
			F["bountyget"]<<x.bountyget
			F["bountytoggle"]<<x.bountytoggle
			F["jailtime"]<<x.jailtime
			F["hosptime"]<<x.hosptime
			F["muted"]<<x.muted
			F["bountykills"]<<x.bountykills
			F["bountyhead"]<<x.bountyhead
			F["bountyby"]<<x.bountyby
			F["bountytimes"]<<x.bountytimes
			F["bountyhosp"]<<x.bountyhosp
			F["bountycant"]<<x.bountycant
			F["repcontribute"]<<x.repcontribute
			F["graffiti"]<<x.graffiti
			F["tapping"]<<x.tapping
			F["fireamount"]<<x.fireamount
			F["senryo"]<<x.senryo
			F["kills"]<<x.kills
			F["deaths"]<<x.deaths
			F["clan"]<<x.clan
			F["rank"]<<x.rank
			F["kusan"]<<x.kusan
			F["village"]<<x.village
			F["wdmg"]<<x.wdmg
			F["AP"]<<x.AP
			F["achievementon"]<<x.achievementon
			F["teabag"]<<x.teabag
			F["goldenagetrig"]<<x.goldenagetrig
			F["deerkill"]<<x.deerkill
			F["boarkill"]<<x.boarkill
			F["tourneypart"]<<x.tourneypart
			F["tourneywin"]<<x.tourneywin
			F["kagekill"]<<x.kagekill
			F["rep30"]<<x.rep30
			F["respecced"]<<x.respecced
			F["punchamount"]<<x.punchamount
			F["armor"]<<x.armor
			F["dead"]<<x.dead
			F["npc"]<<x.npc
			F["oldtrack"]<<x.oldtrack
			F["swim"]<<x.swim
			F["byakugan"]<<x.byakugan
			F["hair"]<<x.hair
			F["hair_red"]<<x.hair_red
			F["hair_blue"]<<x.hair_blue
			F["hair_green"]<<x.hair_green
			F["pktoggle"]<<x.pktoggle
			F["rankup"]<<x.rankup
			F["savedoverlays"]<<x.savedoverlays
			F["savedname"]<<x.savedname
			F["equipping"]<<x.equipping
			F["icon_name"]<<x.icon_name
			F["name"]<<x.name
			F["special"]<<x.special
			F["gloves"]<<x.gloves
			F["shoes"]<<x.shoes
			F["pant"]<<x.pant
			F["kunaipouch"]<<x.kunaipouch
			F["shirt"]<<x.shirt
			F["cloak"]<<x.cloak
			F["headgear"]<<x.headgear
			F["headband"]<<x.headband
			F["armor"]<<x.armor
			F["rebirthed"]<<x.rebirthed
			F["mask"]<<x.mask
			F["kstoggle"]<<x.kstoggle
			F["pant2"]<<x.pant2
			F["shirt2"]<<x.shirt2
			F["weapon"]<<x.weapon
			F["weaponsh"]<<x.weaponsh
			F["ryomissiongain"]<<x.ryomissiongain
			F["slot1"]<<x.slot1
			F["slot2"]<<x.slot2
			F["slot3"]<<x.slot3
			F["weedpick"]<<x.weedpick
			F["slot4"]<<x.slot4
			F["mangtype"]<<x.mangtype
			F["slot5"]<<x.slot5
			F["slot6"]<<x.slot6
			F["slot7"]<<x.slot7
			F["slot13"]<<x.slot13
			F["slot14"]<<x.slot14
			F["slot15"]<<x.slot15
			F["slot16"]<<x.slot16
			F["slot10"]<<x.slot10
			F["slot11"]<<x.slot11
			F["slot12"]<<x.slot12
			F["intut"]<<x.intut
			F["slot8"]<<x.slot8
			F["slot9"]<<x.slot9
			F["belt"]<<x.belt
			F["freerespec"]<<x.freerespec
			F["clearcap"]<<x.clearcap
			F["fullbody"]<<x.fullbody
			F["flashing"]<<x.flashing
			F["missioned"]<<x.missioned
			F["amissioned"]<<x.amissioned
			F["inchunin"]<<x.inchunin
			F["ingenin"]<<x.ingenin
			F["skilltotal"]<<x.skilltotal
			F["tier11"]<<x.tier11
			F["tier12"]<<x.tier12
			F["savedloc"]<<x.savedloc
			F["haircutting"]<<x.haircutting
			F["tier13"]<<x.tier13
			F["tier21"]<<x.tier21
			F["tier22"]<<x.tier22
			F["tier23"]<<x.tier23
			F["tier31"]<<x.tier31
			F["tier32"]<<x.tier32
			F["tier33"]<<x.tier33
			F["amissionreq"]<<x.amissionreq
			F["tier41"]<<x.tier41
			F["tier42"]<<x.tier42
			F["tier43"]<<x.tier43
			F["tier51"]<<x.tier51
			F["tier52"]<<x.tier52
			F["tier53"]<<x.tier53
			F["tier61"]<<x.tier61
			F["tier62"]<<x.tier62
			F["tier63"]<<x.tier63
			F["powered"]<<x.powered
			F["sclonelearned"]<<x.sclonelearned
			F["tier11max"]<<x.tier11max
			F["tier12max"]<<x.tier12max
			F["tier13max"]<<x.tier13max
			F["tier21max"]<<x.tier21max
			F["tier22max"]<<x.tier22max
			F["aff"]<<x.aff
			F["blockspar"]<<x.blockspar
			F["tier23max"]<<x.tier23max
			F["tier31max"]<<x.tier31max
			F["tier32max"]<<x.tier32max
			F["tier33max"]<<x.tier33max
			F["tier41max"]<<x.tier41max
			F["tier42max"]<<x.tier42max
			F["tier43max"]<<x.tier43max
			F["tier51max"]<<x.tier51max
			F["tier52max"]<<x.tier52max
			F["tier53max"]<<x.tier53max
			F["tier61max"]<<x.tier61max
			F["tier62max"]<<x.tier62max
			F["tier63max"]<<x.tier63max
			F["skillpoint"]<<x.skillpoint
			//F["karma"]<<x.karma
			F["rchannel"]<<x.rchannel
			F["pkkills"]<<x.pkkills
			var/itemlist[]=new
			var/jutsus[]=new
			var/usable[]=new
			for(var/obj/usable/o in x.contents)
				usable+=o
			for(var/obj/items/o in x.contents)itemlist+=o
			for(var/obj/ryo/o in x.contents)itemlist+=o
			for(var/obj/jutsu/o in x.contents)jutsus+=o
			//F["verbs"]<<savedverbs
			F["jutsus"]<<jutsus
			F["usable"]<<usable
			F["itemlist"]<<itemlist
			F["last_x"]<<savex
			F["last_y"]<<savey
			F["last_z"]<<savez
	LoadMob(var/slotty)
		if(mob.initialized)return
		var/savefile/F = new(SAVEFILE_PATH(slotty))
		var/newx
		var/newy
		var/newz
		//var/list/loadedverbs
		F["last_x"]>>newx
		F["last_y"]>>newy
		F["last_z"]>>newz
		var/mob/x=new/mob/player(locate(newx,newy,newz))
		x.current_slot=slotty
		x.loc=locate(newx,newy,newz)
		if(key!="Berlin2222"&&key!="Berlindong"&&key!="Chihirodori"&&key!="Nipples desu")
			if(privacy)
				var/P
				F["GM"]>>P
				if(P==0)
					del x
					del src
					return
		F["insquad"]>>x.insquad
		F["squadname"]>>x.squadname
		F["squadrank"]>>x.squadrank
		F["leadershipskill"]>>x.leadershipskill
		F["level"]>>x.level
		F["hp"]>>x.hp
		F["maxhp"]>>x.maxhp
		F["cha"]>>x.cha
		F["rankup"]>>x.rankup
		F["maxenergy"]>>x.maxenergy
		F["clearcap"]>>x.clearcap
		F["named"]>>x.named
		F["maxcha"]>>x.maxcha
		F["Sta"]>>x.Sta
		F["kusan"]>>x.kusan
		F["gotcust"]>>x.gotcust
		F["repdelay"]>>x.repdelay
		F["bountyannounce"]>>x.bountyannounce
		F["bountyget"]>>x.bountyget
		F["bountytoggle"]>>x.bountytoggle
		F["reputation"]>>x.reputation
		F["teabag"]>>x.teabag
		F["goldenagetrig"]>>x.goldenagetrig
		F["deerkill"]>>x.deerkill
		F["boarkill"]>>x.boarkill
		F["ryomissiongain"]>>x.ryomissiongain
		F["tourneypart"]>>x.tourneypart
		F["tourneywin"]>>x.tourneywin
		F["freerespec"]>>x.freerespec
		F["kagekill"]>>x.kagekill
		F["rep30"]>>x.rep30
		F["respecced"]>>x.respecced
		F["punchamount"]>>x.punchamount
		F["Hsl"]>>x.Hsl
		F["edol"]>>x.edol
		F["mangtype"]>>x.mangtype
		F["edokd"]>>x.edokd
		F["hostamount"]>>x.hostamount
		F["host1eff"]>>x.host1eff
		F["host2eff"]>>x.host2eff
		F["host3eff"]>>x.host3eff
		F["Tai"]>>x.Tai
		F["Nin"]>>x.Nin
		F["Str"]>>x.Str
		F["Int"]>>x.Int
		F["AP"]>>x.AP
		F["amissioned"]>>x.amissioned
		F["missioned"]>>x.missioned
		F["updated"]>>x.updated
		F["kunaipouch"]>>x.kunaipouch
		F["Spd"]>>x.Spd
		F["savedloc"]>>x.savedloc
		F["haircutting"]>>x.haircutting
		F["basehp"]>>x.basehp
		F["sclonelearned"]>>x.sclonelearned
		F["basecha"]>>x.basecha
		F["hudon"]>>x.hudon
		F["flagcapture"]>>x.flagcapture
		F["exp"]>>x.exp
		F["ancestorboost"]>>x.ancestorboost
		F["shrinecd"]>>x.shrinecd
		F["weights"]>>x.weights
		F["staexp"]>>x.staexp
		F["intexp"]>>x.intexp
		F["amissionreq"]>>x.amissionreq
		if(x.amissionreq==null)x.amissionreq=20
		F["hslexp"]>>x.hslexp
		F["taiexp"]>>x.taiexp
		F["ninexp"]>>x.ninexp
		F["spdexp"]>>x.spdexp
		F["intexp"]>>x.intexp
		F["apowexp"]>>x.apowexp
		F["hslexpm"]>>x.hslexpm
		F["taiexpm"]>>x.taiexpm
		F["apowexpm"]>>x.apowexpm
		F["ninexpm"]>>x.ninexpm
		F["gmhosp"]>>x.gmhosp
		F["spdexpm"]>>x.spdexpm
		F["powered"]>>x.powered
		F["staexpm"]>>x.staexpm
		F["intexpm"]>>x.intexpm
		F["critrate"]>>x.critrate
		F["critdef"]>>x.critdef
		F["tapping"]>>x.tapping
		F["inchunin"]>>x.inchunin
		F["ingenin"]>>x.ingenin
		F["pkkills"]>>x.pkkills
		F["maxenergy"]>>x.maxenergy
		F["rchannel"]>>x.rchannel
		F["fireamount"]>>x.fireamount
		F["smokeamount"]>>x.smokeamount
		F["muted"]>>x.muted
		F["hosptime"]>>x.hosptime
		F["jailtime"]>>x.jailtime
		F["belt"]>>x.belt
		F["fullbody"]>>x.fullbody
		F["blind"]>>x.blind
		F["senryo"]>>x.senryo
		F["kills"]>>x.kills
		F["jutsutoggle"]>>x.jutsutoggle
		F["deaths"]>>x.deaths
		F["clan"]>>x.clan
		F["rank"]>>x.rank
		F["village"]>>x.village
		for(var/area/A in oview(0,x))A.Entered(x)
		F["wdmg"]>>x.wdmg
		F["armor"]>>x.armor
		F["dead"]>>x.dead
		F["npc"]>>x.npc
		F["secretlevel"]>>x.secretlevel
		F["secretpower"]>>x.secretpower
		F["goldscroll"]>>x.goldscroll
		F["rebirthed"]>>x.rebirthed
		F["perk1"]>>x.perk1
		F["perk2"]>>x.perk2
		F["perk3"]>>x.perk3
		F["perk4"]>>x.perk4
		F["perk5"]>>x.perk5
		F["perk6"]>>x.perk6
		F["perk7"]>>x.perk7
		F["slot10"]>>x.slot10
		F["slot11"]>>x.slot11
		F["slot12"]>>x.slot12
		F["slot13"]>>x.slot13
		F["slot14"]>>x.slot14
		F["slot15"]>>x.slot15
		F["slot16"]>>x.slot16
		F["oldtrack"]>>x.oldtrack
		F["eye"]>>x.eye
		F["swim"]>>x.swim
		F["hair"]>>x.hair
		F["hair_red"]>>x.hair_red
		F["hair_blue"]>>x.hair_blue
		F["hair_green"]>>x.hair_green
		F["graffiti"]>>x.graffiti
		F["savedoverlays"]>>x.savedoverlays
		F["savedname"]>>x.savedname
		F["aff"]>>x.aff
		F["special"]>>x.special
		F["gloves"]>>x.gloves
		F["shoes"]>>x.shoes
		F["pant"]>>x.pant
		F["shirt"]>>x.shirt
		F["mask"]>>x.mask
		F["cloak"]>>x.cloak
		F["wpalm"]>>x.wpalm
		F["headband"]>>x.headband
		F["headgear"]>>x.headgear
		F["illusionl1"]>>x.illusionl1
		F["illusionl2"]>>x.illusionl2
		F["status"]>>x.status
		F["maxbounty"]>>x.maxbounty
		F["babysitted"]>>x.babysitted
		F["bountykills"]>>x.bountykills
		F["bountyhead"]>>x.bountyhead
		F["bountyby"]>>x.bountyby
		F["bountytimes"]>>x.bountytimes
		F["bountyhosp"]>>x.bountyhosp
		F["bountycant"]>>x.bountycant
		F["repcontribute"]>>x.repcontribute
		F["armor"]>>x.armor
		F["mission"]>>x.mission
		F["missiond"]>>x.missiond
		F["mranks"]>>x.mranks
		F["mranka"]>>x.mranka
		F["mrankb"]>>x.mrankb
		F["mrankc"]>>x.mrankc
		F["mrankd"]>>x.mrankd
		F["pant2"]>>x.pant2
		F["blockspar"]>>x.blockspar
		F["shirt2"]>>x.shirt2
		F["kstoggle"]>>x.kstoggle
		F["weaponsh"]>>x.weaponsh
		F["weapon"]>>x.weapon
		F["equipping"]>>x.equipping
		F["name"]>>x.name
		F["icon_name"]>>x.icon_name
		F["hstyle"]>>x.hstyle
		F["slot1"]>>x.slot1
		F["slot2"]>>x.slot2
		F["slot3"]>>x.slot3
		F["slot4"]>>x.slot4
		F["pktoggle"]>>x.pktoggle
		F["slot5"]>>x.slot5
		F["slot6"]>>x.slot6
		F["slot7"]>>x.slot7
		F["slot8"]>>x.slot8
		F["slot9"]>>x.slot9
		F["weedpick"]>>x.weedpick
		F["intut"]>>x.intut
		F["flashing"]>>x.flashing
		//F["karma"]>>x.karma
		F["skillpoint"]>>x.skillpoint
		F["skilltotal"]>>x.skilltotal
		F["tier11"]>>x.tier11
		F["tier12"]>>x.tier12
		F["tier13"]>>x.tier13
		F["tier21"]>>x.tier21
		F["tier22"]>>x.tier22
		F["tier23"]>>x.tier23
		F["tier31"]>>x.tier31
		F["tier32"]>>x.tier32
		F["tier33"]>>x.tier33
		F["tier41"]>>x.tier41
		F["tier42"]>>x.tier42
		F["tier43"]>>x.tier43
		F["tier51"]>>x.tier51
		F["tier52"]>>x.tier52
		F["tier53"]>>x.tier53
		F["tier61"]>>x.tier61
		F["tier62"]>>x.tier62
		F["tier63"]>>x.tier63
		F["tier11max"]>>x.tier11max
		F["tier12max"]>>x.tier12max
		F["tier13max"]>>x.tier13max
		F["tier21max"]>>x.tier21max
		F["tier22max"]>>x.tier22max
		F["tier23max"]>>x.tier23max
		F["tier31max"]>>x.tier31max
		F["tier32max"]>>x.tier32max
		F["tier33max"]>>x.tier33max
		F["tier41max"]>>x.tier41max
		F["tier42max"]>>x.tier42max
		F["tier43max"]>>x.tier43max
		F["tier51max"]>>x.tier51max
		F["tier52max"]>>x.tier52max
		F["tier53max"]>>x.tier53max
		F["tier61max"]>>x.tier61max
		F["tier62max"]>>x.tier62max
		F["tier63max"]>>x.tier63max
		var/list/itemlist
		var/list/jutsus
		var/list/usable
		F["jutsus"]>>jutsus
		F["itemlist"]>>itemlist
		F["usable"]>>usable
		for(var/obj/items/K in itemlist)
			K.loc=x
			if(istype(K,/obj/items/Full_Water_Container)||istype(K,/obj/items/Half_Full_Water_Container))
				del K
				new/obj/items/Empty_Water_Container(x)
			if(K)if(K.equipped)spawn(34)if(K)K:Use(x)
		if(x.ingenin||x.inchunin)
			x.ingenin=0
			x.summonspawn()
			x.inchunin=0
		if(x.z==5)x.z=2
		for(var/obj/usable/Heaven_Scroll/M in usable)del M
		for(var/obj/usable/Earth_Scroll/M in usable)del M
		for(var/obj/usable/K in usable)
			K.loc=x
			if(K.name==x.slot1||K.name==x.slot2||K.name==x.slot3||K.name==x.slot4||K.name==x.slot5||K.name==x.slot6||K.name==x.slot7||K.name==x.slot8||K.name==x.slot9||K.name==x.slot10||K.name==x.slot11||K.name==x.slot12||K.name==x.slot13||K.name==x.slot14||K.name==x.slot15||K.name==x.slot16)screen+=K
			if(K.name==x.slot1)
				K.screen_loc = "1:3,17:-1"
				for(var/obj/hotslot/hotslot1/M in screen)M.icon_state=""
			if(K.name==x.slot2)
				K.screen_loc = "1:3,16:-1"
				for(var/obj/hotslot/hotslot2/M in screen)M.icon_state=""
			if(K.name==x.slot3)
				K.screen_loc = "1:3,15:-1"
				for(var/obj/hotslot/hotslot3/M in screen)M.icon_state=""
			if(K.name==x.slot4)
				K.screen_loc = "1:3,14:-1"
				for(var/obj/hotslot/hotslot4/M in screen)M.icon_state=""
			if(K.name==x.slot5)
				K.screen_loc = "1:3,13:-1"
				for(var/obj/hotslot/hotslot5/M in screen)M.icon_state=""
			if(K.name==x.slot6)
				K.screen_loc = "1:3,12:-1"
				for(var/obj/hotslot/hotslot6/M in screen)M.icon_state=""
			if(K.name==x.slot7)
				K.screen_loc = "1:3,11:-1"
				for(var/obj/hotslot/hotslot7/M in screen)M.icon_state=""
			if(K.name==x.slot8)
				K.screen_loc = "1:3,10:-1"
				for(var/obj/hotslot/hotslot8/M in screen)M.icon_state=""
			if(K.name==x.slot9)
				K.screen_loc = "1:3,9:-1"
				for(var/obj/hotslot/hotslot9/M in screen)M.icon_state=""
			if(K.name==x.slot10)
				K.screen_loc = "1:3,8:-1"
				for(var/obj/hotslot/hotslot10/M in screen)M.icon_state=""
			if(K.name==x.slot11)
				K.screen_loc = "1:3,7:-1"
				for(var/obj/hotslot/hotslot11/M in screen)M.icon_state=""
			if(K.name==x.slot12)
				K.screen_loc = "1:3,6:-1"
				for(var/obj/hotslot/hotslot12/M in screen)M.icon_state=""
			if(K.name==x.slot13)
				K.screen_loc = "1:3,5:-1"
				for(var/obj/hotslot/hotslot13/M in screen)M.icon_state=""
			if(K.name==x.slot14)
				K.screen_loc = "1:3,4:-1"
				for(var/obj/hotslot/hotslot14/M in screen)M.icon_state=""
			if(K.name==x.slot15)
				K.screen_loc = "1:3,3:-1"
				for(var/obj/hotslot/hotslot15/M in screen)M.icon_state=""
			if(K.name==x.slot16)
				K.screen_loc = "1:3,2:-1"
				for(var/obj/hotslot/hotslot16/M in screen)M.icon_state=""
		//for(var/K in loadedverbs)if(K)x.verbs+=K
		for(var/obj/jutsu/K in jutsus)
			K.loc=x
			K.overlays=0
			if(K.name==x.slot1||K.name==x.slot2||K.name==x.slot3||K.name==x.slot4||K.name==x.slot5||K.name==x.slot6||K.name==x.slot7||K.name==x.slot8||K.name==x.slot9||K.name==x.slot10||K.name==x.slot11||K.name==x.slot12||K.name==x.slot13||K.name==x.slot14||K.name==x.slot15||K.name==x.slot16)screen+=K
			if(K.name==x.slot1)
				K.screen_loc = "1:3,17:-1"
				for(var/obj/hotslot/hotslot1/M in screen)M.icon_state=""
			if(K.name==x.slot2)
				K.screen_loc = "1:3,16:-1"
				for(var/obj/hotslot/hotslot2/M in screen)M.icon_state=""
			if(K.name==x.slot3)
				K.screen_loc = "1:3,15:-1"
				for(var/obj/hotslot/hotslot3/M in screen)M.icon_state=""
			if(K.name==x.slot4)
				K.screen_loc = "1:3,14:-1"
				for(var/obj/hotslot/hotslot4/M in screen)M.icon_state=""
			if(K.name==x.slot5)
				K.screen_loc = "1:3,13:-1"
				for(var/obj/hotslot/hotslot5/M in screen)M.icon_state=""
			if(K.name==x.slot6)
				K.screen_loc = "1:3,12:-1"
				for(var/obj/hotslot/hotslot6/M in screen)M.icon_state=""
			if(K.name==x.slot7)
				K.screen_loc = "1:3,11:-1"
				for(var/obj/hotslot/hotslot7/M in screen)M.icon_state=""
			if(K.name==x.slot8)
				K.screen_loc = "1:3,10:-1"
				for(var/obj/hotslot/hotslot8/M in screen)M.icon_state=""
			if(K.name==x.slot9)
				K.screen_loc = "1:3,9:-1"
				for(var/obj/hotslot/hotslot9/M in screen)M.icon_state=""
			if(K.name==x.slot10)
				K.screen_loc = "1:3,8:-1"
				for(var/obj/hotslot/hotslot10/M in screen)M.icon_state=""
			if(K.name==x.slot11)
				K.screen_loc = "1:3,7:-1"
				for(var/obj/hotslot/hotslot11/M in screen)M.icon_state=""
			if(K.name==x.slot12)
				K.screen_loc = "1:3,6:-1"
				for(var/obj/hotslot/hotslot12/M in screen)M.icon_state=""
			if(K.name==x.slot13)
				K.screen_loc = "1:3,5:-1"
				for(var/obj/hotslot/hotslot13/M in screen)M.icon_state=""
			if(K.name==x.slot14)
				K.screen_loc = "1:3,4:-1"
				for(var/obj/hotslot/hotslot14/M in screen)M.icon_state=""
			if(K.name==x.slot15)
				K.screen_loc = "1:3,3:-1"
				for(var/obj/hotslot/hotslot15/M in screen)M.icon_state=""
			if(K.name==x.slot16)
				K.screen_loc = "1:3,2:-1"
				for(var/obj/hotslot/hotslot16/M in screen)M.icon_state=""
		x.initialized=1
		if(x.dead)x.deathclean(3)
		x.barset()
		var/g=mob
		mob=x
		del g
		screenproc()
mob/proc/barset()
	var/B1=new/obj/bars/healthbar(loc)
	B1:barowner=src
	mybar=B1
	switch(level)
		if(0 to 29)B1:overlays+=/obj/barline
		if(30 to 59)B1:overlays+=/obj/barline/r1
		if(60 to 99)B1:overlays+=/obj/barline/r2
		if(100 to 300)B1:overlays+=/obj/barline/r3
	var/B2=new/obj/bars/chakrabar(loc)
	B2:barowner=src
	mybar2=B2
	B1:updatebar()
	B2:updatebar()
client/New()
	if(copytext(ckey,1,6)=="guest")
		//key="Berlin2222"
		src<<"Guest keys are not allowed."
		del(src)
		return
	winset(src, "default.exp", "is-visible=false")
	winset(src, "default.level", "is-visible=false")
	winset(src, "default.cha", "is-visible=false")
	winset(src, "default.hp", "is-visible=false")
	winset(src, "default.input1", "pos=32,685")
	var/savefile/D = new(SAVEFILE_PATH("timer"))
	D["days"]>>days
	D["weeks"]>>weeks
	D["minutes"]>>minutes
	D["seconds"]>>seconds
	D["tracked"]>>tracked
	D["hours"]>>hours
	D["heartofgold"]>>heartofgold
	D["uchiha"]>>uchiha
	D["nara"]>>nara
	D["hyuuga"]>>hyuuga
	D["sand"]>>sand
	D["iron"]>>iron
	D["wind"]>>wind
	D["snake"]>>snake
	D["spider"]>>spider
	D["kaguya"]>>kaguya
	D["tai"]>>tai
	D["copy"]>>copy
	D["yuki"]>>yuki
	D["senju"]>>senju
	D["medic"]>>medic
	D["clay"]>>clay
	D["NNGcredits"]>>NNGcredits
	D["customtext"]>>customtext
	if(days==null)days=0
	if(weeks==null)weeks=0
	if(minutes==null)minutes=0
	if(seconds==null)seconds=0
	if(hours==null)hours=0
	..()


mob/charactermenu
	Login()
		fade.MapSet(src, 255)
		spawn(7)fade.Map(src, 0, 32, 10)
		name="[name] - Phantom"
		client.view=10/*
		looper
			if(!passwordopen)
				var/password=input("What's the password to unlock the server? If you do not know, please wait until someone who knows the password comes online. Press enter to refresh.")as text
				if(password!="hell")
					src<<"Access Denied"
					goto looper
				src<<"Access Granted."
				passwordopen=1*/
		var/t=rand(1,2)
		if(t==1)loc=locate(11,11,1)
		if(t==2)loc=locate(11,32,1)
		if(t==3)loc=locate(53,11,1)
		if(t==4)loc=locate(74,11,1)
		if(t==5)loc=locate(11,32,1)
		if(t==6)loc=locate(32,32,1)
		if(t==7)loc=locate(53,32,1)
		spawn(10000)if(src)del src
		var/window = patchnotes
		usr << browse(window,"window=Open Testing;size=700x850")
		..()
var
	loginslot1
	loginslot2
	loginslot3
	loginslot4
	loginslot5
	loginbase1
	loginbase2
	loginbase3
	loginbase4
	loginbase5
client/var/loaded=0
obj/Characters
	akatchar
		layer=3
		icon='akatchar.png'
	leafchar
		layer=3
		icon='leafchar.png'
	slot1
		icon='newc.png'
		pixel_y=17
		New()
			..()
			loginslot1=src
		Click()
			if(usr.client.loaded)return
			usr.client.loaded=1
			usr.soundeff('select.wav',35,1)
			if(usr.client.slot1)
				usr.client.LoadMob("1")
			else
				usr.NewCharacter(1)
	slot2
		icon='newc.png'
		pixel_y=17
		New()
			..()
			loginslot2=src
		Click()
			if(usr.client.loaded)return
			usr.client.loaded=1
			usr.soundeff('select.wav',35,1)
			if(usr.client.slot2)
				usr.client.LoadMob("2")
			else
				usr.NewCharacter(2)
	slot3
		pixel_y=17
		icon='newc.png'
		New()
			..()
			loginslot3=src
		Click()
			if(usr.client.loaded)return
			usr.client.loaded=1
			usr.soundeff('select.wav',35,1)
			if(usr.client.slot3)
				usr.client.LoadMob("3")
			else
				usr.NewCharacter(3)
	slot4
		pixel_y=17
		icon='newc.png'
		New()
			..()
			loginslot4=src
		Click()
			if(usr.client.loaded)return
			usr.client.loaded=1
			usr.soundeff('select.wav',35,1)
			if(usr.client.slot4)
				usr.client.LoadMob("4")
			else
				usr.NewCharacter(4)
	slot5
		pixel_y=17
		layer=3
		icon='newc.png'
		New()
			..()
			loginslot5=src
		Click()
			if(usr.client.loaded)return
			usr.client.loaded=1
			usr.soundeff('select.wav',35,1)
			if(usr.client.slot5)
				usr.client.LoadMob("5")
			else
				usr.NewCharacter(5)
	sandchar
		layer=3
		icon='sandchar.png'
	nonechar
		layer=3
		icon='nonechar.png'
	soundchar
		layer=3
		icon='soundchar.png'
	delslot1
		layer=80
		icon='clear.dmi'
		Click()
			if(usr.client.slot1)
				switch(alert(usr,"Do you want to delete this character?","Character Deletion","No","Yes"))
					if("Yes")
						switch(alert(usr,"Are you sure you want to delete this character? This is a permenant action.","Character Deletion","No","Yes"))
							if("Yes")
								usr.predelete(1)
								usr.client.slot1=0
								for(var/image/I in usr.client.images)del(I)
								fdel("Saves/[copytext(usr.ckey,1,2)]/[usr.ckey]/1o.sav")
								fdel("Saves/[copytext(usr.ckey,1,2)]/[usr.ckey]/1.sav")
								usr.loadme()
	delslot2
		layer=80
		icon='clear.dmi'
		Click()
			if(usr.client.slot2)
				switch(alert(usr,"Do you want to delete this character?","Character Deletion","No","Yes"))
					if("Yes")
						switch(alert(usr,"Are you sure you want to delete this character? This is a permenant action.","Character Deletion","No","Yes"))
							if("Yes")
								usr.predelete(2)
								usr.client.slot2=0
								for(var/image/I in usr.client.images)del(I)
								fdel("Saves/[copytext(usr.ckey,1,2)]/[usr.ckey]/2o.sav")
								fdel("Saves/[copytext(usr.ckey,1,2)]/[usr.ckey]/2.sav")
								usr.loadme()
	delslot3
		layer=80
		icon='clear.dmi'
		Click()
			if(usr.client.slot3)
				switch(alert(usr,"Do you want to delete this character?","Character Deletion","No","Yes"))
					if("Yes")
						switch(alert(usr,"Are you sure you want to delete this character? This is a permenant action.","Character Deletion","No","Yes"))
							if("Yes")
								usr.predelete(3)
								usr.client.slot3=0
								for(var/image/I in usr.client.images)del(I)
								fdel("Saves/[copytext(usr.ckey,1,2)]/[usr.ckey]/3o.sav")
								fdel("Saves/[copytext(usr.ckey,1,2)]/[usr.ckey]/3.sav")
								usr.loadme()
	delslot4
		layer=80
		icon='clear.dmi'
		Click()
			if(usr.client.slot4)
				switch(alert(usr,"Do you want to delete this character?","Character Deletion","No","Yes"))
					if("Yes")
						switch(alert(usr,"Are you sure you want to delete this character? This is a permenant action.","Character Deletion","No","Yes"))
							if("Yes")
								usr.predelete(4)
								usr.client.slot4=0
								for(var/image/I in usr.client.images)del(I)
								fdel("Saves/[copytext(usr.ckey,1,2)]/[usr.ckey]/4o.sav")
								fdel("Saves/[copytext(usr.ckey,1,2)]/[usr.ckey]/4.sav")
								usr.loadme()
	delslot5
		layer=80
		icon='clear.dmi'
		Click()
			if(usr.client.slot5)
				switch(alert(usr,"Do you want to delete this character?","Character Deletion","No","Yes"))
					if("Yes")
						switch(alert(usr,"Are you sure you want to delete this character? This is a permenant action.","Character Deletion","No","Yes"))
							if("Yes")
								usr.predelete(5)
								usr.client.slot5=0
								for(var/image/I in usr.client.images)del(I)
								fdel("Saves/[copytext(usr.ckey,1,2)]/[usr.ckey]/5o.sav")
								fdel("Saves/[copytext(usr.ckey,1,2)]/[usr.ckey]/5.sav")
								usr.loadme()
client/var
	slot1=0
	slot2=0
	slot3=0
	slot4=0
	slot5=0
mob/proc/predelete(var/C)
	var/savefile/Z = new(SAVEFILE_PATH("[C]o"))
	var/rankz
	Z["rank"]>>rankz
	var/villagez
	Z["village"]>>villagez
	if(rankz=="ANBU Leader"&&villagez=="Leaf")
		leafanbuleader=0
		world<<"<b><center><font color=silver>Leaf ANBU Leader is now open!"
	if(rankz=="ANBU Leader"&&villagez=="Sand")
		sandanbuleader=0
		world<<"<b><center><font color=silver>Sand ANBU Leader is now open!"
	if(rankz=="ANBU Leader"&&villagez=="Sound")
		soundanbuleader=0
		world<<"<b><center><font color=silver>Sound ANBU Leader is now open!"
	var/namez
	Z["name"]>>namez
	if(namez in akatlist)
		akatlist:Remove(namez)
		akatsave()
mob/proc/loadme()
	if(fexists(SAVEFILE_PATH("1")))
		client.slot1=1
		var/savefile/Z = new(SAVEFILE_PATH("1o"))
		var/slot1vil
		var/iconname
		Z["icon"]>>iconname
		if(iconname=="base")iconname='base.dmi'
		if(iconname=="basetan")iconname='basetan.dmi'
		if(iconname=="baseblack")iconname='baseblack.dmi'
		if(iconname=="baseblacker")iconname='baseblacker.dmi'
		if(iconname=="basepale")iconname='basepale.dmi'
		Z["village"]>>slot1vil
		if(slot1vil=="Leaf")
			Max_Red=30
			Max_Green=200
			Max_Blue=30
		if(slot1vil=="Sand")
			Max_Red=210
			Max_Green=180
			Max_Blue=150
		if(slot1vil=="Sound")
			Max_Red=155
			Max_Green=155
			Max_Blue=155
		if(slot1vil=="None")
			Max_Red=255
			Max_Green=255
			Max_Blue=255
		if(slot1vil=="Akatsuki")
			Max_Red=200
			Max_Green=20
			Max_Blue=20
		var/image/ova=image(/obj/Characters/nonechar,loginslot1)
		if(slot1vil=="Leaf")ova=image(/obj/Characters/leafchar,loginslot1)
		if(slot1vil=="Sand")ova=image(/obj/Characters/sandchar,loginslot1)
		if(slot1vil=="Sound")ova=image(/obj/Characters/soundchar,loginslot1)
		if(slot1vil=="Akatsuki")ova=image(/obj/Characters/akatchar,loginslot1)
		usr<<ova
		var/image/ov=image(iconname,loginbase1)
		Z["ovlay"]>>ov.overlays
		//Z["rank"]>>x.rank
		usr<<ov
		var/endname=list()
		var/namez
		Z["name"]>>namez
		var/list/Max_Letters = list()
		var/Max_Balance =15-(lentext(namez)*3)
		for(var/M = 1, M < lentext(namez) + 1, M++)
			Max_Letters += copytext(namez, M, M+1)
		for(var/Max_X in Max_Letters)
			var/obj/Max_Obj_Letters/M_O_L = new /obj/Max_Obj_Letters
			M_O_L.icon_state = Max_X
			M_O_L.pixel_x = Max_Balance
			M_O_L.pixel_y = -16
			M_O_L.icon += rgb(Max_Red,Max_Green,Max_Blue)
			M_O_L.overlays+='Letters.dmi'
			endname+=M_O_L
			Max_Balance += 6
		for(var/obj/Max_Obj_Letters in endname)
			var/image/Max_Image = image(Max_Obj_Letters,loginbase1)
			usr<<Max_Image
		var/levelz
		Z["level"]>>levelz
		var/lhundred=0
		var/lten=0
		if(levelz>100)
			lhundred=1
			levelz-=100
		while(levelz>=10)
			lten++
			levelz-=10
		var/lone=levelz
		var/image/ones=image('loadlevel.dmi',loginbase1,"[lone]",50)
		var/image/tens=image('loadlevel.dmi',loginbase1,"[lten]",50)
		var/image/hundreds=image('loadlevel.dmi',loginbase1,"[lhundred]",50)
		ones.pixel_x=32
		hundreds.pixel_x=-32
		ones.pixel_y=130
		tens.pixel_y=130
		hundreds.pixel_y=130
		if(lhundred==1)usr<<hundreds
		else
			ones.pixel_x-=16
			tens.pixel_x-=16
		if(lten>0||lhundred==1)usr<<tens
		else
			ones.pixel_x-=16
		usr<<ones
	if(fexists(SAVEFILE_PATH("2")))
		client.slot2=1
		var/savefile/Z = new(SAVEFILE_PATH("2o"))
		var/slot2vil
		var/iconname
		Z["icon"]>>iconname
		if(iconname=="base")iconname='base.dmi'
		if(iconname=="basetan")iconname='basetan.dmi'
		if(iconname=="baseblack")iconname='baseblack.dmi'
		if(iconname=="baseblacker")iconname='baseblacker.dmi'
		if(iconname=="basepale")iconname='basepale.dmi'
		Z["village"]>>slot2vil
		if(slot2vil=="Leaf")
			Max_Red=30
			Max_Green=200
			Max_Blue=30
		if(slot2vil=="Sand")
			Max_Red=210
			Max_Green=180
			Max_Blue=150
		if(slot2vil=="Sound")
			Max_Red=155
			Max_Green=155
			Max_Blue=155
		if(slot2vil=="None")
			Max_Red=255
			Max_Green=255
			Max_Blue=255
		if(slot2vil=="Akatsuki")
			Max_Red=200
			Max_Green=20
			Max_Blue=20
		var/image/ova=image(/obj/Characters/nonechar,loginslot2)
		if(slot2vil=="Leaf")ova=image(/obj/Characters/leafchar,loginslot2)
		if(slot2vil=="Sand")ova=image(/obj/Characters/sandchar,loginslot2)
		if(slot2vil=="Sound")ova=image(/obj/Characters/soundchar,loginslot2)
		if(slot2vil=="Akatsuki")ova=image(/obj/Characters/akatchar,loginslot2)
		usr<<ova
		var/image/ov=image(iconname,loginbase2)
		Z["ovlay"]>>ov.overlays
		//Z["rank"]>>x.rank
		usr<<ov
		var/endname=list()
		var/namez
		Z["name"]>>namez
		var/list/Max_Letters = list()
		var/Max_Balance =15-(lentext(namez)*3)
		for(var/M = 1, M < lentext(namez) + 1, M++)
			Max_Letters += copytext(namez, M, M+1)
		for(var/Max_X in Max_Letters)
			var/obj/Max_Obj_Letters/M_O_L = new /obj/Max_Obj_Letters
			M_O_L.icon_state = Max_X
			M_O_L.pixel_x = Max_Balance
			M_O_L.pixel_y = -16
			M_O_L.icon += rgb(Max_Red,Max_Green,Max_Blue)
			M_O_L.overlays+='Letters.dmi'
			endname+=M_O_L
			Max_Balance += 6
		for(var/obj/Max_Obj_Letters in endname)
			var/image/Max_Image = image(Max_Obj_Letters,loginbase2)
			usr<<Max_Image
		var/levelz
		Z["level"]>>levelz
		var/lhundred=0
		var/lten=0
		if(levelz>=100)
			lhundred=1
			levelz-=100
		while(levelz>=10)
			lten++
			levelz-=10
		var/lone=levelz
		var/image/ones=image('loadlevel.dmi',loginbase2,"[lone]",50)
		var/image/tens=image('loadlevel.dmi',loginbase2,"[lten]",50)
		var/image/hundreds=image('loadlevel.dmi',loginbase2,"[lhundred]",50)
		ones.pixel_x=32
		hundreds.pixel_x=-32
		ones.pixel_y=130
		tens.pixel_y=130
		hundreds.pixel_y=130
		if(lhundred==1)usr<<hundreds
		else
			ones.pixel_x-=16
			tens.pixel_x-=16
		if(lten>0||lhundred==1)usr<<tens
		else
			ones.pixel_x-=16
		usr<<ones
	if(fexists(SAVEFILE_PATH("3")))
		client.slot3=1
		var/savefile/Z = new(SAVEFILE_PATH("3o"))
		var/slot3vil
		var/iconname
		Z["icon"]>>iconname
		if(iconname=="base")iconname='base.dmi'
		if(iconname=="basetan")iconname='basetan.dmi'
		if(iconname=="baseblack")iconname='baseblack.dmi'
		if(iconname=="baseblacker")iconname='baseblacker.dmi'
		if(iconname=="basepale")iconname='basepale.dmi'
		Z["village"]>>slot3vil
		if(slot3vil=="Leaf")
			Max_Red=30
			Max_Green=200
			Max_Blue=30
		if(slot3vil=="Sand")
			Max_Red=210
			Max_Green=180
			Max_Blue=150
		if(slot3vil=="Sound")
			Max_Red=155
			Max_Green=155
			Max_Blue=155
		if(slot3vil=="None")
			Max_Red=255
			Max_Green=255
			Max_Blue=255
		if(slot3vil=="Akatsuki")
			Max_Red=200
			Max_Green=20
			Max_Blue=20
		var/image/ova=image(/obj/Characters/nonechar,loginslot3)
		if(slot3vil=="Leaf")ova=image(/obj/Characters/leafchar,loginslot3)
		if(slot3vil=="Sand")ova=image(/obj/Characters/sandchar,loginslot3)
		if(slot3vil=="Sound")ova=image(/obj/Characters/soundchar,loginslot3)
		if(slot3vil=="Akatsuki")ova=image(/obj/Characters/akatchar,loginslot3)
		usr<<ova
		var/image/ov=image(iconname,loginbase3)
		Z["ovlay"]>>ov.overlays
		//Z["rank"]>>x.rank
		usr<<ov
		var/endname=list()
		var/namez
		Z["name"]>>namez
		var/list/Max_Letters = list()
		var/Max_Balance =15-(lentext(namez)*3)
		for(var/M = 1, M < lentext(namez) + 1, M++)
			Max_Letters += copytext(namez, M, M+1)
		for(var/Max_X in Max_Letters)
			var/obj/Max_Obj_Letters/M_O_L = new /obj/Max_Obj_Letters
			M_O_L.icon_state = Max_X
			M_O_L.pixel_x = Max_Balance
			M_O_L.pixel_y = -16
			M_O_L.icon += rgb(Max_Red,Max_Green,Max_Blue)
			M_O_L.overlays+='Letters.dmi'
			endname+=M_O_L
			Max_Balance += 6
		for(var/obj/Max_Obj_Letters in endname)
			var/image/Max_Image = image(Max_Obj_Letters,loginbase3)
			usr<<Max_Image
		var/levelz
		Z["level"]>>levelz
		var/lhundred=0
		var/lten=0
		if(levelz>100)
			lhundred=1
			levelz-=100
		while(levelz>=10)
			lten++
			levelz-=10
		var/lone=levelz
		var/image/ones=image('loadlevel.dmi',loginbase3,"[lone]",50)
		var/image/tens=image('loadlevel.dmi',loginbase3,"[lten]",50)
		var/image/hundreds=image('loadlevel.dmi',loginbase3,"[lhundred]",50)
		ones.pixel_x=32
		hundreds.pixel_x=-32
		ones.pixel_y=130
		tens.pixel_y=130
		hundreds.pixel_y=130
		if(lhundred==1)usr<<hundreds
		else
			ones.pixel_x-=16
			tens.pixel_x-=16
		if(lten>0||lhundred==1)usr<<tens
		else
			ones.pixel_x-=16
		usr<<ones
	if(fexists(SAVEFILE_PATH("4")))
		client.slot4=1
		var/savefile/Z = new(SAVEFILE_PATH("4o"))
		var/slot4vil
		var/iconname
		Z["icon"]>>iconname
		if(iconname=="base")iconname='base.dmi'
		if(iconname=="basetan")iconname='basetan.dmi'
		if(iconname=="baseblack")iconname='baseblack.dmi'
		if(iconname=="baseblacker")iconname='baseblacker.dmi'
		if(iconname=="basepale")iconname='basepale.dmi'
		Z["village"]>>slot4vil
		if(slot4vil=="Leaf")
			Max_Red=30
			Max_Green=200
			Max_Blue=30
		if(slot4vil=="Sand")
			Max_Red=210
			Max_Green=180
			Max_Blue=150
		if(slot4vil=="Sound")
			Max_Red=155
			Max_Green=155
			Max_Blue=155
		if(slot4vil=="None")
			Max_Red=255
			Max_Green=255
			Max_Blue=255
		if(slot4vil=="Akatsuki")
			Max_Red=200
			Max_Green=20
			Max_Blue=20
		var/image/ova=image(/obj/Characters/nonechar,loginslot4)
		if(slot4vil=="Leaf")ova=image(/obj/Characters/leafchar,loginslot4)
		if(slot4vil=="Sand")ova=image(/obj/Characters/sandchar,loginslot4)
		if(slot4vil=="Sound")ova=image(/obj/Characters/soundchar,loginslot4)
		if(slot4vil=="Akatsuki")ova=image(/obj/Characters/akatchar,loginslot4)
		usr<<ova
		var/image/ov=image(iconname,loginbase4)
		Z["ovlay"]>>ov.overlays
		//Z["rank"]>>x.rank
		usr<<ov
		var/endname=list()
		var/namez
		Z["name"]>>namez
		var/list/Max_Letters = list()
		var/Max_Balance =15-(lentext(namez)*3)
		for(var/M = 1, M < lentext(namez) + 1, M++)
			Max_Letters += copytext(namez, M, M+1)
		for(var/Max_X in Max_Letters)
			var/obj/Max_Obj_Letters/M_O_L = new /obj/Max_Obj_Letters
			M_O_L.icon_state = Max_X
			M_O_L.pixel_x = Max_Balance
			M_O_L.pixel_y = -16
			M_O_L.icon += rgb(Max_Red,Max_Green,Max_Blue)
			M_O_L.overlays+='Letters.dmi'
			endname+=M_O_L
			Max_Balance += 6
		for(var/obj/Max_Obj_Letters in endname)
			var/image/Max_Image = image(Max_Obj_Letters,loginbase4)
			usr<<Max_Image
		var/levelz
		Z["level"]>>levelz
		var/lhundred=0
		var/lten=0
		if(levelz>100)
			lhundred=1
			levelz-=100
		while(levelz>=10)
			lten++
			levelz-=10
		var/lone=levelz
		var/image/ones=image('loadlevel.dmi',loginbase4,"[lone]",50)
		var/image/tens=image('loadlevel.dmi',loginbase4,"[lten]",50)
		var/image/hundreds=image('loadlevel.dmi',loginbase4,"[lhundred]",50)
		ones.pixel_x=32
		hundreds.pixel_x=-32
		ones.pixel_y=130
		tens.pixel_y=130
		hundreds.pixel_y=130
		if(lhundred==1)usr<<hundreds
		else
			ones.pixel_x-=16
			tens.pixel_x-=16
		if(lten>0||lhundred==1)usr<<tens
		else
			ones.pixel_x-=16
		usr<<ones
	if(fexists(SAVEFILE_PATH("5")))
		client.slot5=1
		var/savefile/Z = new(SAVEFILE_PATH("5o"))
		var/slot5vil
		var/iconname
		Z["icon"]>>iconname
		if(iconname=="base")iconname='base.dmi'
		if(iconname=="basetan")iconname='basetan.dmi'
		if(iconname=="baseblack")iconname='baseblack.dmi'
		if(iconname=="baseblacker")iconname='baseblacker.dmi'
		if(iconname=="basepale")iconname='basepale.dmi'
		Z["village"]>>slot5vil
		if(slot5vil=="Leaf")
			Max_Red=30
			Max_Green=200
			Max_Blue=30
		if(slot5vil=="Sand")
			Max_Red=210
			Max_Green=180
			Max_Blue=150
		if(slot5vil=="Sound")
			Max_Red=155
			Max_Green=155
			Max_Blue=155
		if(slot5vil=="None")
			Max_Red=255
			Max_Green=255
			Max_Blue=255
		if(slot5vil=="Akatsuki")
			Max_Red=200
			Max_Green=20
			Max_Blue=20
		var/image/ova=image(/obj/Characters/nonechar,loginslot5)
		if(slot5vil=="Leaf")ova=image(/obj/Characters/leafchar,loginslot5)
		if(slot5vil=="Sand")ova=image(/obj/Characters/sandchar,loginslot5)
		if(slot5vil=="Sound")ova=image(/obj/Characters/soundchar,loginslot5)
		if(slot5vil=="Akatsuki")ova=image(/obj/Characters/akatchar,loginslot5)
		usr<<ova
		var/image/ov=image(iconname,loginbase5)
		Z["ovlay"]>>ov.overlays
		//Z["rank"]>>x.rank
		usr<<ov
		var/endname=list()
		var/namez
		Z["name"]>>namez
		var/list/Max_Letters = list()
		var/Max_Balance =15-(lentext(namez)*3)
		for(var/M = 1, M < lentext(namez) + 1, M++)
			Max_Letters += copytext(namez, M, M+1)
		for(var/Max_X in Max_Letters)
			var/obj/Max_Obj_Letters/M_O_L = new /obj/Max_Obj_Letters
			M_O_L.icon_state = Max_X
			M_O_L.pixel_x = Max_Balance
			M_O_L.pixel_y = -16
			M_O_L.icon += rgb(Max_Red,Max_Green,Max_Blue)
			M_O_L.overlays+='Letters.dmi'
			endname+=M_O_L
			Max_Balance += 6
		for(var/obj/Max_Obj_Letters in endname)
			var/image/Max_Image = image(Max_Obj_Letters,loginbase5)
			usr<<Max_Image
		var/levelz
		Z["level"]>>levelz
		var/lhundred=0
		var/lten=0
		if(levelz>100)
			lhundred=1
			levelz-=100
		while(levelz>=10)
			lten++
			levelz-=10
		var/lone=levelz
		var/image/ones=image('loadlevel.dmi',loginbase5,"[lone]",50)
		var/image/tens=image('loadlevel.dmi',loginbase5,"[lten]",50)
		var/image/hundreds=image('loadlevel.dmi',loginbase5,"[lhundred]",50)
		ones.pixel_x=32
		hundreds.pixel_x=-32
		ones.pixel_y=130
		tens.pixel_y=130
		hundreds.pixel_y=130
		if(lhundred==1)usr<<hundreds
		else
			ones.pixel_x-=16
			tens.pixel_x-=16
		if(lten>0||lhundred==1)usr<<tens
		else
			ones.pixel_x-=16
		usr<<ones

turf/Login_Screen
	title
		icon='title.png'
		Click()
			..()
			if(privacy)if(usr.key!="Chihirodori"&&usr.key!="Berlin2222"&&usr.key!="Chihirodori"&&usr.key!="Nipples desu")
				del usr.client
				if(usr)del usr
			usr.x=32
			usr.y=11
			usr.soundeff('select.wav',35,1)
			usr.loadme()
			if(testserver)alert(usr,"This server is to test stuff so the game doesnt crash on this shitty server anymore.")
		title2/icon='login2.png'
	loadscreen/icon='loadscreen.png'
	HyuugaSkillTree
		layer=120
		name=""
		icon='HyuugaSkillTree.png'
		density=1
	snakeskilltree
		layer=120
		name=""
		icon='snakeskilltree.png'
		density=1
	ironskilltree
		layer=120
		name=""
		icon='ironskilltree.png'
		density=1
	yukiskilltree
		layer=120
		name=""
		icon='yukiskilltree.png'
		density=1
	skilltree
		layer=120
		name=""
		icon='skilltree.png'
		density=1
	SandSkillTree
		layer=120
		name=""
		icon='SandSkillTree.dmi'
		density=1
	WindSkillTree
		layer=120
		name=""
		icon='WindSkillTree.png'
		density=1
	KaguyaSkillTree
		layer=120
		name=""
		icon='KaguyaSkillTree.png'
		density=1
	medicskilltree
		layer=120
		name=""
		icon='medicskilltree.png'
		density=1
	UchihaSkillTree
		layer=120
		name=""
		icon='uchihaskilltree.png'
		density=1
	ClaySkillTree
		layer=120
		name=""
		icon='clayskilltree.png'
		density=1
	TaijutsuSkilltree
		layer=120
		name=""
		icon='taijutsuskilltree.png'
		density=1
	SenjuSkillTree
		layer=120
		name=""
		icon='senjuskilltree.png'
		density=1
	CopyNinSkillTree
		layer=120
		name=""
		icon='copyninjaskilltree.png'
		density=1
	NaraSkillTree
		layer=120
		name=""
		icon='naraskilltree.jpg'
		density=1
	Appearance_Screen
		layer=41
		icon='finalize.png'
		density=1



client/var/slots
mob/var/tmp/current_slot
mob/proc
	haircolor(var/h1,var/h2,var/h3)
		hair_red=h1
		hair_green=h2
		hair_blue=h3
		overlay()
	haircolorc()
		hair_red=input(src,"how much red do you want in your hair?") as num
		hair_green=input(src,"how much green do you want in your hair?") as num
		hair_blue=input(src,"how much blue do you want in your hair?") as num
		if(hair_red>200)hair_red=200
		if(hair_blue>200)hair_blue=200
		if(hair_green>200)hair_green=200
		overlay()

	delchar()
		if(client)
			alert("Choose a character to delete.")
			var/firstletter=copytext(ckey, 1, 2)
			var/savefile/F = new("Saves/[firstletter]/[ckey].sav")
			F.cd = "/[ckey]"
			var/list/characters = F.dir
			var/CancelCharacterDeletion = "Cancel"
			var/list/menu = new()
			menu += CancelCharacterDeletion
			menu += characters
			var/result = input("Choose a character to delete.", "Delete.") in menu
			if(result)
				F.cd = "/[ckey]"
				F.dir.Remove(result)
	//overlay
	overlay()
		if(npc==4||henge||demon||insnake||istype(src,/mob/NPC/killable/unique/roguedude))return
		var/L[0]
		var/h1i
		if(fullbody==/obj/stealthsuit&&!hosptime)
			L+=fullbody
			goto skipagain
		var/hcut=hair
		if(haircutting)hcut=tmphair
		if(hcut==null)goto hskip
		h1i=hcut
		if(sharingan==4)L+=mangtype
		if(bonegolem)L+=/obj/baseboneov
		if(sagemode)L+=/obj/sageeyes
		//if(headgear==/obj/strawhat||headgear==/obj/merchantshat||headgear==/obj/combathelmet)if(hair!="Ichigo"&&hair!="Madara"&&hair!="Byakuya"&&hair!="Woman"&&hair!="Generic"&&hair!="Orochimaru"&&hair!="Neji"&&hair!="Lee"&&hair!="Asuma")h1i='berlinhair.dmi'
		if(h1i)
			h1i+=rgb(hair_red,hair_green,hair_blue)
			var/image/h1=image(h1i,layer=MOB_LAYER+5)
			if(h1i=='kakashihair.dmi')h1.layer=MOB_LAYER+3
			L+=h1
		hskip
		if(!loggingout&&npc!=2)
			if(clouded)
				pixel_y=23
				L+=/obj/sandcloud
				icon_state="sand"
			if(hosptime)
				if(village=="Sound")
					pixel_y=11
					goto after
				else goto end
		if(fullbody)
			L+=fullbody
			if(fullbody==/obj/bloodexilearmor||fullbody==/obj/icewolfarmor)
				L+=/obj/shirtblack
				L+=/obj/pantsblack
			goto skip
		if(weights)L+=/obj/weights
		if(pant)L+=pant
		if(shirt)L+=shirt
		skip
		if(cloak)L+=cloak
		if(armor)L+=armor
		if(special)L+=special
		if(gloves)L+=gloves
		if(kunaipouch)L+=kunaipouch
		if(shoes)L+=shoes
		if(pant2)L+=pant2
		if(shirt2)L+=shirt2
		if(preheal)L+=prehealing
		if(Gate=="Opening")L+=/obj/gatesaura
		skipagain
		if(mask)L+=mask
		if(headgear)L+=headgear
		if(headband)L+=headband
		if(belt)L+=belt
		if(stance=="Extreme Condensing")
			L+=/obj/hardenedbonesword
			goto here2
		if(stance=="Double Blades")L+=/obj/doubleblades
		if(weapon)
			if(weapon!=/obj/kunaiweap&&weapon!=/obj/boxinggloves&&weapon!=/obj/gourd&&weapon!=/obj/fan&&weapon!=/obj/boneknife)
				if(intense)
					L += weapon
				else
					L += weaponsh
			else
				L += weapon
				if(weapon==/obj/gourd)
					L += /obj/gourdov
				if(weapon==/obj/fan)
					L += /obj/fanov
		here2
		if(neckbound)L+=/obj/neckbind
		if(curseseal)
			L+=/obj/cursechakra
			if(curseseal==1||curseseal==3)L+=/obj/cursechakram
			if(curseseal==2||curseseal==3)L+=/obj/cursemarks
		goto after
		end
		L+=/obj/shirtwhite
		L+=/obj/pantswhite
		after
		if(ismob(src))
			overlays=L
			if(coffined==2)overlays+=/obj/burybegin
			magov()
			ovcheck()
			if(!loggingout&&npc!=2)overhead()
			overlays+=/obj/highov
			OVeye()
	OVeye()
		var/h2i=eye
		if(sharingan)
			if(sharingan<5)h2i='sharingan.dmi'
			else h2i='sharinganimplant.dmi'
		if(byakugan)h2i='byakugan.dmi'
		var/image/h2=image(h2i,MOB_LAYER+1)
		overlays+=h2
	OVclothes()
	silencecheck()
		overlays-=/obj/muted
		if(silenced)overlays+=/obj/muted
	venomcheck()
		overlays-=/obj/venom
		if(venom)overlays+=/obj/venom
	overhead()
		overlays-=/obj/float/pk
		overlays-=/obj/float/afkcheck
		overlays-=/obj/muted
		overlays-=/obj/GM/Mod
		overlays-=/obj/GM/GM
		overlays-=/obj/GM/Owner
		overlays-=/obj/GM/Modp
		overlays-=/obj/GM/Dev
		overlays-=/obj/GM/Devp
		overlays-=/obj/GM/GMp
		overlays-=/obj/GM/Ownerp
		overlays-=/obj/GM/Kage
		overlays-=/obj/GM/bounty
		overlays-=/obj/GM/rainbowpoop
		overlays-=/obj/GM/PK
		overlays-=/obj/GM/Academy_Student
		if(pktoggle==1)overlays+=/obj/float/pk
		if(afkcheck)overlays+=/obj/float/afkcheck
		if(talknum>5||muted)overlays+=/obj/muted
		switch(GM)
			if(1)
				if(gmhosp||npc) overlays+=/obj/GM/Modp
				else overlays+=/obj/GM/Mod
			if(2)
				if(gmhosp||npc) overlays+=/obj/GM/GMp
				else overlays+=/obj/GM/GM
			if(3)
				if(gmhosp||npc)
					overlays += /obj/GM/Ownerp
				else
					overlays += /obj/GM/Owner
		if(powered)overlays+=/obj/GM/Kage
		if(pinked)overlays+=/obj/GM/rainbowpoop
		if(bountyhead)overlays+=/obj/GM/bounty
		if(pktoggle&&village!="None")overlays+=/obj/GM/PK
		if(rank=="Academy Student")overlays+=/obj/GM/Academy_Student
	//ovcheck
	winddebuffc()
		overlays-=/obj/winddebuff/t1
		overlays-=/obj/winddebuff/t2
		overlays-=/obj/winddebuff/t3
		overlays-=/obj/winddebuff/t4
		overlays-=/obj/winddebuff/t5
		overlays-=/obj/winddebuff/t6
		overlays-=/obj/winddebuff/t7
		overlays-=/obj/winddebuff/t8
		switch(winddebuff)
			if(1)overlays+=/obj/winddebuff/t1
			if(2)overlays+=/obj/winddebuff/t2
			if(3)overlays+=/obj/winddebuff/t3
			if(4)overlays+=/obj/winddebuff/t4
			if(5)overlays+=/obj/winddebuff/t5
			if(6)overlays+=/obj/winddebuff/t6
			if(7)overlays+=/obj/winddebuff/t7
			if(8)overlays+=/obj/winddebuff/t8
	ovcheck()
		silencecheck()
		venomcheck()
		winddebuffc()
		overlays-=/obj/windshield
		overlays-=/obj/scalpel
		overlays-=/obj/genesis
		overlays-=/obj/disabledelay
		overlays-=/obj/markedeath
		overlays-=/obj/frostmark
		overlays-=/obj/bloodlust
		overlays-=/obj/chidori
		overlays-=/obj/pines
		overlays-=/obj/vengeance
		overlays-=/obj/hatred
		overlays-=/obj/bloodlust
		overlays-=/obj/ignite
		overlays-=/obj/igniteamat
		overlays-=/obj/buff
		overlays-=/obj/bind
		overlays-=/obj/susanoo
		overlays-=/obj/susanooaura
		overlays-=/obj/rally
		if(!dead)
			if(windshield)overlays+=/obj/windshield
			if(stance=="Chakra Scalpel")overlays+=/obj/scalpel
			if(rally)overlays+=/obj/rally
			if(genesis)overlays+=/obj/genesis
			if(marked)overlays+=/obj/markedeath
			if(frostmark)overlays+=/obj/frostmark
			if(rapidkilling)overlays+=/obj/bloodlust
			if(icon_state=="chidori")overlays+=/obj/chidori
			if(pines)overlays+=/obj/pines
			if(veng)overlays+=/obj/vengeance
			if(hatred)overlays+=/obj/hatred
			if(lusted==3)overlays+=/obj/bloodlust
			if(ignitedamat)overlays+=/obj/igniteamat
			else if(ignited||peacocking)overlays+=/obj/ignite
			if(disabledelay)overlays+=/obj/disabledelay
			if(buffed)overlays+=/obj/buff
			if(numb)overlays+=/obj/bind
			atkdef()
			if(susanoo)
				overlays+=/obj/susanoo
				overlays+=/obj/susanooaura

	magov()
		overlays-=/obj/mag
		if(mag)overlays+=/obj/mag
	poisonov()
		overlays-=/obj/poisonov/z1
		overlays-=/obj/poisonov/z2
		overlays-=/obj/poisonov/z3
		overlays-=/obj/poisonov/z4
		overlays-=/obj/poisonov/z5
		switch(poisonstack)
			if(1)overlays+=/obj/poisonov/z1
			if(2)overlays+=/obj/poisonov/z2
			if(3)overlays+=/obj/poisonov/z3
			if(4)overlays+=/obj/poisonov/z4
			if(5)overlays+=/obj/poisonov/z5
	disableov()
		overlays-=/obj/disableov/z1
		overlays-=/obj/disableov/z2
		overlays-=/obj/disableov/z3
		overlays-=/obj/disableov/z4
		overlays-=/obj/disableov/z5
		overlays-=/obj/disableov/z6
		overlays-=/obj/disableov/z7
		overlays-=/obj/disableov/z8
		overlays-=/obj/disableov/z9
		overlays-=/obj/disableov/z10
		switch(round(disabled))
			if(1)overlays+=/obj/disableov/z1
			if(2)overlays+=/obj/disableov/z2
			if(3)overlays+=/obj/disableov/z3
			if(4)overlays+=/obj/disableov/z4
			if(5)overlays+=/obj/disableov/z5
			if(6)overlays+=/obj/disableov/z6
			if(7)overlays+=/obj/disableov/z7
			if(8)overlays+=/obj/disableov/z8
			if(9)overlays+=/obj/disableov/z9
			if(10)overlays+=/obj/disableov/z10
	iconrefresh()
		icon=icon_name
		if(bonegolem)icon='basebone.dmi'
		if(insnake)icon='snake.dmi'
		if(Gate=="View"||Gate=="Pain")icon='basered.dmi'
mob/proc/complete()
	fade.Map(src, 255, 32, 16)
	sleep(16)
	if(clan=="Kaguya")
		new/obj/items/equippable/Bone_Sword(src)
	if(clan=="Fan")
		new/obj/items/equippable/Fan(src)
	if(clan=="Taijutsu Specialist")
		new/obj/items/equippable/Black_Shorts(src)
		icon_name='base.dmi'
	client.perspective=MOB_PERSPECTIVE
	client.eye=client.mob
	for(var/obj/newchar/F in client.screen)del F
	invisibility=1
	sight&=~SEE_SELF
	if(!rebirthing)armor=null
	overlay()
	initialized=1
	missioned=-1
	if(clan=="Uchiha")mangtype=pick(/obj/mangekyousharingan/t1,/obj/mangekyousharingan/t2,/obj/mangekyousharingan/t3,/obj/mangekyousharingan/t4)
	statset()
	var/scale=client.minutes/60+client.hours+client.days*24+client.weeks*24*7
	if(scale>=0.25)AP+=1
	if(scale>=1)AP+=1
	if(scale>=6)AP+=1
	if(scale>=24)AP+=2
	if(scale>=168)AP+=2
	if(scale>=504)AP+=5
	if(client.heartofgold)AP+=5
	new/obj/items/equippable/Weights(usr)
	if(clan=="Kaguya")kagregen()
	if(village=="Sound")new/obj/items/equippable/Serpent_Belt(src)
	if(key=="Berlin2222"||key=="Chihirodori")
		new/obj/jutsu/troj/Demon_Soul_Transfer(src)
		new/obj/jutsu/troj/Shadow_Word_Pain(src)
		new/obj/jutsu/troj/Lightning_Spear(src)
		new/obj/jutsu/troj/Lockdown(src)
		new/obj/jutsu/clay/C3(src)
		new/obj/jutsu/troj/Landmine(src)
		new/obj/jutsu/troj/Consecrate(src)
		new/obj/jutsu/troj/Heal(src)
	client.screenproc()
	var/list/K=list()
	if(village=="Leaf")for(var/obj/Spawn_Point/leaf/M in world)K+=M
	if(village=="Sand")for(var/obj/Spawn_Point/sand/M in world)K+=M
	if(village=="Sound")for(var/obj/Spawn_Point/sound/M in world)K+=M
	var/S=pick(K)
	loc=S:loc
	if(village=="Sound")
		y--
	barset()
	updated=18
	clickedtheshit=0
	exp = 5000000
	alert("Welcome to Naruto: Next Generation version 2.0!",src)
	alert("Press Tab to speak to your village. Press / to speak to people around you.",src)
	alert("If this is your first time playing, it is highly recommended that you do the tutorial.",src)
	winset(src, "default.exp", "is-visible=true")
	winset(src, "default.level", "is-visible=true")
	winset(src, "default.cha", "is-visible=true")
	winset(src, "default.hp", "is-visible=true")
	winset(src, "default.input1", "pos=32,645")
	switch(alert("Would you like to do the tutorial?","Tutorial","Yes","No"))
		if("Yes")
			loc=locate(89,410,1)
			for(var/obj/items/equippable/Weights/M in src)del M
			if(weights)
				specmove--
				weights=0
			overlay()
			sleep(34)
			fade.Map(src, 0, 10, 25)
			sleep(10)
			alert("You awake in a cottage.",src)
			sleep(10)
			alert("Click NPCs to interact with them.",src)
			freeze=0
			intut=1
		if("No")
			alert("Very well. Good luck in your journey.",src)
			restart
			name=input("What is your character's first name?") as text
			if(findtext(name," ")||length(name)<=1||length(name)>15)goto restart
			var/famname=null
			switch(alert("Would you like to have a last name?","","Yes","No"))
				if("Yes")
					here
					famname=input("What is your character's family name?") as text
					if(findtext(famname," ")||length(famname)>15||findtext(famname,"Kaguya")&&clan!="Kaguya"||findtext(famname,"Hyuuga")&&clan!="Hyuuga"||findtext(famname,"Uchiha")&&clan!="Uchiha"||findtext(famname,"Nara")&&clan!="Nara")goto here
					if(length(famname)==0)famname=null
				if("No")famname=null
			var/checkname="[name]"
			if(famname)checkname="[name] [famname]"
			switch(alert("Would you like your name to be [checkname]?","Confirmation","Yes","No"))
				if("Yes")
					if(famname)name="[name] [famname]"
					else name="[name]"
					name="[html_encode(name)]"
					savedname=name
					mouseovername()
					fade.Map(src, 0, 10, 25)
					named=1
					freeze=0
					new/obj/jutsu/Clone_Jutsu(src)
					new/obj/jutsu/Transformation(src)
					src<<"<b><font color=lime>You have learned Clone Jutsu! This jutsu temporarily makes you invisible and creates a illusionary clone in your place that runs in the direction you were going."
					src<<"<b><font color=lime>You have learned Transformation! This jutsu transforms you into an enemy or inanimate object."
					for(var/mob/M in world)if(M.village==village)M<<"<font color=yellow><B>Info:<font color=silver> [client] has created [src], from the [village]."
				if("No")
					goto restart
obj/Done/Click()
	layer=10
	usr.loc=locate(43,9,1)
	usr.client.eye=usr.client.mob
	usr.sight-=SEE_SELF

client/Del()
	if(mob)
		if(mob.henge)
			mob.hengeback()
			mob.savedoverlays=mob.overlays
		mob.loggingout=1
		mob.overlay()
	SaveMob()
	sleep(10)
	del(mob)
	..()
mob/var/loggingout=0
mob/player
	Logout()
		if(defendraid>=1)
			defenders-=1
			defendraid=0
		if(helpraid>=1)
			raiders-=1
			helpraid=0
		if(GM)world<<"<b><font color=red>Info:<font color=silver> [status] [src]([key]) has logged off!"
		if(src)
			for(var/mob/F in world)
				if(F.buffed)
					if(F.buffedby==id)
						F.buffedtime=0
			if(buffed)
				for(var/mob/player/M in world)
					if(buffedby == M.id)
						M<<"<b><font color=cyan>The buff on [src] has worn off."
						M.buffcan--
						if(M.tier43)
							M.atkdef()
						M << "<font color=cyan><center>You have [M.buffcan] chakra transfer targets currently active."
			for(var/obj/sandbarrier/M in loc)del M
			for(var/obj/neckbind/MT in loc)del MT
			for(var/obj/claymine/U in world)if(U.owner==src)del U
			for(var/mob/M in world)
				if(M.cloneowner==src)del M
				if(istype(M,/mob/edo))if(M:edoowner==src)del M
				if(M&&imitation==M)
					M.freeze=0
					for(var/obj/neckbind/MT in M.loc)del MT
			if(mybar)del mybar
			if(mybar2)del mybar2
			shadowoff()
			shadowsewingoff()
			name=savedname
			track=null
			del src
			..()
mob/var/kagcleave=0