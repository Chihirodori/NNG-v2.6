mob
	StandNPC
		icon='NPCs.dmi'
		TempContractor
			name="Temporary Contractor"
			village="None"
			rank="Chunin"
			npc=2
			icon_state=""
			Anko
				name="Anko(Bounty NPC)"
				icon_state="Anko"
				village="Leaf"
				rank="Special Jounin"
				mouse_over_pointer='cursorleaf.dmi'
			Kankuro
				name="Kankuro(Bounty NPC)"
				icon_state="Kankuro"
				village="Sand"
				rank="Jounin"
				mouse_over_pointer='cursorsand.dmi'
			Katarina
				name="Katarina(Bounty NPC)"
				icon_state="Katarina"
				village="Sound"
				rank="Special Jounin"
				mouse_over_pointer='cursorsound.dmi'
			Sarah
				name="Sarah(Bounty NPC)"
				icon_state="Sarah"
				village="None"
				rank="Bounty Contractor"
			Click()
				if(name!="Sarah(Bounty NPC)")if(usr.village!=village)return
				if(usr.mzing)return
				usr.mzing=1
				var/list/options=list()
				options.Add("Bingo Book")
				options.Add("Place A Bounty")
				if(usr.bountyget)options.Add("Receive Bounty Reward")
				if(usr.bountyhead&&!usr.bountycant)options.Add("Remove Your Bounty")
				//if(usr.karma<200)options.Add("Reset Your Karma")
				options.Add("Cancel")
				var/G=input("[src]: What do you want?)") as null|anything in options
				if(!G||G=="Cancel")goto mclickr
				if(G=="Bingo Book")
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
				if(G=="Place A Bounty")
					var/list/choose=list()
					for(var/mob/player/M in world)if(M.client)if(!M.bountyhead&&M!=usr)choose.Add(M)
					var/cancel="Cancel"
					choose+=cancel
					var/mob/M=input("Which person do you want to place a bounty on?") as null|anything in choose
					if(!M||M=="Cancel")
						usr.mzing=0
						return
					if(M.bountyhead>0)
						usr.mzing=0
						return
					var/baseryo=round(M.level/4)+3
					if(usr.senryo<baseryo)
						alert(usr,"You need at least [realnum(baseryo)] senryo to place a bounty on [M].")
					else
						switch(alert(usr,"A bounty on [M] will cost at least [realnum(baseryo)] senryo. Would you like to place a bonus senryo reward on his head?","Bounty","Yes","No"))
							if("Yes")
								var/F=input("How much bonus senryo do you want to place on [M]'s head?") as num
								if(F<0)F=0
								baseryo+=F
						var/brutalhosp=0
						var/ryocost=baseryo
						switch(alert(usr,"([realnum(baseryo)] senryo) Would you like to enforce high brutality on [M]'s bounty?(Causes longer hospital time)","Bounty","Yes","No"))
							if("Yes")
								var/Fz=input("How much do you want to pay for high brutality? (up to 20 extra senryo. 30 seconds per senryo.)","High Brutality",0) as num
								if(Fz<0)Fz=0
								if(Fz>20)Fz=20
								brutalhosp=Fz*30
								baseryo+=Fz
						var/F=input("([realnum(baseryo)] senryo)How many times would you like [M] to die? (Up to 10 times.)","Bounty",1) as num
						if(F<1)F=1
						if(F>10)F=10
						baseryo*=F
						var/clearable=0
						switch(alert(usr,"([realnum(baseryo)] senryo) Would you like to triple the cost of your bounty placement to make your bounty untracable and unclearable?","Bounty","Yes","No"))
							if("Yes")
								clearable=1
								baseryo*=3
						var/announcable=0
						if(baseryo>=1000)
							switch(alert(usr,"([realnum(baseryo)] senryo) Would you like to make your bounty more publicized by spending an extra 10%?","Bounty","Yes","No"))
								if("Yes")
									announcable=1
									baseryo*=1.1
						baseryo*=1.2
						alert("([realnum(baseryo)] senryo) An extra 20% fee has been added as listing fee.")
						if(usr.senryo<baseryo)
							usr<<"<font color=red><b>Limited Funds: You need at least [realnum(baseryo)] senryo to place a bounty with these conditions on [M]."
						else
							switch(alert(usr,"Would you like to place a [realnum(ryocost)] senryo bounty for a total of [F] times with an extra [brutalhosp] second of hospital time on [M]'s head? Total cost: [realnum(baseryo)] senryo","Bounty","Yes","No"))
								if("Yes")
									usr.senryo-=baseryo
									usr<<"<b>You have [realnum(usr.senryo)] senryo. (-[realnum(baseryo)])"
									if(M&&!M.bountyhead)
										M.bountyhead=ryocost
										M.bountyhosp=brutalhosp
										M.bountyannounce=announcable
										M.bountycant=clearable
										M.bountytimes=F
										M<<"<b><font color=red>Bounty Info:<font color=white> Someone has placed a [realnum(M.bountyhead)] senryo reward on your head for a total of [M.bountytimes] times.(extra [M.bountyhosp] second of hospital time)"
										if(M.bountycant)M<<"<b><font color=red>Your bounty has been set to unclearable and untraceable!"
										M.bountyby="[usr]([usr.key])"
									for(var/mob/player/Fz in world)
										if(announcable)
											Fz<<"<br><b><font color=red><center><u>A [realnum(M.bountyhead)] senryo reward has been placed on [M]'s head for a total of [M.bountytimes] times.<br>"
										else
											if(Fz!=M&&Fz.bountytoggle||Fz==usr)
												Fz<<"<b><font color=red>Bounty Info:<font color=white> A [realnum(M.bountyhead)] senryo reward has been placed on [M]'s head for a total of [M.bountytimes] times."
				if(G=="Receive Bounty Reward")
					if(usr.bountyget)
						var/T=usr.bountyget
						usr.bountyget=0
						usr.senryo+=T
						usr.ryorefresh()
						usr<<"<b>Bounty Info: You have received [realnum(T)] ryo. ([realnum(usr.senryo)])."
				if(G=="Remove Your Bounty")
					switch(alert("Would you like to remove the bounty on your head by spending [round(usr.bountyhead*1.5)] ryo?","","Yes","No"))
						if("Yes")
							if(usr.senryo>=round(usr.bountyhead*usr.bountytimes*1.5))
								if(usr.senryo>=round(usr.bountyhead*usr.bountytimes*3))
									switch(alert("Would you like to reveal who placed the bounty on your head for another [realnum(usr.bountyhead*1.5)] senryo?","","Yes","No"))
										if("Yes")
											usr<<"<b><font color=red>Bounty Info:<font color=white> [usr.bountyby] has been revealed to be the one who placed the bounty on you."
											usr.bountyhead*=2
								usr.senryo-=round(usr.bountyhead*usr.bountytimes*1.5)
								usr<<"<b>You have [realnum(usr.senryo)] senryo. (-[realnum(usr.bountyhead*usr.bountytimes*1.5)])"
								usr.ryorefresh()
								usr.bountyhead=0
								usr.bountyannounce=0
								usr.bountyhosp=0
								usr.bountyby=null
								usr.bountytimes=0
								for(var/mob/player/M in world)if(M.bountytoggle)
									M<<"<b><font color=red>Bounty Info:<font color=white> The bounty on [usr] is off."
				if(G=="Reset Your Karma")
					switch(alert("Would you like to set your karma to 300 by spending 20 senryo?","","Yes","No"))
						if("Yes")
							if(usr.senryo>=20)
								usr.senryo-=20
								usr.ryorefresh()
								usr<<"<b><u><center>Your karma is now 50."
								usr<<"<b>You have [realnum(usr.senryo)] senryo. (-20)"
								//usr.karma=50
				mclickr
				usr.mzing=0
turf/Jail
	icon='jail.dmi'
	name="Jail"
	layer=40
	ground
		layer=1
		icon_state="ground"
	bar/icon_state="bar"
	bar2/icon_state="bar2"
	bar3/icon_state="bar3"
	bar4/icon_state="bar4"
	bar5/icon_state="bar5"
	light
		icon_state="light"
		layer=30
	light2
		icon_state="light2"
		layer=30
	light3
		icon_state="light3"
		layer=30
turf/Tsukiyomi
	icon='tsukiyomi.dmi'
	name=""
	q/icon_state="1"
	w/icon_state="2"
	e/icon_state="3"
	r/icon_state="4"
	t/icon_state="5"
	y/icon_state="6"
	u
		dir=NORTH
		layer=50
		icon_state="7"
	u2
		dir=SOUTH
		icon_state="7"
	u3
		dir=EAST
		icon_state="7"
	u4
		dir=WEST
		icon_state="7"
	i/icon_state="8"
	i2
		layer=50
		icon_state="9"
	i3
		density=1
		icon_state="10"