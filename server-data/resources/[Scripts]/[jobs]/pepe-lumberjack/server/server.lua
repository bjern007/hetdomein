
-- Framework = nil
-- TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)

local Framework = exports["pepe-core"]:GetCoreObject()


RegisterServerEvent('wood:getItem')
AddEventHandler('wood:getItem', function()
	local xPlayer, randomItem = Framework.Functions.GetPlayer(source), Config.Items[math.random(1, #Config.Items)]
	
	if math.random(0, 100) <= Config.ChanceToGetItem then
		local Item = xPlayer.Functions.GetItemByName('wood_cut')
		if Item == nil then
			xPlayer.Functions.AddItem(randomItem, 1)
			TriggerClientEvent("pepe-inventory:client:ItemBox", source, Framework.Shared.Items[randomItem], "add")
		else	
		if Item.amount < 20 then
		xPlayer.Functions.AddItem(randomItem, 1)
		TriggerClientEvent("pepe-inventory:client:ItemBox", source, Framework.Shared.Items[randomItem], "add")
		else
			TriggerClientEvent('Framework:Notify', source, 'Inventaris zit vol. Je kunt niet meer bij je dragen', "error")  
		end
	    end
    end
end)

RegisterServerEvent('wood_weed:processweed2')
AddEventHandler('wood_weed:processweed2', function()
	local src = source
	local Player = Framework.Functions.GetPlayer(src)

	--if Player.Functions.GetItemByName('wood_cut') then
		local Houtje = Player.Functions.GetItemByName("wood_cut")
		if Houtje ~= nil then
			if Houtje.amount >= 5 then
		--local chance = math.random(1, 8)
		--if chance == 1 or chance == 2 or chance == 3 or chance == 4 or chance == 5 or chance == 6 or chance == 7 or chance == 8 then
			Player.Functions.RemoveItem('wood_cut', 5)
			Player.Functions.AddItem('wood_proc', math.random(5, 7))
			TriggerClientEvent("pepe-inventory:client:ItemBox", source, Framework.Shared.Items['wood_cut'], "remove")
			TriggerClientEvent("pepe-inventory:client:ItemBox", source, Framework.Shared.Items['wood_proc'], "add")
			TriggerClientEvent('Framework:Notify', src, 'Hout verwerkt', "success")  
			else
				TriggerClientEvent('Framework:Notify', src, 'Zorg dat je vijf hout bij je hebt.', "error") 	
			end 
	else
		TriggerClientEvent('Framework:Notify', src, 'Je hebt niet de juiste items', "error") 
	end
end)

RegisterServerEvent('wood:sell')
AddEventHandler('wood:sell', function()
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    for k, v in pairs(Player.PlayerData.items) do
        if v.name == 'wood_proc' then
            Player.Functions.RemoveItem('wood_proc', 1)
            Player.Functions.AddMoney('cash', math.random(75, 80), 'sold-wood')
            TriggerClientEvent('pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['wood_proc'], "remove")
        end
    end
end)


local prezzo = 10
RegisterServerEvent('pepe-jobwood:server:truck')
AddEventHandler('pepe-jobwood:server:truck', function(boatModel, BerthId)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    local plate = "HOUT"..math.random(1111, 9999)
    
	TriggerClientEvent('pepe-jobwood:Auto', src, boatModel, plate)
end)
