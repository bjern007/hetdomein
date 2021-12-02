---------------
-- Variables --
---------------
Framework = exports["pepe-core"]:GetCoreObject()
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


local MeterObjects = {
    2108567945,
}

local requiredItemsShowed = false
local requiredItems = {}

local timer = 0
local canRob = true

MaleNoHandshoes = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = true,
    [14] = true,
    [15] = true,
    [18] = true,
    [26] = true,
    [52] = true,
    [53] = true,
    [54] = true,
    [55] = true,
    [56] = true,
    [57] = true,
    [58] = true,
    [59] = true,
    [60] = true,
    [61] = true,
    [62] = true,
    [112] = true,
    [113] = true,
    [114] = true,
    [118] = true,
    [125] = true,
    [132] = true,
}

FemaleNoHandshoes = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = true,
    [14] = true,
    [15] = true,
    [19] = true,
    [59] = true,
    [60] = true,
    [61] = true,
    [62] = true,
    [63] = true,
    [64] = true,
    [65] = true,
    [66] = true,
    [67] = true,
    [68] = true,
    [69] = true,
    [70] = true,
    [71] = true,
    [129] = true,
    [130] = true,
    [131] = true,
    [135] = true,
    [142] = true,
    [149] = true,
    [153] = true,
    [157] = true,
    [161] = true,
    [165] = true,
}

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


function IsNearParkingMeter()
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    for k, v in pairs(MeterObjects) do
      local closestObj = GetClosestObjectOfType(plyCoords.x, plyCoords.y, plyCoords.z, 3.0, v, false, 0, 0)
      local objCoords = GetEntityCoords(closestObj)
      if closestObj ~= 0 then
        local dist = GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, objCoords.x, objCoords.y, objCoords.z, true)
        if dist <= 1.5 then
          return true
        end
      end
    end
    return false
end


function IsInVehicle()
    local ply = PlayerPedId()
    if IsPedSittingInAnyVehicle(ply) then
      return true
    else
      return false
    end
  end


function lockpickDone(success)

    local pos = GetEntityCoords(PlayerPedId())

    if success then
        PoliceCall()
        TriggerServerEvent('kwk-robparking:server:1I1i01I1')
        print("done")

        canRob = false
        timer = 60
    else

        if math.random(1, 100) <= 65 and not IsWearingHandshoes() then
            TriggerServerEvent("pepe-police:server:CreateFingerDrop", GetEntityCoords(PlayerPedId()))
            Framework.Functions.Notify("Handschoenen zijn gescheurd..")
        end

        if math.random(1, 100) <= 10 then
            TriggerServerEvent("Framework:Server:RemoveItem", "lockpick", 1)
            TriggerEvent('pepe-inventory:client:ItemBox', Framework.Shared.Items["lockpick"], "remove")
        end
    end
end



function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
    local model = GetEntityModel(PlayerPedId())
    local retval = true
    if model == GetHashKey("mp_m_freemode_01") then
        if MaleNoHandshoes[armIndex] ~= nil and MaleNoHandshoes[armIndex] then
            retval = false
        end
    else
        if FemaleNoHandshoes[armIndex] ~= nil and FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval
end


function PoliceCall()
    local pos = GetEntityCoords(PlayerPedId())
    local chance = 75
    if GetClockHours() >= 1 and GetClockHours() <= 6 then
        chance = 25
    end

    if math.random(1,100) < 40 then
        local StreetLabel = Framework.Functions.GetStreetLabel()
        TriggerServerEvent('pepe-police:server:send:alert:meter', GetEntityCoords(PlayerPedId()), StreetLabel)
     end
end


RegisterNetEvent('pepe-parkmeter:client:open')
AddEventHandler('pepe-parkmeter:client:open', function()
    Framework.Functions.TriggerCallback('Framework:HasItem', function(result)
        if result == true then
            if canRob == true then
                PoliceCall()
                exports['pepe-lockpick']:OpenLockpickGame(function(Success)
                    if Success then
                        LockPickRegisterAnim(12000)
                        Framework.Functions.Progressbar("search_parkmeter", "Parkeermeter beroven...", 12000, false, true, {
                           disableMovement = true,
                           disableCarMovement = true,
                           disableMouse = false,
                           disableCombat = true,
                       }, {}, {}, {}, function() -- Done    

                        TriggerServerEvent('kwk-robparking:server:1I1i01I1')
                        print("done")

                        canRob = false
                        timer = 60
                        if math.random(1, 100) <= 65 and not IsWearingHandshoes() then
                            TriggerServerEvent("pepe-police:server:CreateFingerDrop", GetEntityCoords(PlayerPedId()))
                            Framework.Functions.Notify("Handschoenen zijn gescheurd..")
                        end

                        if math.random(1, 100) <= 10 then
                            TriggerServerEvent("Framework:Server:RemoveItem", "lockpick", 1)
                            TriggerEvent('pepe-inventory:client:ItemBox', Framework.Shared.Items["lockpick"], "remove")
                        end

                       end, function() -- Cancel

                        Framework.Functions.Notify("Heloas")
                       end)
                    end
                end)
            else
                Framework.Functions.Notify('Cooldown. Over '..timer..' seconden kan je het weer proberen', 'error')
            end
        else
            Framework.Functions.Notify('Je hebt niet de benodigde items!', 'error')
        end
    end, "lockpick")
end)


function LockPickRegisterAnim(time)
    time = time / 1000
    exports['pepe-assets']:RequestAnimationDict("veh@break_in@0h@p_m_one@")
    TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds" ,3.0, 3.0, -1, 16, 0, false, false, false)
    canRob = true
    Citizen.CreateThread(function()
        while canRob do
            TriggerServerEvent('pepe-hud:server:gain:stress', 1) 
            TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Citizen.Wait(2000)
            time = time - 2
            if time <= 0 then
                canRob = false
                StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
            end
        end
    end)
   end

Citizen.CreateThread(function()
    while true do
        if canRob == false then
            if timer < 0 then
                timer = 0
                canRob = true
            else
                if timer == 0 then
                    canRob = true
                else
                    timer = timer - 60
                end
            end
        end
        Citizen.Wait(60000)
    end
end)

