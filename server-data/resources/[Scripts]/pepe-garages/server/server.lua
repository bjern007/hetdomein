-- Framework = nil

-- TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)
local Framework = exports["pepe-core"]:GetCoreObject()
-- Code

Framework.Functions.CreateCallback("pepe-garage:server:is:vehicle:owner", function(source, cb, plate)
    Framework.Functions.ExecuteSql(true, "SELECT * FROM `characters_vehicles` WHERE `plate` = @plate", {
      ['@plate'] = plate,
    }, function(result)
        local Player = Framework.Functions.GetPlayer(source)
        if result[1] ~= nil then
            if result[1].citizenid == Player.PlayerData.citizenid then
              cb(true)
            else
              cb(false)
            end
        else
            cb(false)
        end
    end)
end)

Framework.Functions.CreateCallback("pepe-garage:server:GetHouseVehicles", function(source, cb, HouseId)
  Framework.Functions.ExecuteSql(true, "SELECT * FROM `characters_vehicles` WHERE `garage` = @HouseId", {
    ['@HouseId'] = HouseId,
  }, function(result)
    if result ~= nil then
      cb(result)
    end 
  end)
end)


Framework.Functions.CreateCallback("pepe-garage:server:GetPoliceVehicles", function(source, cb)
  Framework.Functions.ExecuteSql(true, "SELECT * FROM `characters_vehicles` WHERE `garage` = @garage", {
    ['@garage'] = 'Police',
  }, function(result)
    if result ~= nil then
      cb(result)
    end 
  end)
end)

Framework.Functions.CreateCallback("pepe-garage:server:GetUserVehicles", function(source, cb, garagename)
  local src = source
  local Player = Framework.Functions.GetPlayer(src)
  Framework.Functions.ExecuteSql(true, "SELECT * FROM `characters_vehicles` WHERE `citizenid` = @citizenid AND garage = @garagename", {
    ['@citizenid'] = Player.PlayerData.citizenid,
    ['@garagename'] = garagename,
  }, function(result)
      if result ~= nil then
          for k, v in pairs(result) do
              cb(result)
          end
      end
      cb(nil)
  end)
end)

Framework.Functions.CreateCallback("pepe-garage:server:GetDepotVehicles", function(source, cb)
  local src = source
  local Player = Framework.Functions.GetPlayer(source)
  Framework.Functions.ExecuteSql(true, "SELECT * FROM `characters_vehicles` WHERE `citizenid` = @citizenid", {
    ['@citizenid'] = Player.PlayerData.citizenid,
  }, function(result)
      if result ~= nil then
          for k, v in pairs(result) do
              cb(result)
          end
      end
      cb(nil)
  end)
end)

Framework.Functions.CreateCallback("pepe-garage:server:pay:depot", function(source, cb, price)
  local src = source
  local Player = Framework.Functions.GetPlayer(src)
  if Player.Functions.RemoveMoney("cash", price, "Depot Paid") then
    cb(true)
  else
    TriggerClientEvent('Framework:Notify', src, "Je hebt niet genoeg contant..", "error")
    cb(false)
  end
end)

Framework.Functions.CreateCallback("pepe-garage:server:get:vehicle:mods", function(source, cb, plate)
  local src = source
  local properties = {}
  Framework.Functions.ExecuteSql(false, "SELECT `mods` FROM `characters_vehicles` WHERE `plate` = @plate", {
    ['@plate'] = plate,
  }, function(result)
      if result[1] ~= nil then
          properties = json.decode(result[1].mods)
      end
      cb(properties)
  end)
end)
RegisterNetEvent("pepe-garage:server:removeOldVehicle")
AddEventHandler("pepe-garage:server:removeOldVehicle", function(plate)
    plate = plate
    local vehicles = GetAllVehicles()
    for k, v in pairs(vehicles) do
        local p = GetVehicleNumberPlateText(v)
        if plate == p then 
            DeleteEntity(v)
        end
    end
end)

RegisterServerEvent('pepe-garages:server:set:in:Pgarage')
AddEventHandler('pepe-garages:server:set:in:Pgarage', function(Plate)
 --TriggerEvent('pepe-garages:server:set:garage:state', Plate, 'in')
 Framework.Functions.ExecuteSql(true, "UPDATE `characters_vehicles` SET garage = 'Legion Parking' WHERE `plate` = @plate", {
  ['@plate'] = Plate,
 })
end)

RegisterServerEvent('pepe-garages:server:set:in:garage')
AddEventHandler('pepe-garages:server:set:in:garage', function(Plate, GarageData, Status, MetaData)
 TriggerEvent('pepe-garages:server:set:garage:state', Plate, 'in')
 Framework.Functions.ExecuteSql(true, "UPDATE `characters_vehicles` SET garage = @garage, state = @state, metadata = @metadata WHERE `plate` = @plate", {
  ['@garage'] = GarageData,
  ['@state'] = Status,
  ['@metadata'] = json.encode(MetaData),
  ['@plate'] = Plate,
 })
end)

RegisterServerEvent('pepe-garages:server:set:in:impound')
AddEventHandler('pepe-garages:server:set:in:impound', function(Plate)
 TriggerEvent('pepe-garages:server:set:garage:state', Plate, 'in')
--  local MetaData = '{"Engine":1000.0,"Fuel":100.0,"Body":1000.0}'
 Framework.Functions.ExecuteSql(true, "UPDATE `characters_vehicles` SET garage = 'Police', state = 'in' WHERE `plate` = @plate", {
  ['@plate'] = Plate,
 })
end)

RegisterServerEvent('pepe-garages:server:set:garage:state')
AddEventHandler('pepe-garages:server:set:garage:state', function(Plate, Status)
  Framework.Functions.ExecuteSql(true, "UPDATE `characters_vehicles` SET state = '"..Status.."' WHERE `plate` = @plate", {
    ['@plate'] = Plate,
   })
end)

RegisterServerEvent('pepe-garages:server:set:depot:price')
AddEventHandler('pepe-garages:server:set:depot:price', function(Plate, Price)
  Framework.Functions.ExecuteSql(true, "UPDATE `characters_vehicles` SET depotprice = '"..Price.."' WHERE `plate` = @plate", {
    ['@plate'] = Plate,
   })
end)

RegisterNetEvent("pepe-garages:server:removeOldVehicle")
AddEventHandler("pepe-garages:server:removeOldVehicle", function(plate)
    plate = plate
    local vehicles = GetAllVehicles()
    for k, v in pairs(vehicles) do
        local p = GetVehicleNumberPlateText(v)
        if plate == p then 
            DeleteEntity(v)
        end
    end
end)
