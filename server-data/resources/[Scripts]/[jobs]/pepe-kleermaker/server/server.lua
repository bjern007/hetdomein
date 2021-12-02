-- Framework = nil
-- TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)

local Framework = exports["pepe-core"]:GetCoreObject()

local Bail = {}

Framework.Functions.CreateCallback('pepe-kleermaker:server:HasMoney', function(source, cb)
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

Framework.Functions.CreateCallback('pepe-kleermaker:server:CheckBail', function(source, cb)
    local Player = Framework.Functions.GetPlayer(source)
    local CitizenId = Player.PlayerData.citizenid

    if Bail[CitizenId] ~= nil then
        Player.Functions.AddMoney(Bail[CitizenId], Config.BailPrice, 'pepe-kleermaker:server:CheckBail')
        Bail[CitizenId] = nil
        cb(true)
    else
        cb(false)
    end
end)


RegisterServerEvent('pepe-kleermaker:server:give:zeis')
AddEventHandler('pepe-kleermaker:server:give:zeis', function()
    local Speler = Framework.Functions.GetPlayer(source)
    Speler.Functions.AddItem('zeis', math.random(1,1))
    TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['zeis'], "add")
end)

RegisterServerEvent('pepe-kleermaker:server:remove:zeis')
AddEventHandler('pepe-kleermaker:server:remove:zeis', function()
    local Player = Framework.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('zeis', math.random(1,1))
    TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['zeis'], "remove")


end)

TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)

Framework.Functions.CreateUseableItem("zeis", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-kleermaker:client:use:scissor', source)
    end
end)


RegisterServerEvent('pepe-kleermaker:server:give:katoen')
AddEventHandler('pepe-kleermaker:server:give:katoen', function()
    local Speler = Framework.Functions.GetPlayer(source)
    Speler.Functions.AddItem('katoen', math.random(2,4))
    TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['katoen'], "add")
end)

RegisterServerEvent('pepe-kleermaker:server:add:item')
AddEventHandler('pepe-kleermaker:server:add:item', function(Item, Amount)
    local Player = Framework.Functions.GetPlayer(source)
    Player.Functions.AddItem(Item, Amount)
    TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items[Item], "add")
end)

RegisterServerEvent('pepe-kleermaker:server:remove:item')
AddEventHandler('pepe-kleermaker:server:remove:item', function(Item, Amount)
    local Player = Framework.Functions.GetPlayer(source)
    Player.Functions.RemoveItem(Item, Amount)
    TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items[Item], "remove")

    local randomgunpart = math.random(1,2500)
    
    if randomgunpart < 5 then
        Player.Functions.AddItem("snspistol_stage_1", 1)
        TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items["snspistol_stage_1"], 'add') 
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(4)
        for k, v in pairs(Config.Plants['planten']) do
         if Config.Plants['planten'][k]['Geplukt'] then
             Citizen.Wait(30000)
             Config.Plants['planten'][k]['Geplukt'] = false
             TriggerClientEvent('pepe-kleermaker:client:set:picked:state', -1, k, false)
         end
      end
  end
end)

-- Functions

Framework.Functions.CreateCallback('pepe-kleermaker:server:GetConfig', function(source, cb)
    cb(Config)
end)

Framework.Functions.CreateCallback('pepe-kleermaker:server:has:takken', function(source, cb)
    local Player = Framework.Functions.GetPlayer(source)
    local ItemTak = Player.Functions.GetItemByName("katoen")
	if ItemTak ~= nil then
        if ItemTak.amount >= 4 then
            cb(true)
		else
            cb(false)
		end
	   else
        cb(false)
	end
end)

Framework.Functions.CreateCallback('pepe-kleermaker:server:has:nugget', function(source, cb)
    local Player = Framework.Functions.GetPlayer(source)
    local ItemTak = Player.Functions.GetItemByName("stofrol")
	if ItemTak ~= nil then
        if ItemTak.amount >= 2 then
            cb(true)
		else
            cb(false)
		end
	   else
        cb(false)
	end
end)

RegisterServerEvent('pepe-kleermaker:server:sell:items')
AddEventHandler('pepe-kleermaker:server:sell:items', function()
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    for k, v in pairs(Config.SellItems) do
        local Item = Player.Functions.GetItemByName(k)
        if Item ~= nil then
          if Item.amount > 0 then
            for i = 1, Item.amount do
                Player.Functions.RemoveItem(Item.name, 1)
                TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items[Item.name], "remove")
                Citizen.Wait(500)
            end
            if v['Type'] == 'item' then
                Player.Functions.AddItem(v['Item'], v['Amount'])
            else
                Player.Functions.AddMoney('cash', v['Amount'] * Item.amount, 'sold-kleding')
            end
          end
        end
    end
end)