mob/var
	spectatetourney=0
	intourn=0
var/intourney = 0
var/intourney2 = 0
mob/GM
	verb
		Set_Up_Tournament()
			set category="Tournament"
			intourney = input("Enter the first level requirement.") as num
			intourney2 = input("Enter the second level requirement.") as num
			var/intourney3 = max(intourney, intourney2)
			intourney2 = min(intourney, intourney2)
			world<<"<center><font size=4><b>[src] has started a tournament! The level range is between [intourney2] and [intourney3]. Go to the tournament tab to spectate!"
			for(var/mob/player/M in world)
				M.flashing = 0
				M.verbs += typesof(/mob/Tournament/verb)
				M << sound('Avenger.ogg', volume=30)
				if(M.level >= intourney2 && M.level <= intourney3)
					spawn(30)
						switch(input(M,"Would you like to join the tournament?") in list("Yes","No"))
							if("Yes")
								M.intourn=1
								if(!M.tourneypart)
									M.tourneypart = 1
									M.medal(1,23)
								world<<"<font color=red><b>[M] has joined the tournament."

		End_Tournament()
			set category="Tournament"
			if(intourney==0)return
			for(var/mob/player/M in world)
				M.verbs-=typesof(/mob/Tournament/verb)
				intourn=0
				if(M.spectatetourney)
					M.client.perspective=MOB_PERSPECTIVE
					M.client.eye=M.client.mob
					M.spectatetourney=0
			intourney = 0
			world<<"<center><b><u>[src] has ended the tournament."

		Fight()
			set category="Tournament"
			if(intourney==0)return
			var/list/choose=list()
			for(var/mob/player/M in world)if(M.intourn)choose.Add(M)
			var/cancel="Cancel"
			choose+=cancel
			var/mob/M=input("Who is the first fighter?") as null|anything in choose
			if(!M||M==cancel)return
			var/mob/M2=input("Who is the second fighter?") as null|anything in choose
			if(!M2||M2==cancel)return
			world<<"<b><center><font size=3><font color=red>[M]"
			world<<"<b><center><font size=3><font color=red>VS"
			world<<"<b><center><font size=3><font color=red>[M2]"
			M.onwater=0
			M.onsand=0
			M.intourn = 2
			M2.intourn = 2
			if(M.village == M2.village)
				M.betrayal()
				M2.betrayal()
			if(M.hosptime)
				M.hosptime = 1
			if(M2.hosptime)
				M2.hosptime = 1
			M2.onwater=0
			M2.onsand=0
			M.hp=M.maxhp
			M.cha=M.maxcha
			M2.hp=M2.maxhp
			M2.cha=M2.maxcha
			M.loc=locate(144,305,3)
			M2.loc=locate(154,305,3)
			M.client.perspective=MOB_PERSPECTIVE
			M.client.eye=M.client.mob
			M2.client.perspective=MOB_PERSPECTIVE
			M2.client.eye=M2.client.mob
			new/obj/tele(M.loc)
			new/obj/tele(M2.loc)
			M.barloc()
			M2.barloc()
			M.freeze=1
			M2.freeze=1
			M.busy="yes"
			M2.busy="yes"
			sleep(10)
			world<<"<b><center><font size=3><font color=red>5"
			sleep(10)
			world<<"<b><center><font size=3><font color=red>4"
			sleep(10)
			world<<"<b><center><font size=3><font color=red>3"
			sleep(10)
			world<<"<b><center><font size=3><font color=red>2"
			sleep(10)
			world<<"<b><center><font size=4><font color=red>1"
			sleep(10)
			world<<"<b><center><font size=5><font color=red>GO!"
			M.freeze=0
			M2.freeze=0
			M.busy=null
			M2.busy=null
mob
	Tournament
		verb
			Spectate()
				set category="Tournament"
				if(!spectatetourney)
					client.perspective=EYE_PERSPECTIVE
					client.eye=locate(149,305,3)
					spectatetourney=1
				else
					client.perspective=MOB_PERSPECTIVE
					client.eye=client.mob
					spectatetourney=0