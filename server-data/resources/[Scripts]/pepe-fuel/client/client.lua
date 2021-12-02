local IsBusy = false
local LoggedIn = false
-- Framework = nil
Framework = exports["pepe-core"]:GetCoreObject()
RegisterNetEvent("Framework:Client:OnPlayerLoaded")
AddEventHandler("Framework:Client:OnPlayerLoaded", function()
    Citizen.SetTimeout(1250, function()
        Framework.Functions.TriggerCallback("pepe-fuel:server:get:fuel:config", function(config)
            Config = config
        end)
        LoggedIn = true
    end)
end)

-- Code

-- // Events \\ --

RegisterNetEvent('pepe-fuel:client:register:vehicle:fuel')
AddEventHandler('pepe-fuel:client:register:vehicle:fuel', function(Plate, Vehicle, Amount)
 Config.VehicleFuel[Plate] = Amount
end)

RegisterNetEvent('pepe-fuel:client:update:vehicle:fuel')
AddEventHandler('pepe-fuel:client:update:vehicle:fuel', function(Plate, Vehicle, Amount)
 Config.VehicleFuel[Plate] = Amount
end)

-- // Loops \\ --

Citizen.CreateThread(function()
    Citizen.Wait(150)
    while true do
        Citizen.Wait(5)
        if LoggedIn then
        local Vehicle = GetVehiclePedIsIn(PlayerPedId())
        local Plate = GetVehicleNumberPlateText(Vehicle)
        if Vehicle ~= 0 then
            if Config.VehicleFuel[Plate] ~= nil then
                if IsVehicleEngineOn(Vehicle) then
                    if Config.VehicleFuel[Plate] ~= 0 then
                        if GetPedInVehicleSeat(Vehicle, -1) == PlayerPedId() then 
                          SetFuelLevel(Vehicle, Plate, Config.VehicleFuel[Plate] - Config.FuelUsageSpeed[Round(GetVehicleCurrentRpm(Vehicle, 1))] * Config.VehicleFuelUsage[GetVehicleClass(Vehicle)], false)
                          Citizen.Wait(7250)
                        end
                    end
                else
                    Citizen.Wait(250)
                end
            else
                Citizen.Wait(250)
                TriggerServerEvent('pepe-fuel:server:register:fuel', Plate, Vehicle, math.random(55, 95))
                Citizen.Wait(2500)
            end
         else
            Citizen.Wait(1000)
        end
      else
        Citizen.Wait(1000)
     end
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 1500
        if LoggedIn then
        local Vehicle, VehDistance = Framework.Functions.GetClosestVehicle()
        local Plate = GetVehicleNumberPlateText(Vehicle)
        InRange = false
        for k, v in pairs(Config.TankLocations) do
            local Distance = #(GetEntityCoords(PlayerPedId()) - vector3(Config.TankLocations[k]["Coords"]["X"], Config.TankLocations[k]["Coords"]["Y"], Config.TankLocations[k]["Coords"]["Z"])) 
            if Distance < 15.0 then
                InRange = true
                sleep = 5
                if VehDistance < 2.5 and not IsPedSittingInVehicle(PlayerPedId(), Vehicle) and GetFuelLevel(Plate) ~= 100 then
                  local VehicleCoords = GetEntityCoords(Vehicle)
                  DrawMarker(2, VehicleCoords.x, VehicleCoords.y, VehicleCoords.z + 1.15, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 35, 161, 48, 255, false, false, false, 1, false, false, false)     
                  DrawText3D(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z + 1.10, '~g~Inhoud~s~: '..GetFuelLevel(Plate).. '%\n~g~E~s~ - Brandstof | Kosten ~g~€~s~'..Config.TankLocations[k]['Tank-Price'])
                if IsControlJustReleased(0, 38) and not IsBusy then
                    Framework.Functions.TriggerCallback("pepe-fuel:server:can:fuel", function(CanFuel)
                        if CanFuel then
                         IsBusy = true
                         RefuelCar(Vehicle, Plate)
                        else
                         Framework.Functions.Notify('Je hebt niet genoeg geld.', 'error')
                        end
                    end, Config.TankLocations[k]["Tank-Price"])
                end
                else  
                    sleep = 1000
                end
            end
        end
     end

     Citizen.Wait(sleep)
    end
end)

-- // Functions \\ --

function GetFuelLevel(Plate)
    if Config.VehicleFuel[Plate] ~= nil then
        return Config.VehicleFuel[Plate]
    else
        return 0
    end
end

function SetFuelLevel(Vehicle, Plate, Amount, Spawned)
 if Amount < 0 then 
  Amount = 0 
 end
 if Spawned then
    if Amount < 100 or GetFuelLevel(Plate) < 100 then
        Amount = 100
    end
 end
 SetVehicleFuelLevel(Vehicle, Amount + 0.0)
 TriggerServerEvent('pepe-fuel:server:update:fuel', Plate, Vehicle, math.floor(Amount))
end

function RefuelCar(Vehicle, Plate)
 exports['pepe-assets']:RequestAnimationDict("weapon@w_sp_jerrycan")
 TaskPlayAnim( PlayerPedId(), "weapon@w_sp_jerrycan", "fire", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
 Framework.Functions.Progressbar("refuel-car", "Aan het tanken..", 10000, false, true, {
     disableMovement = true,
     disableCarMovement = true,
     disableMouse = false,
     disableCombat = true,
 }, {}, {}, {}, function() -- Done
    IsBusy = false
    SetFuelLevel(Vehicle, Plate, 100, false)
    PlaySound(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
    -- Framework.Functions.Notify('Voertuig vol getankt.', 'success')
    StopAnimTask(PlayerPedId(), "weapon@w_sp_jerrycan", "fire", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
 end, function() -- Cancel
    IsBusy = false
    StopAnimTask(PlayerPedId(), "weapon@w_sp_jerrycan", "fire", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
 end)
end

function DrawText3D(x, y, z, text)
 SetTextScale(0.35, 0.35)
 SetTextFont(4)
 SetTextProportional(1)
 SetTextColour(255, 255, 255, 215)
 SetTextEntry("STRING")
 SetTextCentre(true)
 AddTextComponentString(text)
 SetDrawOrigin(x,y,z, 0)
 DrawText(0.0, 0.0)
 ClearDrawOrigin()
end

function Round(num, numDecimalPlaces)
 local mult = 10^(numDecimalPlaces or 0)
 return math.floor(num * mult + 0.5) / mult
end