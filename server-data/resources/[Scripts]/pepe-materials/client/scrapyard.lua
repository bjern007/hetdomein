local NearScrapYard = false
local CurrentScrapYard = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(4)
        if LoggedIn then
         local PlayerCoords = GetEntityCoords(PlayerPedId())
         NearScrapYard = false
         for k, v in pairs(Config.ScrapyardLocations) do 
		    local Area = #(PlayerCoords - vector3(v['X'], v['Y'], v['Z'])) 
             if Area < 7.5 then
                CurrentScrapYard = k
                NearScrapYard = true
             end
         end
         if not NearScrapYard then
            Citizen.Wait(2500)
            CurrentScrapYard = false
         end
        end
    end
end)

RegisterNetEvent('pepe-materials:client:scrap:vehicle')
AddEventHandler('pepe-materials:client:scrap:vehicle', function()
    local Vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
    --local veh = GetVehiclePedIsIn(PlayerPedId(),false)
    local driver = GetPedInVehicleSeat(Vehicle, -1)
    if Config.CanScrap then
        Config.CanScrap = false
	    -- Framework.Functions.TriggerCallback('pepe-materials:server:is:vehicle:owned', function(IsOwned)
        -- if not IsOwned then
			if driver == PlayerPedId() then
            -- start scrap
            local Time = math.random(30000, 40000)
	        ScrapVehicleAnim(Time)
	    	Framework.Functions.Progressbar("scrap-vehicle", "Scrapping Vehicle..", Time, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
               
                Framework.Functions.DeleteVehicle(Vehicle)
                StopAnimTask(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 1.0)
                TriggerServerEvent('pepe-materials:server:scrap:reward')
                --local curRep = Player.PlayerData.metadata["alcoholaddiction"]
                --Player.Functions.SetMetaData('alcoholaddiction', (curRep + 1))
                Citizen.SetTimeout((1000 * 60) * 2, function()
                   Config.CanScrap = true
                end)
            end, function() -- Cancel
                StopAnimTask(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 1.0)
                Framework.Functions.Notify("Geannuleerd.", "error")
                Config.CanScrap = true
            end)
            else
                Framework.Functions.Notify("Je zit niet op de bestuurdersplaats.", "error")
            end

	    -- else
	    -- 	Framework.Functions.Notify("Dit voertuig kan niet worden geschraapt.", "error")									end
        -- end, GetVehicleNumberPlateText(Vehicle))
    else
      Framework.Functions.Notify("Je moet nog even wachten.", "error")	
    end								
end)

function IsNearScrapYard()
  if IsPedSittingInAnyVehicle(PlayerPedId()) then
      return NearScrapYard
  else
      return false
  end
end

function ScrapVehicleAnim(time)
    time = (time / 1000)
    exports['pepe-assets']:RequestAnimationDict("mp_car_bomb")
    TaskPlayAnim(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic" ,3.0, 3.0, -1, 16, 0, false, false, false)
    Scrapping = true
    Citizen.CreateThread(function()
        while Scrapping do
            TaskPlayAnim(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Citizen.Wait(2000)
			time = time - 2
            if time <= 0 then
                Scrapping = false
                StopAnimTask(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 1.0)
            end
        end
    end)
end