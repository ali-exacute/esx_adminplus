ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local onTimer       = {}
local savedCoords   = {}
local warnedPlayers = {}
local deadPlayers   = {}

RegisterCommand("admin", function(source, args, rawCommand)
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.triggerEvent('chatMessage', _U('your_rank', xPlayer.getGroup()))
	end
end, false)

RegisterCommand("tpm", function(source, args, rawCommand)	-- /tpm		teleport to waypoint
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer) then
			xPlayer.triggerEvent("esx_admin:tpm")
		end
	end
end, false)

RegisterCommand("coords", function(source, args, rawCommand)	-- /coords		print exact ped location in console/F8
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer) then
			print(xPlayer.getCoords(true))
		end
	end
end, false)

RegisterCommand("players", function(source, args, rawCommand)	-- players		show online players | console only
	isPlayerOnline = false
	if source == 0 then
		local xAll = ESX.GetPlayers()
		for i=1, #xAll, 1 do
			local xPlayer = ESX.GetPlayerFromId(xAll[i])
			print("^4[ ^2ID : ^3"..xPlayer.playerId.." ^0| ^2Name : ^3"..xPlayer.getName().." ^0 | ^2Group : ^3"..xPlayer.getGroup().." ^4]^0\n")
			isPlayerOnline = true
		end
		if not isPlayerOnline then
			print(_U('no_online'))
		end
	end
end, false)

RegisterCommand("report", function(source, args, rawCommand)	-- /report [MESSAGE]		send report message to all online admins
  	local xPlayer = ESX.GetPlayerFromId(source)
	if onTimer[source] and onTimer[source] > GetGameTimer() then
		local timeLeft = (onTimer[source] - GetGameTimer()) / 1000
		xPlayer.triggerEvent('chatMessage', _U('report_cooldown', tostring(ESX.Math.Round(timeLeft))))
		return
	end
	if args[1] then
    	local message = string.sub(rawCommand, 8)
    	local xAll = ESX.GetPlayers()
    	for i=1, #xAll, 1 do
      		local xTarget = ESX.GetPlayerFromId(xAll[i])
      		if havePermission(xTarget) then		-- you can exclude some ranks to NOT reciveing reports
        		if xPlayer.playerId ~= xTarget.playerId then
		    		xTarget.triggerEvent('chatMessage', _U('report', xPlayer.getName(), xPlayer.playerId, message))
        		end
      		end
		end
		xPlayer.triggerEvent('chatMessage', _U('report', xPlayer.getName(), xPlayer.playerId, message))
		onTimer[source] = GetGameTimer() + (Config.reportCooldown * 1000)
	else
		xPlayer.triggerEvent('chatMessage', _U('invalid_input', 'REPORT'))
	end
end, false)
------------ announcement -------------
RegisterCommand("announce", function(source, args, rawCommand)	-- /announce [MESSAGE]
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if args[1] then
			local message = string.sub(rawCommand, 10)
			if xPlayer then
				if havePermission(xPlayer) then
					TriggerClientEvent('chatMessage',-1 , _U('admin_announce', xPlayer.getName(), message))
				end
			end
		else
    		xPlayer.triggerEvent('chatMessage', _U('invalid_input', 'ANNOUNCMENT'))
	 	end
	end
end, false)
------------ Console Say -------------
RegisterCommand("say", function(source, args, rawCommand)	-- say [message]		only for server console
	if source == 0 then
		if args[1] then
			local message = string.sub(rawCommand, 4)
			print("^1SERVER Announcement ^0: "..message)
			TriggerClientEvent('chatMessage',-1 , _U('server_announce', message))
		else
			print(_U('invalid_input'))
		end
	end
end, false)
---------- Bring / Bringback ----------
RegisterCommand("bring", function(source, args, rawCommand)	-- /bring [ID]
	if source ~= 0 then
	  	local xPlayer = ESX.GetPlayerFromId(source)
	  	if havePermission(xPlayer) then
	    	if args[1] and tonumber(args[1]) then
	      		local targetId = tonumber(args[1])
	      		local xTarget = ESX.GetPlayerFromId(targetId)
	      		if xTarget then
	        		local targetCoords = xTarget.getCoords()
	        		local playerCoords = xPlayer.getCoords()
	        		savedCoords[targetId] = targetCoords
	        		xTarget.setCoords(playerCoords)
	        		xPlayer.triggerEvent("chatMessage", _U('bring_adminside', args[1]))
	        		xTarget.triggerEvent("chatMessage", _U('bring_playerside'))
	      		else
	        		xPlayer.triggerEvent("chatMessage", _U('not_online', 'BRING'))
	      		end
	    	else
	      		xPlayer.triggerEvent("chatMessage", _U('invalid_input', 'BRING'))
	    	end
	  	end
	end
end, false)

RegisterCommand("bringback", function(source, args, rawCommand)	-- /bringback [ID] will teleport player back where he was before /bring
	if source ~= 0 then
  		local xPlayer = ESX.GetPlayerFromId(source)
  		if havePermission(xPlayer) then
    		if args[1] and tonumber(args[1]) then
      			local targetId = tonumber(args[1])
      			local xTarget = ESX.GetPlayerFromId(targetId)
      			if xTarget then
        			local playerCoords = savedCoords[targetId]
        			if playerCoords then
          			xTarget.setCoords(playerCoords)
          			xPlayer.triggerEvent("chatMessage", _U('bringback_admin', 'BRINGBACK', args[1]))
          			xTarget.triggerEvent("chatMessage",  _U('bringback_player', 'BRINGBACK'))
          			savedCoords[targetId] = nil
        		else
          			xPlayer.triggerEvent("chatMessage", _U('noplace_bring'))
        			end
      			else
        			xPlayer.triggerEvent("chatMessage", _U('not_online', 'BRINGBACK'))
      			end
    		else
      			xPlayer.triggerEvent("chatMessage", _U('invalid_input', 'BRINGBACK'))
    		end
  		end
	end
end, false)

---------- goto/goback ----------
RegisterCommand("goto", function(source, args, rawCommand)	-- /goto [ID]
	if source ~= 0 then
  		local xPlayer = ESX.GetPlayerFromId(source)
  		if havePermission(xPlayer) then
    		if args[1] and tonumber(args[1]) then
      			local targetId = tonumber(args[1])
      			local xTarget = ESX.GetPlayerFromId(targetId)
      			if xTarget then
        			local targetCoords = xTarget.getCoords()
        			local playerCoords = xPlayer.getCoords()
        			savedCoords[source] = playerCoords
        			xPlayer.setCoords(targetCoords)
        			xPlayer.triggerEvent("chatMessage", _U('goto_admin', args[1]))
					xTarget.triggerEvent("chatMessage",  _U('goto_player'))
      			else
        			xPlayer.triggerEvent("chatMessage", _U('not_online', 'GOTO'))
      			end
    		else
      			xPlayer.triggerEvent("chatMessage", _U('invalid_input', 'GOTO'))
    		end
  		end
	end
end, false)

RegisterCommand("goback", function(source, args, rawCommand)	-- /goback will teleport you back where you was befor /goto
	if source ~= 0 then
	  	local xPlayer = ESX.GetPlayerFromId(source)
	  	if havePermission(xPlayer) then
	    	local playerCoords = savedCoords[source]
	    	if playerCoords then
	      		xPlayer.setCoords(playerCoords)
				xPlayer.triggerEvent("chatMessage", _U('goback'))
	      		savedCoords[source] = nil
	    	else
	      		xPlayer.triggerEvent("chatMessage", _U('goback_error'))
	    	end
	  	end
	end
end, false)

---------- Noclip --------
RegisterCommand("noclip", function(source, args, rawCommand)	-- /goback will teleport you back where you was befor /goto
	if source ~= 0 then
	  	local xPlayer = ESX.GetPlayerFromId(source)
	  	if havePermission(xPlayer) then
	    	xPlayer.triggerEvent("esx_admin:noclip")
	  	end
	end
end, false)
---------- kill ----------
RegisterCommand("kill", function(source, args, rawCommand)	-- /kill [ID]
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer) then
			if args[1] and tonumber(args[1]) then
				local targetId = tonumber(args[1])
      			local xTarget = ESX.GetPlayerFromId(targetId)
      			if xTarget then
					xTarget.triggerEvent("esx_admin:killPlayer")
        			xPlayer.triggerEvent("chatMessage", _U('kill_admin', targetId))
					xTarget.triggerEvent('chatMessage', _U('kill_by_admin'))
      			else
        			xPlayer.triggerEvent("chatMessage", _U('not_online', 'KILL'))
      			end
    		else
      			xPlayer.triggerEvent("chatMessage", _U('invalid_input', 'KILL'))
    		end
  		end
	end
end, false)

---------- freeze/unfreeze ---------
RegisterCommand("freeze", function(source, args, rawCommand)	-- /freeze [ID]
	if source ~= 0 then
  		local xPlayer = ESX.GetPlayerFromId(source)
  		if havePermission(xPlayer) then
    		if args[1] and tonumber(args[1]) then
      			local targetId = tonumber(args[1])
      			local xTarget = ESX.GetPlayerFromId(targetId)
      			if xTarget then
        			xTarget.triggerEvent("esx_admin:freezePlayer", 'freeze')
					xPlayer.triggerEvent("chatMessage", _U('freeze_admin', args[1]))
					xTarget.triggerEvent("chatMessage", _U('freeze_player'))
      			else
        			xPlayer.triggerEvent("chatMessage", _U('not_online', 'FREEZE'))
      			end
    		else
		      	xPlayer.triggerEvent("chatMessage", _U('invalid_input', 'FREEZE'))
    		end
  		end
	end
end, false)

RegisterCommand("unfreeze", function(source, args, rawCommand)	-- /unfreeze [ID]
	if source ~= 0 then
  		local xPlayer = ESX.GetPlayerFromId(source)
  		if havePermission(xPlayer) then
    		if args[1] and tonumber(args[1]) then
      			local targetId = tonumber(args[1])
      			local xTarget = ESX.GetPlayerFromId(targetId)
      			if xTarget then
        			xTarget.triggerEvent("esx_admin:freezePlayer", 'unfreeze')
					xPlayer.triggerEvent("chatMessage", _U('unfreeze_admin', args[1]))
					xTarget.triggerEvent("chatMessage", _U('unfreeze_player'))
      			else
        			xPlayer.triggerEvent("chatMessage", _U('not_online', 'UNFREEZE'))
      			end
    		else
      			xPlayer.triggerEvent("chatMessage", _U('invalid_input', 'UNFREEZE'))
    		end
  		end
	end
end, false)

RegisterCommand("reviveall", function(source, args, rawCommand)	-- reviveall (can be used from console)
	canRevive = false
	if source == 0 then
		canRevive = true
	else
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer) then
			canRevive = true
		end
	end
	if canRevive then
		for i,data in pairs(deadPlayers) do
			TriggerClientEvent('esx_ambulancejob:revive', i)
		end
	end
end, false)

RegisterCommand("a", function(source, args, rawCommand)	-- /a command for adminchat
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer) then
			if args[1] then
				local message = string.sub(rawCommand, 3)
				local xAll = ESX.GetPlayers()
				for i=1, #xAll, 1 do
					local xTarget = ESX.GetPlayerFromId(xAll[i])
					if havePermission(xTarget) then
						if xPlayer.playerId ~= xTarget.playerId then
							xTarget.triggerEvent('chatMessage', _U('adminchat', xPlayer.getName(), xPlayer.getGroup(), message))
						end
					end
				end
				xPlayer.triggerEvent('chatMessage', _U('adminchat', xPlayer.getName(), xPlayer.getGroup(), message))
			else
				xPlayer.triggerEvent('chatMessage', _U('invalid_input', 'AdminChat'))
			end
		end
	end
end, false)

RegisterCommand("warn", function(source, args, rawCommand)	-- /warn [ID] , will warn player and kick if execeed max warns
	if source ~= 0 then
  		local xPlayer = ESX.GetPlayerFromId(source)
  		if havePermission(xPlayer) then
    		if args[1] and tonumber(args[1]) then
					if source == tonumber(args[1]) then
						xPlayer.triggerEvent("chatMessage", _U('selfwarn'))
					else
      					local targetId = tonumber(args[1])
      					local xTarget = ESX.GetPlayerFromId(targetId)
      					if xTarget then
							if havePermission(xTarget) then
								xPlayer.triggerEvent("chatMessage", _U('adminwarn'))
								xTarget.triggerEvent("chatMessage", _U('adminwarn_to', args[1],xPlayer.getName(), xPlayer.getGroup()))
							else
								local warnCount = warnedPlayers[targetId] or 1
								if warnCount >= Config.warnMax then
									DropPlayer(targetId, _U('warnkick'))
									xPlayer.triggerEvent("chatMessage", _U('playerkicked', args[1], warnCount, Config.warnMa))
									warnedPlayers[targetId] = nil
								else
									xPlayer.triggerEvent("chatMessage", _U('playerwarned', args[1], warnCount, Config.warnMa))
									xTarget.triggerEvent("chatMessage", _U('gotwarn', warnCount, Config.warnMa))
									warnedPlayers[targetId] = warnCount + 1
								end
							end
      					else
        				xPlayer.triggerEvent("chatMessage", _U('not_online', 'WARN'))
      				end
				end
    		else
      			xPlayer.triggerEvent("chatMessage", _U('invalid_input', 'WARN'))
    		end
  		end
	end
end, false)

------------ functions and events ------------
RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	deadPlayers[source] = data
end)

RegisterNetEvent('esx:onPlayerSpawn')
AddEventHandler('esx:onPlayerSpawn', function()
	if deadPlayers[source] then
		deadPlayers[source] = nil
	end
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
	-- empty tables when player no longer online
	if onTimer[playerId] then
		onTimer[playerId] = nil
	end
    if savedCoords[playerId] then
    	savedCoords[playerId] = nil
    end
	if warnedPlayers[playerId] then
		warnedPlayers[playerId] = nil
	end
	if deadPlayers[playerId] then
		deadPlayers[playerId] = nil
	end
end)

function havePermission(xPlayer, exclude)	-- you can exclude rank(s) from having permission to specific commands 	[exclude only take tables]
	if exclude and type(exclude) ~= 'table' then exclude = nil;print("^3[esx_admin] ^1ERROR ^0exclude argument is not table..^0") end	-- will prevent from errors if you pass wrong argument

	local playerGroup = xPlayer.getGroup()
	for k,v in pairs(Config.adminRanks) do
		if v == playerGroup then
			if not exclude then
				return true
			else
				for a,b in pairs(exclude) do
					if b == v then
						return false
					end
				end
				return true
			end
		end
	end
	return false
end
