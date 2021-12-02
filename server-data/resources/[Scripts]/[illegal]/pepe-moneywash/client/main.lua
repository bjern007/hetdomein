Framework = exports["pepe-core"]:GetCoreObject()

RegisterNetEvent('Framework:Client:OnPlayerLoaded')
AddEventHandler('Framework:Client:OnPlayerLoaded', function()
    PlayerJob = Framework.Functions.GetPlayerData().job
    onDuty = true
end)

RegisterNetEvent('Framework:Client:SetDuty')
AddEventHandler('Framework:Client:SetDuty', function(duty)
    onDuty = duty
end)

RegisterNetEvent('Framework:Client:OnJobUpdate')
AddEventHandler('Framework:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = true
end)

RegisterNetEvent('police:SetCopCount')
AddEventHandler('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

local washing = false
local timer = 0
local collect = false
local washer = 0



Citizen.CreateThread(function()
	while true do 
		-- Citizen.Wait(1)
		local inRange = false
        local pos = GetEntityCoords(PlayerPedId())
        local sleep = 1000
        local dist = #(pos - tpLocations.pOne)

        local distout = #(pos - tpLocations.tpOne)

      --  DrawMarker(markerConfig.markerType, tpLocations.pOne.x, tpLocations.pOne.y, tpLocations.pOne.z + 0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.5, 0.15, 255, 55, 15, 255, false, false, false, true, false, false, false)
        
		-- if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, tpLocations.pOne.x, tpLocations.pOne.y, tpLocations.pOne.z, true) < 5.0 then

        if dist <= 3.0 then
			inRange = true
            sleep = 5
            -- if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, tpLocations.pOne.x, tpLocations.pOne.y, tpLocations.pOne.z, true) < 1.5 then                                    
                DrawText3D(tpLocations.pOne.x, tpLocations.pOne.y, tpLocations.pOne.z, "~g~E~w~ - Enter Laundrette")
                if IsControlJustReleased(1, Keys['E']) then
                    --passcode()
                    enter()
                end
			-- end
        end

        -- if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, tpLocations.tpOne.x, tpLocations.tpOne.y, tpLocations.tpOne.z, true) < 5.0 then

        if distout <= 3.0 then
			inRange = true
            sleep = 5
            -- if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, tpLocations.tpOne.x, tpLocations.tpOne.y, tpLocations.tpOne.z, true) < 1.5 then      
                DrawText3D(tpLocations.tpOne.x, tpLocations.tpOne.y, tpLocations.tpOne.z, "~g~E~w~ - Exit Laundrette")
                if IsControlJustReleased(1, Keys['E']) then
                    leave()
                end
			-- end
        end
        Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function(amt)
	while true do 
		-- Citizen.Wait(7)
        local sleep = 1000
		local inRange = false
        local pos = GetEntityCoords(PlayerPedId())
        local ped = PlayerPedId()

        local distone = #(pos - washLocations.pOne)
        local disttwo = #(pos - washLocations.pTwo)
        local distthree = #(pos - washLocations.pThree)
        local distfour = #(pos - washLocations.pFour)

       -- DrawMarker(markerConfig.markerType, washLocations.pOne.x, washLocations.pOne.y, washLocations.pOne.z + 0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.5, 0.15, 255, 55, 15, 255, false, false, false, true, false, false, false)

		-- if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, washLocations.pOne.x, washLocations.pOne.y, washLocations.pOne.z, true) < 0.5 then

        if distone <= 0.5 then
			inRange = true
            sleep = 5
            -- if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, washLocations.pOne.x, washLocations.pOne.y, washLocations.pOne.z, true) < 0.5 then      
                if not washing and not collect then      
                    DrawText3D(washLocations.pOne.x, washLocations.pOne.y, washLocations.pOne.z, "~g~E~w~ - Starten")
                        if IsControlJustReleased(1, Keys['E']) then
                            WashAnimation()
                            Framework.Functions.Progressbar("bills_wash", "Gemarkeerd geld in de wasser stoppen..", math.random(2000, 5000), false, true, {
                                disableMovement = false,
                                disableCarMovement = false,
                                disableMouse = false,
                                disableCombat = true,
                            }, {
                            animDict = "mp_car_bomb",
                            anim = "car_bomb_mechanic",
                            flags = 16,
                        }, {}, {}, function() -- Done
                            TriggerServerEvent('pepe-moneywash:server:checkInv', amt)
                                StopAnimTask(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 1.0)
                                washer = 1

                    
                            end, function()
                                Framework.Functions.Notify("Gefaald.", "error")
                            end)                        
                        end
                        
                    end
			-- end
        end

        --DrawMarker(markerConfig.markerType, washLocations.pTwo.x, washLocations.pTwo.y, washLocations.pTwo.z + 0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.5, 0.15, 255, 55, 15, 255, false, false, false, true, false, false, false)

		-- if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, washLocations.pTwo.x, washLocations.pTwo.y, washLocations.pTwo.z, true) < 0.5 then

        if disttwo <= 0.5 then
			inRange = true
            sleep = 5
            -- if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, washLocations.pTwo.x, washLocations.pTwo.y, washLocations.pTwo.z, true) < 0.5 then      
                if not washing and not collect then      
                    DrawText3D(washLocations.pTwo.x, washLocations.pTwo.y, washLocations.pTwo.z, "~g~E~w~ - Starten")
                        if IsControlJustReleased(1, Keys['E']) then
                            WashAnimation()
                            Framework.Functions.Progressbar("bills_wash", "Gemarkeerd geld in de wasser stoppen..", math.random(2000, 6000), false, true, {
                                disableMovement = false,
                                disableCarMovement = false,
                                disableMouse = false,
                                disableCombat = true,
                            }, {
                            animDict = "mp_car_bomb",
                            anim = "car_bomb_mechanic",
                            flags = 16,
                        }, {}, {}, function() -- Done
                            TriggerServerEvent('pepe-moneywash:server:checkInv', amt)
                                StopAnimTask(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 1.0)
                                washer = 2

                    
                            end, function()
                                Framework.Functions.Notify("Gefaald.", "error")
                            end)                        
                        end
                        
                    end
			-- end
        end

        --DrawMarker(markerConfig.markerType, washLocations.pThree.x, washLocations.pThree.y, washLocations.pThree.z + 0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.5, 0.15, 255, 55, 15, 255, false, false, false, true, false, false, false)

		-- if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, washLocations.pThree.x, washLocations.pThree.y, washLocations.pThree.z, true) < 0.5 then

        if distthree <= 0.5 then
			inRange = true
            sleep = 5
            -- if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, washLocations.pThree.x, washLocations.pThree.y, washLocations.pThree.z, true) < 0.5 then      
                if not washing and not collect then      
                    DrawText3D(washLocations.pThree.x, washLocations.pThree.y, washLocations.pThree.z, "~g~E~w~ - Starten")
                        if IsControlJustReleased(1, Keys['E']) then
                            WashAnimation()
                            Framework.Functions.Progressbar("bills_wash", "Gemarkeerd geld in de wasser stoppen..", math.random(2000, 3000), false, true, {
                                disableMovement = false,
                                disableCarMovement = false,
                                disableMouse = false,
                                disableCombat = true,
                            }, {
                            animDict = "mp_car_bomb",
                            anim = "car_bomb_mechanic",
                            flags = 16,
                            }, {}, {}, function() -- Done
                                TriggerServerEvent('pepe-moneywash:server:checkInv', 1)
                                StopAnimTask(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 1.0)
                                washer = 3

                    
                            end, function()
                                Framework.Functions.Notify("Gefaald.", "error")
                            end)                        
                        end
                        
                    end     
			-- end
        end	
  
        
       -- DrawMarker(markerConfig.markerType, washLocations.pFour.x, washLocations.pFour.y, washLocations.pFour.z + 0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.5, 0.15, 255, 55, 15, 255, false, false, false, true, false, false, false)

		-- if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, washLocations.pFour.x, washLocations.pFour.y, washLocations.pFour.z, true) < 0.5 then

        if distfour <= 0.5 then
			inRange = true
            sleep = 5
            -- if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, washLocations.pFour.x, washLocations.pFour.y, washLocations.pFour.z, true) < 0.5 then      
                if not washing and not collect then      
                    DrawText3D(washLocations.pFour.x, washLocations.pFour.y, washLocations.pFour.z, "~g~E~w~ - Starten")
                        if IsControlJustReleased(1, Keys['E']) then
                            WashAnimation()
                            Framework.Functions.Progressbar("bills_wash", "Gemarkeerd geld in de wasser stoppen..", math.random(2000, 3000), false, true, {
                                disableMovement = false,
                                disableCarMovement = false,
                                disableMouse = false,
                                disableCombat = true,
                            }, {
                            animDict = "mp_car_bomb",
                            anim = "car_bomb_mechanic",
                            flags = 16,
                            }, {}, {}, function() -- Done
                                TriggerServerEvent('pepe-moneywash:server:checkInv', 1)
                                StopAnimTask(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 1.0)
                                washer = 4    
                            end, function()
                                Framework.Functions.Notify("Gefaald.", "error")
                            end)                        
                        end
                        
                    end
                    
                
			-- end
        end
        Citizen.Wait(sleep)
    end 
end)

RegisterNetEvent('pepe-moneywash:client:washTimer')
AddEventHandler('pepe-moneywash:client:washTimer', function()
        Citizen.Wait(0)
        local pos = GetEntityCoords(PlayerPedId())
        local ped = PlayerPedId()
        local inRange = false

        while washing do
            if washer == 1 then
                washCoordX = washLocations.pOne.x
                washCoordY = washLocations.pOne.y
                washCoordZ = washLocations.pOne.z
            elseif washer == 2 then
                washCoordX = washLocations.pTwo.x
                washCoordY = washLocations.pTwo.y
                washCoordZ = washLocations.pTwo.z
            elseif washer == 3 then
                washCoordX = washLocations.pThree.x
                washCoordY = washLocations.pThree.y
                washCoordZ = washLocations.pThree.z
            elseif washer == 4 then
                washCoordX = washLocations.pFour.x
                washCoordY = washLocations.pFour.y
                washCoordZ = washLocations.pFour.z
            end
            Citizen.Wait(0)
            DrawText3D(washCoordX, washCoordY, washCoordZ, "Klaar over: " .. timer .. ' seconden.')               
        end
end)

function collectMoney(amt)

    Citizen.CreateThread(function()

    while collect do
        if washer == 1 then
            collectCoordX = washLocations.pOne.x
            collectCoordY = washLocations.pOne.y
            collectCoordZ = washLocations.pOne.z
        elseif washer == 2 then
            collectCoordX = washLocations.pTwo.x
            collectCoordY = washLocations.pTwo.y
            collectCoordZ = washLocations.pTwo.z
        elseif washer == 3 then
            collectCoordX = washLocations.pThree.x
            collectCoordY = washLocations.pThree.y
            collectCoordZ = washLocations.pThree.z
        elseif washer == 4 then
            collectCoordX = washLocations.pFour.x
            collectCoordY = washLocations.pFour.y
            collectCoordZ = washLocations.pFour.z
        end

        local inRange = false
        local pos = GetEntityCoords(PlayerPedId())
        local ped = PlayerPedId()
    
        local distcollect = #(pos - vector3(collectCoordX, collectCoordY, collectCoordZ))
        Citizen.Wait(0)
        DrawText3D(collectCoordX, collectCoordY, collectCoordZ, "~g~E~w~ - Ontvang Geld")

        if distcollect <= 1.0 then 
            inRange = true 
                        if IsControlJustReleased(1, Keys['E']) and inRange then
                            WashAnimation()
                            Framework.Functions.Progressbar("bills_collect", "Geld uit de wasser halen...", math.random(1000, 5000), false, true, {
                                disableMovement = false,
                                disableCarMovement = false,
                                disableMouse = false,
                                disableCombat = true,
                            }, {
                            animDict = "mp_car_bomb",
                            anim = "car_bomb_mechanic",
                            flags = 16,
                            }, {}, {}, function() -- Done
                                TriggerServerEvent('pepe-moneywash:server:giveMoney', amt)
                                TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                                StopAnimTask(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 1.0)
                                collect = false                        
                            end, function()
                                Framework.Functions.Notify("Gefaald.", "error")
                            end) 

                    end                   
                --end
            end            
        end
    end)
end

--- blips here

Citizen.CreateThread(function()
	for k,v in pairs(Config.Witwas) do
		local WitwasBlip = AddBlipForCoord(v.Blip.Coords)

		SetBlipSprite (WitwasBlip, v.Blip.Sprite)
		SetBlipScale  (WitwasBlip, v.Blip.Scale) 
		SetBlipColour (WitwasBlip, v.Blip.Colour)
		SetBlipAsShortRange(WitwasBlip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('Witwassen')
		EndTextCommandSetBlipName(WitwasBlip)
	end
end)

RegisterNetEvent('pepe-moneywash:client:startTimer')
AddEventHandler('pepe-moneywash:client:startTimer', function(amt)

    washing = true
    timer = math.ceil(0.005 * 1)
    if timer <= 10 then
        timer = 10
    end
    TriggerEvent('pepe-moneywash:client:washTimer')

        while washing do
            timer = timer - 1
            if timer <= 0 then
                washing = false
                collect = true
                Framework.Functions.Notify('Je geld is witgewassen.', 'success', 2000)

                collectMoney(amt)
            end
            Citizen.Wait(1000)
        end
end)

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
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 41, 11, 41, 60)    
    ClearDrawOrigin()
end

function WashAnimation()
    loadAnimDict("mp_car_bomb")
    TaskPlayAnim(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic" ,3.0, 3.0, -1, 16, 0, false, false, false)
    Citizen.CreateThread(function()
        while washing do
            TaskPlayAnim(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Citizen.Wait(2000)
        end
    end)
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function openHouseAnim()
    loadAnimDict("anim@heists@keycard@") 
    TaskPlayAnim( PlayerPedId(), "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0 )
    Citizen.Wait(400)
    ClearPedTasks(PlayerPedId())
end

function enter()
	local ped = PlayerPedId()
	openHouseAnim()
    DoScreenFadeOut(500)
    Citizen.Wait(1500)
    SetEntityCoords(ped, tpLocations.tpOne.x, tpLocations.tpOne.y, tpLocations.tpOne.z)
	DoScreenFadeIn(500)
	--TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_close", 0.1)
    --TriggerEvent("pepe-sound:client:play", "house-door-close", 0.1)
end

function leave()
	local ped = PlayerPedId()
	openHouseAnim()
    DoScreenFadeOut(500)
    Citizen.Wait(1500)
    SetEntityCoords(ped, tpLocations.pOne.x, tpLocations.pOne.y, tpLocations.pOne.z)
	DoScreenFadeIn(500)
end
function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
    local model = GetEntityModel(PlayerPedId())
    local retval = true
    if model == GetHashKey("mp_m_freemode_01") then
        if Barley.MaleNoHandshoes[armIndex] ~= nil and Barley.MaleNoHandshoes[armIndex] then
            retval = false
        end
    else
        if Barley.FemaleNoHandshoes[armIndex] ~= nil and Barley.FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval
end
