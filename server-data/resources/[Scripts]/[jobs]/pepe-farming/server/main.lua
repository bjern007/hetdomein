-- SCRIPT DEVELOPED BY OSMIUM | OSMFX | DISCORD.IO/OSMFX --

Framework = nil

TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)

local playersProcessingCannabis = {}

RegisterServerEvent('pepe-farming:pickedUpCannabis')
AddEventHandler('pepe-farming:pickedUpCannabis', function()
	local src = source
	local Player = Framework.Functions.GetPlayer(src)

	  if TriggerClientEvent("Framework:Notify", src, "Mais gepakt", "Success", 3000) then
		  Player.Functions.AddItem('corn_kernel', Config.CornOutput) ---- change this shit 
		  TriggerClientEvent("inventory:client:ItemBox", source, Framework.Shared.Items['corn_kernel'], "add")
	  end
end)

RegisterServerEvent('pepe-farming:GivePlayerBox')
AddEventHandler('pepe-farming:GivePlayerBox', function()
	local src = source
	local Player = Framework.Functions.GetPlayer(src)

	Player.Functions.AddItem('box', 2) ---- change this shit 
	TriggerClientEvent("inventory:client:ItemBox", source, Framework.Shared.Items['box'], "add")

end)

RegisterServerEvent("pepe-farming:server:SellFarmingItems")
AddEventHandler("pepe-farming:server:SellFarmingItems", function()
    local src = source
    local price = 0
    local Player = Framework.Functions.GetPlayer(src)
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if Config.ItemList[Player.PlayerData.items[k].name] ~= nil then 
                    price = price + (Config.ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                end
            end
        end
        Player.Functions.AddMoney("cash", price, "sold-farm-items")
        TriggerClientEvent('Framework:Notify', src, "Je hebt items verkocht twv € "..price)
    end
end)

RegisterServerEvent('pepe-farming:CowMilked')
AddEventHandler('pepe-farming:CowMilked', function()
	local src = source
	local Player = Framework.Functions.GetPlayer(src)

	  if TriggerClientEvent("Framework:Notify", src, "Je hebt melk gekregen!", "Success", 4000) then
		  Player.Functions.AddItem('milk', Config.MilkOutput) ---- change this shit 
		  TriggerClientEvent("inventory:client:ItemBox", source, Framework.Shared.Items['milk'], "add")
	  end
end)

RegisterServerEvent('pepe-farming:ProcessCorn')
AddEventHandler('pepe-farming:ProcessCorn', function()
		local src = source
    	local Player = Framework.Functions.GetPlayer(src)
		local item = Player.Functions.GetItemByName('corn_kernel')
		if item ~= nil then 
			if item.amount > 4 then 
				Player.Functions.RemoveItem('corn_kernel', 4)----change this
				Player.Functions.RemoveItem('box', 1)----change this
				Player.Functions.AddItem('corn_pack', 1)----change this
				TriggerClientEvent("inventory:client:ItemBox", source, Framework.Shared.Items['corn_kernel'], "remove")
				TriggerClientEvent("inventory:client:ItemBox", source, Framework.Shared.Items['corn_pack'], "add")
				TriggerClientEvent('Framework:Notify', src, 'Mais verpakt!', "success")   
			else 
				TriggerClientEvent('Framework:Notify', src, 'Je hebt minstens 4 maiskolven nodig!', "success")   
			end     
		else    
			TriggerClientEvent('Framework:Notify', src, 'Je hebt minstens 4 maiskolven nodig!', "success")   
		end                                                                				
end)

RegisterServerEvent('pepe-farming:ProcessOranges')
AddEventHandler('pepe-farming:ProcessOranges', function()
		local src = source
    	local Player = Framework.Functions.GetPlayer(src)
		local item = Player.Functions.GetItemByName('orange')
		if item ~= nil then 
			if item.amount > 10 then 
				Player.Functions.RemoveItem('orange', math.random(5,10))----change this
				Player.Functions.RemoveItem('box', 1)----change this
				Player.Functions.AddItem('fruit_pack', 1)----change this
				TriggerClientEvent("inventory:client:ItemBox", source, Framework.Shared.Items['orange'], "remove")
				TriggerClientEvent("inventory:client:ItemBox", source, Framework.Shared.Items['fruit_pack'], "add")
				TriggerClientEvent('Framework:Notify', src, 'Sinasappel net met succes in elkaar geflanst!', "success")   
			else 
				TriggerClientEvent('Framework:Notify', src, 'Een goeie net sinasappels is minstens 10 nodig!', "success")   
			end     
		else    
			TriggerClientEvent('Framework:Notify', src, 'Een goeie net sinasappels is minstens 10 nodig!', "success")   
		end                                                                				
end)

RegisterServerEvent('pepe-farming:ProcessMilk')
AddEventHandler('pepe-farming:ProcessMilk', function()
		local src = source
    	local Player = Framework.Functions.GetPlayer(src)

		local item = Player.Functions.GetItemByName('milk')
		if item ~= nil then 
			if item.amount > 5 then 
				Player.Functions.RemoveItem('milk', math.random(2,5))----change this
				Player.Functions.RemoveItem('box', 1)----change this
				Player.Functions.AddItem('milk_pack', 1)----change this
				TriggerClientEvent("inventory:client:ItemBox", source, Framework.Shared.Items['milk'], "remove")
				TriggerClientEvent("inventory:client:ItemBox", source, Framework.Shared.Items['milk_pack'], "add")
				TriggerClientEvent('Framework:Notify', src, 'Halve liter melk doos verpakt en beplakt!', "success")   
			else 
				TriggerClientEvent('Framework:Notify', src, 'Je hebt minstens 5 halve liters nodig om een doos te vullen', "success")   
			end     
		else    
			TriggerClientEvent('Framework:Notify', src, 'Je hebt minstens 5 halve liters nodig om een doos te vullen', "success")   
		end                                                                				
end)

RegisterServerEvent('pepe-farming:server:SpawnTractor')
AddEventHandler('pepe-farming:server:SpawnTractor', function()
		local src = source
    	local Player = Framework.Functions.GetPlayer(src)
		local cashamount = Player.PlayerData.money["cash"]

		if cashamount >= Config.TractorRent then
			Player.Functions.RemoveMoney('cash', Config.TractorRent) 
			TriggerClientEvent('SpawnTractor', src)
		else
			TriggerClientEvent('Framework:Notify', src, 'Je hebt € '..Config.TractorRent..' contant nodig voor een trekker', "success")   
		end
end)

RegisterServerEvent('pepe-farming:GiveOranges')
AddEventHandler('pepe-farming:GiveOranges', function()
		local src = source
    	local Player = Framework.Functions.GetPlayer(src)
		Player.Functions.AddItem('orange', math.random(4, 7))----change this
		TriggerClientEvent('Framework:Notify', src, 'Je hebt een aantal sinasappels uit de boom kunnen krijgen!', "success")                                                                         				
end)

RegisterServerEvent('Server:UnRentTractor')
AddEventHandler('Server:UnRentTractor', function()
		local src = source
    	local Player = Framework.Functions.GetPlayer(src)
		-- Player.Functions.RemoveMoney('bank', 1500, 'tractor')
		TriggerClientEvent('UnRentTractor', src)
end)

function CancelProcessing(playerId)
	if playersProcessingCannabis[playerId] then
		ClearTimeout(playersProcessingCannabis[playerId])
		playersProcessingCannabis[playerId] = nil
	end
end

RegisterServerEvent('pepe-farming:cancelProcessing')
AddEventHandler('pepe-farming:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('pepe-farming:playerDropped', function(playerId, reason)
	CancelProcessing(playerId)
end)

RegisterServerEvent('pepe-farming:onPlayerDeath')
AddEventHandler('pepe-farming:onPlayerDeath', function(data)
	local src = source
	CancelProcessing(src)
end)

Framework.Functions.CreateCallback('pepe-farming:server:GetSellingPrice', function(source, cb)
    local retval = 0
    local Player = Framework.Functions.GetPlayer(source)
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if Config.ItemList[Player.PlayerData.items[k].name] ~= nil then 
                    retval = retval + (Config.ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                end
            end
        end
    end
    cb(retval)
end)
