Framework = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(600)
        if Framework == nil then
            TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)
            Citizen.Wait(200)
        end
    end
end)
local bac = nil
local display = false

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

RegisterNUICallback("exit", function(data)
    SetDisplay(false)
    SendNUIMessage({
        type = "data",
        bac = '0.00',
        textColor = '--color-black'
    })
end)

RegisterNUICallback("startBac", function(data)
    local target = GetClosestPlayerRadius(2.0)
	if target == nil then Notify("~r~Player not found!") return; end
	-- if target == nil then target = 1 end -- debugging
    TriggerServerEvent('breathalyzer.server:doBacTest', GetPlayerServerId(target))
    
    Framework.Functions.Notify('Verzoek gestuurd aan ' .. GetPlayerName(target), 'success')
    -- Notify('Request has been sent to ~y~' .. GetPlayerName(target))
end)

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        -- https://runtime.fivem.net/doc/natives/#_0xFE99B66D079CF6BC
        --[[ 
            inputGroup -- integer , 
	        control --integer , 
            disable -- boolean 
        ]]
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)

RegisterNetEvent('breathalyzer.client:requestBac')
AddEventHandler('breathalyzer.client:requestBac', function(leo,target)
    local accepted = nil
    
    Framework.Functions.Notify('' .. GetPlayerName(GetPlayerFromServerId(leo)) .. ' wilt jou een ademtest afnemen. Accepteer [Y] of Weigeren [N]', 'error')

    Citizen.CreateThread(function()
        while accepted == nil do
            Citizen.Wait(0)
            if IsControlJustReleased(1, 246) then
                accepted = true
                TriggerServerEvent('breathalyzer.server:acceptedBac', leo, target)
                --local result = KeyboardInput('BAC Level (Legal limit is 0.08):', 4)
                --if result then
                Framework.Functions.GetPlayerData(function(PlayerData)
                    if PlayerData ~= nil and PlayerData.money ~= nil then
                        alcohollvl = PlayerData.metadata["alcohol"]
                    end
                end)
                    bac = alcohollvl
                    -- bac = tonumber(result)
                Citizen.Wait(6250)
                    TriggerServerEvent('breathalyzer.server:returnBac', bac, leo)
                --end
            end
            if IsControlJustReleased(1, 249) then
                accepted = false
                TriggerServerEvent('breathalyzer.server:refusedBac', leo, target)
            end
        end
    end)
end)

RegisterNetEvent('breathalyzer.client:OdisplayBac')
AddEventHandler('breathalyzer.client:OdisplayBac', function()
    SetDisplay(true)
end)


RegisterNetEvent('breathalyzer.client:displayBac')
AddEventHandler('breathalyzer.client:displayBac', function(bac, color)
    SendNUIMessage({
        type = "data",
        bac = bac,
        textColor = color
    })
end)

RegisterNetEvent('breathalyzer.client:bacRefused')
AddEventHandler('breathalyzer.client:bacRefused', function(target)
    SetDisplay(false)
    SendNUIMessage({
        type = "data",
        bac = '0.00',
        textColor = '--color-black'
    })
    
    Framework.Functions.Notify("" .. GetPlayerName(GetPlayerFromServerId(target)) .. " ~w~heeft de test geweigerd!", "error")
end)

RegisterNetEvent('breathalyzer.client:acceptedBac')
AddEventHandler('breathalyzer.client:acceptedBac', function(target)
    
    Framework.Functions.Notify("" .. GetPlayerName(GetPlayerFromServerId(target)) .. " zijn/haar adem aan het testen...", "error")
end)