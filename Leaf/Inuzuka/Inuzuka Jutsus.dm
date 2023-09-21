mob/var
	tmp/fanging=0
mob
	proc
		fangoverfang()
			prejutsu()
			if(possessiondelay||swim||dead||stun||resting||caught||seals||busy||imitated||paralysed)return
			handseals(1,1,1)
			if(!sealpass)return
			possessiondelay=1
			var/sdelay=50*(cdapow/100)
			for(var/obj/jutsu/inuzuka/Fang_Over_Fang/M in src)timerjutsu(sdelay,M)
			spawn(sdelay)possessiondelay=0
			fanging=1
			var/obj/L=new/obj/fangoverfang(loc)
			if(dir==EAST)
				L.pixel_x=-52
				L.pixel_y=-36
			if(dir==NORTH)
				L.pixel_x=-78
				L.pixel_y=-40
			if(dir==WEST)
				L.pixel_x=-82
				L.pixel_y=-36
			if(dir==SOUTH)
				L.pixel_x=-48
				L.pixel_y=-74
			L.owner=src
			L.dir=dir
			flick("start",L)
			var/am = 12
			fast=1
			loop
				if(am)
					am --
					moving = 0
					step(src,dir)
					L.loc=loc
					for(var/mob/M in oview(1))
						if(aff==M.aff)continue
						if(dir==SOUTH&&M.y<y||dir==NORTH&&M.y>y||dir==EAST&&M.x>x||dir==WEST&&M.x<x)
							if(M.illusion)
								M.illusionhit(src)
								continue
							faceme(M)
							M.stepback(1)
							var/damage = apow*0.30
							if(M.clan=="Taijutsu Specialist")
								if(M.tier32)damage*=1-(M.tier32*0.05)
							M.dmgch(src, 1)
							damage = (damage*M.variable) + M.variable2
							critroll(M)
							var/random = rand(1, 100)
							if(criticalroll >= random)
								M.damage(damage, 1.5)
							else
								M.damage(damage)
							if(M)
								M.death(src)
					spawn(1)goto loop
				else
					fanging=0
					del L
			fast=0
obj
	fangoverfang
		layer=100
		icon='WolfFang.dmi'

