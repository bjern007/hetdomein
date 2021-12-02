local Framework = exports["pepe-core"]:GetCoreObject()

Framework.Functions.CreateCallback('pepe-radialmenu:server:HasItem', function(source, cb, itemName)
    local Player = Framework.Functions.GetPlayer(source)
    if Player ~= nil then
      local Item = Player.Functions.GetItemByName(itemName)
        if Item ~= nil then
			cb(true)
        else
			cb(false)
        end
	end
end)

Framework.Commands.Add("f1reset", "Reset de F1.", {}, false, function(source, args)
  TriggerClientEvent('pepe-radialmenu:client:refresh', source)
end)