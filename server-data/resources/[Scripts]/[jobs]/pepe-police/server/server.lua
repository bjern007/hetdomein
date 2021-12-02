local Framework = exports["pepe-core"]:GetCoreObject()

local Casings = {}
local HairDrops = {}
local BloodDrops = {}
local SlimeDrops = {}
local FingerDrops = {}
local PlayerStatus = {}
local Objects = {}
local Blips = {}
local Blips = {}

RegisterServerEvent("pepe-police:blips:server:updateBlips")
AddEventHandler("pepe-police:blips:server:updateBlips", function()
    local players = Framework.Functions.GetPlayers()
    Blips = {}
    for k, v in pairs(players) do
        local player = Framework.Functions.GetPlayer(v)
        local hasradar = player.Functions.GetItemByName('signalradar') ~= nil and true or false
        if hasradar == true then
            local callsign = player.PlayerData.metadata["callsign"] ~= nil and player.PlayerData.metadata["callsign"] or "Police"
            if player.PlayerData.job.name == "police" and player.PlayerData.job.onduty then
                table.insert(Blips, {v, 'police', callsign})
            elseif player.PlayerData.job.name == "ambulance" and player.PlayerData.job.onduty then
                table.insert(Blips, {v, 'ambulance', callsign})
            end
        end
    end

    TriggerClientEvent('pepe-blips:client:updateBlips', -1, Blips)
end)

CreateThread(function()
    while true do
        TriggerEvent("pepe-police:blips:server:updateBlips")
        Wait(25000)
    end
end)

RegisterServerEvent('pepe-police:server:UpdateBlips')
AddEventHandler('pepe-police:server:UpdateBlips', function()
    local src = source
    local dutyPlayers = {}
    for k, v in pairs(Framework.Functions.GetPlayers()) do
        local Player = Framework.Functions.GetPlayer(v)
        if Player ~= nil then 
            if ((Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "ambulance") and Player.PlayerData.job.onduty) then
                table.insert(dutyPlayers, {
                    source = Player.PlayerData.source,
                    label = Player.PlayerData.metadata["callsign"]..' | '..Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname,
                    job = Player.PlayerData.job.name,
                })
            end
        end
    end
    TriggerClientEvent("pepe-police:client:UpdateBlips", -1, dutyPlayers)
end)

-- // Loops \\ --

Citizen.CreateThread(function()
  while true do 
    Citizen.Wait(0)
    local CurrentCops = GetCurrentCops()
    TriggerClientEvent("pepe-police:SetCopCount", -1, CurrentCops)
    Citizen.Wait(1000 * 60 * 10)
  end
end)


CreateThread(function()
    while true do
        TriggerEvent("pepe-blips:server:updateBlips")
        Wait(25000)
    end
end)

-- // Functions \\ --

function IsVehicleOwned(plate)
    local val = false
	Framework.Functions.ExecuteSql(true, "SELECT * FROM `characters_vehicles` WHERE `plate` = @plate", {
        ['@plate'] = plate,
    }, function(result)
		if (result[1] ~= nil) then
			val = true
		else
			val = false
		end
	end)
	return val
end
function GetCurrentCops()
    local amount = 0
    for k, v in pairs(Framework.Functions.GetPlayers()) do
        local Player = Framework.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
    end
    return amount
end

-- // Evidence Events \\ --

RegisterServerEvent('pepe-police:server:CreateCasing')
AddEventHandler('pepe-police:server:CreateCasing', function(weapon, coords)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    local casingId = CreateIdType('casing')
    local weaponInfo = exports['pepe-weapons']:GetWeaponList(weapon)
    local serieNumber = nil
    if weaponInfo ~= nil then 
        local weaponItem = Player.Functions.GetItemByName(weaponInfo["IdName"])
        if weaponItem ~= nil then
            if weaponItem.info ~= nil and weaponItem.info ~= "" then 
                serieNumber = weaponItem.info.serie
            end
        end
    end
    TriggerClientEvent("pepe-police:client:AddCasing", -1, casingId, weapon, coords, serieNumber)
end)

RegisterServerEvent('pepe-police:server:CreateBloodDrop')
AddEventHandler('pepe-police:server:CreateBloodDrop', function(coords)
 local src = source
 local Player = Framework.Functions.GetPlayer(src)
 local bloodId = CreateIdType('blood')
 BloodDrops[bloodId] = Player.PlayerData.metadata["bloodtype"]
 TriggerClientEvent("pepe-police:client:AddBlooddrop", -1, bloodId, Player.PlayerData.metadata["bloodtype"], coords)
end)

RegisterServerEvent('pepe-police:server:CreateFingerDrop')
AddEventHandler('pepe-police:server:CreateFingerDrop', function(coords)
 local src = source
 local Player = Framework.Functions.GetPlayer(src)
 local fingerId = CreateIdType('finger')
 FingerDrops[fingerId] = Player.PlayerData.metadata["fingerprint"]
 TriggerClientEvent("pepe-police:client:AddFingerPrint", -1, fingerId, Player.PlayerData.metadata["fingerprint"], coords)
end)

RegisterServerEvent('pepe-police:server:CreateHairDrop')
AddEventHandler('pepe-police:server:CreateHairDrop', function(coords)
 local src = source
 local Player = Framework.Functions.GetPlayer(src)
 local HairId = CreateIdType('hair')
 HairDrops[HairId] = Player.PlayerData.metadata["haircode"]
 TriggerClientEvent("pepe-police:client:AddHair", -1, HairId, Player.PlayerData.metadata["haircode"], coords)
end)

RegisterServerEvent('pepe-police:server:CreateSlimeDrop')
AddEventHandler('pepe-police:server:CreateSlimeDrop', function(coords)
 local src = source
 local Player = Framework.Functions.GetPlayer(src)
 local SlimeId = CreateIdType('slime')
 SlimeDrops[SlimeId] = Player.PlayerData.metadata["slimecode"]
 TriggerClientEvent("pepe-police:client:AddSlime", -1, SlimeId, Player.PlayerData.metadata["slimecode"], coords)
end)

RegisterServerEvent('pepe-police:server:AddEvidenceToInventory')
AddEventHandler('pepe-police:server:AddEvidenceToInventory', function(EvidenceType, EvidenceId, EvidenceInfo)
 local src = source
 local Player = Framework.Functions.GetPlayer(src)
 if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
    if Player.Functions.AddItem("filled_evidence_bag", 1, false, EvidenceInfo) then
        RemoveDna(EvidenceType, EvidenceId)
        TriggerClientEvent("pepe-police:client:RemoveDnaId", -1, EvidenceType, EvidenceId)
        TriggerClientEvent("pepe-inventory:client:ItemBox", src, Framework.Shared.Items["filled_evidence_bag"], "add")
    
        Player.Functions.SetMetaData("craftingrep", Player.PlayerData.metadata["craftingrep"]+1)
    end
 else
    TriggerClientEvent('Framework:Notify', src, "Je moet een leeg bewijszak bij je hebben...", "error")
 end
end)

RegisterServerEvent("pepe-blips:server:updateBlips")
AddEventHandler("pepe-blips:server:updateBlips", function()
    local players = Framework.Functions.GetPlayers()
    Blips = {}
    for k, v in pairs(players) do
        local player = Framework.Functions.GetPlayer(v)
        local hasradar = player.Functions.GetItemByName('signalradar') ~= nil and true or false
        if hasradar == true then
            local callsign = player.PlayerData.metadata["callsign"] ~= nil and player.PlayerData.metadata["callsign"] or "Police"
            if player.PlayerData.job.name == "police" and player.PlayerData.job.onduty then
                table.insert(Blips, {v, 'police', callsign})
            elseif player.PlayerData.job.name == "ambulance" and player.PlayerData.job.onduty then
                table.insert(Blips, {v, 'ambulance', callsign})
            end
        end
    end

    TriggerClientEvent('pepe-blips:client:updateBlips', -1, Blips)
end)

RegisterServerEvent('heli:spotlight')
AddEventHandler('heli:spotlight', function(state)
	local serverID = source
	TriggerClientEvent('heli:spotlight', -1, serverID, state)
end)


RegisterServerEvent('pepe-police:server:SyncSpikes')
AddEventHandler('pepe-police:server:SyncSpikes', function(table)
    TriggerClientEvent('pepe-police:client:SyncSpikes', -1, table)
end)

-- // Finger Scanner \\ --

RegisterServerEvent('pepe-police:server:show:machine')
AddEventHandler('pepe-police:server:show:machine', function(PlayerId)
    local Player = Framework.Functions.GetPlayer(PlayerId)
    TriggerClientEvent('pepe-police:client:show:machine', PlayerId, source)
    TriggerClientEvent('pepe-police:client:show:machine', source, PlayerId)
end)

RegisterServerEvent('pepe-police:server:showFingerId')
AddEventHandler('pepe-police:server:showFingerId', function(FingerPrintSession)
 local Player = Framework.Functions.GetPlayer(source)
 local FingerId = Player.PlayerData.metadata["fingerprint"] 
 if math.random(1,25)  <= 15 then
 TriggerClientEvent('pepe-police:client:show:fingerprint:id', FingerPrintSession, FingerId)
 TriggerClientEvent('pepe-police:client:show:fingerprint:id', source, FingerId)
 end
end)

RegisterServerEvent('pepe-police:server:set:tracker')
AddEventHandler('pepe-police:server:set:tracker', function(TargetId)
    local Target = Framework.Functions.GetPlayer(TargetId)
    local TrackerMeta = Target.PlayerData.metadata["tracker"]
    if TrackerMeta then
        Target.Functions.SetMetaData("tracker", false)
        TriggerClientEvent('Framework:Notify', TargetId, 'Je enkelband is afgedaan.', 'error', 5000)
        TriggerClientEvent('Framework:Notify', source, 'Je hebt een enkelband afgedaan van '..Target.PlayerData.charinfo.firstname.." "..Target.PlayerData.charinfo.lastname, 'error', 5000)
        TriggerClientEvent('pepe-police:client:set:tracker', TargetId, false)
    else
        Target.Functions.SetMetaData("tracker", true)
        TriggerClientEvent('Framework:Notify', TargetId, 'Je hebt een enkelband omgekregen.', 'error', 5000)
        TriggerClientEvent('Framework:Notify', source, 'Je hebt een enkelband omgedaan bij '..Target.PlayerData.charinfo.firstname.." "..Target.PlayerData.charinfo.lastname, 'error', 5000)
        TriggerClientEvent('pepe-police:client:set:tracker', TargetId, true)
    end
end)

RegisterServerEvent('pepe-police:server:send:tracker:location')
AddEventHandler('pepe-police:server:send:tracker:location', function(Coords, RequestId)
    local Target = Framework.Functions.GetPlayer(RequestId)
    local AlertData = {title = "Enkelband Locatie", coords = {x = Coords.x, y = Coords.y, z = Coords.z}, description = "De enkelband locatie van: "..Target.PlayerData.charinfo.firstname.." "..Target.PlayerData.charinfo.lastname}
    TriggerClientEvent("pepe-phone:client:addPoliceAlert", -1, AlertData)
    TriggerClientEvent('pepe-police:client:send:tracker:alert', -1, Coords, Target.PlayerData.charinfo.firstname.." "..Target.PlayerData.charinfo.lastname)
end)

-- // Update Cops \\ --
RegisterServerEvent('pepe-police:server:UpdateCurrentCops')
AddEventHandler('pepe-police:server:UpdateCurrentCops', function()
    local amount = 0
    for k, v in pairs(Framework.Functions.GetPlayers()) do
        local Player = Framework.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
    end
    TriggerClientEvent("pepe-police:SetCopCount", -1, amount)
end)

RegisterServerEvent('pepe-police:server:UpdateStatus')
AddEventHandler('pepe-police:server:UpdateStatus', function(data)
    local src = source
    PlayerStatus[src] = data
end)

RegisterServerEvent('pepe-police:server:ClearDrops')
AddEventHandler('pepe-police:server:ClearDrops', function(Type, List)
    local src = source
    if Type == 'casing' then
        if List ~= nil and next(List) ~= nil then 
            for k, v in pairs(List) do
                TriggerClientEvent("pepe-police:client:RemoveDnaId", -1, 'casing', v)
                Casings[v] = nil
            end
        end
    elseif Type == 'finger' then
        if List ~= nil and next(List) ~= nil then 
            for k, v in pairs(List) do
                TriggerClientEvent("pepe-police:client:RemoveDnaId", -1, 'finger', v)
                FingerDrops[v] = nil
            end
        end
    elseif Type == 'blood' then
        if List ~= nil and next(List) ~= nil then 
            for k, v in pairs(List) do
                TriggerClientEvent("pepe-police:client:RemoveDnaId", -1, 'blood', v)
                BloodDrops[v] = nil
            end
        end
    elseif Type == 'Hair' then
        if List ~= nil and next(List) ~= nil then 
            for k, v in pairs(List) do
                TriggerClientEvent("pepe-police:client:RemoveDnaId", -1, 'hair', v)
                HairDrops[v] = nil
            end
        end
    elseif Type == 'Slime' then
        if List ~= nil and next(List) ~= nil then 
            for k, v in pairs(List) do
                TriggerClientEvent("pepe-police:client:RemoveDnaId", -1, 'slime', v)
                HairDrops[v] = nil
            end
        end
    end
end)

function RemoveDna(EvidenceType, EvidenceId)
 if EvidenceType == 'hair' then
     HairDrops[EvidenceId] = nil
 elseif EvidenceType == 'blood' then
     BloodDrops[EvidenceId] = nil
 elseif EvidenceType == 'finger' then
     FingerDrops[EvidenceId] = nil
 elseif EvidenceType == 'slime' then
     SlimeDrops[EvidenceId] = nil
 elseif EvidenceType == 'casing' then
     Casings[EvidenceId] = nil
 end
end

Framework.Functions.CreateCallback('pepe-police:GetPlayerStatus', function(source, cb, playerId)
    local Player = Framework.Functions.GetPlayer(playerId)
    local statList = {}
	if Player ~= nil then
        if PlayerStatus[Player.PlayerData.source] ~= nil and next(PlayerStatus[Player.PlayerData.source]) ~= nil then
            for k, v in pairs(PlayerStatus[Player.PlayerData.source]) do
                table.insert(statList, PlayerStatus[Player.PlayerData.source][k].text)
            end
        end
	end
    cb(statList)
end)

-- // Functions \\ --

function CreateIdType(Type)
    if Type == 'casing' then
        if Casings ~= nil then
	    	local caseId = math.random(10000, 99999)
	    	while Casings[caseId] ~= nil do
	    		caseId = math.random(10000, 99999)
	    	end
	    	return caseId
	    else
	    	local caseId = math.random(10000, 99999)
	    	return caseId
        end
    elseif Type == 'finger' then
        if FingerDrops ~= nil then
            local fingerId = math.random(10000, 99999)
            while FingerDrops[fingerId] ~= nil do
                fingerId = math.random(10000, 99999)
            end
            return fingerId
        else
            local fingerId = math.random(10000, 99999)
            return fingerId
        end
    elseif Type == 'blood' then
        if BloodDrops ~= nil then
            local bloodId = math.random(10000, 99999)
            while BloodDrops[bloodId] ~= nil do
                bloodId = math.random(10000, 99999)
            end
            return bloodId
        else
            local bloodId = math.random(10000, 99999)
            return bloodId
        end
    elseif Type == 'hair' then
        if HairDrops ~= nil then
            local hairId = math.random(10000, 99999)
            while HairDrops[hairId] ~= nil do
                hairId = math.random(10000, 99999)
            end
            return hairId
        else
            local hairId = math.random(10000, 99999)
            return hairId
        end
    elseif Type == 'slime' then
        if SlimeDrops ~= nil then
            local slimeId = math.random(10000, 99999)
            while SlimeDrops[slimeId] ~= nil do
                slimeId = math.random(10000, 99999)
            end
            return slimeId
        else
            local slimeId = math.random(10000, 99999)
            return slimeId
        end
   end
end

Framework.Functions.CreateCallback('pepe-police:GetPoliceVehicles', function(source, cb)
    local vehicles = {}
    exports['ghmattimysql']:execute('SELECT * FROM characters_vehicles WHERE state = @state', {['@state'] = "impound"}, function(result)
        if result[1] ~= nil then
            vehicles = result
        end
        cb(vehicles)
    end)
end)


RegisterServerEvent("pepe-police:client:getvehicles")
AddEventHandler("pepe-police:client:getvehicles", function()
	local xPlayer = Framework.Functions.GetPlayer(source)
	local oSource = source
	local myOutfits = {}

	exports.ghmattimysql:execute('SELECT * FROM characters_vehicles WHERE state = @state', {
		['@state'] = "impound"
	}, function(result)
		for i=1, #result, 1 do
			table.insert(myOutfits, {id = result[i].id, name = result[i].vehicle, citizenid = result[i].citizenid})
		end
		TriggerClientEvent('pepe-police:client:getvehicles', oSource, myOutfits)
	end)
end)

-- // Commands \\ --

Framework.Commands.Add("boei", "Boei iemand (Admin.)", {{name="id", help="Speler ID"}}, true, function(source, args)
    local Player = Framework.Functions.GetPlayer(source)
    if args ~= nil then
     local TargetPlayer = Framework.Functions.GetPlayer(tonumber(args[1]))
       if TargetPlayer ~= nil then
         TriggerClientEvent("pepe-police:client:get:cuffed", TargetPlayer.PlayerData.source, Player.PlayerData.source)
       end
    end
end, "admin")

Framework.Commands.Add("zethogecommando", "Zet iemand zijn hoge commando status", {{name="id", help="Speler ID"}, {name="status", help="True / False"}}, true, function(source, args)
  if args ~= nil then
    local TargetPlayer = Framework.Functions.GetPlayer(tonumber(args[1]))
    if TargetPlayer ~= nil then
      if args[2]:lower() == 'true' then
          TargetPlayer.Functions.SetMetaData("ishighcommand", true)
          TriggerClientEvent('Framework:Notify', TargetPlayer.PlayerData.source, 'Je bent nu een leidinggevende!', 'success')
          TriggerClientEvent('Framework:Notify', source, 'Speler is nu een leidinggevende!', 'success')
      else
          TargetPlayer.Functions.SetMetaData("ishighcommand", false)
          TriggerClientEvent('Framework:Notify', TargetPlayer.PlayerData.source, 'Je bent geen leidinggevende meer!', 'error')
          TriggerClientEvent('Framework:Notify', source, 'Speler is GEEN leidinggevende meer!', 'error')
      end
    end
  end
end, "admin")

Framework.Commands.Add("zetpolitie", "Neem een agent aan", {{name="id", help="Speler ID"}}, true, function(source, args)
    local Player = Framework.Functions.GetPlayer(source)
    local TargetPlayer = Framework.Functions.GetPlayer(tonumber(args[1]))
    if Player.PlayerData.metadata['ishighcommand'] then
      if TargetPlayer ~= nil then
          TriggerClientEvent('Framework:Notify', TargetPlayer.PlayerData.source, 'Je bent aangenomen als agent!', 'success')
          TriggerClientEvent('Framework:Notify', Player.PlayerData.source, 'Je hebt '..TargetPlayer.PlayerData.charinfo.firstname..' '..TargetPlayer.PlayerData.charinfo.lastname..' aangenomen als agent!', 'success')
          TargetPlayer.Functions.SetJob('police')
      end
    end
end)

Framework.Functions.CreateUseableItem("spikestrip", function(source, item)
    local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("pepe-police:client:SpawnSpikeStrip", source)
    end
end)

Framework.Commands.Add("ontslapolitie", "Ontsla een agent", {{name="id", help="Speler ID"}}, true, function(source, args)
    local Player = Framework.Functions.GetPlayer(source)
    local TargetPlayer = Framework.Functions.GetPlayer(tonumber(args[1]))
    if Player.PlayerData.metadata['ishighcommand'] then
      if TargetPlayer ~= nil then
          TriggerClientEvent('Framework:Notify', TargetPlayer.PlayerData.source, 'Je bent ontslagen!', 'error')
          TriggerClientEvent('Framework:Notify', Player.PlayerData.source, 'Je hebt '..TargetPlayer.PlayerData.charinfo.firstname..' '..TargetPlayer.PlayerData.charinfo.lastname..' ontslagen!', 'success')
          TargetPlayer.Functions.SetJob('unemployed')
      end
    end
end)

Framework.Commands.Add("callsign", "Verander je dienstnummer", {{name="Nummer", help="Dienstnummer"}}, true, function(source, args)
    local Player = Framework.Functions.GetPlayer(source)
    if args[1] ~= nil then
        if Player.PlayerData.job.name == 'police' or Player.PlayerData.job.name == 'ambulance' and Player.PlayerData.job.onduty then
         Player.Functions.SetMetaData("callsign", args[1])
         TriggerClientEvent('Framework:Notify', source, 'Dienstnummer succesvol aangepast. U bent nu de: ' ..args[1], 'success')
        else
            TriggerClientEvent('Framework:Notify', source, 'Dit is alleen voor hulp diensten..', 'error')
        end
    end
end)

Framework.Commands.Add("setplate", "Verander je dienst kenteken", {{name="Nummer", help="Dienstnummer"}}, true, function(source, args)
    local Player = Framework.Functions.GetPlayer(source)
    if args[1] ~= nil then
        if Player.PlayerData.job.name == 'police' or Player.PlayerData.job.name == 'ambulance' and Player.PlayerData.job.onduty then
           if args[1]:len() == 8 then
             Player.Functions.SetDutyPlate(args[1])
             TriggerClientEvent('Framework:Notify', source, 'Kenteken succesvol aangepast. U dienst kenteken is nu: ' ..args[1], 'success')
           else
               TriggerClientEvent('Framework:Notify', source, 'Het moet exact 8 karakters lang zijn..', 'error')
           end
        else
            TriggerClientEvent('Framework:Notify', source, 'Dit is alleen voor hulp diensten..', 'error')
        end
    end
end)

Framework.Commands.Add("kluis", "Open bewijskluis", {{"bsn", "BSN Nummer"}}, true, function(source, args)
    local Player = Framework.Functions.GetPlayer(source)
    if args[1] ~= nil then 
    if ((Player.PlayerData.job.name == "police") and Player.PlayerData.job.onduty) then
        TriggerClientEvent("pepe-police:client:open:evidence", source, args[1])
    else
        TriggerClientEvent('Framework:Notify', source, "Dit commando is alleen voor hulpdiensten!", "error")
    end
  else
    TriggerClientEvent('chatMessage', source, "SYSTEEM", "error", "Je moet alle argumenten invoeren.")
 end
end)

Framework.Commands.Add("zetdienstvoertuig", "Geef een werk voertuig aan een werknemer", {{name="id", help="Speler ID"}, {name="voertuig", help="Standaard / Audi / Heli / Motor / Unmarked"}, {name="status", help="True / False"}}, true, function(source, args)
    local SelfPlayerData = Framework.Functions.GetPlayer(source)
    local TargetPlayerData = Framework.Functions.GetPlayer(tonumber(args[1]))
    local TargetPlayerVehicleData = TargetPlayerData.PlayerData.metadata['duty-vehicles']
    if SelfPlayerData.PlayerData.metadata['ishighcommand'] then
       if args[2]:upper() == 'STANDAARD' then
           if args[3] == 'true' then
               VehicleList = {Standard = true, Audi = TargetPlayerVehicleData.Audi, Heli = TargetPlayerVehicleData.Heli, Motor = TargetPlayerVehicleData.Motor, Unmarked = TargetPlayerVehicleData.Unmarked}
           else
               VehicleList = {Standard = false, Audi = TargetPlayerVehicleData.Audi, Heli = TargetPlayerVehicleData.Heli, Motor = TargetPlayerVehicleData.Motor, Unmarked = TargetPlayerVehicleData.Unmarked}
           end
       elseif args[2]:upper() == 'AUDI' then
           if args[3] == 'true' then
               VehicleList = {Standard = TargetPlayerVehicleData.Standard, Audi = true, Heli = TargetPlayerVehicleData.Heli, Motor = TargetPlayerVehicleData.Motor, Unmarked = TargetPlayerVehicleData.Unmarked}
           else
               VehicleList = {Standard = TargetPlayerVehicleData.Standard, Audi = false, Heli = TargetPlayerVehicleData.Heli, Motor = TargetPlayerVehicleData.Motor, Unmarked = TargetPlayerVehicleData.Unmarked}
           end
       elseif args[2]:upper() == 'UNMARKED' then
           if args[3] == 'true' then
               VehicleList = {Standard = TargetPlayerVehicleData.Standard, Audi = TargetPlayerVehicleData.Audi, Heli = TargetPlayerVehicleData.Heli, Motor = TargetPlayerVehicleData.Motor, Unmarked = true}
           else
               VehicleList = {Standard = TargetPlayerVehicleData.Standard, Audi = TargetPlayerVehicleData.Audi, Heli = TargetPlayerVehicleData.Heli, Motor = TargetPlayerVehicleData.Motor, Unmarked = false}
           end 
        elseif args[2]:upper() == 'MOTOR' then
            if args[3] == 'true' then
                VehicleList = {Standard = TargetPlayerVehicleData.Standard, Audi = TargetPlayerVehicleData.Audi, Heli = TargetPlayerVehicleData.Heli, Motor = true, Unmarked = TargetPlayerVehicleData.Unmarked}
            else
                VehicleList = {Standard = TargetPlayerVehicleData.Standard, Audi = TargetPlayerVehicleData.Audi, Heli = TargetPlayerVehicleData.Heli, Motor = false, Unmarked = TargetPlayerVehicleData.Unmarked}
            end 
       elseif args[2]:upper() == 'HELI' then
           if args[3] == 'true' then
               VehicleList = {Standard = TargetPlayerVehicleData.Standard, Audi = TargetPlayerVehicleData.Audi, Heli = true, Motor = TargetPlayerVehicleData.Motor, Unmarked = TargetPlayerVehicleData.Unmarked}
           else
               VehicleList = {Standard = TargetPlayerVehicleData.Standard, Audi = TargetPlayerVehicleData.Audi, Heli = false, Motor = TargetPlayerVehicleData.Motor, Unmarked = TargetPlayerVehicleData.Unmarked}
           end 
       end
       local PlayerCredentials = TargetPlayerData.PlayerData.metadata['callsign']..' | '..TargetPlayerData.PlayerData.charinfo.firstname..' '..TargetPlayerData.PlayerData.charinfo.lastname
       TargetPlayerData.Functions.SetMetaData("duty-vehicles", VehicleList)
       TriggerClientEvent('pepe-radialmenu:client:update:duty:vehicles', TargetPlayerData.PlayerData.source)
       if args[3] == 'true' then
           TriggerClientEvent('Framework:Notify', TargetPlayerData.PlayerData.source, 'Je hebt een voertuig specialisatie ontvangen ('..args[2]:upper()..')', 'success')
           TriggerClientEvent('Framework:Notify', SelfPlayerData.PlayerData.source, 'Je hebt succesvol de voertuig specialisatie ('..args[2]:upper()..') gegeven aan '..PlayerCredentials, 'success')
       else
           TriggerClientEvent('Framework:Notify', TargetPlayerData.PlayerData.source, 'Je ('..args[2]:upper()..') specialisatie is afgenomen nerd..', 'error')
           TriggerClientEvent('Framework:Notify', SelfPlayerData.PlayerData.source, 'Je hebt succesvol de voertuig specialisatie ('..args[2]:upper()..') afgenomen van '..PlayerCredentials, 'error')
       end
    end
end)


Framework.Commands.Add("factuur", "Factuur uitschrijven", {{name="BSN", help="Burger Service Nummer"},{name="geld", help="Hoeveelheid"}}, true, function(source, args)
    local Player = Framework.Functions.GetPlayer(source)
    local TargetPlayer = Framework.Functions.GetPlayerByCitizenId(args[1])
    local Amount = tonumber(args[2])
    if TargetPlayer ~= nil then
            if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "ambulance") then
                if Amount > 0 then
                TriggerClientEvent("pepe-police:client:bill:player", TargetPlayer.PlayerData.source, Amount, Player.PlayerData.job.name)
                TargetPlayer.Functions.RemoveMoney("bank", Amount, "KamaPay")
                else
                    TriggerClientEvent('chatMessage', source, "SYSTEEM", "error", "Het bedrag moet hoger zijn dan 0")
                end
            elseif Player.PlayerData.job.name == "realestate" then
                if Amount > 0 then
                    TriggerEvent('pepe-phone:server:add:invoice', TargetPlayer.PlayerData.citizenid, Amount, 'Makelaar', 'realestate')  
                else
                    TriggerClientEvent('chatMessage', source, "SYSTEEM", "error", "Het bedrag moet hoger zijn dan 0")
                end                
            elseif Player.PlayerData.job.name == "mechanic" then
                if Amount > 0 then
                    TriggerEvent('pepe-phone:server:add:invoice', TargetPlayer.PlayerData.citizenid, Amount, 'Autocare', 'request')
                else
                    TriggerClientEvent('chatMessage', source, "SYSTEEM", "error", "Het bedrag moet hoger zijn dan 0")
                end
            else
                TriggerClientEvent('chatMessage', source, "SYSTEEM", "error", "Dit commando is alleen voor hulpdiensten!")
            end
    end
end)

Framework.Commands.Add("paylaw", "Betaal een advocaat", {{name="id", help="Speler ID"}, {name="geld", help="Hoeveelheid"}}, true, function(source, args)
	local Player = Framework.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "judge" then
        local playerId = tonumber(args[1])
        local Amount = tonumber(args[2])
        local OtherPlayer = Framework.Functions.GetPlayer(playerId)
        if OtherPlayer ~= nil then
            if OtherPlayer.PlayerData.job.name == "lawyer" then
                OtherPlayer.Functions.AddMoney("bank", Amount, "police-lawyer-paid")
                TriggerEvent('pepe-bossmenu:server:removeAccountMoney', 'police', Amount)
                TriggerClientEvent('chatMessage', OtherPlayer.PlayerData.source, "SYSTEEM", "warning", "Je hebt €"..Amount..",- ontvangen voor je gegeven diensten!")
                TriggerClientEvent('Framework:Notify', source, 'Je hebt een advocaat betaald!')

            else
                TriggerClientEvent('Framework:Notify', source, 'Persoon is geen advocaat...', "error")
            end
            
       Player.Functions.SetMetaData("lockpickrep", Player.PlayerData.metadata["lockpickrep"]+1)
        end
    else
        TriggerClientEvent('chatMessage', source, "SYSTEEM", "error", "Dit commando is alleen voor hulpdiensten!")
    end
end)

Framework.Commands.Add("cam", "Bekijk Camera", {{name="camid", help="Camera ID"}}, false, function(source, args)
	local Player = Framework.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("pepe-police:client:CameraCommand", source, tonumber(args[1]))
    else
        TriggerClientEvent('chat:addMessage', source, {
        template = '<div class="chat-message emergency">Dit commando is alleen voor hulpdiensten!  </div>',
        })
    end
end)

Framework.Commands.Add("112", "Stuur een melding naar de hulpdiensten", {{name="melding", help="De melding die je wilt sturen"}}, true, function(source, args)
    local Message = table.concat(args, " ")
    local Player = Framework.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName("phone") ~= nil then
        TriggerClientEvent('pepe-police:client:send:alert', source, Message, false)
    else
        TriggerClientEvent('Framework:Notify', source, 'Je hebt geen telefoon...', 'error')
    end
end)

Framework.Commands.Add("112a", "Stuur een anonieme melding naar hulpdiensten (geeft geen locatie)", {{name="melding", help="De melding die je anoniem wilt sturen"}}, true, function(source, args)
    local Message = table.concat(args, " ")
    local Player = Framework.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName("phone") ~= nil then
        TriggerClientEvent("pepe-police:client:call:anim", source)
        TriggerClientEvent('pepe-police:client:send:alert', -1, Message, true)
    else
        TriggerClientEvent('Framework:Notify', source, 'Je hebt geen telefoon...', 'error')
    end
end)

Framework.Commands.Add("112r", "Stuur een bericht terug naar een melding", {{name="id", help="ID van de melder"}, {name="bericht", help="Bericht die je wilt sturen"}}, true, function(source, args)
    local Player = Framework.Functions.GetPlayer(source)
    local OtherPlayer = Framework.Functions.GetPlayer(tonumber(args[1]))
    table.remove(args, 1)
    local message = table.concat(args, " ")
    if Player.PlayerData.job.name == "police" then
        if OtherPlayer ~= nil then
            --TriggerClientEvent('chatMessage', OtherPlayer.PlayerData.source, "(POLITIE) " ..Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname, "error", message)
            TriggerClientEvent('chatMessage', OtherPlayer.PlayerData.source, "(POLITIE) ", "error", message)
            TriggerClientEvent("pepe-police:client:call:anim", source)
        end
    elseif Player.PlayerData.job.name == "ambulance" then
        if OtherPlayer ~= nil then 
           -- TriggerClientEvent('chatMessage', OtherPlayer.PlayerData.source, "(AMBULANCE) " ..Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname, "error", message)
            TriggerClientEvent('chatMessage', OtherPlayer.PlayerData.source, "(AMBULANCE) ", "error", message)
            TriggerClientEvent("pepe-police:client:call:anim", source)
        end
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Dit command is voor hulpdiensten!")
    end
end)

Framework.Commands.Add("unjail", "Haal persoon uit het gevang.", {{name="id", help="Speler ID"}}, true, function(source, args)
    local Player = Framework.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        local playerId = tonumber(args[1])
        TriggerClientEvent("pepe-prison:client:leave:prison", playerId)
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Alleen voor hulpdiensten.", "success")
    end
end)


Framework.Commands.Add("dna", "Neem dna af", {{"id", "Speler id"}}, true, function(source, args)
    local Player = Framework.Functions.GetPlayer(source)
    local OtherPlayer = Framework.Functions.GetPlayer(tonumber(args[1]))
    if ((Player.PlayerData.job.name == "police") and Player.PlayerData.job.onduty) and OtherPlayer ~= nil then
        if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
            local info = {
                label = "DNA-Monster",
                dnalabel = DnaHash(OtherPlayer.PlayerData.citizenid),
            }
            if Player.Functions.AddItem("dna-print", 1, false, info) then
                TriggerClientEvent("pepe-inventory:client:ItemBox", source, Framework.Shared.Items["dna-print"], "add")
            end
        else
            TriggerClientEvent('Framework:Notify', source, "Je hebt een leeg bewijszakje opzak nodig", "error")
        end
    end
end)

Framework.Commands.Add("enkelbandlocatie", "Haal locatie van persoon met enkelband", {{name="bsn", help="BSN van de burger"}}, true, function(source, args)
    local Player = Framework.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        if args[1] ~= nil then
            local citizenid = args[1]
            local Target = Framework.Functions.GetPlayerByCitizenId(citizenid)
            local Tracking = false
            if Target ~= nil then
                if Target.PlayerData.metadata["tracker"] and not Tracking then
                    Tracking = true
                    TriggerClientEvent("pepe-police:client:send:tracker:location", Target.PlayerData.source, Target.PlayerData.source)
                else
                    TriggerClientEvent('Framework:Notify', source, 'Dit persoon heeft geen enkelband...', 'error')
                end
            end
        end
    else
        TriggerClientEvent('chatMessage', source, "SYSTEEM", "error", "Dit commando is alleen voor hulpdiensten!")
    end
end)

Framework.Functions.CreateUseableItem("handcuffs", function(source, item)
    local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("pepe-police:client:cuff:closest", source)
    end
end)

-- // HandCuffs \\ --
RegisterServerEvent('pepe-police:server:cuff:closest')
AddEventHandler('pepe-police:server:cuff:closest', function(SeverId)
    local Player = Framework.Functions.GetPlayer(source)
    local CuffedPlayer = Framework.Functions.GetPlayer(SeverId)
    if CuffedPlayer ~= nil then
        TriggerClientEvent("pepe-police:client:get:cuffed", CuffedPlayer.PlayerData.source, Player.PlayerData.source)
    end
end)


function DnaHash(s)
    local h = string.gsub(s, ".", function(c)
		return string.format("%02x", string.byte(c))
	end)
    return h
end

RegisterServerEvent('pepe-police:server:set:handcuff:status')
AddEventHandler('pepe-police:server:set:handcuff:status', function(Cuffed)
	local Player = Framework.Functions.GetPlayer(source)
	if Player ~= nil then
		Player.Functions.SetMetaData("ishandcuffed", Cuffed)
	end
end)

RegisterServerEvent('pepe-police:server:escort:closest')
AddEventHandler('pepe-police:server:escort:closest', function(SeverId)
    local Player = Framework.Functions.GetPlayer(source)
    local EscortPlayer = Framework.Functions.GetPlayer(SeverId)
    if EscortPlayer ~= nil then
        if (EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"]) then
            TriggerClientEvent("pepe-police:client:get:escorted", EscortPlayer.PlayerData.source, Player.PlayerData.source)
        else
            TriggerClientEvent('chatMessage', source, "SYSTEEM", "error", "Persoon is niet dood of geboeid!")
        end
    end
end)

RegisterServerEvent('pepe-police:server:set:out:veh')
AddEventHandler('pepe-police:server:set:out:veh', function(ServerId)
    local Player = Framework.Functions.GetPlayer(source)
    local EscortPlayer = Framework.Functions.GetPlayer(ServerId)
    if EscortPlayer ~= nil then
        if EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] then
            TriggerClientEvent("pepe-police:client:set:out:veh", EscortPlayer.PlayerData.source)
        else
            TriggerClientEvent('chatMessage', source, "SYSTEEM", "error", "Persoon is niet dood of geboeid!")
        end
    end
end)

RegisterServerEvent('pepe-police:server:set:in:veh')
AddEventHandler('pepe-police:server:set:in:veh', function(ServerId)
    local Player = Framework.Functions.GetPlayer(source)
    local EscortPlayer = Framework.Functions.GetPlayer(ServerId)
    if EscortPlayer ~= nil then
        if EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] then
            TriggerClientEvent("pepe-police:client:set:in:veh", EscortPlayer.PlayerData.source)
        else
            TriggerClientEvent('chatMessage', source, "SYSTEEM", "error", "Persoon is niet dood of geboeid!")
        end
    end
end)

Framework.Functions.CreateCallback('pepe-police:server:is:player:dead', function(source, cb, playerId)
    local Player = Framework.Functions.GetPlayer(playerId)
    cb(Player.PlayerData.metadata["isdead"])
end)

RegisterServerEvent('pepe-police:server:SearchPlayer')
AddEventHandler('pepe-police:server:SearchPlayer', function(playerId)
    local src = source
    local SearchedPlayer = Framework.Functions.GetPlayer(playerId)
    if SearchedPlayer ~= nil then 
        TriggerClientEvent('chatMessage', source, "SYSTEEM", "warning", "Persoon heeft €"..SearchedPlayer.PlayerData.money["cash"]..",- op zak..")
        TriggerClientEvent('Framework:Notify', SearchedPlayer.PlayerData.source, "Je wordt gefouilleerd..")
    end
end)

RegisterServerEvent('pepe-police:server:rob:player')
AddEventHandler('pepe-police:server:rob:player', function(playerId)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    local SearchedPlayer = Framework.Functions.GetPlayer(playerId)
    if SearchedPlayer ~= nil then 
        local money = SearchedPlayer.PlayerData.money["cash"]
        Player.Functions.AddMoney("cash", money, "police-player-robbed")
        SearchedPlayer.Functions.RemoveMoney("cash", money, "police-player-robbed")
        TriggerClientEvent('Framework:Notify', SearchedPlayer.PlayerData.source, "Je bent van €"..money.." beroofd")
    end
    
    Player.Functions.SetMetaData("lockpickrep", Player.PlayerData.metadata["lockpickrep"]+1)
end)

RegisterServerEvent('pepe-police:server:send:call:alert')
AddEventHandler('pepe-police:server:send:call:alert', function(playerId, Coords, Message)
 local Player = Framework.Functions.GetPlayer(source)
 local Name = Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname..' ('..source..')'
 local AlertData = {title = "112 Melding - (".. playerId ..") "..Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. " ("..source..")", coords = {x = Coords.x, y = Coords.y, z = Coords.z}, description = Message}
 TriggerClientEvent("pepe-phone:client:addPoliceAlert", -1, AlertData)
 TriggerClientEvent("pepe-phone:client:addAmbuAlert", -1, AlertData)
 TriggerClientEvent('pepe-police:client:send:message', -1, Coords, Message, Name)
end)

RegisterServerEvent('pepe-police:server:spawn:object')
AddEventHandler('pepe-police:server:spawn:object', function(type)
    local src = source
    local objectId = CreateIdType('casing')
    Objects[objectId] = type
    TriggerClientEvent("pepe-police:client:place:object", -1, objectId, type, src)
end)

RegisterServerEvent('pepe-police:server:delete:object')
AddEventHandler('pepe-police:server:delete:object', function(objectId)
    local src = source
    TriggerClientEvent('pepe-police:client:remove:object', -1, objectId)
end)


Framework.Commands.Add("beslag", "Neem een voertuig in beslag", {}, true, function(source, args)
	local Player = Framework.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("pepe-police:client:hardimpound:closest", source, tonumber(args[1]))
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Alleen voor hulpdiensten.")
    end
end)


RegisterServerEvent('pepe-police:server:hardimpound')
AddEventHandler('pepe-police:server:hardimpound', function(plate)
    local src = source
    local state = "in"
    if IsVehicleOwned(plate) then
            exports['ghmattimysql']:execute('UPDATE characters_vehicles SET garage = @garage, state = @state WHERE plate = @plate', {['@garage'] = "Police", ['@state'] = "in", ['@plate'] = plate})
            TriggerClientEvent('Framework:Notify', src, "Voertuig opgenomen in depot.")
    end
end)


Framework.Commands.Add("duty", "Ga in of uit dienst", {}, true, function(source, args)
    local Player = Framework.Functions.GetPlayer(source)
        if Player.PlayerData.job.name == 'police' or Player.PlayerData.job.name == 'ambulance' or Player.PlayerData.job.name == 'mechanic' or Player.PlayerData.job.name == 'vanilla' or Player.PlayerData.job.name == 'burger' or Player.PlayerData.job.name == 'lawyer' or Player.PlayerData.job.name == 'realestate' then
         onDuty = Player.PlayerData.job.onduty
         TriggerClientEvent("pepe-police:client:Dienstklokker", source)
        else
            TriggerClientEvent('Framework:Notify', source, 'Alleen voor overheidsdiensten', 'error')
        end
end)

-- // Police Alerts Events \\ --

RegisterServerEvent('pepe-police:server:send:alert:officer:down')
AddEventHandler('pepe-police:server:send:alert:officer:down', function(Coords, StreetName, Info, Priority)
   TriggerClientEvent('pepe-police:client:send:officer:down', -1, Coords, StreetName, Info, Priority)
end)

RegisterServerEvent('pepe-police:server:send:alert:panic:button')
AddEventHandler('pepe-police:server:send:alert:panic:button', function(Coords, StreetName, Info)
    local AlertData = {title = "Assistentie collega", coords = {x = Coords.x, y = Coords.y, z = Coords.z}, description = "Noodknop ingedrukt door "..Info['Callsign'].." "..Info['Firstname']..' '..Info['Lastname'].." bij "..StreetName}
    TriggerClientEvent("pepe-phone:client:addPoliceAlert", -1, AlertData)
    TriggerClientEvent('pepe-police:client:send:alert:panic:button', -1, Coords, StreetName, Info)
end)

RegisterServerEvent('pepe-police:server:send:alert:gunshots')
AddEventHandler('pepe-police:server:send:alert:gunshots', function(Coords, GunType, StreetName, InVeh)
    local AlertData = {title = "Schoten Gelost",coords = {x = Coords.x, y = Coords.y, z = Coords.z}, description = 'Schoten gelost nabij ' ..StreetName}
    if InVeh then
      AlertData = {title = "Schoten Gelost",coords = {x = Coords.x, y = Coords.y, z = Coords.z}, description = 'Schoten gelost vanuit een voertuig, nabij ' ..StreetName}
    end
   TriggerClientEvent("pepe-phone:client:addPoliceAlert", -1, AlertData)
   TriggerClientEvent('pepe-police:client:send:alert:gunshots', -1, Coords, GunType, StreetName, InVeh)
end)

RegisterServerEvent('pepe-police:server:send:alert:dead')
AddEventHandler('pepe-police:server:send:alert:dead', function(Coords, StreetName)
   local AlertData = {title = "Gewonde Burger", coords = {x = Coords.x, y = Coords.y, z = Coords.z}, description = "Er is een gewonde burger gemeld nabij "..StreetName}
   TriggerClientEvent("pepe-phone:client:addPoliceAlert", -1, AlertData)
   TriggerClientEvent('pepe-police:client:send:alert:dead', -1, Coords, StreetName)
end)

RegisterServerEvent('pepe-police:server:send:bank:alert')
AddEventHandler('pepe-police:server:send:bank:alert', function(Coords, StreetName, CamId)
   local AlertData = {title = "Bank Alarm", coords = {x = Coords.x, y = Coords.y, z = Coords.z}, description = "Een Fleeca Bank alarm is afgegaan nabij "..StreetName}
   TriggerClientEvent("pepe-phone:client:addPoliceAlert", -1, AlertData)
   TriggerClientEvent('pepe-police:client:send:bank:alert', -1, Coords, StreetName, CamId)
end)

RegisterServerEvent('pepe-police:server:send:alert:jewellery')
AddEventHandler('pepe-police:server:send:alert:jewellery', function(Coords, StreetName)
   local AlertData = {title = "Juwelier Alarm", coords = {x = Coords.x, y = Coords.y, z = Coords.z}, description = "Het Vangelico Juwelier alarm is zojuist afgegaan nabij "..StreetName}
   TriggerClientEvent("pepe-phone:client:addPoliceAlert", -1, AlertData)
   TriggerClientEvent('pepe-police:client:send:alert:jewellery', -1, Coords, StreetName)
end)

RegisterServerEvent('pepe-police:server:send:alert:humanelabs')
AddEventHandler('pepe-police:server:send:alert:humanelabs', function(Coords, StreetName)
   local AlertData = {title = "Humanelabs Alarm", coords = {x = Coords.x, y = Coords.y, z = Coords.z}, description = "Humanelabs word overvallen "..StreetName}
   TriggerClientEvent("pepe-phone:client:addPoliceAlert", -1, AlertData)
   TriggerClientEvent('pepe-police:client:send:alert:humanelabs', -1, Coords, StreetName)
end)

RegisterServerEvent('pepe-police:server:send:alert:store')
AddEventHandler('pepe-police:server:send:alert:store', function(Coords, StreetName, StoreNumber)
   local AlertData = {title = "Winkel Alarm", coords = {x = Coords.x, y = Coords.y, z = Coords.z}, description = "Het alarm van winkel: "..StoreNumber..' is afgegaan nabij '..StreetName}
   TriggerClientEvent("pepe-phone:client:addPoliceAlert", -1, AlertData)
   TriggerClientEvent('pepe-police:client:send:alert:store', -1, Coords, StreetName, StoreNumber)
end)

RegisterServerEvent('pepe-police:server:send:house:alert')
AddEventHandler('pepe-police:server:send:house:alert', function(Coords, StreetName)
   local AlertData = {title = "Huis Alarm", coords = {x = Coords.x, y = Coords.y, z = Coords.z}, description = "Er is een Huisalarm systeem afgegaan nabij "..StreetName}
   TriggerClientEvent("pepe-phone:client:addPoliceAlert", -1, AlertData)
   TriggerClientEvent('pepe-police:client:send:house:alert', -1, Coords, StreetName)
end)

RegisterServerEvent('pepe-police:server:send:banktruck:alert')
AddEventHandler('pepe-police:server:send:banktruck:alert', function(Coords, Plate, StreetName)
   local AlertData = {title = "Bankwagen Alarm", coords = {x = Coords.x, y = Coords.y, z = Coords.z}, description = "Er is een Bankwagen alarm systeem afgegaan met het kenteken: "..Plate..'. nabij '..StreetName}
   TriggerClientEvent("pepe-phone:client:addPoliceAlert", -1, AlertData)
   TriggerClientEvent('pepe-police:client:send:banktruck:alert', -1, Coords, Plate, StreetName)
end)

RegisterServerEvent('pepe-police:server:alert:cornerselling')
AddEventHandler('pepe-police:server:alert:cornerselling', function(Coords, StreetName)
   local AlertData = {title = "Drugsverkoop", coords = {x = Coords.x, y = Coords.y, z = Coords.z}, description = "Vermoedelijke drugsverkoop bij: "..StreetName.."."}
   TriggerClientEvent("pepe-phone:client:addPoliceAlert", -1, AlertData)
   TriggerClientEvent('pepe-police:client:send:cornerselling:alert', -1, Coords, StreetName)
end)
RegisterServerEvent('pepe-police:server:alert:koperdief')
AddEventHandler('pepe-police:server:alert:koperdief', function(Coords, StreetName)
   local AlertData = {title = "Koperdiefstal", coords = {x = Coords.x, y = Coords.y, z = Coords.z}, description = "Vermoedelijke koperdief bij: "..StreetName.."."}
   TriggerClientEvent("pepe-phone:client:addPoliceAlert", -1, AlertData)
   TriggerClientEvent('pepe-police:client:send:koperdief:alert', -1, Coords, StreetName)
end)