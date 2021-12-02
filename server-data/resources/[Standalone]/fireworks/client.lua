local last_firework_trigger = -3000
Framework = exports["pepe-core"]:GetCoreObject()

RegisterNetEvent("mmfireworks:fireup", function()
	if CheckAntiSpam() then
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
		if Framework.Functions.IsSpawnPointClear(playerCoords, 2.0) then
			if GetInteriorFromEntity(playerPed) == 0 then
				TriggerServerEvent("mmfireworks:remove")
				-- Framework.Functions.Notify("Placing fireworks launcher...")
				PlayAnim(playerPed, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1, 10000)
				
				local forward   = GetEntityForwardVector(playerPed)
				local coords    = playerCoords + (forward * 0.9)
				local obj_ 		= nil
				SpawnObject(`ind_prop_firework_03`, coords, function(obj)
					obj_ = NetworkGetNetworkIdFromEntity(obj)
					SetEntityAsMissionEntity(obj, true, false)
					PlaceObjectOnGroundProperly(obj)
					FreezeEntityPosition(obj, true)
					SetEntityCollision(obj, false, false)     
				end)
				
				Citizen.Wait(15000)
				
				for i = 1, 15 do
					TriggerServerEvent("mmfireworks:particles:1", coords)
					Citizen.Wait(200)
				end

				math.randomseed(GetGameTimer())
				local x = 0.0
				local y = 0.0
				for i = 1, 8 do
					x = math.random(10, 150) / 10
					y = math.random(10, 150) / 10

					TriggerServerEvent("mmfireworks:particles:1", coords)
					ShootBullet(`WEAPON_FIREWORK`, 100.0, coords + vector3(0.0, 0.0, 1.0), coords + vector3(x, y, 100.0))

					Citizen.Wait(1500)
					
					for j = 1, 5 do
						x = math.random(10, 250) / 10
						y = math.random(10, 250) / 10
						TriggerServerEvent("mmfireworks:particles:2", coords + vector3(x, y, 20.0))
						Citizen.Wait(150)
					end
				end
				TriggerServerEvent("mmfireworks:delete", obj_)
			else
				Framework.Functions.Notify("Je kan dit niet afsteken binnenshuis")
			end
		else
			Framework.Functions.Notify("Pas op voor de autos!")
		end
	end
end)

RegisterNetEvent("mmfireworks:firework2", function()
	if CheckAntiSpam() then
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
		if Framework.Functions.IsSpawnPointClear(playerCoords, 2.0) then
			if GetInteriorFromEntity(playerPed) == 0 then
						fireup()
			else
				Framework.Functions.Notify("Je kan dit niet afsteken binnenshuis")
			end
		else
			Framework.Functions.Notify("Pas op voor de autos!")
		end
	end
end)

RegisterNetEvent("mmfireworks:firework", function()
	if CheckAntiSpam() then
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
		if Framework.Functions.IsSpawnPointClear(playerCoords, 2.0) then
			if GetInteriorFromEntity(playerPed) == 0 then
						fireup2()
			else
				Framework.Functions.Notify("Je kan dit niet afsteken binnenshuis")
			end
		else
			Framework.Functions.Notify("Pas op voor de autos!")
		end
	end
end)

RegisterNetEvent("mmfireworks:particles:1", function(coords)
	local dict = "scr_indep_fireworks"
	local particleName = "scr_indep_firework_shotburst"
	RequestNamedPtfxAsset(dict)
	while not HasNamedPtfxAssetLoaded(dict) do
		Citizen.Wait(0)
	end
	local x,y,z = table.unpack(coords)
	UseParticleFxAssetNextCall(dict)
	StartParticleFxNonLoopedAtCoord(particleName, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.2, false, false, false)
end)

RegisterNetEvent("mmfireworks:particles:2", function(coords)
	local dict = "scr_indep_fireworks"
	local particleName = "scr_indep_firework_starburst"
	RequestNamedPtfxAsset(dict)
	while not HasNamedPtfxAssetLoaded(dict) do
		Citizen.Wait(0)
	end
	local x,y,z = table.unpack(coords)
	UseParticleFxAssetNextCall(dict)
	StartParticleFxNonLoopedAtCoord(particleName, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.2, false, false, false)
end)

function fireup()
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	if Framework.Functions.IsSpawnPointClear(playerCoords, 2.0) then
		if GetInteriorFromEntity(playerPed) == 0 then
			TriggerServerEvent("mmfireworks:remove2")
			Framework.Functions.Notify("Placing firework...")
			PlayAnim(playerPed, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1, 10000)
			
			local forward   = GetEntityForwardVector(playerPed)
			local coords   = playerCoords + (forward * 0.9)
			local obj_ = nil
			SpawnObject(`ind_prop_firework_01`, coords, function(obj)
				obj_ = NetworkGetNetworkIdFromEntity(obj)
				SetEntityAsMissionEntity(obj, true, false)
				PlaceObjectOnGroundProperly(obj)
				local coords2 = GetEntityCoords(obj)
				FreezeEntityPosition(obj, true)
				SetEntityCollision(obj, false, false)
				SetEntityCoords(obj, coords2.x, coords2.y, coords2.z + 0.2)     
			end)
			
			Citizen.Wait(15000)
			
			for i = 1, 3 do
				TriggerServerEvent("mmfireworks:particles:1", coords-vector3(0.0, 0.0, 1.0))
				Citizen.Wait(200)
			end


			local x = 0.0
			local y = 0.0
			math.randomseed(GetGameTimer())
			x = math.random(10, 150) / 10
			y = math.random(10, 150) / 10
			TriggerServerEvent("mmfireworks:delete", obj_)
			TriggerServerEvent("mmfireworks:particles:1", coords)
			ShootBullet(`WEAPON_FIREWORK`, 100.0, coords + vector3(0.0, 0.0, 1.0), coords + vector3(x, y, 100.0))

			Citizen.Wait(2500)
				
			for j = 1, 10 do
				x = math.random(10, 250) / 10
				y = math.random(10, 250) / 10
				TriggerServerEvent("mmfireworks:particles:2", coords + vector3(x, y, 25.0))
				Citizen.Wait(200)
			end 
		else
			Framework.Functions.Notify("Je kan dit niet afsteken binnenshuis")
		end
	else
		Framework.Functions.Notify("Pas op voor de autos!")
	end
end

function fireup2()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	if Framework.Functions.IsSpawnPointClear(coords, 2.0) then
		if GetInteriorFromEntity(playerPed) == 0 then
			TriggerServerEvent("mmfireworks:remove2")
			local obj_ 	= nil
			local obj2_ = nil

			SetFollowPedCamViewMode(4)

			SpawnObject(`ind_prop_firework_01`, coords, function(obj)
				obj2_ = obj
				obj_ = NetworkGetNetworkIdFromEntity(obj)
				SetEntityAsMissionEntity(obj, true, false)
				SetEntityCollision(obj, false, false)
				AttachEntityToEntity(obj, playerPed, GetPedBoneIndex(playerPed, 57005), 0.205, 0.315, 0.17, -62.0, 41.0, 12.0, 1, 1, 0, 1, 1, 1)
			end)

			PlayAnim(playerPed, "amb@world_human_smoking@male@male_a@enter", "enter", 1, 2500)
			Citizen.Wait(2500)
			AttachEntityToEntity(obj2_, playerPed, GetPedBoneIndex(playerPed, 47495), 0.305, 0.005, 0.405, -1.0, 35.0, 10.0, 1, 1, 0, 1, 1, 1)
			PlayAnim(playerPed, "rcmbarry", "base", 1, -1)
			Citizen.Wait(3000)
			coords = GetEntityCoords(obj2_)
			TriggerServerEvent("mmfireworks:particles:1", coords-vector3(0.0, 0.0, 0.5))
			Citizen.Wait(250)
			local x = 0.0
			local y = 0.0
			math.randomseed(GetGameTimer())
			x = math.random(10, 150) / 10
			y = math.random(10, 150) / 10
			TriggerServerEvent("mmfireworks:delete", obj_)
			TriggerServerEvent("mmfireworks:particles:1", coords)
			ShootBullet(`WEAPON_FIREWORK`, 100.0, coords + vector3(0.0, 0.0, 0.5), coords + vector3(x, y, 100.0))
			DoScreenFadeOut(500)

			Citizen.CreateThread(function()
				Citizen.Wait(1500)
				DoScreenFadeIn(500)
				SetFollowPedCamViewMode(1)
				ClearPedTasks(playerPed)
			end)
		
			Citizen.Wait(2500)
				
			for j = 1, 10 do
				x = math.random(10, 250) / 10
				y = math.random(10, 250) / 10
				TriggerServerEvent("mmfireworks:particles:2", coords + vector3(x, y, 25.0))
				Citizen.Wait(200)
			end
		else
			Framework.Functions.Notify("Je kan dit niet afsteken binnenshuis")
		end
	else
		Framework.Functions.Notify("Pas op voor de autos!")
	end
end

function ShootBullet(model, speed, startPosition, targetPosition)
	RequestWeaponAsset(model, 31, 26)
	while not HasWeaponAssetLoaded(model) do
		Citizen.Wait(0)
	end
	ShootSingleBulletBetweenCoordsWithExtraParams(startPosition.x, startPosition.y, startPosition.z, targetPosition.x, targetPosition.y, targetPosition.z, 0, true, model, PlayerPedId(), true, true, speed, 0, false, false, false, true)
end

function SpawnObject(model, coords, cb)
	Citizen.CreateThread(function()
		RequestModel(model)

		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end

		local obj = CreateObject(model, coords.x, coords.y, coords.z, true, false, true)

		if cb ~= nil then
			cb(obj)
		end
	end)
end

function CheckAntiSpam()
	local timer = GetGameTimer()
	if timer - last_firework_trigger > 5000 then
		last_firework_trigger = timer
		return true
	end
	return false
end

function PlayAnim(ped, dict, name, flag, time)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(0)
	end
	TaskPlayAnim(ped, dict, name, 8.0, 8.0, time, flag, 1.0, false, false, false)	
end