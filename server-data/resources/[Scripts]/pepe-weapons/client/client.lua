local isLoggedIn = true
local MultiplierAmount = 0
local HasDot = false
local reloading = false
-- Framework = nil
Framework = exports["pepe-core"]:GetCoreObject()
-- TriggerEvent("Framework:GetObject", function(obj) Framework = obj end)    


RegisterNetEvent('Framework:Client:OnPlayerLoaded')
AddEventHandler('Framework:Client:OnPlayerLoaded', function()
--  Citizen.SetTimeout(1250, function()
--      TriggerEvent("Framework:GetObject", function(obj) Framework = obj end)    
--      Citizen.Wait(100)
     isLoggedIn = true
--  end)
end)

-- Code

-- // Loops \\ --

Citizen.CreateThread(function()
    while true do
        if isLoggedIn then
            local inRange = false
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)

            for k, data in pairs(Config.WeaponRepairPoints) do
                local distance = GetDistanceBetweenCoords(pos, data.coords.x, data.coords.y, data.coords.z, true)

                if distance < 10 then
                    inRange = true

                    if distance < 1 then
                        if data.IsRepairing then
                            if data.RepairingData.CitizenId ~= PlayerData.citizenid then
                                Framework.Functions.DrawText3D(data.coords.x, data.coords.y, data.coords.z, 'De repairshop is momenteel ~r~niet~w~ beschikbaar..')
                            else
                                if not data.RepairingData.Ready then
                                    Framework.Functions.DrawText3D(data.coords.x, data.coords.y, data.coords.z, 'Je wapen is gerepareerd')
                                else
                                    Framework.Functions.DrawText3D(data.coords.x, data.coords.y, data.coords.z, '[E] Haal wapen terug op')
                                end
                            end
                        else
                            if CurrentWeaponData ~= nil and next(CurrentWeaponData) ~= nil then
                                if not data.RepairingData.Ready then

                                    local WeaponData = GetSelectedPedWeapon(PlayerPedId())
                                    if Config.WeaponsList[WeaponData] ~= nil and Config.WeaponsList[WeaponData]['AmmoType'] ~= nil then
                                       if Config.WeaponsList[WeaponData]['IdName'] ~= 'weapon_unarmed' then 

                                    -- local WeaponData = Framework.Shared.Weapons[GetHashKey(CurrentWeaponData.name)]
                                    local WeaponClass = (Framework.Shared.SplitStr(WeaponData.ammotype, "_")[2]):lower()
                                    Framework.Functions.DrawText3D(data.coords.x, data.coords.y, data.coords.z, '[E] Repair weapon, ~g~€ 15000~w~')
                                    if IsControlJustPressed(0, 38) then
                                        Framework.Functions.TriggerCallback('pepe-weapons:server:RepairWeapon', function(HasMoney)
                                            if HasMoney then
                                                CurrentWeaponData = {}
                                            end
                                        end, k, CurrentWeaponData)
                                    end
                                end
                            end
                                else
                                    if data.RepairingData.CitizenId ~= PlayerData.citizenid then
                                        Framework.Functions.DrawText3D(data.coords.x, data.coords.y, data.coords.z, 'De repairshop is momenteel ~r~niet~w~ beschikbaar..')
                                    else
                                        Framework.Functions.DrawText3D(data.coords.x, data.coords.y, data.coords.z, '[E] Haal wapen terug op')
                                        if IsControlJustPressed(0, 38) then
                                            TriggerServerEvent('pepe-weapons:server:TakeBackWeapon', k, data)
                                        end
                                    end
                                end
                            else
                                if data.RepairingData.CitizenId == nil then
                                    Framework.Functions.DrawText3D(data.coords.x, data.coords.y, data.coords.z, 'Je hebt geen wapen vast..')
                                elseif data.RepairingData.CitizenId == PlayerData.citizenid then
                                    Framework.Functions.DrawText3D(data.coords.x, data.coords.y, data.coords.z, '[E] Haal wapen terug op')
                                    if IsControlJustPressed(0, 38) then
                                        TriggerServerEvent('pepe-weapons:server:TakeBackWeapon', k, data)
                                    end
                                end
                            end
                        end
                    end
                end
            end

            if not inRange then
                Citizen.Wait(1000)
            end
        end
        Citizen.Wait(3)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(4)
        if isLoggedIn then
            local Weapon = GetSelectedPedWeapon(PlayerPedId())
            local WeaponBullets = GetAmmoInPedWeapon(PlayerPedId(), Weapon)
            if Config.WeaponsList[Weapon] ~= nil and Config.WeaponsList[Weapon]['AmmoType'] ~= nil then
               if Config.WeaponsList[Weapon]['IdName'] ~= 'weapon_unarmed' then 
                if IsPedShooting(PlayerPedId()) or IsPedPerformingMeleeAction(PlayerPedId()) then
                    if Config.WeaponsList[Weapon]['IdName'] == 'weapon_molotov' then
                        TriggerServerEvent('Framework:Server:RemoveItem', 'weapon_molotov', 1)
                        TriggerEvent('pepe-weapons:client:set:current:weapon', nil)
                        TriggerEvent('pepe-inventory:client:ItemBox', Framework.Shared.Items['weapon_molotov'], 'remove')
                    else
                        TriggerServerEvent("pepe-weapons:server:UpdateWeaponQuality", Config.CurrentWeaponData, 1)
                        if WeaponBullets == 1 then
                          TriggerServerEvent("pepe-weapons:server:UpdateWeaponAmmo", Config.CurrentWeaponData, 1)
                        else
                          TriggerServerEvent("pepe-weapons:server:UpdateWeaponAmmo", Config.CurrentWeaponData, tonumber(WeaponBullets))
                        end
                    end
                end
                if Config.WeaponsList[Weapon]['AmmoType'] ~= 'AMMO_FIRE' then
                  if IsPedArmed(PlayerPedId(), 6) then
                    if WeaponBullets == 1 then
                        DisableControlAction(0, 24, true) 
                        DisableControlAction(0, 257, true)
                        if IsPedInAnyVehicle(PlayerPedId(), true) then
                            SetPlayerCanDoDriveBy(PlayerId(), false)
                        end
                    else
                        EnableControlAction(0, 24, true) 
                        EnableControlAction(0, 257, true)
                        if IsPedInAnyVehicle(PlayerPedId(), true) then
                            SetPlayerCanDoDriveBy(PlayerId(), true)
                        end
                    end
                  else
                      Citizen.Wait(1000)
                  end
                end
            else
                Citizen.Wait(1000)
            end
          end
        end
    end
end)

Citizen.CreateThread(function()
   while true do
    Citizen.Wait(0)
     if isLoggedIn then
        if IsPedShooting(PlayerPedId()) and not IsPedDoingDriveby(PlayerPedId()) then
          local CurrentWapon = GetSelectedPedWeapon(PlayerPedId())
          if Config.WeaponsList[CurrentWapon] ~= nil then
              Recoil = 0
              if GetFollowPedCamViewMode() ~= 4 then
                repeat 
                    Citizen.Wait(1)
                    SetGameplayCamRelativePitch(GetGameplayCamRelativePitch() + 0.1, 0.2)
                    Recoil = Recoil + 0.1
                until Recoil >= Config.WeaponsList[CurrentWapon]['Recoil']
              else
                  repeat 
                      Citizen.Wait(1)
                      if Config.WeaponsList[CurrentWapon]['Recoil'] > 0.1 then
                          SetGameplayCamRelativePitch(GetGameplayCamRelativePitch() + 0.6, 1.2)
                          Recoil = Recoil + 0.6
                      else
                          SetGameplayCamRelativePitch(GetGameplayCamRelativePitch() + 0.016, 0.333)
                          Recoil = Recoil + 0.1
                      end
                  until Recoil >= Config.WeaponsList[CurrentWapon]['Recoil']
              end
          end
        end
    else
        Citizen.Wait(1000)
     end
   end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if isLoggedIn then
            if IsPedArmed(PlayerPedId(), 6) then
                SendNUIMessage({
                    action = "toggle",
                    show = IsPlayerFreeAiming(PlayerId()),
                })
            else
                SendNUIMessage({
                    action = "toggle",
                    show = false,
                })
                Citizen.Wait(250)
            end
        end
    end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if reloading then
        --SetPedStealthMovement(PlayerPedId(),true,"")
        DisableControlAction(0,37,true) -- disable ALT
        DisableControlAction(0,157,true) -- disable 1
        DisableControlAction(0,158,true) -- disable 2
        DisableControlAction(0,159,true) -- disable 3
        DisableControlAction(0,160,true) -- disable 4
        DisableControlAction(0,164,true) -- disable 5
        DisableControlAction(0,165,true) -- disable 6
    end
  end
end)

-- // Events \\ --

RegisterNetEvent('pepe-weapons:client:set:current:weapon')
AddEventHandler('pepe-weapons:client:set:current:weapon', function(data)
    if data ~= false then
        Config.CurrentWeaponData = data
    else
        Config.CurrentWeaponData = {}
    end
end)

RegisterNetEvent('pepe-weapons:client:set:quality')
AddEventHandler('pepe-weapons:client:set:quality', function(amount)
    if Config.CurrentWeaponData ~= nil and next(Config.CurrentWeaponData) ~= nil then
        TriggerServerEvent("pepe-weapons:server:SetWeaponQuality", Config.CurrentWeaponData, amount)
    end
end)


RegisterNetEvent("pepe-weapons:client:SyncRepairShops")
AddEventHandler("pepe-weapons:client:SyncRepairShops", function(NewData, key)
    Config.WeaponRepairPoints[key].IsRepairing = NewData.IsRepairing
    Config.WeaponRepairPoints[key].RepairingData = NewData.RepairingData
end)


RegisterNetEvent("pepe-weapons:client:EquipAttachment")
AddEventHandler("pepe-weapons:client:EquipAttachment", function(ItemData, attachment)
    local weapon = GetSelectedPedWeapon(PlayerPedId())
    local WeaponData = Config.WeaponsList[weapon]
    if weapon ~= GetHashKey("WEAPON_UNARMED") then
        WeaponData['IdName'] = WeaponData['IdName']:upper()
        if Config.WeaponAttachments[WeaponData['IdName']] ~= nil then
            if Config.WeaponAttachments[WeaponData['IdName']][attachment] ~= nil then
                TriggerServerEvent("pepe-weapons:server:EquipAttachment", ItemData, Config.CurrentWeaponData, Config.WeaponAttachments[WeaponData['IdName']][attachment])
            else
                Framework.Functions.Notify("Het wapen dat je vasthoudt, ondersteunt deze toebehoren niet.", "error")
            end
        end
    else
        Framework.Functions.Notify("Pak een wapen.", "error")
    end
end)

RegisterNetEvent('pepe-weapons:client:reload:ammo')
AddEventHandler('pepe-weapons:client:reload:ammo', function(AmmoType, AmmoName)
 local Weapon = GetSelectedPedWeapon(PlayerPedId())
 local WeaponBullets = GetAmmoInPedWeapon(PlayerPedId(), Weapon)
 if Config.WeaponsList[Weapon] ~= nil and Config.WeaponsList[Weapon]['AmmoType'] ~= nil then
 local NewAmmo = WeaponBullets + Config.WeaponsList[Weapon]['MaxAmmo']
 if Config.WeaponsList[Weapon]['AmmoType'] == AmmoType then
    if WeaponBullets <= 1 then
	reloading = true
    TriggerServerEvent('Framework:Server:RemoveItem', AmmoName, 1)
    TriggerEvent("pepe-inventory:client:ItemBox", Framework.Shared.Items[AmmoName], "remove")
        Framework.Functions.Progressbar("taking_bullets", "Herladen..", math.random(2000, 6000), false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
             -- Remove Item Trigger.
             SetAmmoInClip(PlayerPedId(), Weapon, 0)
             SetPedAmmo(PlayerPedId(), Weapon, NewAmmo)
             TriggerServerEvent("pepe-weapons:server:UpdateWeaponAmmo", Config.CurrentWeaponData, tonumber(NewAmmo))
             Framework.Functions.Notify("+ "..NewAmmo.."x kogels ("..Config.WeaponsList[Weapon]['Name']..")", "success")
             reloading = false
        end, function()
            Framework.Functions.Notify("Geannuleerd.", "error")
            
            TriggerServerEvent('Framework:Server:AddItem', AmmoName, 1)
            TriggerEvent("pepe-inventory:client:ItemBox", Framework.Shared.Items[AmmoName], "add")
				reloading = false
        end)
    else
        Framework.Functions.Notify("Je hebt al wat kogels in je pistool.", "error")
			reloading = false
    end
  end
 end
end)

RegisterNetEvent('pepe-weapons:client:set:ammo')
AddEventHandler('pepe-weapons:client:set:ammo', function(Amount)
 local Weapon = GetSelectedPedWeapon(PlayerPedId())
 local WeaponBullets = GetAmmoInPedWeapon(PlayerPedId(), Weapon)
 local NewAmmo = WeaponBullets + tonumber(Amount)
 if Config.WeaponsList[Weapon] ~= nil and Config.WeaponsList[Weapon]['AmmoType'] ~= nil then
  SetAmmoInClip(PlayerPedId(), Weapon, 0)
  SetPedAmmo(PlayerPedId(), Weapon, tonumber(NewAmmo))
  TriggerServerEvent("pepe-weapons:server:UpdateWeaponAmmo", Config.CurrentWeaponData, tonumber(NewAmmo))
  Framework.Functions.Notify("Geladen: "..Amount..'x kogels ('..Config.WeaponsList[Weapon]['Name']..')', "success", 4500)
 end
end)

RegisterNetEvent('pepe-weapons:client:remove:dot')
AddEventHandler('pepe-weapons:client:remove:dot', function()
 if not IsPlayerFreeAiming(PlayerId()) then
    SendNUIMessage({
        action = "toggle",
        show = false,
    })
 end
end)

RegisterNetEvent("pepe-weapons:client:addAttachment")
AddEventHandler("pepe-weapons:client:addAttachment", function(component)
 local weapon = GetSelectedPedWeapon(PlayerPedId())
 local WeaponData = Config.WeaponsList[weapon]
 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey(WeaponData['IdName']), GetHashKey(component))
end)

-- // Functions \\ --

function GetAmmoType(Weapon)
 if Config.WeaponsList[Weapon] ~= nil then
     return Config.WeaponsList[Weapon]['AmmoType']
 end
end