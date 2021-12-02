local Framework = exports["pepe-core"]:GetCoreObject()

Framework.Functions.CreateCallback('pepe-storerobbery:server:get:config', function(source, cb)
    cb(Config)
end)

Framework.Commands.Add("resetsafes", "Reset de kluis winkels", {}, false, function(source, args)
    for k, v in pairs(Config.Safes) do
        Config.Safes[k]['Busy'] = false
        TriggerClientEvent('pepe-storerobbery:client:safe:busy', -1, k, false)
    end
end, "admin")

Framework.Commands.Add("resetstores", "Reset de winkels", {}, false, function(source, args)
    for k, v in pairs(Config.Registers) do
        Config.Registers[k]['Robbed'] = false
        TriggerClientEvent('pepe-storerobbery:client:set:register:robbed', -1, k, false)
    end
end, "admin")

Framework.Functions.CreateCallback('pepe-storerobbery:server:HasItem', function(source, cb, itemName)
    local Player = Framework.Functions.GetPlayer(source)
    local Item = Player.Functions.GetItemByName(itemName)
	if Player ~= nil then
        if Item ~= nil then
			cb(true)
        else
			cb(false)
        end
	end
end)

Citizen.CreateThread(function()
    while true do
        for k, v in pairs(Config.Registers) do
            if Config.Registers[k]['Time'] > 0 and (Config.Registers[k]['Time'] - Config.Inverval) >= 0 then
                Config.Registers[k]['Time'] = Config.Registers[k]['Time'] - Config.Inverval
            else
                Config.Registers[k]['Time'] = 0
                Config.Registers[k]['Robbed'] = false
                TriggerClientEvent('pepe-storerobbery:client:set:register:robbed', -1, k, false)
            end
        end
        Citizen.Wait(Config.Inverval)
    end
end)

RegisterServerEvent('pepe-storerobbery:server:set:register:robbed')
AddEventHandler('pepe-storerobbery:server:set:register:robbed', function(RegisterId, bool)
    Config.Registers[RegisterId]['Robbed'] = bool
    Config.Registers[RegisterId]['Time'] = Config.ResetTime
    TriggerClientEvent('pepe-storerobbery:client:set:register:robbed', -1, RegisterId, bool)
end)

RegisterServerEvent('pepe-storerobbery:server:set:register:busy')
AddEventHandler('pepe-storerobbery:server:set:register:busy', function(RegisterId, bool)
    Config.Registers[RegisterId]['Busy'] = bool
    TriggerClientEvent('pepe-storerobbery:client:set:register:busy', -1, RegisterId, bool)
end)

RegisterServerEvent('pepe-storerobbery:server:safe:busy')
AddEventHandler('pepe-storerobbery:server:safe:busy', function(SafeId, bool)
    Config.Safes[SafeId]['Busy'] = bool
    TriggerClientEvent('pepe-storerobbery:client:safe:busy', -1, SafeId, bool)
end)

RegisterServerEvent('pepe-storerobbery:server:safe:robbed')
AddEventHandler('pepe-storerobbery:server:safe:robbed', function(SafeId, bool)
    Config.Safes[SafeId]['Robbed'] = bool
    TriggerClientEvent('pepe-storerobbery:client:safe:robbed', -1, SafeId, bool)
    SetTimeout((1000 * 60) * 25, function()
        TriggerClientEvent('pepe-storerobbery:client:safe:robbed', -1, SafeId, false)
        Config.Safes[SafeId]['Robbed'] = false
    end)
end)

RegisterServerEvent('pepe-storerobbery:server:rob:register')
AddEventHandler('pepe-storerobbery:server:rob:register', function(RegisterId, Cops, IsDone)
    local Player = Framework.Functions.GetPlayer(source)
    local curRep = Player.PlayerData.metadata["lockpickrep"]
    if IsDone then
            if Cops >= 1 then
                Player.Functions.AddMoney('cash', math.random(275, 390), "Winkel overval")
                local RandomItem = Config.SpecialItems[math.random(#Config.SpecialItems)]
                local RandomValue = math.random(1, 150)
                if RandomValue <= 2 then
                    Player.Functions.AddItem(RandomItem, 1)
                    TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items[RandomItem], "add")
                end
                Player.Functions.AddItem('money-roll', math.random(9, 82))
                TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['money-roll'], "add")
            else
                Player.Functions.AddItem('money-roll', math.random(2, 25))
                TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['money-roll'], "add")
            end
    end
end)

RegisterServerEvent('pepe-storerobbery:server:safe:reward')
AddEventHandler('pepe-storerobbery:server:safe:reward', function()
    local Player = Framework.Functions.GetPlayer(source)
    local RandomItem = Config.SpecialItems[math.random(#Config.SpecialItems)]
    Player.Functions.AddMoney('cash', math.random(500, 1400), "Kluis overval")
    Player.Functions.AddItem('money-roll', math.random(7, 30))
    TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['money-roll'], "add")
    local special = math.random(1,5)
    if special <= 1 then
        local RandomValue = math.random(1,190)
         if RandomValue <= 25 then
        Player.Functions.AddItem("gold-rolex", math.random(2,4))
        TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items["gold-rolex"], "add") 
        elseif RandomValue >= 35 and RandomValue <= 45 then
        Player.Functions.AddItem(RandomItem, 1)
        TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items[RandomItem], "add")
        elseif RandomValue >= 45 and RandomValue <= 75 then
        Player.Functions.AddItem("gold-bar", math.random(1,2))
        TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items["gold-bar"], "add") 
        elseif RandomValue >= 76 and RandomValue <= 190 then
        Player.Functions.AddItem("plasticbag", math.random(1, 5))
        TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items["plasticbag"], "add")
        end
    end
end)