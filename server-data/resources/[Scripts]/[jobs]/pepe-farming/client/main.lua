-- SCRIPT DEVELOPED BY OSMIUM | OSMFX | DISCORD.IO/OSMFX --

Framework = nil
isLoggedIn = false

local menuOpen = false
local wasOpen = false

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(10)
        if Framework == nil then
            TriggerEvent("Framework:GetObject", function(obj) Framework = obj end)    
            Citizen.Wait(200)
        end
    end
end)

local spawnedCorns = 0
local cornPlants = {}
local isPickingUp, isProcessing = false, false

local f = false
local b = 0
local water = false

local rented = false
local track = false
local trackspots = {}
local oranges = nil 
local cowmilking = false
local cowobjects = {}

local hasbox = false

local rentveh = nil 

Citizen.CreateThread(function()
	for _, info in pairs(Config.Blips) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, info.id)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 0.8)
		SetBlipColour(info.blip, info.colour)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(info.title)
		EndTextCommandSetBlipName(info.blip)
	end
end) 

local sleep = 1000

Citizen.CreateThread(
    function()
		local sleep = 1300
        while true do
			if not f then
				local h = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.CircleZones.FarmCoords.coords, true)
				if h < 100 and not track then
                    CreateTrackSpots()
                    track = true
                end
				local cowdis = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.CircleZones.CowFarm.coords, true)
				if cowdis < 100 and not cowmilking then
                    CreateCows()
                    cowmilking = true
                end
				if not cowmilking or not track and not oranges then 
					for i = 1, #Config.OrangeFarm do		
						local orangedis = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.OrangeFarm[i], true)
						if orangedis < 5 then 
							sleep = 5
							Draw3DText(Config.OrangeFarm[i].x, Config.OrangeFarm[i].y, Config.OrangeFarm[i].z, '[E] - Pluk Sinasappels', 4, 0.08, 0.08, Config.SecondaryColor)
							
							if orangedis < 2 then 
								if IsControlJustReleased(0, 38) and not oranges then
									oranges = true
									PickOrange()
								elseif IsControlJustReleased(0, 38) and oranges then
									Framework.Functions.Notify('Wacht een aantal seconden voor je weer gaat plukken!')
								end
							end
						end
					end	
				end
            else
                Citizen.Wait(500)
            end
			
			Citizen.Wait(sleep)
        end
    end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.CircleZones.CornProcessing.coords, true) < 3 then
			DrawMarker(27, Config.CircleZones.CornProcessing.coords.x, Config.CircleZones.CornProcessing.coords.y, Config.CircleZones.CornProcessing.coords.z - 1 , 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 200, 0, 0, 0, 0)

			if not isProcessing then
				Draw3DText(Config.CircleZones.CornProcessing.coords.x, Config.CircleZones.CornProcessing.coords.y, Config.CircleZones.CornProcessing.coords.z, '[E] - Verwerk Mais', 4, 0.08, 0.08, Config.SecondaryColor)
			end

			if IsControlJustReleased(0, 38) and not isProcessing then
				TriggerServerEvent('pepe-farming:ProcessCorn')
			end

		elseif GetDistanceBetweenCoords(coords, Config.CircleZones.Boxes.coords, true) < 3 then
			local nowcoords = Config.CircleZones.Boxes.coords
			DrawMarker(27, nowcoords.x, nowcoords.y, nowcoords.z - 1 , 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 200, 0, 0, 0, 0)

			if not isProcessing then
				Draw3DText(nowcoords.x, nowcoords.y,nowcoords.z, '[E] - Pak een Doos', 4, 0.08, 0.08, Config.SecondaryColor)
			end
			if IsControlJustReleased(0, 38) and not isProcessing then
				Framework.Functions.TriggerCallback('Framework:HasItem', function(result)
					if result then
						Framework.Functions.Notify('Je hebt al een doos')
					else 
						TriggerServerEvent('pepe-farming:GivePlayerBox')
					end
				end, 'box')
			end

		elseif GetDistanceBetweenCoords(coords, Config.CircleZones.OrangePack.coords, true) < 3 then
			local nowcoords = Config.CircleZones.OrangePack.coords
			DrawMarker(27, nowcoords.x, nowcoords.y, nowcoords.z - 1 , 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 200, 0, 0, 0, 0)

			if not isProcessing then
				Draw3DText(nowcoords.x, nowcoords.y,nowcoords.z, '[E] - Pack Oranges', 4, 0.08, 0.08, Config.SecondaryColor)
			end
			if IsControlJustReleased(0, 38) and not isProcessing then
				-- Framework.Functions.TriggerCallback('Framework:HasItem', function(result)
				-- 	if result and hasbox then
				-- 		TriggerServerEvent('pepe-farming:ProcessOranges')
				-- 	else
				-- 		Framework.Functions.Notify('You need a Box and Oranges to Proceed!')
				-- 	end
				-- end, 'orange')
				TriggerServerEvent('pepe-farming:ProcessOranges')
			end
		elseif GetDistanceBetweenCoords(coords, Config.CircleZones.MilkPack.coords, true) < 3 then
			local nowcoords = Config.CircleZones.MilkPack.coords
			DrawMarker(27, nowcoords.x, nowcoords.y, nowcoords.z - 1 , 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 200, 0, 0, 0, 0)

			if not isProcessing then
				Draw3DText(nowcoords.x, nowcoords.y,nowcoords.z, '[E] - Bereid Melk', 4, 0.08, 0.08, Config.SecondaryColor)
			end
			if IsControlJustReleased(0, 38) and not isProcessing then
				-- Framework.Functions.TriggerCallback('Framework:HasItem', function(result)
				-- 	if result then 
				-- 		hasbox = true
				-- 	else 
				-- 		Framework.Functions.Notify('You need a Box to Proceed!')
				-- 	end
				-- end, 'box')
				-- Citizen.Wait(100)
				-- Framework.Functions.TriggerCallback('Framework:HasItem', function(result)
				-- 	if result and hasbox then
				-- 		TriggerServerEvent('pepe-farming:ProcessMilk')
				-- 	else
				-- 		Framework.Functions.Notify('You need a Box and Milk to Proceed!')
				-- 	end
				-- end, 'milk')
				TriggerServerEvent('pepe-farming:ProcessMilk')
			end

		elseif GetDistanceBetweenCoords(coords, Config.TractorCoords, true) < 3 then
			if not rented then
				Draw3DText(Config.TractorCoords.x, Config.TractorCoords.y, Config.TractorCoords.z, '[E] - Huur Trekker', 4, 0.08, 0.08, Config.SecondaryColor)
			end
			if rented then 
				Draw3DText(Config.TractorCoords.x, Config.TractorCoords.y, Config.TractorCoords.z, '[E] - Parkeer Trekker', 4, 0.08, 0.08, Config.SecondaryColor)
			end

			if IsControlJustReleased(0, 38) and not rented then
				Framework.Functions.Notify('TREKKER! Succes met je baan!', 'success', 5000) -- [text] = message, [type] = primary | error | success, [length] = time till fadeout.
				TriggerServerEvent('pepe-farming:server:SpawnTractor')
			end
			if IsControlJustReleased(0, 38) and rented then
				Framework.Functions.Notify('Je hebt de trekker terug gebracht', 'success', 5000) -- [text] = message, [type] = primary | error | success, [length] = time till fadeout.
				TriggerServerEvent('Server:UnRentTractor')
			end
		else
			Citizen.Wait(500)
		end
	end
end)

local sellItemsSet = false
local sellPrice = 0
local sellHardwareItemsSet = false
local sellHardwarePrice = 0

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local inRange = false
		local pos = GetEntityCoords(GetPlayerPed(-1))
		if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.SellLocation.x, Config.SellLocation.y, Config.SellLocation.z, true) < 5.0 then
			inRange = true
			if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.SellLocation.x, Config.SellLocation.y, Config.SellLocation.z, true) < 1.5 then
					if not sellItemsSet then 
						sellPrice = GetSellingPrice()
						sellItemsSet = true
					elseif sellItemsSet and sellPrice ~= 0 then
						DrawText3D(Config.SellLocation.x, Config.SellLocation.y, Config.SellLocation.z, "~g~E~w~ -Verkoop Items ($"..sellPrice..")")
						if IsControlJustReleased(0, 38) then
							TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
                            Framework.Functions.Progressbar("sell_pawn_items", "Selling stuff ..", math.random(15000, 25000), false, true, {}, {}, {}, {}, function() -- Done
                                ClearPedTasks(GetPlayerPed(-1))
								TriggerServerEvent("pepe-farming:server:SellFarmingItems")
								sellItemsSet = false
								sellPrice = 0
                            end, function() -- Cancel
								ClearPedTasks(GetPlayerPed(-1))
								Framework.Functions.Notify("Geannuleerd..", "error")
							end)
						end
					else
						DrawText3D(Config.SellLocation.x, Config.SellLocation.y, Config.SellLocation.z, "Je hebt niks bij je van de boerderij om te verkopen")
					end
			end
		end
		if not inRange then
			sellPrice = 0
			sellItemsSet = false
			Citizen.Wait(2500)
		end
	end
end)

RegisterNetEvent('SpawnTractor')
AddEventHandler('SpawnTractor', function()
	SetNewWaypoint(Config.TractorSpawn.x, Config.TractorSpawn.y)
		Framework.Functions.SpawnVehicle(Config.Tractor, function(veh)
			-- TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
			exports['pepe-fuel']:SetFuelLevel(veh, GetVehicleNumberPlateText(veh), 100.0, false)
			SetVehicleNumberPlateText(veh, 'FARMVEH')
			SetEntityHeading(veh, Config.TractorSpawnHeading)
			SetEntityAsMissionEntity(veh, true, true)
			exports['pepe-vehiclekeys']:SetVehicleKey(GetVehicleNumberPlateText(veh), true)
			TriggerServerEvent("vehicletuning:server:SaveVehicleProps", Framework.Functions.GetVehicleProperties(veh))
			-- TriggerServerEvent("pepe-carrentals:server:sql", num, plate, veh)
			SetEntityAsMissionEntity(veh, true, true)
			rentveh = veh
			rented = true
		end, Config.TractorSpawn, false)
	-- end
end)

RegisterNetEvent('UnRentTractor')
AddEventHandler('UnRentTractor', function()
	DeleteEntity(rentveh)
	rented = false
end)

function GetSellingPrice()
	local price = 0
	Framework.Functions.TriggerCallback('pepe-farming:server:GetSellingPrice', function(result)
		price = result
	end)
	Citizen.Wait(500)
	return price
end

function ProcessCorn()
	isProcessing = true
	local playerPed = PlayerPedId()

	
	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	-- exports['progressBars']:startUI(15000, "Processing..")

	Framework.Functions.Progressbar("search_register", "Processing..", 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done
		TriggerServerEvent('pepe-farming:ProcessCorn')
		local timeLeft = Config.Delays.CornProcessing / 1000

		while timeLeft > 0 do
			Citizen.Wait(1000)
			timeLeft = timeLeft - 1

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.CornProcessing.coords, false) > 4 then
				TriggerServerEvent('pepe-farming:cancelProcessing')
				break
			end
		end
		ClearPedTasks(PlayerPedId())
	end, function()
		ClearPedTasks(PlayerPedId())
	end) -- Cancel
		
	
	isProcessing = false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)

		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID
		local nearbySpot, spotID

		for i=1, #cornPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(cornPlants[i]), false) < 1 then
				nearbyObject, nearbyID = cornPlants[i], i
			end
		end
		for i=1, #trackspots, 1 do 
			if GetDistanceBetweenCoords(coords, GetEntityCoords(trackspots[i]), false) < 3 then
				nearbySpot, spotID = trackspots[i], i
			end
		end
		local playerVehicle = GetVehiclePedIsIn(playerPed, false)

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				-- DrawText2D(0.4, 0.8, '~w~Press ~g~[E]~w~ to Pickup Corn')
				local coord1 = GetEntityCoords(nearbyObject)
				Draw3DText(coord1.x, coord1.y, coord1.z + 1.5, '[E] - Pak Mais', 4, 0.08, 0.08, Config.SecondaryColor)
			end

			if IsControlJustReleased(0, 38) and not isPickingUp then
				isPickingUp = true
				TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)

				-- Framework.Functions.Notify("Picking up Corn Kernel!", "error", 10000)
				-- exports['progressBars']:startUI(5000, "Picking up Corn Kernel!")
				Framework.Functions.Progressbar("search_register", "Picking up Corn Kernel!", 5000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {}, {}, {}, function() -- Done
					ClearPedTasks(PlayerPedId())
					DeleteObject(nearbyObject)

					table.remove(cornPlants, nearbyID)
					spawnedCorns = spawnedCorns - 1

					if #cornPlants == 0 then 
						track = false
					end
	
					TriggerServerEvent('pepe-farming:pickedUpCannabis')

				end, function()
					ClearPedTasks(PlayerPedId())
				end) -- Cancel

				isPickingUp = false
			end

		elseif nearbySpot and GetEntityModel(playerVehicle) == `tractor3` then

			if not isPickingUp then
				local coord = GetEntityCoords(trackspots[spotID])
				Draw3DText(coord.x, coord.y, coord.z + 1.5, '[E] - Maai het veld', 4, 0.2, 0.2, Config.SecondaryColor)
			end

			if IsControlJustReleased(0, 38) then					
					ClearPedTasks(PlayerPedId())
					DeleteObject(nearbySpot)
					table.remove(trackspots, spotID)

					if #trackspots == 0 then 
						water = true
						Framework.Functions.Notify('Veld is gemaaid start met water sprayen', 'success', 6000)
						Citizen.Wait(100) -- For Variable Defining Delay
						WaterStart()
					end
					-- spawnedCorns = spawnedCorns - 1
			end
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)

		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbycow, cowid

		for i=1, #cowobjects, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(cowobjects[i]), false) < 2 then
				nearbycow, cowid = cowobjects[i], i
			end
		end

		if nearbycow and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				local coord1 = GetEntityCoords(nearbycow)
				Draw3DText(coord1.x, coord1.y, coord1.z + 1.5, '[E] - Melk de koe', 4, 0.07, 0.07, Config.SecondaryColor)
			end

			if IsControlJustReleased(0, 38) and not isPickingUp then
				if math.random(1,10) > 4 then 
					FreezeEntityPosition(nearbycow, true)
					TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
					MilkCow(nearbycow)
				else
					Framework.Functions.Notify('Heloas geen melk kunnen bemachtigen van de koe')
				end
			end
		else
			Citizen.Wait(500)
		end

	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		if #cowobjects ~= nil or #cowobjects ~= 0 then
			for k, v in pairs(cowobjects) do
				TaskPedSlideToCoord(v, 2540.9519042969,4788.830078125,33.564464569092, 50, 10)
			end
			Citizen.Wait(60000)
			for k, v in pairs(cowobjects) do
				TaskPedSlideToCoord(v, 2463.6857910156,4734.30078125,34.303768157959, 50, 10)
			end
			Citizen.Wait(60000)
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(cornPlants) do
			DeleteObject(v)
		end
		for k, v in pairs(trackspots) do
			DeleteObject(v)
		end
		for k, v in pairs(cowobjects) do
			DeleteObject(v)
		end
	end
end)

function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY,color)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(color.r, color.g, color.b, color.a)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

local UI = {
    x =  0.000 ,	-- Base Screen Coords 	+ 	 x
    y = -0.001 ,	-- Base Screen Coords 	+ 	-y
}

local prog = 0 

function MilkCow(nearbycow)
	TriggerEvent('pepe-farming:internal:CowProgress')
	isPickingUp = true	
	while true do 
		Citizen.Wait(5)
		if prog > 0 and prog < 101 then
			drawTxt(UI.x + 0.9605, UI.y + 0.962, 1.0,0.98,0.4, "~y~[~w~".. prog .. "%~y~]", 255, 255, 255, 255)
		end
		if prog == 100 then 
			TriggerServerEvent('pepe-farming:CowMilked')
			isPickingUp = false
			ClearPedTasks(PlayerPedId())
			FreezeEntityPosition(nearbycow, false)
			break
		end
	end
end

RegisterNetEvent('pepe-farming:internal:CowProgress')
AddEventHandler('pepe-farming:internal:CowProgress', function()
	-- print(prog)
	while prog < 101 do 
		-- print(prog)
		prog = prog + 1
		Citizen.Wait(100)
		if prog == 101 then 
			prog = 0
			break
		end
	end
end)

function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function SpawnCornPlants()
	math.randomseed(GetGameTimer())
    local random = math.random(30, 40)
	local hash = GetHashKey(Config.CornPlant)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(1)
    end
    while b < random do
		Citizen.Wait(1)
		local D = GenerateWeedCoords(Config.CircleZones.FarmCoords.coords)
		-- print(D)

        local E = CreateObject(hash, D.x, D.y, D.z, false, false, true)
        PlaceObjectOnGroundProperly(E)
        FreezeEntityPosition(E, true)
        table.insert(cornPlants, E)
        b = b + 1
    end
end

function PickOrange()
	local ad = "amb@prop_human_movie_bulb@base"
	local anim = "base"
	local player = PlayerPedId()

	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 8 ) ) then
			TaskPlayAnim( player, ad, "exit", 8.0, 8.0, 1.0, 1, 1, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			Citizen.Wait(50)
			TaskPlayAnim( player, ad, anim, 8.0, 8.0, 1.0, 1, 1, 0, 0, 0 )
		end
    end

	Framework.Functions.Progressbar("search_register", "Picking Up oranges!", 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done
		TriggerServerEvent('pepe-farming:GiveOranges')
		ClearPedTasks(PlayerPedId())
		Citizen.Wait(5000)
		oranges = false
	end, function()
		ClearPedTasks(PlayerPedId())
	end) 
end

function WaterStart()
	while true do 
		Citizen.Wait(5)
		local h = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.CircleZones.Water.coords, true)
		if water then 
			if h < 5 then
					Draw3DText(Config.CircleZones.Water.coords.x, Config.CircleZones.Water.coords.y, Config.CircleZones.Water.coords.z, '[E] - Start Water Supply', 4, 0.08, 0.08, Config.SecondaryColor)
				if IsControlJustReleased(0, 38) then
					TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
					Framework.Functions.Progressbar("search_register", "Starten met water sproeien over het veld", 15000, false, true, {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					}, {}, {}, {}, function() -- Done
						SpawnCornPlants()
						Framework.Functions.Notify('Plante zouden nu weer gezond moeten groeien!', 'success', 6000)
						water = false
					end, function()
						ClearPedTasks(PlayerPedId())
					end) -- Cancel
				end
			else
				Citizen.Wait(500)
			end
		else 
			break
		end
	end
end

local c = 0
function CreateTrackSpots()

	math.randomseed(GetGameTimer())
    local random = math.random(5, 10)
	local hash = GetHashKey(Config.MowProp)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(1)
    end
    while c < random do
		Citizen.Wait(1)
		local DE = GenerateWeedCoords(Config.CircleZones.FarmCoords.coords)
        local EE = CreateObject(hash, DE.x, DE.y, DE.z, false, false, true)
        PlaceObjectOnGroundProperly(EE)
        FreezeEntityPosition(EE, true)
        table.insert(trackspots, EE)
        c = c + 1
    end
end

local cd = 0

function CreateCows()

	math.randomseed(GetGameTimer())
    local random = math.random(5, 10)
	local hash2 = GetHashKey(Config.CowProp)
    RequestModel(hash2)
    while not HasModelLoaded(hash2) do
        Citizen.Wait(1)
    end
    while cd < random do
		Citizen.Wait(1)
		local DEF = GenerateWeedCoords(Config.CircleZones.CowFarm.coords)
		-- print(DEF)
		-- local EEF = CreateObject(hash2, DEF.x, DEF.y, DEF.z + 3, false, false, true)
		local EEF =  CreatePed(4, hash2, DEF.x, DEF.y, DEF.z, -149.404, false, true)
		SetEntityInvincible(EEF, true)
        PlaceObjectOnGroundProperly(EEF)
		-- TaskReactAndFleePed(EEF, PlayerPedId())
		Citizen.Wait(1000)
        table.insert(cowobjects, EEF)
		-- print(cd)
        cd = cd + 1
    end
end

function ValidateWeedCoord(plantCoord)
	if spawnedCorns > 0 then
		local validate = true

		for k, v in pairs(cornPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.FarmCoords.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateWeedCoords(data)
	while true do
		Citizen.Wait(1)

		local cornCoordX, cornCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-30,30)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-30, 30)

		cornCoordX = data.x + modX
		cornCoordY = data.y + modY

		local coordZ = GetCoordZ(cornCoordX, cornCoordY)
		local coord = vector3(cornCoordX, cornCoordY, coordZ)

		if ValidateWeedCoord(coord) then
			-- print('cord', coord)
			return coord
		end
	end
end

function GetCoordZ(x, y)
    --local groundCheckHeights = { 31.0, 32.0, 33.0, 34.0, 35.0, 36.0, 37.0, 38.0, 39.0, 40.0, 50.0 }
	local groundCheckHeights = { 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0 }
    for i, height in ipairs(groundCheckHeights) do
        local foundGround, z = GetGroundZFor_3dCoord(x, y, 900.0, 1)
		-- print('za', z)
        if foundGround then
			-- print('z', z)
            return z
        end
    end

    return 31.0
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
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
