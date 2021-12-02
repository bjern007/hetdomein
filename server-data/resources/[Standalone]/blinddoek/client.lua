Framework = nil

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(10)
        if Framework == nil then
            TriggerEvent("Framework:GetObject", function(obj) Framework = obj end)    
            Citizen.Wait(200)
        end
    end
end)

RegisterNetEvent('pepe-blinddoekclient:omdoen')
AddEventHandler('pepe-blinddoekclient:omdoen', function()

	LoadAnimationDictionary("mp_masks@on_foot")

	while not HasAnimDictLoaded('mp_masks@on_foot') do
		Citizen.Wait(100)
	end

	TaskPlayAnim(PlayerPedId(), "mp_masks@on_foot", "put_on_mask", 8.0, -8, -1, 48, 0, 0, 0, 0)
	Citizen.Wait(1000)
	ClearPedTasks(PlayerPedId())
		SendNUIMessage({
			action = "open"
		})
		SetNuiFocus(false,false)
end)


function GetClosestPlayer()
    local closestPlayers = Framework.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())

    for i=1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
	end

	return closestPlayer, closestDistance
end

RegisterNetEvent('pepe-blinddoekclient:afdoen')
AddEventHandler('pepe-blinddoekclient:afdoen', function()
	--[[
	TriggerEvent('skinchanger:getSkin', function(skin)
			local clothesSkin = {
				['mask_1'] = 0, ['mask_2'] = 0
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)]]--

	SendNUIMessage({
		action = "close"
		
	})

	SetNuiFocus(false,false)
	LoadAnimationDictionary("misscommon@std_take_off_masks")

	
	TaskPlayAnim(PlayerPedId(), "misscommon@std_take_off_masks", "take_off_mask_ps", 8.0, -8, -1, 48, 0, 0, 0, 0)
	Citizen.Wait(1000)
	ClearPedTasks(PlayerPedId())

end)

RegisterNetEvent('pepe-blinddoekclient:afdoenanderespeler')
AddEventHandler('pepe-blinddoekclient:afdoenanderespeler', function()
	local player, distance = GetClosestPlayer()  

	if distance ~= -1 and distance <= 3.0 then
		--Framework.Functions.TriggerCallback('pepe-blinddoekserver:afdoen',GetPlayerServerId(player) function() end)
		TriggerServerEvent('pepe-blinddoekserver:afdoen',GetPlayerServerId(player))
    else
	Framework.Functions.Notify("Geen Speler in de buurt.", "error")
	end

end)


RegisterNetEvent('pepe-blinddoekclient:afdoeneigen')
AddEventHandler('pepe-blinddoekclient:afdoeneigen', function()
	--local player, distance = GetClosestPlayer()  

	--if distance ~= -1 and distance <= 3.0 then
		TriggerServerEvent('pepe-blinddoekserver:afdoen', GetPlayerServerId(-1))
    --else
	--end

end)

RegisterNetEvent('pepe-blinddoekclient:omdoenanderespeler')
AddEventHandler('pepe-blinddoekclient:omdoenanderespeler', function()
	local player, distance = GetClosestPlayer()  
	if distance ~= -1 and distance <= 3.0 then
		TriggerServerEvent('pepe-blinddoekserver:omdoen', GetPlayerServerId(player))
    else
	Framework.Functions.Notify("Geen Speler in de buurt.", "error")

	end
end)

function LoadAnimationDictionary(animationD) -- Simple way to load animation dictionaries to save lines.
    while(not HasAnimDictLoaded(animationD)) do
        RequestAnimDict(animationD)
        Citizen.Wait(1)
    end
end