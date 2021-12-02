Framework = nil

TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)

Framework.Functions.CreateCallback('pepe-fishing:GetItemData', function(source, cb, itemName)
	local retval = false
	local Player = Framework.Functions.GetPlayer(source)
	if Player ~= nil then 
		if Player.Functions.GetItemByName(itemName) ~= nil then
			retval = true
		end
	end
	
	cb(retval)
end)	

Framework.Functions.CreateUseableItem("fishrod", function(source, item)
    local Player = Framework.Functions.GetPlayer(source)

    TriggerClientEvent('pepe-fishing:tryToFish', source)
end)


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
RegisterServerEvent('pepe-fishing:receiveFish')
AddEventHandler('pepe-fishing:receiveFish', function(cabin, house)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    local luck = math.random(1, 100)
    local itemFound = true
    local itemCount = 1

    if itemFound then
        for i = 1, itemCount, 1 do
            local randomItem = Config.FishingItems["type"]math.random(1, 2)
			local itemInfo = Framework.Shared.Items[randomItem]
			local SubValue = math.random(1,350)
            if luck == 100 then
                randomItem = "oxy"
                itemInfo = Framework.Shared.Items[randomItem]
                Player.Functions.AddItem(randomItem, 1)
				TriggerClientEvent('pepe-inventory:client:ItemBox', src, itemInfo, "add")
			elseif luck >= 99 and luck <= 100 then
				randomItem = "stingraymeat"
				itemInfo = Framework.Shared.Items[randomItem]
                Player.Functions.AddItem(randomItem, 1)
				TriggerClientEvent('pepe-inventory:client:ItemBox', src, itemInfo, "add")
			elseif luck >= 85 and luck <= 98 then
				randomItem = "plastic"
				itemInfo = Framework.Shared.Items[randomItem]
                Player.Functions.AddItem(randomItem, 6)
				TriggerClientEvent('pepe-inventory:client:ItemBox', src, itemInfo, "add")
			elseif luck >= 80 and luck <= 85 then
				randomItem = "ticket"
				itemInfo = Framework.Shared.Items[randomItem]
                Player.Functions.AddItem(randomItem, 2)
				TriggerClientEvent('pepe-inventory:client:ItemBox', src, itemInfo, "add")
			elseif luck >= 73 and luck <= 75 then
				randomItem = "plastic"
				itemInfo = Framework.Shared.Items[randomItem]
                Player.Functions.AddItem(randomItem, 1)
				TriggerClientEvent('pepe-inventory:client:ItemBox', src, itemInfo, "add")
			elseif luck >= 70 and luck <= 72 then
				randomItem = "fish-2"
				itemInfo = Framework.Shared.Items[randomItem]
                Player.Functions.AddItem(randomItem, 1)
				TriggerClientEvent('pepe-inventory:client:ItemBox', src, itemInfo, "add")
			elseif luck >= 65 and luck <= 70 then
				randomItem = "fish-3"
				itemInfo = Framework.Shared.Items[randomItem]
                Player.Functions.AddItem(randomItem, 1)
				TriggerClientEvent('pepe-inventory:client:ItemBox', src, itemInfo, "add")
			elseif luck >= 60 and luck <= 65 then
				randomItem = "fish-1"
				itemInfo = Framework.Shared.Items[randomItem]
                Player.Functions.AddItem(randomItem, 1)
				TriggerClientEvent('pepe-inventory:client:ItemBox', src, itemInfo, "add")
			elseif luck >= 55 and luck <= 60 then
				randomItem = "fish-3"
				itemInfo = Framework.Shared.Items[randomItem]
                Player.Functions.AddItem(randomItem, 1)
				TriggerClientEvent('pepe-inventory:client:ItemBox', src, itemInfo, "add")
			elseif luck >= 40 and luck <= 55 then
				randomItem = "fish-1"
				itemInfo = Framework.Shared.Items[randomItem]
                Player.Functions.AddItem(randomItem, 1)
				TriggerClientEvent('pepe-inventory:client:ItemBox', src, itemInfo, "add")
			elseif luck >= 30 and luck <= 40 then
				randomItem = "fish-2"
				itemInfo = Framework.Shared.Items[randomItem]
                Player.Functions.AddItem(randomItem, 1)
				TriggerClientEvent('pepe-inventory:client:ItemBox', src, itemInfo, "add")
			elseif luck >= 0 and luck <= 30 then
				randomItem = "fish-1"
				itemInfo = Framework.Shared.Items[randomItem]
                Player.Functions.AddItem(randomItem, 1)
				TriggerClientEvent('pepe-inventory:client:ItemBox', src, itemInfo, "add")
            end

			if SubValue < 5 then
				Player.Functions.AddItem('snspistol_part_3', 1)
				TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['snspistol_part_3'], "add") 
			end
            Citizen.Wait(500)
        end
    end
end)

RegisterServerEvent("pepe-fishing:sellFish")
AddEventHandler("pepe-fishing:sellFish", function()
    local src = source
	local Player = Framework.Functions.GetPlayer(src)
	local price = 0
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if Player.PlayerData.items[k].name == "fish-1" then 
                    price = price + (Config.FishingItems["fish"]["price"] * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("fish-1", Player.PlayerData.items[k].amount, k)
				elseif Player.PlayerData.items[k].name == "fish-2" then 
                    price = price + (Config.FishingItems["fish-2"]["price"] * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("fish-2", Player.PlayerData.items[k].amount, k)
				elseif Player.PlayerData.items[k].name == "fish-3" then 
                    price = price + (Config.FishingItems["fish-3"]["price"] * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("fish-3", Player.PlayerData.items[k].amount, k)
                end
            end
        end
        Player.Functions.AddMoney("cash", price, "sold-fish")
		TriggerClientEvent('Framework:Notify', src, "You have sold your fish")
	end
end)