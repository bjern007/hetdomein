-- Framework = nil
local Framework = exports["pepe-core"]:GetCoreObject()

-- TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)

Framework.Functions.CreateCallback("pepe-doorlock:server:get:config", function(source, cb)
    cb(Config)
end)

RegisterServerEvent('pepe-doorlock:server:change:door:looks')
AddEventHandler('pepe-doorlock:server:change:door:looks', function(Door, Type)
 TriggerClientEvent('pepe-doorlock:client:change:door:looks', -1, Door, Type)
end)

RegisterServerEvent('pepe-doorlock:server:reset:door:looks')
AddEventHandler('pepe-doorlock:server:reset:door:looks', function()
 TriggerClientEvent('pepe-doorlock:client:reset:door:looks', -1)
end)

RegisterServerEvent('pepe-doorlock:server:updateState')
AddEventHandler('pepe-doorlock:server:updateState', function(doorID, state)
 Config.Doors[doorID]['Locked'] = state
 TriggerClientEvent('pepe-doorlock:client:setState', -1, doorID, state)
end)