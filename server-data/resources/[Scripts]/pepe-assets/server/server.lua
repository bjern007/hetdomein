local Framework = exports["pepe-core"]:GetCoreObject()

RegisterServerEvent('pepe-assets:server:tackle:player')
AddEventHandler('pepe-assets:server:tackle:player', function(playerId)
    TriggerClientEvent("pepe-assets:client:get:tackeled", playerId)
end)

RegisterServerEvent('pepe-assets:server:display:text')
AddEventHandler('pepe-assets:server:display:text', function(Text)
	TriggerClientEvent('pepe-assets:client:me:show', -1, Text, source)
end)

-- RegisterServerEvent('pepe-assets:server:drop')
-- AddEventHandler('pepe-assets:server:drop', function()
-- 	if not Framework.Functions.HasPermission(source, 'admin') then
-- 		TriggerEvent("pepe-logs:server:SendLog", "anticheat", "Nui Devtools", "red", "**".. GetPlayerName(source).. "** Probeerde DevTools te openen.")
-- 		DropPlayer(source, 'DevTools niet openen graag.')
-- 	end
-- end)

Framework.Commands.Add("id", "Wat is mijn ID?", {}, false, function(source, args)
    TriggerClientEvent('chatMessage', source, "SYSTEEM", "warning", "ID: "..source)
end)
Framework.Commands.Add("shuffle", "Shuffle seats", {}, false, function(source, args)
 TriggerClientEvent('pepe-assets:client:seat:shuffle', source)
end)
--[[
Framework.Commands.Add("me", "Wanneer je iets moet uitvoeren in tekst.", {}, false, function(source, args)
  local Text = table.concat(args, ' ')
  TriggerClientEvent('pepe-assets:client:me:show', -1, Text, source)
end)]]--