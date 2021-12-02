local PlayerData = nil

Framework = exports["pepe-core"]:GetCoreObject()
Citizen.CreateThread(function()
	while Framework == nil do
		-- TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)
		Citizen.Wait(200)
	end

	while Framework.Functions.GetPlayerData() == nil do
		Wait(0)
	end

	while Framework.Functions.GetPlayerData().job == nil do
		Wait(0)
	end

	PlayerData = Framework.Functions.GetPlayerData()
end)

RegisterNetEvent("Framework:Client:OnJobUpdate")
AddEventHandler("Framework:Client:OnJobUpdate", function(JobInfo)
	PlayerData.job = JobInfo
end)

CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
        local plyCoords = GetEntityCoords(plyPed)
        local letSleep = true
        
        if PlayerData and PlayerData.job.name == 'lawyer' then
            local vehicles = Config.Locations['vehicles']
            local boss = Config.Locations['boss']

            if (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, vehicles.x, vehicles.y, vehicles.z, true) < 20) then
                letSleep = false
                DrawMarker(2, vehicles.x, vehicles.y, vehicles.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                 if (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, vehicles.x, vehicles.y, vehicles.z, true) < 1.5) then
                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                        DrawText3D(vehicles.x, vehicles.y, vehicles.z, "~g~E~w~ - Parkeer voertuig")
                    else
                        DrawText3D(vehicles.x, vehicles.y, vehicles.z, "~g~E~w~ - Pak voertuig")
                    end
                    if IsControlJustReleased(0, 38) then
                        if IsPedInAnyVehicle(PlayerPedId(), false) then
                            Framework.Functions.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                        else
                            MenuGarage()
                            Menu.hidden = not Menu.hidden
                        end
                    end
                    Menu.renderGUI()
                end  
            end
        end

        if letSleep then
            Wait(2000)
        end

        Wait(1)
    end
end)

function MenuGarage()
    local ped = PlayerPedId();
    MenuTitle = "Garage"
    ClearMenu()
    Menu.addButton("Vehicles", "VehicleList", nil)
    Menu.addButton("Close Menu", "CloseMenu", nil) 
end

function VehicleList(isDown)
    MenuTitle = "Vehicles:"
    ClearMenu()

    for k, v in pairs(Config.Vehicles) do
        Menu.addButton(Config.Vehicles[k], "SpawnVehicle", k, "Garage", " Motor: 100%", " Body: 100%", " Fuel: 100%")
    end
        
    Menu.addButton("Back", "MenuGarage",nil)
end

function SpawnVehicle(model)
    if not IsModelValid(model) then
        Framework.Functions.Notify("Invaild Vehicle Model", "error")
    end

    Framework.Functions.SpawnVehicle(model, function(veh)
        SetVehicleNumberPlateText(veh, "Law-"..tostring(math.random(1, 100)))
        SetEntityHeading(veh, Config.Locations['vehicles'].h)
        CloseMenu()
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh), veh)
        SetVehicleEngineOn(veh, true, true)
    end, Config.Locations['vehicles'], true)
end

function CloseMenu()
    Menu.hidden = true
    ClearMenu()
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
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end