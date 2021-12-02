Framework = exports["pepe-core"]:GetCoreObject() 
-- Code

local robberyAlert = false

local isLoggedIn = true

local firstAlarm = false

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

RegisterNetEvent('Framework:Client:OnPlayerLoaded')
AddEventHandler('Framework:Client:OnPlayerLoaded', function()
    isLoggedIn = true
end)

RegisterNetEvent('Framework:Client:OnPlayerUnload')
AddEventHandler('Framework:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 1500
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        inRange = false

        if Framework ~= nil then
            if isLoggedIn then
                PlayerData = Framework.Functions.GetPlayerData()
                for case,_ in pairs(Config.Locations) do
                    local dist = #(pos - vector3(Config.Locations[case]["coords"]["x"], Config.Locations[case]["coords"]["y"], Config.Locations[case]["coords"]["z"])) 
                    local storeDist = #(pos - vector3(Config.JewelleryLocation["coords"]["x"], Config.JewelleryLocation["coords"]["y"], Config.JewelleryLocation["coords"]["z"])) 
                    if dist < 4 then
                        inRange = true
                        sleep = 5
                        if dist < 0.6 then
                            if not Config.Locations[case]["isBusy"] and not Config.Locations[case]["isOpened"] then
                                DrawText3Ds(Config.Locations[case]["coords"]["x"], Config.Locations[case]["coords"]["y"], Config.Locations[case]["coords"]["z"], '[E] Stelen')
                                if IsControlJustPressed(0, Keys["E"]) then
                                    Framework.Functions.TriggerCallback('pepe-ifruit:server:getCops', function(cops)
                                        if cops >= Config.RequiredCops then
                                            --if validWeapon() then
                                                smashVitrine(case)
                                            --else
                                             --   Framework.Functions.Notify('Je wapen lijkt niet sterk genoeg.', 'error')
                                            --end
                                        else
                                            Framework.Functions.Notify('Er zijn niet genoeg agenten aanwezig.', 'error')
                                        end                
                                    end)
                                end
                            end
                        end

                        if storeDist < 2 then
                            if not firstAlarm then
                                --if validWeapon() then
                                    --Framework.Functions.TriggerCallback('pepe-ifruit:server:PoliceAlertMessage', function(result)
                                    --end, "Verdachte situatie", pos, true)
                                        TriggerEvent('dispatch:weaponrobbery')
                                        local cameraID = math.random(31,34)
                                    -- TriggerServerEvent('pepe-ifruit:server:PoliceAlertMessage', "Verdachte situatie", pos, true)
                                    firstAlarm = true
                               -- end
                            end
                        end
                    end
                end
            end
        end

        Citizen.Wait(sleep)
    end
end)

function loadParticle()
	if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
    RequestNamedPtfxAsset("scr_jewelheist")
    end
    while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
    Citizen.Wait(0)
    end
    SetPtfxAssetNextCall("scr_jewelheist")
end

function loadAnimDict(dict)  
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(3)
    end
end

function validWeapon()
    local ped = PlayerPedId()
    local pedWeapon = GetSelectedPedWeapon(ped)

    for k, v in pairs(Config.WhitelistedWeapons) do
        if pedWeapon == k then
            return true
        end
    end
    return false
end

local smashing = false

function smashVitrine(k)
    local animDict = "missheist_jewel"
    local animName = "smash_case"
    local ped = PlayerPedId()
    local plyCoords = GetOffsetFromEntityInWorldCoords(ped, 0, 0.6, 0)
    local pedWeapon = GetSelectedPedWeapon(ped)

    smashing = true

    Framework.Functions.Progressbar("smash_vitrine", "Goederen stelen...", "5000", false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        Framework.Functions.TriggerCallback('pepe-ifruit:server:setVitrineState', function(result)
        end, "isOpened", true, k)
        Framework.Functions.TriggerCallback('pepe-ifruit:server:setVitrineState', function(result)
        end, "isBusy", false, k)
        TriggerServerEvent('pepe-ifruit:server:setVitrineState', "isOpened", true, k)
        TriggerServerEvent('pepe-ifruit:server:setVitrineState', "isBusy", false, k)
        Framework.Functions.TriggerCallback('pepe-ifruit:vitrineReward', function()
        end)
        StealProp(1)
        Framework.Functions.TriggerCallback('pepe-ifruit:server:setTimeout', function(result)
        end)
        Framework.Functions.TriggerCallback('pepe-ifruit:server:PoliceAlertMessage', function(result)
        end, "Applestore overval", plyCoords, false)
        TriggerServerEvent('pepe-ifruit:server:setTimeout')
        TriggerServerEvent('pepe-ifruit:server:PoliceAlertMessage', "Apple Store overval", plyCoords, false)
        smashing = false
        TaskPlayAnim(ped, animDict, "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
    end, function() -- Cancel
        Framework.Functions.TriggerCallback('pepe-ifruit:server:setVitrineState', function(result)
        end, "isBusy", false, k)
        TriggerServerEvent('pepe-ifruit:server:setVitrineState', "isBusy", false, k)
        TaskPlayAnim(ped, animDict, "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
        smashing = false
    end)
    Framework.Functions.TriggerCallback('pepe-ifruit:server:setVitrineState', function(result)
    end, "isBusy", true, k)
    TriggerServerEvent('pepe-ifruit:server:setVitrineState', "isBusy", true, k)

    Citizen.CreateThread(function()
        while smashing do
            loadAnimDict(animDict)
            TaskPlayAnim(ped, animDict, animName, 3.0, 3.0, -1, 2, 0, 0, 0, 0 )
            Citizen.Wait(500)
            --TriggerServerEvent("InteractSound_SV:PlayOnSource", "breaking_vitrine_glass", 0.25)
            -- TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, "breaking_vitrine_glass", 0.25)
            loadParticle()
            StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", plyCoords.x, plyCoords.y, plyCoords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
            Citizen.Wait(2500)
        end
    end)
end

RegisterNetEvent('pepe-jewellery:client:set:extra:state')
AddEventHandler('pepe-jewellery:client:set:extra:state', function(Id, bool)
    Config.Items[Id]['Stolen'] = bool 
end)

function StealProp(Id)
    local StealObject = GetClosestObjectOfType(Config.Items[Id]['Coords']['X'], Config.Items[Id]['Coords']['Y'], Config.Items[Id]['Coords']['Z'], 5.0, GetHashKey(Config.Items[Id]['PropName']), false, false, false)
    NetworkRequestControlOfEntity(StealObject)
    DeleteEntity(StealObject)
    TriggerServerEvent('pepe-jewellery:server:recieve:items', Config['Items'], Id)
 end

RegisterNetEvent('pepe-ifruit:client:setVitrineState')
AddEventHandler('pepe-ifruit:client:setVitrineState', function(stateType, state, k)
    Config.Locations[k][stateType] = state
end)

RegisterNetEvent('pepe-ifruit:client:setAlertState')
AddEventHandler('pepe-ifruit:client:setAlertState', function(bool)
    robberyAlert = bool
end)

RegisterNetEvent('pepe-ifruit:client:executeEvents')
AddEventHandler('pepe-ifruit:client:executeEvents', function()
    TriggerServerEvent('pepe-ifruit:server:vitrineReward')
end)

RegisterNetEvent('pepe-ifruit:client:PoliceAlertMessage')
AddEventHandler('pepe-ifruit:client:PoliceAlertMessage', function(title, coords, blip)
    if blip then
        TriggerEvent('pepe-alerts:client:send:alert', {
            timeOut = 15000,
            alertTitle = title,
            details = {
                [1] = {
                    icon = '<i class="fas fa-raygun"></i>',
                    detail = "Applestore Overval",
                },
                [2] = {
                    icon = '<i class="fas fa-globe-europe"></i>',
                    detail = "Rockford Dr",
                },
            },
            callSign = Framework.Functions.GetPlayerData().metadata["callsign"],
        })
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        Citizen.Wait(100)
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        Citizen.Wait(100)
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        local transG = 100
        local blip = AddBlipForRadius(coords.x, coords.y, coords.z, 100.0)
        SetBlipSprite(blip, 9)
        SetBlipColour(blip, 1)
        SetBlipAlpha(blip, transG)
        SetBlipAsShortRange(blip, false)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("112 - Verdachte situatie bij de Applestore")
        EndTextCommandSetBlipName(blip)
        while transG ~= 0 do
            Wait(180 * 4)
            transG = transG - 1
            SetBlipAlpha(blip, transG)
            if transG == 0 then
                SetBlipSprite(blip, 2)
                RemoveBlip(blip)
                return
            end
        end
    else
        if not robberyAlert then
            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            TriggerEvent('pepe-alerts:client:send:alert', {
                timeOut = 15000,
                alertTitle = title,
                details = {
                    [1] = {
                        icon = '<i class="fas fa-raygun"></i>',
                        detail = "Applestore Overval",
                    },
                    [2] = {
                        icon = '<i class="fas fa-video"></i>',
                        detail = "32 | 33 | 34",
                    },
                    [3] = {
                        icon = '<i class="fas fa-globe-europe"></i>',
                        detail = "Rockford Dr",
                    },
                },
                callSign = Framework.Functions.GetPlayerData().metadata["callsign"],
            })
            robberyAlert = true
        end
    end
end)

function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
    local model = GetEntityModel(PlayerPedId())
    local retval = true
    if model == GetHashKey("mp_m_freemode_01") then
        if Config.MaleNoHandshoes[armIndex] ~= nil and Config.MaleNoHandshoes[armIndex] then
            retval = false
        end
    else
        if Config.FemaleNoHandshoes[armIndex] ~= nil and Config.FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval
end