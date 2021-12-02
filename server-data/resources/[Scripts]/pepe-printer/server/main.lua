-- Framework = nil
-- TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)
local Framework = exports["pepe-core"]:GetCoreObject()

-- Code

Framework.Functions.CreateUseableItem("printerdocument", function(source, item)
    local Player = Framework.Functions.GetPlayer(source)
    TriggerClientEvent('pepe-printer:client:UseDocument', source, item)
end)

-- Framework.Commands.Add("spawnprinter", "Spawn een printer", {}, true, function(source, args)
-- 	TriggerClientEvent('pepe-printer:client:SpawnPrinter', source)
-- end, "admin")

RegisterServerEvent('pepe-printer:server:SaveDocument')
AddEventHandler('pepe-printer:server:SaveDocument', function(url)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    local info = {}

    if url ~= nil then
        info.url = url
        Player.Functions.AddItem('printerdocument', 1, nil, info)
        TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items['printerdocument'], "add")
    end
end)