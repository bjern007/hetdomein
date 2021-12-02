local Framework = exports["pepe-core"]:GetCoreObject()


Framework.Commands.Add("cash", "Check cash", {}, false, function(source, args)
	TriggerClientEvent('hud:client:ShowMoney', source, "cash")
end)