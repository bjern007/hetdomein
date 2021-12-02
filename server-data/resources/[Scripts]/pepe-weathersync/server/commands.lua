Framework.Commands.Add("blackout", "Create a blackout", {}, false, function(source, args)
    ToggleBlackout()
end, "admin")

Framework.Commands.Add("clock", "Change exact time", {}, false, function(source, args)
    if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil then
        SetExactTime(args[1], args[2])
    end
end, "admin")

Framework.Commands.Add("time", "Set time", {}, false, function(source, args)
    for _, v in pairs(AvailableTimeTypes) do
        if args[1]:upper() == v then
            SetTime(args[1])
            return
        end
    end
end, "admin")

Framework.Commands.Add("weather", "Set weather", {}, false, function(source, args)
    for _, v in pairs(AvailableWeatherTypes) do
        if args[1]:upper() == v then
            SetWeather(args[1])
            return
        end
    end
end, "admin")

Framework.Commands.Add("freeze", "Freeze time or weather", {}, false, function(source, args)
    if args[1]:lower() == 'weer' or args[1]:lower() == 'tijd' then
        FreezeElement(args[1])
    else
        TriggerClientEvent('Framework:Notify', source, "Wrong input format: /freeze (weather of time)", "error")
    end
end, "admin")