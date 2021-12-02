Framework = exports["pepe-core"]:GetCoreObject()

-- Code

local isLoggedIn = false
local PlayerData = {}

RegisterNetEvent('Framework:Client:OnPlayerLoaded')
AddEventHandler('Framework:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerData = Framework.Functions.GetPlayerData()
end)

RegisterNetEvent('Framework:Client:OnPlayerUnload')
AddEventHandler('Framework:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('Framework:Client:OnJobUpdate')
AddEventHandler('Framework:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)

function DrawText3Ds(xPos, yPos, zPos, Text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(Text)
    SetDrawOrigin(xPos, yPos, zPos, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(Text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local timeout = false

function RandomCars()
  return Config.cars[math.random(#Config.cars)]
end

function RandomPos(variable)
  return variable[math.random(1, #variable)]
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
			local coords = GetEntityCoords(PlayerPedId())
			local modelName = RandomCars()
			local sellpos = RandomPos(Config.sellveh)
			local model = (type(modelName) == 'number' and modelName or GetHashKey(modelName))
			local cooords = GetBlipInfoIdCoord(blip)
			if PlayerData.job ~= nil and (PlayerData.job.name == "cardealer") then
				if GetDistanceBetweenCoords(coords, Config.Startpoint.x, Config.Startpoint.y, Config.Startpoint.z, true) < Config.Startpoint.d and not timeout then
					DrawText3Ds(Config.Startpoint.x, Config.Startpoint.y, Config.Startpoint.z + 0.3, "~g~E~w~ - Start de verkoop missie")
					if IsControlJustPressed(1, 38) then
						blip = AddBlipForCoord(sellpos.x, sellpos.y, sellpos.z)
						SetBlipSprite(blip, 478)
						SetBlipRoute(blip,  true)
						SetBlipRouteColour(blip,  2)
						Citizen.CreateThread(function()
							RequestModel(model)

							while not HasModelLoaded(model) do
								Citizen.Wait(0)
							end

							local vehicle = CreateVehicle(model, Config.spawnveh.x, Config.spawnveh.y, Config.spawnveh.z, Config.spawnveh.h, true, false)
							local id      = NetworkGetNetworkIdFromEntity(vehicle)

							SetNetworkIdCanMigrate(id, true)
							SetEntityAsMissionEntity(vehicle, true, false)
							SetVehicleHasBeenOwnedByPlayer(vehicle, true)
							SetVehicleNeedsToBeHotwired(vehicle, false)
							SetModelAsNoLongerNeeded(model)
							TaskWarpPedIntoVehicle(PlayerPedId(),  vehicle, -1)
							TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))

							RequestCollisionAtCoord(Config.spawnveh.x, Config.spawnveh.y, Config.spawnveh.z)

							while not HasCollisionLoadedAroundEntity(vehicle) do
								RequestCollisionAtCoord(Config.spawnveh.x, Config.spawnveh.y, Config.spawnveh.z)
								Citizen.Wait(0)
							end

							SetVehRadioStation(vehicle, 'OFF')	
							Framework.Functions.Notify("Bezorg dit aan onze klant, en verpest de voertuig niet.", "success", 7000)
							timeout = true
							Wait(Config.Holdup * 60000)
							timeout = false
						end)
					end
				elseif GetDistanceBetweenCoords(coords, Config.Startpoint.x, Config.Startpoint.y, Config.Startpoint.z, true) < Config.Startpoint.d and timeout then
					DrawText3Ds(Config.Startpoint.x, Config.Startpoint.y, Config.Startpoint.z + 0.3, "Wachten op telefoontje van de klant.")
				elseif GetDistanceBetweenCoords(coords, cooords.x, cooords.y, cooords.z, true) < 1.8 and IsPedInAnyVehicle(PlayerPedId()) then
					DrawText3Ds(cooords.x, cooords.y, cooords.z + 0.3, "~g~E~w~ - Verkoop voertuig")
					if IsControlJustPressed(1, 38) then
						if (IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()), model)) then
						TriggerEvent('pepe-cardealer:job:sellveh')
						Wait(250)
						TriggerEvent('Framework:Command:DeleteVehicle', PlayerPedId())
						end
					end
				else
					Wait(850)
				end
			else
				Wait(2500)
			end
		end
end)


RegisterNetEvent('pepe-cardealer:job:sellveh')
AddEventHandler('pepe-cardealer:job:sellveh', function()
	local health = GetVehicleBodyHealth(GetVehiclePedIsUsing(PlayerPedId()), PlayerPedId())
	if health <= 2000 then
		local type = 'bestpay'
		Framework.Functions.Notify("Het voertuig ziet er geweldig uit, geniet van de betaling.", "success", 2500)
		TriggerServerEvent('pepe-cardealer:job:pay', type)
	elseif health <= 1600 then
		local type = 'womenpayxd'
		Framework.Functions.Notify("Bedankt voor het brengen van mijn auto, geniet van de betaling", "success", 2500)
		TriggerServerEvent('pepe-cardealer:job:pay', type)
	elseif health <= 1400 then
		local type = 'shitpay'
		Framework.Functions.Notify("Het voertuig ziet er een beetje kapot uit, hier is je betaling, de volgende keer niet verpesten.", "success", 2500)
		TriggerServerEvent('pepe-cardealer:job:pay', type)
	elseif health <= 800 then
		local type = 'Lpay'
	elseif health == 0 then
		Framework.Functions.Notify("Meen je dat het voertuig kapot is, geen betaling voor jou, klootzak.", "success", 2500)
		TriggerServerEvent('pepe-cardealer:job:pay', type)
	end
end)