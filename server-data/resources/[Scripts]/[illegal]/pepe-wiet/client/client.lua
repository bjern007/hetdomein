Framework = exports["pepe-core"]:GetCoreObject()
local IsSelling = false
local CurrentRadiusBlip = {}
local CurrentLocation = {
    ['Name'] = 'Wiet1',
    ['Coords'] = {['X'] = 5211.1103, ['Y'] = -5169.724, ['Z'] = 12.056114},
}
local CurrentBlip = {}
local LastLocation = nil  

local LoggedIn = false

RegisterNetEvent("Framework:Client:OnPlayerLoaded")
AddEventHandler("Framework:Client:OnPlayerLoaded", function()
  Citizen.SetTimeout(650, function()
      Framework.Functions.TriggerCallback('pepe-field:server:GetConfig', function(config)
          Config = config
          Citizen.Wait(250)
          LoggedIn = true
      end) 
      SetRandomLocation()  
      LoggedIn = true 
  end)
end)

RegisterNetEvent('Framework:Client:OnPlayerUnload')
AddEventHandler('Framework:Client:OnPlayerUnload', function()
    LoggedIn = false
end)

RegisterNetEvent('pepe-wiet:client:set:picked:state')
AddEventHandler('pepe-wiet:client:set:picked:state',function(PlantId, bool)
    Config.Plants['planten'][PlantId]['Geplukt'] = bool
end)

RegisterNetEvent('pepe-wiet:client:set:dry:busy')
AddEventHandler('pepe-wiet:client:set:dry:busy',function(DryRackId, bool)
    Config.WeedLocations['drogen'][DryRackId]['IsBezig'] = bool
end)

RegisterNetEvent('pepe-wiet:client:set:pack:busy')
AddEventHandler('pepe-wiet:client:set:pack:busy',function(PackerId, bool)
    Config.WeedLocations['verwerk'][PackerId]['IsBezig'] = bool
end)

-- Code

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(4)
        if LoggedIn then
          Citizen.Wait(1000 * 60 * 55)
          SetRandomLocation()
        end
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(15000)
    while true do
        Citizen.Wait(4)
        if LoggedIn then
          NearWietField = false
          local PlayerCoords = GetEntityCoords(PlayerPedId())
          local Distance = GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, CurrentLocation['Coords']['X'], CurrentLocation['Coords']['Y'], CurrentLocation['Coords']['Z'], true)
          if Distance <= 75.0 then
              NearWietField = true
              Config.CanWiet = true
          end
          if not NearWietField then
              Citizen.Wait(1500)
              Config.CanWiet = false
          end
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(4)
        if LoggedIn then
         local SpelerCoords = GetEntityCoords(PlayerPedId())
            NearAnything = false
            for k, v in pairs(Config.WeedLocations["drogen"]) do
                local PlantDistance = GetDistanceBetweenCoords(SpelerCoords.x, SpelerCoords.y, SpelerCoords.z, Config.WeedLocations["drogen"][k]['x'], Config.WeedLocations["drogen"][k]['y'], Config.WeedLocations["drogen"][k]['z'], true)
                if PlantDistance < 1.2 then
                 NearAnything = true
                 DrawMarker(2, Config.WeedLocations["drogen"][k]['x'], Config.WeedLocations["drogen"][k]['y'], Config.WeedLocations["drogen"][k]['z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 67, 156, 77, 255, false, false, false, 1, false, false, false)
                 if IsControlJustPressed(0, Config.Keys['E']) then
                  --if not Config.WeedLocations['drogen'][k]['IsBezig'] then
                    Framework.Functions.TriggerCallback('pepe-wiet:server:has:takken', function(HasTak)
                      if HasTak then
                          DryPlant(k)
                      else
                          Framework.Functions.Notify("Je mist iets.", "error")
                      end
                  end)
              --else
              --    Framework.Functions.Notify("Iemand is al aan het drogen.", "error")
              --end
            end
            end
            end

            for k, v in pairs(Config.WeedLocations["verwerk"]) do
                local PlantDistance = GetDistanceBetweenCoords(SpelerCoords.x, SpelerCoords.y, SpelerCoords.z, Config.WeedLocations["verwerk"][k]['x'], Config.WeedLocations["verwerk"][k]['y'], Config.WeedLocations["verwerk"][k]['z'], true)
                if PlantDistance < 1.2 then
                NearAnything = true
                 DrawMarker(2, Config.WeedLocations["verwerk"][k]['x'], Config.WeedLocations["verwerk"][k]['y'], Config.WeedLocations["verwerk"][k]['z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 67, 156, 77, 255, false, false, false, 1, false, false, false)
                 if IsControlJustPressed(0, Config.Keys['E']) then
                  if not Config.WeedLocations['verwerk'][k]['IsBezig'] then
                    Framework.Functions.TriggerCallback('pepe-wiet:server:has:nugget', function(HasNugget)
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

RegisterNetEvent('pepe-wiet:client:rod:anim')
AddEventHandler('pepe-wiet:client:rod:anim', function()
    exports['pepe-assets']:AddProp('Schaar')
    exports['pepe-assets']:RequestAnimationDict('amb@world_human_gardener_plant@male@idle_a')
    TaskPlayAnim(PlayerPedId(), "amb@world_human_gardener_plant@male@idle_a", "idle_a", 3.0, 3.0, -1, 49, 0, 0, 0, 0)
end)

RegisterNetEvent('pepe-wiet:client:use:scissor')
AddEventHandler('pepe-wiet:client:use:scissor', function()
  Citizen.SetTimeout(1000, function()
      if not Config.UsingRod then
       if Config.CanWiet then
          if not IsPedInAnyVehicle(PlayerPedId()) then
           if not IsEntityInWater(PlayerPedId()) then
               Config.UsingRod = true
               FreezeEntityPosition(PlayerPedId(), true)
               local Skillbar = exports['pepe-skillbar']:GetSkillbarObject()
               local SucceededAttempts = 0
               local NeededAttempts = math.random(2, 5)
               TriggerEvent('pepe-wiet:client:rod:anim')
               Skillbar.Start({
                   duration = math.random(500, 1300),
                   pos = math.random(10, 30),
                   width = math.random(10, 20),
               }, function()
                   if SucceededAttempts + 1 >= NeededAttempts then
                       -- Finish
                       FreezeEntityPosition(PlayerPedId(), false)
                       exports['pepe-assets']:RemoveProp()
                       Config.UsingRod = false
                       SucceededAttempts = 0
                       TriggerServerEvent('pepe-wiet:server:weed:reward')
                       StopAnimTask(PlayerPedId(), "amb@world_human_gardener_plant@male@idle_a", "idle_a", 1.0)
                   else
                       -- Repeat
                       Skillbar.Repeat({
                           duration = math.random(500, 1300),
                           pos = math.random(10, 40),
                           width = math.random(5, 13),
                       })
                       SucceededAttempts = SucceededAttempts + 1
                   end
               end, function()
                   -- Fail
                   FreezeEntityPosition(PlayerPedId(), false)
                   exports['pepe-assets']:RemoveProp()
                   Config.UsingRod = false
                   Framework.Functions.Notify('Je faalde..', 'error')
                   SucceededAttempts = 0
                   StopAnimTask(PlayerPedId(), "amb@world_human_gardener_plant@male@idle_a", "idle_a", 1.0)
               end)
           else
               Framework.Functions.Notify('Je bent aan het zwemmen.', 'error')
           end
          else
              Framework.Functions.Notify('Je zit in een voertuig.', 'error')
          end
       else
           Framework.Functions.Notify('Je bent niet in het kweek gebied.', 'error')
       end
      end
  end)
end)

function SetRandomLocation()
    RandomLocation = Config.WeedLocations[math.random(1, #Config.WeedLocations)]
    if CurrentLocation['Name'] ~= RandomLocation['Name'] then
     if CurrentBlip ~= nil and CurrentRadiosBlip ~= nil then
      RemoveBlip(CurrentBlip)
      RemoveBlip(CurrentRadiosBlip)
     end
     Citizen.SetTimeout(250, function()
         CurrentRadiosBlip = AddBlipForRadius(RandomLocation['Coords']['X'], RandomLocation['Coords']['Y'], RandomLocation['Coords']['Z'], 75.0)        
         SetBlipRotation(CurrentRadiosBlip, 0)
         SetBlipColour(CurrentRadiosBlip, 19)
     
         CurrentBlip = AddBlipForCoord(RandomLocation['Coords']['X'], RandomLocation['Coords']['Y'], RandomLocation['Coords']['Z'])
         SetBlipSprite(CurrentBlip, 140)
         SetBlipDisplay(CurrentBlip, 4)
         SetBlipScale(CurrentBlip, 0.7)
         SetBlipColour(CurrentBlip, 0)
         SetBlipAsShortRange(CurrentBlip, true)
         BeginTextCommandSetBlipName('STRING')
         AddTextComponentSubstringPlayerName('Wietveld')
         EndTextCommandSetBlipName(CurrentBlip)
         CurrentLocation = RandomLocation
     end)
    else
        SetRandomLocation()
    end
end

function DryPlant(DryRackId)
    TriggerServerEvent('pepe-wiet:server:remove:item', 'wet-tak', 2)
    TriggerServerEvent('pepe-wiet:server:set:dry:busy', DryRackId, true)
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
        TriggerServerEvent('pepe-wiet:server:add:item21212', 'wet-bud', math.random(1,6))
        TriggerServerEvent('pepe-wiet:server:set:dry:busy', DryRackId, false)
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        Framework.Functions.Notify("Gelukt!", "success")
    end, function() -- Cancel
        TriggerServerEvent('pepe-wiet:server:set:dry:busy', DryRackId, false)
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        Framework.Functions.Notify("Geannuleerd.", "error")
    end) 
end

function PackagePlant(PackerId)
    local WeedItems = Config.WeedSoorten[math.random(#Config.WeedSoorten)]
    TriggerServerEvent('pepe-wiet:server:remove:item', 'wet-bud', 2)
    TriggerServerEvent('pepe-wiet:server:remove:item', 'plastic-bag', 1)
    TriggerServerEvent('pepe-wiet:server:set:pack:busy', PackerId, true)
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
        TriggerServerEvent('pepe-wiet:server:add:item21212', WeedItems, math.random(1, 5))
        TriggerServerEvent('pepe-wiet:server:set:pack:busy', PackerId, false)
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        Framework.Functions.Notify("Gelukt!", "success")
    end, function() -- Cancel
        TriggerServerEvent('pepe-wiet:server:set:pack:busy', PackerId, false)
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        Framework.Functions.Notify("Geannuleerd.", "error")
    end) 
end