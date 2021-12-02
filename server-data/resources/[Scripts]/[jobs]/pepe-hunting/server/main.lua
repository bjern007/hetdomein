local Framework = exports["pepe-core"]:GetCoreObject()

RegisterServerEvent('pepe-hunt:reward')
AddEventHandler('pepe-hunt:reward', function(Weight)
    local xPlayer = Framework.Functions.GetPlayer(source)
    if Weight >= 1 then
       xPlayer.Functions.AddItem('meath', math.random(1, 5))
       TriggerClientEvent('inventory:client:ItemBox', source, Framework.Shared.Items['meath'], "add")
    elseif Weight >= 9 then
        xPlayer.Functions.AddItem('meath', math.random(3, 8))
       TriggerClientEvent('inventory:client:ItemBox', source, Framework.Shared.Items['meath'], "add")
    elseif Weight >= 15 then
        xPlayer.Functions.AddItem('meath', math.random(6, 9))
       TriggerClientEvent('inventory:client:ItemBox', source, Framework.Shared.Items['meath'], "add")
    end
end)

RegisterServerEvent('pepe-hunt:sell')
AddEventHandler('pepe-hunt:sell', function()
   local xPlayer  = Framework.Functions.GetPlayer(source)

    local MeatPrice = math.random(50,350)
    local LeatherPrice = 300

		local MeatP = xPlayer.Functions.GetItemByName('meath')
			if MeatP == nil then
               	TriggerClientEvent('Framework:Notify', source, "Je hebt geen vlees!", "error")	
			else   
				TriggerClientEvent('inventory:client:ItemBox', source, Framework.Shared.Items['meath'], "remove")	
			    xPlayer.Functions.RemoveItem("meath", 1)
			    xPlayer.Functions.AddMoney('cash', MeatPrice)
			    TriggerClientEvent('Framework:Notify', source, "Je hebt wild vlees verkocht", "success")
			end
end)

RegisterServerEvent('pepe-hunting:server:recieve:knife')
AddEventHandler('pepe-hunting:server:recieve:knife', function()
    local Player = Framework.Functions.GetPlayer(source)
    Player.Functions.AddItem("weapon_knife", 1)
    TriggerClientEvent("pepe-inventory:client:ItemBox", source, Framework.Shared.Items["weapon-knife"], "add")
end)


RegisterServerEvent('pepe-hunting:server:remove:knife')
AddEventHandler('pepe-hunting:server:remove:knife', function()
    local Player = Framework.Functions.GetPlayer(source)
    Player.Functions.RemoveItem("weapon_knife", 1)
    TriggerClientEvent("pepe-inventory:client:ItemBox", source, Framework.Shared.Items["weapon-knife"], "remove")
end)