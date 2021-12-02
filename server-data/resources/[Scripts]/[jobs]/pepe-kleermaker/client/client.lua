-- Framework = nil
local LoggedIn = false
local PlayerData = {}
local PlayerJob = {}
local blip = nil

local sellX4 = 1205.84  
local sellY4 = -1271.42
local sellZ4 = 35.23
local model1 = Config.ModelCar --model
local delX = 1187.84  --del auto 
local delY = -1286.76
local delZ = 34.95
local HasVehicle = true

Framework = exports["pepe-core"]:GetCoreObject()

local CurrentLocation = {
    ['Coords'] = {['X'] = 1880.18, ['Y'] = 5054.91, ['Z'] = 50.86},
}




RegisterNetEvent("Framework:Client:OnPlayerLoaded")
AddEventHandler("Framework:Client:OnPlayerLoaded", function()
  Citizen.SetTimeout(650, function()
    --   TriggerEvent("Framework:GetObject", function(obj) Framework = obj end)   
    --   Citizen.Wait(200)
      Framework.Functions.TriggerCallback('pepe-kleermaker:server:GetConfig', function(config)
          Config = config
      end) 
      PlayerJob = Framework.Functions.GetPlayerData().job
	  LoggedIn = true
	  CurrentBlip = nil
	    if PlayerJob.name == "kledingmaker" then
            TruckVehBlip = AddBlipForCoord(713.12, -969.08, 30.4)
            SetBlipSprite(TruckVehBlip, 73)
            SetBlipDisplay(TruckVehBlip, 4)
            SetBlipScale(TruckVehBlip, 0.6)
            SetBlipAsShortRange(TruckVehBlip, true)
            SetBlipColour(TruckVehBlip, 5)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Textiel fabriek")
            EndTextCommandSetBlipName(TruckVehBlip)
			
			TruckVehBlip2 = AddBlipForCoord(429.45, -808.05, 29.49)
            SetBlipSprite(TruckVehBlip2, 73)
            SetBlipDisplay(TruckVehBlip2, 4)
            SetBlipScale(TruckVehBlip2, 0.6)
            SetBlipAsShortRange(TruckVehBlip2, true)
            SetBlipColour(TruckVehBlip2, 5)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Textiel verkoop")
            EndTextCommandSetBlipName(TruckVehBlip2)
			
			TruckVehBlip = AddBlipForCoord(1928.74, 5088.98, 43.05)
            SetBlipSprite(TruckVehBlip, 73)
            SetBlipDisplay(TruckVehBlip, 4)
            SetBlipScale(TruckVehBlip, 0.6)
            SetBlipAsShortRange(TruckVehBlip, true)
            SetBlipColour(TruckVehBlip, 5)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Katoen pluk")
            EndTextCommandSetBlipName(TruckVehBlip)
        end
	  
  end)
  
end)

RegisterNetEvent('Framework:Client:OnPlayerUnload')
AddEventHandler('Framework:Client:OnPlayerUnload', function()
    LoggedIn = false
	RemoveTruckerBlips()
end)

RegisterNetEvent('Framework:Client:OnJobUpdate')
AddEventHandler('Framework:Client:OnJobUpdate', function(JobInfo)	
	PlayerJob = JobInfo
	if PlayerJob.name == "kledingmaker" then
        TruckVehBlip = AddBlipForCoord(713.12, -969.08, 30.4)
        SetBlipSprite(TruckVehBlip, 73)
        SetBlipDisplay(TruckVehBlip, 4)
        SetBlipScale(TruckVehBlip, 0.6)
        SetBlipAsShortRange(TruckVehBlip, true)
        SetBlipColour(TruckVehBlip, 5)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Textiel fabriek")
        EndTextCommandSetBlipName(TruckVehBlip)
		
		TruckVehBlip2 = AddBlipForCoord(429.45, -808.05, 29.49)
        SetBlipSprite(TruckVehBlip2, 73)
        SetBlipDisplay(TruckVehBlip2, 4)
        SetBlipScale(TruckVehBlip2, 0.6)
        SetBlipAsShortRange(TruckVehBlip2, true)
        SetBlipColour(TruckVehBlip2, 5)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Textiel verkoop")
        EndTextCommandSetBlipName(TruckVehBlip2)
		
		TruckVehBlip3 = AddBlipForCoord(1928.74, 5088.98, 43.05)
        SetBlipSprite(TruckVehBlip3, 73)
        SetBlipDisplay(TruckVehBlip3, 4)
        SetBlipScale(TruckVehBlip3, 0.6)
        SetBlipAsShortRange(TruckVehBlip3, true)
        SetBlipColour(TruckVehBlip3, 5)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Katoen pluk")
        EndTextCommandSetBlipName(TruckVehBlip3)
		
    elseif OldlayerJob == "kledingmaker" then
        RemoveTruckerBlips()
    end
	
end)


function RemoveTruckerBlips()
    if TruckVehBlip ~= nil then
        RemoveBlip(TruckVehBlip)
        TruckVehBlip = nil
    end
	
	if TruckVehBlip2 ~= nil then
        RemoveBlip(TruckVehBlip2)
        TruckVehBlip2 = nil
    end
	
	if TruckVehBlip3 ~= nil then
        RemoveBlip(TruckVehBlip3)
        TruckVehBlip3 = nil
    end

    if CurrentBlip ~= nil then
        RemoveBlip(CurrentBlip)
        CurrentBlip = nil
    end
end


--Code
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
              Citizen.Wait(2000)
              Config.CanWiet = false
          end
        end
    end
end)

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


RegisterNetEvent('pepe-kleermaker:client:use:scissor')
AddEventHandler('pepe-kleermaker:client:use:scissor', function()
  Citizen.SetTimeout(1000, function()
      if PlayerJob.name ==  "kledingmaker" then
	    if not Config.UsingRod then
         if Config.CanWiet then
            if not IsPedInAnyVehicle(PlayerPedId()) then
             if not IsEntityInWater(PlayerPedId()) then
                 Config.UsingRod = true
			     PickPlant(k)
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
	  else
         Framework.Functions.Notify('Je bent geed kledingmaker.', 'error')  
	  end
  end)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(4)
        if LoggedIn then
		 if PlayerJob.name ==  "kledingmaker" then	
		    local SpelerCoords = GetEntityCoords(PlayerPedId())
              NearAnything = false
                if IsSelling then 
                    Framework.Functions.Notify('Foei.', 'info')
                    return
                end
                    IsSelling = false
              for k, v in pairs(Config.Plants["Ontwerpen"]) do
                  local PlantDistance = GetDistanceBetweenCoords(SpelerCoords.x, SpelerCoords.y, SpelerCoords.z, Config.Plants["Ontwerpen"][k]['x'], Config.Plants["Ontwerpen"][k]['y'], Config.Plants["Ontwerpen"][k]['z'], true)
                  if PlantDistance < 1.2 then
                   NearAnything = true
                   DrawMarker(2, Config.Plants["Ontwerpen"][k]['x'], Config.Plants["Ontwerpen"][k]['y'], Config.Plants["Ontwerpen"][k]['z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 67, 156, 77, 255, false, false, false, 1, false, false, false)
                   if IsControlJustPressed(0, Config.Keys['E']) then
                      Framework.Functions.TriggerCallback('pepe-kleermaker:server:has:takken', function(HasTak)
                        if HasTak then
                            DryPlant(k)
                        else
                            Framework.Functions.Notify("Je hebt katoen nodig.", "error")
                        end
                    end)
                end
              end
              end

              for k, v in pairs(Config.Plants["Naaien"]) do
                  local PlantDistance = GetDistanceBetweenCoords(SpelerCoords.x, SpelerCoords.y, SpelerCoords.z, Config.Plants["Naaien"][k]['x'], Config.Plants["Naaien"][k]['y'], Config.Plants["Naaien"][k]['z'], true)
                  if PlantDistance < 1.2 then
                  NearAnything = true
                   DrawMarker(2, Config.Plants["Naaien"][k]['x'], Config.Plants["Naaien"][k]['y'], Config.Plants["Naaien"][k]['z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 67, 156, 77, 255, false, false, false, 1, false, false, false)
                   if IsControlJustPressed(0, Config.Keys['E']) then
                      Framework.Functions.TriggerCallback('pepe-kleermaker:server:has:nugget', function(HasNugget)
                        if HasNugget then
                            PackagePlant(k)
                        else
                            Framework.Functions.Notify("Je hebt stof rollen nodig..", "error")
                        end
                    end)
                end
              end
              end
			  
			  for k, v in pairs(Config.Plants["Verkoop"]) do
                  local PlantDistance = GetDistanceBetweenCoords(SpelerCoords.x, SpelerCoords.y, SpelerCoords.z, Config.Plants["Verkoop"][k]['x'], Config.Plants["Verkoop"][k]['y'], Config.Plants["Verkoop"][k]['z'], true)
                  if PlantDistance < 1.2 then
                  NearAnything = true
                   DrawMarker(2, Config.Plants["Verkoop"][k]['x'], Config.Plants["Verkoop"][k]['y'], Config.Plants["Verkoop"][k]['z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 67, 156, 77, 255, false, false, false, 1, false, false, false)
                   if IsControlJustPressed(0, Config.Keys['E']) then
                      IsSelling = true
                      Framework.Functions.Notify('Selling..', 'info')
                      TriggerServerEvent('pepe-kleermaker:server:sell:items')
                      Citizen.SetTimeout(15000, function()
                          IsSelling = false
                      end)
                    end
                end
              --end
              end
			 
			  for k, v in pairs(Config.Plants["vehicle"]) do
                  local PlantDistance = GetDistanceBetweenCoords(SpelerCoords.x, SpelerCoords.y, SpelerCoords.z, Config.Plants["vehicle"][k]['x'], Config.Plants["vehicle"][k]['y'], Config.Plants["vehicle"][k]['z'], true)
                  local InVehicle = IsPedInAnyVehicle(PlayerPedId(), false)
				  if PlantDistance < 4.2 then
                  NearAnything = true
                        if InVehicle then
                            DrawText3D(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z, "~g~E~w~ - Busje terug brengen")
                            if IsControlJustPressed(0, Config.Keys['E']) then
                                Framework.Functions.TriggerCallback('pepe-kleermaker:server:CheckBail', function(DidBail)
                                    if DidBail then
                                        BringBackCar()
										TriggerServerEvent('pepe-kleermaker:server:remove:zeis')
                                        Framework.Functions.Notify("Je hebt €1000,- borg terug ontvangen.")
                                    else
                                        Framework.Functions.Notify("Je hebt geen borg betaald over dit voertuig.")
                                    end
                                end)
                            end
                        else
                            DrawText3D(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z, "~g~E~w~ - Busje")
                            if IsControlJustPressed(0, Config.Keys['E']) then
                                Framework.Functions.TriggerCallback('pepe-kleermaker:server:HasMoney', function(HasMoney)
                                    if HasMoney then
                                        local coords = Config.Locations["vehicle"].coords
                                        Framework.Functions.SpawnVehicle("rumpo", function(veh)
                                            GarbageVehicle = veh
                                            SetVehicleNumberPlateText(veh, "KLEDING"..tostring(math.random(1000, 9999)))
                                            SetEntityHeading(veh, coords.h)
                                            exports['pepe-fuel']:SetFuelLevel(veh, GetVehicleNumberPlateText(veh), 100, false)
                                            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                                            SetEntityAsMissionEntity(veh, true, true)
                                            exports['pepe-vehiclekeys']:SetVehicleKey(GetVehicleNumberPlateText(veh), true)
                                            SetVehicleEngineOn(veh, true, true)
                                            hasVuilniswagen = true
                                            IsWorking = true
											TriggerServerEvent('pepe-kleermaker:server:give:zeis')
                                            Framework.Functions.Notify("Je hebt €1000,- borg betaald.")
                                        end, coords, true)
                                    else
                                        Framework.Functions.Notify("Je hebt niet genoeg geld voor de borg. Borg kosten zijn €1000,-")
                                    end
                                end)
                            end
                        end
                end
              end
              if not NearAnything then
                  Citizen.Wait(2500)
              end
			  
          end
		end  
    end
end)





--AUTO STUFF
function SpawnVehicle()
    local CoordTable = {x = 745.08, y = -966.29, z = 24.65, a = 270.92}
    Framework.Functions.SpawnVehicle('rumpo', function(vehicle)
     TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
     exports['pepe-vehiclekeys']:SetVehicleKey(GetVehicleNumberPlateText(vehicle), true)
     Citizen.Wait(100)
     exports['pepe-fuel']:SetFuelLevel(vehicle, GetVehicleNumberPlateText(vehicle), 100, true)
     Framework.Functions.Notify('Je hebt je busje ontvangen', 'success')
    end, CoordTable, true, true)
end

function BringBackCar()
    local veh = GetVehiclePedIsIn(PlayerPedId())
    DeleteVehicle(veh)
end
-- Functions 

function PickPlant(PlantId)
	TriggerEvent('pepe-sound:client:play', 'cutting', 0.4)
    Framework.Functions.Progressbar("pick_plant", "katoen plukken...", math.random(3500, 6500), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@prop_human_bum_bin@idle_b",
        anim = "idle_d",
        flags = 16,
    }, {}, {}, function() -- Done
        TriggerServerEvent('pepe-kleermaker:server:set:picked:state', PlantId, true)
        TriggerServerEvent('pepe-kleermaker:server:give:katoen')
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
        Framework.Functions.Notify("katoen geplukt!", "success")
		Config.UsingRod = false
    end, function() -- Cancel
        TriggerServerEvent('pepe-kleermaker:server:set:plant:busy', PlantId, false)
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
        Framework.Functions.Notify("Geannuleerd.", "error")
		Config.UsingRod = false
    end)
end

function DryPlant(DryRackId)
    TriggerServerEvent('pepe-kleermaker:server:remove:item', 'katoen', 4)
    Framework.Functions.Progressbar("pick_plant", "Stof rollen maken...", math.random(6000, 11000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@narcotics@trash",
        anim = "drop_front",
        flags = 16,
    }, {}, {}, function() -- Done
        TriggerServerEvent('pepe-kleermaker:server:add:item', 'stofrol', math.random(2,2))
        TriggerServerEvent('pepe-kleermaker:server:set:dry:busy', DryRackId, false)
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        Framework.Functions.Notify("Gelukt!", "success")
    end, function() -- Cancel
        TriggerServerEvent('pepe-kleermaker:server:set:dry:busy', DryRackId, false)
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        Framework.Functions.Notify("Geannuleerd.", "error")
    end) 
end

function PackagePlant(PackerId)
    if inAction then 
        Framework.Functions.Notify('Foei.', 'info')
        return
    end
    inAction = true
    local WeedItems = Config.KledingSoorten[math.random(#Config.KledingSoorten)]
    TriggerServerEvent('pepe-kleermaker:server:remove:item', 'stofrol', 2)
    --TriggerServerEvent('pepe-kleermaker:server:set:pack:busy', PackerId, true)
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
        TriggerServerEvent('pepe-kleermaker:server:add:item', WeedItems, 1)
        TriggerServerEvent('pepe-kleermaker:server:set:pack:busy', PackerId, false)
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        Framework.Functions.Notify("Gelukt!", "success")
        inAction = false
    end, function() -- Cancel
        TriggerServerEvent('pepe-kleermaker:server:set:pack:busy', PackerId, false)
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        Framework.Functions.Notify("Geannuleerd.", "error")
        inAction = false
    end) 
end

