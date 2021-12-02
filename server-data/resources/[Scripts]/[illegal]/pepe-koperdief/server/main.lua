local Framework = exports["pepe-core"]:GetCoreObject()
local TotalKoper = 0

Framework.Functions.CreateCallback('pepe-koperdief:getItem', function(source, cb)
	local Speler = Framework.Functions.GetPlayer(source)
    Speler.Functions.AddItem('koperdraad', math.random(1,2))
	TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['koperdraad'], "add")
    Speler.Functions.AddItem('rubber', math.random(1,11)) -- 151 per uur
	TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['koperdraad'], "add")
end)

RegisterServerEvent('pepe-koperdief:server:sell:items')
AddEventHandler('pepe-koperdief:server:sell:items', function()
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    for k, v in pairs(Config.SellItems) do
        local Item = Player.Functions.GetItemByName(k)
        if Item ~= nil then
          if Item.amount > 0 then
              for i = 1, Item.amount do
                  Player.Functions.RemoveItem(Item.name, 1)
                  TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items[Item.name], "remove")
                  if v['Type'] == 'item' then
                      Player.Functions.AddItem(v['Item'], v['Amount'])
                  else
                      Player.Functions.AddMoney('cash', v['Amount'], 'sold-koper')
                  end
                  Citizen.Wait(500)
              end
          end
        end
    end
end)


Framework.Functions.CreateCallback('ks-koperdief:server:tang', function(source, cb)
    local Player = Framework.Functions.GetPlayer(source)
    local Item = Player.Functions.GetItemByName("kniptang")

    if Item ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

Framework.Functions.CreateCallback('ks-koperdief:server:koperdraad', function(source, cb)
    local Player = Framework.Functions.GetPlayer(source)
    local Item = Player.Functions.GetItemByName("koperdraad")

    if Item ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('pepe-koperdief:server:redeem:koper:bars')
AddEventHandler('pepe-koperdief:server:redeem:koper:bars', function()
    local src = source
	local Player = Framework.Functions.GetPlayer(src)
    local amount2 = math.random(4, 4)
	Player.Functions.AddItem('copper', amount2) ---- change this shit 
	TriggerClientEvent("pepe-inventory:client:ItemBox", source, Framework.Shared.Items['copper'], "add")
	TriggerClientEvent('pepe-koperdief:server:reset:smelter', -1)
end)




RegisterServerEvent('pepe-koperdief:server:smelt:koper')
AddEventHandler('pepe-koperdief:server:smelt:koper', function()
    local xPlayer = Framework.Functions.GetPlayer(source)
	xPlayer.Functions.RemoveItem("koperdraad", 1)
    TriggerClientEvent('pepe-koperdief:client:start:process', -1)
end)