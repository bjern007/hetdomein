local Framework = exports["pepe-core"]:GetCoreObject() 

-- Code

local timeOut = false

local alarmTriggered = false

Framework.Functions.CreateCallback('pepe-ifruit:vitrineReward', function(source, cb)
	local src = source
    local Player = Framework.Functions.GetPlayer(src)
    local otherchance = math.random(1, 2)
    local odd = math.random(1, 2)

    if otherchance == odd then
        local item = math.random(1, #Config.VitrineRewards)
        local amount = math.random(Config.VitrineRewards[item]["amount"]["min"], Config.VitrineRewards[item]["amount"]["max"])
        if Player.Functions.AddItem(Config.VitrineRewards[item]["item"], amount) then
            TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items[Config.VitrineRewards[item]["item"]], 'add')
        else
            TriggerClientEvent('Framework:Notify', src, 'Je hebt te veel op zak.', 'error')
        end
    end
end)	

RegisterServerEvent('pepe-jewellery:server:recieve:extra')
AddEventHandler('pepe-jewellery:server:recieve:extra', function(Id)
  local Player = Framework.Functions.GetPlayer(source)
  Player.Functions.AddItem(Config.Items[Id]['Item'], 1)
  TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items[Config.Items[Id]['Item']], "add")
  Config.Items[Id]['Stolen'] = true
  TriggerClientEvent('pepe-jewellery:client:set:extra:state', -1, Id, true)
end)

Framework.Functions.CreateCallback('pepe-ifruit:server:setVitrineState', function(source, cb, stateType, state, k)
	Config.Locations[k][stateType] = state
    TriggerClientEvent('pepe-ifruit:client:setVitrineState', -1, stateType, state, k)
end)

Framework.Functions.CreateCallback('pepe-ifruit:server:setTimeout', function(source, cb)
	if not timeOut then
        timeOut = true
        TriggerEvent('pepe-board:server:SetActivityBusy', "applestore", true)
        Citizen.CreateThread(function()
            Citizen.Wait(Config.Timeout)

            for k, v in pairs(Config.Locations) do
                Config.Locations[k]["isOpened"] = false
                TriggerClientEvent('pepe-ifruit:client:setVitrineState', -1, 'isOpened', false, k)
                TriggerClientEvent('pepe-ifruit:client:setAlertState', -1, false)
                TriggerEvent('pepe-board:server:SetActivityBusy', "applestore", false)
            end
            timeOut = false
            alarmTriggered = false
        end)
    end
end)

Framework.Commands.Add("resetapple", "Reset de Applestore", {}, false, function(source, args)
    for k, v in pairs(Config.Locations) do
        Config.Locations[k]["isOpened"] = false
        TriggerClientEvent('pepe-ifruit:client:setVitrineState', -1, 'isOpened', false, k)
        TriggerClientEvent('pepe-ifruit:client:setAlertState', -1, false)
        TriggerEvent('pepe-board:server:SetActivityBusy', "applestore", false)
    end
    timeOut = false
    alarmTriggered = false
end, "admin")

Framework.Functions.CreateCallback('pepe-ifruit:server:PoliceAlertMessage', function(source, cb, title, coords, blip)
	local src = source
    local alertData = {
        title = title,
        coords = {x = coords.x, y = coords.y, z = coords.z},

        description = "Overval gaande bij de Apple Store <br>Beschikbare camera: Geen",
    }

    for k, v in pairs(Framework.Functions.GetPlayers()) do
        local Player = Framework.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                if blip then
                    if not alarmTriggered then
                        TriggerClientEvent("pepe-phone:client:addPoliceAlert", v, alertData)
                        TriggerClientEvent("pepe-ifruit:client:PoliceAlertMessage", v, title, coords, blip)
                        alarmTriggered = true
                    end
                else
                    TriggerClientEvent("pepe-phone:client:addPoliceAlert", v, alertData)
                    TriggerClientEvent("pepe-ifruit:client:PoliceAlertMessage", v, title, coords, blip)
                end
            end
        end
    end
end)

Framework.Functions.CreateCallback('pepe-ifruit:server:getCops', function(source, cb)
	local amount = 0
    for k, v in pairs(Framework.Functions.GetPlayers()) do
        local Player = Framework.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
	end
	cb(amount)
end)