-- Framework = nil

-- TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)
local Framework = exports["pepe-core"]:GetCoreObject()

-- Code

RegisterServerEvent('pepe-materials:server:get:reward')
AddEventHandler('pepe-materials:server:get:reward', function()
		Framework.Functions.BanInjection(source, 'Triggeren materials reward')
end)
Framework.Functions.CreateCallback('pepe-materials:server:get:reward', function(source)
    local Player = Framework.Functions.GetPlayer(source)
    local RandomValue = math.random(1, 100)
    local RandomItems = Config.BinItems[math.random(#Config.BinItems)]
    if RandomValue <= 55 then
     Player.Functions.AddItem(RandomItems, math.random(2, 9))
     TriggerClientEvent('pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items[RandomItems], 'add')
    elseif RandomValue >= 85 and RandomValue <= 89 then
      
    Player.Functions.AddItem('lockpick', 1)
    TriggerClientEvent('pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['lockpick'], 'add')
    
    else
        TriggerClientEvent('Framework:Notify', Player.PlayerData.source, 'Je vond niks.', 'error')
    end

end)

RegisterServerEvent('pepe-materials:server:scrap:reward')
AddEventHandler('pepe-materials:server:scrap:reward', function()
    -- Framework.Functions.BanInjection(source, 'Triggeren materials reward')
    local Player = Framework.Functions.GetPlayer(source)
    for i = 1, math.random(4, 8), 1 do
        local Items = Config.CarItems[math.random(1, #Config.CarItems)]
        local RandomNum = math.random(2, 30)

        if Items == "plastic" then 
          RandomNum = math.random(15, 45)
        end
        
        Player.Functions.AddItem(Items, RandomNum)
        TriggerClientEvent('pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items[Items], 'add')
        Player.Functions.AddItem('rubber', math.random(1, 6))
        TriggerClientEvent('pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['rubber'], 'add')
        Citizen.Wait(500)
    end
    -- if math.random(1, 100) <= 35 then
    --   Player.Functions.AddItem('rubber', math.random(1, 6))
    --   TriggerClientEvent('pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['rubber'], 'add')
    -- end
      
  if math.random(1, 150) <= 15 then
    Player.Functions.AddItem('lockpick', 1)
    TriggerClientEvent('pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['lockpick'], 'add')
  end
  
  Player.Functions.SetMetaData("geduldrep", Player.PlayerData.metadata["geduldrep"]+1)
end)

Framework.Functions.CreateCallback('pepe-materials:server:scrap:reward', function(source)
  local Player = Framework.Functions.GetPlayer(source)
  for i = 1, math.random(4, 8), 1 do
      local Items = Config.CarItems[math.random(1, #Config.CarItems)]
      local RandomNum = math.random(2, 20)
      Player.Functions.AddItem(Items, RandomNum)
      
      TriggerClientEvent('pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items[Items], 'add')
      Citizen.Wait(500)
  end
  
  -- if math.random(1, 100) <= 35 then
  --   Player.Functions.AddItem('rubber', math.random(1, 9))
  --   TriggerClientEvent('pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['rubber'], 'add')
  -- end
  
  if math.random(1, 135) <= 15 then
    Player.Functions.AddItem('lockpick', 1)
    TriggerClientEvent('pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['lockpick'], 'add')
  end
  
  if math.random(1, 450) <= 2 then
    Player.Functions.AddItem('treasure_map', 1)
    TriggerClientEvent('pepe-inventory:client:ItemBox', Player.PlayerData.source, Framework.Shared.Items['treasure_map'], 'add')
  end

  Player.Functions.SetMetaData("geduldrep", Player.PlayerData.metadata["geduldrep"]+1)

end)

-- COMMENT UNTILL FURTHER NOTICE AND WORK - KAMATCHO

-- RegisterServerEvent("r3_prospecting:UpdateBase")
-- AddEventHandler("r3_prospecting:UpdateBase", function(base)
--     base_location = base
-- end)

-- -- Area to create targets within, matches the client side blips
-- local base_location = vector3(1580.9, 6592.204, 13.84828)
-- local area_size = 100.0

-- -- Choose a random item from the item_pool list
-- function GetNewRandomItem()
--     local item = Config.Items[math.random(#Config.Items)]
--     return {item = item.item, label = item.label}
-- end

-- -- Make a random location within the area
-- function GetNewRandomLocation()
--     local offsetX = math.random(-area_size, area_size)
--     local offsetY = math.random(-area_size, area_size)
--     local pos = vector3(offsetX, offsetY, 0.0)
--     if #(pos) > area_size then
--         -- It's not within the circle, generate a new one instead
--         return GetNewRandomLocation()
--     end
--     return base_location + pos
-- end

-- -- Generate a new target location
-- function GenerateNewTarget()
--     local newPos = GetNewRandomLocation()
--     local newData = GetNewRandomItem()
--     Prospecting.AddTarget(newPos.x, newPos.y, newPos.z, newData)
-- end

-- RegisterServerEvent("r3_prospecting:activateProspecting")
-- AddEventHandler("r3_prospecting:activateProspecting", function()
--     local player = source
--     Prospecting.StartProspecting(player)
-- end)

-- CreateThread(function()
--     -- Default difficulty
--     Prospecting.SetDifficulty(1.0)

--     -- Add a list of targets
--     -- Each target needs an x, y, z and data entry
--     Prospecting.AddTargets(Config.Locations)

--     -- Generate 10 random extra targets
--     for n = 0, 10 do
--         GenerateNewTarget()
--     end

--     -- The player collected something
--     Prospecting.SetHandler(function(player, data, x, y, z)
-- 		FoundItem(player, data)
--         -- Every time a
--         GenerateNewTarget()
--     end)

--     -- The player started prospecting
--     Prospecting.OnStart(function(player)
-- 		Notify(player, "Started prospecting", "primary", 2500)
--     end)

--     -- The player stopped prospecting
--     -- time in milliseconds
--     Prospecting.OnStop(function(player, time)
-- 		Notify(player, "Stopped prospecting", "primary", 2500)
--     end)
-- end)


-- Framework.Functions.CreateUseableItem("detector", function(source)
-- 	TriggerClientEvent("r3_prospecting:useDetector", source)
-- end)

-- function FoundItem(player, data)
-- 	local Player = Framework.Functions.GetPlayer(player)
--     local canCarry = false
--     if Player.Functions.AddItem(data.item, 1) then
--         Notify(player, "You found " .. data.label .. "!", "success", 5000)
--         TriggerClientEvent('inventory:client:ItemBox', player, Framework.Shared.Items[data.item], "add")
--     else
--         Notify(player, "You found " .. data.label .. " but your inventory is full!", "error", 5000)
--     end
--     Prospecting.StopProspecting(player)
--     TriggerClientEvent("r3_prospecting:CloseMap", player)
-- end

-- Framework.Functions.CreateUseableItem("treasure_map", function(source)
--     local Player = Framework.Functions.GetPlayer(source)
--     TriggerClientEvent("r3_prospecting:OpenMap", source)
--     Player.Functions.RemoveItem('treasure_map', 1)
--     TriggerClientEvent('inventory:client:ItemBox', source, Framework.Shared.Items["treasure_map"], "remove")
-- end)

-- COMMENT UNTILL FURTHER NOTICE AND WORK - KAMATCHO

function Notify(target, v, type, duration)
    TriggerClientEvent('Framework:Notify', target, v, type, duration)
end
