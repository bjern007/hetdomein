isLoggedIn = false
PlayerData = {}

Framework = exports["pepe-core"]:GetCoreObject()

local ClosestTraphouse = nil
local InsideTraphouse = false
local CurrentTraphouse = nil
local TraphouseObj = {}
local POIOffsets = nil
local IsKeyHolder = false
local IsHouseOwner = false
local InTraphouseRange = false
local CodeNPC = nil
local IsRobbingNPC = false
local takeover = false
local MenuOpen = false
local Selling = false

local HouseData, OffSets = nil, nil

-- Code

Citizen.CreateThread(function()
    while true do
        if isLoggedIn then
            SetClosestTraphouse()
        end
        Citizen.Wait(1000)
    end
end)

Citizen.CreateThread(function()
    Wait(1000)
    if Framework.Functions.GetPlayerData() ~= nil then
        isLoggedIn = true
        PlayerData = Framework.Functions.GetPlayerData()
        Framework.Functions.TriggerCallback('pepe-traphouses:server:GetTraphousesData', function(trappies)
            Config.TrapHouses = trappies
        end)
    end
end)

RegisterNetEvent('Framework:Client:OnPlayerLoaded')
AddEventHandler('Framework:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerData = Framework.Functions.GetPlayerData()
    Framework.Functions.TriggerCallback('pepe-traphouses:server:GetTraphousesData', function(trappies)
        Config.TrapHouses = trappies
    end)
end)

function SetClosestTraphouse()
    local pos = GetEntityCoords(GetPlayerPed(-1), true)
    local current = nil
    local dist = nil
    for id, traphouse in pairs(Config.TrapHouses) do
        if current ~= nil then
            if(GetDistanceBetweenCoords(pos, Config.TrapHouses[id].coords.enter.x, Config.TrapHouses[id].coords.enter.y, Config.TrapHouses[id].coords.enter.z, true) < dist)then
                current = id
                dist = GetDistanceBetweenCoords(pos, Config.TrapHouses[id].coords.enter.x, Config.TrapHouses[id].coords.enter.y, Config.TrapHouses[id].coords.enter.z, true)
            end
        else
            dist = GetDistanceBetweenCoords(pos, Config.TrapHouses[id].coords.enter.x, Config.TrapHouses[id].coords.enter.y, Config.TrapHouses[id].coords.enter.z, true)
            current = id
        end
    end
    ClosestTraphouse = current
    IsKeyHolder = HasKey(PlayerData.citizenid)
    IsHouseOwner = IsOwner(PlayerData.citizenid)
end

function HasKey(CitizenId)
    local haskey = false
    if ClosestTraphouse ~= nil then
        if Config.TrapHouses[ClosestTraphouse].keyholders ~= nil and next(Config.TrapHouses[ClosestTraphouse].keyholders) ~= nil then
            for _, data in pairs(Config.TrapHouses[ClosestTraphouse].keyholders) do
                if data.citizenid == CitizenId then
                    haskey = true
                end
            end
        end
    end
    return haskey
end

function IsOwner(CitizenId)
    local retval = false
    if ClosestTraphouse ~= nil then
        if Config.TrapHouses[ClosestTraphouse].keyholders ~= nil and next(Config.TrapHouses[ClosestTraphouse].keyholders) ~= nil then
            for _, data in pairs(Config.TrapHouses[ClosestTraphouse].keyholders) do
                if data.citizenid == CitizenId then
                    if data.owner then
                        retval = true
                    else
                        retval = false
                    end
                end
            end
        end
    end
    return retval
end

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

RegisterNetEvent('pepe-traphouses:client:EnterTraphouse')
AddEventHandler('pepe-traphouses:client:EnterTraphouse', function(code)
    if ClosestTraphouse ~= nil then
        if InTraphouseRange then
            local data = Config.TrapHouses[ClosestTraphouse]
            if not IsKeyHolder then
                SendNUIMessage({
                    action = "open"
                })
                SetNuiFocus(true, true)
            else
                EnterTraphouse(data)
            end
        end
    end
end)

RegisterNUICallback('PinpadClose', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('ErrorMessage', function(data)
    Framework.Functions.Notify(data.message, 'error')
end)

RegisterNUICallback('EnterPincode', function(d)
    local data = Config.TrapHouses[ClosestTraphouse]
    if tonumber(d.pin) == data.pincode then
        EnterTraphouse(data)
    else
        Framework.Functions.Notify('Deze code is incorrect..', 'error')
    end
end)

local CanRob = true

function RobTimeout(timeout)
    SetTimeout(timeout, function()
        CanRob = true
    end)
end

local RobbingTime = 3

function IsInVehicle()
    local ply = GetPlayerPed(-1)
    if IsPedSittingInAnyVehicle(ply) then
      return true
    else
      return false
    end
  end

Citizen.CreateThread(function()
    while true do
        local aiming, targetPed = GetEntityPlayerIsFreeAimingAt(PlayerId(-1))

        if targetPed ~= 0 and not IsPedAPlayer(targetPed) then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            if ClosestTraphouse ~= nil then
                local data = Config.TrapHouses[ClosestTraphouse]
                local dist = GetDistanceBetweenCoords(pos, data.coords["enter"].x, data.coords["enter"].y, data.coords["enter"].z, true)
                if dist < 100 then
                    if (IsInVehicle()) then
                        return
                    else
                        if aiming then
                            local pcoords = GetEntityCoords(targetPed)
                            local peddist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, pcoords.x, pcoords.y, pcoords.z, true)
                            if peddist < 4 then
                                InDistance = true
                                if not IsRobbingNPC and CanRob then
                                    if IsPedInAnyVehicle(targetPed) then
                                        TaskLeaveVehicle(targetPed, GetVehiclePedIsIn(targetPed), 1)
                                    end
                                    Citizen.Wait(500)
                                    InDistance = true
    
                                    local dict = 'random@mugging3'
                                    RequestAnimDict(dict)
                                    while not HasAnimDictLoaded(dict) do
                                        Citizen.Wait(10)
                                    end
                            
                                    SetEveryoneIgnorePlayer(PlayerId(), true)
                                    TaskStandStill(targetPed, RobbingTime * 1000)
                                    FreezeEntityPosition(targetPed, true)
                                    SetBlockingOfNonTemporaryEvents(targetPed, true)
                                    TaskPlayAnim(targetPed, dict, 'handsup_standing_base', 2.0, -2, 15.0, 1, 0, 0, 0, 0)
                                    for i = 1, RobbingTime / 2, 1 do
                                        PlayAmbientSpeech1(targetPed, "GUN_BEG", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
                                        Citizen.Wait(2000)
                                    end
                                    FreezeEntityPosition(targetPed, true)
                                    IsRobbingNPC = true
                                    SetTimeout(RobbingTime, function()
                                        IsRobbingNPC = false
                                        RobTimeout(math.random(30000, 60000))
                                        if not IsEntityDead(targetPed) then
                                            if CanRob then
                                                if InDistance then
                                                    SetEveryoneIgnorePlayer(PlayerId(), false)
                                                    SetBlockingOfNonTemporaryEvents(targetPed, false)
                                                    FreezeEntityPosition(targetPed, false)
                                                    ClearPedTasks(targetPed)
                                                    AddShockingEventAtPosition(99, GetEntityCoords(targetPed), 0.5)
                                                    Framework.Functions.TriggerCallback('pepe-traphouses:server:RobNpc', function(result)
                                                    end, ClosestTraphouse)
                                                    -- TriggerServerEvent('pepe-traphouses:server:RobNpc', ClosestTraphouse)
                                                    CanRob = false
                                                end
                                            end
                                        end
                                    end)
                                end
                            else
                                if InDistance then
                                    InDistance = false
                                end
                            end
                        end
                    end  
                end
            else
                Citizen.Wait(1000)
            end
        end
        Citizen.Wait(3)
    end
end)

Citizen.CreateThread(function()
    while true do

        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        local inRange = false

        if ClosestTraphouse ~= nil then
            -- print(ClosestTraphouse)
            local data = Config.TrapHouses[ClosestTraphouse]
            if InsideTraphouse then
                local ExitDistance = GetDistanceBetweenCoords(pos, data.coords["enter"].x + 2, data.coords["enter"].y - 5, data.coords["enter"].z - Config.MinZOffset, true)
                if ExitDistance < 990 then
                    -- print(data.coords["enter"].x + 2, data.coords["enter"].y - 5, data.coords["enter"].z - Config.MinZOffset)
                    inRange = true
                    if ExitDistance < 5 and not takeover then
                        DrawText3Ds(data.coords["enter"].x + 2, data.coords["enter"].y - 5, data.coords["enter"].z - Config.MinZOffset, '~b~E~w~ - Verlaten')
                        if IsControlJustPressed(0, Keys["E"]) then
                            LeaveTraphouse(data)
                        end
                    end
                end

                local InteractDistance = GetDistanceBetweenCoords(pos, data.coords["interaction"].x, data.coords["interaction"].y, data.coords["interaction"].z, true)
                if InteractDistance < 4 then
                    inRange = true
                    if InteractDistance < 1 and not MenuOpen then
                        if not IsKeyHolder then
                            DrawText3Ds(data.coords["interaction"].x, data.coords["interaction"].y, data.coords["interaction"].z + 0.2, '~b~H~w~ - Menu')
                            -- DrawText3Ds(data.coords["interaction"].x, data.coords["interaction"].y, data.coords["interaction"].z, '~b~E~w~ - Traphouse overnemen (~g~€20000~w~)')
                            if IsControlJustPressed(0, Keys["H"]) then
                                TriggerEvent('pepe-traphouses:client:interact')
                            end
                        else
                            DrawText3Ds(data.coords["interaction"].x, data.coords["interaction"].y, data.coords["interaction"].z + 0.2, '~b~H~w~ - Open Menu')
                            DrawText3Ds(data.coords["interaction"].x, data.coords["interaction"].y, data.coords["interaction"].z, '~b~Contant geld ~g~€~w~'..data.money..'')
                            if IsHouseOwner then
                                DrawText3Ds(data.coords["interaction"].x, data.coords["interaction"].y, data.coords["interaction"].z - 0.2, '~b~/geeftrapsleutels~w~ [id] - Om sleutels te geven')
                                DrawText3Ds(data.coords["interaction"].x, data.coords["interaction"].y, data.coords["interaction"].z - 0.4, '~b~G~w~ - Pincode zien')
                                if IsControlJustPressed(0, Keys["G"]) then
                                    Framework.Functions.Notify('Pincode: '..data.pincode)
                                end
                            end
                            if IsControlJustPressed(0, Keys["H"]) then
                                TriggerEvent('pepe-traphouses:client:interact')
                            end
                        end
                    end
                end
            else
                local EnterDistance = GetDistanceBetweenCoords(pos, data.coords["enter"].x, data.coords["enter"].y, data.coords["enter"].z, true)
                if EnterDistance < 20 then
                    inRange = true
                    if EnterDistance < 1 then
                        InTraphouseRange = true
                    else
                        if InTraphouseRange then
                            InTraphouseRange = false
                        end
                    end
                end
            end
        else
            Citizen.Wait(2000)
        end

        Citizen.Wait(3)
    end
end)



function CanPlayerEnterTraphouse()
    return InTraphouseRange
end

function EnterTraphouse(data)
    local coords = { x = data.coords["enter"].x, y = data.coords["enter"].y, z= data.coords["enter"].z - Config.MinZOffset}
    TriggerEvent("pepe-sound:client:play", "house-door-open", 0.1)
    data = exports['pepe-interiors']:TrapHouse(coords)

    TraphouseObj = data[1]
    POIOffsets = data[2]
    CurrentTraphouse = ClosestTraphouse
    InsideTraphouse = true
    SetRainFxIntensity(0.0)
    TriggerEvent('pepe-weathersync:client:DisableSync')
    FreezeEntityPosition(TraphouseObj, true)
    SetWeatherTypePersist('EXTRASUNNY')
    SetWeatherTypeNow('EXTRASUNNY')
    SetWeatherTypeNowPersist('EXTRASUNNY')
    NetworkOverrideClockTime(23, 0, 0)
end

function LeaveTraphouse(data)
    local ped = GetPlayerPed(-1)
    TriggerEvent("pepe-sound:client:play", "house-door-open", 0.1)
    DoScreenFadeOut(250)
    Citizen.Wait(250)
    exports['pepe-interiors']:DespawnInterior(TraphouseObj, function()
        TriggerEvent('pepe-weathersync:client:EnableSync')
        DoScreenFadeIn(250)
        SetEntityCoords(ped, data.coords["enter"].x, data.coords["enter"].y, data.coords["enter"].z + 0.5)
        SetEntityHeading(ped, data.coords["enter"].h)
        TraphouseObj = nil
        POIOffsets = nil
        CurrentTraphouse = nil
        InsideTraphouse = false
        MenuOpen = false
    end)
end


RegisterNetEvent("pepe-traphouses:client:pakgeld")
AddEventHandler("pepe-traphouses:client:pakgeld", function()
    Framework.Functions.TriggerCallback('pepe-traphouses:server:TakeMoney', function(result)
    end, CurrentTraphouse)  
    MenuOpen = false
end)

RegisterNetEvent("pepe-traphouses:client:takeover")
AddEventHandler("pepe-traphouses:client:takeover", function()

    Framework.Functions.TriggerCallback('pepe-traphouses:server:TakeoverHouse', function(result)
    end, CurrentTraphouse)  
    MenuOpen = false    
end)

RegisterNetEvent("pepe-traphouses:client:interact")
AddEventHandler("pepe-traphouses:client:interact", function()
    local citizenid = Framework.Functions.GetPlayerData().citizenid
    PlayerJob = Framework.Functions.GetPlayerData().job
    MenuOpen = true
    TriggerEvent('nh-context:sendMenu', { --send the close button all the time
        {
            id = 0,
            header = "Traphouse",
            txt = "",
        },        
    }) 
    
    if IsKeyHolder then

    TriggerEvent('nh-context:sendMenu', { --send the close button all the time
            {
                id = 1,
                header = "Verkoop Items",
                txt = "",
                params = {
                    event = "pepe-traphouses:client:sell", 
                }
            },
            {
                id = 2,
                header = "Craften",
                txt = "",
                params = {
                    event = "pepe-traphouses:client:close2",
                }
            },
            {
                id = 3,
                header = "Neem Geld",
                txt = "",
                params = {
                    event = "pepe-traphouses:client:pakgeld",
                }
            },
            
        }) 
    end
    
    if not IsKeyHolder then
        
    TriggerEvent('nh-context:sendMenu', { --send the close button all the time
            {
                id = 4,
                header = "Overnemen (20.000)",
                txt = "",
                params = {
                    event = "pepe-traphouses:client:takeover", 
                }
            },
        }) 
        end
    TriggerEvent('nh-context:sendMenu', { --send the close button all the time
        {
            id = 9999,
            header = "Sluit Menu",
            txt = "",
            params = {
                event = "pepe-traphouses:client:close",
            }
        },   
    }) 
end)

RegisterNetEvent('pepe-traphouses:client:close')
AddEventHandler('pepe-traphouses:client:close', function()
    TriggerEvent('nh-context:closeMenu')
    MenuOpen = false
end)

RegisterNetEvent('pepe-traphouses:client:close2')
AddEventHandler('pepe-traphouses:client:close2', function()
    TriggerEvent('pepe-crafting:client:trapstation')
    MenuOpen = false
end)

RegisterNetEvent("pepe-traphouses:client:sell")
AddEventHandler("pepe-traphouses:client:sell", function()
    TryToSell()
    MenuOpen = false
end)


function TryToSell()
    Framework.Functions.TriggerCallback("pepe-traphouses:server:has:sell:item", function(HasSellItem)
        if HasSellItem then
            TriggerServerEvent('pepe-traphouses:server:set:selling:state', true)
            Citizen.SetTimeout(math.random(90000, 120000), function()
                TriggerServerEvent('pepe-traphouses:server:sell:item')
                TriggerServerEvent('pepe-traphouses:server:set:selling:state', false)
            end)
        else
            Framework.Functions.Notify('Je hebt geen items om te verkopen.', 'error')
        end
    end)
end


RegisterNetEvent('pepe-traphouses:client:TakeoverHouse')
AddEventHandler('pepe-traphouses:client:TakeoverHouse', function(TraphouseId)
    local ped = GetPlayerPed(-1)

    takeover = true
    Framework.Functions.Progressbar("takeover_traphouse", "Traphouse aan het overnemen", math.random(1800, 3000), false, true, {
        -- Framework.Functions.Progressbar("takeover_traphouse", "Traphouse aan het overnemen", math.random(180000, 300000), false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        Framework.Functions.TriggerCallback('pepe-traphouses:server:AddHouseKeyHolder', function(result)
        end, PlayerData.citizenid, TraphouseId, true)
        takeover = false
        -- TriggerServerEvent('pepe-traphouses:server:AddHouseKeyHolder', PlayerData.citizenid, TraphouseId, true)
    end, function()
        takeover = false
        Framework.Functions.Notify("Overnamen geannuleerd..", "error")
    end)
end)

function HasCitizenIdHasKey(CitizenId, Traphouse)
    local retval = false
    for _, data in pairs(Config.TrapHouses[Traphouse].keyholders) do
        if data.citizenid == CitizenId then
            retval = true
            break
        end
    end
    return retval
end

function AddKeyHolder(CitizenId, Traphouse)
    if #Config.TrapHouses[Traphouse].keyholders <= 6 then
        if not HasCitizenIdHasKey(CitizenId, Traphouse) then
            if #Config.TrapHouses[Traphouse].keyholders == 0 then
                table.insert(Config.TrapHouses[Traphouse].keyholders, {
                    citizenid = CitizenId,
                    owner = true,
                })
            else
                table.insert(Config.TrapHouses[Traphouse].keyholders, {
                    citizenid = CitizenId,
                    owner = false,
                })
            end
            Framework.Functions.Notify(CitizenId..' is toegevoegd aan de traphouse!')
        else
            Framework.Functions.Notify(CitizenId..' dit persoon heeft al sleutels!')
        end
    else
        Framework.Functions.Notify('Je kan max 6 andere toegang geven tot de traphouse!')
    end
    IsKeyHolder = HasKey(CitizenId)
    IsHouseOwner = IsOwner(CitizenId)
end

RegisterNetEvent('pepe-traphouses:client:SyncData')
AddEventHandler('pepe-traphouses:client:SyncData', function(k, data)
    Config.TrapHouses[k] = data
    IsKeyHolder = HasKey(PlayerData.citizenid)
    IsHouseOwner = IsOwner(PlayerData.citizenid)
end)