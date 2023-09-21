mob/var/clickedtheshit=0
mob/proc
	NewCharacter(var/C)
		client.screen+=new/obj/newchar/claninfo
		client.screen+=new/obj/newchar/village/leaf
		client.screen+=new/obj/newchar/village/sand
		client.screen+=new/obj/newchar/village/sound
		client.screen+=new/obj/newchar/clan/uchiha
		client.screen+=new/obj/newchar/clan/nara
		client.screen+=new/obj/newchar/clan/hyuuga
		client.screen+=new/obj/newchar/clan/sand
		client.screen+=new/obj/newchar/clan/iron
		client.screen+=new/obj/newchar/clan/wind
		client.screen+=new/obj/newchar/clan/snake
		client.screen+=new/obj/newchar/clan/spider
		client.screen+=new/obj/newchar/clan/kaguya
		client.screen+=new/obj/newchar/clan/tai
		client.screen+=new/obj/newchar/clan/copy
		client.screen+=new/obj/newchar/clan/yuki
		client.screen+=new/obj/newchar/clan/senju
		client.screen+=new/obj/newchar/clan/medic
		client.screen+=new/obj/newchar/clan/clay
		var/mob/newmob=new/mob/player(locate(121,16,1))
		client.perspective=EYE_PERSPECTIVE
		client.eye=locate(121,11,1)
		var/mob/old=src
		newmob.clan="None"
		newmob.icon='base.dmi'
		newmob.icon_name='base.dmi'
		newmob.eye='blackeyes.dmi'
		newmob.hair='berlinhair2.dmi'
		newmob.armor=/obj/anbusuit
		newmob.current_slot=C
		newmob.initialized=0
		newmob.name=key
		newmob.invisibility=10
		newmob.sight|=SEE_SELF
		newmob.overlay()
		var/image/I=image('clanscreen.dmi',locate(128,18,1),"arrow",63)
		I.vtype="hair"
		client.images+=I
		var/image/I2=image('clanscreen.dmi',locate(126,12,1),"arrow",63)
		I2.vtype="eye"
		I2.pixel_y=6
		usr.client.images+=I2
		var/image/I3=image('clanscreen.dmi',locate(126,13,1),"1",63)
		I3.vtype="hairc"
		I3.pixel_y=6
		usr.client.images+=I3
		var/image/I4=image('clanscreen.dmi',locate(127,11,1),"arrow",63)
		I4.vtype="skin"
		I4.pixel_y=6
		usr.client.images+=I4
		client.mob=newmob
		del old
	clancheck()
		soundeff('select2.wav',35,1)
		clan="None"
		if(eye=='hyuugaeyes.dmi')
			eye='blackeyes.dmi'
			for(var/image/I in usr.client.images)
				if(I.vtype=="eye")
					del(I)
			var/image/I=image('clanscreen.dmi',locate(126,12,1),"arrow",63)
			I.vtype="eye"
			I.pixel_y=6
			usr.client.images+=I
			overlay()
		for(var/obj/newchar/claninfo/M in usr.client.screen)
			M.icon_state=""
		for(var/obj/newchar/clan/uchiha/M in usr.client.screen)
			M.icon_state="uchiha1"
		for(var/obj/newchar/clan/nara/M in usr.client.screen)
			M.icon_state="nara1"
		for(var/obj/newchar/clan/hyuuga/M in usr.client.screen)
			M.icon_state="hyuuga1"
		for(var/obj/newchar/clan/sand/M in usr.client.screen)
			M.icon_state="sand1"
		for(var/obj/newchar/clan/iron/M in usr.client.screen)
			M.icon_state="iron1"
		for(var/obj/newchar/clan/wind/M in usr.client.screen)
			M.icon_state="wind1"
		for(var/obj/newchar/clan/kaguya/M in usr.client.screen)
			M.icon_state="kaguya1"
		for(var/obj/newchar/clan/snake/M in usr.client.screen)
			M.icon_state="snake1"
		for(var/obj/newchar/clan/spider/M in usr.client.screen)
			M.icon_state="spider1"
		for(var/obj/newchar/clan/yuki/M in usr.client.screen)
			M.icon_state="yuki1"
		for(var/obj/newchar/clan/tai/M in usr.client.screen)
			M.icon_state="tai1"
		for(var/obj/newchar/clan/medic/M in usr.client.screen)
			M.icon_state="medic1"
		for(var/obj/newchar/clan/copy/M in usr.client.screen)
			M.icon_state="copy1"
		for(var/obj/newchar/clan/senju/M in usr.client.screen)
			M.icon_state="senju1"
		for(var/obj/newchar/clan/clay/M in usr.client.screen)
			M.icon_state="clay1"
		if(village=="Leaf")
			for(var/obj/newchar/clan/tai/M in usr.client.screen)
				M.icon_state="tai2"
			for(var/obj/newchar/clan/copy/M in usr.client.screen)
				M.icon_state="copy2"
			for(var/obj/newchar/clan/senju/M in usr.client.screen)
				M.icon_state="senju2"
			for(var/obj/newchar/clan/uchiha/M in usr.client.screen)
				M.icon_state="uchiha2"
			for(var/obj/newchar/clan/hyuuga/M in usr.client.screen)
				M.icon_state="hyuuga2"
			for(var/obj/newchar/clan/nara/M in usr.client.screen)
				M.icon_state="nara2"
		if(village=="Sand")
			for(var/obj/newchar/clan/clay/M in usr.client.screen)
				M.icon_state="clay2"
			for(var/obj/newchar/clan/sand/M in usr.client.screen)
				M.icon_state="sand2"
			for(var/obj/newchar/clan/iron/M in usr.client.screen)
				M.icon_state="iron2"
			for(var/obj/newchar/clan/wind/M in usr.client.screen)
				M.icon_state="wind2"
		if(village=="Sound")
			for(var/obj/newchar/clan/kaguya/M in usr.client.screen)
				M.icon_state="kaguya2"
			for(var/obj/newchar/clan/snake/M in usr.client.screen)
				M.icon_state="snake2"
			for(var/obj/newchar/clan/yuki/M in usr.client.screen)
				M.icon_state="yuki2"
			for(var/obj/newchar/clan/medic/M in usr.client.screen)
				M.icon_state="medic2"
client/var
	uchiha=0
	nara=0
	hyuuga=0
	sand=0
	iron=0
	wind=0
	snake=0
	spider=0
	kaguya=0
	tai=0
	copy=0
	yuki=0
	senju=0
	medic=0
	clay=0
obj/newchar
	name=""
	layer=62
	arrow
		icon='clanscreen.dmi'
		icon_state="arrow"
	claninfo
		icon='clanscreen1.dmi'
		screen_loc="1,1"
	village
		icon='clanscreen2.dmi'
		leaf
			screen_loc="4,8"
			icon_state="leafn"
			Click()
				if(usr.clickedtheshit)return
				for(var/obj/newchar/village/sand/M in usr.client.screen)
					M.icon_state="sandn"
				for(var/obj/newchar/village/sound/M in usr.client.screen)
					M.icon_state="soundn"
				icon_state="leaf"
				usr.village="Leaf"
				usr.aff=1
				usr.loc=locate(117,34,1)
				for(var/image/I in usr.client.images)
					if(I.y>=11&&I.y<=18)
						I.y+=21
						continue
					if(I.y>=53&&I.y<=60)
						I.y-=21
						continue
					if(I.y>=74&&I.y<=81)
						I.y-=42
						continue
				usr.client.eye=locate(121,32,1)
				usr.soundeff('scroll.wav',100,1)
				usr.clancheck()
		sand
			screen_loc="10:16,8"
			icon_state="sandn"
			Click()
				if(usr.clickedtheshit)return
				for(var/obj/newchar/village/leaf/M in usr.client.screen)
					M.icon_state="leafn"
				for(var/obj/newchar/village/sound/M in usr.client.screen)
					M.icon_state="soundn"
				icon_state="sand"
				usr.aff=2
				usr.loc=locate(121,54,1)
				for(var/image/I in usr.client.images)
					if(I.y>=11&&I.y<=18)
						I.y+=42
						continue
					if(I.y>=32&&I.y<=39)
						I.y+=21
						continue
					if(I.y>=74&&I.y<=81)
						I.y-=21
						continue
				usr.client.eye=locate(121,53,1)
				usr.village="Sand"
				usr.soundeff('scroll.wav',100,1)
				usr.clancheck()
		sound
			screen_loc="17,8"
			icon_state="soundn"
			Click()
				if(usr.clickedtheshit)return
				for(var/obj/newchar/village/sand/M in usr.client.screen)
					M.icon_state="sandn"
				for(var/obj/newchar/village/leaf/M in usr.client.screen)
					M.icon_state="leafn"
				icon_state="sound"
				usr.aff=3
				usr.loc=locate(120,76,1)
				for(var/image/I in usr.client.images)
					if(I.y>=11&&I.y<=18)
						I.y+=63
						continue
					if(I.y>=32&&I.y<=39)
						I.y+=42
						continue
					if(I.y>=53&&I.y<=60)
						I.y-=21
						continue
				usr.client.eye=locate(121,74,1)
				usr.village="Sound"
				usr.soundeff('scroll.wav',100,1)
				usr.clancheck()
	clan
		icon='clanscreen.dmi'
		copy
			icon_state="copy1"
			screen_loc="4,5"
			Click()
				if(icon_state=="copy2")
					usr.clancheck()
					icon_state="copy3"
					usr.clan="Copy Ninja"
					usr.tier11max = 5
					usr.tier12max = 3
					usr.tier13max = 3
					usr.tier21max = 3
					usr.tier22max = 3
					usr.tier23max = 5
					usr.tier31max = 3
					usr.tier32max = 3
					usr.tier33max = 5
					usr.tier41max = 3
					usr.tier42max = 5
					usr.tier43max = 3
					usr.tier51max = 3
					usr.tier52max = 3
					usr.tier53max = 3
					usr.tier61max = 3
					usr.tier62max = 3
					usr.tier63max = 3
					usr.overlay()
					for(var/obj/newchar/claninfo/M in usr.client.screen)
						M.icon_state="copy ninja"
		clay
			icon_state="clay1"
			screen_loc="5,5"
			Click()
				if(icon_state=="clay2")
					usr.clancheck()
					icon_state="clay3"
					usr.clan="Clay"
					usr.tier11max = 4
					usr.tier12max = 5
					usr.tier13max = 3
					usr.tier21max = 5
					usr.tier22max = 3
					usr.tier23max = 3
					usr.tier31max = 3
					usr.tier32max = 3
					usr.tier33max = 3
					usr.tier41max = 3
					usr.tier42max = 3
					usr.tier43max = 3
					usr.tier51max = 3
					usr.tier52max = 3
					usr.tier53max = 3
					usr.tier61max = 3
					usr.tier62max = 3
					usr.tier63max = 3
					usr.overlay()
					for(var/obj/newchar/claninfo/M in usr.client.screen)
						M.icon_state="CLAY"
		hyuuga
			icon_state="hyuuga1"
			screen_loc="6,5"
			Click()
				if(icon_state=="hyuuga2")
					usr.clancheck()
					icon_state="hyuuga3"
					usr.clan="Hyuuga"
					usr.eye='hyuugaeyes.dmi'
					usr.tier11max = 4
					usr.tier12max = 4
					usr.tier13max = 3
					usr.tier21max = 3
					usr.tier22max = 3
					usr.tier23max = 3
					usr.tier31max = 3
					usr.tier32max = 5
					usr.tier33max = 2
					usr.tier41max = 3
					usr.tier42max = 3
					usr.tier43max = 2
					usr.tier51max = 2
					usr.tier52max = 3
					usr.tier53max = 2
					usr.tier61max = 3
					usr.tier62max = 1
					usr.tier63max = 3
					usr.overlay()
					for(var/obj/newchar/claninfo/M in usr.client.screen)
						M.icon_state="hyuuga"
		kaguya
			icon_state="kaguya1"
			screen_loc="7,5"
			Click()
				if(icon_state=="kaguya2")
					usr.clancheck()
					icon_state="kaguya3"
					usr.clan="Kaguya"
					usr.tier11max=4
					usr.tier12max=3
					usr.tier13max=3
					usr.tier21max=3
					usr.tier22max=2
					usr.tier23max=3
					usr.tier31max=3
					usr.tier32max=3
					usr.tier33max=4
					usr.tier41max=3
					usr.tier42max=3
					usr.tier43max=3
					usr.tier51max=3
					usr.tier52max=3
					usr.tier53max=2
					usr.tier61max=1
					usr.tier62max=3
					usr.tier63max=3
					for(var/obj/newchar/claninfo/M in usr.client.screen)
						M.icon_state="kaguya"
		iron
			icon_state="iron1"
			screen_loc="8,5"
			Click()
				if(icon_state=="iron2")
					usr.clancheck()
					icon_state="iron3"
					usr.clan="Iron"
					usr.tier11max=5
					usr.tier12max=3
					usr.tier13max=5
					usr.tier21max=3
					usr.tier22max=3
					usr.tier23max=5
					usr.tier31max=3
					usr.tier32max=3
					usr.tier33max=4
					usr.tier41max=4
					usr.tier42max=3
					usr.tier43max=3
					usr.tier51max=3
					usr.tier52max=3
					usr.tier53max=3
					usr.tier61max=3
					usr.tier62max=3
					usr.tier63max=3
					for(var/obj/newchar/claninfo/M in usr.client.screen)
						M.icon_state="iron"
		medic
			icon_state="medic1"
			screen_loc="9,5"
			Click()
				if(icon_state=="medic2")
					usr.clancheck()
					icon_state="medic3"
					usr.clan="Medic"
					usr.tier11max=5
					usr.tier12max=5
					usr.tier13max=5
					usr.tier21max=4
					usr.tier22max=4
					usr.tier23max=3
					usr.tier31max=3
					usr.tier32max=3
					usr.tier33max=3
					usr.tier41max=3
					usr.tier42max=3
					usr.tier43max=5
					usr.tier51max=3
					usr.tier52max=3
					usr.tier53max=3
					usr.tier61max=3
					usr.tier62max=5
					usr.tier63max=3
					for(var/obj/newchar/claninfo/M in usr.client.screen)
						M.icon_state="medic"
		nara
			icon_state="nara1"
			screen_loc="10,5"
			Click()
				if(icon_state=="nara2")
					usr.clancheck()
					icon_state="nara3"
					usr.clan="Nara"
					usr.tier11max=3
					usr.tier12max=5
					usr.tier13max=3
					usr.tier21max=3
					usr.tier22max=3
					usr.tier23max=3
					usr.tier31max=3
					usr.tier32max=3
					usr.tier33max=3
					usr.tier41max=3
					usr.tier42max=3
					usr.tier43max=3
					usr.tier51max=3
					usr.tier52max=3
					usr.tier53max=3
					usr.tier61max=3
					usr.tier62max=3
					usr.tier63max=3
					for(var/obj/newchar/claninfo/M in usr.client.screen)
						M.icon_state="nara"
		sand
			icon_state="sand1"
			screen_loc="11,5"
			Click()
				if(icon_state=="sand2")
					usr.clancheck()
					icon_state="sand3"
					usr.tier11max=3
					usr.tier12max=5
					usr.tier13max=5
					usr.tier21max=3
					usr.tier22max=3
					usr.tier23max=3
					usr.tier31max=4
					usr.tier32max=3
					usr.tier33max=4
					usr.tier41max=3
					usr.tier42max=3
					usr.tier43max=3
					usr.tier51max=3
					usr.tier52max=3
					usr.tier53max=3
					usr.tier61max=3
					usr.tier62max=3
					usr.tier63max=3
					usr.clan="Sand"
					for(var/obj/newchar/claninfo/M in usr.client.screen)
						M.icon_state="sand"
		senju
			icon_state = "senju1"
			screen_loc = "12,5"
			Click()
				if(icon_state=="senju2")
					usr.clancheck()
					icon_state = "senju3"
					usr.clan = "Senju"
					usr.tier11max = 3
					usr.tier12max = 3
					usr.tier13max = 3
					usr.tier21max = 3
					usr.tier22max = 3
					usr.tier23max = 3
					usr.tier31max = 3
					usr.tier32max = 3
					usr.tier33max = 3
					usr.tier41max = 3
					usr.tier42max = 3
					usr.tier43max = 3
					usr.tier51max = 3
					usr.tier52max = 5
					usr.tier53max = 3
					usr.tier61max = 3
					usr.tier62max = 3
					usr.tier63max = 3
					for(var/obj/newchar/claninfo/M in usr.client.screen)
						M.icon_state = "senju"
		snake
			icon_state="snake1"
			screen_loc="13,5"
			Click()
				if(icon_state=="snake2")
					usr.clancheck()
					icon_state="snake3"
					usr.clan="Snake"
					usr.tier11max=3
					usr.tier12max=5
					usr.tier13max=3
					usr.tier21max=3
					usr.tier22max=4
					usr.tier23max=3
					usr.tier31max=3
					usr.tier32max=3
					usr.tier33max=3
					usr.tier41max=2
					usr.tier42max=3
					usr.tier43max=3
					usr.tier51max=3
					usr.tier52max=3
					usr.tier53max=3
					usr.tier61max=5
					usr.tier62max=3
					usr.tier63max=3
					for(var/obj/newchar/claninfo/M in usr.client.screen)
						M.icon_state="snake"
		spider
			icon_state="spider1"
			screen_loc="14,5"
		tai
			icon_state="tai1"
			screen_loc="15,5"
			Click()
				if(icon_state=="tai2")
					usr.clancheck()
					icon_state="tai3"
					usr.clan="Taijutsu Specialist"
					usr.tier11max=5
					usr.tier12max=5
					usr.tier13max=3
					usr.tier21max=3
					usr.tier22max=3
					usr.tier23max=3
					usr.tier31max=3
					usr.tier32max=3
					usr.tier33max=3
					usr.tier41max=3
					usr.tier42max=3
					usr.tier43max=3
					usr.tier51max=3
					usr.tier52max=3
					usr.tier53max=3
					usr.tier61max=3
					usr.tier62max=3
					usr.tier63max=3
					for(var/obj/newchar/claninfo/M in usr.client.screen)
						M.icon_state="taijutsu"
		uchiha
			icon_state="uchiha1"
			screen_loc="16,5"
			Click()
				if(icon_state=="uchiha2")
					usr.clancheck()
					icon_state="uchiha3"
					usr.clan="Uchiha"
					usr.tier11max=5
					usr.tier12max=3
					usr.tier13max=5
					usr.tier21max=3
					usr.tier22max=3
					usr.tier23max=3
					usr.tier31max=3
					usr.tier32max=3
					usr.tier33max=5
					usr.tier41max=5
					usr.tier42max=3
					usr.tier43max=3
					usr.tier51max=3
					usr.tier52max=3
					usr.tier53max=3
					usr.tier61max=3
					usr.tier62max=3
					usr.tier63max=3
					for(var/obj/newchar/claninfo/M in usr.client.screen)
						M.icon_state="uchiha"
		wind
			icon_state="wind1"
			screen_loc="17,5"
			Click()
				if(icon_state=="wind2")
					usr.clancheck()
					icon_state="wind3"
					usr.clan="Fan"
					usr.tier11max=4
					usr.tier12max=4
					usr.tier13max=5
					usr.tier21max=3
					usr.tier22max=3
					usr.tier23max=3
					usr.tier31max=3
					usr.tier32max=5
					usr.tier33max=2
					usr.tier41max=3
					usr.tier42max=3
					usr.tier43max=2
					usr.tier51max=2
					usr.tier52max=3
					usr.tier53max=2
					usr.tier61max=3
					usr.tier62max=1
					usr.tier63max=3
					for(var/obj/newchar/claninfo/M in usr.client.screen)
						M.icon_state="wind"
		yuki
			icon_state="yuki1"
			screen_loc="18,5"
			Click()
				if(icon_state=="yuki2")
					usr.clancheck()
					icon_state="yuki3"
					usr.clan="Yuki"
					usr.tier11max=5
					usr.tier12max=3
					usr.tier13max=3
					usr.tier21max=3
					usr.tier22max=3
					usr.tier23max=3
					usr.tier31max=5
					usr.tier32max=3
					usr.tier33max=3
					usr.tier41max=3
					usr.tier42max=3
					usr.tier43max=3
					usr.tier51max=3
					usr.tier52max=3
					usr.tier53max=3
					usr.tier61max=3
					usr.tier62max=5
					usr.tier63max=3
					for(var/obj/newchar/claninfo/M in usr.client.screen)
						M.icon_state="yuki"
















image/var/vtype
obj/charcreate
	Hair
		icon='clear.dmi'
		layer=100
		Click()
			for(var/image/I in usr.client.images)
				if(I.vtype=="hair")
					del(I)
			var/image/I=image('clanscreen.dmi',loc,"arrow",63)
			I.vtype="hair"
			usr.soundeff('select3.wav',35,1)
			usr.client.images+=I
			..()
		asumahair/Click()
			..()
			usr.hair='asumahair.dmi'
			usr.overlay()
		berlinhair/Click()
			..()
			usr.hair='berlinhair.dmi'
			usr.overlay()
		berlinhair2/Click()
			..()
			usr.hair='berlinhair2.dmi'
			usr.overlay()
		buzzhair/Click()
			..()
			usr.hair='buzzhair.dmi'
			usr.overlay()
		bald/Click()
			..()
			usr.hair=null
			usr.overlay()
		tayuyahair/Click()
			..()
			usr.hair='tayuyahair.dmi'
			usr.overlay()

		gaarahair/Click()
			..()
			usr.hair='gaarahair.dmi'
			usr.overlay()

		longhair/Click()
			..()
			usr.hair='longhair.dmi'
			usr.overlay()

		itachihair/Click()
			..()
			usr.hair='itachihair.dmi'
			usr.overlay()

		dbzhair/Click()
			..()
			usr.hair='dbzhair.dmi'
			usr.overlay()

		leehair/Click()
			..()
			usr.hair='leehair.dmi'
			usr.overlay()

		sasukehair/Click()
			..()
			usr.hair='sasukehair.dmi'
			usr.overlay()

		trunkshair/Click()
			..()
			usr.hair='trunkshair.dmi'
			usr.overlay()

		clownhair/Click()
			..()
			usr.hair='clownhair.dmi'
			usr.overlay()

		irukahair/Click()
			..()
			usr.hair='irukahair.dmi'
			usr.overlay()

		generichair/Click()
			..()
			usr.hair='generichair.dmi'
			usr.overlay()

		windyhair/Click()
			..()
			usr.hair='windyhair.dmi'
			usr.overlay()

		orochimaruhair/Click()
			..()
			usr.hair='orochimaruhair.dmi'
			usr.overlay()

		nejihair/Click()
			..()
			usr.hair='nejihair.dmi'
			usr.overlay()

		byakuyahair/Click()
			..()
			usr.hair='byakuyahair.dmi'
			usr.overlay()
	Hair_Color
		icon='clanscreen3.dmi'
		var/typez
		layer=41
		Click()
			for(var/image/I in usr.client.images)
				if(I.vtype=="hairc")
					del(I)
			var/image/I=image('clanscreen.dmi',loc,"[typez]",63)
			I.vtype="hairc"
			usr.soundeff('select3.wav',35,1)
			usr.client.images+=I
			..()
		h1
			typez=1
			icon_state="1"
			Click()
				..()
				usr.haircolor(0,0,0)
		h2
			typez=3
			icon_state="2"
			Click()
				..()
				usr.haircolor(59,22,0)
		h3
			typez=1
			icon_state="3"
			Click()
				..()
				usr.haircolor(136,65,1)
		h4
			typez=3
			icon_state="4"
			Click()
				..()
				usr.haircolor(207,140,0)
		h5
			typez=1
			icon_state="5"
			Click()
				..()
				usr.haircolor(235,210,147)
		h6
			typez=3
			icon_state="6"
			Click()
				..()
				usr.haircolor(235,155,230)
		h7
			typez=1
			icon_state="7"
			Click()
				..()
				usr.haircolor(235,75,235)
		h8
			typez=3
			icon_state="8"
			Click()
				..()
				usr.haircolor(125,125,125)
		h9
			typez=1
			icon_state="9"
			Click()
				..()
				usr.haircolor(233,233,233)
		h10
			typez=3
			icon_state="10"
			Click()
				..()
				usr.haircolorc()
		h11
			typez=2
			icon_state="11"
			Click()
				..()
				usr.haircolor(170,0,0)
		h12
			typez=4
			icon_state="12"
			Click()
				..()
				usr.haircolor(235,130,0)
		h13
			typez=2
			icon_state="13"
			Click()
				..()
				usr.haircolor(230,230,0)
		h14
			typez=4
			icon_state="14"
			Click()
				..()
				usr.haircolor(0,230,0)
		h15
			typez=2
			icon_state="15"
			Click()
				..()
				usr.haircolor(0,100,0)
		h16
			typez=4
			icon_state="16"
			Click()
				..()
				usr.haircolor(0,180,230)
		h17
			typez=2
			icon_state="17"
			Click()
				..()
				usr.haircolor(0,100,90)
		h18
			typez=4
			icon_state="18"
			Click()
				..()
				usr.haircolor(0,30,230)
		h19
			typez=2
			icon_state="19"
			Click()
				..()
				usr.haircolor(0,22,140)
		h20
			typez=4
			icon_state="20"
			Click()
				..()
				usr.haircolor(80,0,140)



	Eyes
		icon='clear.dmi'
		icon_state="2"
		layer=100
		Click()
			for(var/image/I in usr.client.images)
				if(I.vtype=="eye")
					del(I)
			var/image/I=image('clanscreen.dmi',loc,"arrow",63)
			I.vtype="eye"
			I.pixel_y=6
			usr.soundeff('select3.wav',35,1)
			usr.client.images+=I
			..()
		blackeye/Click()
			..()
			if(usr.clan!="Hyuuga")
				usr.eye='blackeyes.dmi'
				usr.overlay()
		greeneye/Click()
			..()
			if(usr.clan!="Hyuuga")
				usr.eye='greeneyes.dmi'
				usr.overlay()
		blueeye/Click()
			..()
			if(usr.clan!="Hyuuga")
				usr.eye='blueeyes.dmi'
				usr.overlay()
		browneye/Click()
			..()
			if(usr.clan!="Hyuuga")
				usr.eye='browneyes.dmi'
				usr.overlay()
		ambereye/Click()
			..()
			if(usr.clan!="Hyuuga")
				usr.eye='ambereyes.dmi'
				usr.overlay()

	Skin
		layer=100
		icon='clear.dmi'
		Click()
			for(var/image/I in usr.client.images)
				if(I.vtype=="skin")
					del(I)
			usr.soundeff('select3.wav',35,1)
			var/image/I=image('clanscreen.dmi',loc,"arrow",63)
			I.vtype="skin"
			usr.client.images+=I
			..()
		basepale/Click()
			..()
			usr.icon_name='basepale.dmi'
			usr.iconrefresh()
		base/Click()
			..()
			usr.icon_name='base.dmi'
			usr.iconrefresh()
		basetan/Click()
			..()
			usr.icon_name='basetan.dmi'
			usr.iconrefresh()
		baseblack/Click()
			..()
			usr.icon_name='baseblack.dmi'
			usr.iconrefresh()
		baseblacker/Click()
			..()
			usr.icon_name='baseblacker.dmi'
			usr.iconrefresh()
	Complete
		layer=100
		icon='clear.dmi'
		Click()
			if(usr.clan!="None")
				usr.clickedtheshit=1
				usr.soundeff('select.wav',35,1)
				usr.complete()