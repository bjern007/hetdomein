Framework = nil

local Drugs = Config.Drugs

TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)

Framework.Functions.CreateCallback('inside-selldrugs:checkMoneyWholesale', function(playerId, cb)
	local xPlayer = Framework.Functions.GetPlayer(playerId)

	if xPlayer.getMoney() >= Config.VehiclePrice then
        xPlayer.removeMoney(Config.VehiclePrice)
		cb(true)
	else
		cb(false)
	end
end)

Framework.Functions.CreateCallback('inside-selldrugs:checkMoneySingly', function(playerId, cb)
	local xPlayer = Framework.Functions.GetPlayer(playerId)

	-- if xPlayer.getMoney() >= Config.CustomersFindPrice then
        -- xPlayer.removeMoney(Config.CustomersFindPrice)
		cb(true)
	-- else
		-- cb(false)
	-- end
end)

Framework.Functions.CreateCallback('inside-selldrugs:checkWholesaleItems', function(source, cb)
	local xPlayer = Framework.Functions.GetPlayer(source)

	local weed = xPlayer.Functions.GetItemByName(Drugs.Weed.ItemName)
	local meth = xPlayer.Functions.GetItemByName(Drugs.Meth.ItemName)
	local opium = xPlayer.Functions.GetItemByName(Drugs.Opium.ItemName)
	local coke = xPlayer.Functions.GetItemByName(Drugs.Coke.ItemName)

	if weed >= Config.MinWholesaleCount then
		cb('hasWeed')
	elseif meth >= Config.MinWholesaleCount then
		cb('hasMeth')
	elseif opium >= Config.MinWholesaleCount then
		cb('hasOpium')
	elseif coke >= Config.MinWholesaleCount then
		cb('hasCoke')
	elseif weed <= Config.MinWholesaleCount and meth <= Config.MinWholesaleCount and opium <= Config.MinWholesaleCount and coke <= Config.MinWholesaleCount then
		cb('hasNothing')
	end
end)

Framework.Functions.CreateCallback('inside-selldrugs:sellWholesale', function(source, cb)
	local xPlayer = Framework.Functions.GetPlayer(source)

	local weed = xPlayer.Functions.GetItemByName(Drugs.Weed.ItemName)
	local meth = xPlayer.Functions.GetItemByName(Drugs.Meth.ItemName)
	local opium = xPlayer.Functions.GetItemByName(Drugs.Opium.ItemName)
	local coke = xPlayer.Functions.GetItemByName(Drugs.Coke.ItemName)

	local AmountPayoutWeed = weed * Drugs.Weed.ItemWholesalePrice
	local AmountPayoutMeth = meth * Drugs.Meth.ItemWholesalePrice
	local AmountPayoutOpium = opium * Drugs.Opium.ItemWholesalePrice
	local AmountPayoutCoke = coke * Drugs.Coke.ItemWholesalePrice

	if weed >= Config.MinWholesaleCount then
		xPlayer.removeInventoryItem(Drugs.Weed.ItemName, weed)
		
			Player.Functions.AddItem('money-roll', AmountPayoutWeed)
		TriggerClientEvent("pNotify:SendNotification", source, {text = "<b>Dealer</b></br>You sold Weed for <b style='color: green;'>" ..AmountPayoutWeed.. "$</b> Black Money!", timeout = 2500})
		cb('hasWeed')
	elseif meth >= Config.MinWholesaleCount then
		xPlayer.Functions.RemoveItem(Drugs.Weed.ItemName, meth)
		xPlayer.addAccountMoney('black_money', AmountPayoutMeth)
		TriggerClientEvent("pNotify:SendNotification", source, {text = "<b>Dealer</b></br>You sold Methamphetamine for <b style='color: green;'>" ..AmountPayoutMeth.. "$</b> Black Money!", timeout = 2500})
		cb('hasMeth')
	elseif opium >= Config.MinWholesaleCount then
		xPlayer.Functions.RemoveItem(Drugs.Weed.ItemName, opium)
		
		xPlayer.Functions.AddItem('money-roll', AmountPayoutOpium)
		TriggerClientEvent("pNotify:SendNotification", source, {text = "<b>Dealer</b></br>You sold Opium for <b style='color: green;'>" ..AmountPayoutOpium.. "$</b> Black Money!", timeout = 2500})
		cb('hasOpium')
	elseif coke >= Config.MinWholesaleCount then
		Player.Functions.RemoveItem(Drugs.Weed.ItemName, coke)
		
		xPlayer.Functions.AddItem('money-roll', AmountPayoutCoke)
		TriggerClientEvent("pNotify:SendNotification", source, {text = "<b>Dealer</b></br>You sold Cocaine for <b style='color: green;'>" ..AmountPayoutCoke.. "$</b> Black Money!", timeout = 2500})
		cb('hasCoke')
	elseif weed <= Config.MinWholesaleCount and meth <= Config.MinWholesaleCount and opium <= Config.MinWholesaleCount and coke <= Config.MinWholesaleCount then
		cb('hasNothing')
	end
end)

RegisterServerEvent('inside-selldrugs:clearDrugs')
AddEventHandler('inside-selldrugs:clearDrugs', function()
	local xPlayer = Framework.Functions.GetPlayer(source)

	local weed = Player.Functions.GetItemByName(Drugs.Weed.ItemName)
	local meth = Player.Functions.GetItemByName(Drugs.Meth.ItemName)
	local opium = Player.Functions.GetItemByName(Drugs.Opium.ItemName)
	local coke = Player.Functions.GetItemByName(Drugs.Coke.ItemName)

	if weed > 0 then
		Player.Functions.RemoveItem(Drugs.Weed.ItemName, weed)
	end
	if meth > 0 then
		Player.Functions.RemoveItem(Drugs.Weed.ItemName, meth)
	end
	if opium > 0 then
		Player.Functions.RemoveItem(Drugs.Weed.ItemName, opium)
	end
	if coke > 0 then
		Player.Functions.RemoveItem(Drugs.Weed.ItemName, coke)
	end
end)

RegisterServerEvent('inside-selldrugs:sellSingly')
AddEventHandler('inside-selldrugs:sellSingly', function(AmountPayout)	
	local xPlayer = Framework.Functions.GetPlayer(source)

	local weed = xPlayer.Functions.GetItemByName(Drugs.Weed.ItemName)
	local meth = xPlayer.Functions.GetItemByName(Drugs.Meth.ItemName)
	local opium = xPlayer.Functions.GetItemByName(Drugs.Opium.ItemName)
	local coke = xPlayer.Functions.GetItemByName(Drugs.Coke.ItemName)
	
	if weed > 0 then
		if weed == 1 then
			amount = math.random(1,1)
			AmountPayoutWeed = amount * Drugs.Weed.ItemSinglyPrice * AmountPayout
			xPlayer.Functions.RemoveItem(Drugs.Weed.ItemName, amount)
			
			xPlayer.Functions.AddItem('money-roll', AmountPayoutWeed)
		elseif weed == 2 then
			amount = math.random(1,2)
			AmountPayoutWeed = amount * Drugs.Weed.ItemSinglyPrice * AmountPayout
			xPlayer.Functions.RemoveItem(Drugs.Weed.ItemName, amount)
			
			xPlayer.Functions.AddItem('money-roll', AmountPayoutWeed)
		elseif weed == 3 then
			amount = math.random(1,3)
			AmountPayoutWeed = amount * Drugs.Weed.ItemSinglyPrice * AmountPayout
			xPlayer.Functions.RemoveItem(Drugs.Weed.ItemName, amount)
			xPlayer.Functions.AddItem('money-roll', AmountPayoutWeed)
		elseif weed == 4 then
			amount = math.random(1,4)
			AmountPayoutWeed = amount * Drugs.Weed.ItemSinglyPrice * AmountPayout
			Player.Functions.RemoveItem(Drugs.Weed.ItemName, amount)
			Player.Functions.AddItem('money-roll', AmountPayoutWeed)
		elseif weed >= 5 then
			amount = math.random(1,5)
			AmountPayoutWeed = amount * Drugs.Weed.ItemSinglyPrice * AmountPayout
			xPlayer.Functions.RemoveItem(Drugs.Weed.ItemName, amount)
			xPlayer.Functions.AddItem('money-roll', AmountPayoutWeed)
		end
		TriggerClientEvent("pNotify:SendNotification", source, {text = "<b>Dealer</b></br>You sold Weed for <b style='color: green;'>" ..AmountPayoutWeed.. "$</b> Black Money!", timeout = 2500})
	elseif meth > 0 then
		if meth == 1 then
			amount = math.random(1,1)
			AmountPayoutMeth = amount * Drugs.Meth.ItemSinglyPrice * AmountPayout
			
			xPlayer.Functions.RemoveItem(Drugs.Meth.ItemName, amount)
			xPlayer.addAccountMoney('black_money', AmountPayoutMeth)
		elseif meth == 2 then
			amount = math.random(1,2)
			AmountPayoutMeth = amount * Drugs.Meth.ItemSinglyPrice * AmountPayout
			xPlayer.Functions.RemoveItem(Drugs.Meth.ItemName, amount)
			xPlayer.addAccountMoney('black_money', AmountPayoutMeth)
		elseif meth == 3 then
			amount = math.random(1,3)
			AmountPayoutMeth = amount * Drugs.Meth.ItemSinglyPrice * AmountPayout
			
			xPlayer.Functions.RemoveItem(Drugs.Meth.ItemName, amount)
			xPlayer.addAccountMoney('black_money', AmountPayoutMeth)
		elseif meth == 4 then
			amount = math.random(1,4)
			AmountPayoutMeth = amount * Drugs.Meth.ItemSinglyPrice * AmountPayout
			
			xPlayer.Functions.RemoveItem(Drugs.Meth.ItemName, amount)
			xPlayer.addAccountMoney('black_money', AmountPayoutMeth)
		elseif meth >= 5 then
			amount = math.random(1,5)
			AmountPayoutMeth = amount * Drugs.Meth.ItemSinglyPrice * AmountPayout
			
			xPlayer.Functions.RemoveItem(Drugs.Meth.ItemName, amount)
			xPlayer.addAccountMoney('black_money', AmountPayoutMeth)
		end
		TriggerClientEvent("pNotify:SendNotification", source, {text = "<b>Dealer</b></br>You sold Methamphetamine for <b style='color: green;'>" ..AmountPayoutMeth.. "$</b> Black Money!", timeout = 2500})
	elseif opium > 0 then
		if opium == 1 then
			amount = math.random(1,1)
			AmountPayoutOpium = amount * Drugs.Opium.ItemSinglyPrice * AmountPayout
			
			xPlayer.Functions.RemoveItem(Drugs.Opium.ItemName, amount)
			xPlayer.Functions.AddItem('money-roll', AmountPayoutOpium)
		elseif opium == 2 then
			amount = math.random(1,2)
			AmountPayoutOpium = amount * Drugs.Opium.ItemSinglyPrice * AmountPayout
			xPlayer.Functions.RemoveItem(Drugs.Opium.ItemName, amount)
			
			xPlayer.Functions.AddItem('money-roll', AmountPayoutOpium)
		elseif opium == 3 then
			amount = math.random(1,3)
			AmountPayoutOpium = amount * Drugs.Opium.ItemSinglyPrice * AmountPayout
			
			xPlayer.Functions.RemoveItem(Drugs.Opium.ItemName, amount)
			
			xPlayer.Functions.AddItem('money-roll', AmountPayoutOpium)
		elseif opium == 4 then
			amount = math.random(1,4)
			AmountPayoutOpium = amount * Drugs.Opium.ItemSinglyPrice * AmountPayout
			
			xPlayer.Functions.RemoveItem(Drugs.Opium.ItemName, amount)
			
			xPlayer.Functions.AddItem('money-roll', AmountPayoutOpium)
		elseif opium >= 5 then
			amount = math.random(1,5)
			AmountPayoutOpium = amount * Drugs.Opium.ItemSinglyPrice * AmountPayout
			
			xPlayer.Functions.RemoveItem(Drugs.Opium.ItemName, amount)
			
			xPlayer.Functions.AddItem('money-roll', AmountPayoutOpium)
		end
		TriggerClientEvent("pNotify:SendNotification", source, {text = "<b>Dealer</b></br>You sold Opium for <b style='color: green;'>" ..AmountPayoutOpium.. "$</b> Black Money!", timeout = 2500})
	elseif coke > 0 then
		if coke == 1 then
			amount = math.random(1,1)
			AmountPayoutCoke = amount * Drugs.Coke.ItemSinglyPrice * AmountPayout
			xPlayer.removeInventoryItem(Drugs.Coke.ItemName, amount)
			xPlayer.Functions.AddItem('money-roll', AmountPayoutCoke)
		elseif coke == 2 then
			amount = math.random(1,2)
			AmountPayoutCoke = amount * Drugs.Coke.ItemSinglyPrice * AmountPayout
			xPlayer.removeInventoryItem(Drugs.Coke.ItemName, amount)
			
			xPlayer.Functions.AddItem('money-roll', AmountPayoutCoke)
		elseif coke == 3 then
			amount = math.random(1,3)
			AmountPayoutCoke = amount * Drugs.Coke.ItemSinglyPrice * AmountPayout
			xPlayer.removeInventoryItem(Drugs.Coke.ItemName, amount)
			
			xPlayer.Functions.AddItem('money-roll', AmountPayoutCoke)
		elseif coke == 4 then
			amount = math.random(1,4)
			AmountPayoutCoke = amount * Drugs.Coke.ItemSinglyPrice * AmountPayout
			xPlayer.removeInventoryItem(Drugs.Coke.ItemName, amount)
			
			xPlayer.Functions.AddItem('money-roll', AmountPayoutCoke)
		elseif coke >= 5 then
			amount = math.random(1,5)
			AmountPayoutCoke = amount * Drugs.Coke.ItemSinglyPrice * AmountPayout
			xPlayer.removeInventoryItem(Drugs.Coke.ItemName, amount)
			
			xPlayer.Functions.AddItem('money-roll', AmountPayoutCoke)
		end
		TriggerClientEvent("pNotify:SendNotification", source, {text = "<b>Dealer</b></br>You sold Cocaine for <b style='color: green;'>" ..AmountPayoutCoke.. "$</b> Black Money!", timeout = 2500})
	end
end)


Framework.Functions.CreateCallback('inside-selldrugs:checkSinglyItems', function(source, cb)
    local Player = Framework.Functions.GetPlayer(source)
    if Player ~= nil then
        if Player.Functions.GetItemByName(Drugs.Weed.ItemName) ~= nil or Player.Functions.GetItemByName(Drugs.Meth.ItemName) or Player.Functions.GetItemByName(Drugs.Opium.ItemName) ~= nil or Player.Functions.GetItemByName(Drugs.Coke.ItemName) ~= nil then
            cb(true)
        else
            cb(false)
        end
    end
end)

-- Framework.Functions.CreateCallback('inside-selldrugs:checkSinglyItems', function(source, cb)
-- 	local xPlayer = Framework.Functions.GetPlayer(source)

-- 	local weed = Player.Functions.GetItemByName(Drugs.Weed.ItemName)
-- 	local meth = Player.Functions.GetItemByName(Drugs.Meth.ItemName)
-- 	local opium = Player.Functions.GetItemByName(Drugs.Opium.ItemName)
-- 	local coke = Player.Functions.GetItemByName(Drugs.Coke.ItemName)
-- 	local amount = 0

-- 	if weed > 0 then
-- 		cb('hasWeed')
-- 	elseif meth > 0 then
-- 		cb('hasMeth')
-- 	elseif opium > 0 then
-- 		cb('hasOpium')
-- 	elseif coke > 0 then
-- 		cb('hasCoke')
-- 	else
-- 		cb('hasNothing')
-- 	end
-- end)