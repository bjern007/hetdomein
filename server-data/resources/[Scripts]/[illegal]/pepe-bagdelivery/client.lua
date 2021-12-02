Framework = nil

local Dealer = Config.SellDrugs.Dealer
local Docks = Config.SellDrugs.DocksCustomer
local EastVinewood = Config.SellDrugs.EastVinewoodCustomer
local SandyShores = Config.SellDrugs.SandyShoresCustomer
local PaletoBay = Config.SellDrugs.PaletoBayCustomer
local Type = nil
local SinglyType = nil
local AmountPayout = 1
local PlayerData = {}
local PoliceCount = 0
local Stype = nil
local Wtype = nil

SelectType = false
Wholesale = false
Singly = false
InfoWholesale = false
InfoSingly = false
HasErrand = false
RandomText = nil
RandomWholesaleText = nil
RandomSinglyText = nil
RandomSinglyNormalText = nil
RandomSinglyDruggedText = nil
RandomSinglyAttackText = nil
RandomSinglyPoliceText = nil
hasCar = false
hasParked = false
hasDrugs = false
PedhasDrugs = false
hasOpenDoor = false
wasTalked = false
scenariotype = nil
SearchingNewOrder = false



Citizen.CreateThread(function()
	while Framework == nil do
		TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)
		Citizen.Wait(200)
	end

	while Framework.Functions.GetPlayerData() == nil do
		Wait(0)
	end

	while Framework.Functions.GetPlayerData().job == nil do
		Wait(0)
	end

	PlayerData = Framework.Functions.GetPlayerData()
end)

RegisterNetEvent('Framework:Client:OnPlayerUnload')
AddEventHandler('Framework:Client:OnPlayerUnload', function()
    LoggedIn = false
end)


-- START ERRAND
Citizen.CreateThread(function()
	local pedmodel = GetHashKey(Dealer.DealerPed)
	RequestModel(pedmodel)
	while not HasModelLoaded(pedmodel) do
		Citizen.Wait(1)
	end	
	dealer = CreatePed(1, pedmodel, Dealer.Pos.x, Dealer.Pos.y, Dealer.Pos.z - 1.0, Dealer.Pos.h, false, true)
	SetBlockingOfNonTemporaryEvents(dealer, true)
	SetPedDiesWhenInjured(dealer, false)
	SetPedCanPlayAmbientAnims(dealer, true)
	SetPedCanRagdollFromPlayerImpact(dealer, false)
	SetEntityInvincible(dealer, true)
	FreezeEntityPosition(dealer, true)
    PedGuardAnim()

    local RandomText = Dealer.DealerText[math.random(1,#Dealer.DealerText)].text
    while true do

        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local coordsNPC = GetEntityCoords(dealer, false)

            if not HasErrand then
                if not SelectType then
                    if (GetDistanceBetweenCoords(coords, Dealer.Pos.x, Dealer.Pos.y, Dealer.Pos.z, true) < 8) then
                        sleep = 5
                        DrawMarker(Dealer.Type, Dealer.Pos.x, Dealer.Pos.y, Dealer.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Dealer.Size.x, Dealer.Size.y, Dealer.Size.z, Dealer.Color.r, Dealer.Color.g, Dealer.Color.b, 100, false, true, 2, false, false, false, false)
                        if (GetDistanceBetweenCoords(coords, Dealer.Pos.x, Dealer.Pos.y, Dealer.Pos.z, true) < 2) then
                            -- if PoliceCount >= Config.RequiredCops then
                                DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.0, RandomText)
                                DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[E]~s~ - Sure')
                                if IsControlJustReleased(0, Keys["E"]) then
                                    ClearPedTasks(dealer)
                                    RequestAnimDict("amb@world_human_guard_patrol@male@idle_a")
                                    while (not HasAnimDictLoaded("amb@world_human_guard_patrol@male@idle_a")) do
                                        Citizen.Wait(7)
                                    end
                                    exports['pepe-assets']:RequestAnimationDict('amb@world_human_guard_patrol@male@idle_a', function()
                                        TaskPlayAnim(dealer, 'amb@world_human_guard_patrol@male@idle_a', 'idle_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                    end)
                                    SelectType = true
                                    exports.pNotify:SendNotification({text = "<b>Dealer</b></br>Choose how you want to sell drugs", timeout = 2500})
                                end
                            -- else
                                -- DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.0, 'There is not enough Police in the city, a minimum is ~b~' ..Config.RequiredCops.. '~s~!')
                            -- end
                        end
                    end
                elseif SelectType then
                    if (GetDistanceBetweenCoords(coords, Dealer.Pos.x, Dealer.Pos.y, Dealer.Pos.z, true) < 8) then
                        sleep = 5
                        DrawMarker(Dealer.Type, Dealer.Pos.x, Dealer.Pos.y, Dealer.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Dealer.Size.x, Dealer.Size.y, Dealer.Size.z, Dealer.Color.r, Dealer.Color.g, Dealer.Color.b, 100, false, true, 2, false, false, false, false)
                        if (GetDistanceBetweenCoords(coords, Dealer.Pos.x, Dealer.Pos.y, Dealer.Pos.z, true) < 2) then
                            -- if PoliceCount >= Config.RequiredCops then
                                if not InfoWholesale and not InfoSingly then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.0, 'We have two options to sell drugs, wholesale and single, what do you prefer?')
                                    DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[E]~s~ - Wholesale | ~g~[G]~s~ - Singly')
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        InfoWholesale = true
                                    elseif IsControlJustReleased(0, Keys["G"]) then
                                        InfoSingly = true
                                    end
                                elseif InfoWholesale then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.0, 'If you want to sell your drugs in bulk, you must pay me ~r~' ..Config.VehiclePrice.. '$~s~ for the vehicle')
                                    DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[E]~s~ - We will get along | ~r~[G]~s~ - Back')
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        Framework.Functions.TriggerCallback('inside-selldrugs:checkWholesaleItems', function(cb)
                                            if cb == "hasNothing" then
                                                exports.pNotify:SendNotification({text = "<b>Dealer</b></br>You don't have enough gram to sell wholesale. A minimum of " ..Config.MinWholesaleCount.. " grams!", timeout = 2500})
                                            else
                                                Framework.Functions.TriggerCallback('inside-selldrugs:checkMoneyWholesale', function(hasMoney)
                                                if hasMoney then
                                                    InfoWholesale = false
                                                    Wholesale = true
                                                    HasErrand = true
                                                    PedGuardAnim()
                                                    Framework.Functions.SpawnVehicle(Config.WholesaleVehicle, vector3(Dealer.WholesaleVehicleSpawnPoint.x, Dealer.WholesaleVehicleSpawnPoint.y, Dealer.WholesaleVehicleSpawnPoint.z), Dealer.WholesaleVehicleSpawnPoint.h, function(vehicle)
                                                        SetVehicleNumberPlateText(vehicle, "LSS"..tostring(math.random(1000, 9999)))
                                                        SetVehicleEngineOn(vehicle, true, true)
                                                        hasCar = true
                                                        Plate = GetVehicleNumberPlateText(vehicle)
                                                    end)
                                                    WholesaleLocations = Randomize(Config.WholesaleLocations)
                                                    CreateWork(WholesaleLocations.Location)
                                                    if Type then
                                                        for i, v in ipairs(Wtype) do
                                                            SetNewWaypoint(v.x, v.y, v.z)
                                                        end
                                                    end
                                                    exports.pNotify:SendNotification({text = "<b>Dealer</b></br>You paid <b style='color: red;'>" ..Config.VehiclePrice.. "$</b> to download the errand and vehicle", timeout = 2500})
                                                    exports.pNotify:SendNotification({text = "<b>Dealer</b></br>The vehicle is waiting near the warehouse near the stairs, drive to the designated place", timeout = 7000})
                                                elseif not hasMoney then
                                                    exports.pNotify:SendNotification({text = "<b>Dealer</b></br>You don't have enough cash", timeout = 2500})
                                                end
                                                end)
                                            end
                                        end)
                                    elseif IsControlJustReleased(0, Keys["G"]) then
                                        InfoWholesale = false
                                        PedGuardAnim()
                                    end
                                elseif InfoSingly then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.0, 'I want ~r~' ..Config.CustomersFindPrice.. '$~s~ for finding customers')
                                    DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[E]~s~ - We will get along | ~r~[G]~s~ - Back')
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        Framework.Functions.TriggerCallback('inside-selldrugs:checkSinglyItems', function(cb)
                                        if cb == "hasNothing" then
                                            exports.pNotify:SendNotification({text = "<b>Dealer</b></br>You don't have drugs!", timeout = 2500})
                                        else
                                            Framework.Functions.TriggerCallback('inside-selldrugs:checkMoneySingly', function(hasMoney)
                                            if hasMoney then
                                                InfoSingly = false
                                                Singly = true
                                                HasErrand = true
                                                PedGuardAnim()
                                                SinglyLocations = Randomize(Config.SinglyLocations)
                                                CreateSinglyWork(SinglyLocations.Location)
                                                if SinglyType then
                                                    for i, v in ipairs(Stype) do
                                                        SetNewWaypoint(v.x, v.y, v.z)
                                                    end
                                                end
                                                exports.pNotify:SendNotification({text = "<b>Dealer</b></br>You paid <b style='color: red;'>" ..Config.CustomersFindPrice.. "$</b> to download the errand", timeout = 2500})
                                                exports.pNotify:SendNotification({text = "<b>Dealer</b></br>Deliver drugs to the client", timeout = 5000})
                                            elseif not hasMoney then
                                                exports.pNotify:SendNotification({text = "<b>Dealer</b></br>You don't have enough cash", timeout = 2500})
                                            end
                                            end)
                                        end
                                        end)
                                    elseif IsControlJustReleased(0, Keys["G"]) then
                                        InfoSingly = false
                                        PedGuardAnim()
                                    end
                                end
                            -- else
                                -- DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.0, 'There is not enough Police in the city, a minimum is ~b~' ..Config.RequiredCops.. '~s~!')
                            -- end
                        end
                    end
                end
            elseif HasErrand then
                if (GetDistanceBetweenCoords(coords, Dealer.Pos.x, Dealer.Pos.y, Dealer.Pos.z, true) < 8) then
                    sleep = 5
                    DrawMarker(Dealer.Type, Dealer.Pos.x, Dealer.Pos.y, Dealer.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Dealer.Size.x, Dealer.Size.y, Dealer.Size.z, Dealer.Color.r, Dealer.Color.g, Dealer.Color.b, 100, false, true, 2, false, false, false, false)
                    if (GetDistanceBetweenCoords(coords, Dealer.Pos.x, Dealer.Pos.y, Dealer.Pos.z, true) < 2) then
                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.0, 'You want to cancel drugs errand?')
                        DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~r~[E]~s~ - Unfortunately yes')
                        if IsControlJustReleased(0, Keys["E"]) then
                            if not hasCar then
                                SelectType = false
                                Singly = false
                                Wholesale = false
                                HasErrand = false
                                Type = nil
                                Stype = nil
                                Wtype = nil
                                RandomText = nil
                                RandomText = Dealer.DealerText[math.random(1,#Dealer.DealerText)].text
                                exports.pNotify:SendNotification({text = "<b>Dealer</b></br>You cancelled a drugs errand!", timeout = 2500})
                            elseif hasCar then
                                exports.pNotify:SendNotification({text = "<b>Dealer</b></br>Put the vehicle in the garage!", timeout = 2500})
                            end
                        end
                    end
                end
            end
        Citizen.Wait(sleep)
    end
end)

-- RETURN VEHICLE
Citizen.CreateThread(function()
    while true do

        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)

            if hasCar then
                if IsPedInAnyVehicle(ped, false) then
                    if (GetDistanceBetweenCoords(coords, Dealer.WholesaleVehicleSpawnPoint.x, Dealer.WholesaleVehicleSpawnPoint.y, Dealer.WholesaleVehicleSpawnPoint.z, true) < 8) then
                        sleep = 5
                        DrawMarker(Dealer.Type, Dealer.WholesaleVehicleSpawnPoint.x, Dealer.WholesaleVehicleSpawnPoint.y, Dealer.WholesaleVehicleSpawnPoint.z - 0.65, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Dealer.WholesaleVehicleSpawnPointSize.x, Dealer.WholesaleVehicleSpawnPointSize.y, Dealer.WholesaleVehicleSpawnPointSize.z, Dealer.Color.r, Dealer.Color.g, Dealer.Color.b, 100, false, true, 2, false, false, false, false)
                        if (GetDistanceBetweenCoords(coords, Dealer.WholesaleVehicleSpawnPoint.x, Dealer.WholesaleVehicleSpawnPoint.y, Dealer.WholesaleVehicleSpawnPoint.z, true) < 2.5) then
                            DrawText3Ds(Dealer.WholesaleVehicleSpawnPoint.x, Dealer.WholesaleVehicleSpawnPoint.y, Dealer.WholesaleVehicleSpawnPoint.z + 1.0, '~r~[E]~s~ - Return vehicle')
                            if IsControlJustReleased(0, Keys["E"]) then
                                if Plate == GetVehicleNumberPlateText(vehicle) then
                                    ReturnVehicle()
                                    hasCar = false
                                    Plate = nil
                                    HasErrand = false
                                    Wholesale = false
                                    SelectType = false
                                    Type = nil
                                    for i, v in ipairs(Wtype) do
                                        RemoveBlip(v.blip)
                                        DeleteEntity(v.ped)
                                    end
                                    Wtype = nil
                                else
                                    exports.pNotify:SendNotification({text = "<b>Dealer</b></br>The vehicle does not belong to you!", timeout = 2500})
                                end
                            end
                        end
                    end
                end
            end
        Citizen.Wait(sleep)
    end
end)

-- OPENING VAN DOORS
Citizen.CreateThread(function()
    while true do

        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)

            if hasCar then
                if not IsPedInAnyVehicle(ped, false) then
                    if Plate == GetVehicleNumberPlateText(vehicle) then
                        local trunkpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.0, 0)
                        if (GetDistanceBetweenCoords(coords.x, coords.y, coords.z, trunkpos.x, trunkpos.y, trunkpos.z, true) < 2) then
                            if not hasOpenDoor then
                                sleep = 5
                                DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.4, "~g~[G]~s~ - Open Doors")
                                if IsControlJustReleased(0, Keys["G"]) then
                                    exports.rprogress:Custom({
                                        Duration = 1500,
                                        Label = "You're opening the rear doors",
                                        DisableControls = {
                                            Mouse = false,
                                            Player = true,
                                            Vehicle = true
                                        }
                                    })
                                    Citizen.Wait(1500)
                                    SetVehicleDoorOpen(vehicle, 3, false, false)
                                    SetVehicleDoorOpen(vehicle, 2, false, false)
                                    hasOpenDoor = true
                                end
                            elseif hasOpenDoor then
                                if not hasDrugs then
                                    sleep = 5
                                    DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.4, "~r~[G]~s~ - Close Doors | ~g~[E]~s~ - Get drugs out of the trunk")
                                    if IsControlJustReleased(0, Keys["G"]) then
                                        exports.rprogress:Custom({
                                            Duration = 1500,
                                            Label = "You're closing the rear doors",
                                            DisableControls = {
                                                Mouse = false,
                                                Player = true,
                                                Vehicle = true
                                            }
                                        })
                                        Citizen.Wait(1500)
                                        SetVehicleDoorShut(vehicle, 3, false)
                                        SetVehicleDoorShut(vehicle, 2, false)
                                        hasOpenDoor = false
                                    elseif IsControlJustReleased(0, Keys["E"]) then
                                        Framework.Functions.TriggerCallback('inside-selldrugs:checkWholesaleItems', function(cb)
                                        if cb == "hasNothing" then
                                            exports.pNotify:SendNotification({text = "<b>Dealer</b></br>You don't have any drugs!", timeout = 2500})
                                        else
                                            exports.rprogress:Custom({
                                                Duration = 1500,
                                                Label = "You're taking drugs from the trunk...",
                                                DisableControls = {
                                                    Mouse = false,
                                                    Player = true,
                                                    Vehicle = true
                                                }
                                            })
                                            Citizen.Wait(1500)
                                            DrugsAnimObj()
                                            hasDrugs = true
                                        end
                                        end)
                                    end
                                elseif hasDrugs then
                                    sleep = 5
                                    DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.4, "~r~[E]~s~ - Put the drugs to the trunk")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        exports.rprogress:Custom({
                                            Duration = 1500,
                                            Label = "You're putting drugs to the trunk...",
                                            DisableControls = {
                                                Mouse = false,
                                                Player = true,
                                                Vehicle = true
                                            }
                                        })
                                        Citizen.Wait(1500)
                                        DeleteObject(GarbageObject)
                                        hasDrugs = false
                                    end
                                end
                            end
                        end
                    end
                end
            end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    local RandomWholesaleText = Dealer.CustomerWholesaleText[math.random(1,#Dealer.CustomerWholesaleText)].text
    while true do

    local sleep = 500
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)

            if HasErrand then
                if Wholesale then
                    if Type then
                        for i, v in ipairs(Wtype) do
                            local coordsNPC = GetEntityCoords(v.ped, false)
                            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                                sleep = 5
                                DrawMarker(Dealer.Type, v.x, v.y, v.z - 0.65, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Dealer.WholesaleVehicleSpawnPointSize.x, Dealer.WholesaleVehicleSpawnPointSize.y, Dealer.WholesaleVehicleSpawnPointSize.z, Dealer.Color.r, Dealer.Color.g, Dealer.Color.b, 100, false, true, 2, false, false, false, false)
                                if IsPedInAnyVehicle(ped, false) then
                                    if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 2.5) then
                                        if not hasParked then
                                            DrawText3Ds(v.x, v.y, v.z + 1.0, '~g~[E]~s~ - Park your vehicle')
                                            if IsControlJustReleased(0, Keys["E"]) then
                                                SetEntityCoords(vehicle, v.x, v.y, v.z)
                                                SetEntityHeading(vehicle, v.h)
                                                FreezeEntityPosition(vehicle, true)
                                                SetVehicleEngineOn(vehicle, false, false, true)
                                                TaskGoToCoordAnyMeans(v.ped, v.PedGoX, v.PedGoY, v.PedGoZ, 1.0)
                                                FreezeEntityPosition(v.ped, false)
                                                hasParked = true
                                                wasTalked = true
                                            end
                                        elseif hasParked then
                                            DrawText3Ds(v.x, v.y, v.z + 1.0, '~r~[E]~s~ - Unpark your vehicle')
                                            if IsControlJustReleased(0, Keys["E"]) then
                                                FreezeEntityPosition(vehicle, false)
                                                SetVehicleEngineOn(vehicle, true, false, true)
                                                hasParked = false
                                            end
                                        end
                                    end
                                end
                            end
                            if wasTalked then
                                if (GetDistanceBetweenCoords(coordsNPC, v.PedGoX, v.PedGoY, v.PedGoZ, true) < 0.35) then
                                    ClearPedTasks(v.ped)
                                    FreezeEntityPosition(v.ped, true)
                                    SetEntityCoords(v.ped, v.PedGoX, v.PedGoY, v.PedGoZ - 1.0)
                                    SetEntityHeading(v.ped, v.PedGoH)
                                    wasTalked = false
                                end
                            elseif not wasTalked then
                                if not hasDrugs then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.0) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.0, RandomWholesaleText)
                                        DrawText3Ds(coords.x, coords.y, coords.z + 1.0, 'Get the drugs out of the trunk')
                                    end
                                elseif hasDrugs then
                                    if not PedhasDrugs then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.0) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.0, RandomWholesaleText)
                                            DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[E]~s~ - Hand over drugs to the customer')
                                            if IsControlJustReleased(0, Keys["E"]) then
                                                Framework.Functions.TriggerCallback('inside-selldrugs:sellWholesale', function(cb)
                                                if cb == 'hasNothing' then
                                                    exports.pNotify:SendNotification({text = "<b>Dealer</b></br>You dont have any drugs, back to base and return vehicle", timeout = 5500})
                                                    DeleteObject(GarbageObject)
                                                    DeleteEntity(v.ped)
                                                    RemoveBlip(v.blip)
                                                    hasDrugs = false
                                                    PedhasDrugs = false
                                                    RandomWholesaleText = nil
                                                    RandomWholesaleText = Dealer.CustomerWholesaleText[math.random(1,#Dealer.CustomerWholesaleText)].text
                                                    SetNewWaypoint(Dealer.WholesaleVehicleSpawnPoint.x, Dealer.WholesaleVehicleSpawnPoint.y, Dealer.WholesaleVehicleSpawnPoint.z)
                                                else
                                                    exports['pepe-assets']:RequestAnimationDict('mp_common', function()
                                                        TaskPlayAnim(ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                    end)
                                                    DeleteObject(GarbageObject)
                                                    exports['pepe-assets']:RequestAnimationDict('mp_common', function()
                                                        TaskPlayAnim(v.ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                    end)
                                                    DrugsAnimObjPed()
                                                    Citizen.Wait(2500)
                                                    ClearPedTasks(v.ped)
                                                    ClearPedTasks(ped)
                                                    hasDrugs = false
                                                    Citizen.Wait(2500)
                                                    DeleteObject(GarbageObject)
                                                    DeleteEntity(v.ped)
                                                    RemoveBlip(v.blip)
                                                    PedhasDrugs = false
                                                    RandomWholesaleText = nil
                                                    RandomWholesaleText = Dealer.CustomerWholesaleText[math.random(1,#Dealer.CustomerWholesaleText)].text
                                                    exports.pNotify:SendNotification({text = "<b>Dealer</b></br>You finished the errand, return to the base to put the vehicle back", timeout = 5500})
                                                    SetNewWaypoint(Dealer.WholesaleVehicleSpawnPoint.x, Dealer.WholesaleVehicleSpawnPoint.y, Dealer.WholesaleVehicleSpawnPoint.z)
                                                end
                                                end)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 500

        if SearchingNewOrder then
            HasErrand = false
            Singly = false
            Citizen.Wait(200)
            HasErrand = true
            Singly = true
            SinglyType = nil
            Stype = nil
            SinglyLocations = Randomize(Config.SinglyLocations)
            CreateSinglyWork(SinglyLocations.Location)
            if SinglyType then
                for i, v in ipairs(Stype) do
                    SetNewWaypoint(v.x, v.y, v.z)
                end
            end
            exports.pNotify:SendNotification({text = "<b>Dealer</b></br>Found a client, meet with him", timeout = 2500})
            SearchingNewOrder = false
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    local RandomSinglyText = Dealer.CustomerSinglyText[math.random(1,#Dealer.CustomerSinglyText)].text
    while true do

    local sleep = 500
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

            if HasErrand then
                if Singly then
                    if SinglyType then
                        for i, v in ipairs(Stype) do
                            local coordsNPC = GetEntityCoords(v.ped, false)
                            if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.0) then
                                if not wasTalked then
                                    sleep = 5
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.0, RandomSinglyText)
                                    DrawText3Ds(coords.x, coords.y, coords.z + 1.0, "~g~[E]~s~ - Sell drugs to the customer")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        if not IsPedInAnyVehicle(ped, false) then
                                            sleep = 5
                                            Framework.Functions.TriggerCallback('inside-selldrugs:checkSinglyItems', function(cb)
                                            if cb == "hasNothing" then
                                                exports.pNotify:SendNotification({text = "<b>Dealer</b></br>You don't have any drugs!", timeout = 2500})
                                                DeleteEntity(v.ped)
                                                RemoveBlip(v.blip)
                                                scenariotype = nil
                                                RandomSinglyNormalText = nil
                                                RandomSinglyText = nil
                                                HasErrand = false
                                                Singly = false
                                                SinglyType = nil
                                                Stype = nil
                                                RandomSinglyText = Dealer.CustomerSinglyText[math.random(1,#Dealer.CustomerSinglyText)].text
                                            else
                                                local scenario = math.random(0, 100)
                                                if scenario > Config.NormalSellChance then -- 45% Normal Sale
                                                    exports.rprogress:Custom({
                                                        Duration = 7500,
                                                        Label = "You're talking with customer...",
                                                        DisableControls = {
                                                            Mouse = false,
                                                            Player = true,
                                                            Vehicle = true
                                                        }
                                                    })
                                                    Citizen.Wait(7500)
                                                    RandomSinglyNormalText = Dealer.CustomerSinglyNormalText[math.random(1,#Dealer.CustomerSinglyNormalText)].text
                                                    wasTalked = true
                                                    scenariotype = 'Normal'
                                                    exports['pepe-assets']:RequestAnimationDict('mp_common', function()
                                                        TaskPlayAnim(ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                    end)
                                                    exports['pepe-assets']:RequestAnimationDict('mp_common', function()
                                                        TaskPlayAnim(v.ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                    end)
                                                    Citizen.Wait(2500)
                                                    AmountPayout = 1
                                                    TriggerServerEvent('inside-selldrugs:sellSingly', AmountPayout)
                                                    FreezeEntityPosition(v.ped, false)
                                                    TaskGoToCoordAnyMeans(v.ped, v.gx, v.gy, v.gz, 1.0)
                                                    ClearPedTasks(ped)
                                                    ClearPedTasks(v.ped)
                                                    Citizen.Wait(4000)
                                                    DeleteEntity(v.ped)
                                                    RemoveBlip(v.blip)
                                                    wasTalked = false
                                                    scenariotype = nil
                                                    RandomSinglyNormalText = nil
                                                    RandomSinglyText = nil
                                                    RandomSinglyText = Dealer.CustomerSinglyText[math.random(1,#Dealer.CustomerSinglyText)].text
                                                    Framework.Functions.TriggerCallback('inside-selldrugs:checkSinglyItems', function(cb)
                                                        if cb == "hasNothing" then
                                                            exports.pNotify:SendNotification({text = "<b>Dealer</b></br>You have no more drugs, Order is done", timeout = 2500})
                                                            DeleteEntity(v.ped)
                                                            RemoveBlip(v.blip)
                                                            scenariotype = nil
                                                            RandomSinglyNormalText = nil
                                                            RandomSinglyText = nil
                                                            HasErrand = false
                                                            Singly = false
                                                            SinglyType = nil
                                                            Stype = nil
                                                            RandomSinglyText = Dealer.CustomerSinglyText[math.random(1,#Dealer.CustomerSinglyText)].text
                                                        else
                                                            exports.pNotify:SendNotification({text = "<b>Dealer</b></br>You are waiting for the dealer's order...", timeout = 2500})
                                                            Citizen.Wait(2500)
                                                            SearchingNewOrder = true
                                                        end
                                                    end)
                                                elseif scenario > Config.DruggedSellChance and scenario <= Config.NormalSellChance then -- 5% NPC is drugged and paid 2x
                                                    exports.rprogress:Custom({
                                                        Duration = 7500,
                                                        Label = "You're talking with customer...",
                                                        DisableControls = {
                                                            Mouse = false,
                                                            Player = true,
                                                            Vehicle = true
                                                        }
                                                    })
                                                    Citizen.Wait(7500)
                                                    RandomSinglyDruggedText = Dealer.CustomerSinglyDruggedText[math.random(1,#Dealer.CustomerSinglyDruggedText)].text
                                                    wasTalked = true
                                                    scenariotype = 'Drugged'
                                                    exports['pepe-assets']:RequestAnimationDict('mp_common', function()
                                                        TaskPlayAnim(ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                    end)
                                                    exports['pepe-assets']:RequestAnimationDict('mp_common', function()
                                                        TaskPlayAnim(v.ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                    end)
                                                    Citizen.Wait(2500)
                                                    AmountPayout = 2
                                                    TriggerServerEvent('inside-selldrugs:sellSingly', AmountPayout)
                                                    AmountPayout = 1
                                                    FreezeEntityPosition(v.ped, false)
                                                    TaskGoToCoordAnyMeans(v.ped, v.gx, v.gy, v.gz, 1.0)
                                                    exports.pNotify:SendNotification({text = "<b>Dealer</b></br>Customer was drugged and paid double", timeout = 5000})
                                                    ClearPedTasks(ped)
                                                    ClearPedTasks(v.ped)
                                                    Citizen.Wait(4000)
                                                    DeleteEntity(v.ped)
                                                    RemoveBlip(v.blip)
                                                    wasTalked = false
                                                    scenariotype = nil
                                                    RandomSinglyDruggedText = nil
                                                    RandomSinglyText = nil
                                                    RandomSinglyText = Dealer.CustomerSinglyText[math.random(1,#Dealer.CustomerSinglyText)].text
                                                    Framework.Functions.TriggerCallback('inside-selldrugs:checkSinglyItems', function(cb)
                                                        if cb == "hasNothing" then
                                                            exports.pNotify:SendNotification({text = "<b>Dealer</b></br>You have no more drugs, Order is done", timeout = 2500})
                                                            DeleteEntity(v.ped)
                                                            RemoveBlip(v.blip)
                                                            scenariotype = nil
                                                            RandomSinglyNormalText = nil
                                                            RandomSinglyText = nil
                                                            HasErrand = false
                                                            Singly = false
                                                            SinglyType = nil
                                                            Stype = nil
                                                            RandomSinglyText = Dealer.CustomerSinglyText[math.random(1,#Dealer.CustomerSinglyText)].text
                                                        else
                                                            exports.pNotify:SendNotification({text = "<b>Dealer</b></br>You are waiting for the dealer's order...", timeout = 2500})
                                                            Citizen.Wait(2500)
                                                            SearchingNewOrder = true
                                                        end
                                                    end)
                                                elseif scenario > Config.AttackSellChance and scenario <= Config.DruggedSellChance then -- 15% NPC robbing us
                                                    exports.rprogress:Custom({
                                                        Duration = 7500,
                                                        Label = "You're talking with customer...",
                                                        DisableControls = {
                                                            Mouse = false,
                                                            Player = true,
                                                            Vehicle = true
                                                        }
                                                    })
                                                    Citizen.Wait(7500)
                                                    RandomSinglyAttackText = Dealer.CustomerSinglyAttackText[math.random(1,#Dealer.CustomerSinglyAttackText)].text
                                                    GiveWeaponToPed(v.ped, 'weapon_pistol', 250)
                                                    SetCurrentPedWeapon(v.ped, 'weapon_pistol', true)
                                                    TaskAimGunAtEntity(v.ped, ped, -1)
                                                    wasTalked = true
                                                    scenariotype = 'Attack'
                                                    TaskHandsUp(ped, -1, v.ped)
                                                    FreezeEntityPosition(ped, true)
                                                    exports.pNotify:SendNotification({text = "<b>Dealer</b></br>Customer turned out to be a bandit!", timeout = 5000})
                                                elseif scenario > Config.PoliceSellChance and scenario <= Config.AttackSellChance then -- 35% NPC notifies the LSPD
                                                    TriggerServerEvent('inside-selldrugs:addnotifyCops', coords)
                                                    exports.rprogress:Custom({
                                                        Duration = 12500,
                                                        Label = "You're talking with customer...",
                                                        DisableControls = {
                                                            Mouse = false,
                                                            Player = true,
                                                            Vehicle = true
                                                        }
                                                    })
                                                    Citizen.Wait(12500)
                                                    RandomSinglyPoliceText = Dealer.CustomerSinglyPoliceText[math.random(1,#Dealer.CustomerSinglyPoliceText)].text
                                                    wasTalked = true
                                                    scenariotype = 'Police'
                                                    FreezeEntityPosition(v.ped, false)
                                                    FreezeEntityPosition(ped, false)
                                                    exports.pNotify:SendNotification({text = "<b>Dealer</b></br>Customer notified the police!", timeout = 5000})
                                                    TaskGoToCoordAnyMeans(v.ped, v.gx, v.gy, v.gz, 1.0)
                                                    Citizen.Wait(4000)
                                                    ClearPedTasks(ped)
                                                    ClearPedTasks(v.ped)
                                                    DeleteEntity(v.ped)
                                                    RemoveBlip(v.blip)
                                                    wasTalked = false
                                                    scenariotype = nil
                                                    RandomSinglyPoliceText = nil
                                                    RandomSinglyText = nil
                                                    RandomSinglyText = Dealer.CustomerSinglyText[math.random(1,#Dealer.CustomerSinglyText)].text
                                                    Framework.Functions.TriggerCallback('inside-selldrugs:checkSinglyItems', function(cb)
                                                        if cb == "hasNothing" then
                                                            exports.pNotify:SendNotification({text = "<b>Dealer</b></br>You have no more drugs, Order is done", timeout = 2500})
                                                            DeleteEntity(v.ped)
                                                            RemoveBlip(v.blip)
                                                            scenariotype = nil
                                                            RandomSinglyNormalText = nil
                                                            RandomSinglyText = nil
                                                            HasErrand = false
                                                            Singly = false
                                                            SinglyType = nil
                                                            Stype = nil
                                                            RandomSinglyText = Dealer.CustomerSinglyText[math.random(1,#Dealer.CustomerSinglyText)].text
                                                        else
                                                            exports.pNotify:SendNotification({text = "<b>Dealer</b></br>You are waiting for the dealer's order...", timeout = 2500})
                                                            Citizen.Wait(2500)
                                                            SearchingNewOrder = true
                                                        end
                                                    end)
                                                end
                                            end
                                            end)
                                        elseif IsPedInAnyVehicle(ped, false) then
                                            exports.pNotify:SendNotification({text = "<b>Dealer</b></br>Leave the vehicle!", timeout = 2500})
                                        end
                                    end
                                elseif wasTalked then
                                    sleep = 5
                                    if scenariotype == 'Normal' then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.0, RandomSinglyNormalText)
                                    elseif scenariotype == 'Drugged' then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.0, RandomSinglyDruggedText)
                                    elseif scenariotype == 'Attack' then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.0, RandomSinglyAttackText)
                                        DrawText3Ds(coords.x, coords.y, coords.z + 1.0, "~g~[E]~s~ - Give up | ~r~[G]~s~ - Try to escape")
                                        if IsControlJustReleased(0, Keys["E"]) then
                                            if not IsPedInAnyVehicle(ped, false) then
                                                -- exports['pepe-assets']:RequestAnimationDict('mp_common', function()
                                                --     TaskPlayAnim(ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                -- end)
                                                -- exports['pepe-assets']:RequestAnimationDict('mp_common', function()
                                                --     TaskPlayAnim(v.ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                -- end)
                                                Citizen.Wait(2500)
                                                TriggerServerEvent('inside-selldrugs:clearDrugs')
                                                exports.pNotify:SendNotification({text = "<b>Dealer</b></br>All your drugs have been stolen", timeout = 5000})
                                                FreezeEntityPosition(v.ped, false)
                                                TaskGoToCoordAnyMeans(v.ped, v.gx, v.gy, v.gz, 1.0)
                                                ClearPedTasks(ped)
                                                FreezeEntityPosition(ped, false)
                                                Citizen.Wait(4000)
                                                ClearPedTasks(v.ped)
                                                DeleteEntity(v.ped)
                                                RemoveBlip(v.blip)
                                                wasTalked = false
                                                scenariotype = nil
                                                RandomSinglyAttackText = nil
                                                RandomSinglyText = nil
                                                RandomSinglyText = Dealer.CustomerSinglyText[math.random(1,#Dealer.CustomerSinglyText)].text
                                                Framework.Functions.TriggerCallback('inside-selldrugs:checkSinglyItems', function(cb)
                                                    if cb == "hasNothing" then
                                                        exports.pNotify:SendNotification({text = "<b>Dealer</b></br>Order canceled", timeout = 2500})
                                                        DeleteEntity(v.ped)
                                                        RemoveBlip(v.blip)
                                                        scenariotype = nil
                                                        RandomSinglyNormalText = nil
                                                        RandomSinglyText = nil
                                                        HasErrand = false
                                                        Singly = false
                                                        SinglyType = nil
                                                        Stype = nil
                                                        RandomSinglyText = Dealer.CustomerSinglyText[math.random(1,#Dealer.CustomerSinglyText)].text
                                                    else
                                                        exports.pNotify:SendNotification({text = "<b>Dealer</b></br>You are waiting for the dealer's order...", timeout = 2500})
                                                        Citizen.Wait(2500)
                                                        SearchingNewOrder = true
                                                    end
                                                end)
                                            elseif IsPedInAnyVehicle(ped, false) then
                                                exports.pNotify:SendNotification({text = "<b>Dealer</b></br>Leave the vehicle!", timeout = 2500})
                                            end
                                        elseif IsControlJustReleased(0, Keys["G"]) then
                                            if not IsPedInAnyVehicle(ped, false) then
                                                local health = GetEntityHealth(ped)
                                                ClearPedTasks(ped)
                                                FreezeEntityPosition(v.ped, false)
                                                FreezeEntityPosition(ped, false)
                                                if health > 150 then
                                                    SetEntityHealth(ped, 150)
                                                end
                                                TaskCombatPed(v.ped, ped)
                                                Citizen.Wait(10000)
                                                ClearPedTasks(v.ped)
                                                DeleteEntity(v.ped)
                                                RemoveBlip(v.blip)
                                                wasTalked = false
                                                scenariotype = nil
                                                RandomSinglyAttackText = nil
                                                RandomSinglyText = nil
                                                RandomSinglyText = Dealer.CustomerSinglyText[math.random(1,#Dealer.CustomerSinglyText)].text
                                                Framework.Functions.TriggerCallback('inside-selldrugs:checkSinglyItems', function(cb)
                                                    if not IsPedDeadOrDying(ped) then
                                                        if cb == "hasNothing" then
                                                            exports.pNotify:SendNotification({text = "<b>Dealer</b></br>You have no more drugs, Order is done", timeout = 2500})
                                                            DeleteEntity(v.ped)
                                                            RemoveBlip(v.blip)
                                                            scenariotype = nil
                                                            RandomSinglyNormalText = nil
                                                            RandomSinglyText = nil
                                                            HasErrand = false
                                                            Singly = false
                                                            SinglyType = nil
                                                            Stype = nil
                                                            RandomSinglyText = Dealer.CustomerSinglyText[math.random(1,#Dealer.CustomerSinglyText)].text
                                                        else
                                                            exports.pNotify:SendNotification({text = "<b>Dealer</b></br>You are waiting for the dealer's order...", timeout = 2500})
                                                            Citizen.Wait(2500)
                                                            SearchingNewOrder = true
                                                        end
                                                    elseif IsPedDeadOrDying(ped) then
                                                        exports.pNotify:SendNotification({text = "<b>Dealer</b></br>Order canceled", timeout = 2500})
                                                        DeleteEntity(v.ped)
                                                        RemoveBlip(v.blip)
                                                        scenariotype = nil
                                                        RandomSinglyNormalText = nil
                                                        RandomSinglyText = nil
                                                        HasErrand = false
                                                        Singly = false
                                                        SinglyType = nil
                                                        Stype = nil
                                                        RandomSinglyText = Dealer.CustomerSinglyText[math.random(1,#Dealer.CustomerSinglyText)].text
                                                    end
                                                end)
                                            elseif IsPedInAnyVehicle(ped, false) then
                                                exports.pNotify:SendNotification({text = "<b>Dealer</b></br>Leave the vehicle!", timeout = 2500})
                                            end
                                        end
                                    elseif scenariotype == 'Police' then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.0, RandomSinglyPoliceText)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        Citizen.Wait(sleep)
    end
end)

function Randomize(tb)
	local keys = {}
	for k in pairs(tb) do table.insert(keys, k) end
	return tb[keys[math.random(#keys)]]
end

RegisterNetEvent('inside-selldrugs:notifyCops')
AddEventHandler('inside-selldrugs:notifyCops', function(coords)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		street = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
		street2 = GetStreetNameFromHashKey(street)
		exports.pNotify:SendNotification({text = "<b>Dealer</b></br>There have been drug sales on <b>" ..street2.. "</b>.", timeout = 7500})

		blipcops = AddBlipForCoord(coords.x, coords.y, coords.z)
		SetBlipSprite(blipcops,  403)
		SetBlipColour(blipcops,  1)
		SetBlipAlpha(blipcops, 250)
		SetBlipScale(blipcops, 1.2)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('[Drugs] Last drug sales')
		EndTextCommandSetBlipName(blipcops)
        Wait(35000)
        RemoveBlip(blipcops)
	end
end)

function CreateSinglyWork(singlytype)
    
    if singlytype == "Loc1" then
        Stype = Config.Loc1
        for i, v in ipairs(Stype) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 2)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Dealer] Place of meeting')
            EndTextCommandSetBlipName(v.blip)

            local pedmodel = GetHashKey(Config.SellDrugs.SinglyPeds[math.random(1,#Config.SellDrugs.SinglyPeds)].ped)
            RequestModel(pedmodel)
            while not HasModelLoaded(pedmodel) do
                Citizen.Wait(1)
            end	
            v.ped = CreatePed(1, pedmodel, v.x, v.y, v.z - 0.8, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
            PedGuardAnim()
        end
    elseif singlytype == "Loc2" then
        Stype = Config.Loc2
        for i, v in ipairs(Stype) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 2)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Dealer] Place of meeting')
            EndTextCommandSetBlipName(v.blip)

            local pedmodel = GetHashKey(Config.SellDrugs.SinglyPeds[math.random(1,#Config.SellDrugs.SinglyPeds)].ped)
            RequestModel(pedmodel)
            while not HasModelLoaded(pedmodel) do
                Citizen.Wait(1)
            end	
            v.ped = CreatePed(1, pedmodel, v.x, v.y, v.z - 0.8, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
            PedGuardAnim()
        end
    elseif singlytype == "Loc3" then
        Stype = Config.Loc3
        for i, v in ipairs(Stype) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 2)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Dealer] Place of meeting')
            EndTextCommandSetBlipName(v.blip)

            local pedmodel = GetHashKey(Config.SellDrugs.SinglyPeds[math.random(1,#Config.SellDrugs.SinglyPeds)].ped)
            RequestModel(pedmodel)
            while not HasModelLoaded(pedmodel) do
                Citizen.Wait(1)
            end	
            v.ped = CreatePed(1, pedmodel, v.x, v.y, v.z - 0.8, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
            PedGuardAnim()
        end
    elseif singlytype == "Loc4" then
        Stype = Config.Loc4
        for i, v in ipairs(Stype) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 2)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Dealer] Place of meeting')
            EndTextCommandSetBlipName(v.blip)

            local pedmodel = GetHashKey(Config.SellDrugs.SinglyPeds[math.random(1,#Config.SellDrugs.SinglyPeds)].ped)
            RequestModel(pedmodel)
            while not HasModelLoaded(pedmodel) do
                Citizen.Wait(1)
            end	
            v.ped = CreatePed(1, pedmodel, v.x, v.y, v.z - 0.8, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
            PedGuardAnim()
        end
    elseif singlytype == "Loc5" then
        Stype = Config.Loc5
        for i, v in ipairs(Stype) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 2)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Dealer] Place of meeting')
            EndTextCommandSetBlipName(v.blip)

            local pedmodel = GetHashKey(Config.SellDrugs.SinglyPeds[math.random(1,#Config.SellDrugs.SinglyPeds)].ped)
            RequestModel(pedmodel)
            while not HasModelLoaded(pedmodel) do
                Citizen.Wait(1)
            end	
            v.ped = CreatePed(1, pedmodel, v.x, v.y, v.z - 0.8, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
            PedGuardAnim()
        end
    elseif singlytype == "Loc6" then
        Stype = Config.Loc6
        for i, v in ipairs(Stype) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 2)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Dealer] Place of meeting')
            EndTextCommandSetBlipName(v.blip)

            local pedmodel = GetHashKey(Config.SellDrugs.SinglyPeds[math.random(1,#Config.SellDrugs.SinglyPeds)].ped)
            RequestModel(pedmodel)
            while not HasModelLoaded(pedmodel) do
                Citizen.Wait(1)
            end	
            v.ped = CreatePed(1, pedmodel, v.x, v.y, v.z - 0.8, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
            PedGuardAnim()
        end
    elseif singlytype == "Loc7" then
        Stype = Config.Loc7
        for i, v in ipairs(Stype) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 2)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Dealer] Place of meeting')
            EndTextCommandSetBlipName(v.blip)

            local pedmodel = GetHashKey(Config.SellDrugs.SinglyPeds[math.random(1,#Config.SellDrugs.SinglyPeds)].ped)
            RequestModel(pedmodel)
            while not HasModelLoaded(pedmodel) do
                Citizen.Wait(1)
            end	
            v.ped = CreatePed(1, pedmodel, v.x, v.y, v.z - 0.8, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
            PedGuardAnim()
        end
    elseif singlytype == "Loc8" then
        Stype = Config.Loc8
        for i, v in ipairs(Stype) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 2)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Dealer] Place of meeting')
            EndTextCommandSetBlipName(v.blip)

            local pedmodel = GetHashKey(Config.SellDrugs.SinglyPeds[math.random(1,#Config.SellDrugs.SinglyPeds)].ped)
            RequestModel(pedmodel)
            while not HasModelLoaded(pedmodel) do
                Citizen.Wait(1)
            end	
            v.ped = CreatePed(1, pedmodel, v.x, v.y, v.z - 0.8, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
            PedGuardAnim()
        end
    elseif singlytype == "Loc9" then
        Stype = Config.Loc9
        for i, v in ipairs(Stype) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 2)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Dealer] Place of meeting')
            EndTextCommandSetBlipName(v.blip)

            local pedmodel = GetHashKey(Config.SellDrugs.SinglyPeds[math.random(1,#Config.SellDrugs.SinglyPeds)].ped)
            RequestModel(pedmodel)
            while not HasModelLoaded(pedmodel) do
                Citizen.Wait(1)
            end	
            v.ped = CreatePed(1, pedmodel, v.x, v.y, v.z - 0.8, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
            PedGuardAnim()
        end
    elseif singlytype == "Loc10" then
        Stype = Config.Loc10
        for i, v in ipairs(Stype) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 2)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Dealer] Place of meeting')
            EndTextCommandSetBlipName(v.blip)

            local pedmodel = GetHashKey(Config.SellDrugs.SinglyPeds[math.random(1,#Config.SellDrugs.SinglyPeds)].ped)
            RequestModel(pedmodel)
            while not HasModelLoaded(pedmodel) do
                Citizen.Wait(1)
            end	
            v.ped = CreatePed(1, pedmodel, v.x, v.y, v.z - 0.8, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
            PedGuardAnim()
        end
    elseif singlytype == "Loc11" then
        Stype = Config.Loc11
        for i, v in ipairs(Stype) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 2)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Dealer] Place of meeting')
            EndTextCommandSetBlipName(v.blip)

            local pedmodel = GetHashKey(Config.SellDrugs.SinglyPeds[math.random(1,#Config.SellDrugs.SinglyPeds)].ped)
            RequestModel(pedmodel)
            while not HasModelLoaded(pedmodel) do
                Citizen.Wait(1)
            end	
            v.ped = CreatePed(1, pedmodel, v.x, v.y, v.z - 0.8, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
            PedGuardAnim()
        end
    elseif singlytype == "Loc12" then
        Stype = Config.Loc12
        for i, v in ipairs(Stype) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 2)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Dealer] Place of meeting')
            EndTextCommandSetBlipName(v.blip)

            local pedmodel = GetHashKey(Config.SellDrugs.SinglyPeds[math.random(1,#Config.SellDrugs.SinglyPeds)].ped)
            RequestModel(pedmodel)
            while not HasModelLoaded(pedmodel) do
                Citizen.Wait(1)
            end	
            v.ped = CreatePed(1, pedmodel, v.x, v.y, v.z - 0.8, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
            PedGuardAnim()
        end
    elseif singlytype == "Loc13" then
        Stype = Config.Loc13
        for i, v in ipairs(Stype) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 2)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Dealer] Place of meeting')
            EndTextCommandSetBlipName(v.blip)

            local pedmodel = GetHashKey(Config.SellDrugs.SinglyPeds[math.random(1,#Config.SellDrugs.SinglyPeds)].ped)
            RequestModel(pedmodel)
            while not HasModelLoaded(pedmodel) do
                Citizen.Wait(1)
            end	
            v.ped = CreatePed(1, pedmodel, v.x, v.y, v.z - 0.8, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
            PedGuardAnim()
        end
    elseif singlytype == "Loc14" then
        Stype = Config.Loc14
        for i, v in ipairs(Stype) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 2)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Dealer] Place of meeting')
            EndTextCommandSetBlipName(v.blip)

            local pedmodel = GetHashKey(Config.SellDrugs.SinglyPeds[math.random(1,#Config.SellDrugs.SinglyPeds)].ped)
            RequestModel(pedmodel)
            while not HasModelLoaded(pedmodel) do
                Citizen.Wait(1)
            end	
            v.ped = CreatePed(1, pedmodel, v.x, v.y, v.z - 0.8, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
            PedGuardAnim()
        end
    elseif singlytype == "Loc15" then
        Stype = Config.Loc15
        for i, v in ipairs(Stype) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 2)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Dealer] Place of meeting')
            EndTextCommandSetBlipName(v.blip)

            local pedmodel = GetHashKey(Config.SellDrugs.SinglyPeds[math.random(1,#Config.SellDrugs.SinglyPeds)].ped)
            RequestModel(pedmodel)
            while not HasModelLoaded(pedmodel) do
                Citizen.Wait(1)
            end	
            v.ped = CreatePed(1, pedmodel, v.x, v.y, v.z - 0.8, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
            PedGuardAnim()
        end
    elseif singlytype == "Loc16" then
        Stype = Config.Loc16
        for i, v in ipairs(Stype) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 2)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Dealer] Place of meeting')
            EndTextCommandSetBlipName(v.blip)

            local pedmodel = GetHashKey(Config.SellDrugs.SinglyPeds[math.random(1,#Config.SellDrugs.SinglyPeds)].ped)
            RequestModel(pedmodel)
            while not HasModelLoaded(pedmodel) do
                Citizen.Wait(1)
            end	
            v.ped = CreatePed(1, pedmodel, v.x, v.y, v.z - 0.8, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
            PedGuardAnim()
        end
    elseif singlytype == "Loc17" then
        Stype = Config.Loc17
        for i, v in ipairs(Stype) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 2)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Dealer] Place of meeting')
            EndTextCommandSetBlipName(v.blip)

            local pedmodel = GetHashKey(Config.SellDrugs.SinglyPeds[math.random(1,#Config.SellDrugs.SinglyPeds)].ped)
            RequestModel(pedmodel)
            while not HasModelLoaded(pedmodel) do
                Citizen.Wait(1)
            end	
            v.ped = CreatePed(1, pedmodel, v.x, v.y, v.z - 0.8, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
            PedGuardAnim()
        end
    elseif singlytype == "Loc18" then
        Stype = Config.Loc18
        for i, v in ipairs(Stype) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 2)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Dealer] Place of meeting')
            EndTextCommandSetBlipName(v.blip)

            local pedmodel = GetHashKey(Config.SellDrugs.SinglyPeds[math.random(1,#Config.SellDrugs.SinglyPeds)].ped)
            RequestModel(pedmodel)
            while not HasModelLoaded(pedmodel) do
                Citizen.Wait(1)
            end	
            v.ped = CreatePed(1, pedmodel, v.x, v.y, v.z - 0.8, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
            PedGuardAnim()
        end
    elseif singlytype == "Loc19" then
        Stype = Config.Loc19
        for i, v in ipairs(Stype) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 2)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Dealer] Place of meeting')
            EndTextCommandSetBlipName(v.blip)

            local pedmodel = GetHashKey(Config.SellDrugs.SinglyPeds[math.random(1,#Config.SellDrugs.SinglyPeds)].ped)
            RequestModel(pedmodel)
            while not HasModelLoaded(pedmodel) do
                Citizen.Wait(1)
            end	
            v.ped = CreatePed(1, pedmodel, v.x, v.y, v.z - 0.8, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
            PedGuardAnim()
        end
    elseif singlytype == "Loc20" then
        Stype = Config.Loc20
        for i, v in ipairs(Stype) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 2)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Dealer] Place of meeting')
            EndTextCommandSetBlipName(v.blip)

            local pedmodel = GetHashKey(Config.SellDrugs.SinglyPeds[math.random(1,#Config.SellDrugs.SinglyPeds)].ped)
            RequestModel(pedmodel)
            while not HasModelLoaded(pedmodel) do
                Citizen.Wait(1)
            end	
            v.ped = CreatePed(1, pedmodel, v.x, v.y, v.z - 0.8, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
            PedGuardAnim()
        end
    end
    SinglyType = singlytype
end

function CreateWork(type)

        if type == "Docks" then
            Wtype = Config.Docks
            for i, v in ipairs(Wtype) do
                v.blip = AddBlipForCoord(v.x, v.y, v.z)
                SetBlipSprite(v.blip, 205)
                SetBlipColour(v.blip, 2)
                SetBlipScale(v.blip, 0.5)
                SetBlipAsShortRange(v.blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString('[Dealer] Place of meeting')
                EndTextCommandSetBlipName(v.blip)

                local pedmodel = GetHashKey(Docks.DocksPed)
                RequestModel(pedmodel)
                while not HasModelLoaded(pedmodel) do
                    Citizen.Wait(1)
                end	
                v.ped = CreatePed(1, pedmodel, v.PedPosX, v.PedPosY, v.PedPosZ - 1.0, v.PedPosH, false, true)
                SetBlockingOfNonTemporaryEvents(v.ped, true)
                SetPedDiesWhenInjured(v.ped, false)
                SetPedCanPlayAmbientAnims(v.ped, true)
                SetPedCanRagdollFromPlayerImpact(v.ped, false)
                SetEntityInvincible(v.ped, true)
                FreezeEntityPosition(v.ped, true)
                PedGuardAnim()
            end
        elseif type == "East Vinewood" then
            Wtype = Config.EastVinewood
            for i, v in ipairs(Wtype) do
                v.blip = AddBlipForCoord(v.x, v.y, v.z)
                SetBlipSprite(v.blip, 205)
                SetBlipColour(v.blip, 2)
                SetBlipScale(v.blip, 0.5)
                SetBlipAsShortRange(v.blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString('[Dealer] Place of meeting')
                EndTextCommandSetBlipName(v.blip)

                local pedmodel = GetHashKey(EastVinewood.EastVinewoodPed)
                RequestModel(pedmodel)
                while not HasModelLoaded(pedmodel) do
                    Citizen.Wait(1)
                end	
                v.ped = CreatePed(1, pedmodel, v.PedPosX, v.PedPosY, v.PedPosZ - 1.0, v.PedPosH, false, true)
                SetBlockingOfNonTemporaryEvents(v.ped, true)
                SetPedDiesWhenInjured(v.ped, false)
                SetPedCanPlayAmbientAnims(v.ped, true)
                SetPedCanRagdollFromPlayerImpact(v.ped, false)
                SetEntityInvincible(v.ped, true)
                FreezeEntityPosition(v.ped, true)
                PedGuardAnim()
            end
        elseif type == "Sandy Shores" then
            Wtype = Config.SandyShores
            for i, v in ipairs(Wtype) do
                v.blip = AddBlipForCoord(v.x, v.y, v.z)
                SetBlipSprite(v.blip, 205)
                SetBlipColour(v.blip, 2)
                SetBlipScale(v.blip, 0.5)
                SetBlipAsShortRange(v.blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString('[Dealer] Place of meeting')
                EndTextCommandSetBlipName(v.blip)

                local pedmodel = GetHashKey(SandyShores.SandyShoresPed)
                RequestModel(pedmodel)
                while not HasModelLoaded(pedmodel) do
                    Citizen.Wait(1)
                end	
                v.ped = CreatePed(1, pedmodel, v.PedPosX, v.PedPosY, v.PedPosZ - 1.0, v.PedPosH, false, true)
                SetBlockingOfNonTemporaryEvents(v.ped, true)
                SetPedDiesWhenInjured(v.ped, false)
                SetPedCanPlayAmbientAnims(v.ped, true)
                SetPedCanRagdollFromPlayerImpact(v.ped, false)
                SetEntityInvincible(v.ped, true)
                FreezeEntityPosition(v.ped, true)
                PedGuardAnim()
            end
        elseif type == "Paleto Bay" then
            Wtype = Config.PaletoBay
            for i, v in ipairs(Wtype) do
                v.blip = AddBlipForCoord(v.x, v.y, v.z)
                SetBlipSprite(v.blip, 205)
                SetBlipColour(v.blip, 2)
                SetBlipScale(v.blip, 0.5)
                SetBlipAsShortRange(v.blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString('[Dealer] Place of meeting')
                EndTextCommandSetBlipName(v.blip)

                local pedmodel = GetHashKey(PaletoBay.PaletoBayPed)
                RequestModel(pedmodel)
                while not HasModelLoaded(pedmodel) do
                    Citizen.Wait(1)
                end	
                v.ped = CreatePed(1, pedmodel, v.PedPosX, v.PedPosY, v.PedPosZ - 1.0, v.PedPosH, false, true)
                SetBlockingOfNonTemporaryEvents(v.ped, true)
                SetPedDiesWhenInjured(v.ped, false)
                SetPedCanPlayAmbientAnims(v.ped, true)
                SetPedCanRagdollFromPlayerImpact(v.ped, false)
                SetEntityInvincible(v.ped, true)
                FreezeEntityPosition(v.ped, true)
                PedGuardAnim()
            end
        end
    Type = type
end

function ReturnVehicle()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)

    Framework.Functions.DeleteVehicle(vehicle)
end

function PedGuardAnim()
    RequestAnimDict("amb@world_human_stand_guard@male@idle_a")
    while (not HasAnimDictLoaded("amb@world_human_stand_guard@male@idle_a")) do
        Citizen.Wait(7)
    end
    exports['pepe-assets']:RequestAnimationDict('amb@world_human_stand_guard@male@idle_a', function()
        TaskPlayAnim(dealer, 'amb@world_human_stand_guard@male@idle_a', 'idle_a', 8.0, -8.0, -1, 2, 0, false, false, false)
    end)
end

function DrugsAnimObj()
    local ped = PlayerPedId()

    GarbageObject = CreateObject(GetHashKey("prop_cs_rub_binbag_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(GarbageObject, ped, GetPedBoneIndex(ped, 57005), 0.12, 0.0, -0.05, 220.0, 120.0, 0.0, true, true, false, true, 1, true)
end

function DrugsAnimObjPed()
    if Type then
        for i, v in ipairs(Wtype) do

            GarbageObject = CreateObject(GetHashKey("prop_cs_rub_binbag_01"), 0, 0, 0, true, true, true)
            AttachEntityToEntity(GarbageObject, v.ped, GetPedBoneIndex(v.ped, 57005), 0.12, 0.0, -0.05, 220.0, 120.0, 0.0, true, true, false, true, 1, true)
        end
    end
end

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
    DrawRect(0.0, 0.0+0.0125, 0.025+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end