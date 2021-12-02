
RegisterServerEvent('pepe-emsActives:server:createNUI')
AddEventHandler('pepe-emsActives:server:createNUI', function(draggable)
    local src = source
    local players = Framework.Functions.GetPlayers()
    local draggable = draggable.draggable
    local CopsInfo = {}
    for k, v in pairs(players) do
        local player = Framework.Functions.GetPlayer(v).PlayerData
        if player.job.name == "ambulance" then
            local callsignal = player.metadata["callsign"] ~= nil and player.metadata["callsign"] or "None"
            table.insert(CopsInfo, {name = player.charinfo.firstname .. ' ' .. player.charinfo.lastname, callsign = callsignal, onduty = player.job.onduty, grade = player.job.grade.name})
        end
    end
    TriggerClientEvent('pepe-emsActives:client:createNUI', src, CopsInfo, draggable)
end)

RegisterServerEvent('pepe-emsActives:server:updateParamedics')
AddEventHandler('pepe-emsActives:server:updateParamedics', function()
    local players = Framework.Functions.GetPlayers()
    local CopsInfo = {}
    for k, v in pairs(players) do
        local player = Framework.Functions.GetPlayer(v).PlayerData
        if player.job.name == "ambulance" then
            local callsignal = player.metadata["callsign"] ~= nil and player.metadata["callsign"] or "None"
            table.insert(CopsInfo, {name = player.charinfo.firstname .. ' ' .. player.charinfo.lastname, callsign = callsignal, onduty = player.job.onduty, grade = player.job.grade.name})
        end
    end

    TriggerClientEvent('pepe-emsActives:client:updateParamedics', -1, CopsInfo)
end)

Framework.Commands.Add('mlist', 'Check status collegas Ambulance', {{name = '1 - Draggable | 2 - Enable/Disable Permanent'}}, false, function(source, args)
    local src = source
    local xPlayer = Framework.Functions.GetPlayer(src)
    
    if xPlayer.PlayerData.job.name == "ambulance" then
        local draggable = tonumber(args[1]) ~= nil and tonumber(args[1]) or 0

        local src = source
        local players = Framework.Functions.GetPlayers()
        local CopsInfo = {}
        for k, v in pairs(players) do
            local player = Framework.Functions.GetPlayer(v).PlayerData
            if player.job.name == "ambulance" then
                local callsignal = player.metadata["callsign"] ~= nil and player.metadata["callsign"] or "None"
                table.insert(CopsInfo, {name = player.charinfo.firstname .. ' ' .. player.charinfo.lastname, callsign = callsignal, onduty = player.job.onduty, grade = player.job.grade.name})
            end
        end
        TriggerClientEvent('pepe-emsActives:client:createNUI', src, CopsInfo, draggable)
        TriggerEvent('pepe-logs:server:createLog', GetCurrentResourceName(), 'Command "plist"', "Used the command **plist** type " .. tostring(draggable), src)
    end
end)