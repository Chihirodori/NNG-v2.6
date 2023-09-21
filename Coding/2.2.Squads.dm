mob/var
	squadrank=""
	squadname=""
	insquad=0
	leadershipskill=0

mob/squad
	nothing/verb
		Create_Squad()
			set category="Squad"
			if(village=="None"||village=="Akatsuki")
				src<<output("You must be in a village to create a squad!")
				return
			if(rank!="Chunin"&&rank!="Jounin")
				src<<output("Only Chunins and Jounins can make squads.")
				return
			if(insquad)return
			switch(alert("Are you sure that you want to create a Squad?","","Yes","No"))
				if("Yes")
					squadname="[name]'s Squad"
					squadrank="Squad Leader"
					insquad=1
					removenothing()
					for(var/mob/player/G in world)if(G.village==village)G<<output("<b><center><font color=aqua>[src] has created a squad!")
					guildbothon()
	leader/verb
		Squad_Invite()
			set category="Squad"
			var/list/invitelist=list()
			for(var/mob/player/M in oview(8))
				if(M.rank!="Genin"&&M.rank!="Academy Student")continue
				if(M.name!=name)if(!M.insquad)if(M.village==village)invitelist.Add(M)
			var/mob/M=input("Who do you want to invite to your Squad?","") as null|anything in invitelist
			if(!M)return
			switch(alert(M,"[src] wishes for you to join his squad. Would you like to accept his invitation?","","Yes","No"))
				if("Yes")
					M.squadname=squadname
					M.squadrank="Squad Member"
					M.insquad=1
					M.verbs+=typesof(/mob/squad/member/verb)
					M.removenothing()
					for(var/mob/player/G in world)if(G.village==village)G<<output("<b><font color=aqua>[M] has joined [src]'s squad!")
				if("No")
					src<<output("[M] has rejected your Squad invitation.")
					return
		Squad_Boot()
			set category="Squad"
			var/list/Menu=list()
			for(var/mob/M in world)if(M.name!=name)if(M.insquad)if(M.squadname == squadname)Menu.Add(M)
			var/mob/M=input("Who do you want to boot from the Squad?","") as null | anything in Menu
			if(!M)return
			if(M.squadrank=="Squad Leader")
				alert("You can not boot the Squad Leader!")
				return
			switch(alert("Are you sure you want to kick [M] out of your Squad?","","Yes","No"))
				if("Yes")
					for(var/mob/player/G in world)if(G.village==village)G<<output("<b><font color=aqua>[src] has kicked [M] out of his squad!")
					M.guildbothoff()
					M.addnothing()
					M.squadname=""
					M.squadrank=""
					M.insquad = 0
				if("No")return
		Squad_Announce(T as text)
			set category="Squad"
			var/list/L
			L = list("font size")
			if(lentext(T) > 200)
				alert("Your message must be less than 200 characters!")
				return
			for(var/X in L)if(findtext(T,X))
				alert("You can not change your font size.")
				return
			for(var/mob/X in world)if(X.squadname == squadname)X<<output("<font size=2><font color=yellow><b><center>[usr] would like to announce to the Squad:<font size=2><br><font color=silver>[T]")
	member/verb
		Squad_Say(T as text)
			set category="Squad"
			var/list/L
			L = list("font size")
			if(lentext(T) > 200)
				alert("Your message must be less than 200 characters!")
				return
			for(var/X in L)
				if(findtext(T,X))
					alert("You can not change your font size.")
					return
			for(var/mob/X in world)if(X.squadname == squadname)X <<output("<b><font color=yellow>(Squad Say)([squadrank])[name]: [T]")
		Squad_Leave()
			set category="Squad"
			if(squadrank=="Squad Leader")
				src<<"You cannot leave your own squad."
				return
			switch(alert("Are you sure you want to leave [squadname]?","","Yes","No"))
				if("Yes")
					guildbothoff()
					addnothing()
					for(var/mob/player/G in world)if(G.village==village)G << output("<b><font color=aqua>[src] has left [squadname].")
					squadname = ""
					squadrank = ""
					insquad = 0
				if("No")return
mob/proc
	guildbothoff()
		verbs-=typesof(/mob/squad/leader/verb)
		verbs-=typesof(/mob/squad/member/verb)
	guildleaderoff()verbs-=typesof(/mob/squad/leader/verb)
	guildbothon()
		verbs+=typesof(/mob/squad/member/verb)
		verbs+=typesof(/mob/squad/leader/verb)
	guildleaderon()verbs+=typesof(/mob/squad/leader/verb)
	addnothing()
		verbs+=typesof(/mob/squad/nothing/verb)
	removenothing()
		verbs-=typesof(/mob/squad/nothing/verb)