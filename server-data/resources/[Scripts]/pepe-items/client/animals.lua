-- Framework = nil

-- Citizen.CreateThread(function()
--     while Framework == nil do
--         TriggerEvent('Framework:GetObject', function(obj) 
--             Framework = obj 
--         end)
--         Citizen.Wait(200)
--     end
-- end)

-- code
isLoggedIn = false
animalSpawned = false
companion = nil
spawnDistanceRadius = 1.0

local k9_name = "K9 Dog"
local spawned_ped = nil
local following = false
local attacking = false
local attacked_player = 0
local searching = false
local playing_animation = false

RegisterNetEvent("Framework:Client:OnPlayerLoaded")
AddEventHandler("Framework:Client:OnPlayerLoaded", function()
	animalSpawned = false
    companion = nil
end)

AddEventHandler('onClientResourceStart', function ()
	animalSpawned = false
    companion = nil
end)

RegisterNetEvent('pepe-animals:client:ToggleCompanion')
AddEventHandler('pepe-animals:client:ToggleCompanion', function(model)
    if companion == nil or #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(companion)) < 2.0 then
        TaskStartScenarioInPlace(PlayerPedId(), "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 0, true)
        local progressBarMessage = "Huis aan het oppakken"
        if not animalSpawned then
            progressBarMessage = "Huisdier neerzetten"
        end
        Framework.Functions.Progressbar("toggle_companion", progressBarMessage, 2000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            if not animalSpawned then
                -- spawn animal
                spawnAnimal(model)
                animalSpawned = true
            else
                --delete animal
                deleteAnimal()
                animalSpawned = false
            end
            ClearPedTasks(PlayerPedId())
        end, function() -- Cancel
            ClearPedTasks(PlayerPedId())
        end)
    else
        Framework.Functions.Notify("Huisdier is te ver ga dichterbij staan.", "error")
    end
end)    

function spawnAnimal(modelName)
    print("spawn companion")
    local hash = GetHashKey(modelName)

    local coords = GetEntityCoords(PlayerPedId())
    local spawnX = math.random(-spawnDistanceRadius,spawnDistanceRadius)
	local spawnY = math.random(-spawnDistanceRadius,spawnDistanceRadius)
	local spawnLoc = vector3(coords.x + spawnX, coords.y + spawnY, coords.z -1.0)
    
	RequestModel(modelName)
	while not HasModelLoaded(modelName) do
		Citizen.Wait(10)				
	end

	companion = CreatePed(28, hash, spawnLoc, true, true, true)
    SetModelAsNoLongerNeeded(modelName)
    Citizen.CreateThread(function()
        while companion ~= nil do
            Citizen.Wait(3)
            if IsControlJustPressed(0,38) then
                TaskGoToEntity(companion, PlayerPedId(), -1, 1.0, 10.0, 1073741824.0, 0)
                SetPedKeepTask(companion, true)
            end
        end
    end)
end


-- Toggles K9 In and Out of Vehicles
RegisterNetEvent("K9:ToggleVehicle")
AddEventHandler("K9:ToggleVehicle", function(isRestricted, vehList)
    if not searching then
        if IsPedInAnyVehicle(companion, false) then
            SetEntityInvincible(companion, true)
            SetPedCanRagdoll(companion, false)
            TaskLeaveVehicle(companion, GetVehiclePedIsIn(companion, false), 256)
            QBCore.Functions.Notify(k9_name .. " " .. language.exit, "error", 5000)
            Wait(2000)
            SetPedCanRagdoll(companion, true)
            SetEntityInvincible(companion, false)
        else
            if not IsPedInAnyVehicle(GetLocalPed(), false) then
                local plyCoords = GetEntityCoords(GetLocalPed(), false)
                local vehicle = GetVehicleAheadOfPlayer()
                local door = GetClosestVehicleDoor(vehicle)
                if door ~= false then
                    if isRestricted then
                        if CheckVehicleRestriction(vehicle, vehList) then
                            TaskEnterVehicle(companion, vehicle, -1, door, 2.0, 1, 0)
                            QBCore.Functions.Notify(k9_name .. " " .. language.enter, "success", 5000)
                        end
                    else
                        TaskEnterVehicle(companion, vehicle, -1, door, 2.0, 1, 0)
                        QBCore.Functions.Notify(k9_name .. " " .. language.enter, "success", 5000)
                    end
                end
            else
                local vehicle = GetVehiclePedIsIn(GetLocalPed(), false)
                local door = 1
                if isRestricted then
                    if CheckVehicleRestriction(vehicle, vehList) then
                        TaskEnterVehicle(companion, vehicle, -1, door, 2.0, 1, 0)
                        QBCore.Functions.Notify(k9_name .. " " .. language.enter, "success", 5000)
                    end
                else
                    TaskEnterVehicle(companion, vehicle, -1, door, 2.0, 1, 0)
                    QBCore.Functions.Notify(k9_name .. " " .. language.enter, "success", 5000)
                end
            end
        end
    end
end)

-- Triggers K9 to Attack
RegisterNetEvent("K9:ToggleAttack")
AddEventHandler("K9:ToggleAttack", function(target)
    if not attacking and not searching then
        if IsPedAPlayer(target) then
            local has_control = false
            RequestNetworkControl(function(cb)
                has_control = cb
            end)
            if has_control then
                local player = GetPlayerFromServerId(GetPlayerId(target))
                SetPedRelationshipGroupHash(GetPlayerPed(player), k9TargetHash)
                SetCanAttackFriendly(companion, true, true)
                TaskPutPedDirectlyIntoMelee(companion, GetPlayerPed(player), 0.0, -1.0, 0.0, 0)
                attacked_player = player
            end
        else
            local has_control = false
            RequestNetworkControl(function(cb)
                has_control = cb
            end)
            if has_control then
                SetCanAttackFriendly(companion, true, true)
                TaskPutPedDirectlyIntoMelee(companion, target, 0.0, -1.0, 0.0, 0)
                attacked_player = 0
            end
        end
        attacking = true
        following = false
        QBCore.Functions.Notify("Kan niet aanvallen", "error", 5000)
    end
end)

    -- Triggers K9 to Search Vehicle
    RegisterNetEvent("K9:SearchVehicle")
    AddEventHandler("K9:SearchVehicle", function(openDoors)
        local vehicle = GetVehicleAheadOfPlayer()
        Citizen.Trace(tostring(vehicle))
        if vehicle ~= 0 and not searching then
            local carplate = GetVehicleNumberPlateText(vehicle)
            if carplate ~= nil then
                searching = true

                QBCore.Functions.Notify("Hond Is begonnen met zoeken...", "primary", 5000) -- [text] = message, [type] = primary | error | success, [length] = time till fadeout.
                
                if openDoors then
                    SetVehicleDoorOpen(vehicle, 0, 0, 0)
                    SetVehicleDoorOpen(vehicle, 1, 0, 0)
                    SetVehicleDoorOpen(vehicle, 2, 0, 0)
                    SetVehicleDoorOpen(vehicle, 3, 0, 0)
                    SetVehicleDoorOpen(vehicle, 4, 0, 0)
                    SetVehicleDoorOpen(vehicle, 5, 0, 0)
                    SetVehicleDoorOpen(vehicle, 6, 0, 0)
                    SetVehicleDoorOpen(vehicle, 7, 0, 0)
                end

                -- Back Right
                local offsetOne = GetOffsetFromEntityInWorldCoords(vehicle, 2.0, -2.0, 0.0)
                TaskGoToCoordAnyMeans(companion, offsetOne.x, offsetOne.y, offsetOne.z, 5.0, 0, 0, 1, 10.0)

                Citizen.Wait(7000)

                -- Front Right
                local offsetTwo = GetOffsetFromEntityInWorldCoords(vehicle, 2.0, 2.0, 0.0)
                TaskGoToCoordAnyMeans(companion, offsetTwo.x, offsetTwo.y, offsetTwo.z, 5.0, 0, 0, 1, 10.0)

                Citizen.Wait(7000)

                -- Front Left
                local offsetThree = GetOffsetFromEntityInWorldCoords(vehicle, -2.0, 2.0, 0.0)
                TaskGoToCoordAnyMeans(companion, offsetThree.x, offsetThree.y, offsetThree.z, 5.0, 0, 0, 1, 10.0)

                Citizen.Wait(7000)

                -- Front Right
                local offsetFour = GetOffsetFromEntityInWorldCoords(vehicle, -2.0, -2.0, 0.0)
                TaskGoToCoordAnyMeans(companion, offsetFour.x, offsetFour.y, offsetFour.z, 5.0, 0, 0, 1, 10.0)

                Citizen.Wait(7000)

                if openDoors then
                    SetVehicleDoorsShut(vehicle, 0)
                end

                TriggerServerEvent("K9:SearchItems", carplate, k9_name)
                searching = false
            else
                QBCore.Functions.Notify("There is no vehicle nearby", "error", 5000) -- [text] = message, [type] = primary | error | success, [length] = time till fadeout.
            end
        else
            QBCore.Functions.Notify("There is no vehicle nearby", "error", 5000) -- [text] = message, [type] = primary | error | success, [length] = time till fadeout.
        end
    end)


function deleteAnimal()
    DeleteEntity(companion)
    companion = nil
    print("despawn companion")
end

function DrawText3Ds(x, y, z, text)
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
