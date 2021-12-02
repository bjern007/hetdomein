Framework = nil
TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)

Framework.Commands.Add("am", "Toggle animatie menu", {}, false, function(source, args)
	TriggerClientEvent('animations:client:ToggleMenu', source)
end)

Framework.Commands.Add("a", "Gebruik een animatie, voor animatie lijst doe /em", {{name = "naam", help = "Emote naam"}}, true, function(source, args)
	TriggerClientEvent('animations:client:EmoteCommandStart', source, args)
end)

Framework.Functions.CreateUseableItem("walkstick", function(source, item)
    local Player = Framework.Functions.GetPlayer(source)
    TriggerClientEvent("animations:UseWandelStok", source)
end)