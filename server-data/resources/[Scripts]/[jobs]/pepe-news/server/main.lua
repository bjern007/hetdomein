-- Framework = nil
local Framework = exports["pepe-core"]:GetCoreObject()

-- TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)

Framework.Commands.Add("nieuwscam", "Pak een nieuwscamera", {}, false, function(source, args)
    local Player = Framework.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "reporter" then
        TriggerClientEvent("Cam:ToggleCam", source)
    end
end)

Framework.Commands.Add("nieuwsmic", "Pak een nieuwsmicrofoon", {}, false, function(source, args)
    local Player = Framework.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "reporter" then
        TriggerClientEvent("Mic:ToggleMic", source)
    end
end)

