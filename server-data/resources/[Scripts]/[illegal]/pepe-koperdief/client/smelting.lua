local NearSmelt = false
LoggedIn = false

Framework = exports["pepe-core"]:GetCoreObject()

RegisterNetEvent('Framework:Client:OnPlayerLoaded')
AddEventHandler('Framework:Client:OnPlayerLoaded', function()
     Citizen.Wait(350)   
     LoggedIn = true
end)


Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        if LoggedIn then
            NearSmelt = false
            local Playercoords = GetEntityCoords(PlayerPedId())
            if #(Playercoords - vector3(Config.smelten['Smeltery'][1]['X'], Config.smelten['Smeltery'][1]['Y'], Config.smelten['Smeltery'][1]['Z'])) <= 1.5 then
                NearSmelt = true
                sleep = 6
                if not Config.Smelting then
                    if Config.CanTake then
                        DrawMarker(2, Config.smelten['Smeltery'][1]['X'], Config.smelten['Smeltery'][1]['Y'], Config.smelten['Smeltery'][1]['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                        Framework.Functions.DrawText3D(Config.smelten['Smeltery'][1]['X'], Config.smelten['Smeltery'][1]['Y'], Config.smelten['Smeltery'][1]['Z'] + 0.15, "~g~E~w~ - Koper ophalen")
                        if IsControlJustReleased(0, 38) then
                            Config.Smelting = false
                            Config.CanTake = false
                            Config.MeltTime = 300
                            TriggerServerEvent('pepe-koperdief:server:redeem:koper:bars')
                        end
                    else
                        DrawMarker(2, Config.smelten['Smeltery'][1]['X'], Config.smelten['Smeltery'][1]['Y'], Config.smelten['Smeltery'][1]['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 39, 196, 27, 255, false, false, false, 1, false, false, false)
                        Framework.Functions.DrawText3D(Config.smelten['Smeltery'][1]['X'], Config.smelten['Smeltery'][1]['Y'], Config.smelten['Smeltery'][1]['Z'] + 0.15, "~g~E~w~ - Smelt koper")
                        if IsControlJustReleased(0, 38) then
                            Framework.Functions.TriggerCallback('ks-koperdief:server:koperdraad', function(HasItem)
						        if HasItem then
							
							        Framework.Functions.Progressbar("sell-gold", "Koper smelten...", math.random(10000, 15000), false, true, {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    }, {}, {}, {}, function() -- Done
                                        TriggerServerEvent('pepe-koperdief:server:smelt:koper')
                                    end, function() -- Cancel
                                        Framework.Functions.Notify("Geannuleerd.", "error")
                                    end)
                                else
								    Framework.Functions.Notify('U heeft minimaal 1xkoper nodig..', 'error')
								end
							end)	
						end
                    end
                elseif Config.Smelting and Config.SmeltTime > 0 then
                    DrawMarker(2, Config.smelten['Smeltery'][1]['X'], Config.smelten['Smeltery'][1]['Y'], Config.smelten['Smeltery'][1]['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 227, 142, 39, 255, false, false, false, 1, false, false, false)
                    Framework.Functions.DrawText3D(Config.smelten['Smeltery'][1]['X'], Config.smelten['Smeltery'][1]['Y'], Config.smelten['Smeltery'][1]['Z'] + 0.15, "~o~Smelten: ~s~"..Config.SmeltTime..'s')
                end
            end
            -- if not NearSmelt then
            --     Citizen.Wait(2500)
            -- end
        end
        Citizen.Wait(sleep)
    end
end)

RegisterNetEvent('pepe-koperdief:client:start:process')
AddEventHandler('pepe-koperdief:client:start:process', function()
    if not Config.Smelting then
        Config.Smelting = true
        while Config.Smelting do
          if Config.SmeltTime > 0 then
            Config.SmeltTime = Config.SmeltTime - 1
          end
          if Config.SmeltTime <= 0 then
            Config.CanTake = true
            Config.Smelting = false
          end
          Citizen.Wait(1000)
        end
    end
end)

RegisterNetEvent('pepe-koperdief:server:reset:smelter')
AddEventHandler('pepe-koperdief:server:reset:smelter', function()
    Config.Smelting = false
    Config.CanTake = false
    Config.SmeltTime = 20  --tijd van smelter aanpassen in config en hier !!!
end)