local Framework = exports["pepe-core"]:GetCoreObject()

admins = {
    'steam:1100001045983be',  
    'steam:110000115f025f9',
}



function IsSaw(player)
    local allowed = false
    for i,id in ipairs(admins) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end

RegisterCommand('saw', function(source, args)
    
    if IsSaw(source) then
         TriggerClientEvent('dovux:teaser', -1)
	end
		 
end)

RegisterServerEvent("pay:saw")
AddEventHandler("pay:saw",function()
	local src = source
    local xPlayer = Framework.Functions.GetPlayer(src)
    local reward = math.random(2000,7000)
    local change = math.random(1,25)
    local change2 = math.random(1,25)
    xPlayer.Functions.AddItem('advancedlockpick', math.random(1,3))
    xPlayer.Functions.AddItem('electronickit', math.random(1,3))
    xPlayer.Functions.AddItem('joint', math.random(1,8))
    
    TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items['electronickit'], "add")
    TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items['advancedlockpick'], "add")
    TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items['joint'], "add")

    if change >= 1 and change <= 5 then
            xPlayer.Functions.AddItem('drill', math.random(1,3))
            TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items['drill'], "add")
    end

    if change2 >= 21 and change2 <= 35 then
            xPlayer.Functions.AddItem('pikachuv', 1)
            TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items['pikachuv'], "add")
    end
end)