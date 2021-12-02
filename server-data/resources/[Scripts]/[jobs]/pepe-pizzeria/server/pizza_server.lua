-- Framework = nil
local Bail = {}

local Framework = exports["pepe-core"]:GetCoreObject()
-- TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)

Framework.Functions.CreateCallback('pepe-pizzeria:server:HasMoney', function(source, cb)
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

RegisterServerEvent('pepe-pizzeria:server:add:to:register')
AddEventHandler('pepe-pizzeria:server:add:to:register', function(Price, Note)
    local RandomID = math.random(1111,9999)
    Config.ActivePaymentsPizza[RandomID] = {['Price'] = Price, ['Note'] = Note}
    TriggerClientEvent('pepe-pizzeria:client:sync:register', -1, Config.ActivePaymentsPizza)
end)

RegisterServerEvent('pepe-pizzeria:server:pay:receipt')
AddEventHandler('pepe-pizzeria:server:pay:receipt', function(Price, Note, Id)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    if Player.Functions.RemoveMoney('cash', Price, 'pizzeria') then
        if Config.ActivePaymentsPizza[tonumber(Id)] ~= nil then
            Config.ActivePaymentsPizza[tonumber(Id)] = nil
            TriggerEvent('pepe-pizzeria:give:receipt:to:workers', Note, Price)
            TriggerClientEvent('pepe-pizzeria:client:sync:register', -1, Config.ActivePaymentsPizza)
        
            TriggerEvent('pepe-bossmenu:server:addAccountMoney', 'pizza', Price)
        else
            TriggerClientEvent('Framework:Notify', src, 'Error..', 'error')
        end
    else
        TriggerClientEvent('Framework:Notify', src, 'Je hebt niet genoeg contant geld..', 'error')
    end
end)

RegisterServerEvent('pepe-pizzeria:give:receipt:to:workers')
AddEventHandler('pepe-pizzeria:give:receipt:to:workers', function(Note, Price)
    local src = source
    for k, v in pairs(Framework.Functions.GetPlayers()) do
        local Player = Framework.Functions.GetPlayer(v)
        if Player ~= nil then
            if Player.PlayerData.job.name == 'pizza' and Player.PlayerData.job.onduty then
                local Info = {note = Note, price = Price}
                Player.Functions.AddItem('burger-ticket', 1, false, Info)
                TriggerClientEvent('pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['burger-ticket'], "add")
            end
        end
    end
end)

Framework.Commands.Add("refreshpizza", "Reset de Pizzeria props", {}, false, function(source, args)
    TriggerClientEvent('pepe-pizzeria:client:refresh:props', -1)
end, "admin")


Framework.Functions.CreateCallback('pepe-pizzeria:server:CheckBail', function(source, cb)
    local Player = Framework.Functions.GetPlayer(source)
    local CitizenId = Player.PlayerData.citizenid

    if Bail[CitizenId] ~= nil then
        Player.Functions.AddMoney(Bail[CitizenId], Config.BailPrice, 'pepe-pizzeria:server:CheckBail')
        Bail[CitizenId] = nil
        cb(true)
    else
        cb(false)
    end
end)





RegisterServerEvent('pepe-pizza:server:start:black')
AddEventHandler('pepe-pizza:server:start:black', function()
    local src = source
    local Player = Framework.Functions.GetPlayer(source)
    TriggerClientEvent('pepe-pizza:start:black:job', src)
    Player.Functions.AddItem("pizza-doos", 1)
    TriggerClientEvent('pepe-pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['pizza-doos'], 'add')
end)

Framework.Functions.CreateCallback('pepe-pizzeria:server:GetConfig', function(source, cb)
    cb(Config)
end)

RegisterServerEvent('pepe-pizza:server:reward:money')
AddEventHandler('pepe-pizza:server:reward:money', function()
    local Player = Framework.Functions.GetPlayer(source)
    Player.Functions.AddMoney('cash', math.random(360, 500), "pizza-shop-reward")
    TriggerClientEvent('Framework:Notify', source, "pizza geleverd! Ga terug naar de pizza Shop voor een nieuwe levering.")
    Player.Functions.RemoveItem('pizza-doos', 1)
    TriggerClientEvent('pepe-pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['pizza-doos'], 'remove')

end)


RegisterServerEvent('pepe-pizzeria:server:remove:verpak')
AddEventHandler('pepe-pizzeria:server:remove:verpak', function()
    local Player = Framework.Functions.GetPlayer(source)
    
    if Player ~= nil then
        Player.Functions.RemoveItem('pizza', 1)
    end
end)

RegisterServerEvent('pepe-pizzeria:server:add:doos')
AddEventHandler('pepe-pizzeria:server:add:doos', function()
    local Player = Framework.Functions.GetPlayer(source)
    
    if Player ~= nil then
        Player.Functions.AddItem('pizza-doos', 1)
        TriggerClientEvent('pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['pizza-doos'], 'add')
    end
end)


RegisterServerEvent('pepe-pizzeria:server:get:stuff')
AddEventHandler('pepe-pizzeria:server:get:stuff', function()
    local Player = Framework.Functions.GetPlayer(source)
    
    if Player ~= nil then
        Player.Functions.AddItem('pizza-vooraad', 1)
        TriggerClientEvent('pepe-pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['pizza-vooraad'], 'add')
    end
end)


RegisterServerEvent('pepe-pizzeria:server:rem:pizza')
AddEventHandler('pepe-pizzeria:server:rem:pizza', function()
    local Player = Framework.Functions.GetPlayer(source)
    
    if Player ~= nil then
        Player.Functions.RemoveItem('pizza', 1)
        TriggerClientEvent('pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['pizza'], 'remove')
    end
end)

RegisterServerEvent('pepe-pizzeria:server:rem:pizzabox')
AddEventHandler('pepe-pizzeria:server:rem:pizzabox', function()
    local Player = Framework.Functions.GetPlayer(source)
    
    if Player ~= nil then
        Player.Functions.RemoveItem('pizza', 1)
        TriggerClientEvent('pepe-pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['pizza'], 'add')
    end
end)

RegisterServerEvent('pepe-pizzeria:server:rem:stuff')
AddEventHandler('pepe-pizzeria:server:rem:stuff', function(what)
    local Player = Framework.Functions.GetPlayer(source)
    
   -- if Player ~= nil then
    if Player ~= nil and what == "pizzameat" or what == "groenten" or what == "pizza-vooraad" or what == "pizza" then
        Player.Functions.RemoveItem(what, 1)
        TriggerClientEvent('pepe-pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['what'], 'add')
    end
end)

RegisterServerEvent('pepe-pizzeria:server:add:stuff')
AddEventHandler('pepe-pizzeria:server:add:stuff', function(what)
    local Player = Framework.Functions.GetPlayer(source)
    
    if Player ~= nil and what == "pizzameat" or what == "groenten" or what == "pizza-vooraad" or what == "pizza" then
        Player.Functions.AddItem(what, 1)
        TriggerClientEvent('pepe-pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['what'], 'add')
    end
end)




Framework.Functions.CreateCallback('pepe-pizza:server:get:ingredient', function(source, cb)
    local src = source
    local Ply = Framework.Functions.GetPlayer(src)
    local lettuce = Ply.Functions.GetItemByName("groenten")
    local meat = Ply.Functions.GetItemByName("pizzameat")
    if lettuce ~= nil and meat ~= nil then
        cb(true)
    else
        cb(false)
    end
end)



Framework.Functions.CreateCallback('pepe-pizza:server:get:pizzas', function(source, cb)
    local src = source
    local Ply = Framework.Functions.GetPlayer(src)
    local pizza = Ply.Functions.GetItemByName('pizza')
    if pizza ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

Framework.Functions.CreateUseableItem("pizza-doos", function(source, item)
	local xPlayer = Framework.Functions.GetPlayer(source)
	TriggerClientEvent("pepe-inventory:client:ItemBox", source, Framework.Shared.Items['pizza-doos'], "remove")
	xPlayer.Functions.RemoveItem("pizza-doos", 1)
	TriggerClientEvent("pepe-inventory:client:ItemBox", source, Framework.Shared.Items['pizza'], "add")
    xPlayer.Functions.AddItem('pizza', 1) 
end)



