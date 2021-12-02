local Framework = exports["pepe-core"]:GetCoreObject()

Framework.Commands.Add("vuur", "", {}, false, function(source, args)
    local Player = Framework.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "vanilla" then

		TriggerEvent('vuurtje:maken')
    end
end)

Framework.Commands.Add("stopvuur", "", {}, false, function(source, args)
    local Player = Framework.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "vanilla" then

		TriggerEvent('stripclub:server:stopvuur')
    end
end)

RegisterServerEvent('vuurtje:maken')
AddEventHandler('vuurtje:maken', function(source)
    local src = source
    -- local Player = Framework.Functions.GetPlayer(src)

    for k, v in pairs(Framework.Functions.GetPlayers()) do
        local Player = Framework.Functions.GetPlayer(v)
        if Player ~= nil then 
			TriggerClientEvent('vuurtje:smoke', Player.PlayerData.source) 
		end
	end
end)

RegisterServerEvent('stripclub:server:bubbles')
AddEventHandler('stripclub:server:bubbles', function(source)
    local src = source
    -- local Player = Framework.Functions.GetPlayer(src)

    for k, v in pairs(Framework.Functions.GetPlayers()) do
        local Player = Framework.Functions.GetPlayer(v)
        if Player ~= nil then 
			TriggerClientEvent('stripclub:client:bubbles', Player.PlayerData.source) 
		end
	end
end)



RegisterServerEvent('stripclub:server:stars')
AddEventHandler('stripclub:server:stars', function(source)
    local src = source
    -- local Player = Framework.Functions.GetPlayer(src)

    for k, v in pairs(Framework.Functions.GetPlayers()) do
        local Player = Framework.Functions.GetPlayer(v)
        if Player ~= nil then 
			TriggerClientEvent('stripclub:client:stars', Player.PlayerData.source) 
		end
	end
end)

RegisterServerEvent("strippers:spawn")
AddEventHandler("strippers:spawn", function(spawned)
	TriggerClientEvent("strippers:spawn", spawned)
end)

RegisterServerEvent("strippers:updateStrippers")
AddEventHandler("strippers:updateStrippers", function(data)
	TriggerClientEvent("strippers:updateStrippers", -1, data)
	Config.Strippers['locations'] = data
end)

RegisterServerEvent("strippers:serverDeletePed")
AddEventHandler("strippers:serverDeletePed", function(model, coords)
	TriggerClientEvent("strippers:clientDeletePed", -1, model, coords)
end)


RegisterServerEvent('pepe-stripclub:server:add:to:register')
AddEventHandler('pepe-stripclub:server:add:to:register', function(Price, Note)
    local RandomID = math.random(1111,9999)
    Config.ActivePaymentsStrip[RandomID] = {['Price'] = Price, ['Note'] = Note}
    TriggerClientEvent('pepe-stripclub:client:sync:register', -1, Config.ActivePaymentsStrip)
end)

Framework.Functions.CreateCallback('pepe-stripclub:server:has:drank:items', function(source, cb)
    local src = source
    local count = 0
    local Player = Framework.Functions.GetPlayer(src)
    for k, v in pairs(Config.DrankItems) do
        local ItemzData = Player.Functions.GetItemByName(v)
        if ItemzData ~= nil then
           count = count + 1
           if count == 3 then
               cb(true)
           end
        end
    end
end)

RegisterServerEvent('pepe-stripclub:server:finish:create')
AddEventHandler('pepe-stripclub:server:finish:create', function(Drankje)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    for k, v in pairs(Config.DrankItems) do
        Player.Functions.RemoveItem(v, 1)
        TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items[v], "remove")
    end
    Citizen.SetTimeout(350, function()
        Player.Functions.AddItem(Drankje, 1)
        TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items[Drankje], "add")
    end)
end)


RegisterServerEvent('pepe-stripclub:server:pay:receipt')
AddEventHandler('pepe-stripclub:server:pay:receipt', function(Price, Note, Id)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    if Player.Functions.RemoveMoney('cash', Price, 'stripclub') then
        if Config.ActivePaymentsStrip[tonumber(Id)] ~= nil then
            Config.ActivePaymentsStrip[tonumber(Id)] = nil
            TriggerEvent('pepe-stripclub:give:receipt:to:workers', Note, Price)
            TriggerClientEvent('pepe-stripclub:client:sync:register', -1, Config.ActivePaymentsStrip)
        
            TriggerEvent('pepe-bossmenu:server:addAccountMoney', 'vanilla', Price)
        else
            TriggerClientEvent('Framework:Notify', src, 'Error..', 'error')
        end
    else
        TriggerClientEvent('Framework:Notify', src, 'Je hebt niet genoeg contant geld..', 'error')
    end
end)

RegisterServerEvent('pepe-stripclub:give:receipt:to:workers')
AddEventHandler('pepe-stripclub:give:receipt:to:workers', function(Note, Price)
    local src = source
    for k, v in pairs(Framework.Functions.GetPlayers()) do
        local Player = Framework.Functions.GetPlayer(v)
        if Player ~= nil then
            if Player.PlayerData.job.name == 'vanilla' and Player.PlayerData.job.onduty then
                local Info = {note = Note, price = Price}
                Player.Functions.AddItem('burger-ticket', 1, false, Info)
                TriggerClientEvent('pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['burger-ticket'], "add")
            end
        end
    end
end)

RegisterServerEvent('pepe-stripclub:server:sell:tickets')
AddEventHandler('pepe-stripclub:server:sell:tickets', function()
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    for k, v in pairs(Player.PlayerData.items) do
        if v.name == 'burger-ticket' then
            Player.Functions.RemoveItem('burger-ticket', 1)
            -- Player.Functions.AddMoney('cash', math.random(60, 100), 'stripclub-payment')
		TriggerEvent("pepe-bossmenu:server:addAccountMoney", "vanilla", math.random(20, 40))
        end
    end
    TriggerClientEvent('pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['burger-ticket'], "remove")
end)