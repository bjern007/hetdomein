Framework = nil

TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)

RegisterNetEvent("stopsign:server:additem")
AddEventHandler("stopsign:server:additem", function()
    local src = source
    local xPlayer = Framework.Functions.GetPlayer(tonumber(src))

	xPlayer.Functions.AddItem("stopsign", 1, false)
	TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items['stopsign'], "add")
end)

RegisterNetEvent("walkingmansign:server:additem")
AddEventHandler("walkingmansign:server:additem", function()
    local src = source
    local xPlayer = Framework.Functions.GetPlayer(tonumber(src))

	xPlayer.Functions.AddItem("walkingmansign", 1, false)
	TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items['walkingmansign'], "add")
end)

RegisterNetEvent("dontblockintersectionsign:server:additem")
AddEventHandler("dontblockintersectionsign:server:additem", function()
    local src = source
    local xPlayer = Framework.Functions.GetPlayer(tonumber(src))

	xPlayer.Functions.AddItem("dontblockintersectionsign", 1, false)
	TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items['dontblockintersectionsign'], "add")
end)

RegisterNetEvent("uturnsign:server:additem")
AddEventHandler("uturnsign:server:additem", function()
    local src = source
    local xPlayer = Framework.Functions.GetPlayer(tonumber(src))

	xPlayer.Functions.AddItem("uturnsign", 1, false)
	TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items['uturnsign'], "add")
end)

Framework.Functions.CreateUseableItem("stopsign", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-signrobbery:client:anim', source)
    end
end)