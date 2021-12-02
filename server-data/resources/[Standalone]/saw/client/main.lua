local EventActive = false
local FrozenVeh = nil
local IsSaw = false
Framework = exports["pepe-core"]:GetCoreObject()

RegisterNetEvent('dovux:teaser')
AddEventHandler('dovux:teaser', function()
    if not EventActive then
        SetNuiFocus(true, false)
        SendNUIMessage({
            action = "enable"
        })

        if IsPedInAnyVehicle(PlayerPedId()) then
		local vehicle = GetVehiclePedIsIn(PlayerPedId())
           TaskLeaveVehicle(PlayerPedId(), vehicle, 16)
			
        end
        EventActive = true
    end
end)

RegisterNUICallback('CloseEvent', function(data, cb)
    SetNuiFocus(false, false)
    EventActive = false
    FreezeEntityPosition(FrozenVeh, false)
    FrozenVeh = nil
	TriggerEvent('dovux:juego')
end)


RegisterNetEvent('dovux:juego')
AddEventHandler('dovux:juego', function()
	local ped = PlayerPedId()
		
		--casco = CreateObject(GetHashKey("prop_welding_mask_01"), 0, 0, 0, true, true, true) -- Create saw mask
		--AttachEntityToEntity(casco, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 12844), 0.15, 0.018, -0.01, 0, 98.0, 178.0, true, true, false, true, 1, true) -- Attach object to head
		IsSaw = true
        exports['minigame-memoryminigame']:StartMinigame({
            success = 'success:event:example22',
            fail = 'fail:event:example22'
        })
end)


RegisterNetEvent('success:event:example22')
AddEventHandler('success:event:example22', function()
    
            TriggerServerEvent("pay:saw") 
			ClearPedTasks(ped)
			DeleteEntity(casco)
			IsSaw = false
end)

RegisterNetEvent('fail:event:example22')
AddEventHandler('fail:event:example22', function()

    ClearPedTasks(ped)
    IsSaw = false
    DeleteEntity(casco)
end)

-- RegisterNetEvent('instrucciones')
-- AddEventHandler('instrucciones', function()
--     while IsSaw do
--         Citizen.Wait(0)        
--           drawTxt(0.94, 1.44, 1.0,1.0,0.6, "Maak je keuze...", 255, 255, 255, 255)       
--           --drawTxt(0.94, 1.44, 1.0,1.0,0.6, "Maak je keuze...", 255, 255, 255, 255)       
--     end
-- end)

-- function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
--     SetTextFont(4)
--     SetTextProportional(0)
--     SetTextScale(0.40, 0.40)
--     SetTextColour(r, g, b, a)
--     SetTextDropShadow(0, 0, 0, 0,255)
--     SetTextEdge(2, 0, 0, 0, 255)
--     SetTextDropShadow()
--     SetTextOutline()
--     SetTextEntry("STRING")
--     AddTextComponentString(text)
--     DrawText(x - width/2, y - height/2 + 0.005)
-- end
