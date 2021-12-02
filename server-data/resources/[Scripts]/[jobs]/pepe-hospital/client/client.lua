local BedData = nil
local BedCam = nil
local onDuty = false
local CurrentGarage = nil
isLoggedIn = false

local InRangeIncheck = false

-- Framework = nil  

doctorCount = 0

Framework = exports["pepe-core"]:GetCoreObject()
RegisterNetEvent('Framework:Client:OnPlayerLoaded')
AddEventHandler('Framework:Client:OnPlayerLoaded', function()
    Citizen.SetTimeout(1250, function()
    -- TriggerEvent("Framework:GetObject", function(obj) Framework = obj end)    
     Citizen.Wait(250)
      Framework.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.metadata["isdead"] then
         Citizen.Wait(4500)
            local BedSomething = GetAvailableBed()
            if BedSomething ~= nil or BedSomething ~= false then
                TriggerEvent('pepe-hospital:client:send:to:bed', BedSomething)
                TriggerServerEvent("pepe-hospital:server:dead:respawn")
                SetState('death', true)
            end
        else
         SetEntityHealth(PlayerPedId(), PlayerData.metadata["health"])
        end
         isLoggedIn = true
         onDuty = PlayerData.job.onduty
         TriggerServerEvent("pepe-police:server:UpdateBlips")
		 TriggerServerEvent("pepe-hospital:server:SetDoctor")
     end)
    end) 
end)

RegisterNetEvent('Framework:Client:OnPlayerUnload')
AddEventHandler('Framework:Client:OnPlayerUnload', function()
 TriggerServerEvent('pepe-hospital:server:save:health:armor', GetEntityHealth(PlayerPedId()), GetPedArmour(PlayerPedId()))
 isLoggedIn = false
end)

RegisterNetEvent('Framework:Client:SetDuty')
AddEventHandler('Framework:Client:SetDuty', function(Onduty)
 TriggerServerEvent("pepe-police:server:UpdateBlips")
 onDuty = Onduty
 TriggerServerEvent("pepe-hospital:server:SetDoctor")
end)

RegisterNetEvent('Framework:Client:OnJobUpdate')
AddEventHandler('Framework:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    TriggerServerEvent("pepe-hospital:server:SetDoctor")
end)

-- // Loops \\ --

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3)
        if isLoggedIn then
            Citizen.Wait(20000)
            TriggerServerEvent('pepe-hospital:server:save:health:armor', GetEntityHealth(PlayerPedId()), GetPedArmour(PlayerPedId()))
        else
            Citizen.Wait(1500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3)
        if isLoggedIn then
            local PlayerCoords = GetEntityCoords(PlayerPedId())
            NearSomething = false

            if onDuty then

             if (GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, Config.Locations["Shop"][1]['X'], Config.Locations["Shop"][1]['Y'], Config.Locations["Shop"][1]['Z'], true) < 1.5) then
                 if (Framework.Functions.GetPlayerData().job.name == "ambulance") and Framework.Functions.GetPlayerData().job.onduty then
                   Framework.Functions.DrawText3D(Config.Locations["Shop"][1]['X'], Config.Locations["Shop"][1]['Y'], Config.Locations["Shop"][1]['Z'] + 0.15, _U("emscloset"))
                   DrawMarker(2, Config.Locations["Shop"][1]['X'], Config.Locations["Shop"][1]['Y'], Config.Locations["Shop"][1]['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                   NearSomething = true
                   if IsControlJustReleased(0, 38) then
                    TriggerServerEvent("pepe-inventory:server:OpenInventory", "shop", "hospital", Config.Items)
                   end
                 end
             end

             if (GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, Config.Locations["Storage"][1]['X'], Config.Locations["Storage"][1]['Y'], Config.Locations["Storage"][1]['Z'], true) < 1.5) then
                if (Framework.Functions.GetPlayerData().job.name == "ambulance") and Framework.Functions.GetPlayerData().job.onduty then
                  Framework.Functions.DrawText3D(Config.Locations["Storage"][1]['X'], Config.Locations["Storage"][1]['Y'], Config.Locations["Storage"][1]['Z'] + 0.15, _U("emsstash"))
                  DrawMarker(2, Config.Locations["Storage"][1]['X'], Config.Locations["Storage"][1]['Y'], Config.Locations["Storage"][1]['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                  NearSomething = true
                  if IsControlJustReleased(0, 38) then
                    local Other = {maxweight = 2000000, slots = 200}
                    TriggerServerEvent("pepe-inventory:server:OpenInventory", "stash", "hospital", Other)
                    TriggerEvent("pepe-inventory:client:SetCurrentStash", "hospital")
                  end
                end
             end
                         
            end

             if (GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, Config.Locations["CheckIn"]['X'], Config.Locations["CheckIn"]['Y'], Config.Locations["CheckIn"]['Z'], true) < 2.5) then
             NearSomething = true
                if doctorCount >= Config.MinimalDoctors then
                    Framework.Functions.DrawText3D(Config.Locations["CheckIn"]['X'], Config.Locations["CheckIn"]['Y'], Config.Locations["CheckIn"]['Z'] + 0.15, "Roep Arts")
                    DrawMarker(2, Config.Locations["CheckIn"]['X'], Config.Locations["CheckIn"]['Y'], Config.Locations["CheckIn"]['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                else
                    InRangeIncheck = true
                    Framework.Functions.DrawText3D(Config.Locations["CheckIn"]['X'], Config.Locations["CheckIn"]['Y'], Config.Locations["CheckIn"]['Z'] + 0.15, "Inchecken")
                    DrawMarker(2, Config.Locations["CheckIn"]['X'], Config.Locations["CheckIn"]['Y'], Config.Locations["CheckIn"]['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                end    
                if IsControlJustReleased(0, 38) then
                    if doctorCount >= Config.MinimalDoctors then
                    TriggerServerEvent("pepe-hospital:server:SendDoctorAlert")
                    Framework.Functions.Notify('Even geduld, er komt zo iemand langs', 'success')
                    Citizen.Wait(10000)
                    end    
                end
            end

            if (GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, Config.Locations['Teleporters']['ToHeli']['X'], Config.Locations['Teleporters']['ToHeli']['Y'], Config.Locations['Teleporters']['ToHeli']['Z'], true) < 1.5) then
                Framework.Functions.DrawText3D(Config.Locations['Teleporters']['ToHeli']['X'], Config.Locations['Teleporters']['ToHeli']['Y'], Config.Locations['Teleporters']['ToHeli']['Z'] + 0.15, _U("upstairs"))
                DrawMarker(2, Config.Locations['Teleporters']['ToHeli']['X'], Config.Locations['Teleporters']['ToHeli']['Y'], Config.Locations['Teleporters']['ToHeli']['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                NearSomething = true
                if IsControlJustReleased(0, 38) then
                    DoScreenFadeOut(450)
                    Citizen.Wait(450)
                    TriggerEvent("pepe-sound:client:play", "hospital-elevator", 0.25)
                    SetEntityCoords(PlayerPedId(), Config.Locations['Teleporters']['ToHospitalFirst']['X'], Config.Locations['Teleporters']['ToHospitalFirst']['Y'], Config.Locations['Teleporters']['ToHospitalFirst']['Z'])
                    Citizen.Wait(250)
                    DoScreenFadeIn(450)
                end
            end

            if (GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, Config.Locations['Teleporters']['ToHospitalFirst']['X'], Config.Locations['Teleporters']['ToHospitalFirst']['Y'], Config.Locations['Teleporters']['ToHospitalFirst']['Z'], true) < 1.5) then
                Framework.Functions.DrawText3D(Config.Locations['Teleporters']['ToHospitalFirst']['X'], Config.Locations['Teleporters']['ToHospitalFirst']['Y'], Config.Locations['Teleporters']['ToHospitalFirst']['Z'] + 0.15, _U("downstairs"))
                DrawMarker(2, Config.Locations['Teleporters']['ToHospitalFirst']['X'], Config.Locations['Teleporters']['ToHospitalFirst']['Y'], Config.Locations['Teleporters']['ToHospitalFirst']['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                NearSomething = true
                if IsControlJustReleased(0, 38) then
                    DoScreenFadeOut(450)
                    Citizen.Wait(450)
                    TriggerEvent("pepe-sound:client:play", "hospital-elevator", 0.25)
                    SetEntityCoords(PlayerPedId(), Config.Locations['Teleporters']['ToHeli']['X'], Config.Locations['Teleporters']['ToHeli']['Y'], Config.Locations['Teleporters']['ToHeli']['Z'])
                    Citizen.Wait(250)
                    DoScreenFadeIn(450)
                end
            end

            if (GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, Config.Locations['Teleporters']['ToLower']['X'], Config.Locations['Teleporters']['ToLower']['Y'], Config.Locations['Teleporters']['ToLower']['Z'], true) < 1.5) then
                Framework.Functions.DrawText3D(Config.Locations['Teleporters']['ToLower']['X'], Config.Locations['Teleporters']['ToLower']['Y'], Config.Locations['Teleporters']['ToLower']['Z'] + 0.15, _U("upstairs"))
                DrawMarker(2, Config.Locations['Teleporters']['ToLower']['X'], Config.Locations['Teleporters']['ToLower']['Y'], Config.Locations['Teleporters']['ToLower']['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                NearSomething = true
                if IsControlJustReleased(0, 38) then
                    DoScreenFadeOut(450)
                    Citizen.Wait(450)
                    TriggerEvent("pepe-sound:client:play", "hospital-elevator", 0.25)
                    SetEntityCoords(PlayerPedId(), Config.Locations['Teleporters']['ToHospitalSecond']['X'], Config.Locations['Teleporters']['ToHospitalSecond']['Y'], Config.Locations['Teleporters']['ToHospitalSecond']['Z'])
                    Citizen.Wait(250)
                    DoScreenFadeIn(450)
                end
            end
            
            if (GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, Config.Locations['Teleporters']['ToHospitalSecond']['X'], Config.Locations['Teleporters']['ToHospitalSecond']['Y'], Config.Locations['Teleporters']['ToHospitalSecond']['Z'], true) < 1.5) then
                Framework.Functions.DrawText3D(Config.Locations['Teleporters']['ToHospitalSecond']['X'], Config.Locations['Teleporters']['ToHospitalSecond']['Y'], Config.Locations['Teleporters']['ToHospitalSecond']['Z'] + 0.15, _U("downstairs"))
                DrawMarker(2, Config.Locations['Teleporters']['ToHospitalSecond']['X'], Config.Locations['Teleporters']['ToHospitalSecond']['Y'], Config.Locations['Teleporters']['ToHospitalSecond']['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                NearSomething = true
                if IsControlJustReleased(0, 38) then
                    DoScreenFadeOut(450)
                    Citizen.Wait(450)
                    TriggerEvent("pepe-sound:client:play", "hospital-elevator", 0.25)
                    SetEntityCoords(PlayerPedId(), Config.Locations['Teleporters']['ToLower']['X'], Config.Locations['Teleporters']['ToLower']['Y'], Config.Locations['Teleporters']['ToLower']['Z'])
                    Citizen.Wait(250)
                    DoScreenFadeIn(450)
                end
            end

            if not NearSomething then
                Citizen.Wait(2000)
                InRangeIncheck = false
            end

        end
    end
end)

RegisterNetEvent('pepe-hospital:client:checkin:radial')
AddEventHandler('pepe-hospital:client:checking:radial', function()
  
    local BedSomething = GetAvailableBed()
    if BedSomething ~= nil or BedSomething ~= false then
        Framework.Functions.Progressbar("lockpick-door", _U("checkinprogres"), 2500, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() 
            TriggerEvent('pepe-hospital:client:send:to:bed', BedSomething)
            TriggerServerEvent("pepe-hospital:server:hospital:respawn")
        end, function() -- Cancel
            Framework.Functions.Notify(_U("cancel"), "error")
        end)
    else
        Framework.Functions.Notify(_U("allbedstaken"), 'error')
    end

end)

RegisterNetEvent('pepe-hospital:client:SendAlert')
AddEventHandler('pepe-hospital:client:SendAlert', function(msg)
    PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
    TriggerEvent("chatMessage", "PAGER", "error", msg)
end)

RegisterNetEvent('pepe-hospital:client:SendBillEmail')
AddEventHandler('pepe-hospital:client:SendBillEmail', function(amount)
    SetTimeout(math.random(2500, 4000), function()
        local gender = "meneer"
        if Framework.Functions.GetPlayerData().charinfo.gender == 1 then
            gender = "mevrouw"
        end
        local charinfo = Framework.Functions.GetPlayerData().charinfo
        TriggerServerEvent('pepe-phone:server:sendNewMail', {
            sender = "Ziekenhuis",
            subject = "Factuur",
            message = "Beste " .. gender .. " " .. charinfo.lastname .. ",<br /><br />Hierbij ontvangt u een e-mail met de kosten van het laatste ziekenhuis bezoek.<br />De uiteindelijke kosten waren: <strong>€"..amount.."</strong><br /><br />Nog veel beterschap gewenst!",
            button = {}
        })
    end)
end)


-- // Events \\ --

RegisterNetEvent('pepe-hospital:client:SetDoctorCount')
AddEventHandler('pepe-hospital:client:SetDoctorCount', function(amount)
    doctorCount = amount
end)

RegisterNetEvent('pepe-hospital:client:revive')
AddEventHandler('pepe-hospital:client:revive', function(UseAnim, IsAdmin)
    if Config.IsDeath then
      SetState('death', false)
      SetEntityInvincible(PlayerPedId(), false)
      NetworkResurrectLocalPlayer(GetEntityCoords(PlayerPedId(), true), true, true, false)   
    end
    ResetBodyHp()
    ResetScreenAndWalk()
    ClearPedTasks(PlayerPedId())
    SetEntityHealth(PlayerPedId(), 200)
    ClearPedBloodDamage(PlayerPedId())
    SetPlayerSprint(PlayerId(), true)
     TriggerServerEvent("Framework:Server:SetMetaData", "thirst", Framework.Functions.GetPlayerData().metadata["thirst"] + 85)
     TriggerServerEvent("Framework:Server:SetMetaData", "hunger", Framework.Functions.GetPlayerData().metadata["hunger"] + 85)  

    TriggerServerEvent('pepe-hud:server:remove:stress', 100)
    TriggerEvent('pepe-police:client:set:escort:status:false')
    Framework.Functions.Notify("Je bent geholpen.", 'success')
end)

RegisterNetEvent('pepe-hospital:client:heal:closest')
AddEventHandler('pepe-hospital:client:heal:closest', function()
    local Player, Distance = Framework.Functions.GetClosestPlayer()
    local RandomTime = math.random(10000, 15000)
    if Player ~= -1 and Distance < 1.5 then
        if not IsTargetDead(GetPlayerServerId(Player)) then
           HealAnim(RandomTime)
           Framework.Functions.Progressbar("healing-citizen", _U("healcitizen"), RandomTime, false, true, {
               disableMovement = true,
               disableCarMovement = true,
               disableMouse = false,
               disableCombat = true,
           }, {}, {}, {}, function() -- Done
               TriggerServerEvent('pepe-hospital:server:heal:player', GetPlayerServerId(Player))
               Framework.Functions.Notify(_U("healciti"), "success")
           end, function() -- Cancel
               Framework.Functions.Notify(_U("cancel"), "error")
           end)
        else
            Framework.Functions.Notify(_U("citizenc"), "error")
        end
    end
end)

RegisterNetEvent('pepe-hospital:client:revive:closest')
AddEventHandler('pepe-hospital:client:revive:closest', function()
    local Player, Distance = Framework.Functions.GetClosestPlayer()
    local RandomTime = math.random(15000, 25000)
    if Player ~= -1 and Distance < 2.5 then
      if IsTargetDead(GetPlayerServerId(Player)) then
         Framework.Functions.Progressbar("hospital_revive", _U("healcitizen"), RandomTime, false, true, {
             disableMovement = false,
             disableCarMovement = false,
             disableMouse = false,
             disableCombat = true,
         }, {
             animDict = 'mini@cpr@char_a@cpr_str',
             anim = 'cpr_pumpchest',
             flags = 8,
         }, {}, {}, function() -- Done
             TriggerServerEvent('pepe-hospital:server:revive:player', GetPlayerServerId(Player))
             StopAnimTask(PlayerPedId(), 'mini@cpr@char_a@cpr_str', "exit", 1.0)
             Framework.Functions.Notify(_U("citizenc"))
         end, function() -- Cancel
             StopAnimTask(PlayerPedId(), 'mini@cpr@char_a@cpr_str', "exit", 1.0)
             Framework.Functions.Notify(_U("failed"), "error")
         end)
        else
            Framework.Functions.Notify(_U("citizenc"), "error")
        end
    end
end)

RegisterNetEvent('pepe-hospital:client:take:blood:closest')
AddEventHandler('pepe-hospital:client:take:blood:closest', function()
    local Player, Distance = Framework.Functions.GetClosestPlayer()
    local RandomTime = math.random(7500, 10500)
    if Player ~= -1 and Distance < 1.5 then
      HealAnim(RandomTime)
      Framework.Functions.Progressbar("healing-citizen", _U("takebsample"), RandomTime, false, true, {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
      }, {}, {}, {}, function() -- Done
          TriggerServerEvent('pepe-hospital:server:take:blood:player', GetPlayerServerId(Player))
          Framework.Functions.Notify(_U("samplerecieved"), "success")
      end, function() -- Cancel
          Framework.Functions.Notify(_U("cancel"), "error")
      end)
    end
end)

RegisterNetEvent('pepe-hospital:client:heal')
AddEventHandler('pepe-hospital:client:heal', function()
    local CurrentHealth = GetEntityHealth(PlayerPedId())
    local NewHealth = CurrentHealth + 15.0
    if CurrentHealth + 15.0 > 200.0 then
        NewHealth = 200.0
    end
    ResetBodyHp()
    ClearPedTasks(PlayerPedId())
    ClearPedBloodDamage(PlayerPedId())
    SetEntityHealth(PlayerPedId(), NewHealth)
end)

RegisterNetEvent('pepe-hospital:client:revive:anim')
AddEventHandler('pepe-hospital:client:revive:anim', function()
 exports['pepe-assets']:RequestAnimationDict("random@crash_rescue@help_victim_up")
 TaskPlayAnim(PlayerPedId(), "random@crash_rescue@help_victim_up", "helping_victim_to_feet_victim", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
 Citizen.Wait(1850)
 ClearPedSecondaryTask(PlayerPedId())
end)

RegisterNetEvent('pepe-hospital:client:set:bed:state')
AddEventHandler('pepe-hospital:client:set:bed:state', function(BedData, bool)
  Config.Beds[BedData]['Busy'] = bool
end)

RegisterNetEvent('pepe-hospital:client:send:to:bed')
AddEventHandler('pepe-hospital:client:send:to:bed', function(BedId)
    Citizen.SetTimeout(50, function()
        EnterBedCam(BedId)
        Framework.Functions.Notify(_U("recieving"), 'info')
        Citizen.Wait(25000)
        TriggerEvent('pepe-hospital:client:revive', false, false)
        LeaveBed()
    end)
end)

RegisterNetEvent('pepe-hospital:client:spawn:vehicle')
AddEventHandler('pepe-hospital:client:spawn:vehicle', function(VehicleName)
    if VehicleName ~= 'alifeliner' then
        local RandomCoords = Config.Locations['Garage'][CurrentGarage]['Spawns'][math.random(1, #Config.Locations['Garage'][CurrentGarage]['Spawns'])]
        local CoordTable = {x = RandomCoords['X'], y = RandomCoords['Y'], z = RandomCoords['Z'], a = RandomCoords['H']}    
        Framework.Functions.SpawnVehicle(VehicleName, function(Vehicle)
          Citizen.Wait(25)
          exports['pepe-vehiclekeys']:SetVehicleKey(GetVehicleNumberPlateText(Vehicle), true)
          exports['pepe-fuel']:SetFuelLevel(Vehicle, GetVehicleNumberPlateText(Vehicle), 100, false)
          exports['pepe-els']:SetupEmergencyVehicle(Vehicle)
          Framework.Functions.Notify(_U("dutyparked"), 'info')
          CurrentGarage = nil
         end, CoordTable, true, false)
      else
          local CoordTable = {x = 352.17, y = -587.87, z = 74.16, a = 90.57}
          Framework.Functions.SpawnVehicle('alifeliner', function(Vehicle)
           Citizen.Wait(25)
           exports['pepe-vehiclekeys']:SetVehicleKey(GetVehicleNumberPlateText(Vehicle), true)
           exports['pepe-fuel']:SetFuelLevel(Vehicle, GetVehicleNumberPlateText(Vehicle), 100, false)
           Framework.Functions.Notify(_U("helilanded"), 'info')
           CurrentGarage = nil
          end, CoordTable, true, false)
      end
end)

-- // Functions \\ --

function NearGarage()
  for k, v in pairs(Config.Locations['Garage']) do
      local PlayerCoords = GetEntityCoords(PlayerPedId())
      if (GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, v['X'], v['Y'], v['Z'], true) < 10.0) then
          CurrentGarage = k
          return true
      end
  end
end

function EnterBedCam(BedId)
    Config.IsInBed = true
    BedData = BedId
    TriggerServerEvent('pepe-hospital:server:set:bed:state', BedData, true)
    DoScreenFadeOut(1000)
    while not IsScreenFadedOut() do
        Citizen.Wait(100)
    end
    BedObject = GetClosestObjectOfType(Config.Beds[BedData]['X'], Config.Beds[BedData]['Y'], Config.Beds[BedData]['Z'], 1.0, Config.Beds[BedData]['Hash'], false, false, false)
    SetEntityCoords(PlayerPedId(), Config.Beds[BedData]['X'], Config.Beds[BedData]['Y'], Config.Beds[BedData]['Z'] + 0.02)
    Citizen.Wait(500)
    FreezeEntityPosition(PlayerPedId(), true)
    exports['pepe-assets']:RequestAnimationDict("misslamar1dead_body")
    TaskPlayAnim(PlayerPedId(), "misslamar1dead_body", "dead_idle", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
    SetEntityHeading(PlayerPedId(), Config.Beds[BedData]['H'])
    BedCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamActive(BedCam, true)
    RenderScriptCams(true, false, 1, true, true)
    AttachCamToPedBone(BedCam, PlayerPedId(), 31085, 0, 1.0, 1.0 , true)
    SetCamFov(BedCam, 100.0)
    SetCamRot(BedCam, -45.0, 0.0, GetEntityHeading(PlayerPedId()) + 180, true)
    DoScreenFadeIn(1000)
end

function LeaveBed()
    exports['pepe-assets']:RequestAnimationDict('switch@franklin@bed')
    FreezeEntityPosition(PlayerPedId(), false)
    SetEntityInvincible(PlayerPedId(), false)
    SetEntityHeading(PlayerPedId(), Config.Beds[BedData]['H'] + 90)
    TaskPlayAnim(PlayerPedId(), 'switch@franklin@bed', 'sleep_getup_rubeyes', 100.0, 1.0, -1, 8, -1, 0, 0, 0)
    Citizen.Wait(4000)
    ClearPedTasks(PlayerPedId())
    RenderScriptCams(0, true, 200, true, true)
    DestroyCam(BedCam, false)
    TriggerServerEvent('pepe-hospital:server:set:bed:state', BedData, false)
end

function HealAnim(time)
  time = time / 1000
  exports['pepe-assets']:RequestAnimationDict("weapons@first_person@aim_rng@generic@projectile@thermal_charge@")
  TaskPlayAnim(PlayerPedId(), "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor" ,3.0, 3.0, -1, 16, 0, false, false, false)
  Healing = true
  Citizen.CreateThread(function()
      while Healing do
          TaskPlayAnim(PlayerPedId(), "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
          Citizen.Wait(2000)
          time = time - 2
          if time <= 0 then
              Healing = false
              StopAnimTask(PlayerPedId(), "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)
          end
      end
  end)
end

function ResetScreenAndWalk() 
    Citizen.SetTimeout(1500, function()
        SetFlash(false, false, 450, 3000, 450)
        Citizen.Wait(350)
        ClearTimecycleModifier()
        ResetPedMovementClipset(PlayerPedId(), 0)
    end)
end

function GetAvailableBed()
    for k, v in pairs(Config.Beds) do
        if not v['Busy'] then
            return k
        end
    end
end

function RangeCheck()
    return InRangeIncheck
end
function IsTargetDead(playerId)
 local IsDead = false
  Framework.Functions.TriggerCallback('pepe-police:server:is:player:dead', function(result)
    IsDead = result
  end, playerId)
  Citizen.Wait(100)
  return IsDead
end