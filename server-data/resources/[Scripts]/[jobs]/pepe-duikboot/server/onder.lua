local Bail = {}
local CurrentDivingArea = math.random(1, #PEPEduikboot.Locations)
local Framework = exports["pepe-core"]:GetCoreObject()

Framework.Functions.CreateCallback('pepe-duikboot:server:GetDivingConfig', function(source, cb)
    cb(PEPEduikboot.Locations, CurrentDivingArea)
end)




Framework.Functions.CreateCallback('pepe-duikboot:server:HasMoney', function(source, cb)
    local Player = Framework.Functions.GetPlayer(source)
    local CitizenId = Player.PlayerData.citizenid

    if Player.PlayerData.money.cash >= Config.BailPrice then
        Bail[CitizenId] = "cash"
        Player.Functions.RemoveMoney('cash', Config.BailPrice)
        cb(true)
    elseif Player.PlayerData.money.bank >= Config.BailPrice then
        Bail[CitizenId] = "bank"
        Player.Functions.RemoveMoney('bank', Config.BailPrice)
        cb(true)
    else
        cb(false)
    end
end)

Framework.Functions.CreateCallback('pepe-duikboot:server:CheckBail', function(source, cb)
    local Player = Framework.Functions.GetPlayer(source)
    local CitizenId = Player.PlayerData.citizenid

    if Bail[CitizenId] ~= nil then
        Player.Functions.AddMoney(Bail[CitizenId], Config.BailPrice, 'pepe-duikboot:server:CheckBail')
        Bail[CitizenId] = nil
        cb(true)
    else
        cb(false)
    end
end)



RegisterServerEvent('pepe-duikboot:server:TakeVuil')
AddEventHandler('pepe-duikboot:server:TakeVuil', function(Area, Vuiligheid, Bool)
    local Player = Framework.Functions.GetPlayer(source)
    local SubValue = math.random(1,3)
    if SubValue == 1 then
        Player.Functions.AddItem('iron', math.random(20,25))
        TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['iron'], "add") 
    elseif SubValue == 2 then
        Player.Functions.AddItem('metalscrap', math.random(20,25))
        TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['metalscrap'], "add") 
    elseif SubValue == 3 then
        Player.Functions.AddItem('rubber', math.random(5,15))
        TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['rubber'], "add") 
    end

    if (PEPEduikboot.Locations[Area].TotalVuiligheid - 1) == 0 then
        for k, v in pairs(PEPEduikboot.Locations[CurrentDivingArea].coords.Vuiligheid) do
            v.PickedUp = false
        end
        PEPEduikboot.Locations[CurrentDivingArea].TotalVuiligheid = PEPEduikboot.Locations[CurrentDivingArea].DefaultVuiligheid

        local newLocation = math.random(1, #PEPEduikboot.Locations)
        while (newLocation == CurrentDivingArea) do
            Citizen.Wait(3)
            newLocation = math.random(1, #PEPEduikboot.Locations)
        end
        CurrentDivingArea = newLocation
        
        TriggerClientEvent('pepe-duikboot:client:NewLocations', -1)
    else
        PEPEduikboot.Locations[Area].coords.Vuiligheid[Vuiligheid].PickedUp = Bool
        PEPEduikboot.Locations[Area].TotalVuiligheid = PEPEduikboot.Locations[Area].TotalVuiligheid - 1
    end

    TriggerClientEvent('pepe-duikboot:server:UpdateVuil', -1, Area, Vuiligheid, Bool)
end)

