local LoggedIn = false

Framework = nil

RegisterNetEvent("Framework:Client:OnPlayerLoaded")
AddEventHandler("Framework:Client:OnPlayerLoaded", function()
  Citizen.SetTimeout(650, function()
      TriggerEvent("Framework:GetObject", function(obj) Framework = obj end)   
      Citizen.Wait(200)
      Framework.Functions.TriggerCallback('pepe-field:server:GetConfig', function(config)
          Config = config
      end) 
      LoggedIn = true
  end)
end)

RegisterNetEvent('Framework:Client:OnPlayerUnload')
AddEventHandler('Framework:Client:OnPlayerUnload', function()
    LoggedIn = false
end)

-- Code

RegisterNetEvent('pepe-field:client:set:plant:busy')
AddEventHandler('pepe-field:client:set:plant:busy',function(PlantId, bool)
    Config.Plants['planten'][PlantId]['IsBezig'] = bool
end)

RegisterNetEvent('pepe-field:client:set:picked:state')
AddEventHandler('pepe-field:client:set:picked:state',function(PlantId, bool)
    Config.Plants['planten'][PlantId]['Geplukt'] = bool
end)

RegisterNetEvent('pepe-field:client:set:dry:busy')
AddEventHandler('pepe-field:client:set:dry:busy',function(DryRackId, bool)
    Config.Plants['drogen'][DryRackId]['IsBezig'] = bool
end)

RegisterNetEvent('pepe-field:client:set:pack:busy')
AddEventHandler('pepe-field:client:set:pack:busy',function(PackerId, bool)
    Config.Plants['verwerk'][PackerId]['IsBezig'] = bool
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(4)
        if LoggedIn then
         local SpelerCoords = GetEntityCoords(PlayerPedId())
            NearAnything = false
            for k, v in pairs(Config.Plants["planten"]) do
                local PlantDistance = GetDistanceBetweenCoords(SpelerCoords.x, SpelerCoords.y, SpelerCoords.z, Config.Plants["planten"][k]['x'], Config.Plants["planten"][k]['y'], Config.Plants["planten"][k]['z'], true)
                if PlantDistance < 9.2 then
                    DrawMarker(2, Config.Plants["planten"][k]['x'], Config.Plants["planten"][k]['y'], Config.Plants["planten"][k]['z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 48, 255, 58, 255, false, false, false, 1, false, false, false)
                
                    if PlantDistance < 1.2 then
                NearAnything = true
                 if IsControlJustPressed(0, Config.Keys['E']) then
                    if not Config.Plants['planten'][k]['IsBezig'] then
                        if not Config.Plants['planten'][k]['Geplukt'] then
                          PickPlant(k)
                        else
                          Framework.Functions.Notify("Het lijkt erop dat deze plant al is geplukt.", "error")
                      end
                    else
                     Framework.Functions.Notify("Iemand anders is al bezig met deze plant.", "error")
                 end
            end
            end
            end
        end

            for k, v in pairs(Config.Plants["drogen"]) do
                local PlantDistance = GetDistanceBetweenCoords(SpelerCoords.x, SpelerCoords.y, SpelerCoords.z, Config.Plants["drogen"][k]['x'], Config.Plants["drogen"][k]['y'], Config.Plants["drogen"][k]['z'], true)
                if PlantDistance < 1.2 then
                 NearAnything = true
                 DrawMarker(2, Config.Plants["drogen"][k]['x'], Config.Plants["drogen"][k]['y'], Config.Plants["drogen"][k]['z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 67, 156, 77, 255, false, false, false, 1, false, false, false)
                 if IsControlJustPressed(0, Config.Keys['E']) then
                  if not Config.Plants['drogen'][k]['IsBezig'] then
                    Framework.Functions.TriggerCallback('pepe-field:server:has:takken', function(HasTak)
                      if HasTak then
                          DryPlant(k)
                      else
                          Framework.Functions.Notify("Je mist iets.", "error")
                      end
                  end)
              else
                  Framework.Functions.Notify("Iemand is al aan het drogen.", "error")
              end
            end
            end
            end

            for k, v in pairs(Config.Plants["verwerk"]) do
                local PlantDistance = GetDistanceBetweenCoords(SpelerCoords.x, SpelerCoords.y, SpelerCoords.z, Config.Plants["verwerk"][k]['x'], Config.Plants["verwerk"][k]['y'], Config.Plants["verwerk"][k]['z'], true)
                if PlantDistance < 1.2 then
                NearAnything = true
                 DrawMarker(2, Config.Plants["verwerk"][k]['x'], Config.Plants["verwerk"][k]['y'], Config.Plants["verwerk"][k]['z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 67, 156, 77, 255, false, false, false, 1, false, false, false)
                 if IsControlJustPressed(0, Config.Keys['E']) then
                  if not Config.Plants['verwerk'][k]['IsBezig'] then
                    Framework.Functions.TriggerCallback('pepe-field:server:has:nugget', function(HasNugget)
                      if HasNugget then
                          PackagePlant(k)
                      else
                          Framework.Functions.Notify("Je mist iets..", "error")
                      end
                  end)
              else
                  Framework.Functions.Notify("Iemand is al aan het verpakken.", "error")
              end
            end
            end
            end
            if not NearAnything then
                Citizen.Wait(2500)
            end
        end
    end
end)


-- Functions 

function PickPlant(PlantId)
    TriggerServerEvent('pepe-field:server:set:plant:busy', PlantId, true)
    Framework.Functions.Progressbar("pick_plant", "Plukken...", math.random(3500, 6500), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@prop_human_bum_bin@idle_b",
        anim = "idle_d",
        flags = 16,
    }, {}, {}, function() -- Done
        TriggerServerEvent('pepe-field:server:set:plant:busy', PlantId, false)
        TriggerServerEvent('pepe-field:server:set:picked:state', PlantId, true)
        TriggerServerEvent('pepe-field:server:give:tak')
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
        Framework.Functions.Notify("Gelukt!", "success")
    end, function() -- Cancel
        TriggerServerEvent('pepe-field:server:set:plant:busy', PlantId, false)
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
        Framework.Functions.Notify("Geannuleerd.", "error")
    end)
end

function DryPlant(DryRackId)
    TriggerServerEvent('pepe-field:server:remove:item', 'wet-tak', 2)
    TriggerServerEvent('pepe-field:server:set:dry:busy', DryRackId, true)
    Framework.Functions.Progressbar("pick_plant", "Drogen...", math.random(6000, 11000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@narcotics@trash",
        anim = "drop_front",
        flags = 16,
    }, {}, {}, function() -- Done
        TriggerServerEvent('pepe-field:server:add:item', 'wet-bud', math.random(1,3))
        TriggerServerEvent('pepe-field:server:set:dry:busy', DryRackId, false)
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        Framework.Functions.Notify("Gelukt!", "success")
    end, function() -- Cancel
        TriggerServerEvent('pepe-field:server:set:dry:busy', DryRackId, false)
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        Framework.Functions.Notify("Geannuleerd.", "error")
    end) 
end

function PackagePlant(PackerId)
    local WeedItems = Config.WeedSoorten[math.random(#Config.WeedSoorten)]
    TriggerServerEvent('pepe-field:server:remove:item', 'wet-bud', 2)
    TriggerServerEvent('pepe-field:server:remove:item', 'plastic-bag', 1)
    TriggerServerEvent('pepe-field:server:set:pack:busy', PackerId, true)
    Framework.Functions.Progressbar("pick_plant", "Verpakken...", math.random(3500, 6500), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@narcotics@trash",
        anim = "drop_front",
        flags = 16,
    }, {}, {}, function() -- Done
        TriggerServerEvent('pepe-field:server:add:item', WeedItems, 1)
        TriggerServerEvent('pepe-field:server:set:pack:busy', PackerId, false)
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        Framework.Functions.Notify("Gelukt!", "success")
    end, function() -- Cancel
        TriggerServerEvent('pepe-field:server:set:pack:busy', PackerId, false)
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        Framework.Functions.Notify("Geannuleerd.", "error")
    end) 
end