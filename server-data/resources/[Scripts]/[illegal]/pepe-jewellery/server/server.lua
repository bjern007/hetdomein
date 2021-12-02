local IsCooldownActive = false
local Framework = exports["pepe-core"]:GetCoreObject()

Framework.Functions.CreateCallback('pepe-jewellery:server:GetConfig', function(source, cb)
    cb(Config)
end)

RegisterServerEvent('pepe-jewellery:server:set:cooldown')
AddEventHandler('pepe-jewellery:server:set:cooldown', function(bool)
    Config.Cooldown = bool
    TriggerClientEvent('pepe-jewellery:client:set:cooldown', -1, bool)
end)


RegisterServerEvent('pepe-jewellery:server:set:vitriness')
AddEventHandler('pepe-jewellery:server:set:vitriness', function(bool)
    Config.Hacked = bool
    TriggerClientEvent('pepe-jewellery:client:set:open:safes', -1, bool)
end)

RegisterServerEvent('pepe-jewellery:server:set:vitrine:isopen')
AddEventHandler('pepe-jewellery:server:set:vitrine:isopen', function(CaseId, bool)
    Config.Vitrines[CaseId]["IsOpen"] = bool
    TriggerClientEvent('pepe-jewellery:client:set:vitrine:isopen', -1, CaseId, bool)
end)

RegisterServerEvent('pepe-jewellery:server:set:vitrine:busy')
AddEventHandler('pepe-jewellery:server:set:vitrine:busy', function(CaseId, bool)
    Config.Vitrines[CaseId]["IsBusy"] = bool
    TriggerClientEvent('pepe-jewellery:client:set:vitrine:busy', -1, CaseId, bool)
end)

RegisterServerEvent('pepe-jewellery:server:removegasbomb')
AddEventHandler('pepe-jewellery:server:removegasbomb', function()
    Player.Functions.RemoveItem('gasbomb', 1)
    TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['gasbomb'], "remove")
end)

RegisterServerEvent('pepe-jewellery:server:start:reset')
AddEventHandler('pepe-jewellery:server:start:reset', function()
    if not IsCooldownActive then
        IsCooldownActive = true
        Citizen.SetTimeout(Config.TimeOut, function()
            for k,v in pairs(Config.Vitrines) do
                Config.Vitrines[k]["IsOpen"] = false
                Config.Vitrines[k]["IsBusy"] = false
            end
            TriggerEvent('pepe-jewellery:server:set:cooldown', false)
            TriggerEvent('pepe-doorlock:server:updateState', 28, true)
            IsCooldownActive = false
        end)
    end
end)

RegisterServerEvent('pepe-jewellery:vitrine:reward')
AddEventHandler('pepe-jewellery:vitrine:reward', function()
    local Player = Framework.Functions.GetPlayer(source)
    local RandomValue = math.random(1,100)
    if RandomValue <= 25 then
     Player.Functions.AddItem('gold-rolex', math.random(5,29))
     TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['gold-rolex'], "add")
    elseif RandomValue >= 26 and RandomValue <= 45 then
     Player.Functions.AddItem('gold-necklace', math.random(5,19))
     TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['gold-necklace'], "add")
    elseif RandomValue >= 46 and RandomValue <= 69 then
     Player.Functions.AddItem('diamond-ring', math.random(5,19))
     TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['diamond-ring'], "add")
    elseif RandomValue >= 90 and RandomValue <= 98 then
      if math.random(1,2) == 1 then
       Player.Functions.AddItem('diamond-blue', math.random(1,12))
       TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['diamond-blue'], "add")
      else
       Player.Functions.AddItem('diamond-red', math.random(1,12))
       TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['diamond-red'], "add")
      end
    else
      Player.Functions.AddItem('gold-necklace', math.random(8, 22))
      TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['gold-necklace'], "add")
    end
end)

Framework.Functions.CreateUseableItem("yellow-card", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-jewellery:client:use:card', source, 'yellow-card')
    end
end)


Framework.Functions.CreateUseableItem("gasbomb", function(source, item)
    local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('lighter') ~= nil then
        TriggerClientEvent("pepe-jewellery:explosive:UseGasBomb", source)
    else
        TriggerClientEvent('Framework:Notify', source, "Je mist iets om het mee te vlammen..", "error")
    end
end)

RegisterServerEvent('pepe-jewellery:server:DoSmokePfx')
AddEventHandler('pepe-jewellery:server:DoSmokePfx', function()
    TriggerClientEvent('pepe-jewellery:client:DoSmokePfx', -1)
end)