-- Framework = nil
-- TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)
local Framework = exports["pepe-core"]:GetCoreObject()

RegisterServerEvent('pepe-mine:getItem')
AddEventHandler('pepe-mine:getItem', function()
	local xPlayer, randomItem = Framework.Functions.GetPlayer(source), Config.Items[math.random(1, #Config.Items)]
	
    local randomgunpart = math.random(1,1500)
	if math.random(0, 100) <= Config.ChanceToGetItem then
		local Item = xPlayer.Functions.GetItemByName(randomItem)

            if randomgunpart < 10 then
                Player.Functions.AddItem("snspistol_part_2", 1)
                TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items["snspistol_part_2"], 'add') 
            end
        
		if Item == nil then            
		    if Item.amount < 55 then
			    xPlayer.Functions.AddItem(randomItem, 1)
                TriggerClientEvent('pepe-inventory:client:ItemBox', xPlayer.PlayerData.source, Framework.Shared.Items[randomItem], 'add')
		    else	
                xPlayer.Functions.AddItem(randomItem, 1)
                TriggerClientEvent('pepe-inventory:client:ItemBox', xPlayer.PlayerData.source, Framework.Shared.Items[randomItem], 'add') 
            end
		else
			TriggerClientEvent('Framework:Notify', source, 'Inventaris zit vol')  
		end
    end
end)



RegisterServerEvent('pepe-mine:sell')
AddEventHandler('pepe-mine:sell', function()
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    
if Player ~= nil then

    if Player.Functions.RemoveItem("steel", 1) then
        TriggerClientEvent("Framework:Notify", src, "Je hebt 1x staal verkocht", "success", 1000)
        Player.Functions.AddMoney("cash", Config.pricexd.steel)
        Citizen.Wait(200)
        TriggerClientEvent('pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['steel'], 'remove')
    else
        TriggerClientEvent("Framework:Notify", src, "Je hebt geen items om te verkopen.", "error", 1000)
    end
        Citizen.Wait(1000)
    if Player.Functions.RemoveItem("iron", 1) then
        TriggerClientEvent("Framework:Notify", src, "Je hebt 1x ijzer verkocht", "success", 1000)
        Player.Functions.AddMoney("cash", Config.pricexd.iron)
        Citizen.Wait(200)
        TriggerClientEvent('pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['iron'], 'remove')
    else
        TriggerClientEvent("Framework:Notify", src, "Je hebt geen items om te verkopen.", "error", 1000)
    end
        Citizen.Wait(1000)
    -- if Player.Functions.RemoveItem("copper", 1) then
    --     TriggerClientEvent("Framework:Notify", src, "Je hebt 1x koper verkocht", "success", 1000)
    --     Player.Functions.AddMoney("cash", Config.pricexd.copper)
    --     Citizen.Wait(200)
    --     TriggerClientEvent('pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['copper'], 'remove')
    -- else
    --     TriggerClientEvent("Framework:Notify", src, "Je hebt geen items om te verkopen.", "error", 1000)
    -- end
        Citizen.Wait(1000)
    if Player.Functions.RemoveItem("diamond", 1) then
        TriggerClientEvent("Framework:Notify", src, "Je hebt 1x diamand verkocht", "success", 1000)
        Player.Functions.AddMoney("cash", Config.pricexd.diamond)
        Citizen.Wait(200)
        TriggerClientEvent('pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['diamond'], 'remove')
    else
        TriggerClientEvent("Framework:Notify", src, "Je hebt geen items om te verkopen.", "error", 1000)
    end
        Citizen.Wait(1000)
    if Player.Functions.RemoveItem("emerald", 1) then
        TriggerClientEvent("Framework:Notify", src, "Je hebt 1x smaragd verkocht", "success", 1000)
        Player.Functions.AddMoney("cash", Config.pricexd.emerald)
        Citizen.Wait(200)
        TriggerClientEvent('pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['emerald'], 'remove')
    else
        TriggerClientEvent("Framework:Notify", src, "Je hebt geen items om te verkopen.", "error", 1000)
    end
end
end)
