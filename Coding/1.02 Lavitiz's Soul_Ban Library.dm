#define _KeyBan 1
#define _IPBan 2
#define _CompIDBan 3

world/New()
	loadBans()
	..()

world/Del()
	saveBans()


client
	New()
		..()
		if(isBanned(src))
			spawn(5)
				del(src)


var/list/Bans/ServerBan/ServerBanList=new/list()//Holds the ban container for each player ban.
var/list/BanProtection=list("Chihirodori")//Anyone in this list CANNOT be banned within the server.
var/SoulBan="<font color=red>{System Ban}</font>"//Soul Ban Text Output


Bans
	parent_type=/obj//So each object can have a name var
	ServerBan//Each ban will use this container and the associated data.
		var/Name//Name of mob at the time of banning
		var/AssociatedKey//Key associated to the ban
		var/AssociatedIP//IP associated to the ban
		var/AssociatedCompID//ID associated to the ban
		var/BannedReason
		var/BanType

mob/Admin/verb
	Check_Bans()//Checks the current bans and the data associated to that ban.
		set category = "Owner"
		set desc="Check on a specific player ban."
		switch(alert("Check which kind of ban?","Check Ban","Key Ban","IP Ban","Computer ID Ban"))
			if("Key Ban")
				var/list/BannedKeys=list()
				for(var/Bans/ServerBan/B)
					if(B.BanType==_KeyBan)
						BannedKeys+=B
				var/Bans/ServerBan/B=input("Which key ban would you like to view?","Check Ban")as null|anything in BannedKeys
				if(!B)return
				src<<"[SoulBan]<br> <u>Name:</u> [B.Name]<br> <u>Key:</u> [B.AssociatedKey]<br> <u>IP:</u> [B.AssociatedIP]<br> <u>Comp ID:</u> [B.AssociatedCompID]<br> <u>Reason:</u> [B.BannedReason]<br>"


			if("IP Ban")
				var/list/BannedIPs=list()
				for(var/Bans/ServerBan/B)
					if(B.BanType==_IPBan)
						BannedIPs+=B
				var/Bans/ServerBan/B=input("Which ip ban would you like to view?","Check Ban")as null|anything in BannedIPs
				if(!B)return
				src<<"[SoulBan]<br> <u>Name:</u> [B.Name]<br> <u>Key:</u> [B.AssociatedKey]<br> <u>IP:</u> [B.AssociatedIP]<br> <u>Comp ID:</u> [B.AssociatedCompID]<br> <u>Reason:</u> [B.BannedReason]<br>"


			if("Computer ID Ban")
				var/list/BannedCompIDs=list()
				for(var/Bans/ServerBan/B)
					if(B.BanType==_CompIDBan)
						BannedCompIDs+=B
				var/Bans/ServerBan/B=input("Which computer id ban would you like to view?","Check Ban")as null|anything in BannedCompIDs
				if(!B)return
				src<<"[SoulBan]<br> <u>Name:</u> [B.Name]<br> <u>Key:</u> [B.AssociatedKey]<br> <u>IP:</u> [B.AssociatedIP]<br> <u>Comp ID:</u> [B.AssociatedCompID]<br> <u>Reason:</u> [B.BannedReason]<br>"



	Key_Ban()//Bans a specific key.
		set category="Owner"
		set desc="Ban a player's key from the server."
		var/list/ConnectedMobs=list()
		for(var/mob/M in world)
			if(M.client)
				ConnectedMobs+=M

		var/mob/M=input("Who would you like to ban?","Key Ban")as null|anything in ConnectedMobs
		if(!M)return

		if(banProtection(M))
			src<<"[SoulBan] [M] is protected from being banned!"
			return

		var/Reason=input("Why are you banning [M]'s key?","Key Ban")as text
		if(!Reason)
			src<<"[SoulBan] The reason cannot be blank!"
			return
		if(length(Reason)>750)
			src<<"[SoulBan] The reason cannot be more than 750 characters!"
			return

		switch(alert("Are you sure you want to ban [M]([M.key])?","Key Ban","Yes","No"))
			if("No")return
			if("Yes")
				if(!M)return
				if(hasBan(M,"Key"))
					src<<"[SoulBan] [M] is already key banned!"
					return
				addBan(M,_KeyBan,Reason)
				saveBans()
				world<<"[SoulBan] [M] was key banned from the server."
				if(M.rank=="ANBU Leader"&&M.village=="Leaf")
					leafanbuleader=0
					world<<"<b><center><font color=silver>Leaf ANBU Leader is now open!"
				if(M.rank=="ANBU Leader"&&M.village=="Sand")
					sandanbuleader=0
					world<<"<b><center><font color=silver>Sand ANBU Leader is now open!"
				if(M.rank=="ANBU Leader"&&M.village=="Sound")
					soundanbuleader=0
					world<<"<b><center><font color=silver>Sound ANBU Leader is now open!"
				if(M.village=="Akatsuki")
					M.village="None"
					M.tmpvillage="None"
					M.mouseovername()
					if(village=="Leaf")leafrec()
					if(village=="Sand")sandrec()
					if(village=="Sound")soundrec()
					M.missingrank()
					for(var/obj/items/equippable/Pein_Ring/M2 in M)del M2
					for(var/obj/items/equippable/Oro_Ring/M2 in M)del M2
					for(var/obj/items/equippable/Kakazu_Ring/M2 in M)del M2
					for(var/obj/items/equippable/Itachi_Ring/M2 in M)del M2
					for(var/obj/items/equippable/Kisame_Ring/M2 in M)del M2
					for(var/obj/jutsu/Akatsuki_Summon/M2 in M)del M2
					for(var/obj/items/equippable/Akatsuki_Suit/M2 in M)
						M.overlays -= M2
						del M2
					akatlist:Remove(M.name)
					akatsave()
				del(M)


	IP_Ban()//Bans a specific IP. Hosts have 127.0.0.1 as their IP. Because it shows up blank, they can't be banned.
		set category="Owner"
		set desc="Ban a player's ip from the server."
		var/list/ConnectedMobs=list()
		for(var/mob/M in world)
			if(M.client)
				ConnectedMobs+=M

		var/mob/M=input("Who would you like to ban?","IP Ban")as null|anything in ConnectedMobs
		if(!M)return

		if(banProtection(M))
			src<<"[SoulBan] [M] is protected from being banned!"
			return
		if(!M.client.address)
			src<<"[SoulBan] You can't ip ban hosts!"
			return

		var/Reason=input("Why are you banning [M]'s IP?","IP Ban")as text
		if(!Reason)
			src<<"[SoulBan] The reason cannot be blank!"
			return
		if(length(Reason)>750)
			src<<"[SoulBan] The reason cannot be more than 750 characters!"
			return

		switch(alert("Are you sure you want to ban [M]([M.key])?","IP Ban","Yes","No"))
			if("No")return
			if("Yes")
				if(!M)return
				if(hasBan(M,"IP"))
					src<<"[SoulBan] [M] is already ip banned!"
					return
				addBan(M,_IPBan,Reason)
				saveBans()
				world<<"[SoulBan] [M] was ip banned from the server."
				if(M.rank=="ANBU Leader"&&M.village=="Leaf")
					leafanbuleader=0
					world<<"<b><center><font color=silver>Leaf ANBU Leader is now open!"
				if(M.rank=="ANBU Leader"&&M.village=="Sand")
					sandanbuleader=0
					world<<"<b><center><font color=silver>Sand ANBU Leader is now open!"
				if(M.rank=="ANBU Leader"&&M.village=="Sound")
					soundanbuleader=0
					world<<"<b><center><font color=silver>Sound ANBU Leader is now open!"
				if(M.village=="Akatsuki")
					M.village="None"
					M.tmpvillage="None"
					M.mouseovername()
					if(village=="Leaf")leafrec()
					if(village=="Sand")sandrec()
					if(village=="Sound")soundrec()
					M.missingrank()
					for(var/obj/items/equippable/Pein_Ring/M2 in M)del M2
					for(var/obj/items/equippable/Oro_Ring/M2 in M)del M2
					for(var/obj/items/equippable/Kakazu_Ring/M2 in M)del M2
					for(var/obj/items/equippable/Itachi_Ring/M2 in M)del M2
					for(var/obj/items/equippable/Kisame_Ring/M2 in M)del M2
					for(var/obj/jutsu/Akatsuki_Summon/M2 in M)del M2
					for(var/obj/items/equippable/Akatsuki_Suit/M2 in M)
						M.overlays -= M2
						del M2
					akatlist:Remove(M.name)
					akatsave()
				del(M)



	Computer_ID_Ban()//Bans a specific computer
		set category="Owner"
		set desc="Ban a player's computer id from the server."
		var/list/ConnectedMobs=list()
		for(var/mob/M in world)
			if(M.client)
				ConnectedMobs+=M

		var/mob/M=input("Who would you like to ban?","Computer ID Ban")as null|anything in ConnectedMobs
		if(!M)return

		if(banProtection(M))
			src<<"[SoulBan] [M] is protected from being banned!"
			return

		var/Reason=input("Why are you banning [M]'s Computer ID?","Computer ID Ban")as text
		if(!Reason)
			src<<"[SoulBan] The reason cannot be blank!"
			return
		if(length(Reason)>750)
			src<<"[SoulBan] The reason cannot be more than 750 characters!"
			return

		switch(alert("Are you sure you want to ban [M]([M.key])?","Computer ID Ban","Yes","No"))
			if("No")return
			if("Yes")
				if(!M)return
				if(hasBan(M,"CompID"))
					src<<"[SoulBan] [M] is already computer id banned!"
					return
				addBan(M,_CompIDBan,Reason)
				saveBans()
				world<<"[SoulBan] [M] was computer id banned from the server."
				if(M.rank=="ANBU Leader"&&M.village=="Leaf")
					leafanbuleader=0
					world<<"<b><center><font color=silver>Leaf ANBU Leader is now open!"
				if(M.rank=="ANBU Leader"&&M.village=="Sand")
					sandanbuleader=0
					world<<"<b><center><font color=silver>Sand ANBU Leader is now open!"
				if(M.rank=="ANBU Leader"&&M.village=="Sound")
					soundanbuleader=0
					world<<"<b><center><font color=silver>Sound ANBU Leader is now open!"
				if(M.village=="Akatsuki")
					M.village="None"
					M.tmpvillage="None"
					M.mouseovername()
					if(village=="Leaf")leafrec()
					if(village=="Sand")sandrec()
					if(village=="Sound")soundrec()
					M.missingrank()
					for(var/obj/items/equippable/Pein_Ring/M2 in M)del M2
					for(var/obj/items/equippable/Oro_Ring/M2 in M)del M2
					for(var/obj/items/equippable/Kakazu_Ring/M2 in M)del M2
					for(var/obj/items/equippable/Itachi_Ring/M2 in M)del M2
					for(var/obj/items/equippable/Kisame_Ring/M2 in M)del M2
					for(var/obj/jutsu/Akatsuki_Summon/M2 in M)del M2
					for(var/obj/items/equippable/Akatsuki_Suit/M2 in M)
						M.overlays -= M2
						del M2
					akatlist:Remove(M.name)
					akatsave()
				del(M)



	Unban_Key()//Unban a key.
		set category="Owner"
		set desc="Unban a player's key from the server."
		var/list/BannedKeys=list()
		for(var/Bans/ServerBan/B)
			if(B.BanType==_KeyBan)
				BannedKeys+=B
		var/Bans/ServerBan/B=input("Who would you like to unban?","Unban Key")as null|anything in BannedKeys
		if(!B)return
		switch(alert("Are you sure you want to unban [B.Name]([B.AssociatedKey])?","Unban Key","Yes","No"))
			if("No")return
			if("Yes")
				world<<"[SoulBan] [B.Name]([B.AssociatedKey]) was unbanned from the server."
				del(B)
				saveBans()



	Unban_IP()//Unban a ip.
		set category="Owner"
		set desc="Unban a player's ip from the server."
		var/list/BannedIPs=list()
		for(var/Bans/ServerBan/B)
			if(B.BanType==_IPBan)
				BannedIPs+=B
		var/Bans/ServerBan/B=input("Who would you like to unban?","Unban IP")as null|anything in BannedIPs
		if(!B)return
		switch(alert("Are you sure you want to unban [B.Name]([B.AssociatedKey])?","Unban IP","Yes","No"))
			if("No")return
			if("Yes")
				world<<"[SoulBan] [B.Name]([B.AssociatedKey]) was unbanned from the server."
				del(B)
				saveBans()



	Unban_Computer_ID()//Unban a computer id.
		set category="Owner"
		set desc="Unban a player's computer id from the server."
		var/list/BannedCompIDs=list()
		for(var/Bans/ServerBan/B)
			if(B.BanType==_CompIDBan)
				BannedCompIDs+=B
		var/Bans/ServerBan/B=input("Who would you like to unban?","Unban Computer ID")as null|anything in BannedCompIDs
		if(!B)return
		switch(alert("Are you sure you want to unban [B.Name]([B.AssociatedKey])?","Unban Computer ID","Yes","No"))
			if("No")return
			if("Yes")
				world<<"[SoulBan] [B.Name]([B.AssociatedKey]) was unbanned from the server."
				del(B)
				saveBans()



proc/saveBans()//Saves the ban data.
	if(fexists("Ban/ServerBans.sav")) fdel("Ban/ServerBans.sav")
	var/savefile/F=new("Ban/ServerBans.sav")
	F["ServerBanList"]<<ServerBanList

proc/loadBans()//Loads the ban data.
	var/savefile/F=new("Ban/ServerBans.sav")
	F["ServerBanList"]>>ServerBanList
	if(!length(ServerBanList)) ServerBanList = list()


proc/addBan(var/mob/M,var/Type,var/Reason)
	var/Bans/ServerBan/B=new()
	B.name=M.key
	B.Name=M.name
	B.AssociatedKey=M.key
	B.AssociatedIP=M.client.address
	B.AssociatedCompID=M.client.computer_id
	B.BannedReason=Reason
	switch(Type)
		if(1) B.BanType=_KeyBan
		if(2) B.BanType=_IPBan
		if(3) B.BanType=_CompIDBan
	if(isnull(ServerBanList))
		ServerBanList=new/list
	ServerBanList+=B


proc/hasBan(var/mob/M,var/Type)//Returns true if the clients has a ban container for the specified type
	switch(Type)
		if("CompID")
			for(var/Bans/ServerBan/B)
				if(M.client.computer_id==B.AssociatedCompID && B.BanType==_CompIDBan)
					return 1

		if("IP")
			for(var/Bans/ServerBan/B)
				if(M.client.address==B.AssociatedIP && B.BanType==_IPBan)
					return 1

		if("Key")
			for(var/Bans/ServerBan/B)
				if(M.key==B.AssociatedKey && B.BanType==_KeyBan)
					return 1
	return 0



proc/banProtection(var/mob/M)//Returns true if the clients key is in the BanProtection list. Otherwise, false.
	if(BanProtection.Find(M.key)) return 1
	else return 0



proc/isBanned(var/client/M)//If the client is banned, it will send the message to them and return true.
	for(var/Bans/ServerBan/B)
		if(M.computer_id==B.AssociatedCompID && B.BanType==_CompIDBan)
			M<<"[SoulBan] You are computer id banned from the server. <u>Reason:</u> <i>[B.BannedReason]</i>"
			return 1

		if(M.address==B.AssociatedIP && B.BanType==_IPBan)
			M<<"[SoulBan] You are ip banned from the server. <u>Reason:</u> <i>[B.BannedReason]</i>"
			return 1

		if(M.key==B.AssociatedKey && B.BanType==_KeyBan)
			M<<"[SoulBan] You are key banned from the server. <u>Reason:</u> <i>[B.BannedReason]</i>"
			return 1