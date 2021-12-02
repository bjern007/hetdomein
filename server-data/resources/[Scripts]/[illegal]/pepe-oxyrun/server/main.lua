local Framework = exports["pepe-core"]:GetCoreObject()

RegisterServerEvent('oxydelivery:server')
AddEventHandler('oxydelivery:server', function()
	local src = source
	local Player = Framework.Functions.GetPlayer(src)
	
	if Player.Functions.RemoveMoney('cash', Config.StartOxyPayment, "pay-job") then
		TriggerClientEvent("oxydelivery:startDealing", source)
		TriggerClientEvent('chatMessage', source, "Dealer", "normal", _U("car_outside"))
		TriggerClientEvent('Framework:Notify', src, _U("payed_deposit"), 'success')
	else
		TriggerClientEvent('Framework:Notify', src, _U("nocash"), 'error')   
    end
end)

RegisterServerEvent('oxydelivery:receiveoxy')
AddEventHandler('oxydelivery:receiveoxy', function()
    Framework.Functions.BanInjection(source, 'Oxy cheat on oxyrun')
end)

RegisterServerEvent('oxydelivery:receivemoneyyy')
AddEventHandler('oxydelivery:receivemoneyyy', function()
	Framework.Functions.BanInjection(source, 'Money cheat on oxyrun')
end)
 
Framework.Functions.CreateCallback('oxydelivery:server:receiveOxey', function(source, cb)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    local Redcard = math.random(1, 1000)
 
    local price = math.random(150, 300)
	Player.Functions.AddMoney("cash", price, "oxy-money")

    Player.Functions.AddItem('oxy', 1)
    TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items['oxy'], "add")

    if Redcard == 1 then
        Player.Functions.AddItem('yellow-red', 1)
        TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items['yellow-red'], "add")
    end
end)
 
Framework.Functions.CreateCallback('oxydelivery:server:receiveMoney', function(source, cb)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    local Oxyjoejoe = math.random(1, 25)
    
    local price = math.random(950, 4410)
	Player.Functions.AddMoney("cash", price, "oxy-money")

    if Oxyjoejoe == 5 then
        Player.Functions.AddItem('oxy', 1)
        TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items['oxy'], "add")
    end

    if Oxyjoejoe == 1 then
        Player.Functions.AddItem('money-roll', math(15, 36))
        TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items['money-roll'], "add")
    end
end)

RegisterServerEvent('pepe-oxyruns:server:callCops')
AddEventHandler('pepe-oxyruns:server:callCops', function(streetLabel, coords)
    local msg = _U("suspected").." "..streetLabel.."."
    local alertData = {
        title = "Oxyhandel",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = msg
    }
    for k, v in pairs(Framework.Functions.GetPlayers()) do
        local Player = Framework.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                TriggerClientEvent("pepe-oxyruns:client:robberyCall", Player.PlayerData.source, msg, streetLabel, coords)
                TriggerClientEvent("pepe-phone:client:addPoliceAlert", Player.PlayerData.source, alertData)
            end
        end
	end
end)