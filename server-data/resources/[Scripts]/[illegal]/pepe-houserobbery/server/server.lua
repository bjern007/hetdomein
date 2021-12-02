local Framework = exports["pepe-core"]:GetCoreObject()

Framework.Functions.CreateCallback('pepe-houserobbery:server:get:config', function(source, cb)
  cb(Config)
end)

-- Code

Framework.Commands.Add("resethuizen", "Reset de overvalbare huizen", {}, false, function(source, args)
  for k, v in pairs(Config.HouseLocations) do
    Config.HouseLocations[k]['Opened'] = false
      TriggerEvent('pepe-houserobbery:server:set:door:status', k, false)
  end
end, "admin")

RegisterServerEvent('pepe-houserobbery:server:set:door:status')
AddEventHandler('pepe-houserobbery:server:set:door:status', function(RobHouseId, bool)
 Config.HouseLocations[RobHouseId]['Opened'] = bool
 TriggerClientEvent('pepe-houserobbery:client:set:door:status', -1, RobHouseId, bool)
 ResetHouse(RobHouseId)
end)

RegisterServerEvent('pepe-houserobbery:server:set:locker:state')
AddEventHandler('pepe-houserobbery:server:set:locker:state', function(RobHouseId, LockerId, Type, bool)
 Config.HouseLocations[RobHouseId]['Lockers'][LockerId][Type] = bool
 TriggerClientEvent('pepe-houserobbery:client:set:locker:state', -1, RobHouseId, LockerId, Type, bool)
end)

RegisterServerEvent('pepe-houserobbery:server:locker:reward')
AddEventHandler('pepe-houserobbery:server:locker:reward', function()
  local Player = Framework.Functions.GetPlayer(source)
  local RandomValue = math.random(1, 100)
  if RandomValue <= 30 then
    Player.Functions.AddMoney('cash', math.random(250, 350), "House Robbery")
  elseif RandomValue >= 45 and RandomValue <= 58 then
    Player.Functions.AddItem('diamond-ring', math.random(2,7))
    TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['diamond-ring'], "add")
  elseif RandomValue >= 76 and RandomValue <= 82 then
    Player.Functions.AddItem('gold-necklace', math.random(2,7))
    TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['gold-necklace'], "add") 
  elseif RandomValue >= 83 and RandomValue <= 98 then
    Player.Functions.AddItem('gold-rolex', math.random(1,5))
    TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['gold-rolex'], "add")
  else
    TriggerClientEvent('Framework:Notify', source, "Je vond niks hier.", "error", 4500)
  end 
end)

RegisterServerEvent('pepe-houserobbery:server:recieve:extra')
AddEventHandler('pepe-houserobbery:server:recieve:extra', function(CurrentHouse, Id)
  local Player = Framework.Functions.GetPlayer(source)
  Player.Functions.AddItem(Config.HouseLocations[CurrentHouse]['Extras'][Id]['Item'], 1)
  TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items[Config.HouseLocations[CurrentHouse]['Extras'][Id]['Item']], "add")
  Config.HouseLocations[CurrentHouse]['Extras'][Id]['Stolen'] = true
  TriggerClientEvent('pepe-houserobbery:client:set:extra:state', -1, CurrentHouse, Id, true)
end)

function ResetHouse(HouseId)
  Citizen.SetTimeout((1000 * 60) * 15, function()
      Config.HouseLocations[HouseId]["Opened"] = false
      for k, v in pairs(Config.HouseLocations[HouseId]["Lockers"]) do
          v["Opened"] = false
          v["Busy"] = false
      end
      if Config.HouseLocations[HouseId]["Extras"] ~= nil then
        for k, v in pairs(Config.HouseLocations[HouseId]["Extras"]) do
          v['Stolen'] = false
        end
      end
      TriggerClientEvent('pepe-houserobbery:server:reset:state', -1, HouseId)
  end)
end