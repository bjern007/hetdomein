local Framework = exports["pepe-core"]:GetCoreObject()
-- Code

Framework.Functions.CreateCallback('pepe-board:server:GetActiveCops', function(source, cb)
    local retval = 0
    
    for k, v in pairs(Framework.Functions.GetPlayers()) do
        local Player = Framework.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                retval = retval + 1
            end
        end
    end

    cb(retval)
end)
Framework.Functions.CreateCallback('kwk-scoreboard:server:GetActivity', function(source, cb)
    local PoliceCount = 0
    local AmbulanceCount = 0
    local AutocareCount = 0
    local CardealerCount = 0

    for k, v in pairs(Framework.Functions.GetPlayers()) do
        local Player = Framework.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                PoliceCount = PoliceCount + 1
            end

            if ((Player.PlayerData.job.name == "ambulance" or Player.PlayerData.job.name == "doctor") and Player.PlayerData.job.onduty) then
                AmbulanceCount = AmbulanceCount + 1
            end

            if (Player.PlayerData.job.name == "mechanic" and Player.PlayerData.job.onduty) then
                AutocareCount = AutocareCount + 1
            end
            
			if (Player.PlayerData.job.name == "cardealer" and Player.PlayerData.job.onduty) then
                CardealerCount = CardealerCount + 1
            end
        end
    end

    cb(PoliceCount, AmbulanceCount, AutocareCount, CardealerCount)
end)

Framework.Functions.CreateCallback('pepe-board:server:GetConfig', function(source, cb)
    cb(Config.IllegalActions)
end)

RegisterServerEvent('pepe-board:server:SetActivityBusy')
AddEventHandler('pepe-board:server:SetActivityBusy', function(activity, bool)
    Config.IllegalActions[activity].busy = bool
    TriggerClientEvent('pepe-board:client:SetActivityBusy', -1, activity, bool)
end)

Framework.Functions.CreateCallback('pepe-board:server:GetPlayersArrays', function(source, cb)
    local players = {}
    for k, v in pairs(Framework.Functions.GetPlayers()) do
        local Player = Framework.Functions.GetPlayer(v)
        if Player ~= nil then 
            players[Player.PlayerData.source] = {}
            players[Player.PlayerData.source].permission = Framework.Functions.IsOptinBoard(Player.PlayerData.source)
        end
    end
    cb(players)
end)
