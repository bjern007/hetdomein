local Framework = exports["pepe-core"]:GetCoreObject()

RegisterNetEvent("mmfireworks:particles:1", function(coords)
    TriggerClientEvent("mmfireworks:particles:1", -1, coords)
end)

RegisterNetEvent("mmfireworks:particles:2", function(coords)
    TriggerClientEvent("mmfireworks:particles:2", -1, coords)
end)

RegisterNetEvent("mmfireworks:delete", function(netId)
    local ent = NetworkGetEntityFromNetworkId(netId)
    
    if DoesEntityExist(ent) then
        local model = GetEntityModel(ent)
        if model == `ind_prop_firework_03` or model == `ind_prop_firework_01` then
            DeleteEntity(ent)
        else
            print(string.format("%s [%s] tried to delete not allowed entity".. GetPlayerName(source), source))
        end
    end
end)

RegisterNetEvent("mmfireworks:remove", function()
    local Player = Framework.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('firework1', 1)
end)

RegisterNetEvent("mmfireworks:remove2", function()
    local Player = Framework.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('firework2', 1)
end)

Framework.Functions.CreateUseableItem("firework1", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mmfireworks:firework', source)
    end
end)

Framework.Functions.CreateUseableItem("firework2", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mmfireworks:firework2', source)
    end
end)
