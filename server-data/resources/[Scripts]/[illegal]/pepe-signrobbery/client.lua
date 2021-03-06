Framework = nil

Citizen.CreateThread(function()
    while Framework == nil do
        TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)
        Citizen.Wait(200)
    end
end)

RegisterNetEvent("stopsign:client:Target")
AddEventHandler("stopsign:client:Target", function()
    local coords = GetEntityCoords(PlayerPedId())
    local obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 10.0, -949234773, false, false, false)
    SetEntityAsMissionEntity(obj, true, true)
    loadAnimDict("amb@prop_human_bum_bin@base")
    TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@base", "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    Framework.Functions.Progressbar("robbing_sign", "Bord aan het stelen", math.random(5000, 7000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, function()
    end, function()
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@base", "base", 1.0)
        TriggerServerEvent("stopsign:server:additem")
        DeleteEntity(obj)
    end)
end)

RegisterNetEvent('pepe-signrobbery:client:anim')
AddEventHandler('pepe-signrobbery:client:anim', function(bool)
    if not bool then
        exports['pepe-assets']:AddProp('Stopsign')
    else
        exports['pepe-assets']:RemoveProp()
    end
end)

RegisterNetEvent("walkingmansign:client:Target")
AddEventHandler("walkingmansign:client:Target", function()
    local coords = GetEntityCoords(PlayerPedId())
    local obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 10.0, 1502931467, false, false, false)
    SetEntityAsMissionEntity(obj, true, true)
    loadAnimDict("amb@prop_human_bum_bin@base")
    TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@base", "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    Framework.Functions.Progressbar("robbing_sign", "Voetgangers bord stelen", math.random(5000, 7000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, function()
    end, function()
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@base", "base", 1.0)
        TriggerServerEvent("walkingmansign:server:additem")
        DeleteEntity(obj)
    end)
end)

RegisterNetEvent("dontblockintersectionsign:client:Target")
AddEventHandler("dontblockintersectionsign:client:Target", function()
    local coords = GetEntityCoords(PlayerPedId())
    local obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 10.0, 1191039009, false, false, false)
    SetEntityAsMissionEntity(obj, true, true)
    loadAnimDict("amb@prop_human_bum_bin@base")
    TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@base", "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    Framework.Functions.Progressbar("robbing_sign", "Aan het stelen", math.random(5000, 7000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, function()
    end, function()
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@base", "base", 1.0)
        TriggerServerEvent("dontblockintersectionsign:server:additem")
        DeleteEntity(obj)
    end)
end)

RegisterNetEvent("uturnsign:client:Target")
AddEventHandler("uturnsign:client:Target", function()
    local coords = GetEntityCoords(PlayerPedId())
    local obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 10.0, 4138610559, false, false, false)
    SetEntityAsMissionEntity(obj, true, true)
    loadAnimDict("amb@prop_human_bum_bin@base")
    TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@base", "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    Framework.Functions.Progressbar("robbing_sign", "Aan het stelen", math.random(5000, 7000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, function()
    end, function()
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@base", "base", 1.0)
        TriggerServerEvent("uturnsign:server:additem")
        DeleteEntity(obj)
    end)
end)

function loadAnimDict(dict)
    while(not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(1)
    end
end