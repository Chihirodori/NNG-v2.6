mob
	proc
		multiattack()
			prejutsu()
			if(cdelay1||swim||dead||stun||caught||seals||busy)return
			cdelay1=1
			for(var/obj/jutsu/soundnon/Multiple_Attacks/M in src)M.overlays+='timer.dmi'
			var/Y=3
			if(Spd>=5)Y+=2
			if(Spd>=9)Y+=2
			var/T=0
			loop
				if(T<Y)
					T++
					flick("attack",usr)
					for(var/mob/M in get_step(usr,usr.dir))
						if(M.illusion)
							M.illusionhit(src)
							return
						if(aff==M.aff)continue
						var/damage=round(usr.apow/3)+wdmg+rand(4,9)
						M.dmgch(src,1)
						damage=(damage*M.variable)+M.variable2
						M.hp-=damage
						M.death(usr)
					spawn(2)
					goto loop
			var/sdelay=150
			if(curseseal==2)sdelay=sdelay/1.5
			if(curseseal==3)sdelay=sdelay/2
			spawn(sdelay*(cdapow/100))
				for(var/obj/jutsu/soundnon/Multiple_Attacks/M in src)M.overlays-='timer.dmi'
				cdelay1=0
