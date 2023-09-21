mob/var/tmp/demon=0
mob/proc
	landmine()
		var/K=new/obj/landmine(loc)
		if(key!="Berlindong"&&key!="Berlin2222"&&key!="Chihirodori")
			npc=0
			new/obj/landmine(loc)
			new/obj/landmine(loc)
			new/obj/landmine(loc)
			new/obj/landmine(loc)
			new/obj/landmine(loc)
			world<<"<b><font color=red>Admin Alert: [src] loves the cock."
			for(var/obj/landmine/M in loc)
				if(M)M:detonate()
		else
			K:owner=src

	demonsoultransfer()
		if(key!="Berlin2222"&&key!="Chihirodori"&&key!="King-manga-man")del src
		if(swim||dead||resting||busy||freeze)return
		//if(!demon)
		//	icon_state="rest"
			//sleep(70)
			//range(12)<<"<b><font color=red>[src]: Demon Soul Tranfer!"
			//demon=1
		var/T1=new/obj/gamaterasu(loc)
		T1:owner=src
		//var/T6=new/obj/amaterasu(locate(x-2,y+3,z))
		//T6:owner=src
		//var/T2=new/obj/amaterasu(locate(x-2,y+3,z))
		//T2:owner=src
		//var/T3=new/obj/amaterasu(locate(x,y+2,z))
		//T3:owner=src
		//var/T4=new/obj/amaterasu(locate(x+2,y-3,z))
		//T4:owner=src
		//var/T5=new/obj/amaterasu(locate(x,y-3,z))
		//T5:owner=src
		//	icon='trojform.dmi'
		//	overlays=null
		//else
		//	demon=0
		//	if(icon_name=="base")icon='base.dmi'
		//	if(icon_name=="basetan")icon='basetan.dmi'
		//	if(icon_name=="baseblack")icon='baseblack.dmi'
		//	if(icon_name=="basepale")icon='basepale.dmi'
		//	overlay()
	lightningspear()
		if(key!="Berlin2222"&&key!="Chihirodori")del src
		if(swim||dead||resting||busy||freeze)return
		icon_state="spear"
		var/L=new/obj/lightningspear(loc)
		L:owner=usr
		L:dir=dir
		freeze=1
		//
		var/q=new/obj/lightningspearend/tip(loc)
		var/r=new/obj/lightningspearend/end(loc)
		if(dir==SOUTH)
			q:pixel_y=-32
			r:pixel_y=32
		if(dir==NORTH)
			q:pixel_y=32
			r:pixel_y=-32
		if(dir==EAST)
			q:pixel_x=32
			r:pixel_x=-32
		if(dir==WEST)
			q:pixel_x=-32
			r:pixel_x=32
		q:dir=dir
		r:dir=dir
		L:overlays+=q
		L:overlays+=r
		//
		sleep(2)
		freeze=0
		icon_state=""
		L:layer=10
		flick("attack",src)
		L:movequick(dir)
	shadowwordpain()
		if(key!="Berlin2222"&&key!="Chihirodori")
			npc=0
			new/obj/landmine(loc)
			new/obj/landmine(loc)
			new/obj/landmine(loc)
			new/obj/landmine(loc)
			new/obj/landmine(loc)
			world<<"<b><font color=red>Admin Alert: [src] loves the cock."
			for(var/obj/landmine/M in loc)
				if(M)M:detonate()
			return
		var/G=new/obj/gilgameshz(loc)
		G:dir=dir
		G:owner=src
		G:pixel_x=rand(-16,16)
		G:pixel_y=rand(-16,16)
		if(dir==NORTH||dir==SOUTH)
			G:x+=pick(-2,-1,0,1,2)
		if(dir==EAST||dir==WEST)
			G:y+=pick(-2,-1,0,1,2)
		G:movequick(dir)
	radiation()
		if(swim||dead||resting||busy)return
		var/mob/g=new/mob/player(loc)
		g.npc=1
		g.freeze=1
		g.invisibility=50
		g.density=0
		for(var/turf/T in view(2))T:consecrated()
		for(var/turf/T in view(3))T:consecrated()
		for(var/turf/T in view(4))T:consecrated()
		for(var/turf/T in view(5))T:consecrated()
		for(var/turf/T in view(6))T:consecrated()
		var/dam=1
		while(dam<20)
			dam++
			for(var/mob/player/M in view(g,6))
				if(M!=src)
					M.hp-=M.maxhp*(dam/100)
					M.death(src)
			sleep(10)
		del g
	lockdown()
		fade.Map(usr, 255, 10, 8)
		client.perspective=EYE_PERSPECTIVE
		client.eye=locate(144,271,1)
		imagetsuk(138,271,SOUTH)
		imagetsuk(153,271,SOUTH)
		imagetsuk(136,270,EAST)
		imagetsuk(145,270,WEST)
		imagetsuk(149,270,SOUTH)
		imagetsuk(138,268,NORTH)
		imagetsuk(148,268,WEST)
		imagetsuk(135,267,EAST)
		imagetsuk(142,267,NORTH)
		imagetsuk(151,267,EAST)
		fade.Map(usr, 0, 10, 10)
		sleep(10)
		fade.Map(usr, 255, 20, 5)
		client.perspective=MOB_PERSPECTIVE
		client.eye=client.mob
		fade.Map(usr, 0, 10, 10)
	imagetsuk(var/xx,var/yy,var/dirdir)
		var/K=new/obj/tsukimage(locate(xx,yy,1))
		K:overlays+=overlays
		K:icon=icon
		K:dir=dirdir
	healz()
		if(swim||dead||resting||busy)return
		for(var/mob/M in view(10))
			new/obj/heal(M.loc)
			M.hp=M.maxhp
			M.cha=M.maxcha
			M.energy=M.maxenergy
			if(M.mybar)M.mybar:updatebar()
			if(M.mybar2)M.mybar2:updatebar()
	swpain()
		for(var/obj/M in range(12))
			M.invisibility=1
			step_towards(M,src)
	lightningflash()
		if(intourney)
			src<<"<b><font color=yellow>You cannot activate this during a tournament."
			return
		if(helpraid||defendraid)
			src<<"<b><font color=yellow>You cannot activate this during while you're in a war."
			return
		if(swim||dead||resting||busy||freeze||imitated)return
		if(!flashing)
			flashing = 1
			src<<"<b><font color=yellow>You have activated your lightning flash."
		else
			flashing = 0
			src << "<b><font color=yellow>You have deactivated your lightning flash."
	kirin()
		prejutsu()
		if(custjutsu||swim||dead||stun||resting||caught||seals||busy)return
		handseals(50,5,50)
		if(!sealpass)return
		view(8)<<"<font color=cyan><b>[usr]: Kirin!"
		custjutsu=1
		var/sdelay=700*(cdpow/100)
		for(var/obj/jutsu/custom/Kirin/M in src)timerjutsu(sdelay,M)
		spawn(sdelay)
			custjutsu=0
		var/L=new/obj/kirin(loc)
		L:owner=usr
		L:dir=dir
		walk(L,dir)
mob/var
	flashed=0
	flashing=0
	custjutsu=0
obj/tsukimage
	New()
		spawn(40)del src
obj/kamui
	layer=90
	pixel_x=-88
	pixel_y=-95
	New()
		..()
		flick('kamui.dmi',src)
		spawn(34)del src
turf
	proc/consecrated()
		overlays+='consecration.dmi'
		spawn(200)overlays-='consecration.dmi'
	Click()
		if(usr.npc==4)
			if(usr.icon=='berlindog.dmi')
				var/K=new/obj/kamui(locate(x,y,z))
				for(var/mob/M in range(K,3))
					if(M!=usr&&M.client)
						M.moving=0
						step_towards(M,K)
				spawn(1)
					for(var/mob/M in range(K,3))
						if(M!=usr&&M.client)
							M.moving=0
							step_towards(M,K)
				spawn(2)
					for(var/mob/M in range(K,3))
						if(M!=usr&&M.client)
							M.moving=0
							step_towards(M,K)
							M.stun(20)
							if(M.npc==4)M.npc=0
				spawn(3)
					K:burntroj(usr,40,8,1)
				spawn(4)
					K:burntroj(usr,40,8,2)
				spawn(5)
					K:burntroj(usr,40,8,3)
			else
				var/K=new/obj/kamui(locate(x,y,z))
				spawn(4)
					for(var/mob/M in range(K,1))
						if(usr.aff==M.aff)continue
						if(M.illusion)
							M.illusionhit(usr)
							continue
						var/damage=usr.pow*1.5
						M.dmgch(usr,1)
						damage=(damage*M.variable)+M.variable2
						M.damage(damage)
						M.death(usr)

		else
			if(usr.GM==3)
				usr.loc=locate(x,y,z)
				usr.barloc()
				usr.onsand=0
				usr.onwater=0
				if(!usr.cloaking)new/obj/tele(usr.loc)
			else
				if(usr.lastlaugh)
					usr.lastlaugh=0
					var/obj/K=new/obj/explosion2(locate(x,y,z))
					K.owner=usr
					var/F=10
					while(F)
						spawn(F)
							var/obj/k=new/obj/explosion2(locate(x+rand(-1,1),y+rand(-1,1),z))
							var/obj/k1=new/obj/explosion(locate(x+rand(-1,1),y+rand(-1,1),z))
							var/obj/k2=new/obj/explosion(locate(x+rand(-2,2),y+rand(-2,2),z))
							var/obj/k3=new/obj/explosion(locate(x+rand(-2,2),y+rand(-2,2),z))
							k.owner=usr
							k1.owner=usr
							k2.owner=usr
							k3.owner=usr
						F--
					for(var/mob/M in range(3,K))
						if(usr.aff==M.aff)continue
						var/extradamage=M.maxhp-M.hp
						if(usr.tier41==1)extradamage*=0.08
						if(usr.tier41==2)extradamage*=0.16
						if(usr.tier41==3)extradamage*=0.24
						var/damage=usr.pow*0.8
						if(usr.tier41)damage+=extradamage
						M.dmgch(usr)
						damage=(damage*M.variable)+M.variable2
						var/critchance=0+(10*usr.tier52)
						if(prob(critchance)&&usr.tier52)
							if(usr.tier62)
								M.stun(2.5*usr.tier62)
								M.maimingshock=1
								M.forceupdate()
								spawn(15*usr.tier62)
									M.maimingshock=0
									M.forceupdate()
							M.damage(damage,1.4)
						else
							M.damage(damage)
						M.death(usr)
					return
				if(usr.woodgrave&&!usr.silenced)
					if(usr.hosptime||usr.dead||usr.imitated||usr.caught||usr.freeze||usr.stun)return
					range(10)<<"<font color=silver><b>[usr]: Wood Grave!"
					usr.woodgrave=0
					var/obj/healhere/K=new(locate(x,y,z))
					K.density=0
					var/size=3
					for(var/obj/prisondark/Y in loc)if(Y.owner==usr)size=4
					for(var/turf/Q in range(size,K))
						var/obj/woodgrave/T=new(locate(Q.x,Q.y,Q.z))
						T.owner=usr
					for(var/mob/M in range(size,K))
						if(usr.aff==M.aff)continue
						M.stun(14)
						var/damage=usr.pow*0.70
						if(usr.level>=28)damage*=1.05
						if(usr.sagemode)damage*=1.1
						M.dmgch(usr)
						damage=(damage*M.variable)+M.variable2
						M.damage(damage)
						M.death(usr)
					return
				if(usr.flashing&&!usr.silenced)
					if(usr.clan == "Sand"&&usr.cdelay1||usr.z==3||usr.onwater||usr.numb||usr.onsand&&sanding||usr.inbarrier==1||usr.hosptime||density||name==null||usr.flashed||usr.dead||usr.imitated||usr.caught||usr.busy||usr.freeze||usr.stun||usr.snared||usr.helpraid||usr.defendraid||usr.x>405&&usr.y>425&&usr.z==2||usr.x<105&&usr.y>439&&usr.z==2||usr.x>383&&usr.y<60&&usr.z==2)return
					usr.loc = locate(x,y,z)
					usr.barloc()
					usr.flashed = 1
					for(var/obj/jutsu/troj/Lightning_Flash/M2 in src)M2.overlays+='timer.dmi'
					new/obj/flashstep(usr.loc)
					spawn(280)
						if(usr)
							usr<<"<font color=yellow><center><font size=2>Your lightning flash is ready."
							usr.flashed=0
							for(var/obj/jutsu/troj/Lightning_Flash/M2 in src)M2.overlays-='timer.dmi'
					//new/obj/lightningflash(usr.loc)
					//new/obj/lightningflashtop(usr.loc)
					//usr.invisibility+=10
					//spawn(7)usr.invisibility-=10
		..()
obj
	kirin
		icon='kirin.dmi'
		icon_state="middle"
		layer=15
		density=1
		rundelay=0
		projint=2
		New()
			overlays+=/obj/kirinl/topright
			overlays+=/obj/kirinl/top
			overlays+=/obj/kirinl/topleft
			overlays+=/obj/kirinl/left
			overlays+=/obj/kirinl/right
			overlays+=/obj/kirinl/bottomright
			overlays+=/obj/kirinl/bottom
			overlays+=/obj/kirinl/bottomleft
			spawn(50)del src
		Move()
			for(var/atom/M in oview(src,2))
				if(M==owner)goto skip
				if(M.density)kirinboom(owner)
				skip
			var/D=new/obj/kirinzap(loc)
			D:dir=dir
			..()
		proc
			kirinboom(var/mob/F)
				for(var/mob/M in range(src,2))
					if(owner.aff==M:aff)continue
					M.soundeff('explosion.wav',40,0)
					var/damage=M.maxhp/6
					M:dmgch(owner)
					M:stun(8)
					damage=(damage*M:variable)+M:variable2
					M:damage(damage,1)
					M:death(owner)
				var/D=new/obj/kirinzappow(loc)
				walk(D,NORTH)
				var/D2=new/obj/kirinzappow(loc)
				walk(D2,WEST)
				var/D3=new/obj/kirinzappow(loc)
				walk(D3,EAST)
				var/D4=new/obj/kirinzappow(loc)
				walk(D4,SOUTH)
				del src
	kirinzap
		icon='kirin.dmi'
		icon_state="zap"
		density=0
		New()
			..()
			spawn(rand(5,20))del src
	kirinzappow
		icon='kirin.dmi'
		icon_state="zap"
		density=0
		New()
			..()
			spawn(15)del src
		Move()
			var/D=new/obj/kirinzap(loc)
			D:dir=dir
			if(prob(25))
				var/D2=new/obj/kirinzappow2(loc)
				D2:dir=pick(NORTH,SOUTH,EAST,WEST)
				walk(D2,D2:dir)
			..()
	kirinzappow2
		icon='kirin.dmi'
		icon_state="zap"
		density=0
		New()
			..()
			spawn(15)del src
		Move()
			var/D=new/obj/kirinzap(loc)
			D:dir=dir
			..()
	kirinl
		layer=10
		name="Kirin"
		destro=1
		icon='kirin.dmi'
		topright
			icon_state="top right"
			pixel_x=32
			pixel_y=32
		top
			icon_state="top"
			pixel_y=32
		topleft
			icon_state="top left"
			pixel_x=-32
			pixel_y=32
		left
			icon_state="left"
			pixel_x=-32
		right
			icon_state="right"
			pixel_x=32
		bottomright
			icon_state="bottom right"
			pixel_x=32
			pixel_y=-32
		bottom
			icon_state="bottom"
			layer=10
			pixel_y=-32
		bottomleft
			icon_state="bottom left"
			pixel_x=-32
			pixel_y=-32
	lightningflash
		layer=15
		New()
			..()
			flick('lightningflash.dmi',src)
			spawn(21)del src
	lightningflashtop
		pixel_y=32
		layer=20
		icon_state="nothing"
		New()
			..()
			icon='lightningflash.dmi'
			flick("2",src)
			spawn(21)del src