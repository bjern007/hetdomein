local Framework = exports["pepe-core"]:GetCoreObject()

-- Code

Citizen.CreateThread(function()
    Config.Locations = {['X'] = -1108.57, ['Y'] = -1643.51, ['Z'] = 4.64}
end)

Framework.Functions.CreateCallback("pepe-crafting:server:get:config", function(source, cb)
    cb(Config.Locations)
end)

function GetCraftingConfig(ItemId)
    return Config.CraftingItems[ItemId]
end

function GetWeaponCraftingConfig(ItemId)
    return Config.CraftingWeapons[ItemId]
end

function GetWeaponTrapConfig(ItemId)
    return Config.TrapHouseItems[ItemId]
end



RegisterServerEvent('pepe-crafting:client:open:craftstation')
AddEventHandler('pepe-crafting:client:open:craftstation', function()
 TriggerClientEvent('pepe-crafting:client:open:craftstation', source)
end)


RegisterServerEvent('pepe-crafting:client:open:trapstation')
AddEventHandler('pepe-crafting:client:open:trapstation', function()
 TriggerClientEvent('pepe-crafting:client:open:trapstation', source)
end)