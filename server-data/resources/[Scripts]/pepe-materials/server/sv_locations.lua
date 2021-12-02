QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent("r3_prospecting:UpdateBase")
AddEventHandler("r3_prospecting:UpdateBase", function(base)
    base_location = base
end)

-- Area to create targets within, matches the client side blips
local base_location = vector3(1580.9, 6592.204, 13.84828)
local area_size = 100.0

-- Choose a random item from the item_pool list
function GetNewRandomItem()
    local item = Config.Items[math.random(#Config.Items)]
    return {item = item.item, label = item.label}
end

-- Make a random location within the area
function GetNewRandomLocation()
    local offsetX = math.random(-area_size, area_size)
    local offsetY = math.random(-area_size, area_size)
    local pos = vector3(offsetX, offsetY, 0.0)
    if #(pos) > area_size then
        -- It's not within the circle, generate a new one instead
        return GetNewRandomLocation()
    end
    return base_location + pos
end

-- Generate a new target location
function GenerateNewTarget()
    local newPos = GetNewRandomLocation()
    local newData = GetNewRandomItem()
    Prospecting.AddTarget(newPos.x, newPos.y, newPos.z, newData)
end

RegisterServerEvent("r3_prospecting:activateProspecting")
AddEventHandler("r3_prospecting:activateProspecting", function()
    local player = source
    Prospecting.StartProspecting(player)
end)

CreateThread(function()
    -- Default difficulty
    Prospecting.SetDifficulty(1.0)

    -- Add a list of targets
    -- Each target needs an x, y, z and data entry
    Prospecting.AddTargets(Config.Locations)

    -- Generate 10 random extra targets
    for n = 0, 10 do
        GenerateNewTarget()
    end

    -- The player collected something
    Prospecting.SetHandler(function(player, data, x, y, z)
		FoundItem(player, data)
        -- Every time a
        GenerateNewTarget()
    end)

    -- The player started prospecting
    Prospecting.OnStart(function(player)
		Notify(player, "Started prospecting", "primary", 2500)
    end)

    -- The player stopped prospecting
    -- time in milliseconds
    Prospecting.OnStop(function(player, time)
		Notify(player, "Stopped prospecting", "primary", 2500)
    end)
end)


QBCore.Functions.CreateUseableItem("detector", function(source)
	TriggerClientEvent("r3_prospecting:useDetector", source)
end)

function FoundItem(player, data)
	local Player = QBCore.Functions.GetPlayer(player)
    local canCarry = false
    if Player.Functions.AddItem(data.item, 1) then
        Notify(player, "You found " .. data.label .. "!", "success", 5000)
        TriggerClientEvent('inventory:client:ItemBox', player, QBCore.Shared.Items[data.item], "add")
    else
        Notify(player, "You found " .. data.label .. " but your inventory is full!", "error", 5000)
    end
    Prospecting.StopProspecting(player)
    TriggerClientEvent("r3_prospecting:CloseMap", player)
end

QBCore.Functions.CreateUseableItem("treasure_map", function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("r3_prospecting:OpenMap", source)
    Player.Functions.RemoveItem('treasure_map', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["treasure_map"], "remove")
end)

function Notify(target, v, type, duration)
    TriggerClientEvent('QBCore:Notify', target, v, type, duration)
end
