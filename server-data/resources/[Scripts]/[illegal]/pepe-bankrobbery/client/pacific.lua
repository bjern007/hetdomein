local Count = 0
local MoneyBag = nil
local GrabbingMoney = false
local MoneyModel = GetHashKey("hei_prop_heist_cash_pile")
local ShowedItemsPacific = false
local ShowedItemsBomb = false
local ShowedDoorItems = false

RegisterNetEvent('pepe-police:SetCopCount')
AddEventHandler('pepe-police:SetCopCount', function(Amount)
    CurrentCops = Amount
end)


RegisterNetEvent('pepe-bankrobbery:client:openVault')
AddEventHandler('pepe-bankrobbery:client:openVault', function(index)
    if index == 1 then
        local vault = GetClosestObjectOfType(253.92, 224.56, 101.88, 2.0, GetHashKey('v_ilev_bk_vaultdoor'), 0, 0, 0)
        Citizen.CreateThread(function()
            repeat
                SetEntityHeading(vault, GetEntityHeading(vault) - 0.15)
                Wait(10)
            until GetEntityHeading(vault) <= 75.0
        end)
    else
        local vault = GetClosestObjectOfType(256.518, 240.101, 101.701, 2.0, GetHashKey('ch_prop_ch_vaultdoor01x'), 0, 0, 0)
        Citizen.CreateThread(function()
            repeat
                SetEntityHeading(vault, GetEntityHeading(vault) + 0.15)
                Wait(10)
            until GetEntityHeading(vault) >= 250.0
        end)
    end
end)

RegisterNetEvent('pepe-bankrobbery:client:doorFix')
AddEventHandler('pepe-bankrobbery:client:doorFix', function(hash, heading, pos)
    local doorObject = GetClosestObjectOfType(pos, 5.0, hash, 0, 0, 0)
    Wait(250)
    SetEntityHeading(doorObject, heading)
    FreezeEntityPosition(doorObject, true)
end)



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(4)
        if LoggedIn then
            NearAnything = false
            for k, v in pairs(Config.SpecialBanks) do
                   if v['Open'] then
                    for Troll, Trolly in pairs(Config.Trollys) do
                        local Distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Trolly['Coords']['X'], Trolly['Coords']['Y'], Trolly['Coords']['Z'], true)
                        if Distance < 1.5 then
                            NearAnything = true
                            if not Trolly['Open-State'] then
                             DrawMarker(2, Trolly['Grab-Coords']['X'], Trolly['Grab-Coords']['Y'], Trolly['Grab-Coords']['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 242, 148, 41, 255, false, false, false, 1, false, false, false)
                             Framework.Functions.DrawText3D(Trolly['Grab-Coords']['X'], Trolly['Grab-Coords']['Y'], Trolly['Grab-Coords']['Z'],_U("grabmoney"))
                             if IsControlJustReleased(0, 38) then
                                GetMoneyFromTrolly(Troll)
                             end
                            end
                        end
                    end
                    for Drill, Drills in pairs(Config.DrillLocations) do
                        local Distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Drills['Coords']['X'], Drills['Coords']['Y'], Drills['Coords']['Z'], true)
                        if Distance < 1.5 then
                            NearAnything = true
                            if not Drills['Open-State'] then
                             DrawMarker(2, Drills['Coords']['X'], Drills['Coords']['Y'], Drills['Coords']['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 242, 148, 41, 255, false, false, false, 1, false, false, false)
                             Framework.Functions.DrawText3D(Drills['Coords']['X'], Drills['Coords']['Y'], Drills['Coords']['Z'],_U("grabmoney"))
                             if IsControlJustReleased(0, 38) then
                                GetDrillItems(Drill)
                             end
                            end
                        end
                    end
                   end
                   if not v['Open'] then
                        local Area = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v['Front-Door']['X'], v['Front-Door']['Y'], v['Front-Door']['Z'], true)
                        if Area < 1.3 then
                            NearAnything = true
                            -- DrawMarker(2, v['Front-Door']['X'], v['Front-Door']['Y'], v['Front-Door']['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                            if not ShowedDoorItems then
                            ShowedDoorItems = true
                            TriggerEvent('pepe-inventory:client:requiredItems', DoorItems, true)
                            end
                        end
                   end
                   if not v['Open'] then
                        local Area = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v['Hack-Door']['X'], v['Hack-Door']['Y'], v['Hack-Door']['Z'], true)
                        if Area < 1.3 then
                            NearAnything = true
                            DrawMarker(2, v['Hack-Door']['X'], v['Hack-Door']['Y'], v['Hack-Door']['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                            if not ShowedItemsPacific then
                            ShowedItemsPacific = true
                            TriggerEvent('pepe-inventory:client:requiredItems', PacificItems, true)
                            end
                        end
                   end
                   
                   if v['Open'] then
                    local Area = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v['Vault-Door']['X'], v['Vault-Door']['Y'], v['Vault-Door']['Z'], true)
                    if Area < 2.0 then
                        NearAnything = true
                        DrawMarker(2, v['Vault-Door']['X'], v['Vault-Door']['Y'], v['Vault-Door']['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                        if not ShowedItemsBomb then
                        ShowedItemsBomb = true
                        TriggerEvent('pepe-inventory:client:requiredItems', GasbombItems, true)
                        end
                    end
               end
                end
            if not NearAnything then
                Citizen.Wait(2000)
                ShowedItemsPacific = false
                ShowedItemsBomb = false
                ShowedDoorItems = false
                TriggerEvent('pepe-inventory:client:requiredItems', PacificItems, false)
                TriggerEvent('pepe-inventory:client:requiredItems', GasbombItems, false)
                TriggerEvent('pepe-inventory:client:requiredItems', DoorItems, false)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(4)
        if LoggedIn then
            if GrabbingMoney then
              TriggerServerEvent('pepe-bankrobbery:server:rob:pacific:money')
              Citizen.Wait(1000)
            end
        end
    end
end)

RegisterNetEvent('pepe-bankrobbery:client:use:black-card')
AddEventHandler('pepe-bankrobbery:client:use:black-card', function()
    for k, v in pairs(Config.SpecialBanks) do 
            if not v['Open'] then
                local Area = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v['Hack-Door']['X'], v['Hack-Door']['Y'], v['Hack-Door']['Z'], true)
                if Area < 1.35 then
                    if CurrentCops >= Config.NeededCopsPacific then
                        Framework.Functions.TriggerCallback('pepe-bankrobbery:server:HasItem', function(HasItem)
                            if HasItem then
                                Framework.Functions.TriggerCallback("pepe-bankrobbery:server:get:status", function(Status)
                                    if not Status then
                                        TriggerServerEvent('pepe-police:server:send:big:bank:alert', GetEntityCoords(PlayerPedId()), Framework.Functions.GetStreetLabel())
                                        TriggerEvent('pepe-inventory:client:set:busy', true)
                                        TriggerEvent('pepe-inventory:client:requiredItems', PacificItems, false)
                                        -- exports['minigame-phone']:ShowHack()
                                        -- exports['minigame-phone']:StartHack(math.random(1,4), 130, function(Success)
                                        --     if Success then
                                        --         TriggerEvent("utk_fingerprint:Start", 1, 1, 1, function(Outcome)
                                        --             if Outcome then
                                                        CreateTrollys()
                                                        TriggerEvent('pepe-inventory:client:requiredItems', PacificItems, false)
                                                        TriggerServerEvent('pepe-bankrobbery:server:pacific:start')
                                                        TriggerServerEvent('Framework:Server:RemoveItem', 'black-card', 1)
                                                        TriggerEvent("pepe-inventory:client:ItemBox", Framework.Shared.Items['black-card'], "remove")
                                                        TriggerEvent('pepe-inventory:client:set:busy', false)
                                                        -- PlayDoorSound()
                                        --             end
                                        --         end)
                                        --     else
                                        --         Framework.Functions.Notify(_U("failed_msg"), "error")
                                        --         TriggerEvent('pepe-inventory:client:set:busy', false)
                                        --     end
                                        --     exports['minigame-phone']:HideHack()
                                        -- end)
                                    else
                                        Framework.Functions.Notify(_U("alreadystarted"), "error")
                                    end
                                end)
                            else
                                Framework.Functions.Notify(_U("missing_msg"), "error")
                            end
                        end, "electronickit")  
                    else
                        Framework.Functions.Notify(_U("nocops"), "info")
                    end
                end
            end
    end
end)

RegisterNetEvent('explosive:UseExplosivePacific')
AddEventHandler('explosive:UseExplosivePacific', function()
-- local Positie = GetEntityCoords(PlayerPedId())
-- local dist = GetDistanceBetweenCoords(Positie.x, Positie.y, Positie.z, Config.SpecialBanks[1]["Front-Door"]["X"], Config.SpecialBanks[1]["Front-Door"]["Y"], Config.SpecialBanks[1]["Front-Door"]["Z"], true)
--     if dist < 2.8 then
--         ExplosiveRange = true
--         else
--         ExplosiveRange = false
--     end
--         if ExplosiveRange then
--          TriggerEvent('pepe-inventory:client:busy:status', true)
--          GiveWeaponToPed(PlayerPedId(), GetHashKey("weapon_stickybomb"), 1, false, true)
--          Citizen.Wait(1000)
--          TaskPlantBomb(PlayerPedId(), Positie.x, Positie.y, Positie.z, 218.5)
--          TriggerServerEvent("Framework:Server:RemoveItem", "explosive", 1)
--          TriggerServerEvent('pepe-pacific:server:DoSmokePfx')
--          TriggerEvent('pepe-inventory:client:busy:status', false)
--             local time = 7
--             local coords = GetEntityCoords(PlayerPedId())
--             while time > 0 do 
--                 Citizen.Wait(1000)
--                 time = time - 1
--             end
--          AddExplosion(Config.SpecialBanks[1]["Front-Door"]["X"], Config.SpecialBanks[1]["Front-Door"]["Y"], Config.SpecialBanks[1]["Front-Door"]["Z"], EXPLOSION_STICKYBOMB, 4.0, true, false, 20.0)
--             deuren = true
--             deuropen = true
--             TriggerServerEvent('pepe-doorlock:server:updateState', 88, false)
--         else
--             Framework.Functions.Notify(_U("cannotuse"), "error")
--         end

    Framework.Functions.Notify('Pacific Bank is nog niet te overvallen momenteel. Kom later terug!', "error")
end)

RegisterNetEvent('pepe-bankrobbery:client:use:gasbomb')
AddEventHandler('pepe-bankrobbery:client:use:gasbomb', function()
    for k, v in pairs(Config.SpecialBanks) do 
            if v['Open'] then
                local Area = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v['Vault-Door']['X'], v['Vault-Door']['Y'], v['Vault-Door']['Z'], true)
                if Area < 1.35 then
                        Framework.Functions.TriggerCallback('pepe-bankrobbery:server:HasItem', function(HasItem)
                            if HasItem then
                                Framework.Functions.TriggerCallback("pepe-bankrobbery:server:get:status", function(Status)
                                    if Status then
                                        TriggerEvent('pepe-inventory:client:set:busy', true)
                                        -- TriggerEvent('pepe-inventory:client:requiredItems', PacificItems, false)
                                        -- exports['minigame-phone']:ShowHack()
                                        -- exports['minigame-phone']:StartHack(math.random(1,4), 130, function(Success)
                                        --     if Success then
                                        --         TriggerEvent("utk_fingerprint:Start", 1, 1, 1, function(Outcome)
                                        --             if Outcome then
                                        --                 CreateTrollys()
                                        --                 TriggerServerEvent('pepe-bankrobbery:server:pacific:start:vault')
                                        --                 TriggerServerEvent('Framework:Server:RemoveItem', 'hackdevice', 1)
                                        --                 TriggerEvent("pepe-inventory:client:ItemBox", Framework.Shared.Items['hackdevice'], "remove")
                                        --                 TriggerEvent('pepe-inventory:client:set:busy', false)
                                        --                 PlayDoorSound()
                                        --             end
                                        --         end)
                                        --     else
                                        --         Framework.Functions.Notify(_U("failed_msg"), "error")
                                        --         TriggerEvent('pepe-inventory:client:set:busy', false)
                                        --     end
                                        --     exports['minigame-phone']:HideHack()
                                        -- end)
                                        TriggerServerEvent('pepe-bankrobbery:server:openVault')
                                        TriggerServerEvent('Framework:Server:RemoveItem', 'gasbomb', 1)
                                        
                                        TriggerEvent('pepe-inventory:client:set:busy', false)
                                    else
                                        TriggerEvent('pepe-inventory:client:set:busy', false)
                                        Framework.Functions.Notify(_U("alreadystarted"), "error")
                                    end
                                end)
                            else
                                Framework.Functions.Notify(_U("missing_msg"), "error")
                            end
                        end, "gasbomb")
                end
            end
    end
end)

RegisterNetEvent('pepe-bankrobbery:client:pacific:start')
AddEventHandler('pepe-bankrobbery:client:pacific:start', function()
    -- OpenPacificDoor()
    TriggerServerEvent('pepe-doorlock:server:updateState', 86, false)
    Config.SpecialBanks[1]['Open'] = true
end)

RegisterNetEvent('pepe-bankrobbery:client:clear:trollys')
AddEventHandler('pepe-bankrobbery:client:clear:trollys', function()
    Count = 0
    for k, v in pairs(Config.Trollys) do
        local ObjectOne = GetClosestObjectOfType(v["Coords"]["X"], v["Coords"]["Y"], v["Coords"]["Z"], 20.0, 269934519, false, false, false)
        local ObjectTwo = GetClosestObjectOfType(v["Coords"]["X"], v["Coords"]["Y"], v["Coords"]["Z"], 20.0, 769923921, false, false, false)
        DeleteEntity(ObjectOne)
        DeleteObject(ObjectOne)
        DeleteEntity(ObjectTwo)
        DeleteObject(ObjectTwo)
    end
    for k,v in pairs(Config.Trollys) do 
        v['Open-State'] = false
    end
end)

RegisterNetEvent('pepe-bankrobbery:client:set:trolly:state')
AddEventHandler('pepe-bankrobbery:client:set:trolly:state', function(TrollyNumber, bool)
    Config.Trollys[TrollyNumber]['Open-State'] = bool
end)

RegisterNetEvent('pepe-bankrobbery:client:set:drill:state')
AddEventHandler('pepe-bankrobbery:client:set:drill:state', function(DrillNumber, bool)
    Config.DrillLocations[DrillNumber]['Open-State'] = bool
end)

function GetDrillItems(DrillNumber)

    Framework.Functions.TriggerCallback("pepe-bankrobbery:server:HasItem", function(HasItem)
        if HasItem then           
                    TriggerServerEvent('pepe-bankrobbery:server:set:state', ClosestBank, LockerId, 'IsBusy', true)
                    PlaySoundFrontend(-1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1);
                    exports['pepe-assets']:RequestAnimationDict("anim@heists@fleeca_bank@drilling")
                    TaskPlayAnim(PlayerPedId(), 'anim@heists@fleeca_bank@drilling', 'drill_straight_idle' , 3.0, 3.0, -1, 1, 0, false, false, false)
                    exports['pepe-assets']:AddProp('Drill')
                    exports['minigame-drill']:StartDrilling(function(Success)
                       if Success then
                           exports['pepe-assets']:RemoveProp()
                        --    Framework.Functions.Notify(_U("success") .."", "success")
                           StopAnimTask(PlayerPedId(), "anim@heists@fleeca_bank@drilling", "drill_straight_idle", 1.0)
                        --    TriggerServerEvent('pepe-bankrobbery:server:random:reward', math.random(1,5))
                           TriggerServerEvent('Framework:Server:RemoveItem', "drill", 1)
                            TriggerServerEvent('pepe-bankrobbery:server:set:drill:state', DrillNumber, true)
                           
                       else
                           exports['pepe-assets']:RemoveProp()
                           Framework.Functions.Notify(_U("cancelled") .."", "error")
                           StopAnimTask(PlayerPedId(), "anim@heists@fleeca_bank@drilling", "drill_straight_idle", 1.0)
                        --    TriggerServerEvent('pepe-bankrobbery:server:set:state', ClosestBank, LockerId, 'IsBusy', false) 
                            TriggerServerEvent('pepe-bankrobbery:server:set:drill:state', DrillNumber, true)
                       end
                       
                    end)
        else
            Framework.Functions.Notify(_U("nodrill") .."", "error")
        end
        
      end, 'drill')
end

function GetMoneyFromTrolly(TrollyNumber)
    local CurrentTrolly = GetClosestObjectOfType(Config.Trollys[TrollyNumber]['Coords']['X'], Config.Trollys[TrollyNumber]['Coords']['Y'], Config.Trollys[TrollyNumber]['Coords']['Z'], 1.0, 269934519, false, false, false)
    local MoneyObject = CreateObject(MoneyModel, GetEntityCoords(PlayerPedId()), true)
    SetEntityVisible(MoneyObject, false, false)
	AttachEntityToEntity(MoneyObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
	local GrabBag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), GetEntityCoords(PlayerPedId()), true, false, false)
    local GrabOne = NetworkCreateSynchronisedScene(GetEntityCoords(CurrentTrolly), GetEntityRotation(CurrentTrolly), 2, false, false, 1065353216, 0, 1.3)
	NetworkAddPedToSynchronisedScene(PlayerPedId(), GrabOne, "anim@heists@ornate_bank@grab_cash", "intro", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(GrabBag, GrabOne, "anim@heists@ornate_bank@grab_cash", "bag_intro", 4.0, -8.0, 1)
    SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 0)
    NetworkStartSynchronisedScene(GrabOne)
    Citizen.Wait(1500)
    GrabbingMoney = true
    SetEntityVisible(MoneyObject, true, true)
    local GrabTwo = NetworkCreateSynchronisedScene(GetEntityCoords(CurrentTrolly), GetEntityRotation(CurrentTrolly), 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(PlayerPedId(), GrabTwo, "anim@heists@ornate_bank@grab_cash", "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(GrabBag, GrabTwo, "anim@heists@ornate_bank@grab_cash", "bag_grab", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(CurrentTrolly, GrabTwo, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 4.0, -8.0, 1)
    NetworkStartSynchronisedScene(GrabTwo)
    Citizen.Wait(37000)
    SetEntityVisible(MoneyObject, false, false)
    local GrabThree = NetworkCreateSynchronisedScene(GetEntityCoords(CurrentTrolly), GetEntityRotation(CurrentTrolly), 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(PlayerPedId(), GrabThree, "anim@heists@ornate_bank@grab_cash", "exit", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(GrabBag, GrabThree, "anim@heists@ornate_bank@grab_cash", "bag_exit", 4.0, -8.0, 1)
    NetworkStartSynchronisedScene(GrabThree)
    NewTrolley = CreateObject(769923921, GetEntityCoords(CurrentTrolly) + vector3(0.0, 0.0, - 0.985), true, false, false)
    SetEntityRotation(NewTrolley, GetEntityRotation(CurrentTrolly))
    GrabbingMoney = false
    TriggerServerEvent('pepe-bankrobbery:server:set:trolly:state', TrollyNumber, true)
    while not NetworkHasControlOfEntity(CurrentTrolly) do
        Citizen.Wait(1)
        NetworkRequestControlOfEntity(CurrentTrolly)
    end
    DeleteObject(CurrentTrolly)
    while DoesEntityExist(CurrentTrolly) do
        Citizen.Wait(1)
        DeleteObject(CurrentTrolly)
    end
    PlaceObjectOnGroundProperly(NewTrolley)
    Citizen.Wait(1800)
    DeleteEntity(GrabBag)
    DeleteObject(MoneyObject)
end

function CreateTrollys()
    RequestModel("hei_prop_hei_cash_trolly_01")
    for k,v in pairs(Config.Trollys) do
        Trolley = CreateObject(269934519, v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z'], 1, 0, 0)
        SetEntityHeading(Trolley, v['Coords']['H'])
	    FreezeEntityPosition(Trolley, true)
	    SetEntityInvincible(Trolley, true)
        PlaceObjectOnGroundProperly(Trolley)
    end
end

function OpenPacificDoor()
    local DoorObject = GetClosestObjectOfType(Config.SpecialBanks[1]["Bank-Door"]["X"], Config.SpecialBanks[1]["Bank-Door"]["Y"], Config.SpecialBanks[1]["Bank-Door"]["Z"], 20.0, Config.SpecialBanks[1]["Bank-Door"]["Object"], false, false, false)
    local CurrentHeading = Config.SpecialBanks[1]["Bank-Door"]['Closed'] 
    if DoorObject ~= 0 then
        Citizen.CreateThread(function()
        while true do
            if CurrentHeading ~= Config.SpecialBanks[1]["Bank-Door"]['Opend'] then
                SetEntityHeading(DoorObject, CurrentHeading - 5)
                CurrentHeading = CurrentHeading - 0.5
            else
                break
            end
            Citizen.Wait(45)
        end
     end)
    end
end

function ClosePacificDoor()
    local Object = GetClosestObjectOfType(Config.SpecialBanks[1]["Bank-Door"]["X"], Config.SpecialBanks[1]["Bank-Door"]["Y"], Config.SpecialBanks[1]["Bank-Door"]["Z"], 5.0, Config.SpecialBanks[1]["Bank-Door"]['Object'], false, false, false)
    if Object ~= 0 then
        SetEntityHeading(Object, Config.SpecialBanks[1]["Bank-Door"]['Closed'])
    end
end

function PlayDoorSound()
    repeat
      PlaySoundFrontend(-1, "OPENING", "MP_PROPERTIES_ELEVATOR_DOORS" , 1)
      Citizen.Wait(00)
      Count = Count + 1
    until Count == 3
end