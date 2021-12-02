local LoggedIn = false
local NearHack = false
local CurrentCops = nil
local HasAlertSend = false
local ExplosiveRange = false
local ExplosiveNeeded = false
Framework = exports["pepe-core"]:GetCoreObject()
  
RegisterNetEvent('Framework:Client:OnPlayerLoaded')
AddEventHandler('Framework:Client:OnPlayerLoaded', function()
    Citizen.SetTimeout(1250, function()
    --  TriggerEvent("Framework:GetObject", function(obj) Framework = obj end)    
    --    Citizen.Wait(150)
     Framework.Functions.TriggerCallback("pepe-jewellery:server:GetConfig", function(config)
      Config = config
     end)
     LoggedIn = true
    end) 
end)

RegisterNetEvent('pepe-police:SetCopCount')
AddEventHandler('pepe-police:SetCopCount', function(Amount)
    CurrentCops = Amount
end)

RegisterNetEvent('pepe-jewellery:client:set:vitrine:isopen')
AddEventHandler('pepe-jewellery:client:set:vitrine:isopen', function(CaseId, bool)
    Config.Vitrines[CaseId]["IsOpen"]= bool
end)

RegisterNetEvent('pepe-jewellery:client:set:vitrine:busy')
AddEventHandler('pepe-jewellery:client:set:vitrine:busy', function(CaseId, bool)
    Config.Vitrines[CaseId]["IsBusy"] = bool
end)

RegisterNetEvent('pepe-jewellery:client:set:cooldown')
AddEventHandler('pepe-jewellery:client:set:cooldown',function(bool)
    Config.Cooldown = bool
end)

RegisterNetEvent('pepe-jewellery:client:set:open:safes')
AddEventHandler('pepe-jewellery:client:set:open:safes', function(state)
    Config.Hacked = state
end)



Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        if Framework ~= nil then
            if GetDistanceBetweenCoords(pos, -631.39, -237.62, 38.08, true) < 9.5 then
                ExplosiveRange = true
                    local dist = GetDistanceBetweenCoords(pos, -631.39, -237.62, 38.08, true)
                    if dist < 2.5 then
                        if not ExplosiveNeeded then
                            ExplosiveNeeded = true
                        end
                    else
                        if ExplosiveNeeded then
                            ExplosiveNeeded = false
                        end
                    end
            else
                ExplosiveRange = false
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(4)
         local PlayerCoords = GetEntityCoords(GetPlayerPed(-1))
         local Distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.Locations['use-card']["Coords"]["X"], Config.Locations['use-card']["Coords"]["Y"], Config.Locations['use-card']["Coords"]["Z"], true)
         NearHack = false
         if Distance <= 1.5 then 
            NearHack = true
            DrawMarker(2, Config.Locations['use-card']["Coords"]["X"], Config.Locations['use-card']["Coords"]["Y"], Config.Locations['use-card']["Coords"]["Z"], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 3, 252, 32, 255, false, false, false, 1, false, false, false)
        end
         if not NearHack then
            Citizen.Wait(1500)
         end
    end
end)


-- Code

-- // Events \\ --

RegisterNetEvent('pepe-jewellery:explosive:UseGasBomb')
AddEventHandler('pepe-jewellery:explosive:UseGasBomb', function()
local Positie = GetEntityCoords(GetPlayerPed(-1))
	 		 deuren = false
            deuropen = false
              if CurrentCops >= Config.PoliceNeeded then
                TriggerServerEvent('pepe-jewellery:server:removegasbomb')
                TriggerEvent('pepe-inventory:client:busy:status', true)
                GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("weapon_stickybomb"), 1, false, true)
                Citizen.Wait(1200)
                TaskPlantBomb(GetPlayerPed(-1), Positie.x, Positie.y, Positie.z, 218.5)
                TriggerEvent('pepe-inventory:client:busy:status', false)
                    local time = 7
                    local coords = GetEntityCoords(GetPlayerPed(-1))
                    while time > 0 do 
                        Framework.Functions.Notify("Ontploffing over " .. time .. "..")
                        Citizen.Wait(1000)
                        time = time - 1
                    end
                    AddExplosion(-631.39, -237.62, 38.08, EXPLOSION_STICKYBOMB, 4.0, false, false, 20.0)
                    Framework.Functions.Notify("De deur is open geknald ga snel naar binnen!!", "success")
                    deuren = true
                    deuropen = true
                    TriggerServerEvent('pepe-doorlock:server:updateState', 28, false)
                      else
                       Framework.Functions.Notify("Niet genoeg agenten! ("..Config.PoliceNeeded.." Nodig)", "info")
                      end
end)


RegisterNetEvent('pepe-jewellery:client:use:card')
AddEventHandler('pepe-jewellery:client:use:card', function()
    local CurrentTime = GetClockHours()
        if NearHack then
          if CurrentTime >= 0 and CurrentTime <= 6 then
            --   if CurrentCops >= Config.PoliceNeeded then
                if not Config.Cooldown then
                    Framework.Functions.TriggerCallback('Framework:HasItem', function(HasItem)
                        if HasItem then
                            TriggerEvent('pepe-inventory:client:set:busy', true)
                            TriggerServerEvent('pepe-jewellery:server:set:cooldown', true)
                            exports['minigame-memoryminigame']:StartMinigame({
                                success = 'pepe-jewllery:event:success',
                                fail = 'pepe-jewllery:event:fail'
                            })
                        else
                            Framework.Functions.Notify("Je mist iets..", "error")
                        end
                      end, "electronickit")
                else
                  Framework.Functions.Notify("Beveiligings slot is nog actief..", "error")
                end
            --   else
            --    Framework.Functions.Notify("Niet genoeg agenten! ("..Config.PoliceNeeded.." Nodig)", "info")
            --   end
          else
              Framework.Functions.Notify("Het is nog niet de juiste tijd..", "error")
        end
    end
end)

-- // Loops \\ --

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(4)
        if LoggedIn then
            InRange = false
            local PlayerCoords = GetEntityCoords(GetPlayerPed(-1))
                local JewelleryDist = GetDistanceBetweenCoords(PlayerCoords, Config.Locations['store']["Coords"]["X"], Config.Locations['store']["Coords"]["Y"], Config.Locations['store']["Coords"]["Z"], true)
                if JewelleryDist < 30.0 then
                    if Framework.Functions.GetPlayerData().job.name ~= 'police' and Framework.Functions.GetPlayerData().job.onduty or Framework.Functions.GetPlayerData().job.name == "police" and not Framework.Functions.GetPlayerData().job.onduty then
                    for k, v in pairs(Config.Vitrines) do
                        local VitrineDist = GetDistanceBetweenCoords(PlayerCoords, Config.Vitrines[k]["Coords"]["X"], Config.Vitrines[k]["Coords"]["Y"], Config.Vitrines[k]["Coords"]["Z"], true)
                        if VitrineDist < 0.6 then
                            InRange = true
                            -- if Config.Hacked then
                            if not Config.Vitrines[k]["IsOpen"] and not Config.Vitrines[k]["IsBusy"] then
                                Framework.Functions.DrawText3D(Config.Vitrines[k]["Coords"]["X"], Config.Vitrines[k]["Coords"]["Y"], Config.Vitrines[k]["Coords"]["Z"], '~g~E~s~ - Vitrine in slaan')
                                if IsControlJustReleased(0, 38) then
                                        if not HasAlertSend then
                                            HasAlertSend = true
                                            TriggerServerEvent('pepe-police:server:send:alert:jewellery', GetEntityCoords(GetPlayerPed(-1)), Framework.Functions.GetStreetLabel())
                                         end
                                        SmashGlass(k)
                                end
                            -- else
                                -- Citizen.Wait(200)
                            -- end
                            else
                                Citizen.Wait(200)
                            end
                        end
                    end
                else
                    Citizen.Wait(500)
                end
             else
                Citizen.Wait(1500)
             end
           if not InRange then
            Citizen.Wait(500)
           end
        end
    end
end)


RegisterNetEvent('pepe-jewllery:event:success')
AddEventHandler('pepe-jewllery:event:success', function()
            TriggerServerEvent('pepe-doorlock:server:updateState', 28, false)
            TriggerServerEvent('Framework:Server:RemoveItem', 'yellow-card', 1)
            TriggerEvent("pepe-inventory:client:ItemBox", Framework.Shared.Items['yellow-card'], "remove")
            TriggerEvent('pepe-inventory:client:set:busy', false)
            TriggerServerEvent('pepe-jewellery:server:set:vitriness', true)
end)

RegisterNetEvent('pepe-jewllery:event:fail')
AddEventHandler('pepe-jewllery:event:fail', function()
            Framework.Functions.Notify("Je hebt gefaalt..", "error")
            TriggerServerEvent('pepe-jewellery:server:set:cooldown', false)
            TriggerEvent('pepe-inventory:client:set:busy', false)
            TriggerServerEvent('pepe-jewellery:server:set:vitriness', false)
end)

-- // Functions \\ --

function SmashGlass(CaseId)
    local Smashing = true
    LoadParticles()
    TriggerServerEvent('pepe-jewellery:server:set:vitrine:busy', CaseId, true)
    StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", GetEntityCoords(GetPlayerPed(-1)).x, GetEntityCoords(GetPlayerPed(-1)).y, GetEntityCoords(GetPlayerPed(-1)).z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Framework.Functions.Progressbar("smash_vitrine", "Vitrine aan het inslaan..", 15000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        Smashing = false
        TriggerServerEvent('pepe-jewellery:vitrine:reward')
        TriggerServerEvent('pepe-jewellery:server:start:reset')
        TriggerServerEvent('pepe-jewellery:server:set:vitrine:isopen', CaseId, true)
        TriggerServerEvent('pepe-jewellery:server:set:vitrine:busy', CaseId, false)
        TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
    end, function() -- Cancel
        Smashing = false
        TriggerServerEvent('pepe-jewellery:server:set:vitrine:busy', CaseId, false)
        TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
    end)
    while Smashing do
        exports['pepe-assets']:RequestAnimationDict("missheist_jewel")
        TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 3.0, 3.0, -1, 2, 0, 0, 0, 0 )
        Citizen.Wait(500)
        TriggerEvent("pepe-sound:client:play", "jewellery-glass", 0.25)
        LoadParticles()
        TriggerServerEvent('pepe-hud:server:gain:stress', math.random(1, 3))
        StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 0.6, 0).x, GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 0.6, 0).y, GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 0.6, 0).z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
        Citizen.Wait(2500)
    end
end

function LoadParticles()
 if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
    RequestNamedPtfxAsset("scr_jewelheist")
 end
 while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
    Citizen.Wait(0)
 end
 SetPtfxAssetNextCall("scr_jewelheist")
end