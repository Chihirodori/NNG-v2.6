mob
	verb
		LightningArmor()
			set hidden = 1
			var/obj/JutsuEffects/NonClan/Lightning/LightningArmor/L = new()
			src.overlays += L

obj
	JutsuEffects
		NonClan
			Lightning
				LightningArmor
					icon = 'LightningArmor.dmi'
					layer = 15