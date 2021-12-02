local Framework = exports["pepe-core"]:GetCoreObject()
  
Framework.Functions.CreateCallback('pepe-wiet:server:GetConfig', function(source, cb)
    cb(Config)
end)

Framework.Functions.CreateUseableItem("scissor", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-wiet:client:use:scissor', source)
    end
end)


RegisterServerEvent('pepe-wiet:server:set:dry:busy')
AddEventHandler('pepe-wiet:server:set:dry:busy', function(DryRackId, bool)
    --Config.Plants['drogen'][DryRackId]['IsBezig'] = bool
    TriggerClientEvent('pepe-wiet:client:set:dry:busy', -1, DryRackId, bool)
end)

RegisterServerEvent('pepe-wiet:server:set:pack:busy')
AddEventHandler('pepe-wiet:server:set:pack:busy', function(PackerId, bool)
    Config.WeedLocations[PackerId]['IsBezig'] = bool
    TriggerClientEvent('pepe-wiet:client:set:pack:busy', -1, PackerId, bool)
end)

RegisterServerEvent('pepe-wiet:server:give:tak')
AddEventHandler('pepe-wiet:server:give:tak', function()
    local Speler = Framework.Functions.GetPlayer(source)
    Speler.Functions.AddItem('wet-tak', math.random(2,4))
    TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['wet-tak'], "add")
end)

RegisterServerEvent('pepe-wiet:server:add:item21212')
AddEventHandler('pepe-wiet:server:add:item21212', function(Item, Amount)
    local Player = Framework.Functions.GetPlayer(source)
    Player.Functions.AddItem(Item, Amount)
    TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items[Item], "add")
end)

RegisterServerEvent('pepe-wiet:server:remove:item')
AddEventHandler('pepe-wiet:server:remove:item', function(Item, Amount)
    local Player = Framework.Functions.GetPlayer(source)
    Player.Functions.RemoveItem(Item, Amount)
    TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items[Item], "remove")
end)

Framework.Functions.CreateCallback('pepe-wiet:server:has:takken', function(source, cb)
    local Player = Framework.Functions.GetPlayer(source)
    local ItemTak = Player.Functions.GetItemByName("wet-tak")
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

Framework.Functions.CreateCallback('pepe-wiet:server:has:nugget', function(source, cb)
    local Player = Framework.Functions.GetPlayer(source)
    local ItemNugget = Player.Functions.GetItemByName("wet-bud")
    local ItemBag = Player.Functions.GetItemByName("plastic-bag")
	if ItemNugget ~= nil and ItemBag ~= nil then
        if ItemNugget.amount >= 2 and ItemBag.amount >= 1 then
            cb(true)
		else
            cb(false)
		end
	   else
        cb(false)
	end
end)

RegisterServerEvent('pepe-wiet:server:weed:reward')
AddEventHandler('pepe-wiet:server:weed:reward', function()
    local Player = Framework.Functions.GetPlayer(source)
    local RandomValue = math.random(1, 1000)
    if RandomValue >= 100 and RandomValue < 650 then
        local SubValue = math.random(1,3)
        if SubValue == 1 then
            Player.Functions.AddItem('wet-tak', 3)
            TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['wet-tak'], "add") 
        elseif SubValue == 2 then
            Player.Functions.AddItem('wet-tak', 4)
            TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['wet-tak'], "add") 
        else
            Player.Functions.AddItem('wet-tak', 6)
            TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['wet-tak'], "add") 
        end
    elseif RandomValue >= 700 and RandomValue < 820 then
        local SubValue = math.random(1,50)
        if SubValue == 1 then
            Player.Functions.AddItem('wet-tak', 9)
            TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['wet-tak'], "add")  
        else
            Player.Functions.AddItem('plastic-bag', 6)
            TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['plastic-bag'], "add") 
        end
    else
        TriggerClientEvent('Framework:Notify', source, "Deze plant heeft nog niets rijp.", "error")
    end
end)

-- RegisterServerEvent('pepe-wiet:server:sell:items')
-- AddEventHandler('pepe-wiet:server:sell:items', function()
--     local src = source
--     local Player = Framework.Functions.GetPlayer(src)
--     for k, v in pairs(Config.SellItems) do
--         local Item = Player.Functions.GetItemByName(k)
--         if Item ~= nil then
--           if Item.amount > 0 then
--               for i = 1, Item.amount do
--                   Player.Functions.RemoveItem(Item.name, 1)
--                   TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items[Item.name], "remove")
--                   if v['Type'] == 'item' then
--                       Player.Functions.AddItem(v['Item'], v['Amount'])
--                   else
--                       Player.Functions.AddMoney('cash', v['Amount'], 'sold-fish')
--                   end
--                   Citizen.Wait(500)
--               end
--           end
--         end
--     end
-- end)