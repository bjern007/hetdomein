local Framework = exports["pepe-core"]:GetCoreObject()



RegisterServerEvent('pepe-hospital:server:set:state')
AddEventHandler('pepe-hospital:server:set:state', function(type, state)
	local src = source
	local Player = Framework.Functions.GetPlayer(src)
	if Player ~= nil then
		Player.Functions.SetMetaData(type, state)
	end
end)


RegisterServerEvent('pepe-hospital:server:hospital:respawn')
AddEventHandler('pepe-hospital:server:hospital:respawn', function()
	local Player = Framework.Functions.GetPlayer(source)
	local src = source
	Player.Functions.RemoveMoney('bank', Config.BedPayment, 'Hospital')
	TriggerClientEvent('pepe-hospital:client:SendBillEmail', src, Config.BedPayment)
end)

RegisterServerEvent('pepe-hospital:server:dead:respawn')
AddEventHandler('pepe-hospital:server:dead:respawn', function()
	local Player = Framework.Functions.GetPlayer(source)
	Player.Functions.ClearInventory()
	Citizen.SetTimeout(750, function()
		Player.Functions.Save()
	end)
	Player.Functions.RemoveMoney('bank', Config.RespawnPrice, 'respawn-fund')
end)

RegisterServerEvent('pepe-hospital:server:save:health:armor')
AddEventHandler('pepe-hospital:server:save:health:armor', function(PlayerHealth, PlayerArmor)
	local Player = Framework.Functions.GetPlayer(source)
	if Player ~= nil then
		Player.Functions.SetMetaData('health', PlayerHealth)
		Player.Functions.SetMetaData('armor', PlayerArmor)
	end
end)

RegisterServerEvent('pepe-hospital:server:revive:player')
AddEventHandler('pepe-hospital:server:revive:player', function(PlayerId)
	local TargetPlayer = Framework.Functions.GetPlayer(PlayerId)
	if TargetPlayer ~= nil then
		TriggerClientEvent('pepe-hospital:client:revive', TargetPlayer.PlayerData.source, true, true)
	end
end)

RegisterServerEvent('pepe-hospital:server:heal:player')
AddEventHandler('pepe-hospital:server:heal:player', function(TargetId)
	local TargetPlayer = Framework.Functions.GetPlayer(TargetId)
	if TargetPlayer ~= nil then
		TriggerClientEvent('pepe-hospital:client:heal', TargetPlayer.PlayerData.source)
	end
end)

RegisterServerEvent('pepe-hospital:server:SendDoctorAlert')
AddEventHandler('pepe-hospital:server:SendDoctorAlert', function()
	local src = source
	for k, v in pairs(Framework.Functions.GetPlayers()) do
		local Player = Framework.Functions.GetPlayer(v)
		if Player ~= nil then 
			if ((Player.PlayerData.job.name == "ambulance") and Player.PlayerData.job.onduty) then
				TriggerClientEvent("pepe-hospital:client:SendAlert", v, "Er is een dokter nodig bij Pillbox Ziekenhuis 1ste verdieping")
			end
		end
	end
end)

RegisterServerEvent('pepe-hospital:server:SetDoctor')
AddEventHandler('pepe-hospital:server:SetDoctor', function()
	local amount = 0
	for k, v in pairs(Framework.Functions.GetPlayers()) do
        local Player = Framework.Functions.GetPlayer(v)
        if Player ~= nil then 
            if ((Player.PlayerData.job.name == "ambulance") and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
	end
	TriggerClientEvent("pepe-hospital:client:SetDoctorCount", -1, amount)
end)

RegisterServerEvent('pepe-hospital:server:take:blood:player')
AddEventHandler('pepe-hospital:server:take:blood:player', function(TargetId)
	local src = source
	local SourcePlayer = Framework.Functions.GetPlayer(src)
	local TargetPlayer = Framework.Functions.GetPlayer(TargetId)
	if TargetPlayer ~= nil then
	 local Info = {vialid = math.random(11111,99999), vialname = TargetPlayer.PlayerData.charinfo.firstname..' '..TargetPlayer.PlayerData.charinfo.lastname, bloodtype = TargetPlayer.PlayerData.metadata['bloodtype'], vialbsn = TargetPlayer.PlayerData.citizenid}
	 SourcePlayer.Functions.AddItem('bloodvial', 1, false, Info)
	 TriggerClientEvent('pepe-inventory:client:ItemBox', SourcePlayer.PlayerData.source, Framework.Shared.Items['bloodvial'], "add")
	 
	end
end)

RegisterServerEvent('pepe-hospital:server:set:bed:state')
AddEventHandler('pepe-hospital:server:set:bed:state', function(BedData, bool)
	Config.Beds[BedData]['Busy'] = bool
	TriggerClientEvent('pepe-hospital:client:set:bed:state', -1 , BedData, bool)
end)

Framework.Functions.CreateCallback('pepe-hospital:GetDoctors', function(source, cb)
	local amount = 0
	for k, v in pairs(Framework.Functions.GetPlayers()) do
		local Player = Framework.Functions.GetPlayer(v)
		if Player ~= nil then 
			if ((Player.PlayerData.job.name == "ambulance") and Player.PlayerData.job.onduty) then
				amount = amount + 1
			end
		end
	end
	cb(amount)
end)

Framework.Commands.Add("revive", "Revive a player or yourself", {{name="id", help="Player ID (can be empty)"}}, false, function(source, args)
	if args[1] ~= nil then
		local SourcePlayer = Framework.Functions.GetPlayer(src)
		local Player = Framework.Functions.GetPlayer(tonumber(args[1]))
		if Player ~= nil then
			TriggerClientEvent('pepe-hospital:client:revive', Player.PlayerData.source, true, true)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Speler is niet online!")
		end
	else
		TriggerClientEvent('pepe-hospital:client:revive', source, true, true)
		
	end
end, "admin")

Framework.Commands.Add("setems", "Neem iemand aan als Ambulancier", {{name="id", help="Speler ID"}}, true, function(source, args)
    local Player = Framework.Functions.GetPlayer(source)
    local TargetPlayer = Framework.Functions.GetPlayer(tonumber(args[1]))
    if Player.PlayerData.metadata['ishighcommand'] then
      if TargetPlayer ~= nil then
          TriggerClientEvent('Framework:Notify', TargetPlayer.PlayerData.source, 'Je bent aangenomen als Ambulancier!', 'success')
          TriggerClientEvent('Framework:Notify', Player.PlayerData.source, 'Je hebt '..TargetPlayer.PlayerData.charinfo.firstname..' '..TargetPlayer.PlayerData.charinfo.lastname..' aangenomen als Ambulancier', 'success')
          TargetPlayer.Functions.SetJob('ambulance', 0)
      end
	  
    end
end)

Framework.Commands.Add("fireems", "Fire a ems personal", {{name="id", help="Player ID"}}, true, function(source, args)
    local Player = Framework.Functions.GetPlayer(source)
    local TargetPlayer = Framework.Functions.GetPlayer(tonumber(args[1]))
    if Player.PlayerData.metadata['ishighcommand'] then
      if TargetPlayer ~= nil then
          TriggerClientEvent('Framework:Notify', TargetPlayer.PlayerData.source, 'Je bent ontslagen van je oude baan', 'error')
          TriggerClientEvent('Framework:Notify', Player.PlayerData.source, 'Je hebt '..TargetPlayer.PlayerData.charinfo.firstname..' '..TargetPlayer.PlayerData.charinfo.lastname..' ontslagen!', 'success')
          TargetPlayer.Functions.SetJob('unemployed', 0)
      end
	  
    end
end)