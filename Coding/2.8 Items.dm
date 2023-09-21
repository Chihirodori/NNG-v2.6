obj/ryo
	name="Senryo"
	icon='items.dmi'
	icon_state="Ryo1"
	var/dropping=0
	var/dropped=0
	mouse_opacity=2
	var/ryoamount=0
	proc
		ryofresh()
			name="[realnum(ryoamount)] Senryo"
			icon_state="Ryo1"
			if(ryoamount>=5)icon_state="Ryo2"
			if(ryoamount>=10)icon_state="Ryo3"
			if(ryoamount>=25)icon_state="Ryo4"
			if(ryoamount>=50)icon_state="Ryo5"
			if(ryoamount>=100)icon_state="Ryo6"
	Click()
		if(dropped)
			for(var/obj/sentag/M in loc)del M
			for(var/mob/M in view(1))if(M==usr)
				usr<<"You picked up [src]."
				usr.senryo+=ryoamount
				usr.ryorefresh()
				del src
		..()
	MouseDrag()if(loc==usr)mouse_drag_pointer=src
	MouseDrop(obj/overobject,srclocation,overlocation)
		if(loc==usr)
			if(usr.rank=="Academy Student")
				usr<<"<b>You should hold on to your senryo until you're a Genin."
				return
			if(isturf(overobject))
				if(dropping)return
				dropping=1
				var/T=input(usr,"How much ryo do you want to drop?(Max [usr.senryo])") as num
				dropping=0
				T=round(T)
				if(T>usr.senryo)
					alert(usr,"You don't have that much senryo.")
					return
				if(T<=0)return
				var/E=new/obj/ryo(usr.loc)
				E:ryoamount=T
				E:dropped=1
				E:ryofresh()
				usr.senryo-=T
				usr.ryorefresh()
				E:countdown()
				return
obj/sentag
	layer=10
obj/proc
	countdown()
		var/time=10
		var/E=new/obj/sentag(loc)
		E:pixel_x=10
		E:pixel_y=32
		while(time)
			E:maptext="<b>[time]"
			time--
			sleep(10)
			if(!time)
				del E
				del src

mob/proc
	ryorefresh()
		for(var/obj/ryo/M in src)
			M.name="[realnum(senryo)] Senryo"
			M.icon_state="Ryo1"
			if(senryo>=5)M.icon_state="Ryo2"
			if(senryo>=10)M.icon_state="Ryo3"
			if(senryo>=25)M.icon_state="Ryo4"
			if(senryo>=50)M.icon_state="Ryo5"
			if(senryo>=100)M.icon_state="Ryo6"
obj/usable
	icon='items.dmi'
	var/dropping=0
	var/dropped=0
	var/bombamount=1
	Click()
		if(dropped)
			for(var/mob/M in view(1))if(M==usr)
				if(istype(src,/obj/usable/Smoke_Bomb))
					if(bombamount==1)usr<<"You picked up a smoke bomb."
					else usr<<"You picked up [bombamount] [src]s."
					if(usr.smokeamount==0)
						loc=usr
						usr.smokeamount+=bombamount
					else
						usr.smokeamount+=bombamount
						del src
					return
				loc=usr
				usr<<"You picked up a [src]."
				dropped=0
			return
		else
			..()
	MouseDrag()
		if(loc==usr)mouse_drag_pointer=src
	MouseDrop(obj/overobject,srclocation,overlocation)
		if(loc==usr)
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
				if(overobject.icon_state=="1")usr.slot1=name
				if(overobject.icon_state=="2")usr.slot2=name
				if(overobject.icon_state=="3")usr.slot3=name
				if(overobject.icon_state=="4")usr.slot4=name
				if(overobject.icon_state=="5")usr.slot5=name
				if(overobject.icon_state=="6")usr.slot6=name
				if(overobject.icon_state=="7")usr.slot7=name
				if(overobject.icon_state=="8")usr.slot8=name
				if(overobject.icon_state=="9")usr.slot9=name
				if(overobject.icon_state=="10")usr.slot10=name
				if(overobject.icon_state=="11")usr.slot11=name
				if(overobject.icon_state=="12")usr.slot12=name
				if(overobject.icon_state=="13")usr.slot13=name
				if(overobject.icon_state=="14")usr.slot14=name
				if(overobject.icon_state=="15")usr.slot15=name
				if(overobject.icon_state=="16")usr.slot16=name
				layer=overobject.layer+2
				return
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
			if(isturf(overobject))
				if(istype(src,/obj/usable/Radio)||istype(src,/obj/usable/Bingo_Book))return
				if(istype(src,/obj/usable/Heaven_Scroll)||istype(src,/obj/usable/Earth_Scroll))
					loc=locate(usr.x,usr.y,usr.z)
					dropped=1
					if(usr.inchunin)
						if(usr.village=="Leaf")usr.loc=locate(291,389,1)
						if(usr.village=="Sand")usr.loc=locate(138,191,1)
						if(usr.village=="Sound")usr.loc=locate(343,89,1)
						usr.inchunin=0
						usr<<"<b>You have failed the Chunin exam!"
						usr.pktoggle=0
						usr.affcheck()
					return
				if(istype(src,/obj/usable/Smoke_Bomb))
					if(dropping)return
					dropping=1
					var/T=input(usr,"How many smoke bombs do you want to discard?(You have [usr.smokeamount])") as num
					dropping=0
					if(T>usr.smokeamount)
						alert(usr,"You don't have that many to discard.")
						return
					if(T<=0)return
					usr.smokeamount-=T
					if(usr.smokeamount<=0)for(var/obj/usable/Smoke_Bomb/M in usr)del M
					return
				if(istype(src,/obj/usable/Fire_Bomb))
					if(dropping)return
					dropping=1
					var/T=input(usr,"How many fire bombs do you want to discard?(You have [usr.fireamount])") as num
					dropping=0
					if(T>usr.fireamount)
						alert(usr,"You don't have that many to discard.")
						return
					if(T<=0)return
					usr.fireamount-=T
					if(usr.fireamount<=0)for(var/obj/usable/Fire_Bomb/M in usr)del M
					return
				if(istype(src,/obj/usable/Bee_Killing_Blaze_Bomb))return
				loc=locate(usr.x,usr.y,usr.z)
				dropped=1
	Heaven_Scroll
		icon_state="Heaven Scroll"
		layer=70
		var/t=0
		Click()
			if(t==0)return
			loc=locate(usr.x,usr.y,usr.z)
			t=0
			usr<<"<b>You got poisoned!"
			fade.MapLayer(usr,255)
			fade.Map(usr, 255, 55, 5)
			sleep(5)
			usr.summonspawn()
			usr.inchunin=0
			usr.pktoggle=0
			usr.affcheck()
			usr<<"<b>You have failed the Chunin exam!"
			fade.Map(usr, 0, 1, 100)
		verb
			Drop()
				loc=locate(usr.x,usr.y,usr.z)
				if(usr.inchunin)
					usr.summonspawn()
					usr.inchunin=0
					usr.pktoggle=0
					usr.affcheck()
					t=0
					usr<<"<b>You have failed the Chunin exam!"
			Pick_Up()
				set src in oview(1)
				for(var/obj/usable/Heaven_Scroll/M in usr)return
				loc=usr
				usr.soundeff('scroll.wav',100,1)
				t=1
				usr<<"You picked up a [src]."
	Chakra_Tracker
		icon='items.dmi'
		icon_state="Advanced Tracker"
		Click()
			usr.advancedtracker(usr.track)
		verb
			Set_Tracker()
				var/list/choose=list()
				for(var/mob/player/M in world)if(M.client)choose.Add(M)
				var/cancel="Cancel"
				choose+=cancel
				var/mob/M=input("Who do you want to set your tracker to track?") as anything in choose
				if(M=="Cancel")return
				usr.track=M
				alert(usr,"You have set your tracker to [M].")
			Drop()loc=locate(usr.x,usr.y,usr.z)
			Pick_Up()
				set src in oview(1)
				loc=usr
				usr<<"You picked up a [src]."
	Bingo_Book
		icon='items.dmi'
		icon_state="Bingo Book"
		Click()
			usr.bingobook()
	Earth_Scroll
		icon_state="Earth Scroll"
		layer=70
		var/t=0
		Click()
			if(t==0)return
			loc=locate(usr.x,usr.y,usr.z)
			t=0
			usr<<"<b>You got poisoned!"
			fade.MapLayer(usr,255)
			fade.Map(usr, 255, 55, 5)
			sleep(5)
			usr.summonspawn()
			usr.inchunin=0
			usr.pktoggle=0
			usr.affcheck()
			usr<<"<b>You have failed the Chunin exam!"
			fade.Map(usr, 0, 1, 100)
		verb
			Drop()
				loc=locate(usr.x,usr.y,usr.z)
				if(usr.inchunin)
					usr.summonspawn()
					usr.inchunin=0
					t=0
					usr.pktoggle=0
					usr.affcheck()
					usr<<"<b>You have failed the Chunin exam!"
			Pick_Up()
				set src in oview(1)
				for(var/obj/usable/Earth_Scroll/M in usr)return
				loc=usr
				usr.soundeff('scroll.wav',100,1)
				t=1
				usr<<"You picked up a [src]."
	Radio
		icon_state="Radio"
		Click()usr.radio()
		verb
			Change_Channel()
				switch(alert(usr,"Which type of channel do you want your radio to set to?","Radio","Private Channel","Public Channel","Secret Channel"))
					if("Private Channel")
						var/list/choose=list()
						for(var/mob/player/M in world)for(var/obj/usable/Radio/G in M)choose.Add(M)
						var/cancel="Cancel"
						choose+=cancel
						var/mob/M=input("Who do you want to connect your radio to?") as null|anything in choose
						if(M=="Cancel")return
						if(M)
							usr.rchannel="[M.savedname]"
							alert(usr,"You have set your channel to [M]'s.")
					if("Public Channel")
						switch(alert(usr,"Which public channel do you want to set to?","Public Channel","Fire Fox","Trojan Horse","Cancel"))
							if("Fire Fox")
								alert(usr,"You have set your channel to Fire Fox.")
								usr.rchannel="Fire Fox"
							if("Trojan Horse")
								alert(usr,"You have set your channel to Trojan Horse.")
								usr.rchannel="Trojan Horse"
					if("Secret Channel")
						var/M=input("Which number do you want to set your channel to? (1-10000)") as num
						if(M<1||M>10000)return
						usr.rchannel="[M]"
						alert(usr,"You have set your channel to [M].")
			Destroy()
				usr.rchannel=null
				del src
	Smoke_Bomb
		icon_state="Smoke Bomb"
		Click()usr.smokebombthrow()
		verb
			Check_Amount()
				if(usr.smokeamount==1)usr<<"You have one smoke bomb."
				usr<<"You have [usr.smokeamount] smoke bombs."
	Fire_Bomb
		icon_state="Fire Bomb"
		Click()usr.firebombthrow()
		verb
			Check_Amount()
				if(usr.fireamount==1)usr<<"You have one fire bomb."
				usr<<"You have [usr.fireamount] fire bombs."
	Bee_Killing_Blaze_Bomb
		icon_state="Fire Bomb"
		Click()if(loc==usr)usr.blazebombthrow()
	Blood_Pill
		icon_state="Blood Pill"
		Click()usr.bloodpill(src)
		verb
			Drop()loc=locate(usr.x,usr.y,usr.z)
			Pick_Up()
				set src in oview(1)
				loc=usr
				usr<<"You picked up a [src]."
	Chakra_Pill
		icon_state="Chakra Pill"
		Click()usr.chakrapill(src)
		verb
			Drop()loc=locate(usr.x,usr.y,usr.z)
			Pick_Up()
				set src in oview(1)
				loc=usr
				usr<<"You picked up a [src]."
	Scroll_of_Secrets
		icon_state="Scroll of Secrets"
		suffix="Increase experience rate by 10x for 2 minutes."
		Click()
			if(usr.secretpower||usr.goldscroll)
				return
			usr<<"<font color=cyan><b>A wave of realization hits you. You have gained 1000% training rate for the next 2 minutes."
			usr.secretpower=120
			usr.client.screen+=new/obj/hudbuttons/superboost
			del src
		verb
			Pick_Up()
				set src in oview(1)
				loc=usr
				usr<<"You picked up a [src]."
	Scroll_of_Gold
		icon_state="Scroll of Gold"
		suffix="Increase experience rate by 500% for 6 minutes. Thank you for donating."
		Click()
			if(usr.secretpower||usr.goldscroll)
				return
			usr<<"<font color=yellow><b>You have gained 500% training rate for the next 6 minutes."
			usr.goldscroll=360
			usr.client.screen+=new/obj/hudbuttons/superboost
			del src
		verb
			Pick_Up()
				set src in oview(1)
				loc=usr
				usr<<"You picked up a [src]."
	Heros_Water
		name="Hero's Water"
		icon_state="Hero's Water"
		Click()
			usr.heroswater(src)
		verb
			Drop()loc=locate(usr.x,usr.y,usr.z)
			Pick_Up()
				set src in oview(1)
				loc=usr
				usr<<"You picked up a [src]."
mob/proc
	bingobook()
		usr<<"<font color=red><b><center><u>Bingo Book"
		usr<<"<font color=red><center>____________________________________"
		for(var/mob/player/M in world)
			if(M.client&&M.bountyhead)
				if(M.bountyannounce)
					usr<<"<font color=red><b>[realnum(M.bountyhead)]([M.bountytimes]) Ryo: [M]([M.key])<font color=white>([M.village])"
		for(var/mob/player/M in world)
			if(M.client&&M.bountyhead)
				if(!M.bountyannounce)
					usr<<"<font color=red>[realnum(M.bountyhead)]([M.bountytimes]) Ryo: [M]([M.key])<font color=white>([M.village])"
		usr<<"<font color=red><center>____________________________________"
		..()
	radio()
		if(rchannel==null)
			alert("You need to set your radio to a channel first.")
			return
		var/T=0
		for(var/mob/player/M in world)if(M.rchannel==rchannel||rchannel=="[M.savedname]")T++
		var/say=input("What would you like to say to your radio? ([T] in channel)") as text
		hengeback()
		if(talknum>5)
			alert("Please wait a little while before talking again!")
			return
		if(!GM&&muted)return
		if(findtext(say,"chink")||findtext(say,"nigga")||findtext(say,"nigger"))
			alert("Don't be racist.")
			return
		if(say=="")return
		if(length(say)>=300)
			usr<<"Your message is too long."
			usr<<"You tried to say [say]"
			return
		if(!usr)return
		if(talknum<5)
			talknum++
			spawn(13)if(usr)talknum--
		else
			talknum+=15
			spawn(200)if(usr)talknum-=20
		for(var/mob/player/M in world)
			if("[M.rchannel]"=="[rchannel]"||"[rchannel]"=="[M.savedname]")M<<"[src] radios: [html_encode(say)]"
			if(M.tapping)M<<"<u>[src]([rchannel]): [html_encode(say)]"
	chakrapill(var/o)
		if(usr.pill!=null)return
		usr<<"<b>You ate a chakra pill! Your chakra regeneration has been boosted by 150% for one minute!"
		usr.pill="chakra"
		regenupdate()
		if(o)o:loc=locate(0,0,0)
		spawn(840)
			usr.pill=null
			regenupdate()
			for(var/obj/usable/Chakra_Pill/M in client.screen)del M
			del o
	heroswater(var/o)
		if(usr.pill!="")return
		usr<<"<b>You drank from the hero's water! Your chakra regeneration has been boosted by 150% for three minutes!"
		usr.pill="hero"
		if(o)o:loc=locate(0,0,0)
		spawn(3000)
			usr.pill=null
			for(var/obj/usable/Heros_Water/M in client.screen)del M
			del o
	bloodpill(var/o)
		if(usr.pill!="")return
		usr<<"<b>You ate a blood pill! Your health regeneration has been boosted by 50% for one minute!"
		usr.pill="blood"
		regenupdate()
		if(o)o:loc=locate(0,0,0)
		spawn(840)
			usr.pill=null
			regenupdate()
			for(var/obj/usable/Blood_Pill/M in client.screen)del M
			del o
	zchakrapill(var/o)
		for(var/obj/usable/Chakra_Pill/M in src)
			if(usr.pill!=null)return
			usr<<"<b>You ate a chakra pill! Your chakra regeneration has been boosted by 150% for one minute!"
			usr.pill="chakra"
			regenupdate()
			if(o)o:loc=locate(0,0,0)
			spawn(840)
				usr.pill=null
				regenupdate()
			break
	zbloodpill(var/o)
		for(var/obj/usable/Blood_Pill/M in src)
			if(usr.pill!="")return
			usr<<"<b>You ate a blood pill! Your health regeneration has been boosted by 50% for one minute!"
			usr.pill="blood"
			regenupdate()
			if(o)o:loc=locate(0,0,0)
			spawn(840)
				usr.pill=null
				regenupdate()
			break
	smokebombthrow()
		if(smokeamount<=0||hosptime||jailtime||bombed||seals||dead||attacking||busy||freeze||stun||inchunin||ingenin)return
		if(smokeamount)smokeamount--
		bombed=1
		spawn(300)bombed=0
		if(usr.subinvis)
			usr.subinvis=0
		usr.invisibility+=10
		spawn(22)usr.invisibility-=10
		var/T=0
		loop
			if(T<100)
				T++
				new/obj/smokebomb(usr.loc)
				goto loop
		usr.stepback(5,2)
		if(smokeamount<=0)
			for(var/obj/usable/Smoke_Bomb/M in client.screen)del M
			for(var/obj/usable/Smoke_Bomb/M in src)del M
	advancedtracker()
		if(tracked)return
		if(track==null)
			usr<<"<b>You need to set a target first."
			return
		tracked=1
		for(var/obj/usable/Chakra_Tracker/Z in src)
			Z:icon_state="Dead Tracker"
			spawn(80)
				Z:icon_state="Advanced Tracker"
		spawn(80)tracked=0
		for(var/mob/player/M in world)
			if(M==track)
				var/F=new/obj/chakratarget(loc)
				var/image/I=image('chakratarget.dmi',F)
				usr<<I
				walk_towards(F,locate(M.x,M.y,z))
				break
	firebombthrow()
		if(seals||bombed||dead||attacking||busy||freeze||stun)return
		bombed=1
		spawn(200)bombed=0
		if(fireamount)fireamount--
		flick(usr,"attack")
		var/T=new/obj/firebomb(loc)
		T:owner=usr
		walk(T,dir)
		if(fireamount<=0)
			for(var/obj/usable/Fire_Bomb/M in client.screen)del M
			for(var/obj/usable/Fire_Bomb/M in src)del M
	blazebombthrow()
		if(freeze||mission!="Bee Nest Burning (D Rank)")return
		for(var/obj/usable/Bee_Killing_Blaze_Bomb/M2 in src)
			freeze=1
			spawn(42)freeze=0
			flick(usr,"attack")
			var/T=new/obj/blazebomb(loc)
			T:owner=usr
			walk(T,dir)
	trackmnin()
		if(usr.cdelay1)return
		usr.cdelay1=1
		spawn(42)usr.cdelay1=0
		var/F=new/obj/chakratarget(usr.loc)
		var/image/I=image('chakratarget.dmi',F)
		usr<<I
		walk_towards(F,locate(161,303,z))
	trackwfall()
		if(usr.cdelay1)return
		usr.cdelay1=1
		spawn(42)usr.cdelay1=0
		var/F=new/obj/chakratarget(usr.loc)
		var/image/I=image('chakratarget.dmi',F)
		usr<<I
		walk_towards(F,locate(227,358,z))
mob/var
	tracked=0
	bombed=0