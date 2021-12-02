
Framework = exports["pepe-core"]:GetCoreObject()

Framework.Commands.Add("radar", "Toggle speedradar", {}, false, function(source, args)
	local Player = Framework.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("wk:toggleRadar", source)
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency only!")
    end
end)