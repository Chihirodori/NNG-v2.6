mob/var/tmp/sz=0
mob/proc
	zonedelay()
		zonedelay++
		spawn(8)zonedelay--
mob/var/zonedelay=0
turf/territorial
	dropdownsound
		Enter(mob/A)
			if(istype(A,/mob))
				if(istype(A,/mob/player))
					if(usr.zonedelay)return
					if(usr.village=="Sound")
						usr.inzone=1
						usr.atkdef()
					usr.loc=locate(423,310,3)
					usr.zonedelay()
					for(var/mob/Clone/M in world)if(M.cloneowner==usr)del M
				else
					A.loc=loc
					return 1
			else
				A.loc=loc
				return 1
	soundmainentrance
		Enter(mob/A)
			if(istype(A,/mob))
				if(istype(A,/mob/player))
					if(usr.zonedelay||usr.cdelay1)return
					usr.cdelay1=1
					var/g=new/obj/derpa(usr.loc)
					var/count=6
					var/Y=usr.hp
					var/X=usr.loc
					loop
					if(count)
						spawn(7)
							if(usr.hp<Y||X!=usr.loc)
								usr.busy=null
								usr.cdelay1=0
								if(g)del g
								return
							count--
							goto loop
					else
						usr.cdelay1=0
						usr.loc=locate(430,237,2)
						if(usr.village=="Sound")
							usr.inzone=0
							usr.atkdef()
						usr.zonedelay()
						for(var/mob/Clone/M in world)if(M.cloneowner==usr)del M
				else
					A.loc=loc
					return 1
			else
				A.loc=loc
				return 1
	soundmainentranceinside
		Enter(mob/A)
			if(istype(A,/mob))
				if(istype(A,/mob/player))
					if(usr.zonedelay||usr.cdelay1)return
					usr.cdelay1=1
					var/g=new/obj/derpa(usr.loc)
					var/count=6
					var/Y=usr.hp
					var/X=usr.loc
					loop
					if(count)
						spawn(7)
							if(usr.hp<Y||X!=usr.loc)
								usr.busy=null
								usr.cdelay1=0
								if(g)del g
								return
							count--
							goto loop
					else
						usr.cdelay1=0
						usr.loc=locate(471,242,3)
						usr.zonedelay()
						if(usr.village=="Sound")
							usr.inzone=1
							usr.atkdef()
						for(var/mob/Clone/M in world)if(M.cloneowner==usr)del M
				else
					A.loc=loc
					return 1
			else
				A.loc=loc
				return 1
obj/warp
	var
		guard=null
		tox=1
		toy=1
		toz=1
		isx=0
		isy=0
		isz=0
		babysit=0
	tolocation
		layer=80
		Cross(o)
			usr=o
			if(istype(usr,/mob/player))
				if(usr.zonedelay || usr.intense && usr.hp<usr.maxhp&&usr.rank!="Academy Student"&&usr.rank!="Genin")
					return
				if(babysit&&usr.client&&!usr.babysitted)
					if(usr.mission=="Babysitting (D Rank)")
						for(var/obj/items/Babysitting_Mission_Proof/M in usr)goto skip
						usr.savedloc=locate(x,y-2,z)
						usr.sz=toz
						usr.babysit()
				skip
				if(guard)if(usr.village!=guard||usr.pktoggle)return
				tox=usr.x
				toy=usr.y
				if(isz==1)
					tox=usr.x
					if(usr.dir==SOUTH)toy=usr.y-2
					else toy=usr.y+1
				if(isz==2)
					tox=usr.x
					toy=usr.y-2
				if(isz==4)
					toz=2
					tox=x+34
					toy=y-28
					if(usr.village=="Sound")
						usr.inzone=0
						usr.atkdef()
				if(isz==5)
					toz=3
					tox=x-34
					toy=y+30
					if(usr.village=="Sound")
						usr.inzone=1
						usr.atkdef()
				if(isz==6)
					if(akatpass!="none"&&usr.rank!="Akatsuki Leader"&&usr.rank!="Akatsuki Member")
						var/bs=input("Enter the password.") as text
						if(bs==akatpass)
							alert(usr,"Accepted.")
						else
							return
					toz=3
					tox=260
					toy=388
				if(isz==7)
					toz=2
					tox=268
					toy=482
				usr.onsand=0
				usr.onwater=0
				usr.loc=locate(tox,toy,toz)
				for(var/area/A in oview(0,usr))A.Entered(usr)
				usr.zonedelay()
				for(var/mob/Clone/M in world)if(M.cloneowner==usr)del M
			if(isobj(o))del o
			..()
		icon='mapeasy.dmi'
		New()
			..()
			invisibility=100
		sounddoorout
			icon_state="enter"
			isz=4
		sounddoorin
			icon_state="enter"
			isz=5
		akatbasein
			icon_state="enter"
			isz=6
		akatbaseout
			icon_state="enter"
			isz=7
		indoortele
			icon_state="enter"
			toz=3
		guardteleleaf
			icon_state="enterg"
			isz=1
			toz=3
			guard="Leaf"
		guardtelesand
			icon_state="enterg"
			isz=1
			toz=3
			guard="Sand"
		guardtelesound
			icon_state="enterg"
			isz=1
			toz=3
			guard="Sound"
		indoortelebaby
			icon_state="babysit"
			isz=1
			toz=3
			babysit=1
		outdoortele
			icon_state="exit"
			toz=2
		z4
			icon_state="upstairs"
			toz=4
		z3
			icon_state="downstairs"
			toz=3

		z3down
			icon_state="downstairs"
			toz=3
			isz=2
		z1
			icon_state="downstairs"
			toz=1
		z2
			icon_state="downstairs"
			toz=2
			isz=2
		z2base
			icon_state="downstairs"
			toz=2
			isz=1









obj
	geninexamenter
		icon='mapeasy.dmi'
		icon_state="upstairs"
		New()
			..()
			invisibility=100
		Crossed(o)
			usr=o
			if(istype(usr,/mob/player))
				if(geninexam==1)
					if(usr.rank=="Academy Student")
						usr.loc=locate(usr.x,usr.y+1,3)
						usr.ingenin=1
				else
					usr<<"There is no Genin Exam at the moment."
					usr.y--
			if(isobj(usr))del usr
			..()
	geninexamexit
		icon='mapeasy.dmi'
		icon_state="downstairs"
		New()
			..()
			invisibility=100
		Crossed(o)
			usr=o
			if(istype(usr,/mob/player))
				usr.loc=locate(usr.x,usr.y-1,2)
				usr.ingenin=0
				for(var/area/A in oview(0,usr))A.Entered(usr)
			if(isobj(usr))del usr
			..()
	soundgeninexam
		icon='mapeasy.dmi'
		icon_state="downstairs"
		New()
			..()
			invisibility=100
		Crossed(o)
			usr=o
			if(istype(usr,/mob/player))
				if(usr.ingenin)
					usr.ingenin=0
					usr.loc=locate(usr.x,usr.y-2,3)
					return
				if(geninexam==1)
					if(usr.rank=="Academy Student")
						usr.loc=locate(usr.x,usr.y+2,3)
						usr.ingenin=1
				else
					usr.y--
			if(isobj(usr))del usr
			..()
	deathforestbuilding
		Crossed(o)
			usr=o
			if(istype(usr,/mob/player))
				var/O=0
				for(var/obj/usable/Earth_Scroll/M in usr)
					O++
				for(var/obj/usable/Heaven_Scroll/M in usr)
					O++
				usr.inchunin=0
				if(O>=2)
					for(var/obj/usable/Earth_Scroll/M in usr)
						del M
					for(var/obj/usable/Heaven_Scroll/M in usr)
						del M
					usr<<"<b><font color=yellow><font size=3>Congratulations! You have passed the Chunin Exam! Your rank is now Chunin!"
					world<<"<b><font color=yellow>[usr], from the [usr.village] has passed the Chunin Exam!"
					usr.rank="Chunin"
					usr.tmprank="Chunin"
					if(usr.insquad)
						for(var/mob/player/M in world)
							if(M.squadname==usr.squadname&&M.squadrank=="Squad Leader")
								M.leadershipskill++
								if(M.leadershipskill>=20)M.leadershipskill=20
								world<<"<b><center>[M] has gained a leadership skill!([M.leadershipskill] total)"
						usr.insquad=0
						usr.squadname=""
						usr.squadrank=""
						usr.guildbothoff()
						usr.addnothing()
					if(usr.rankup<2)
						usr.rankup=2
						usr.medal(1,18)
					usr.pktoggle=0
					usr.affcheck()
					usr.repgain(4,"Passed the chunin exam.")
					usr.summonspawn()
				else
					for(var/obj/usable/Earth_Scroll/M in usr)
						M.loc=locate(usr.x,usr.y-2,usr.z)
					for(var/obj/usable/Heaven_Scroll/M in usr)
						M.loc=locate(usr.x,usr.y-2,usr.z)
					usr<<"<b>You do not have both the scrolls."
					usr.summonspawn()
			if(isobj(usr))del usr
			..()