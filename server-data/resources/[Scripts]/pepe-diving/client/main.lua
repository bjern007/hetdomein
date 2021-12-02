Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}
isLoggedIn = false
PlayerJob = {}

Framework = exports["pepe-core"]:GetCoreObject()


RegisterNetEvent("Framework:Client:OnPlayerLoaded")
AddEventHandler("Framework:Client:OnPlayerLoaded", function()
    Framework.Functions.TriggerCallback('pepe-diving:server:GetBusyDocks', function(Docks)
        QBBoatshop.Locations["berths"] = Docks
    end)

    Framework.Functions.TriggerCallback('pepe-diving:server:GetDivingConfig', function(Config, Area)
        QBDiving.Locations = Config
        TriggerEvent('pepe-diving:client:SetDivingLocation', Area)
    end)

    PlayerJob = Framework.Functions.GetPlayerData().job

    isLoggedIn = true

    if PlayerJob.name == "police" then
        if PoliceBlip ~= nil then
            RemoveBlip(PoliceBlip)
        end
        PoliceBlip = AddBlipForCoord(QBBoatshop.PoliceBoat.x, QBBoatshop.PoliceBoat.y, QBBoatshop.PoliceBoat.z)
        SetBlipSprite(PoliceBlip, 410)
        SetBlipDisplay(PoliceBlip, 4)
        SetBlipScale(PoliceBlip, 0.8)
        SetBlipAsShortRange(PoliceBlip, true)
        SetBlipColour(PoliceBlip, 29)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Politieboot")
        EndTextCommandSetBlipName(PoliceBlip)
        PoliceBlip = AddBlipForCoord(QBBoatshop.PoliceBoat2.x, QBBoatshop.PoliceBoat2.y, QBBoatshop.PoliceBoat2.z)
        SetBlipSprite(PoliceBlip, 410)
        SetBlipDisplay(PoliceBlip, 4)
        SetBlipScale(PoliceBlip, 0.8)
        SetBlipAsShortRange(PoliceBlip, true)
        SetBlipColour(PoliceBlip, 29)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Politieboot")
        EndTextCommandSetBlipName(PoliceBlip)
    end
end)

-- Code

DrawText3D = function(x, y, z, text)
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

RegisterNetEvent('pepe-diving:client:UseJerrycan')
AddEventHandler('pepe-diving:client:UseJerrycan', function()
    local ped = PlayerPedId()
    local boat = IsPedInAnyBoat(ped)
    if boat then
        local curVeh = GetVehiclePedIsIn(ped, false)
        Framework.Functions.Progressbar("reful_boat", "Aan het vol tanken..", 20000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            exports['pepe-fuel']:SetFuelLevel(curVeh, GetVehicleNumberPlateText(curVeh), 100, false)
            Framework.Functions.Notify('Het voertuig is getankt', 'success')
            TriggerServerEvent('pepe-diving:server:RemoveItem', 'jerry_can', 1)
            TriggerEvent('inventory:client:ItemBox', Framework.Shared.Items['jerry_can'], "remove")
        end, function() -- Cancel
            Framework.Functions.Notify('Tanken is geannuleerd!', 'error')
        end)
    else
        Framework.Functions.Notify('Je zit niet in een boot', 'error')
    end
end)

-- local currentGear = {
--     mask = 0,
--     tank = 0,
--     enabled = false
-- }

-- function DeleteGear()
-- 	if currentGear.mask ~= 0 then
--         DetachEntity(currentGear.mask, 0, 1)
--         DeleteEntity(currentGear.mask)
-- 		currentGear.mask = 0
--     end
    
-- 	if currentGear.tank ~= 0 then
--         DetachEntity(currentGear.tank, 0, 1)
--         DeleteEntity(currentGear.tank)
-- 		currentGear.tank = 0
-- 	end
-- end

-- RegisterNetEvent('pepe-diving:client:UseGear')
-- AddEventHandler('pepe-diving:client:UseGear', function(bool)
--     if bool then
--         GearAnim()
--         Framework.Functions.Progressbar("equip_gear", "Duikpak aantrekken..", 5000, false, true, {}, {}, {}, {}, function() -- Done
--             DeleteGear()
--             local maskModel = GetHashKey("p_d_scuba_mask_s")
--             local tankModel = GetHashKey("p_s_scuba_tank_s")
    
--             RequestModel(tankModel)
--             while not HasModelLoaded(tankModel) do
--                 Citizen.Wait(1)
--             end
--             TankObject = CreateObject(tankModel, 1.0, 1.0, 1.0, 1, 1, 0)
--             local bone1 = GetPedBoneIndex(PlayerPedId(), 24818)
--             AttachEntityToEntity(TankObject, PlayerPedId(), bone1, -0.25, -0.25, 0.0, 180.0, 90.0, 0.0, 1, 1, 0, 0, 2, 1)
--             currentGear.tank = TankObject
    
--             RequestModel(maskModel)
--             while not HasModelLoaded(maskModel) do
--                 Citizen.Wait(1)
--             end
            
--             MaskObject = CreateObject(maskModel, 1.0, 1.0, 1.0, 1, 1, 0)
--             local bone2 = GetPedBoneIndex(PlayerPedId(), 12844)
--             AttachEntityToEntity(MaskObject, PlayerPedId(), bone2, 0.0, 0.0, 0.0, 180.0, 90.0, 0.0, 1, 1, 0, 0, 2, 1)
--             currentGear.mask = MaskObject
    
--             SetEnableScuba(PlayerPedId(), true)
--             SetPedMaxTimeUnderwater(PlayerPedId(), 2000.00)
--             currentGear.enabled = true
--             TriggerServerEvent('pepe-diving:server:RemoveGear')
--             ClearPedTasks(PlayerPedId())
--             TriggerEvent('chatMessage', "SYSTEM", "error", "/duikpak om je duikpak uit te trekken!")
--         end)
--     else
--         if currentGear.enabled then
--             GearAnim()
--             Framework.Functions.Progressbar("remove_gear", "Duikpak uittrekken..", 5000, false, true, {}, {}, {}, {}, function() -- Done
--                 DeleteGear()

--                 SetEnableScuba(PlayerPedId(), false)
--                 SetPedMaxTimeUnderwater(PlayerPedId(), 1.00)
--                 currentGear.enabled = false
--                 TriggerServerEvent('pepe-diving:server:GiveBackGear')
--                 ClearPedTasks(PlayerPedId())
--                 Framework.Functions.Notify('Je hebt je duikpak uitgetrokken')
--             end)
--         else
--             Framework.Functions.Notify('Je hebt geen duikgear aan..', 'error')
--         end
--     end
-- end)

-- function GearAnim()
--     loadAnimDict("clothingshirt")    	
-- 	TaskPlayAnim(PlayerPedId(), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
-- end

