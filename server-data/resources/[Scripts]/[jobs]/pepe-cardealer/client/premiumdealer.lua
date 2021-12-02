local PremiumCars = {}
local CurrentVehicle = nil
local SpawnedPremium = false
local CurrentBuyVehicle = nil
local NearCardealer, NearCar = false, false

RegisterNetEvent('pepe-cardealer:client:sync:premium:dealer')
AddEventHandler('pepe-cardealer:client:sync:premium:dealer', function(Slot, ConfigData)
    Config.PremiumDealerSpots[Slot] = ConfigData
    RefreshCars()
end)

RegisterNetEvent('pepe-cardealer:client:set:premium:details')
AddEventHandler('pepe-cardealer:client:set:premium:details', function(Vehicle, Price, Display, Stock)
    Config.PremiumVehicleDetails[Vehicle] = {['Price'] = Price, ['Display'] = Display, ['Stock'] = Stock}
end)

RegisterNetEvent('pepe-cardealer:client:can:buy:vehicle')
AddEventHandler('pepe-cardealer:client:can:buy:vehicle', function(VehicleSlot)
    CurrentBuyVehicle = VehicleSlot
end)

RegisterNetEvent('pepe-cardealer:client:set:stock')
AddEventHandler('pepe-cardealer:client:set:stock', function(StockData, Slot)
    Config.PremiumDealerSpots[Slot]['Stock'] = StockData
end)

RegisterNetEvent('pepe-cardealer:client:spawn:car:premium')
AddEventHandler('pepe-cardealer:client:spawn:car:premium', function(VehicleName, Plate)
    local CoordTable = {x = -783.9868, y = -235.0883, z = 37.152713, a = 26.42336}
    Framework.Functions.SpawnVehicle(VehicleName, function(Vehicle)
    --   TaskWarpPedIntoVehicle(GetPlayerPed(-1), Vehicle, -1)
      SetVehicleNumberPlateText(Vehicle, Plate)
      Citizen.Wait(25)
      exports['pepe-vehiclekeys']:SetVehicleKey(GetVehicleNumberPlateText(Vehicle), true)
      exports['pepe-fuel']:SetFuelLevel(Vehicle, GetVehicleNumberPlateText(Vehicle), 100.0, false)
     end, CoordTable, true, true)
end)

RegisterNetEvent('pepe-cardealer:client:testrit:closest:vehicle')
AddEventHandler('pepe-cardealer:client:testrit:closest:vehicle', function()
    if Config.PremiumDealerSpots[CurrentVehicle]['Model'] ~= nil then
        local Player, Distance = Framework.Functions.GetClosestPlayer()
            Framework.Functions.Progressbar("lockpick-door", "Voertuig Klaarmaken..", 3500, false, false, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "missheistdockssetup1clipboard@base",
                anim = "base",
                flags = 49,
            }, {
                model = "p_amb_clipboard_01",
                bone = 18905,
                coords = { x = 0.10, y = 0.02, z = 0.08 },
                rotation = { x = -80.0, y = 0.0, z = 0.0 },
            }, {
                model = "prop_pencil_01",
                bone = 58866,
                coords = { x = 0.12, y = 0.0, z = 0.001 },
                rotation = { x = -150.0, y = 0.0, z = 0.0 },
            }, function() -- Done

                TriggerEvent('pepe-cardealer:client:spawn:car:premium', Config.PremiumDealerSpots[CurrentVehicle]['Model'], 'TESTRI'..math.random(10,99)..'')
                StopAnimTask(GetPlayerPed(-1), "missheistdockssetup1clipboard@base", "base", 1.0)
            end, function()
                Framework.Functions.Notify("Geannuleerd..", "error")
                StopAnimTask(GetPlayerPed(-1), "missheistdockssetup1clipboard@base", "base", 1.0)
            end)
    else
        Framework.Functions.Notify("Dit is geen verkoop voertuig..", "error")
    end
end)

RegisterNetEvent('pepe-cardealer:client:sell:closest:vehicle')
AddEventHandler('pepe-cardealer:client:sell:closest:vehicle', function()
    if CurrentVehicle ~= nil then
        local Player, Distance = Framework.Functions.GetClosestPlayer()
        if Player ~= -1 and Distance < 2.5 then
            Framework.Functions.Progressbar("lockpick-door", "Voertuig Verkopen..", 5500, false, false, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "missheistdockssetup1clipboard@base",
                anim = "base",
                flags = 49,
            }, {
                model = "p_amb_clipboard_01",
                bone = 18905,
                coords = { x = 0.10, y = 0.02, z = 0.08 },
                rotation = { x = -80.0, y = 0.0, z = 0.0 },
            }, {
                model = "prop_pencil_01",
                bone = 58866,
                coords = { x = 0.12, y = 0.0, z = 0.001 },
                rotation = { x = -150.0, y = 0.0, z = 0.0 },
            }, function() -- Done
                TriggerServerEvent('pepe-cardealer:server:sell:closest', GetPlayerServerId(Player), CurrentVehicle)
                StopAnimTask(GetPlayerPed(-1), "missheistdockssetup1clipboard@base", "base", 1.0)
            end, function()
                Framework.Functions.Notify("Geannuleerd..", "error")
                StopAnimTask(GetPlayerPed(-1), "missheistdockssetup1clipboard@base", "base", 1.0)
            end)
        else
            Framework.Functions.Notify("Niemand in de buurt!", "error")
        end
    else
        Framework.Functions.Notify("Dit is geen verkoop voertuig..", "error")
    end
end)

-- // Functions \\ --

RegisterNUICallback('SetCarInSlot', function(data)
    TriggerServerEvent('pepe-cardealer:server:set:premium:data', data.slot, data.price, data.model, data.stock)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(4)
        if LoggedIn then
            NearCardealer = false
            local PlayerCoords = GetEntityCoords(GetPlayerPed(-1))
            local Distance = GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, Config.Locations[1]['Coords']['X'], Config.Locations[1]['Coords']['Y'], Config.Locations[1]['Coords']['Z'], true)
            if Distance < 75.0 then
                NearCardealer = true
                if not SpawnedPremium then
                    SpawnedPremium = true
                    SpawnPremiumCars()
                end
            end
            if not NearCardealer then
                Citizen.Wait(1000)
                if SpawnedPremium then
                    SpawnedPremium = false
                    DespawnPremiumCars()
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(4)
        if LoggedIn then
            NearCar = false
            shown = false
            if NearCardealer then
                NearCar = false
                for k, v in pairs(Config.PremiumDealerSpots) do
                    local PlayerCoords = GetEntityCoords(GetPlayerPed(-1))
                    local Distance = GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z'], true)
                    if Distance < 2.0 then
                        if v['Model'] ~= nil then
                            NearCar = true
                            CurrentVehicle = k
                            shown = true
				            -- exports['vesx-ui']:open('Model: '..v['DisplayName']..'<br>Prijs: €'..v['Price']..',-<br>Voorraad: '..v['Stock']..'x', 'darkgrey', 'left')
                            DrawText3D(v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z'] + 0.75, 'Model: ~g~'..v['DisplayName']..'~s~ \nPrijs: ~g~€'..v['Price']..',-~s~\nVoorraad: ~g~'..v['Stock']..'x')
                        end
                    end
                end

                if CurrentBuyVehicle ~= nil and NearCar then
                    local PlayerCoords = GetEntityCoords(GetPlayerPed(-1))
                    local Distance = GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, Config.PremiumDealerSpots[CurrentBuyVehicle]['Coords']['X'], Config.PremiumDealerSpots[CurrentBuyVehicle]['Coords']['Y'], Config.PremiumDealerSpots[CurrentBuyVehicle]['Coords']['Z'], true)
                    if Distance <= 2.0 then
                            -- exports['vesx-ui']:open('[E] - Kopen / [H] - Weigeren', 'darkgrey', 'left')
                            DrawText3D(Config.PremiumDealerSpots[CurrentBuyVehicle]['Coords']['X'], Config.PremiumDealerSpots[CurrentBuyVehicle]['Coords']['Y'], Config.PremiumDealerSpots[CurrentBuyVehicle]['Coords']['Z'] + 0.5, '~g~E~s~ - Kopen / ~g~H~s~ - Weigeren')

                        if IsControlJustReleased(0, 38) then
                            TriggerServerEvent('pepe-cardealer:server:buy:current:vehicle', CurrentBuyVehicle)
                            CurrentBuyVehicle = nil
                        end
                        if IsControlJustReleased(0, 74) then
                            CurrentBuyVehicle = nil
                        end
                    end
                end

                -- if not NearCar or shown then
                --     Citizen.Wait(1000)
                --     CurrentVehicle = nil
                --     shown = false
                --     exports['vesx-ui']:close()
                -- end

            end
        end
    end
end)

function RefreshCars()
    if NearCardealer then
        DespawnPremiumCars()
        Citizen.SetTimeout(750, function()
            SpawnPremiumCars()
        end)
    end
end

function SpawnPremiumCars()
    for k, v in pairs(Config.PremiumDealerSpots) do
        if v['Model'] ~= nil then
            exports['pepe-assets']:RequestModelHash(v['Model'])
            local ShowroomCar = CreateVehicle(GetHashKey(v['Model']), v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z'], false, false)
            SetModelAsNoLongerNeeded(ShowroomCar)
            SetVehicleOnGroundProperly(ShowroomCar)
            SetEntityInvincible(ShowroomCar, true)
            SetEntityHeading(ShowroomCar, v['Coords']['H'])
            SetVehicleDoorsLocked(ShowroomCar, 3)
            FreezeEntityPosition(ShowroomCar, true)
            SetVehicleNumberPlateText(ShowroomCar, k .. "CARSALE")
            table.insert(PremiumCars, ShowroomCar)
        end
    end
end

function DespawnPremiumCars()
    for k, v in pairs(PremiumCars) do
        DeleteVehicle(v)
    end
    PremiumCars = {}
end

RegisterNUICallback('SetSlotVehicle', function(data)
    if Config.PremiumVehicleDetails[data.model] ~= nil then
        TriggerServerEvent('pepe-cardealer:server:set:premium:data', data.slot, Config.PremiumVehicleDetails[data.model]['Price'], data.model, Config.PremiumVehicleDetails[data.model]['Display'], Config.PremiumVehicleDetails[data.model]['Stock'])
    end
end)

RegisterNUICallback('GetDisplayVehicles', function(data, cb)
    cb(Config.PremiumDealerSpots)
end)