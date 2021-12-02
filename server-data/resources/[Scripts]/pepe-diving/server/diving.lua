local CurrentDivingArea = math.random(1, #QBDiving.Locations)

Framework.Functions.CreateCallback('pepe-diving:server:GetDivingConfig', function(source, cb)
    cb(QBDiving.Locations, CurrentDivingArea)
end)

RegisterServerEvent('pepe-diving:server:TakeCoral')
AddEventHandler('pepe-diving:server:TakeCoral', function(Area, Coral, Bool)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    local CoralType = math.random(1, #QBDiving.CoralTypes)
    local Amount = math.random(1, QBDiving.CoralTypes[CoralType].maxAmount)
    local ItemData = Framework.Shared.Items[QBDiving.CoralTypes[CoralType].item]

    if Amount > 1 then
        for i = 1, Amount, 1 do
            Player.Functions.AddItem(ItemData["name"], 1)
            TriggerClientEvent('pepe-inventory:client:ItemBox', src, ItemData, "add")
            Citizen.Wait(250)
        end
    else
        Player.Functions.AddItem(ItemData["name"], Amount)
        TriggerClientEvent('pepe-inventory:client:ItemBox', src, ItemData, "add")
    end

    if (QBDiving.Locations[Area].TotalCoral - 1) == 0 then
        for k, v in pairs(QBDiving.Locations[CurrentDivingArea].coords.Coral) do
            v.PickedUp = false
        end
        QBDiving.Locations[CurrentDivingArea].TotalCoral = QBDiving.Locations[CurrentDivingArea].DefaultCoral

        local newLocation = math.random(1, #QBDiving.Locations)
        while (newLocation == CurrentDivingArea) do
            Citizen.Wait(3)
            newLocation = math.random(1, #QBDiving.Locations)
        end
        CurrentDivingArea = newLocation
        
        TriggerClientEvent('pepe-diving:client:NewLocations', -1)
    else
        QBDiving.Locations[Area].coords.Coral[Coral].PickedUp = Bool
        QBDiving.Locations[Area].TotalCoral = QBDiving.Locations[Area].TotalCoral - 1
    end

    TriggerClientEvent('pepe-diving:server:UpdateCoral', -1, Area, Coral, Bool)
end)

RegisterServerEvent('pepe-diving:server:RemoveGear')
AddEventHandler('pepe-diving:server:RemoveGear', function()
    local src = source
    local Player = Framework.Functions.GetPlayer(src)

    Player.Functions.RemoveItem("diving_gear", 1)
    TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items["diving_gear"], "remove")
end)

RegisterServerEvent('pepe-diving:server:GiveBackGear')
AddEventHandler('pepe-diving:server:GiveBackGear', function()
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    
    Player.Functions.AddItem("diving_gear", 1)
    TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items["diving_gear"], "add")
end)