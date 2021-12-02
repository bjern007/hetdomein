Config = {}
Config.Example = {
	[1] = {coords = vector3(150.26, -1040.20, 29.37), distance = 2, text = '[F1] Open Bank'},
    [2] = {coords = vector3(441.27, -981.96, 30.68), distance = 2.5, text = '[E] Dienstklokker'},
    [3] = {coords = vector3(457.98931, -979.4179, 34.297359), distance = 1.5, text = '[E] Outfit kiezen'},
    [4] = {coords = vector3(-453.2829, 6013.7529, 31.716428), distance = 1.5, text = '[E] Outfit kiezen'},
    [5] = {coords = vector3(484.64797, -992.634, 26.39979), distance = 1.5, text = '[E] Impound'},
    [6] = {coords = vector3(442.233, -988.42, 34.282268), distance = 1.5, text = '[E] Wapenkluis'},
    [7] = {coords = vector3(-781.1369, -212.0666, 37.07958), distance = 1.5, text = '[E] Dienstklokker'},
    [8] = {coords = vector3(-779.7492, -233.6356, 37.07958), distance = 1.5, text = '[E] Stash'},
}

Citizen.CreateThread(function()
    local alreadyEnteredZone = false
    local text = nil
    while true do
        wait = 5
        local ped = PlayerPedId()
        local inZone = false
        for cd = 1, #Config.Example do
            local dist = #(GetEntityCoords(ped)-vector3(Config.Example[cd].coords.x, Config.Example[cd].coords.y, Config.Example[cd].coords.z))
            if dist <= Config.Example[cd].distance then
                wait = 5
                inZone  = true
                text = Config.Example[cd].text

                break
            else
                wait = 2000
            end
        end
        
        if inZone and not alreadyEnteredZone then
            alreadyEnteredZone = true
            TriggerEvent('pepe-nui:client:ShowUI', 'show', text)
        end

        if not inZone and alreadyEnteredZone then
            alreadyEnteredZone = false
            TriggerEvent('pepe-nui:client:HideUI')
        end
        Citizen.Wait(wait)
    end
end)

-- Citizen.CreateThread(function()
--     local alreadyEnteredZone = false
--     local text = nil
--     while true do
--         wait = 5
--         local ped = PlayerPedId()
--         local inZone = false
--         for cd = 1, #Config.Example do
--             local dist = #(GetEntityCoords(ped)-vector3(Config.Example[cd].coords.x, Config.Example[cd].coords.y, Config.Example[cd].coords.z))
--             if dist <= Config.Example[cd].distance then
--                 wait = 5
--                 inZone  = true
--                 text = Config.Example[cd].text

--                 if IsControlJustReleased(0, Config.Example[cd].key) then
--                     TriggerEvent(Config.Example[cd].eventname)
--                 end
--                 break
--             else
--                 wait = 2000
--             end
--         end
        
--         if inZone and not alreadyEnteredZone then
--             alreadyEnteredZone = true
--             TriggerEvent('pepe-nui:client:ShowUI', 'show', text)
--         end

--         if not inZone and alreadyEnteredZone then
--             alreadyEnteredZone = false
--             TriggerEvent('pepe-nui:client:HideUI')
--         end
--         Citizen.Wait(wait)
--     end
-- end)

RegisterNetEvent('pepe-nui:client:ShowUI')
AddEventHandler('pepe-nui:client:ShowUI', function(action, text)
	SendNUIMessage({
		action = action,
		text = text,
	})
end)

RegisterNetEvent('pepe-nui:client:HideUI')
AddEventHandler('pepe-nui:client:HideUI', function()
	SendNUIMessage({
		action = 'hide'
	})
end)

