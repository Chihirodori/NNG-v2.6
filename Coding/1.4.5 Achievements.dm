
mob/proc
	medal(var/lvl,var/vicon)
		vicon="[vicon]"
		if(!client)return
		if(AP==0)
			src<<"<b><center>You have received a Achievement Point. You unlock titles for your character with AP. You may change your title at Iron village."
		var/apgain=1
		switch(lvl)
			if(2)apgain=2
			if(3)apgain=5
		AP+=apgain
		if(lvl==3)world<<"<font color=yellow><b>Achievement Info: [src] has earned a legendary achievement!"
		src<<"<b><center>You have gained [apgain] AP. ([AP])"
		var/F
		switch(lvl)
			if(1)F=new/obj/ach/achievebar1()
			if(2)F=new/obj/ach/achievebar2()
			if(3)F=new/obj/ach/achievebar3()
		client.screen+=F
		spawn(4)
			var/G=new/obj/achieve()
			client.screen+=G
			switch(lvl)
				if(2)G:icon='achieve2.dmi'
				if(3)G:icon='achieve3.dmi'
			G:icon_state="[vicon]"
obj/achievementhud
	icon='hudach.dmi'
	screen_loc="18:-10,1:5"
	layer=94
	Click()
		if(usr.achievementon)
			usr.achievementon=0
			for(var/obj/achmenu/F in usr.client.screen)del F
			for(var/obj/achb/F in usr.client.screen)del F
			for(var/obj/achs/F in usr.client.screen)del F
			for(var/obj/achg/F in usr.client.screen)del F
		else
			usr.achievementon=1
			usr.client.screen+=new/obj/achmenu
			if(usr.level>=120)usr.client.screen+=new/obj/achg/g6
			if(usr.level>=110)usr.client.screen+=new/obj/achs/s4
			if(usr.level>=90)usr.client.screen+=new/obj/achs/s2
			if(usr.level>=100)usr.client.screen+=new/obj/achs/s3
			if(usr.level>=70)usr.client.screen+=new/obj/achb/b7
			if(usr.level>=80)usr.client.screen+=new/obj/achs/s1
			if(usr.level>=10)usr.client.screen+=new/obj/achb/b1
			if(usr.level>=20)usr.client.screen+=new/obj/achb/b2
			if(usr.level>=30)usr.client.screen+=new/obj/achb/b3
			if(usr.level>=40)usr.client.screen+=new/obj/achb/b4
			if(usr.level>=50)usr.client.screen+=new/obj/achb/b5
			if(usr.level>=60)usr.client.screen+=new/obj/achb/b6
			var/scale=usr.client.minutes/60+usr.client.hours+usr.client.days*24+usr.client.weeks*24*7
			if(usr.client.heartofgold)usr.client.screen+=new/obj/achg/g3
			if(scale>=0.25)usr.client.screen+=new/obj/achb/b8
			if(scale>=1)usr.client.screen+=new/obj/achb/b9
			if(scale>=6)usr.client.screen+=new/obj/achb/b10
			if(scale>=24)usr.client.screen+=new/obj/achs/s6
			if(scale>=168)usr.client.screen+=new/obj/achs/s7
			if(scale>=504)usr.client.screen+=new/obj/achg/g4
			if(usr.bountykills>=1)usr.client.screen+=new/obj/achb/b11
			if(usr.bountykills>=10)usr.client.screen+=new/obj/achb/b12
			if(usr.bountykills>=50)usr.client.screen+=new/obj/achs/s16
			if(usr.bountykills>=500)usr.client.screen+=new/obj/achg/g8
			if(usr.flagcapture>=1)usr.client.screen+=new/obj/achb/b17
			if(usr.flagcapture>=50)usr.client.screen+=new/obj/achs/s8
			if(usr.flagcapture>=1000)usr.client.screen+=new/obj/achg/g5
			var/missiontot=usr.mranka+usr.mrankb+usr.mrankc+usr.mrankd+usr.mranks
			if(missiontot>=1)usr.client.screen+=new/obj/achb/b19
			if(missiontot>=100)usr.client.screen+=new/obj/achs/s17
			if(missiontot>=1000)usr.client.screen+=new/obj/achg/g9
			if(usr.teabag)usr.client.screen+=new/obj/achb/b24
			if(usr.goldenagetrig)usr.client.screen+=new/obj/achb/b20
			if(usr.deerkill>=1000)usr.client.screen+=new/obj/achb/b21
			if(usr.boarkill>=1000)usr.client.screen+=new/obj/achb/b22
			if(usr.tourneypart)usr.client.screen+=new/obj/achb/b23
			if(usr.tourneywin)usr.client.screen+=new/obj/achs/s19
			if(usr.kagekill)usr.client.screen+=new/obj/achs/s14
			if(usr.rep30)usr.client.screen+=new/obj/achs/s10
			if(usr.respecced)usr.client.screen+=new/obj/achs/s9
			if(usr.punchamount>=5000)usr.client.screen+=new/obj/achs/s18
			if(usr.rankup>=1)usr.client.screen+=new/obj/achb/b13
			if(usr.rankup>=2)usr.client.screen+=new/obj/achb/b18
			if(usr.rankup>=3)usr.client.screen+=new/obj/achs/s5
			if(usr.rankup>=4)usr.client.screen+=new/obj/achs/s15
			if(usr.rankup>=5)usr.client.screen+=new/obj/achg/g7
			if(usr.kills>=1)usr.client.screen+=new/obj/achb/b15
			if(usr.kills>=50)usr.client.screen+=new/obj/achb/b16
			if(usr.kills>=200)usr.client.screen+=new/obj/achs/s12
			if(usr.kills>=1000)usr.client.screen+=new/obj/achs/s13
			if(usr.kills>=5000)usr.client.screen+=new/obj/achg/g1
obj/achmenu
	icon='achievements.png'
	layer=120
	screen_loc="5,10"
obj/achb
	layer=121
	icon='achieve.dmi'
	b1
		icon_state="1"
		screen_loc="6,16"
	b2
		icon_state="2"
		screen_loc="7,16"
	b3
		icon_state="3"
		screen_loc="8,16"
	b4
		icon_state="4"
		screen_loc="9,16"
	b5
		icon_state="5"
		screen_loc="10,16"
	b6
		icon_state="6"
		screen_loc="11,16"
	b7
		icon_state="7"
		screen_loc="12,16"
	b8
		icon_state="8"
		screen_loc="13,16"
	b9
		icon_state="9"
		screen_loc="14,16"
	b10
		icon_state="10"
		screen_loc="15,16"
	b11
		icon_state="11"
		screen_loc="16,16"
	b12
		icon_state="12"
		screen_loc="6,15"
	b13
		icon_state="13"
		screen_loc="7,15"
	b14
		icon_state="14"
		screen_loc="8,15"
	b15
		icon_state="15"
		screen_loc="9,15"
	b16
		icon_state="16"
		screen_loc="10,15"
	b17
		icon_state="17"
		screen_loc="11,15"
	b18
		icon_state="18"
		screen_loc="12,15"
	b19
		icon_state="19"
		screen_loc="13,15"
	b20
		icon_state="20"
		screen_loc="14,15"
	b21
		icon_state="21"
		screen_loc="15,15"
	b22
		icon_state="22"
		screen_loc="16,15"
	b23
		icon_state="23"
		screen_loc="7,14"
	b24
		icon_state="24"
		screen_loc="8,14"
obj/achs
	layer=121
	icon='achieve2.dmi'
	s1
		icon_state="1"
		screen_loc="6,13"
	s2
		icon_state="2"
		screen_loc="7,13"
	s3
		icon_state="3"
		screen_loc="8,13"
	s4
		icon_state="4"
		screen_loc="9,13"
	s5
		icon_state="5"
		screen_loc="10,13"
	s6
		icon_state="6"
		screen_loc="11,13"
	s7
		icon_state="7"
		screen_loc="12,13"
	s8
		icon_state="8"
		screen_loc="13,13"
	s9
		icon_state="9"
		screen_loc="14,13"
	s10
		icon_state="10"
		screen_loc="15,13"
	s11
		icon_state="11"
		screen_loc="16,13"
	s12
		icon_state="12"
		screen_loc="6,12"
	s13
		icon_state="13"
		screen_loc="7,12"
	s14
		icon_state="14"
		screen_loc="8,12"
	s15
		icon_state="15"
		screen_loc="9,12"
	s16
		icon_state="16"
		screen_loc="10,12"
	s17
		icon_state="17"
		screen_loc="11,12"
	s18
		icon_state="18"
		screen_loc="12,12"
	s19
		icon_state="19"
		screen_loc="13,12"
obj/achg
	layer=121
	icon='achieve3.dmi'
	g1
		icon_state="1"
		screen_loc="6,11"
	g2
		icon_state="2"
		screen_loc="7,11"
	g3
		icon_state="3"
		screen_loc="8,11"
	g4
		icon_state="4"
		screen_loc="9,11"
	g5
		icon_state="5"
		screen_loc="10,11"
	g6
		icon_state="6"
		screen_loc="11,11"
	g7
		icon_state="7"
		screen_loc="12,11"
	g8
		icon_state="8"
		screen_loc="13,11"
	g9
		icon_state="9"
		screen_loc="14,11"
mob/var
	achievementon=0
	teabag=0
	goldenagetrig=0
	deerkill=0
	boarkill=0
	tourneypart=0
	tourneywin=0
	kagekill=0
	rep30=0
	respecced=0
	punchamount=0
	rankup=0
	AP=0