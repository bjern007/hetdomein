local lastrob = 0
local Framework = exports["pepe-core"]:GetCoreObject()

Framework.Functions.CreateCallback('artheist:server:checkRobTime', function(source, cb)
    local src = source
    local player = Framework.Functions.GetPlayer(src)
    
    if (os.time() - lastrob) < Config['ArtHeist']['nextRob'] and lastrob ~= 0 then
        local seconds = Config['ArtHeist']['nextRob'] - (os.time() - lastrob)
        TriggerClientEvent('Framework:Notify', src, Strings['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'], "primary")
        cb(false)
    else
        lastrob = os.time()
        cb(true)
    end
end)

RegisterNetEvent('artheist:server:policeAlert')
AddEventHandler('artheist:server:policeAlert', function(coords)
    local players = Framework.Functions.GetPlayers()
    
    for i = 1, #players do
        local player = Framework.Functions.GetPlayer(players[i])
        if player.PlayerData.job.name == 'police' then
            TriggerClientEvent('artheist:client:policeAlert', players[i], coords)
        end
    end
end)


Framework.Functions.CreateCallback('pepe-artheist:server:getCops', function(source, cb)
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

RegisterServerEvent('artheist:server:syncHeistStart')
AddEventHandler('artheist:server:syncHeistStart', function()
    TriggerClientEvent('artheist:client:syncHeistStart', -1)
end)

RegisterServerEvent('artheist:server:syncPainting')
AddEventHandler('artheist:server:syncPainting', function(x)
    TriggerClientEvent('artheist:client:syncPainting', -1, x)
end)

RegisterServerEvent('artheist:server:syncAllPainting')
AddEventHandler('artheist:server:syncAllPainting', function()
    TriggerClientEvent('artheist:client:syncAllPainting', -1)
end)

RegisterServerEvent('artheist:server:rewardItem')
AddEventHandler('artheist:server:rewardItem', function(scene)
    local src = source
    local player = Framework.Functions.GetPlayer(src)
    local item = scene['rewardItem']

    if player then
        player.Functions.AddItem(item, 1)
    end
end)

RegisterServerEvent('artheist:server:finishHeist')
AddEventHandler('artheist:server:finishHeist', function()
    local src = source
    local player = Framework.Functions.GetPlayer(src)

    if player then
        for k, v in pairs(Config['ArtHeist']['painting']) do
            local count = player.Functions.GetItemByName(v['rewardItem'])
            if count ~= nil and count.amount > 0 then
                player.Functions.RemoveItem(v['rewardItem'], 1)
                player.Functions.AddMoney('cash', v['paintingPrice'], 'Art Heist')
            end
        end
    end
end)