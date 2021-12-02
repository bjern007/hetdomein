Framework = exports["pepe-core"]:GetCoreObject()
local PlayerData = nil

RegisterNetEvent('Framework:Client:OnPlayerLoaded')
AddEventHandler('Framework:Client:OnPlayerLoaded', function()
    Citizen.SetTimeout(1250, function()
      Framework.Functions.GetPlayerData(function(PlayerData)
        PlayerJob, onDuty = PlayerData.job, PlayerData.job.onduty 
        isLoggedIn = true 
         onDuty = PlayerData.job.onduty
     end)
    end) 
end)


RegisterNetEvent("Framework:Client:OnJobUpdate")
AddEventHandler("Framework:Client:OnJobUpdate", function(JobInfo)
	PlayerData = Framework.Functions.GetPlayerData()
	PlayerData.job = JobInfo
end)


RegisterNetEvent("pepe-vanillaunicorn:client:shop")
AddEventHandler("pepe-vanillaunicorn:client:shop", function()
    TriggerServerEvent("pepe-inventory:server:OpenInventory", "shop", "vanilla", Config.Items)
end)


RegisterNetEvent('pepe-stripclub:client:open:tray')
AddEventHandler('pepe-stripclub:client:open:tray', function(Numbers)
    TriggerServerEvent("pepe-inventory:server:OpenInventory", "stash", "stripclub"..Numbers, {maxweight = 100000, slots = 8})
    TriggerEvent("pepe-inventory:client:SetCurrentStash", "stripclub"..Numbers)
end)


RegisterNetEvent('pepe-stripclub:client:open:cigarettes')
AddEventHandler('pepe-stripclub:client:open:cigarettes', function(Numbers)
    
    TriggerServerEvent("pepe-inventory:server:OpenInventory", "shop", "sigaretten", Config.ItemsSigaretten)
end)

RegisterNetEvent('pepe-stripclub:client:call:strippers')
AddEventHandler('pepe-stripclub:client:call:strippers', function()
    Progressbar(3000,"Strippers oproepen")
    TriggerEvent("pepe-stripclub:client:strippers:spawn")
    Framework.Functions.Notify('Stripper Bitches are here!', 'success')
end)

RegisterNetEvent('pepe-stripclub:client:open:payment')
AddEventHandler('pepe-stripclub:client:open:payment', function()
  SetNuiFocus(true, true)
  SendNUIMessage({action = 'OpenPaymentStrip', payments = Config.ActivePaymentsStrip})
end)

RegisterNetEvent('pepe-stripclub:client:open:register')
AddEventHandler('pepe-stripclub:client:open:register', function()
	if isLoggedIn then
		if (PlayerJob ~= nil) and PlayerJob.name == "vanilla" then
        SetNuiFocus(true, true)
        SendNUIMessage({action = 'OpenRegisterStrip'})
        else
        Framework.Functions.Notify('Je bent niet bevoegd hiervoor.', 'error')
        end
    end
end)

RegisterNetEvent('pepe-stripclub:client:sync:register')
AddEventHandler('pepe-stripclub:client:sync:register', function(RegisterConfig)
  Config.ActivePaymentsStrip = RegisterConfig
end)

function GetActiveRegister()
    return Config.ActivePaymentsStrip
  end

function Progressbar(duration, label)
	local retval = nil
	Framework.Functions.Progressbar("stripclub", label, duration, false, false, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = false,
	}, {}, {}, {}, function()
		retval = true
	end, function()
		retval = false
	end)

	while retval == nil do
		Wait(1)
	end

	return retval
end

local stripperbitchhh = {
  { model="s_f_y_stripper_02", x=120.01853, y=-1296.789, z=29.729696, a=33.600826, animation="mini@strip_club@private_dance@idle", animationName="priv_dance_idle"},
  { model="u_m_y_staggrm_01", x=123.54811, y=-1294.89, z=29.687574, a=33.168849, animation="mini@strip_club@lap_dance@ld_girl_a_song_a_p1", animationName="ld_girl_a_song_a_p1_f"},
  { model="s_f_y_stripper_01", x=112.76908, y=-1283.036, z=28.882873, a=295.53, animation="mini@strip_club@private_dance@part2", animationName="priv_dance_p2"},
  { model="s_f_y_stripper_02", x=103.21, y=-1292.59, z=29.26, a=296.21, animation="mini@strip_club@private_dance@part1", animationName="priv_dance_p1"},
  { model="s_f_y_stripper_02", x=104.66, y=-1294.46, z=29.26, a=287.12, animation="mini@strip_club@lap_dance@ld_girl_a_song_a_p1", animationName="ld_girl_a_song_a_p1_f"},
  { model="s_f_y_stripper_01", x=102.26, y=-1289.92, z=29.26, a=292.05, animation="mini@strip_club@private_dance@idle", animationName="priv_dance_idle"},
}

RegisterNetEvent('pepe-stripclub:client:strippers:spawn')
AddEventHandler('pepe-stripclub:client:strippers:spawn', function(spawned)
	if not spawned then
			for k,v in ipairs(stripperbitchhh) do
			RequestModel(GetHashKey(v.model))
			while not HasModelLoaded(GetHashKey(v.model)) do
				Wait(0)
			end
			RequestAnimDict(v.animation)
			while not HasAnimDictLoaded(v.animation) do
				Wait(1)
			end
			local stripperbitch = CreatePed(4, GetHashKey(v.model), v.x, v.y, v.z, v.a, true, true)
			TaskSetBlockingOfNonTemporaryEvents(stripperbitch, true)
			SetPedFleeAttributes(stripperbitch, 0, 0)
			SetPedCombatAttributes(stripperbitch, 17, 1)
			SetAmbientVoiceName(stripperbitch, v.voice)
			SetPedSeeingRange(stripperbitch, 0.0)
    		SetPedHearingRange(stripperbitch, 0.0)
    		SetPedAlertness(stripperbitch, 0)
    		SetPedKeepTask(stripperbitch, true)
			SetEntityInvincible(stripperbitch, true)

			TaskPlayAnim(stripperbitch, v.animation, v.animationName, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
			SetModelAsNoLongerNeeded(GetHashKey(v.model))
		end
	end
end)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function Progressbar(duration, label)
	local retval = nil
	Framework.Functions.Progressbar("strip", label, duration, false, false, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = false,
	}, {}, {}, {}, function()
		retval = true
	end, function()
		retval = false
	end)

	while retval == nil do
		Wait(1)
	end

	return retval
end

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

RegisterNetEvent('pepe-stripclub:client:open:opslag')
AddEventHandler('pepe-stripclub:client:open:opslag', function()
    TriggerServerEvent("pepe-inventory:server:OpenInventory", "stash", "strip_opslag", {maxweight = 90000, slots = 10})
    TriggerEvent("pepe-inventory:client:SetCurrentStash", "strip_opslag")
end)


RegisterNetEvent('pepe-stripclub:client:cocktailmaken')
AddEventHandler('pepe-stripclub:client:cocktailmaken', function(Drankjez)
  Framework.Functions.TriggerCallback('pepe-stripclub:server:has:drank:items', function(Drankje)
    if Drankje then
       MaakDrankje(Drankjez)
    else
      Framework.Functions.Notify("Je mist ingredienten om dit drankje te maken..", "error")
    end
  end)
end)


function MaakDrankje(Drankjex)
    Citizen.SetTimeout(750, function()
      TriggerEvent('pepe-inventory:client:set:busy', true)
      exports['pepe-assets']:RequestAnimationDict("mini@repair")
      TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_ped" ,3.0, 3.0, -1, 8, 0, false, false, false)
      Framework.Functions.Progressbar("open-brick", Drankjex.. " Maken..", 7500, false, true, {
          disableMovement = true,
          disableCarMovement = false,
          disableMouse = false,
          disableCombat = true,
      }, {}, {}, {}, function() -- Done
          TriggerServerEvent('pepe-stripclub:server:finish:create', Drankjex)
          TriggerEvent('pepe-inventory:client:set:busy', false)
          StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_ped", 1.0)
      end, function()
          TriggerEvent('pepe-inventory:client:set:busy', false)
          Framework.Functions.Notify("Geannuleerd..", "error")
          StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_ped", 1.0)
      end)
    end)
end

RegisterNetEvent("pepe-stripclub:client:maken")
AddEventHandler("pepe-stripclub:client:maken", function()

    TriggerEvent('pepe-inventory:client:set:busy', true)
    TriggerEvent("pepe-sound:client:play", "pour-drink", 0.4)
    exports['pepe-assets']:RequestAnimationDict("amb@world_human_hang_out_street@female_hold_arm@idle_a")
    TaskPlayAnim(PlayerPedId(), "amb@world_human_hang_out_street@female_hold_arm@idle_a", "idle_a" ,3.0, 3.0, -1, 8, 0, false, false, false)
    Framework.Functions.Progressbar("open-brick", "Slushy Maken..", 6500, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('pepe-prison:server:find:reward', 'slushy')
        TriggerEvent('pepe-inventory:client:set:busy', false)
        StopAnimTask(PlayerPedId(), "amb@world_human_hang_out_street@female_hold_arm@idle_a", "idle_a", 1.0)
    end, function()
        TriggerEvent('pepe-inventory:client:set:busy', false)
        Framework.Functions.Notify("Geannuleerd..", "error")
        StopAnimTask(PlayerPedId(), "amb@world_human_hang_out_street@female_hold_arm@idle_a", "idle_a", 1.0)
    end)
  end)
  

-- Citizen.CreateThread(function()
--     while (true) do
-- 		ClearAreaOfVehicles(141.71, -1322.01, 29.21, 5.0, false, false, false, false, false);
-- 		ClearAreaOfPeds(115.12, -1285.75, 28.26, 15.0, 1)
--         Citizen.Wait(1)
--     end
-- end)

RegisterNetEvent("strippers:mail")
AddEventHandler("strippers:mail", function(mailData)
    if PlayerData and PlayerData.job.name == 'vanilla' then
        TriggerServerEvent('pepe-phone:server:sendNewMail', mailData)
    end
end)

RegisterNetEvent("strippers:updateStrippers")
AddEventHandler("strippers:updateStrippers", function(data)
    Config.Strippers['locations'] = data
end)

RegisterNetEvent("strippers:place")
AddEventHandler("strippers:place", function(index)
    local index = index ~= nil and index or GetClosestLocation()
    local location = Config.Strippers['locations'][index]
    if index and location and location['model'] == nil then
        local model = Config.Strippers['peds'][math.random(#Config.Strippers['peds'])]
        local hash = GetHashKey(model)
        local anim = 'timetable@reunited@ig_10'
        local dict = 'base_amanda'

        -- Loads model
        RequestModel(hash)
        while not HasModelLoaded(hash) do
          Wait(1)
        end
    
        -- Loads animation
        RequestAnimDict(anim)
        while not HasAnimDictLoaded(anim) do
          Wait(1)
        end
    
        -- Creates ped when everything is loaded
        local ped = CreatePed(4, hash, location.sit.x, location.sit.y, location.sit.z, location.sit[4], true, true)
        SetEntityHeading(ped, location.sit[4])
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskPlayAnim(ped,anim,dict, 8.0, 0.0, -1, 1, 0, 0, 0, 0)

        Config.Strippers['locations'][index]['model'] = model
        TriggerServerEvent("strippers:updateStrippers", Config.Strippers['locations'])
    end
end)


RegisterNetEvent('stripclub:client:stars')
AddEventHandler('stripclub:client:stars', function(source)
    -- local Xz = 108.88922
    -- local Yz = -1289.33
    -- local Zz = 27.565741
    local Xz1 = 104.47809
    local Yz1 = -1295.954
    local Zz1 = 27.760248
		if not HasNamedPtfxAssetLoaded("scr_indep_fireworks") then
			RequestNamedPtfxAsset("scr_indep_fireworks")
			while not HasNamedPtfxAssetLoaded("scr_indep_fireworks") do
				Citizen.Wait(1)
			end
		end
		SetPtfxAssetNextCall("scr_indep_fireworks")
		-- local smoke3 = StartParticleFxLoopedAtCoord("scr_indep_firework_fountain", Xz1, Yz1, Zz1 + 0.2, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

        local smoke3 = StartParticleFxLoopedAtCoord("scr_indep_firework_fountain", Xz1, Yz1, Zz1, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
        SetParticleFxLoopedAlpha(smoke3, 0.8)
		SetParticleFxLoopedColour(smoke3, 0.0, 0.0, 0.0, 0)

        Citizen.Wait(22000)
		StopParticleFxLooped(smoke3, 0)
end)


RegisterNetEvent('stripclub:client:stopvuur')
AddEventHandler('stripclub:client:stopvuur', function(source)
		StopParticleFxLooped(vuur3, 0)
		StopParticleFxLooped(vuur4, 0)
end)

RegisterNetEvent('stripclub:client:bubbles')
AddEventHandler('stripclub:client:bubbles', function(source)
    local Xz = 108.38071
    local Yz = -1287.263
    local Zz = 27.565741
		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(1)
			end
		end
		SetPtfxAssetNextCall("core")
		local smoke3 = StartParticleFxLoopedAtCoord("ent_amb_tnl_bubbles_lge", Xz, Yz, Zz + 1.2, 2.3, 69.0, 2.0, 3.8, false, false, false, false)
		SetParticleFxLoopedAlpha(smoke3, 5.8)
		SetParticleFxLoopedColour(smoke3, 255, 255, 255, 0)

        Citizen.Wait(42000)
		StopParticleFxLooped(smoke3, 0)
end)

RegisterNetEvent('vuurtje:smoke')
AddEventHandler('vuurtje:smoke', function(source)

    local Xd = 98.966918
    local Yd = -1288.833
    local Zd = 28.360248
    
    local Xe = 102.48137
    local Ye = -1294.723
    local Ze = 28.360248
    -- stage
    --left
    --1
    local StageXL1 = 106.60735
    local StageYL1 = -1286.529
    local StageZL1 = 28.160248

    local StageXL2 = 108.28424
    local StageYL2 = -1289.139
    local StageZL2 = 28.160248
    --right
    --1 
    local StageXR1 = 109.18802
    local StageYR1 = -1283.98
    local StageZR1 = 28.160248

    local StageXR2 = 111.67589
    local StageYR2 = -1288.033 
    local StageZR2 = 28.160248
		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(1)
			end
		end
		SetPtfxAssetNextCall("core")
		local smoke = StartParticleFxLoopedAtCoord("ent_amb_fbi_fire_sm", Xd, Yd, Zd + 0.2, 0.0, 0.0, 0.0, 0.8, false, false, false, false)
		SetParticleFxLoopedAlpha(smoke, 0.8)
		SetParticleFxLoopedColour(smoke, 0.0, 0.0, 0.0, 0)

		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(1)
			end
		end
		SetPtfxAssetNextCall("core")
		local smoke2 = StartParticleFxLoopedAtCoord("ent_amb_fbi_fire_sm", Xe, Ye, Ze + 0.2, 0.0, 0.0, 0.0, 0.8, false, false, false, false)
		SetParticleFxLoopedAlpha(smoke2, 0.8)
		SetParticleFxLoopedColour(smoke2, 0.0, 0.0, 0.0, 0)
        -- Citizen.Wait(142000)
		-- StopParticleFxLooped(smoke, 0)
		-- StopParticleFxLooped(smoke2, 0)


        Citizen.Wait(9000)

		StopParticleFxLooped(smoke, 0)
		StopParticleFxLooped(smoke2, 0)
        

		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(1)
			end
		end
		SetPtfxAssetNextCall("core")
		local vuur1 = StartParticleFxLoopedAtCoord("ent_amb_fbi_fire_sm", StageXL1, StageYL1, StageZL1 + 0.2, 0.0, 0.0, 0.0, 0.8, false, false, false, false)
		SetParticleFxLoopedAlpha(vuur1, 0.8)
		SetParticleFxLoopedColour(vuur1, 0.0, 0.0, 0.0, 0)

		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(1)
			end
		end

		SetPtfxAssetNextCall("core")
		local vuur2 = StartParticleFxLoopedAtCoord("ent_amb_fbi_fire_sm", StageXR1, StageYR1, StageZR1 + 0.2, 0.0, 0.0, 0.0, 0.8, false, false, false, false)
		SetParticleFxLoopedAlpha(vuur2, 0.8)
		SetParticleFxLoopedColour(vuur2, 0.0, 0.0, 0.0, 0)

        
        Citizen.Wait(8000)

		StopParticleFxLooped(vuur1, 0)
		StopParticleFxLooped(vuur2, 0)

        
		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(1)
			end
		end
		SetPtfxAssetNextCall("core")
		local vuur3 = StartParticleFxLoopedAtCoord("ent_amb_fbi_fire_sm", StageXL2, StageYL2, StageZL2 + 0.2, 0.0, 0.0, 0.0, 0.8, false, false, false, false)
		SetParticleFxLoopedAlpha(vuur3, 0.8)
		SetParticleFxLoopedColour(vuur3, 0.0, 0.0, 0.0, 0)

		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(1)
			end
		end

		SetPtfxAssetNextCall("core")
		local vuur4 = StartParticleFxLoopedAtCoord("ent_amb_fbi_fire_sm", StageXR2, StageYR2, StageZR2 + 0.2, 0.0, 0.0, 0.0, 0.8, false, false, false, false)
		SetParticleFxLoopedAlpha(vuur4, 0.8)
		SetParticleFxLoopedColour(vuur4, 0.0, 0.0, 0.0, 0)

        Citizen.Wait(88000)

		StopParticleFxLooped(vuur3, 0)
		StopParticleFxLooped(vuur4, 0)
        
end)

function GetClosestLocation()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local lastDistance = nil
    local lastLocation = nil
    for k,v in pairs(Config.Strippers['locations']) do
        local distance = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.sit.x, v.sit.y, v.sit.z, true)
        if distance < 2 and (lastDistance == nil or distance < lastDistance) then
            lastDistance = distance
            lastLocation = k
        end
    end
    
    return lastLocation
end

local CurrentDanceIndex = 1
local Dances = {
    {"mp_safehouse", "lap_dance_girl"},
    {"mini@strip_club@private_dance@idle", "priv_dance_idle"},
    {"mini@strip_club@private_dance@part3", "priv_dance_p3"},
}

CreateThread(function()
    local serverID = GetPlayerServerId(PlayerId())

    while true do
        local plyPed = PlayerPedId()
        local coords = GetEntityCoords(plyPed)
        local letSleep = true
        local k = GetClosestLocation()
        local v = Config.Strippers['locations'][k]
        if k and v then
            if v.model ~= nil and v.taken == 0 then
                local distance = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.sit.x, v.sit.y, v.sit.z, true)
                if distance < 1.5 then
                    letSleep = false
                    local msg = "Press ~p~E~w~ to interact"
                    if PlayerData and PlayerData.job.name == 'vanilla' then
                        msg = msg .. '\nPress ~p~K~w~ to change ped'
                        msg = msg .. '\nPress ~p~BACKSPACE~w~ to delete ped'
                    end
                    ShowHelpNotification(msg)
                    if IsControlJustPressed(0,38) then
                        local ped = GetClosestNPC(v.model)
                        DoScreenFadeOut(500)
                        Wait(1000)
                        ClearPedTasks(ped)
                        ClearPedTasks(PlayerPedId())
                        SetEntityCoords(ped, v.stand.x, v.stand.y, v.stand.z)
                        SetEntityHeading(ped, v.stand[4])
                        Wait(200)
                        SetEntityCoords(PlayerPedId(), v.sit.x, v.sit.y, v.sit.z)
                        SetEntityHeading(PlayerPedId(), v.sit[4])

                        -- Loads animation
                        RequestAnimDict('timetable@ron@ig_5_p3')
                        while not HasAnimDictLoaded('timetable@ron@ig_5_p3') do
                            Wait(1)
                        end

                        Wait(200)

                        Config.Strippers['locations'][k]['taken'] = serverID
                        TriggerServerEvent("strippers:updateStrippers", Config.Strippers['locations'])
                        DoScreenFadeIn(500)

                        while Config.Strippers['locations'][k]['taken'] == serverID and DoesEntityExist(ped) do
                            Wait(1)

                            DisableControlAction(0, 38, true)
                            DisableControlAction(0, 77, true)
                            DisableControlAction(0, 244, true)
                            DisableControlAction(0, 246, true)
                            DisableControlAction(0, 249, true)
                            DisableControlAction(0, 45, true)
                            DisableControlAction(0, 288, true)
                            DisableControlAction(0, 289, true)
                            DisableControlAction(0, 157, true)
                            DisableControlAction(0, 158, true)
                            DisableControlAction(0, 160, true)
                            DisableControlAction(0, 164, true)
                            DisableControlAction(0, 165, true)
                            DisableControlAction(0, 159, true)
                            DisableControlAction(0, 161, true)
                            DisableControlAction(0, 162, true)

                            local msg = "Press ~p~E~w~ to change dance (" .. CurrentDanceIndex .. "/" .. #Dances .. ")"
                            msg = msg .. '\n Press ~p~BACKSPACE~w~ to stop dance'
                            ShowHelpNotification(msg)

                            if not IsEntityPlayingAnim(PlayerPedId(), 'timetable@ron@ig_5_p3', 'ig_5_p3_base', 3) then
                                ClearPedTasks(PlayerPedId())
                                TaskPlayAnim(PlayerPedId(),'timetable@ron@ig_5_p3',"ig_5_p3_base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
                            end

                            if Dances[CurrentDanceIndex] and not IsEntityPlayingAnim(ped, Dances[CurrentDanceIndex][1], Dances[CurrentDanceIndex][2], 3) then
                                CreateThread(function()
                                    RequestAnimDict(Dances[CurrentDanceIndex][1])
                                    while not HasAnimDictLoaded(Dances[CurrentDanceIndex][1]) do
                                        Wait(100)
                                    end

                                    ClearPedTasks(ped)
                                    Wait(150)

                                    TaskPlayAnim(ped,Dances[CurrentDanceIndex][1],Dances[CurrentDanceIndex][2], 8.0, 0.0, -1, 1, 0, 0, 0, 0)
                                end)
                            end

                            if IsDisabledControlJustPressed(0,38) then
                                DoScreenFadeOut(500)
                                CurrentDanceIndex = CurrentDanceIndex == #Dances and 1 or CurrentDanceIndex+1
                                Wait(1200)
                                DoScreenFadeIn(500)
                            elseif IsDisabledControlJustPressed(0,194) then
                                ClearPedTasks(PlayerPedId())
                                StopAnimTask(PlayerPedId(), 'timetable@ron@ig_5_p3', 'ig_5_p3_base', 1.0)
                                break
                            end
                        end
                        
                        DoScreenFadeOut(500)
                        Wait(500)
                        if DoesEntityExist(ped) then
                            TriggerServerEvent("strippers:serverDeletePed", v.model, GetEntityCoords(ped))
                        end
                        
                        ClearPedTasks(PlayerPedId())
                        StopAnimTask(PlayerPedId(), 'timetable@ron@ig_5_p3', 'ig_5_p3_base', 1.0)
                        Config.Strippers['locations'][k]['taken'] = 0
                        Config.Strippers['locations'][k]['model'] = nil
                        TriggerServerEvent("strippers:updateStrippers", Config.Strippers['locations'])
                        Wait(500)
                        DoScreenFadeIn(500)
                        TriggerEvent("dpemotes:WalkCommandStart")
                    elseif PlayerData and PlayerData.job.name == 'vanilla' then
                        if IsControlJustPressed(0,194) then
                            local ped = GetClosestNPC(v.model)
                            if DoesEntityExist(ped) then
                                TriggerServerEvent("strippers:serverDeletePed", v.model, GetEntityCoords(ped))
                            end

                            ClearPedTasks(PlayerPedId())
                            Config.Strippers['locations'][k]['taken'] = 0
                            Config.Strippers['locations'][k]['model'] = nil
                            TriggerServerEvent("strippers:updateStrippers", Config.Strippers['locations'])
                        elseif IsControlJustPressed(0,311) then
                            local ped = GetClosestNPC(v.model)
                            if DoesEntityExist(ped) then
                                TriggerServerEvent("strippers:serverDeletePed", v.model, GetEntityCoords(ped))
                            end

                            Config.Strippers['locations'][k]['model'] = Config.Strippers['peds'][math.random(#Config.Strippers['peds'])]
                            local location = Config.Strippers['locations'][k]
                            local hash = location['model']
                            local anim = 'timetable@reunited@ig_10'
                            local dict = 'base_amanda'

                            -- Loads model
                            RequestModel(hash)
                            while not HasModelLoaded(hash) do
                                Wait(1)
                            end
                        
                            -- Loads animation
                            RequestAnimDict(anim)
                            while not HasAnimDictLoaded(anim) do
                                Wait(1)
                            end
                        
                            -- Creates ped when everything is loaded
                            local ped = CreatePed(2, hash, location.sit.x, location.sit.y, location.sit.z, location.sit[4], true, true)
                            SetEntityHeading(ped, location.sit[4])
                            FreezeEntityPosition(ped, true)
                            SetEntityInvincible(ped, true)
                            SetBlockingOfNonTemporaryEvents(ped, true)
                            TaskPlayAnim(ped,anim,dict, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
                            TriggerServerEvent("strippers:updateStrippers", Config.Strippers['locations'])
                        end
                    end
                end
            end
        end

        Wait(letSleep and 2000 or 1)
    end
end)

function ShowHelpNotification(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function GetClosestNPC(model, coords)
    local playerped = PlayerPedId()
    local playerCoords = coords ~= nil and coords or GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = #(playerCoords - pos)
        if not IsEntityDead(ped) and distance < 2.0 and (distanceFrom == nil or distance < distanceFrom) and (model == nil or model == GetEntityModel(ped) or GetHashKey(model) == GetEntityModel(ped)) then
            distanceFrom = distance
            rped = ped
        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return rped
end

RegisterNetEvent("strippers:clientDeletePed")
AddEventHandler("strippers:clientDeletePed", function(model, coords)
    local ped = GetClosestNPC(model, coords)
    if DoesEntityExist(ped) then
        DeleteEntity(ped)
    end
end)
RegisterNUICallback('Click', function()
    PlaySound(-1, "CLICK_BACK", "WEB_NAVIGATION_SOUNDS_PHONE", 0, 0, 1)
  end)
  
  RegisterNUICallback('ErrorClick', function()
    PlaySound(-1, "Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds", 0, 0, 1)
  end)
  
  RegisterNUICallback('AddPrice', function(data)
    TriggerServerEvent('pepe-stripclub:server:add:to:register', data.Price, data.Note)
  end)
  
  RegisterNUICallback('PayReceipt', function(data)
    TriggerServerEvent('pepe-stripclub:server:pay:receipt', data.Price, data.Note, data.Id)
  end)
  
  RegisterNUICallback('CloseNui', function()
    SetNuiFocus(false, false)
  end)