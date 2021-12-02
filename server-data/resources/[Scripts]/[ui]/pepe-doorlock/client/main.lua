local DoorKey, DoorValue = nil, nil
local LoggedIn = false
local NearDoor = nil
local MaxDistance = 1.25

-- Framework = nil

Framework = exports["pepe-core"]:GetCoreObject()
RegisterNetEvent('Framework:Client:OnPlayerLoaded')
AddEventHandler('Framework:Client:OnPlayerLoaded', function()
 Citizen.SetTimeout(1000, function()
	--  TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)
	--  Citizen.Wait(250)
	 Framework.Functions.TriggerCallback("pepe-doorlock:server:get:config", function(config)
		Config = config
	end)
	Citizen.Wait(150)
	LoggedIn = true
 end)
end)

-- Code

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(4)
		if LoggedIn then
		     for key, Door in ipairs(Config.Doors) do
		     	if Door['Doors'] then
		     		for k,v in ipairs(Door['Doors']) do
		     			if not v.object or not DoesEntityExist(v.object) then
		     				v.object = GetClosestObjectOfType(v['ObjCoords'], 1.0, GetHashKey(v['ObjName']), false, false, false)
		     			end
		     		end
		     	else
		     		if not Door.object or not DoesEntityExist(Door.object) then
		     			Door.object = GetClosestObjectOfType(Door['ObjCoords'], 1.0, GetHashKey(Door['ObjName']), false, false, false)
		     		end
		     	end
		     end
		  Citizen.Wait(3500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(8)
		if LoggedIn then
		    local playerCoords = GetEntityCoords(PlayerPedId())
		    NearDoorDistance = true
		    NearDoor = true
		    for k, Door in ipairs(Config.Doors) do
		    	local distance
		    	if Door['Doors'] then
		    		distance = #(playerCoords - Door['Doors'][1]['ObjCoords'])
		    	else
		    		distance = #(playerCoords - Door['ObjCoords'])
		    	end
		    	if Door["Distance"] then
		    		MaxDistance = Door["Distance"]
		    	end
		    	if distance < 11.0 then
		    		NearDoorDistance = false
		    		if Door['Doors'] then
		    			for _,v in ipairs(Door['Doors']) do
		    				FreezeEntityPosition(v.object, Door['Locked'])
		    				if Door['Locked'] and v['ObjYaw'] and GetEntityRotation(v.object).z ~= v['ObjYaw'] then
		    					SetEntityRotation(v.object, 0.0, 0.0, v['ObjYaw'], 2, true)
		    				end
		    			end
		    		else
		    			FreezeEntityPosition(Door.object, Door['Locked'])
		    			if Door['Locked'] and Door['ObjYaw'] and GetEntityRotation(Door.object).z ~= Door['ObjYaw'] then
		    				SetEntityRotation(Door.object, 0.0, 0.0, Door['ObjYaw'], 2, true)
		    			end
		    		end
		    	end
		    	if distance < MaxDistance then
		    		NearDoor = false
		    		DoorKey, DoorValue = k, Door
					local isAuthorized = IsAuthorized(DoorValue)
		    		if Door['Locked'] then	
		    			if not Showing then
		    				Showing = true
							if isAuthorized then
		    					SendNUIMessage({
		    						action = "show",
		    						text = 'closed-auth',
		    					})
							else
								SendNUIMessage({
		    						action = "show",
		    						text = 'closed',
		    					})
							end
		    			end
		    		elseif not Door['Locked'] then
		    			if not Showing then
		    				Showing = true
							if isAuthorized then
		    				    SendNUIMessage({
		    				    	action = "show",
		    				    	text = 'open-auth',
		    				    })
							else
								SendNUIMessage({
		    				    	action = "show",
		    				    	text = 'open',
		    				    })
							end
		    			end
		    		end
					if IsControlJustReleased(0, 38) then
						if isAuthorized then
							SetDoorLock(DoorValue, DoorKey)
						end
					end
		    	end
		    end
		    if NearDoor then
		    	SendNUIMessage({
		    		action = "remove",
		    	})
		    	Showing = false
		    	Citizen.Wait(1500)
		    	DoorKey, DoorValue = nil, nil
		    end
		    if NearDoorDistance then
		    	Citizen.Wait(550)
			end
		end
	end
end)

-- Citizen.CreateThread(function()
-- 	local inZone = false
-- 	local locked = true
-- 	local hasAuth = false
-- 	local shown = false
-- 	local size, displayText = 1, 'Geopend'
-- 	local color

-- 	while true do
-- 		Citizen.Wait(0)
-- 		local letSleep = true
-- 		inZone = false
-- 		for k, Door in ipairs(Config.Doors) do
-- 			if v.distanceToPlayer and v.distanceToPlayer < 50 then
-- 				letSleep = false

-- 				if v.doors then
-- 					for k2,v2 in ipairs(v.doors) do
-- 						FreezeEntityPosition(v2.object, v.locked)
-- 					end
-- 				else
-- 					FreezeEntityPosition(v.object, v.locked)
-- 				end
-- 			end

-- 			if v.distanceToPlayer and v.distanceToPlayer < v.maxDistance then
-- 				inZone = true
				

-- 				if v.size then
-- 					size = v.size
-- 				end
-- 				if v.locked then
-- 					locked = true
-- 				else
-- 					locked = false
-- 				end
-- 				if v.isAuthorized then
-- 					hasAuth = true
-- 				elseif not v.isAuthorized then
-- 					hasAuth = false
-- 				end

-- 				if IsControlJustReleased(0, 38) then
-- 					if isAuthorized then
-- 						SetDoorLock(DoorValue, DoorKey)
-- 					shown = false
-- 					end
-- 				end
-- 			end
-- 		end

-- 		if inZone and not shown then
-- 			shown = true
-- 			if locked and hasAuth then
-- 				exports['vesx-ui']:open('[E] Gesloten', 'lightred', 'left')
-- 			elseif not locked and hasAuth then
-- 				exports['vesx-ui']:open('[E] Open', 'lightgreen', 'left')
-- 			elseif locked then
-- 				exports['vesx-ui']:open('Gesloten', 'lightred', 'left')
-- 			else
-- 				exports['vesx-ui']:open('Open', 'lightgreen', 'left')
-- 			end
-- 		elseif not inZone and shown then
-- 			exports['vesx-ui']:close()
-- 			shown = false
-- 		end

-- 		if letSleep then
-- 			Citizen.Wait(500)
-- 		end
-- 	end
-- end)

RegisterNetEvent('pepe-doorlock:client:change:door:looks')
AddEventHandler('pepe-doorlock:client:change:door:looks', function(Door, Type)
	if Type == 'NaarSmelt' then
	  CreateModelSwap(Door['ObjCoords'], 5, GetHashKey(Door['ObjName']), GetHashKey(Door['Molten-Model']), 1)
	else
	  CreateModelSwap(Door['ObjCoords'], 5, GetHashKey(Door['Molten-Model']), GetHashKey(Door['ObjName']), 1)
	end
end)

RegisterNetEvent('pepe-doorlock:server:reset:door:looks')
AddEventHandler('pepe-doorlock:server:reset:door:looks', function()
	for k, v in pairs(Config.Doors) do
		if v['Heavy-Door'] then
			CreateModelSwap(v['ObjCoords'], 5, GetHashKey(v['Molten-Model']), GetHashKey(v['ObjName']), 1)
		end
	end
end)
RegisterNetEvent('pepe-doorlock:client:setState')
AddEventHandler('pepe-doorlock:client:setState', function(Door, state)
	Config.Doors[Door]['Locked'] = state
	if not NearDoor then
	   if DoorKey == Door then
	   SendNUIMessage({
	   	action = "remove",
	   })
	   Citizen.Wait(500)
	   Showing = false
	  end
	end
end)

-- // Functions \\ --

function SetDoorLock(Door, key)
	--OpenDoorAnimation()
	TriggerServerEvent('pepe-sound:server:play:source', 'doorlock-keys', 0.4)
 	SetTimeout(1050, function()
   Door['Locked'] = not Door['Locked']
   TriggerServerEvent('pepe-doorlock:server:updateState', key, Door['Locked'])
 end)
end

function IsAuthorized(Door)
	local PlayerData = Framework.Functions.GetPlayerData()
	for _, job in pairs(Door['Autorized']) do
		if job == PlayerData.job.name then
			return true
		end
	end
	return false
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

function OpenDoorAnimation()
    ClearPedSecondaryTask(PlayerPedId())
    loadAnimDict( "anim@heists@keycard@" ) 
    TaskPlayAnim( PlayerPedId(), "anim@heists@keycard@", "exit", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
    Citizen.Wait(850)
    ClearPedTasks(PlayerPedId())
end

function ChangeDoorLooks(Door, Type)
	TriggerServerEvent('pepe-doorlock:server:change:door:looks', Door, Type)
end