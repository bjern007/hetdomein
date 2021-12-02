local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}
Framework = nil

Citizen.CreateThread(function()
    while Framework == nil do
        TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)
        Citizen.Wait(200)
    end
end)


isLoggedIn = false
local PlayerJob = {}

local NearRecycleStatus = false

RegisterNetEvent('Framework:Client:OnPlayerLoaded')
AddEventHandler('Framework:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerJob = Framework.Functions.GetPlayerData().job
end)

RegisterNetEvent('Framework:Client:OnPlayerUnload')
AddEventHandler('Framework:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('Framework:Client:OnJobUpdate')
AddEventHandler('Framework:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

---- Render Props -------


function renderPropsWhereHouse()
	CreateObject(GetHashKey("ex_prop_crate_bull_sc_02"),1003.63013,-3108.50415,-39.9669662,false,false,false)
	CreateObject(GetHashKey("ex_prop_crate_wlife_bc"),1018.18011,-3102.8042,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_prop_crate_closed_bc"),1006.05511,-3096.954,-37.8179666,false,false,false)
	CreateObject(GetHashKey("ex_prop_crate_wlife_sc"),1003.63013,-3102.8042,-37.81769,false,false,false)
	CreateObject(GetHashKey("ex_prop_crate_jewels_racks_sc"),1003.63013,-3091.604,-37.8179666,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1013.330000003,-3102.80400000,-35.62896000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1015.75500000,-3102.80400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1015.75500000,-3102.80400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Jewels_BC"),1018.18000000,-3091.60400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1026.75500000,-3111.38400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Jewels_BC"),1003.63000000,-3091.60400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Jewels_BC"),1026.75500000,-3106.52900000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1026.75500000,-3106.52900000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_02_SC"),1010.90500000,-3108.50400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_BC"),1013.33000000,-3108.50400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_BC"),1015.75500000,-3108.50400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_SC_02"),1010.90500000,-3096.95400000,-39.86697000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_SC"),993.35510000,-3111.30400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_BC"),993.35510000,-3108.95400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Gems_SC"),1013.33000000,-3096.95400000,-37.8177600,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_clothing_BC"),1018.180000000,-3096.95400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_clothing_BC"),1008.48000000,-3096.95400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Gems_BC"),1003.63000000,-3108.50400000,-35.61234000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Narc_BC"),1026.75500000,-3091.59400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Narc_BC"),1026.75500000,-3091.59400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_SC"),1008.48000000,-3108.50400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Tob_SC"),1018.18000000,-3096.95400000,-37.81240000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Wlife_BC"),1018.18000000,-3091.60400000,-35.74857000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Med_BC"),1008.48000000,-3091.60400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_SC"),1013.33000000,-3108.50400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1026.75500000,-3108.88900000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_biohazard_BC"),1010.90500000,-3102.80400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Wlife_BC"),1015.75500000,-3091.60400000,-35.74857000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_biohazard_BC"),1003.63000000,-3108.50400000,-37.81561000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_BC"),1008.48000000,-3096.954000000,-35.60529000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_BC_02"),1006.05500000,-3108.50400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_RW"),1013.33000000,-3091.60400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Narc_SC"),1026.75500000,-3094.014000000,-37.81684000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_BC"),1015.75500000,-3108.50400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_BC"),1010.90500000,-3096.95400000,-35.60529000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Ammo_BC"),1013.33000000,-3102.80400000,-37.81427000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Money_BC"),1003.63000000,-3096.95400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Gems_BC"),1003.63000000,-3096.95400000,-37.81187000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1010.90500000,-3091.60400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_furJacket_BC"),1013.33000000,-3091.60400000,-35.74885000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_furJacket_BC"),1026.75500000,-3091.59400000,-35.74885000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_furJacket_BC"),1026.75500000,-3094.0140000,-35.74885000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_furJacket_BC"),1026.75500000,-3096.43400000,-35.74885000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_clothing_SC"),1013.33000000,-3091.604000000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_biohazard_SC"),1006.05500000,-3108.50400000,-37.81576000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_BC"),993.35510000,-3106.60400000,-35.60529000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1026.75500000,-3111.38400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_BC_02"),1026.75500000,-3096.4340000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1015.75500000,-3096.95400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_HighEnd_pharma_BC"),1003.63000000,-3091.60400000,-35.62571000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_HighEnd_pharma_SC"),1015.75500000,-3091.60400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_02_BC"),1013.330000000,-3096.95400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Gems_SC"),1018.18000000,-3102.80400000,-37.81776000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_02_BC"),1013.33000000,-3108.50400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Gems_BC"),1018.18000000,-3108.50400000,-37.81234000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Tob_BC"),1010.90500000,-3108.50400000,-35.75240000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Med_SC"),1026.75500000,-3108.88900000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Money_SC"),1010.90500000,-3091.60400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Med_SC"),1008.48000000,-3091.60400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_02_BC"),1018.180000000,-3108.50400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_SC_02"),1008.48000000,-3108.50400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_02_BC"),993.35510000,-3106.60400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1008.480000000,-3102.804000000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_BC"),993.35510000,-3111.30400000,-35.60529000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_HighEnd_pharma_BC"),1018.18000000,-3091.60400000,-37.81572000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Gems_BC"),1015.75500000,-3102.80400000,-37.81234000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Jewels_racks_BC"),1003.63000000,-3102.80400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Money_SC"),1006.05500000,-3096.95400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1003.630000000,-3096.95400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_furJacket_SC"),1006.05500000,-3102.80400000,-37.81544000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Expl_bc"),1010.90500000,-3102.80400000,-37.81982000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_BC"),1006.05500000,-3096.9540000,-35.60529000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_BC"),1006.05500000,-3102.80400000,-35.60529000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_BC"),1010.90500000,-3108.50400000,-37.81529000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_BC"),1015.75500000,-3096.95400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Gems_BC"),1010.90500000,-3096.95400000,-37.81234000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_BC"),1010.90500000,-3102.804000000,-35.60529000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_BC"),1008.48000000,-3102.80400000,-35.60529000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_BC_02"),993.35510000,-3106.60400000,-37.81342000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Money_SC"),1015.75500000,-3091.604000000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Med_BC"),1026.75500000,-3106.52900000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_SC_02"),1015.75500000,-3096.95400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Tob_SC"),1010.905000000,-3091.60400000,-37.81240000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1006.05500000,-3091.60400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_pharma_SC"),1026.75500000,-3096.43400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1006.05500000,-3108.50400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Gems_SC"),1015.75500000,-3108.504000000,-37.81776000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Tob_BC"),1018.18000000,-3102.80400000,-35.75240000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Tob_BC"),1008.48000000,-3108.50400000,-35.75240000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_BC_02"),993.35510000,-3111.30400000,-37.81342000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Jewels_racks_SC"),1026.75500000,-3111.384000000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Jewels_SC"),1006.05500000,-3102.80400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_BC_02"),1013.33000000,-3096.95400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Gems_SC"),1013.33000000,1013.33000000,1013.33000000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Jewels_BC"),1026.75500000,-3108.889000000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_SC_02"),993.35510000,-3108.95400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1008.48000000,-3091.60400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_SC"),993.35510000,-3108.95400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_XLDiam"),1026.75500000,-3094.01400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_watch"),1013.33000000,-3102.80400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_SHide"),1018.18000000,-3096.95400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Oegg"),1006.05500000,-3091.60400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_MiniG"),1018.18000000,-3108.50400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_FReel"),11008.48000000,-3102.80400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_SC"),1006.05500000,-3091.60400000,-37.81985000,false,false,false) 
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_BC_02"),1026.75500000,-3091.59400000,-39.99757,false,false,false)

	local tool1 = CreateObject(-573669520,1022.6115112305,-3107.1694335938,-39.999912261963,false,false,false)
	local tool2 = CreateObject(-573669520,1022.5317382813,-3095.3305664063,-39.999912261963,false,false,false)
	local tool3 = CreateObject(-573669520,996.60125732422,-3099.2927246094,-39.999923706055,false,false,false)
	local tool4 = CreateObject(-573669520,1002.0411987305,-3108.3645019531,-39.999897003174,false,false,false)

	SetEntityHeading(tool1,GetEntityHeading(tool1)-130)
	SetEntityHeading(tool2,GetEntityHeading(tool2)-40)
	SetEntityHeading(tool3,GetEntityHeading(tool3)+90)
	SetEntityHeading(tool4,GetEntityHeading(tool4)-90)
end

RegisterNetEvent("pepe-recycling:removeWarehouseProps")
AddEventHandler("pepe-recycling:removeWarehouseProps", function()
    CleanUpArea()
end)

function CleanUpArea()
    local playerped = PlayerPedId()
    local plycoords = GetEntityCoords(playerped)
    local handle, ObjectFound = FindFirstObject()
    local success
    repeat
        local pos = GetEntityCoords(ObjectFound)
        local distance = GetDistanceBetweenCoords(plycoords, pos, true)
        if distance < 50.0 and ObjectFound ~= playerped then
        	if IsEntityAPed(ObjectFound) then
        		if IsPedAPlayer(ObjectFound) then
        		else
        			DeleteObject(ObjectFound)
        		end
        	else
        		if not IsEntityAVehicle(ObjectFound) and not IsEntityAttached(ObjectFound) then
	        		DeleteObject(ObjectFound)
	        	end
        	end            
        end
        success, ObjectFound = FindNextObject(handle)
    until not success
    SetEntityAsNoLongerNeeded(handle)
    DeleteEntity(handle)    
    EndFindObject(handle)
end



local carryPackage = nil
---- Enter And Exit Markers (Only Edit This If you Know What You're Doing lol)
local onDuty = false


Citizen.CreateThread(function ()
    while true do
        local sleep = 1000
        --print(NearRecycleStatus)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local pos = GetEntityCoords(PlayerPedId(), true)
        NearRecycleStatus = false
        
        local distoutside = #(pos - Config['delivery'].OutsideLocation)
        local distinside = #(pos - Config['delivery'].InsideLocation)
        local distduty = #(pos - vector3(995.38, -3096.27, -39.0))
        
        if distoutside <= 3 then
            sleep = 5
            local ClockTime = GetClockHours()
            if (ClockTime >= Config.OpenHour and ClockTime < 24) or (ClockTime <= Config.CloseHour -1 and ClockTime > 0) then
                    DrawText3D(Config['delivery'].OutsideLocation.x, Config['delivery'].OutsideLocation.y, Config['delivery'].OutsideLocation.z + 0.5, _U("enter"))
                    NearRecycleStatus = true

                        if IsControlJustReleased(0, Keys["E"]) then
                            renderPropsWhereHouse()
                            DoScreenFadeOut(500)
                            while not IsScreenFadedOut() do
                                Citizen.Wait(10)
                            end
                            SetEntityCoords(PlayerPedId(), Config['delivery'].InsideLocation.x, Config['delivery'].InsideLocation.y, Config['delivery'].InsideLocation.z)
                            DoScreenFadeIn(500)
                        end
            else 
                Framework.Functions.DrawText3D(Config['delivery'].OutsideLocation.x,Config['delivery'].OutsideLocation.y, Config['delivery'].OutsideLocation.z, _U("closed") .."" .. Config.OpenHour ..":00")
            end
        end
    
    if distinside <= 2 and not onDuty then
        sleep = 5
        -- DrawMarker(25, Config['delivery'].InsideLocation.x, Config['delivery'].InsideLocation.y, Config['delivery'].InsideLocation.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5001, 98, 102, 185,100, 0, 0, 0,0)
        Framework.Functions.DrawText3D(Config['delivery'].InsideLocation.x, Config['delivery'].InsideLocation.y, Config['delivery'].InsideLocation.z + 1, _U("exit"))
        if IsControlJustReleased(0, Keys["E"]) then
            TriggerEvent('pepe-recycling:removeWarehouseProps')
            DoScreenFadeOut(500)
            while not IsScreenFadedOut() do
                Citizen.Wait(10)
            end
            SetEntityCoords(PlayerPedId(), Config['delivery'].OutsideLocation.x, Config['delivery'].OutsideLocation.y, Config['delivery'].OutsideLocation.z + 1)
            DoScreenFadeIn(500)
        end
    end

    if distduty <= 2 and CarryPackage == nil then
        sleep = 5
                if onDuty then
                    Framework.Functions.DrawText3D(995.38,-3096.27,-39.0 +0.5, _U("offduty"))
                else
                    Framework.Functions.DrawText3D(995.38,-3096.27,-39.0 +0.5, _U("induty"))
                end

                if IsControlJustReleased(0, Keys["E"]) then
                    onDuty = not onDuty
                    if onDuty then
                        --TriggerEvent('DoLongHudText', _U("offduty1"), 1)
                    else
                        --TriggerEvent('DoLongHudText', _U("offduty2"), 1)
                    end
                end
    end
    
    Citizen.Wait(sleep)
end
end)

local recycleOut = { ['x'] = 992.65,['y'] = -3097.89,['z'] = -38.99,['h'] = 242.93 }
local recycleIn = { ['x'] = 746.78,['y'] = -1399.44,['z'] = 26.61,['h'] = 180.55 }
local officeOut = { ['x'] = 1173.77,['y'] = -3196.58,['z'] = -39.00,['h'] = 91.61 }
local officeIn = { ['x'] = 997.76,['y'] = -3091.90,['z'] = -38.99,['h'] = 270.76 }

Citizen.CreateThread(function()
    while true do
	    Citizen.Wait(1)
        if isLoggedIn and Framework ~= nil then

	    local dropOff = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),recycleOut["x"],recycleOut["y"],recycleOut["z"],true)
	    local dropOff2 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),recycleIn["x"],recycleIn["y"],recycleIn["z"],true)
	    local dropOff3 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),officeOut["x"],officeOut["y"],officeOut["z"],true)
	    local dropOff5 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),officeIn["x"],officeIn["y"],officeIn["z"],true)
        --if PlayerJob.name == "recycling" then

            if dropOff3 < 0.7 then
                DrawText3D(officeOut["x"],officeOut["y"],officeOut["z"], _U("exit")) 
                if IsControlJustReleased(0,38) then
                    onDuty =true
					SetEntityCoords(PlayerPedId(),officeIn["x"],officeIn["y"],officeIn["z"])
					SetEntityHeading(PlayerPedId(), officeIn["h"])
					Citizen.Wait(1000)
				end
			end
    	if dropOff > 1.0 and dropOff2 > 2.0 and dropOff3 > 2.0 and dropOff5 > 2.0 then
	    	Citizen.Wait(1000)
	    end
    end
--end
end
end)


Citizen.CreateThread(function()
    while true do
	    Citizen.Wait(3)
        if isLoggedIn and Framework ~= nil then

    
	    local dropOff = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),recycleOut["x"],recycleOut["y"],recycleOut["z"],true)
	    local dropOff2 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),recycleIn["x"],recycleIn["y"],recycleIn["z"],true)
	    local dropOff3 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),officeOut["x"],officeOut["y"],officeOut["z"],true)
	    local dropOff5 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),officeIn["x"],officeIn["y"],officeIn["z"],true)
        -- if dropOff <= 10.5 or dropOff2 <= 10.5 or dropOff3 <= 10.5 or dropOff5 <= 10.5 then

        --     Citizen.Wait(6)
        --   else
            
        --     Citizen.Wait(100)
        --   end

        --if PlayerJob.name == "recycling" then

            if dropOff5 < 0.7 then
                    Framework.Functions.DrawText3D(officeIn["x"],officeIn["y"],officeIn["z"], _U("enterrecycle")) 
                    if IsControlJustReleased(0,38) then
                        onDuty =false
                        SetEntityCoords(PlayerPedId(),officeOut["x"],officeOut["y"],officeOut["z"])
                        SetEntityHeading(PlayerPedId(), officeOut["h"])
                        Citizen.Wait(1000)
				end
            end
        --end
    end
    end
    	if dropOff > 1.0 and dropOff2 > 2.0 and dropOff3 > 2.0 and dropOff5 > 2.0 then
	    	Citizen.Wait(1000)
	    end
end)


local packagePos = nil

--
Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(3)
        if onDuty then
            if packagePos ~= nil then
                local pos = GetEntityCoords(PlayerPedId(), true)
                if carryPackage == nil then
                    if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, packagePos.x,packagePos.y,packagePos.z, true) < 2.3 then
                        Framework.Functions.DrawText3D(packagePos.x,packagePos.y,packagePos.z+ 1, _U("grab"))
                        if IsControlJustReleased(0, Keys["E"]) then
                            TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
                            Framework.Functions.Progressbar("pickup_reycle_package", _U("grabbing"), 5000, false, true, {}, {}, {}, {}, function() -- Done
                                ClearPedTasks(PlayerPedId())
                                PickupPackage()
                            end)
                        end
                    else
                        Framework.Functions.DrawText3D(packagePos.x, packagePos.y, packagePos.z + 1, "Package")
                    end
                else
                    if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config['delivery'].DropLocation.x, Config['delivery'].DropLocation.y, Config['delivery'].DropLocation.z, true) < 2.0 then
                        Framework.Functions.DrawText3D(Config['delivery'].DropLocation.x, Config['delivery'].DropLocation.y, Config['delivery'].DropLocation.z, _U("deliver"))
                        if IsControlJustReleased(0, Keys["E"]) then
                            DropPackage()
                            ScrapAnim()
                            
                                TriggerEvent('pepe-inventory:client:set:busy', true)
                            Framework.Functions.Progressbar("deliver_reycle_package", _U("placing"), 5000, false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {}, {}, {}, function() -- Done
                                StopAnimTask(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 1.0)
                                TriggerServerEvent('pepe-recycle:getrecyclablematerial')
                                GetRandomPackage()
                                TriggerEvent('pepe-inventory:client:set:busy', false)
                            end)
                        end
                    else
                        Framework.Functions.DrawText3D(Config['delivery'].DropLocation.x, Config['delivery'].DropLocation.y, Config['delivery'].DropLocation.z, _U("handin"))
                    end
                end
            else
                GetRandomPackage()
            end
        end
    end
end)






function GetRandomPackage()
    local randSeed = math.random(1, #Config["delivery"].PackagePickupLocations)
    packagePos = {}
    packagePos.x = Config["delivery"].PackagePickupLocations[randSeed].x
    packagePos.y = Config["delivery"].PackagePickupLocations[randSeed].y
    packagePos.z = Config["delivery"].PackagePickupLocations[randSeed].z
end




--Job Actions over Here


Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(4)
        if isLoggedIn and Framework ~= nil then
            local pos = GetEntityCoords(PlayerPedId())
            --if PlayerJob.name == "recycling" then
                if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config['delivery'].PersonalStash.x, Config['delivery'].PersonalStash.y, Config['delivery'].PersonalStash.z, true) < 18.0) then
                    DrawMarker(2, Config['delivery'].PersonalStash.x, Config['delivery'].PersonalStash.y, Config['delivery'].PersonalStash.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config['delivery'].PersonalStash.x, Config['delivery'].PersonalStash.y, Config['delivery'].PersonalStash.z, true) < 1.5) then
                            Framework.Functions.DrawText3D(Config['delivery'].PersonalStash.x, Config['delivery'].PersonalStash.y, Config['delivery'].PersonalStash.z, "~g~E~w~ - Bulk Trade. ")
                        if IsControlJustReleased(0, Keys["E"]) then
                            ogTradeItems()
                                Menu.hidden = not Menu.hidden
                            end
                        end
                        Menu.renderGUI()
                --end
            else
                Citizen.Wait(2500)
            end
        else
            Citizen.Wait(2500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(4)
        if isLoggedIn and Framework ~= nil then
            local pos = GetEntityCoords(PlayerPedId())
            --if PlayerJob.name == "recycling" then
                if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config['delivery'].TradeItems.x, Config['delivery'].TradeItems.y, Config['delivery'].TradeItems.z, true) < 18.0) then
                    DrawMarker(2, Config['delivery'].TradeItems.x, Config['delivery'].TradeItems.y, Config['delivery'].TradeItems.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config['delivery'].TradeItems.x, Config['delivery'].TradeItems.y, Config['delivery'].TradeItems.z, true) < 1.5) then
                            Framework.Functions.DrawText3D(Config['delivery'].TradeItems.x, Config['delivery'].TradeItems.y, Config['delivery'].TradeItems.z, "~g~E~w~ - Use Stash ")
                        if IsControlJustReleased(0, Keys["E"]) then
                            ogRecycleActions2()
                                Menu.hidden = not Menu.hidden
                            end
                        end
                        Menu.renderGUI()
               -- end
            else
                Citizen.Wait(2500)
            end
        else
            Citizen.Wait(2500)
        end
    end
end)

--Job Functions over Here


function ogRecycleActions2()
    ped = PlayerPedId();
    MenuTitle = "pepe-Menu"
    ClearMenu()
    Menu.addButton("Open Personal Inventory", "OpenCompanyStash", nil)
    Menu.addButton("Close menu", "closeMenuFull", nil) 

end

function ogTradeItems()
    ped = PlayerPedId();
    MenuTitle = "pepe-Menu"
    ClearMenu()
    Menu.addButton("Exchange 10 Recyclable Materials", "TradeItems", nil)
    Menu.addButton("Exchange 100 Recyclable Materials", "TradeItemsbulk", nil)

    Menu.addButton("Close menu", "closeMenuFull", nil) 

end



function OpenCompanyStash()
    ClearMenu()
    TriggerServerEvent("pepe-inventory:server:OpenInventory", "stash", "recyclejobstash", {
        maxweight = 4000000,
        slots = 500,
    })
    TriggerEvent("pepe-inventory:client:SetCurrentStash", "recyclejobstash")
end


function TradeItems()
    ClearMenu()
TriggerServerEvent('pepe-recycle:server:TradeItems')
end

function TradeItemsbulk()
    ClearMenu()
TriggerServerEvent('pepe-recycle:server:TradeItemsBulk')
end

function closeMenuFull()
    Menu.hidden = true
    currentGarage = nil
    ClearMenu()
end

--- 3D Text Shit---

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
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end


---Animations---

function ScrapAnim()
    local time = 5
    loadAnimDict("mp_car_bomb")
    TaskPlayAnim(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic" ,3.0, 3.0, -1, 16, 0, false, false, false)
    openingDoor = true
    Citizen.CreateThread(function()
        while openingDoor do
            TaskPlayAnim(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Citizen.Wait(1000)
            time = time - 1
            if time <= 0 then
                openingDoor = false
                StopAnimTask(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 1.0)
            end
        end
    end)
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end



function PickupPackage()
    local pos = GetEntityCoords(PlayerPedId(), true)
    RequestAnimDict("anim@heists@box_carry@")
    while (not HasAnimDictLoaded("anim@heists@box_carry@")) do
        Citizen.Wait(7)
    end
    TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@" ,"idle", 5.0, -1, -1, 50, 0, false, false, false)
    local model = GetHashKey("prop_cs_cardbox_01")
    RequestModel(model)
    while not HasModelLoaded(model) do Citizen.Wait(0) end
    local object = CreateObject(model, pos.x, pos.y, pos.z, true, true, true)
    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.05, 0.1, -0.3, 300.0, 250.0, 20.0, true, true, false, true, 1, true)
    carryPackage = object
end

function DropPackage()
    ClearPedTasks(PlayerPedId())
    DetachEntity(carryPackage, true, true)
    DeleteObject(carryPackage)
    carryPackage = nil
end


function RecycleStatus()
    return NearRecycleStatus
end