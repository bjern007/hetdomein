local DutyBlips = {}
local ShopItems = {}
local ObjectList = {}
local NearPoliceGarage = false
local NearPoliceImpound = false
local CurrentGarage = nil
local allMyOutfits = {}
local sendnotify = false
local SpikeConfig = {
    MaxSpikes = 5
}
local SpawnedSpikes = {}
local spikemodel = "P_ld_stinger_s"
local nearSpikes = false
local spikesSpawned = false
local ClosestSpike = nil
local Locaties = {["Politie"] = {[1] = {["x"] = 473.78, ["y"] = -992.64, ["z"] = 26.27, ["h"] = 0.0}, [2] = {["x"] = -445.87, ["y"] = 6013.88, ["z"] = 31.71, ["h"] = 0.0}}}
local FingerPrintSession = nil
PlayerJob = {}
isLoggedIn = false
onDuty = false
local NumberCharset = {}
local Charset = {}
local Blips = {}
for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

-- Framework = nil

Framework = exports["pepe-core"]:GetCoreObject()

RegisterNetEvent('Framework:Client:OnPlayerLoaded')
AddEventHandler('Framework:Client:OnPlayerLoaded', function()
    Citizen.SetTimeout(1500, function()
    --  TriggerEvent("Framework:GetObject", function(obj) Framework = obj end)    
    --   Citizen.Wait(450)
      Framework.Functions.GetPlayerData(function(PlayerData)
      PlayerJob, onDuty = PlayerData.job, PlayerData.job.onduty 
      if PlayerJob.name == 'police' and PlayerData.job.onduty then
       TriggerEvent('pepe-radialmenu:client:update:duty:vehicles')
       TriggerEvent('pepe-police:client:set:radio')
    --    TriggerServerEvent("pepe-police:server:UpdateBlips")
       TriggerServerEvent("pepe-police:server:UpdateCurrentCops")
      end
      isLoggedIn = true 
      end)
    end)
end)


RegisterNetEvent('pepe-police:client:Dienstklokker')
AddEventHandler('pepe-police:client:Dienstklokker', function()
    Framework.Functions.GetPlayerData(function(PlayerData)
        PlayerJob, onDuty = PlayerData.job, PlayerData.job.onduty 
        if PlayerJob.name == 'police' or PlayerJob.name == 'ambulance' or PlayerJob.name == 'mechanic' or PlayerJob.name == 'realestate' or PlayerJob.name == 'vanilla' or PlayerJob.name == 'lawyer' or PlayerJob.name == 'burger' then
            if not onDuty then
                TriggerServerEvent("Framework:ToggleDuty", true)
                if PlayerJob.name == 'police' or PlayerJob.name == 'ambulance' then
                    TriggerEvent('pepe-radialmenu:client:update:duty:vehicles')
                    TriggerEvent('pepe-police:client:set:radio')
                    TriggerServerEvent("pepe-police:server:UpdateCurrentCops")
                end
            else 
                TriggerServerEvent("Framework:ToggleDuty", false)
            end
        end
        isLoggedIn = true 
    end)
end)

RegisterNetEvent('Framework:Client:OnPlayerLoaded')
AddEventHandler('Framework:Client:OnPlayerLoaded', function()
    Citizen.SetTimeout(3500, function()
        --  TriggerEvent("Framework:GetObject", function(obj) Framework = obj end)  
        --  Citizen.Wait(3500)
        Framework.Functions.GetPlayerData(function(PlayerData)
            local ped = PlayerPedId()
            local Sex = "Man"
    	    if PlayerData.charinfo.gender == 1 then
    	        Sex = "Vrouw"
    	    end

            if PlayerData.metadata['tracker'] then
                TriggerEvent('pepe-police:client:set:tracker', true)
            end

            if PlayerData.metadata['ishandcuffed'] then
                TriggerServerEvent('pepe-sound:server:play:distance', 2.0, 'handcuff', 0.2)
                Config.IsHandCuffed = true
             end

            if PlayerData.metadata['armor'] ~= 0 then
                if Sex == 'Man' then
                    SetPedComponentVariation(ped, 9, 57, 0, 2)
                    SetPedArmour(ped, PlayerData.metadata['armor'])
                else
                    SetPedComponentVariation(ped, 9, 34, 1, 2)
                    SetPedArmour(ped, PlayerData.metadata['armor'])
                end
            end
        isLoggedIn = true 
        end)
    end)
end)

RegisterNetEvent('Framework:Client:OnPlayerUnload')
AddEventHandler('Framework:Client:OnPlayerUnload', function()
    isLoggedIn = false
    if PlayerJob.name == 'police' then
      TriggerServerEvent("Framework:ToggleDuty", false)
      TriggerServerEvent("pepe-police:server:UpdateCurrentCops")
    --   if DutyBlips ~= nil then 
    --     for k, v in pairs(DutyBlips) do
    --         RemoveBlip(v)
    --     end
    --     DutyBlips = {}
    --   end
    end
    ClearPedTasks(PlayerPedId())
    DetachEntity(PlayerPedId(), true, false)
end)

RegisterNetEvent('Framework:Client:OnJobUpdate')
AddEventHandler('Framework:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    -- TriggerServerEvent("pepe-police:server:UpdateBlips")
    -- if (PlayerJob ~= nil) and PlayerJob.name ~= "police" or PlayerJob.name ~= 'ambulance' then
    --     if DutyBlips ~= nil then
    --         for k, v in pairs(DutyBlips) do
    --             RemoveBlip(v)
    --         end
    --     end
    --     DutyBlips = {}
    -- end
end)

RegisterNetEvent('Framework:Client:SetDuty')
AddEventHandler('Framework:Client:SetDuty', function(Onduty)
TriggerServerEvent("pepe-police:server:UpdateBlips")
--  if not Onduty then
--     if PlayerJob.name == 'police' or PlayerJob.name == 'ambulance' then
--      for k, v in pairs(DutyBlips) do
--          RemoveBlip(v)
--      end
--      DutyBlips = {}
--     end
--  end
 onDuty = Onduty
end)

RegisterNetEvent('pepe-police:client:SpawnSpikeStrip')
AddEventHandler('pepe-police:client:SpawnSpikeStrip', function()
    if #SpawnedSpikes + 1 < SpikeConfig.MaxSpikes then
        if PlayerJob.name == "police" and PlayerJob.onduty then
            local spawnCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, 0.0)
            local spike = CreateObject(GetHashKey(spikemodel), spawnCoords.x, spawnCoords.y, spawnCoords.z, 1, 1, 1)
            local netid = NetworkGetNetworkIdFromEntity(spike)
            SetNetworkIdExistsOnAllMachines(netid, true)
            SetNetworkIdCanMigrate(netid, false)
            SetEntityHeading(spike, GetEntityHeading(PlayerPedId()))
            PlaceObjectOnGroundProperly(spike)
            table.insert(SpawnedSpikes, {
                coords = {
                    x = spawnCoords.x,
                    y = spawnCoords.y,
                    z = spawnCoords.z,
                },
                netid = netid,
                object = spike,
            })
            spikesSpawned = true
            TriggerServerEvent('pepe-police:server:SyncSpikes', SpawnedSpikes)
            TriggerServerEvent('Framework:Server:RemoveItem', 'spikestrip', 1)
        end
    else
        Framework.Functions.Notify('There are no spikestrips left..', 'error')
    end
end)

RegisterNetEvent('pepe-police:client:SyncSpikes')
AddEventHandler('pepe-police:client:SyncSpikes', function(table)
    SpawnedSpikes = table
end)

Citizen.CreateThread(function()
    while true do
        if isLoggedIn then
            if ClosestSpike ~= nil then
                local tires = {
                    {bone = "wheel_lf", index = 0},
                    {bone = "wheel_rf", index = 1},
                    {bone = "wheel_lm", index = 2},
                    {bone = "wheel_rm", index = 3},
                    {bone = "wheel_lr", index = 4},
                    {bone = "wheel_rr", index = 5}
                }

                for a = 1, #tires do
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    local tirePos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, tires[a].bone))
                    local spike = GetClosestObjectOfType(tirePos.x, tirePos.y, tirePos.z, 15.0, GetHashKey(spikemodel), 1, 1, 1)
                    local spikePos = GetEntityCoords(spike, false)
                    local distance = Vdist(tirePos.x, tirePos.y, tirePos.z, spikePos.x, spikePos.y, spikePos.z)

                    if distance < 1.8 then
                        if not IsVehicleTyreBurst(vehicle, tires[a].index, true) or IsVehicleTyreBurst(vehicle, tires[a].index, false) then
                            SetVehicleTyreBurst(vehicle, tires[a].index, false, 1000.0)
                        end
                    end
                end
            end
        end

        Citizen.Wait(3)
    end
end)
-- Code

-- // Loops \\ --

Citizen.CreateThread(function()
    while true do

        if isLoggedIn then
            GetClosestSpike()
        end

        Citizen.Wait(500)
    end
end)


Citizen.CreateThread(function()
    while true do
        if isLoggedIn then
            if ClosestSpike ~= nil then
                local ped = PlayerPedId()
                local pos = GetEntityCoords(ped)
                local dist = GetDistanceBetweenCoords(pos, SpawnedSpikes[ClosestSpike].coords.x, SpawnedSpikes[ClosestSpike].coords.y, SpawnedSpikes[ClosestSpike].coords.z, true)

                if dist < 4 then
                    if not IsPedInAnyVehicle(PlayerPedId()) then
                        if PlayerJob.name == "police" and PlayerJob.onduty then
                            Framework.Functions.DrawText3D(pos.x, pos.y, pos.z, '[E] Verwijder')
                            if IsControlJustPressed(0, Config.Keys['E']) then
                                NetworkRegisterEntityAsNetworked(SpawnedSpikes[ClosestSpike].object)
                                NetworkRequestControlOfEntity(SpawnedSpikes[ClosestSpike].object)            
                                SetEntityAsMissionEntity(SpawnedSpikes[ClosestSpike].object)        
                                DeleteEntity(SpawnedSpikes[ClosestSpike].object)
                                table.remove(SpawnedSpikes, ClosestSpike)
                                ClosestSpike = nil
                                TriggerServerEvent('pepe-police:server:SyncSpikes', SpawnedSpikes)
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(3)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if isLoggedIn then
            if PlayerJob.name == "police" then
                NearAnything = false
                sendnotify = false
                local PlayerCoords = GetEntityCoords(PlayerPedId())
                for k, v in pairs(Config.Locations['checkin']) do 
                    local Area = GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, v['X'], v['Y'], v['Z'], true)
                    if Area < 2.0 then
                        NearAnything = true
                        DrawMarker(2, v['X'], v['Y'], v['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                        if not onDuty then
                            -- DrawText3D(v['X'], v['Y'], v['Z'] + 0.15, '~g~E~w~ - In Dienst')
                            if IsControlJustReleased(0, Config.Keys['E']) then
                                TriggerServerEvent("Framework:ToggleDuty", true)
                                TriggerEvent('pepe-radialmenu:client:update:duty:vehicles')
                                TriggerServerEvent("pepe-police:server:UpdateCurrentCops")
                            end
                        else
                            -- DrawText3D(v['X'], v['Y'], v['Z'] + 0.15, '~r~E~w~ - Uit Dienst')
                            if IsControlJustReleased(0, Config.Keys['E']) then
                                TriggerServerEvent("Framework:ToggleDuty", false)
                                TriggerEvent('pepe-radialmenu:client:update:duty:vehicles')
                                TriggerServerEvent("pepe-police:server:UpdateCurrentCops")
                            end
                        end
                    end
                end

               if onDuty then

                for k, v in pairs(Config.Locations['fingerprint']) do 
                    local Area = GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, v['X'], v['Y'], v['Z'], true)
                    if Area < 3.3 then
                        NearAnything = true
                        DrawMarker(2, v['X'], v['Y'], v['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                    end
                    if Area < 2.0 then
                        NearAnything = true
                        --  DrawText3D(v['X'], v['Y'], v['Z'] + 0.15, '~b~E~w~ - Vingerafdruk afnemen')
                         if IsControlJustReleased(0, Config.Keys['E']) then
                            local Player, Distance = Framework.Functions.GetClosestPlayer()
                            if Player ~= -1 and Distance < 2.5 then
                                 TriggerServerEvent("pepe-police:server:show:machine", GetPlayerServerId(Player))
                            else
                                Framework.Functions.Notify("Niemand in de buurt!", "error")
                            end
                        end
                    end
                end
                for k, v in pairs(Config.Locations['clothing']) do 
                    local Area = GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, v['X'], v['Y'], v['Z'], true)
                    if Area < 3.3 then
                        NearAnything = true
                        DrawMarker(2, v['X'], v['Y'], v['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                    end
                    if Area < 2.0 then
                        NearAnything = true
                        --  DrawText3D(v['X'], v['Y'], v['Z'] + 0.15, '~b~E~w~ - Outfits')
                         if IsControlJustReleased(0, Config.Keys['E']) then
                            TriggerServerEvent("pepe-outfits:server:openUI", true)
                        end
                    end
                end
                NearPoliceGarage = false
                for k, v in pairs(Config.Locations['garage']) do 
                    local Area = GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, v['X'], v['Y'], v['Z'], true)
                    if Area < 8.0 then
                        NearAnything = true
                        NearPoliceGarage = true
                        CurrentGarage = k
                    end
                end

                -- NearPoliceBossMenu = false

                -- for k, v in pairs(Config.Locations['boss']) do 
                --     local Area = GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, v['X'], v['Y'], v['Z'], true)
                --     if Area < 2.0 then
                --         NearAnything = true
                --         NearPoliceBossMenu = true
                --         DrawMarker(2, v['X'], v['Y'], v['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                --         DrawText3D(v['X'], v['Y'], v['Z'], "~r~E~w~ Baas")
                --         if IsControlJustReleased(0, Config.Keys["E"]) then
                --             TriggerServerEvent("pepe-bossmenu:server:openMenu")
                --         end
                --     end
                -- end

                NearPoliceImpound = false
                for k, v in pairs(Config.Locations['impound']) do 
                    -- print(v)
                    local Area = GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, v['X'], v['Y'], v['Z'], true)
                    if Area < 5.0 then
                        NearAnything = true
                        NearPoliceImpound = true
                        GarageG = Police
                                DrawMarker(2, v['X'], v['Y'], v['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                        -- DrawText3D(v['X'], v['Y'], v['Z'], "~r~E~w~ Impound")
                        if IsControlJustReleased(0, Config.Keys["E"]) then
                            exports['pepe-garages']:OpenImpoundGarage()
                        end
                    end
                end

                for k, v in pairs(Config.Locations['personal-safe']) do 
                    local Area = GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, v['X'], v['Y'], v['Z'], true)
                    if Area < 1.5 then
                        NearAnything = true
                        -- DrawText3D(v['X'], v['Y'], v['Z'] + 0.15, "~g~E~w~ - Persoonlijke Kluis")
                        DrawMarker(2, v['X'], v['Y'], v['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                        if IsControlJustReleased(0, Config.Keys["E"]) then
                          TriggerServerEvent("pepe-inventory:server:OpenInventory", "stash", "personalsafe_"..Framework.Functions.GetPlayerData().citizenid)
                          TriggerEvent("pepe-inventory:client:SetCurrentStash", "personalsafe_"..Framework.Functions.GetPlayerData().citizenid)
                        end
                    end
                end

                for k, v in pairs(Config.Locations['work-shops']) do 
                    local Area = GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, v['X'], v['Y'], v['Z'], true)
                    if Area < 1.5 then
                        NearAnything = true
                        -- DrawText3D(v['X'], v['Y'], v['Z'] + 0.15, "~g~E~w~ - Wapenkluis")
                        DrawMarker(2, v['X'], v['Y'], v['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                        if IsControlJustReleased(0, Config.Keys["E"]) then
                            SetWeaponSeries()
                            TriggerServerEvent("pepe-inventory:server:OpenInventory", "shop", "police", Config.Items)
                        end
                    end
                end


              end
              if not NearAnything then 
                  Citizen.Wait(1500)
                  CurrentGarage = nil
              end
            else
                Citizen.Wait(1000)
            end
        end 
    end
end)


RegisterNetEvent('pepe-police:client:getvehicles')
AddEventHandler('pepe-police:client:getvehicles', function()
	TriggerServerEvent('pepe-police:client:getvehicles')
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if Config.IsEscorted then
            DisableAllControlActions(0)
            EnableControlAction(0, 1, true)
			EnableControlAction(0, 2, true)
            EnableControlAction(0, 245, true)
            EnableControlAction(0, 38, true)
            EnableControlAction(0, 322, true)
        end
        if Config.IsHandCuffed then
            DisableControlAction(0, 24, true) 
			DisableControlAction(0, 257, true)
			DisableControlAction(0, 25, true) 
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 45, true)
			DisableControlAction(0, 22, true)
			DisableControlAction(0, 44, true)
			DisableControlAction(1, 37, true)
			DisableControlAction(0, 23, true)
			DisableControlAction(0, 288, true)
            DisableControlAction(2, 199, true)
            DisableControlAction(2, 244, true)
            DisableControlAction(0, 137, true)
			DisableControlAction(0, 59, true) 
			DisableControlAction(0, 71, true) 
			DisableControlAction(0, 72, true) 
			DisableControlAction(0, 73, true) 
			DisableControlAction(2, 36, true) 
			DisableControlAction(0, 264, true)
			DisableControlAction(0, 257, true)
			DisableControlAction(0, 140, true)
			DisableControlAction(0, 141, true)
			DisableControlAction(0, 142, true)
			DisableControlAction(0, 143, true)
			DisableControlAction(0, 75, true) 
            DisableControlAction(27, 75, true)
            DisableControlAction(0, 245, true)
            if (not IsEntityPlayingAnim(PlayerPedId(), "mp_arresting", "idle", 3) and not IsEntityPlayingAnim(PlayerPedId(), "mp_arrest_paired", "crook_p2_back_right", 3)) and not Framework.Functions.GetPlayerData().metadata["isdead"] then
                exports['pepe-assets']:RequestAnimationDict("mp_arresting")
                TaskPlayAnim(PlayerPedId(), "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
            end
        end
        if not Config.IsEscorted and not Config.IsHandCuffed then
            Citizen.Wait(2000)
        end
    end
end)


function format_thousand(v)
    local s = string.format("%d", math.floor(v))
    local pos = string.len(s) % 3
    if pos == 0 then pos = 3 end
    return string.sub(s, 1, pos)
            .. string.gsub(string.sub(s, pos+1), "(...)", ".%1")
end

function GeneratePlate()
    local plate = tostring(GetRandomNumber(1)) .. GetRandomLetter(2) .. tostring(GetRandomNumber(3)) .. GetRandomLetter(2)
    Framework.Functions.ExecuteSql(true, "SELECT * FROM `characters_vehicles` WHERE `plate` = @plate", {
        ['plate'] = plate,
    }, function(result)
        while (result[1] ~= nil) do
            plate = tostring(GetRandomNumber(1)) .. GetRandomLetter(2) .. tostring(GetRandomNumber(3)) .. GetRandomLetter(2)
        end
        return plate
    end)
    return plate:upper()
end

function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end


function GetClosestSpike()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil

    for id, data in pairs(SpawnedSpikes) do
        if current ~= nil then
            if(GetDistanceBetweenCoords(pos, SpawnedSpikes[id].coords.x, SpawnedSpikes[id].coords.y, SpawnedSpikes[id].coords.z, true) < dist)then
                current = id
            end
        else
            dist = GetDistanceBetweenCoords(pos, SpawnedSpikes[id].coords.x, SpawnedSpikes[id].coords.y, SpawnedSpikes[id].coords.z, true)
            current = id
        end
    end
    ClosestSpike = current
end

function MenuImpound()
    ped = PlayerPedId();
    MenuTitle = "Impound"
    ClearMenu()
    Menu.addButton("Voertuigen", "ImpoundVehicleList", nil)
    Menu.addButton("Sluit Menu", "closeMenuFull", nil) 
end

function ImpoundVehicleList()
    Framework.Functions.TriggerCallback("pepe-police:GetPoliceVehicles", function(result)
        ped = PlayerPedId();
        MenuTitle = "Voertuigen:"
        ClearMenu()

        if result == nil then
            Framework.Functions.Notify("Er zijn geen in beslag genomen voertuigen...", "error", 5000)
            closeMenuFull()
        else
            for k, v in pairs(result) do
                enginePercent = round(v.engine / 10, 0)
                bodyPercent = round(v.body / 10, 0)
                currentFuel = v.fuel

                Menu.addButton(Framework.Shared.Vehicles[v.vehicle]["name"], "HaalUitImpound", v, "In Beslag Genomen", " Motor: " .. enginePercent .. "%", " Pantser: " .. bodyPercent.. "%", " Benzine: "..currentFuel.. "%")
            end
        end
            
        Menu.addButton("Terug", "Menu Impound",nil)
    end)
end

function TakeOutImpound(vehicle)
    enginePercent = round(vehicle.engine / 10, 0)
    bodyPercent = round(vehicle.body / 10, 0)
    currentFuel = vehicle.fuel
    local coords = Config.Locations["impound"][currentGarage]
    Framework.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
        Framework.Functions.TriggerCallback('pepe-garage:server:GetVehicleProperties', function(properties)
            Framework.Functions.SetVehicleProperties(veh, properties)
            SetVehicleNumberPlateText(veh, vehicle.plate)
            SetEntityHeading(veh, coords.h)
            doCarDamage(veh, vehicle)
            closeMenuFull()
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            if vehicle.vehicle == "pzulu" then
                exports['pepe-vehiclekeys']:SetVehicleKey(GetVehicleNumberPlateText(veh), true)
            else
                exports['pepe-vehiclekeys']:SetVehicleKey(GetVehicleNumberPlateText(veh), true)
                exports['pepe-fuel']:SetFuelLevel(veh, GetVehicleNumberPlateText(veh), 100.0, false)
            end
            SetVehicleEngineOn(veh, true, true)
        end, vehicle.plate)
    end, coords, true)
end

-- // Events \\ --

-- RegisterNetEvent('pepe-police:client:UpdateBlips')
-- AddEventHandler('pepe-police:client:UpdateBlips', function(players)
--     if PlayerJob ~= nil and (PlayerJob.name == 'police' or PlayerJob.name == 'ambulance') and onDuty then
--         if DutyBlips ~= nil then 
--             for k, v in pairs(DutyBlips) do
--                 RemoveBlip(v)
--             end
--         end
--         DutyBlips = {}
--         if players ~= nil then
--             for k, data in pairs(players) do
--                 local id = GetPlayerFromServerId(data.source)
--                 if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
--                     CreateDutyBlips(id, data.label, data.job)
--                 end
--             end
--         end
-- 	end
-- end)

RegisterNetEvent('pepe-police:client:bill:player')
AddEventHandler('pepe-police:client:bill:player', function(price, type)
    local Table = {}
    local charinfo = Framework.Functions.GetPlayerData().charinfo
    local gender = "meneer"
    if Framework.Functions.GetPlayerData().charinfo.gender == 1 then
        gender = "mevrouw"
    end
    
    if type == "police" then 
        Table  = {
            sender = "Politie LS",
            subject = "Nieuwe boete",
            message = "Geachte " .. gender .. " " .. charinfo.lastname .. ",<br/><br />Het Centraal Justitieel Incassobureau (CJIB) heeft het geld dat u aan de staat verschuldigd was, van uw bankrekening afgeschreven.<br /><br />Totaalbedrag van de boete: <strong>€"..price.."</strong> <br/><br/>Met vriendelijke groet,<br />Het CJIB",
            button = {},
        }
    elseif type == "ambulance" then
        Table = {
            sender = "Geneeskunde LS",
            subject = "Nieuwe zorgkosten",
            message = "Geachte "..gender.." "..charinfo.lastname..",<br/><br/>Hierbij ontvangt u een rekening van €"..price..". Wij hebben dit bedrag met een automatische incasso van uw bankrekening afgeschreven. <br/><br/>Met vriendelijke groet,<br/>Geneeskunde Los Santos",
            button = {},
        }
    end

    SetTimeout(math.random(2500, 3000), function()
        TriggerServerEvent('pepe-phone:server:sendNewMail', Table)
        TriggerEvent('pepe-bossmenu:server:addAccountMoney', type, price)
    end)
end)

-- // Cuff & Escort Event \\ --
RegisterNetEvent('pepe-police:client:cuff:closest')
AddEventHandler('pepe-police:client:cuff:closest', function()
if not IsPedRagdoll(PlayerPedId()) then
    local Player, Distance = Framework.Functions.GetClosestPlayer()
    if Player ~= -1 and Distance < 1.5 then
        local ServerId = GetPlayerServerId(Player)
        if not IsPedInAnyVehicle(GetPlayerPed(Player)) and not IsPedInAnyVehicle(PlayerPedId(), false) then
            TriggerServerEvent("pepe-police:server:cuff:closest", ServerId, true)
            HandCuffAnimation()
        else
            Framework.Functions.Notify("Je kan niet boeien in een voertuig", "error")
        end
    else
        Framework.Functions.Notify("Niemand in de buurt!", "error")
    end
  else
      Citizen.Wait(2000)
  end
end)

RegisterNetEvent('pepe-police:client:get:cuffed')
AddEventHandler('pepe-police:client:get:cuffed', function()
    if not Config.IsHandCuffed then
        Config.IsHandCuffed = true
        TriggerServerEvent("pepe-police:server:set:handcuff:status", true)
        SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"), 1)
        ClearPedTasks(PlayerPedId())
        GetCuffedAnimation(playerId)
        Framework.Functions.Notify("Je bent geboeid, maar bent in staat om te lopen")
    else
        Config.IsEscorted = false
        Config.IsHandCuffed = false
        DetachEntity(PlayerPedId(), true, false)
        TriggerServerEvent("pepe-police:server:set:handcuff:status", false)
        ClearPedTasks(PlayerPedId())
        Framework.Functions.Notify("Je bent niet meer geboeid")
    end
end)

RegisterNetEvent('pepe-police:client:set:escort:status:false')
AddEventHandler('pepe-police:client:set:escort:status:false', function()
 if Config.IsEscorted then
  Config.IsEscorted = false
  DetachEntity(PlayerPedId(), true, false)
  ClearPedTasks(PlayerPedId())
 end
end)

RegisterNetEvent('pepe-police:client:escort:closest')
AddEventHandler('pepe-police:client:escort:closest', function()
    local Player, Distance = Framework.Functions.GetClosestPlayer()
    if Player ~= -1 and Distance < 2.5 then
        local ServerId = GetPlayerServerId(Player)
        if not Config.IsHandCuffed and not Config.IsEscorted then
          if not IsPedInAnyVehicle(PlayerPedId()) then
            TriggerServerEvent("pepe-police:server:escort:closest", ServerId)
        else
         Framework.Functions.Notify("Je kan niet escorteren in een voertuig!", "error")
       end
     end
    else
        Framework.Functions.Notify("Niemand in de buurt!", "error")
    end
end)

RegisterNetEvent('pepe-police:client:get:escorted')
AddEventHandler('pepe-police:client:get:escorted', function(PlayerId)
    if not Config.IsEscorted then
        Config.IsEscorted = true
        local dragger = GetPlayerPed(GetPlayerFromServerId(PlayerId))
        local heading = GetEntityHeading(dragger)
        SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(dragger, 0.0, 0.45, 0.0))
        AttachEntityToEntity(PlayerPedId(), dragger, 11816, 0.45, 0.45, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
    else
        Config.IsEscorted = false
        DetachEntity(PlayerPedId(), true, false)
    end
end)

RegisterNetEvent('pepe-police:client:PutPlayerInVehicle')
AddEventHandler('pepe-police:client:PutPlayerInVehicle', function()
    local Player, Distance = Framework.Functions.GetClosestPlayer()
    if Player ~= -1 and Distance < 2.5 then
        local ServerId = GetPlayerServerId(Player)
        if not Config.IsHandCuffed and not Config.IsEscorted  then
            TriggerServerEvent("pepe-police:server:set:in:veh", ServerId)
        end
    else
        Framework.Functions.Notify("Niemand in de buurt!", "error")
    end
end)

RegisterNetEvent('pepe-police:client:SetPlayerOutVehicle')
AddEventHandler('pepe-police:client:SetPlayerOutVehicle', function()
    local Player, Distance = Framework.Functions.GetClosestPlayer()
    if Player ~= -1 and Distance < 2.5 then
        local ServerId = GetPlayerServerId(Player)
        if not Config.IsHandCuffed and not Config.IsEscorted then
            TriggerServerEvent("pepe-police:server:set:out:veh", ServerId)
        end
    else
        Framework.Functions.Notify("Niemand in de buurt!", "error")
    end
end)

RegisterNetEvent('pepe-police:client:set:out:veh')
AddEventHandler('pepe-police:client:set:out:veh', function()
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        TaskLeaveVehicle(PlayerPedId(), vehicle, 16)
    end
end)

RegisterNetEvent('pepe-police:client:set:in:veh')
AddEventHandler('pepe-police:client:set:in:veh', function()
    if Config.IsHandCuffed or Config.IsEscorted then
        local vehicle = Framework.Functions.GetClosestVehicle()
        if DoesEntityExist(vehicle) then
			for i = GetVehicleMaxNumberOfPassengers(vehicle), -1, -1 do
                if IsVehicleSeatFree(vehicle, i) then
                    Config.IsEscorted = false
                    ClearPedTasks(PlayerPedId())
                    DetachEntity(PlayerPedId(), true, false)
                    Citizen.Wait(100)
                    SetPedIntoVehicle(PlayerPedId(), vehicle, i)
                    return
                end
            end
		end
    end
end)

RegisterNetEvent('pepe-police:client:steal:closest')
AddEventHandler('pepe-police:client:steal:closest', function()
    local player, distance = Framework.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerPed = GetPlayerPed(player)
        local playerId = GetPlayerServerId(player)
        if IsEntityPlayingAnim(playerPed, "missminuteman_1ig_2", "handsup_base", 3) or IsEntityPlayingAnim(playerPed, "mp_arresting", "idle", 3) or IsTargetDead(playerId) then
            Framework.Functions.Progressbar("robbing_player", "Robbing..", math.random(5000, 7000), false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "random@shop_robbery",
                anim = "robbery_action_b",
                flags = 16,
            }, {}, {}, function() -- Done
                local plyCoords = GetEntityCoords(playerPed)
                local pos = GetEntityCoords(PlayerPedId())
                local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, plyCoords.x, plyCoords.y, plyCoords.z, true)
                if dist < 2.5 then
                    StopAnimTask(PlayerPedId(), "random@shop_robbery", "robbery_action_b", 1.0)
                    TriggerServerEvent("pepe-inventory:server:OpenInventory", "otherplayer", playerId)
                    TriggerEvent("pepe-inventory:server:RobPlayer", playerId)
                else
                    StopAnimTask(PlayerPedId(), "random@shop_robbery", "robbery_action_b", 1.0)
                    Framework.Functions.Notify("Niemand in de buurt!", "error")
                end
            end, function() -- Cancel
                StopAnimTask(PlayerPedId(), "random@shop_robbery", "robbery_action_b", 1.0)
                Framework.Functions.Notify("Geannuleerd...", "error")
            end)
        end
    else
        Framework.Functions.Notify("Niemand in de buurt!", "error")
    end
end)

RegisterNetEvent('pepe-police:client:CheckStatus')
AddEventHandler('pepe-police:client:CheckStatus', function()
    Framework.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.job.name == "police" then
            local Player, Distance = Framework.Functions.GetClosestPlayer()
            if Player ~= -1 and Distance < 5.0 then
                local playerId = GetPlayerServerId(Player)
                Framework.Functions.TriggerCallback('pepe-police:GetPlayerStatus', function(result)
                    if result ~= nil then
                        for k, v in pairs(result) do
                            TriggerEvent("chatMessage", "STATUS", "warning", v)
                        end
                    end
                end, playerId)
            end
        end
    end)
end)

RegisterNetEvent('pepe-police:client:search:closest')
AddEventHandler('pepe-police:client:search:closest', function()
    local Player, Distance = Framework.Functions.GetClosestPlayer()
    if Player ~= -1 and Distance < 2.5 then
        local playerId = GetPlayerServerId(Player)
        TriggerServerEvent("pepe-inventory:server:OpenInventory", "otherplayer", playerId)
        TriggerServerEvent("pepe-police:server:SearchPlayer", playerId)
    else
        Framework.Functions.Notify("Niemand in de buurt!", "error")
    end
end)

RegisterNetEvent('pepe-police:client:impound:closest')
AddEventHandler('pepe-police:client:impound:closest', function() 
    local Vehicle, Distance = Framework.Functions.GetClosestVehicle()
    if Vehicle ~= 0 and Distance < 1.7 then
        Framework.Functions.Progressbar("impound-vehicle", "Voertuig in beslag nemen...", math.random(10000, 15000), false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "random@mugging4",
            anim = "struggle_loop_b_thief",
            flags = 49,
        }, {}, {}, function() -- Done
             Framework.Functions.DeleteVehicle(Vehicle)
             Framework.Functions.Notify("Voertuig is met succes in beslag genomen!", "success")
        end, function()
            Framework.Functions.Notify("Geannuleerd...", "error")
        end)
    else
        Framework.Functions.Notify("Geen voertuig in de buurt!", "error")
    end
end)




RegisterNetEvent('pepe-police:client:ImpoundVehicle')
AddEventHandler('pepe-police:client:ImpoundVehicle', function(price)
    local vehicle = Framework.Functions.GetClosestVehicle()
    if vehicle ~= 0 and vehicle ~= nil then
        local pos = GetEntityCoords(PlayerPedId())
        local vehpos = GetEntityCoords(vehicle)
        if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, vehpos.x, vehpos.y, vehpos.z, true) < 5.0) and not IsPedInAnyVehicle(PlayerPedId()) then
            local plate = GetVehicleNumberPlateText(vehicle)
            --TriggerServerEvent("pepe-police:server:hardimpound", plate, price)
            TriggerServerEvent("pepe-garages:server:set:in:impound", plate)
            Framework.Functions.DeleteVehicle(vehicle)
        end
    end
end)

RegisterNetEvent('pepe-police:client:hardimpound:closest')
AddEventHandler('pepe-police:client:hardimpound:closest', function() 
    local Vehicle, Distance = Framework.Functions.GetClosestVehicle()
    if Vehicle ~= 0 and Distance < 1.7 then
        local plate = GetVehicleNumberPlateText(Vehicle)
        Framework.Functions.Progressbar("impound-vehicle", "Voertuig in Politie Depot plaatsen...", math.random(10000, 15000), false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "random@mugging4",
            anim = "struggle_loop_b_thief",
            flags = 49,
        }, {}, {}, function() -- Done
            TriggerServerEvent("pepe-police:server:hardimpound", plate)
             Framework.Functions.DeleteVehicle(Vehicle)
             Framework.Functions.Notify("Voertuig is met succes in beslag genomen!", "success")
        end, function()
            Framework.Functions.Notify("Geannuleerd...", "error")
        end)
    else
        Framework.Functions.Notify("Geen voertuig in de buurt!", "error")
    end
end)


RegisterNetEvent('pepe-police:client:enkelband:closest')
AddEventHandler('pepe-police:client:enkelband:closest', function()
    local Player, Distance = Framework.Functions.GetClosestPlayer()
    if Player ~= -1 and Distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("pepe-police:server:set:tracker",  GetPlayerServerId(Player))
    else
        Framework.Functions.Notify("Niemand in de buurt!", "error")
    end
end)

RegisterNetEvent('pepe-police:client:set:tracker')
AddEventHandler('pepe-police:client:set:tracker', function(bool)
    local trackerClothingData = {}
    if bool then
        trackerClothingData.outfitData = {["accessory"] = { item = 13, texture = 0}}
        --TriggerEvent('pepe-clothing:client:loadOutfit', trackerClothingData) // Old QB Menu
    else
        trackerClothingData.outfitData = {["accessory"] = { item = -1, texture = 0}}
        --TriggerEvent('pepe-clothing:client:loadOutfit', trackerClothingData) // Old QB Menu
    end
end)

RegisterNetEvent('pepe-police:client:send:tracker:location')
AddEventHandler('pepe-police:client:send:tracker:location', function(RequestId)
    local Coords = GetEntityCoords(PlayerPedId())
    TriggerServerEvent('pepe-police:server:send:tracker:location', Coords, RequestId)
end)

RegisterNetEvent('pepe-police:client:show:machine')
AddEventHandler('pepe-police:client:show:machine', function(PlayerId)
    FingerPrintSession = PlayerId
    SendNUIMessage({
        type = "OpenFinger"
    })
    SetNuiFocus(true, true)
end)

RegisterNetEvent('pepe-police:client:show:fingerprint:id')
AddEventHandler('pepe-police:client:show:fingerprint:id', function(FingerPrintId)
 SendNUIMessage({
     type = "UpdateFingerId",
     fingerprintId = FingerPrintId
 })
 PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
end)

RegisterNetEvent('pepe-police:client:show:tablet')
AddEventHandler('pepe-police:client:show:tablet', function()
    exports['pepe-assets']:AddProp('Tablet')
    exports['pepe-assets']:RequestAnimationDict('amb@code_human_in_bus_passenger_idles@female@tablet@base')
    TaskPlayAnim(PlayerPedId(), "amb@code_human_in_bus_passenger_idles@female@tablet@base", "base", 3.0, 3.0, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(500)
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "databank",
    })
end)

RegisterNUICallback('ScanFinger', function(data)
    TriggerServerEvent('pepe-police:server:showFingerId', FingerPrintSession)
end)

RegisterNetEvent('pepe-police:client:spawn:vehicle')
AddEventHandler('pepe-police:client:spawn:vehicle', function(VehicleName)
    if VehicleName ~= 'pzulu' then
      local RandomCoords = Config.Locations['garage'][CurrentGarage]['Spawns'][math.random(1, #Config.Locations['garage'][CurrentGarage]['Spawns'])]
      local CoordTable = {x = RandomCoords['X'], y = RandomCoords['Y'], z = RandomCoords['Z'], a = RandomCoords['H']}    
      Framework.Functions.SpawnVehicle(VehicleName, function(Vehicle)
        SetVehicleNumberPlateText(Vehicle, Framework.Functions.GetPlayerData().job.plate)
        Citizen.Wait(25)
        exports['pepe-vehiclekeys']:SetVehicleKey(GetVehicleNumberPlateText(Vehicle), true)
        exports['pepe-fuel']:SetFuelLevel(Vehicle, GetVehicleNumberPlateText(Vehicle), 100, false)
        Framework.Functions.Notify('Jouw dienstvoertuig is in een van de parkeerplaatsen.', 'info')
       end, CoordTable, true, false)
    else
        local CoordTable = {x = 449.76, y = -980.87, z = 43.69, a = 90.57}
        Framework.Functions.SpawnVehicle('pzulu', function(Vehicle)
         SetVehicleNumberPlateText(Vehicle, Framework.Functions.GetPlayerData().job.plate)
         Citizen.Wait(25)
         exports['pepe-vehiclekeys']:SetVehicleKey(GetVehicleNumberPlateText(Vehicle), true)
         exports['pepe-fuel']:SetFuelLevel(Vehicle, GetVehicleNumberPlateText(Vehicle), 100, false)
         Framework.Functions.Notify('Zulu is klaar voor vertrek op de dak.', 'info')
        end, CoordTable, true, false)
    end
end)

-- RegisterNetEvent('pepe-police:client:spawn:vehicle')
-- AddEventHandler('pepe-police:client:spawn:vehicle', function(VehicleName)
--     if VehicleName ~= 'pzulu' then
--       local RandomCoords = Config.Locations['garage'][CurrentGarage]['Spawns'][math.random(1, #Config.Locations['garage'][CurrentGarage]['Spawns'])]
--       local CoordTable = {x = RandomCoords['X'], y = RandomCoords['Y'], z = RandomCoords['Z'], a = RandomCoords['H']}    
--       Framework.Functions.SpawnVehicle(VehicleName, function(Vehicle)
--         SetVehicleNumberPlateText(Vehicle, Framework.Functions.GetPlayerData().job.plate)
--         Citizen.Wait(25)
--         exports['pepe-vehiclekeys']:SetVehicleKey(GetVehicleNumberPlateText(Vehicle), true)
--         exports['pepe-fuel']:SetFuelLevel(Vehicle, GetVehicleNumberPlateText(Vehicle), 100, false)
--         Framework.Functions.Notify('Jouw dienstvoertuig is in een van de parkeerplaatsen.', 'info')
--        end, CoordTable, true, false)
--     else
--         local CoordTable = {x = 449.76, y = -980.87, z = 43.69, a = 90.57}
--         Framework.Functions.SpawnVehicle('pzulu', function(Vehicle)
--          SetVehicleNumberPlateText(Vehicle, Framework.Functions.GetPlayerData().job.plate)
--          Citizen.Wait(25)
--          exports['pepe-vehiclekeys']:SetVehicleKey(GetVehicleNumberPlateText(Vehicle), true)
--          exports['pepe-fuel']:SetFuelLevel(Vehicle, GetVehicleNumberPlateText(Vehicle), 100, false)
--          Framework.Functions.Notify('Zulu is klaar voor vertrek op de dak.', 'info')
--         end, CoordTable, true, false)
--     end
-- end)


RegisterNetEvent('pepe-police:client:open:evidence')
AddEventHandler('pepe-police:client:open:evidence', function(args)
 local Coords = GetEntityCoords(PlayerPedId())
 NearPolice = false
 for k, v in pairs(Locaties['Politie']) do
 local Gebied = GetDistanceBetweenCoords(Coords.x, Coords.y, Coords.z, v["x"], v["y"], v["z"], true)
   if Gebied <= 45.0 then
    NearPolice = true
     TriggerServerEvent("pepe-inventory:server:OpenInventory", "stash", "evidencestash_"..args, {
         maxweight = 2500000,
         slots = 50,
     })
     TriggerEvent("pepe-inventory:client:SetCurrentStash", "evidencestash_"..args)
   end
 end
 if not NearPolice then
    Framework.Functions.Notify("You need to be close nearby the Police station to use this function..", "error")
 end
end)

-- RegisterNetEvent('pepe-police:client:send:alert')
-- AddEventHandler('pepe-police:client:send:alert', function(Message, Anoniem)
--     local PlayerData = Framework.Functions.GetPlayerData()
--       if Anoniem then
--         if (Framework.Functions.GetPlayerData().job.name == "police") and Framework.Functions.GetPlayerData().job.onduty then
--          TriggerEvent('chatMessage', "ANONIEME MELDING - ", "warning", Message)
--          PlaySoundFrontend( -1, "Beep_Green", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
--         end
--       else
--         local PlayerCoords = GetEntityCoords(PlayerPedId())
--         TriggerServerEvent("pepe-police:server:send:call:alert", PlayerCoords, Message)
--         TriggerEvent("pepe-police:client:call:anim")
--       end
-- end)

RegisterNetEvent('pepe-police:client:send:alert')
AddEventHandler('pepe-police:client:send:alert', function(Message, Anoniem)
    local PlayerData = Framework.Functions.GetPlayerData()
      if Anoniem then
        if (Framework.Functions.GetPlayerData().job.name == "police") and Framework.Functions.GetPlayerData().job.onduty then
         TriggerEvent('chatMessage', "ANONIEME MELDING - ", "warning", Message)
         PlaySoundFrontend( -1, "Beep_Green", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
        end
      else
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        local playerId = source
        TriggerServerEvent("pepe-police:server:send:call:alert", playerId, PlayerCoords, Message)
        TriggerEvent("pepe-police:client:call:anim")
      end
end)

RegisterNetEvent('pepe-police:client:send:message')
AddEventHandler('pepe-police:client:send:message', function(Coords, Message, Name)
    if (Framework.Functions.GetPlayerData().job.name == "police" or Framework.Functions.GetPlayerData().job.name == "ambulance") and Framework.Functions.GetPlayerData().job.onduty then
        TriggerEvent('chatMessage', "112 MELDING - " ..Name, "warning", Message)
        PlaySoundFrontend( -1, "Beep_Green", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
        AddAlert('112', 66, 250, Coords)
    end
end)

RegisterNetEvent('pepe-police:client:call:anim')
AddEventHandler('pepe-police:client:call:anim', function()
    local isCalling = true
    local callCount = 5
    exports['pepe-assets']:RequestAnimationDict("cellphone@")
    TaskPlayAnim(PlayerPedId(), 'cellphone@', 'cellphone_call_listen_base', 3.0, -1, -1, 49, 0, false, false, false)
    Citizen.Wait(1000)
    Citizen.CreateThread(function()
        while isCalling do
            Citizen.Wait(1000)
            callCount = callCount - 1
            if callCount <= 0 then
                isCalling = false
                StopAnimTask(PlayerPedId(), 'cellphone@', 'cellphone_call_listen_base', 1.0)
            end
        end
    end)
end)

RegisterNetEvent('pepe-police:client:spawn:object')
AddEventHandler('pepe-police:client:spawn:object', function(Type)
    Framework.Functions.Progressbar("spawn-object", "Object plaatsen..", 2500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@narcotics@trash",
        anim = "drop_front",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        TriggerServerEvent("pepe-police:server:spawn:object", Type)
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        Framework.Functions.Notify("Geannuleerd...", "error")
    end)
end)

RegisterNetEvent('pepe-police:client:delete:object')
AddEventHandler('pepe-police:client:delete:object', function()
    local objectId, dist = GetClosestPoliceObject()
    if dist < 5.0 then
        Framework.Functions.Progressbar("remove-object", "Removing object..", 2500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "weapons@first_person@aim_rng@generic@projectile@thermal_charge@",
            anim = "plant_floor",
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(PlayerPedId(), "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)
            TriggerServerEvent("pepe-police:server:delete:object", objectId)
        end, function() -- Cancel
            StopAnimTask(PlayerPedId(), "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)
            Framework.Functions.Notify("Geannuleerd...", "error")
        end)
    end
end)

RegisterNetEvent('pepe-police:client:place:object')
AddEventHandler('pepe-police:client:place:object', function(objectId, type, player)
    local coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(player)))
    local heading = GetEntityHeading(GetPlayerPed(GetPlayerFromServerId(player)))
    local forward = GetEntityForwardVector(PlayerPedId())
    local x, y, z = table.unpack(coords + forward * 0.5)
    local spawnedObj = CreateObject(Config.Objects[type].model, x, y, z, false, false, false)
    PlaceObjectOnGroundProperly(spawnedObj)
    SetEntityHeading(spawnedObj, heading)
    FreezeEntityPosition(spawnedObj, Config.Objects[type].freeze)
    ObjectList[objectId] = {
        id = objectId,
        object = spawnedObj,
        coords = {
            x = x,
            y = y,
            z = z - 0.3,
        },
    }
end)

RegisterNetEvent('pepe-police:client:remove:object')
AddEventHandler('pepe-police:client:remove:object', function(objectId)
    NetworkRequestControlOfEntity(ObjectList[objectId].object)
    DeleteObject(ObjectList[objectId].object)
    ObjectList[objectId] = nil
end)

RegisterNetEvent('pepe-police:client:set:radio')
AddEventHandler('pepe-police:client:set:radio', function()
 Framework.Functions.TriggerCallback('Framework:HasItem', function(HasItem)
    if HasItem then
        Framework.Functions.Notify("Je hebt geen rechten voor OC-01", "info", 8500)
    end
 end, "radio")
end)

-- // Functions \\ --

-- function CreateDutyBlips(playerId, playerLabel, playerJob)
-- 	local ped = GetPlayerPed(playerId)
--     local blip = GetBlipFromEntity(ped)
-- 	if not DoesBlipExist(blip) then
-- 		blip = AddBlipForEntity(ped)
-- 		SetBlipSprite(blip, 480)
--         SetBlipScale(blip, 1.0)
--         if playerJob == "police" then
--             SetBlipColour(blip, 38)
--         else
--             SetBlipColour(blip, 35)
--         end
--         SetBlipAsShortRange(blip, true)
--         BeginTextCommandSetBlipName('STRING')
--         AddTextComponentString(playerLabel)
--         EndTextCommandSetBlipName(blip)
-- 		table.insert(DutyBlips, blip)
-- 	end
-- end

RegisterNetEvent('pepe-blips:client:updateBlips')
AddEventHandler('pepe-blips:client:updateBlips', function(data)
    if not Framework or not Framework.Functions.GetPlayerData().job then
        return
    end
    
    for _, blip in pairs(Blips) do
        RemoveBlip(blip)
    end

    Blips = {}

    local job = Framework.Functions.GetPlayerData().job.name
    if job ~= 'police' and job ~= 'ambulance' then
        return
    end

    for _, player in pairs(data) do
        local ped = GetPlayerPed(GetPlayerFromServerId(player[1]))

        blip = AddBlipForEntity(ped)
        SetBlipSprite(blip, 1)
        SetBlipScale(blip, 0.8)
        if player[2] == 'police' then
            SetBlipColour(blip, 3)
            SetBlipShowCone(blip, true)
        else
            SetBlipColour(blip, 23)
        end
        SetBlipAsShortRange(blip, true)
        SetBlipDisplay(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(player[3])
        EndTextCommandSetBlipName(blip)

        table.insert(Blips, blip)
    end
end)

function HandCuffAnimation()
 exports['pepe-assets']:RequestAnimationDict("mp_arrest_paired")
 Citizen.Wait(100)
 TaskPlayAnim(PlayerPedId(), "mp_arrest_paired", "cop_p2_back_right", 3.0, 3.0, -1, 48, 0, 0, 0, 0)
 Citizen.Wait(3500)
 TaskPlayAnim(PlayerPedId(), "mp_arrest_paired", "exit", 3.0, 3.0, -1, 48, 0, 0, 0, 0)
end

function GetCuffedAnimation(playerId)
 local cuffer = GetPlayerPed(GetPlayerFromServerId(playerId))
 local heading = GetEntityHeading(cuffer)
 exports['pepe-assets']:RequestAnimationDict("mp_arrest_paired")
 TriggerServerEvent('pepe-sound:server:play:distance', 2.0, 'handcuff', 0.2)
 SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(cuffer, 0.0, 0.45, 0.0))
 Citizen.Wait(100)
 SetEntityHeading(PlayerPedId(), heading)
 TaskPlayAnim(PlayerPedId(), "mp_arrest_paired", "crook_p2_back_right", 3.0, 3.0, -1, 32, 0, 0, 0, 0)
 Citizen.Wait(2500)
end

function GetClosestPoliceObject()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil
    for id, data in pairs(ObjectList) do
        if current ~= nil then
            if(GetDistanceBetweenCoords(pos, ObjectList[id].coords.x, ObjectList[id].coords.y, ObjectList[id].coords.z, true) < dist)then
                current = id
                dist = GetDistanceBetweenCoords(pos, ObjectList[id].coords.x, ObjectList[id].coords.y, ObjectList[id].coords.z, true)
            end
        else
            dist = GetDistanceBetweenCoords(pos, ObjectList[id].coords.x, ObjectList[id].coords.y, ObjectList[id].coords.z, true)
            current = id
        end
    end
    return current, dist
end

function DrawText3D(x, y, z, text)
 SetTextScale(0.35, 0.35)
 SetTextFont(4)
 SetTextProportional(1)
 SetTextColour(255, 255, 255, 215)
 SetTextEntry("STRING")
 SetTextCentre(true)
 AddTextComponentString(text)
 SetDrawOrigin(x,y,z, 0)
 DrawText(0.0, 0.0)
 ClearDrawOrigin()
end

function IsTargetDead(playerId)
 local IsDead = false
  Framework.Functions.TriggerCallback('pepe-police:server:is:player:dead', function(result)
    IsDead = result
  end, playerId)
  Citizen.Wait(100)
  return IsDead
end


function GetVehicleList()
    local VehicleData = Framework.Functions.GetPlayerData().metadata['duty-vehicles']
    local Vehicles = {}
    if VehicleData.Standard then
        table.insert(Vehicles, "vehicle:delete")
        table.insert(Vehicles, "police:vehicle:fiets")
        table.insert(Vehicles, "police:vehicle:touran")
        table.insert(Vehicles, "police:vehicle:touran11")
        table.insert(Vehicles, "police:vehicle:klasse")
        table.insert(Vehicles, "police:vehicle:vito")
        table.insert(Vehicles, "police:vehicle:amarok")
        table.insert(Vehicles, "police:vehicle:pvito")
        table.insert(Vehicles, "police:vehicle:gevang")
        table.insert(Vehicles, "police:vehicle:pfosprinter")        
    end

    if VehicleData.Audi then
        table.insert(Vehicles, "police:vehicle:audi")
    end

    if VehicleData.Unmarked then
        table.insert(Vehicles, "police:vehicle:velar")
        table.insert(Vehicles, "police:vehicle:pschafter")
        table.insert(Vehicles, "police:vehicle:dsimerc")
        table.insert(Vehicles, "police:vehicle:pmas")
        table.insert(Vehicles, "police:vehicle:dsiq5")
        table.insert(Vehicles, "police:vehicle:prs6")
        table.insert(Vehicles, "police:vehicle:pbal")
        table.insert(Vehicles, "police:vehicle:dsivito")
    end

    if VehicleData.Heli then 
        table.insert(Vehicles, "police:vehicle:heli")
    end
    
    if VehicleData.Motor then
        table.insert(Vehicles, "police:vehicle:motor")
        table.insert(Vehicles, "police:vehicle:pyamahamotor")
    end

    return Vehicles
end

function SetWeaponSeries()
 Config.Items.items[1].info.serie = Framework.Functions.GetPlayerData().job.serial
 Config.Items.items[2].info.serie = Framework.Functions.GetPlayerData().job.serial
 Config.Items.items[3].info.serie = Framework.Functions.GetPlayerData().job.serial
end

function GetGarageStatus()
    return NearPoliceGarage
end

function GetImpoundStatus()
    return NearPoliceImpound
end


function GetEscortStatus()
    return Config.IsEscorted
end

RegisterNUICallback('CloseNui', function()
 SetNuiFocus(false, false)
 if exports['pepe-assets']:GetPropStatus() then
    exports['pepe-assets']:RemoveProp()
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
    TaskPlayAnim(PlayerPedId(), "amb@code_human_in_bus_passenger_idles@female@tablet@base", "exit", 3.0, 3.0, -1, 49, 0, 0, 0, 0)
 end
end)