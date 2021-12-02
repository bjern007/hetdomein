-- Framework = nil

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(10)
--         if Framework == nil then
--             TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)
--             Citizen.Wait(200)
--         end
--     end
-- end)

Framework = exports["pepe-core"]:GetCoreObject()

isLoggedIn = false
PlayerJob = {}

local Duikboot = nil
local heeftduikboot = false
local DeliveryBlip = nil
local GarbageBlip = nil


function BringBackCar()
    local veh = GetVehiclePedIsIn(PlayerPedId())
    DeleteVehicle(veh)
    if DeliveryBlip ~= nil then
        RemoveBlip(DeliveryBlip)
    end
    Duikboot = nil
    heeftduikboot = false
    DeliveryBlip = nil
end




function Enterduikboot()
    local PlayerCoords = GetEntityCoords(PlayerPedId())
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local Area = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z, true)
    if Area < 2.0 then
        return true
    end
end


RegisterNetEvent('pepe-duikboot:client:enter')
AddEventHandler('pepe-duikboot:client:enter', function(House)
    local PlayerCoords = GetEntityCoords(PlayerPedId())
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
	local Area = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z, true)
    if Area < 2.0 then
        Framework.Functions.TriggerCallback('pepe-duikboot:server:HasMoney', function(HasMoney)
            if HasMoney then
			    local coords2 = Config.Locations["vehiclespawn"].coords
                Framework.Functions.SpawnVehicle("Submersible2", function(veh)
                    Duikboot = veh
                    SetVehicleNumberPlateText(veh, "DUIK"..tostring(math.random(1000, 9999)))
                    SetEntityHeading(veh, coords2.h)
                    exports['pepe-fuel']:SetFuelLevel(veh, GetVehicleNumberPlateText(veh), 100, false)
                    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                    SetEntityAsMissionEntity(veh, true, true)
                    exports['pepe-vehiclekeys']:SetVehicleKey(GetVehicleNumberPlateText(veh), true)
                    SetVehicleEngineOn(veh, true, true)
                    heeftduikboot = true
				    Framework.Functions.TriggerCallback('pepe-duikboot:server:GetDivingConfig', function(Config, Area)
                        PEPEduikboot.Locations = Config
                        TriggerEvent('pepe-duikboot:client:SetDivingLocation', Area)
                    end)
                    Framework.Functions.Notify("Je hebt €1000,- borg betaald.")
                    Framework.Functions.Notify("Je bent begonnen met werken, locatie staat aangegeven op je GPS.")
                end, coords2, true)
            else
                Framework.Functions.Notify("Je hebt niet genoeg geld voor de borg. Borg kosten zijn €1000,-")
			end	
        end)
    end
end)


function Storeduikboot()
    local PlayerCoords = GetEntityCoords(PlayerPedId())
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local Area = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["vehiclespawn"].coords.x, Config.Locations["vehiclespawn"].coords.y, Config.Locations["vehiclespawn"].coords.z, true)
    if Area < 10.0 then
        return true
    end
end

RegisterNetEvent('pepe-duikboot:client:store')
AddEventHandler('pepe-duikboot:client:store', function(House)
    local PlayerCoords = GetEntityCoords(PlayerPedId())
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local Area = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["vehiclespawn"].coords.x, Config.Locations["vehiclespawn"].coords.y, Config.Locations["vehiclespawn"].coords.z, true)
    local InVehicle = IsPedInAnyVehicle(PlayerPedId(), false)
    if Area < 10.0 then
	    if InVehicle then
            Framework.Functions.TriggerCallback('pepe-duikboot:server:CheckBail', function(DidBail)
                if DidBail then
                    BringBackCar()
					Framework.Functions.TriggerCallback('pepe-duikboot:server:GetDivingConfig', function(Config, Area)
                        PEPEduikboot.Locations = Config
                        TriggerEvent('pepe-duikboot:client:removeLocation', Area)
                    end)
                    Framework.Functions.Notify("Je hebt €1000,- borg terug ontvangen.")
                else
                    Framework.Functions.Notify("Je hebt geen borg betaald over dit voertuig.")
			    end	
            end)
        end
    end
end)

---Onder water gedeelte---

local CurrentDivingLocation = {
    Area = 0,
    Blip = {
        Radius = nil,
        Label = nil
    }
}

RegisterNetEvent('pepe-duikboot:client:NewLocations')
AddEventHandler('pepe-duikboot:client:NewLocations', function()
    Framework.Functions.TriggerCallback('pepe-duikboot:server:GetDivingConfig', function(Config, Area)
        PEPEduikboot.Locations = Config
        TriggerEvent('pepe-duikboot:client:SetDivingLocation', Area)
    end)
end)

RegisterNetEvent('pepe-duikboot:client:removeLocation')
AddEventHandler('pepe-duikboot:client:removeLocation', function(DivingLocation)
    CurrentDivingLocation.Area = DivingLocation

    for _,Blip in pairs(CurrentDivingLocation.Blip) do
        if Blip ~= nil then
            RemoveBlip(Blip)
        end
    end
end)	


RegisterNetEvent('pepe-duikboot:client:SetDivingLocation')
AddEventHandler('pepe-duikboot:client:SetDivingLocation', function(DivingLocation)
    CurrentDivingLocation.Area = DivingLocation

    for _,Blip in pairs(CurrentDivingLocation.Blip) do
        if Blip ~= nil then
            RemoveBlip(Blip)
        end
    end
    
    Citizen.CreateThread(function()
        RadiusBlip = AddBlipForRadius(PEPEduikboot.Locations[CurrentDivingLocation.Area].coords.Area.x, PEPEduikboot.Locations[CurrentDivingLocation.Area].coords.Area.y, PEPEduikboot.Locations[CurrentDivingLocation.Area].coords.Area.z, 25.0)
        
        SetBlipRotation(RadiusBlip, 0)
        SetBlipColour(RadiusBlip, 4)

        CurrentDivingLocation.Blip.Radius = RadiusBlip

        LabelBlip = AddBlipForCoord(PEPEduikboot.Locations[CurrentDivingLocation.Area].coords.Area.x, PEPEduikboot.Locations[CurrentDivingLocation.Area].coords.Area.y, PEPEduikboot.Locations[CurrentDivingLocation.Area].coords.Area.z)

        SetBlipSprite (LabelBlip, 404)
        SetBlipDisplay(LabelBlip, 4)
        SetBlipScale  (LabelBlip, 0.7)
        SetBlipColour(LabelBlip, 0)
        SetBlipAsShortRange(LabelBlip, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Duikgebied')
        EndTextCommandSetBlipName(LabelBlip)

        CurrentDivingLocation.Blip.Label = LabelBlip
    end)
end)


DrawText3D = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end


Citizen.CreateThread(function()
    while true do
        local inRange = false
        local Ped = PlayerPedId()
        local Pos = GetEntityCoords(Ped)
        local sleep = 2000
        if CurrentDivingLocation.Area ~= 0 then
            local AreaDistance = GetDistanceBetweenCoords(Pos, PEPEduikboot.Locations[CurrentDivingLocation.Area].coords.Area.x, PEPEduikboot.Locations[CurrentDivingLocation.Area].coords.Area.y, PEPEduikboot.Locations[CurrentDivingLocation.Area].coords.Area.z)
            local CoralDistance = nil

            if AreaDistance < 100 then
                inRange = true
            end

            if inRange then
                sleep = 5
                for cur, CoralLocation in pairs(PEPEduikboot.Locations[CurrentDivingLocation.Area].coords.Vuiligheid) do
                    CoralDistance = GetDistanceBetweenCoords(Pos, CoralLocation.coords.x, CoralLocation.coords.y, CoralLocation.coords.z, true)

                    if CoralDistance ~= nil then
                        if CoralDistance <= 30 then
                            if not CoralLocation.PickedUp then
                                DrawMarker(32, CoralLocation.coords.x, CoralLocation.coords.y, CoralLocation.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 1.0, 0.9, 0, 204, 255, 255, true, false, false, false, false, false, false)
                                if CoralDistance <= 7.5 then
                                    DrawText3D(CoralLocation.coords.x, CoralLocation.coords.y, CoralLocation.coords.z, '[E] Koraal verzamelen')
                                    if IsControlJustPressed(0, Keys["E"]) then
                                        if (IsInVehicle()) then
										    local times = math.random(2, 5)
											TriggerEvent('pepe-sound:client:play', 'boortje', 0.8)
                                            FreezeEntityPosition(Ped, true)
                                            Framework.Functions.Progressbar("take_coral", "Koraal aan het verzamelen..", times * 400, false, true, {
                                                disableMovement = true,
                                                disableCarMovement = true,
                                                disableMouse = false,
                                                disableCombat = true,
                                            }, {
                                                animDict = "weapons@first_person@aim_rng@generic@projectile@thermal_charge@",
                                                anim = "plant_floor",
                                                flags = 16,
                                            }, {}, {}, function() -- Done
                                                TakeVuil(cur)
                                                ClearPedTasks(Ped)
                                                FreezeEntityPosition(Ped, false)
                                            end, function() -- Cancel
                                                ClearPedTasks(Ped)
                                                FreezeEntityPosition(Ped, false)
                                            end)
											Citizen.Wait(2000)
										else
                                            Framework.Functions.Notify('U zit niet in de duikboot..', 'error')
                                        end											
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        -- if not inRange then
        --     Citizen.Wait(2500)
        -- end

        Citizen.Wait(sleep)
    end
end)

function IsInVehicle()
    local ply = PlayerPedId()
    if IsPedSittingInAnyVehicle(ply) then
      return true
    else
      return false
    end
  end

function TakeVuil(vuil)
    PEPEduikboot.Locations[CurrentDivingLocation.Area].coords.Vuiligheid[vuil].PickedUp = true
    TriggerServerEvent('pepe-duikboot:server:TakeVuil', CurrentDivingLocation.Area, vuil, true)
end

RegisterNetEvent('pepe-duikboot:client:UpdateVuil')
AddEventHandler('pepe-duikboot:client:UpdateVuil', function(Area, Vuiligheid, Bool)
    PEPEduikboot.Locations[Area].coords.Vuiligheid[Vuiligheid].PickedUp = Bool
end)


Citizen.CreateThread(function()
	local blip = AddBlipForCoord(3807.85,4478.59, 6.36)
	SetBlipSprite(blip, 529)
	SetBlipScale(blip, 0.5)
	SetBlipColour(blip, 42)  
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Duikboot")
    EndTextCommandSetBlipName(blip)
end)