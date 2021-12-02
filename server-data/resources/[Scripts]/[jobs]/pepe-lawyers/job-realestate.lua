local DoorLocked = false
CreateThread(function()
    Wait(500)
    TriggerServerEvent('pepe-lawyers:server:doorState')
    while true do
        local plyPed = PlayerPedId()
        local plyCoords = GetEntityCoords(plyPed)
        local letSleep = true

        local distance = {}
        local whitelisted = (Framework and Framework.Functions.GetPlayerData().job and Framework.Functions.GetPlayerData().job.name == 'realestate')

        for k,v in pairs(Config.Locations) do
            distance[k] = Vdist2(plyCoords.x, plyCoords.y, plyCoords.z, v.x, v.y, v.z)
            if (distance[k] < 20) then
                letSleep = false
                local draw = false
                if (k == 'enter' or k =='exit') then
                    draw = true
                elseif (k == 'boss') then
                    -- if whitelisted and isboss then
                        draw = true
                    -- end
                elseif whitelisted then
                    draw = true
                end

                if (draw) then
                    DrawMarker(27, v.x, v.y, v.z-0.8, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.001, 1.0001, 0.5001, 0, 25, 165, 100, false, true, 2, false, false, false, false)
                end
            end
        end

        if (distance['enter'] < 5) then
            DrawText3Ds(Config.Locations['enter'].x, Config.Locations['enter'].y, Config.Locations['enter'].z, "[E] - Enter")
            if IsControlJustPressed(0, 38) then
                DoScreenFadeOut(500)
                while not IsScreenFadedOut() do
                    Wait(10)
                end
                SetEntityCoords(PlayerPedId(), Config.Locations['exit'].x, Config.Locations['exit'].y, Config.Locations['exit'].z)
                Wait(1000)
                DoScreenFadeIn(500)
            end
        elseif (distance['exit'] < 5) then
                DrawText3Ds(Config.Locations['exit'].x, Config.Locations['exit'].y, Config.Locations['exit'].z, "[E] - Enter")
            if IsControlJustPressed(0, 38) then
                DoScreenFadeOut(500)
                while not IsScreenFadedOut() do
                    Wait(10)
                end
                SetEntityCoords(PlayerPedId(), Config.Locations['enter'].x, Config.Locations['enter'].y, Config.Locations['enter'].z)
                Wait(1000)
                DoScreenFadeIn(500)
            end
        end

        

        if (distance['enterlawyer'] < 5) then
            DrawText3Ds(Config.Locations['enterlawyer'].x, Config.Locations['enterlawyer'].y, Config.Locations['enterlawyer'].z, "[E] - Enter")
            if IsControlJustPressed(0, 38) then
                DoScreenFadeOut(500)
                while not IsScreenFadedOut() do
                    Wait(10)
                end
                SetEntityCoords(PlayerPedId(), Config.Locations['exitlawyer'].x, Config.Locations['exitlawyer'].y, Config.Locations['exitlawyer'].z)
                Wait(1000)
                DoScreenFadeIn(500)
            end
        elseif (distance['exitlawyer'] < 5) then
                DrawText3Ds(Config.Locations['exitlawyer'].x, Config.Locations['exitlawyer'].y, Config.Locations['exitlawyer'].z, "[E] - Enter")
            if IsControlJustPressed(0, 38) then
                DoScreenFadeOut(500)
                while not IsScreenFadedOut() do
                    Wait(10)
                end
                SetEntityCoords(PlayerPedId(), Config.Locations['enterlawyer'].x, Config.Locations['enterlawyer'].y, Config.Locations['enterlawyer'].z)
                Wait(1000)
                DoScreenFadeIn(500)
            end
        end


        if (letSleep) then
            Wait(3000)
        else
            Wait(1)
        end
    end
end)

RegisterNetEvent('pepe-lawyers:client:doorState')
AddEventHandler('pepe-lawyers:client:doorState', function(bool)
    DoorLocked = bool
end)

RegisterNetEvent('pepe-lawyers:client:openstashrealestate')
AddEventHandler('pepe-lawyers:client:openstashrealestate', function()
    TriggerEvent("pepe-inventory:client:SetCurrentStash", "Makelaar")
    TriggerServerEvent("pepe-inventory:server:OpenInventory", "stash", "Makelaar", {
        maxweight = 40000,
        slots = 50,
    })
    TriggerEvent("pepe-sound:client:play", "stash-open", 0.4)
end)

RegisterNetEvent('pepe-lawyers:client:openstashlawyer')
AddEventHandler('pepe-lawyers:client:openstashlawyer', function()
    TriggerEvent("pepe-inventory:client:SetCurrentStash", "Advocaat")
    TriggerServerEvent("pepe-inventory:server:OpenInventory", "stash", "Advocaat", {
        maxweight = 40000,
        slots = 50,
    })
    TriggerEvent("pepe-sound:client:play", "stash-open", 0.4)
end)
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