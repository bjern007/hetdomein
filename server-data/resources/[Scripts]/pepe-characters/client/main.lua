Framework = nil
-- Framework = exports["pepe-core"]:GetCoreObject()
local charPed = nil

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(10)
        if Framework == nil then
            TriggerEvent("Framework:GetObject", function(obj) Framework = obj end)    
            Citizen.Wait(200)
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if NetworkIsSessionStarted() then
			TriggerEvent('pepe-characters:client:chooseChar')
			return
		end
	end
end)

Config = {
    PedCoords = {x = -44.22, y = -575.89, z = 88.71, h = 215.56, r = 1.0}, 
    HiddenCoords = {x = -41.60, y = -576.48, z = 88.73, h = 51.06, r = 1.0}, 
    CamCoords = {x = -43.68, y = -574.19, z = 88.71, h = 251.88, r = 1.0}, 
}

--- CODE

local choosingCharacter = false
local cam = nil

function openCharMenu(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "ui",
        toggle = bool,
    })
    choosingCharacter = bool
    skyCam(bool)
end

RegisterNUICallback('closeUI', function()
    openCharMenu(false)
end)

RegisterNUICallback('selectCharacter', function(data)
    local cData = data.cData
    DoScreenFadeOut(100)
    TriggerServerEvent('pepe-characters:server:loadUserData', cData)
    openCharMenu(false)
    SetEntityAsMissionEntity(charPed, true, true)
    DeleteEntity(charPed)
end)

RegisterNetEvent('pepe-characters:client:closeNUI')
AddEventHandler('pepe-characters:client:closeNUI', function()
    SetNuiFocus(false, false)
end)

local Countdown = 1

RegisterNetEvent('pepe-characters:client:chooseChar')
AddEventHandler('pepe-characters:client:chooseChar', function()
    SetNuiFocus(false, false)
    DoScreenFadeOut(10)
    Citizen.Wait(1000)
    local interior = GetInteriorAtCoords(-814.89, 181.95, 76.85 - 18.9)
    LoadInterior(interior)
    while not IsInteriorReady(interior) do
         Citizen.Wait(1000)
    end
    SetEntityVisible(PlayerPedId(), false)
    FreezeEntityPosition(PlayerPedId(), true)
    SetEntityCoords(PlayerPedId(), 296.22, -992.08, -99.0)
    Citizen.Wait(1500)
    ShutdownLoadingScreenNui()
    ShutdownLoadingScreen()
    Citizen.Wait(1)
    ShutdownLoadingScreenNui()
    ShutdownLoadingScreen()
    openCharMenu(true)
end)

function selectChar()
    openCharMenu(true)
end

RegisterNUICallback('cDataPed', function(data)
    local cData = data.cData  
    SetEntityAsMissionEntity(charPed, true, true)
    DeleteEntity(charPed)
    if cData ~= nil then
        Framework.Functions.TriggerCallback('pepe-characters:server:getSkin', function(model, data)
            model = model ~= nil and tonumber(model) or false
            if model ~= nil then
                Citizen.CreateThread(function()
                    RequestModel(model)
                    while not HasModelLoaded(model) do
                        Citizen.Wait(0)
                    end
                    charPed = CreatePed(2, model, 306.25, -991.09, -99.99, 89.5, false, true)
                    SetPedComponentVariation(charPed, 0, 0, 0, 2)
                    FreezeEntityPosition(charPed, false)
                    SetEntityInvincible(charPed, true)
                    PlaceObjectOnGroundProperly(charPed)
                    SetBlockingOfNonTemporaryEvents(charPed, true)
                    data = json.decode(data)
                    TriggerEvent('pepe-clothing:client:loadPlayerClothing', data, charPed)
                    -- TriggerEvent(fivem-appearance:setOutfit, data)
                end)
            else
                Citizen.CreateThread(function()
                    local randommodels = {
                        "mp_m_freemode_01",
                        "mp_f_freemode_01",
                    }
                    local model = GetHashKey(randommodels[math.random(1, #randommodels)])
                    RequestModel(model)
                    while not HasModelLoaded(model) do
                        Citizen.Wait(0)
                    end
                    charPed = CreatePed(2, model, 306.25, -991.09, -99.99, 89.5, false, true)
                    SetPedComponentVariation(charPed, 0, 0, 0, 2)
                    FreezeEntityPosition(charPed, false)
                    SetEntityInvincible(charPed, true)
                    PlaceObjectOnGroundProperly(charPed)
                    SetBlockingOfNonTemporaryEvents(charPed, true)
                end)
            end
        end, cData.citizenid)
    else
        Citizen.CreateThread(function()
            local randommodels = {
                "mp_m_freemode_01",
                "mp_f_freemode_01",
            }
            local model = GetHashKey(randommodels[math.random(1, #randommodels)])
            RequestModel(model)
            while not HasModelLoaded(model) do
                Citizen.Wait(0)
            end
            charPed = CreatePed(2, model, 306.25, -991.09, -99.99, 89.5, false, true)
            SetPedComponentVariation(charPed, 0, 0, 0, 2)
            FreezeEntityPosition(charPed, false)
            SetEntityInvincible(charPed, true)
            PlaceObjectOnGroundProperly(charPed)
            SetBlockingOfNonTemporaryEvents(charPed, true)
        end)
    end
end)


RegisterNUICallback('setupCharacters', function()
    Framework.Functions.TriggerCallback("pepe-characters:server:get:char:data", function(result)
        SendNUIMessage({
            action = "setupCharacters",
            characters = result
        })
    end)
end)


RegisterNUICallback('removeBlur', function()
    SetTimecycleModifier('default')
end)

RegisterNUICallback('createNewCharacter', function(data)
    local cData = data
    openCharMenu(false)
    DoScreenFadeOut(100)
    if cData.gender == "man" then
        cData.gender = 0
    elseif cData.gender == "vrouw" then
        cData.gender = 1
    end
    TriggerServerEvent('pepe-characters:server:createCharacter', cData)
    Citizen.Wait(500)
end)

RegisterNUICallback('removeCharacter', function(data)
    TriggerServerEvent('pepe-characters:server:deleteCharacter', data.citizenid)
end)

function skyCam(bool)
    SetRainFxIntensity(0.0)
    SetWeatherTypePersist('EXTRASUNNY')
    SetWeatherTypeNow('EXTRASUNNY')
    SetWeatherTypeNowPersist('EXTRASUNNY')
    NetworkOverrideClockTime(12, 0, 0)
    if bool then
        DoScreenFadeIn(1000)
        SetTimecycleModifier('hud_def_blur')
        SetTimecycleModifierStrength(1.0)
        FreezeEntityPosition(PlayerPedId(), false)
        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -42.65, -578.29, 88.71, 0.0, 0.0 , 38.02, 60.00, 60.00, false, 0)
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 1, true, true)
    else
        SetTimecycleModifier('default')
        SetCamActive(cam, false)
        DestroyCam(cam, true)
        RenderScriptCams(false, false, 1, true, true)
        FreezeEntityPosition(PlayerPedId(), false)
    end
end