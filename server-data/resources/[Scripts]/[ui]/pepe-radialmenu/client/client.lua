local AnimSet = "default"

-- Code

RegisterNetEvent('AnimSet:default');
AddEventHandler('AnimSet:default', function()
    ResetPedMovementClipset(PlayerPedId(), 0)
    AnimSet = "default";
end)

RegisterNetEvent('AnimSet:Hurry');
AddEventHandler('AnimSet:Hurry', function()
    RequestAnimSet("move_m@hurry@a")
    while not HasAnimSetLoaded("move_m@hurry@a") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@hurry@a", true)
    AnimSet = "move_m@hurry@a";
end)

RegisterNetEvent('AnimSet:Business');
AddEventHandler('AnimSet:Business', function()
    RequestAnimSet("move_m@business@a")
    while not HasAnimSetLoaded("move_m@business@a") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@business@a", true)
    AnimSet = "move_m@business@a";
end)

RegisterNetEvent('AnimSet:Brave');
AddEventHandler('AnimSet:Brave', function()
    RequestAnimSet("move_m@brave")
    while not HasAnimSetLoaded("move_m@brave") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@brave", true)
    AnimSet = "move_m@brave";
end)

RegisterNetEvent('AnimSet:Tipsy');
AddEventHandler('AnimSet:Tipsy', function()
    RequestAnimSet("move_m@drunk@slightlydrunk")
    while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
        Citizen.Wait(0)
    end
    SetPedMovementClipset(PlayerPedId(), "move_m@drunk@slightlydrunk", true)
    AnimSet = "move_m@drunk@slightlydrunk";
end)

RegisterNetEvent('AnimSet:Injured');
AddEventHandler('AnimSet:Injured', function()
    RequestAnimSet("move_m@injured")
    while not HasAnimSetLoaded("move_m@injured") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@injured", true)
    AnimSet = "move_m@injured";
end)

RegisterNetEvent('AnimSet:ToughGuy');
AddEventHandler('AnimSet:ToughGuy', function()
    RequestAnimSet("move_m@tough_guy@")
    while not HasAnimSetLoaded("move_m@tough_guy@") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@tough_guy@", true)
    AnimSet = "move_m@tough_guy@";
end)

RegisterNetEvent('AnimSet:Sassy');
AddEventHandler('AnimSet:Sassy', function()
    RequestAnimSet("move_m@sassy")
    while not HasAnimSetLoaded("move_m@sassy") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@sassy", true)
    AnimSet = "move_m@sassy";
end)

RegisterNetEvent('AnimSet:Sad');
AddEventHandler('AnimSet:Sad', function()
    RequestAnimSet("move_m@sad@a")
    while not HasAnimSetLoaded("move_m@sad@a") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@sad@a", true)
    AnimSet = "move_m@sad@a";
end)

RegisterNetEvent('AnimSet:Posh');
AddEventHandler('AnimSet:Posh', function()
    RequestAnimSet("move_m@posh@")
    while not HasAnimSetLoaded("move_m@posh@") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@posh@", true)
    AnimSet = "move_m@posh@";
end)

RegisterNetEvent('AnimSet:Alien');
AddEventHandler('AnimSet:Alien', function()
    RequestAnimSet("move_m@alien")
    while not HasAnimSetLoaded("move_m@alien") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@alien", true)
    AnimSet = "move_m@alien";
end)

RegisterNetEvent('AnimSet:NonChalant');
AddEventHandler('AnimSet:NonChalant', function()
    RequestAnimSet("move_m@non_chalant")
    while not HasAnimSetLoaded("move_m@non_chalant") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@non_chalant", true)
    AnimSet = "move_m@non_chalant";
end)

RegisterNetEvent('AnimSet:Hobo');
AddEventHandler('AnimSet:Hobo', function()
    RequestAnimSet("move_m@hobo@a")
    while not HasAnimSetLoaded("move_m@hobo@a") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@hobo@a", true)
    AnimSet = "move_m@hobo@a";
end)

RegisterNetEvent('AnimSet:Money');
AddEventHandler('AnimSet:Money', function()
    RequestAnimSet("move_m@money")
    while not HasAnimSetLoaded("move_m@money") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@money", true)
    AnimSet = "move_m@money";
end)

RegisterNetEvent('AnimSet:Swagger');
AddEventHandler('AnimSet:Swagger', function()
    RequestAnimSet("move_m@swagger")
    while not HasAnimSetLoaded("move_m@swagger") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@swagger", true)
    AnimSet = "move_m@swagger";
end)

RegisterNetEvent('AnimSet:Joy');
AddEventHandler('AnimSet:Joy', function()
    RequestAnimSet("move_m@joy")
    while not HasAnimSetLoaded("move_m@joy") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@joy", true)
    AnimSet = "move_m@joy";
end)

RegisterNetEvent('AnimSet:Moon');
AddEventHandler('AnimSet:Moon', function()
    RequestAnimSet("move_m@powerwalk")
    while not HasAnimSetLoaded("move_m@powerwalk") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@powerwalk", true)
    AnimSet = "move_m@powerwalk";
end)

RegisterNetEvent('AnimSet:Shady');
AddEventHandler('AnimSet:Shady', function()
    RequestAnimSet("move_m@shadyped@a")
    while not HasAnimSetLoaded("move_m@shadyped@a") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@shadyped@a", true)
    AnimSet = "move_m@shadyped@a";
end)

RegisterNetEvent('AnimSet:Tired');
AddEventHandler('AnimSet:Tired', function()
    RequestAnimSet("move_m@tired")
    while not HasAnimSetLoaded("move_m@tired") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@tired", true)
    AnimSet = "move_m@tired";
end)

RegisterNetEvent('AnimSet:Sexy');
AddEventHandler('AnimSet:Sexy', function()
    RequestAnimSet("move_f@sexy")
    while not HasAnimSetLoaded("move_f@sexy") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_f@sexy", true)
    AnimSet = "move_f@sexy";
end)

RegisterNetEvent('AnimSet:ManEater');
AddEventHandler('AnimSet:ManEater', function()
    RequestAnimSet("move_f@maneater")
    while not HasAnimSetLoaded("move_f@maneater") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_f@maneater", true)
    AnimSet = "move_f@maneater";
end)

RegisterNetEvent('AnimSet:ChiChi');
AddEventHandler('AnimSet:ChiChi', function()
    RequestAnimSet("move_f@chichi")
    while not HasAnimSetLoaded("move_f@chichi") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_f@chichi", true)
    AnimSet = "move_f@chichi";
end)

RegisterNetEvent("expressions")
AddEventHandler("expressions", function(pArgs)
    if #pArgs ~= 1 then return end
    local expressionName = pArgs[1]
    SetFacialIdleAnimOverride(PlayerPedId(), expressionName, 0)
    return
end)

RegisterNetEvent("expressions:clear")
AddEventHandler("expressions:clear",function() 
    ClearFacialIdleAnimOverride(PlayerPedId()) 
end)

--  // Main Functions \\ --

RegisterNetEvent('pepe-radialmenu:client:flip:vehicle')
AddEventHandler('pepe-radialmenu:client:flip:vehicle', function()
    local Vehicle, Distance = Framework.Functions.GetClosestVehicle()
    if Vehicle ~= 0 and Distance < 1.7 then
        Framework.Functions.Progressbar("flip-vehicle", "Voertuig aan het omduwen", math.random(10000, 15000), false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "random@mugging4",
            anim = "struggle_loop_b_thief",
            flags = 49,
        }, {}, {}, function() -- Done
             SetVehicleOnGroundProperly(Vehicle)
            --  Framework.Functions.Notify("Succes", "success")
        end, function()
            Framework.Functions.Notify("Gefaald", "error")
        end)
    else
        Framework.Functions.Notify("Geen voertuig in de buurt", "error")
    end
end)

RegisterNetEvent("pepe-radialmenu:client:send:panic:button")
AddEventHandler("pepe-radialmenu:client:send:panic:button",function()
  Framework.Functions.TriggerCallback('Framework:HasItem', function(HasItem)
      if HasItem then
          local Player = Framework.Functions.GetPlayerData()
          local Info = {['Firstname'] = Player.charinfo.firstname, ['Lastname'] = Player.charinfo.lastname, ['Callsign'] = Player.metadata['callsign']}
          local StreetLabel = Framework.Functions.GetStreetLabel()
          TriggerServerEvent('pepe-police:server:send:alert:panic:button', GetEntityCoords(PlayerPedId()), StreetLabel, Info)
      else
          Framework.Functions.Notify(_U("noradio"), "error")
      end
  end, "radio")
end)

RegisterNetEvent("pepe-radialmenu:client:send:down")
AddEventHandler("pepe-radialmenu:client:send:down",function(Type)
    local Player = Framework.Functions.GetPlayerData()
    local Info = {['Firstname'] = Player.charinfo.firstname, ['Lastname'] = Player.charinfo.lastname, ['Callsign'] = Player.metadata['callsign']}
    local StreetLabel = Framework.Functions.GetStreetLabel()
    local Priority = 2
    if Type == 'Urgent' then
        Priority = 3
    end
    TriggerServerEvent('pepe-police:server:send:alert:officer:down', GetEntityCoords(PlayerPedId()), StreetLabel, Info, Priority)
end)

RegisterNetEvent("pepe-radialmenu:client:open:door")
AddEventHandler("pepe-radialmenu:client:open:door",function(DoorNumber)
    local Vehicle = GetVehiclePedIsIn(PlayerPedId())
    if GetVehicleDoorAngleRatio(Vehicle, DoorNumber) > 0.0 then
        SetVehicleDoorShut(Vehicle, DoorNumber, false)
    else
        SetVehicleDoorOpen(Vehicle, DoorNumber, false, false)
    end
end)

RegisterNetEvent("pepe-radialmenu:client:enter:playerradio")
AddEventHandler("pepe-radialmenu:client:enter:playerradio",function()
    Framework.Functions.TriggerCallback('Framework:HasItem', function(HasItem)
        if HasItem then
            Framework.Functions.GetPlayerData(function(PlayerData)
                if PlayerData ~= nil and PlayerData.money ~= nil then
                    favorietefrequentie = PlayerData.metadata["favofrequentie"]
                end
            end)     
            if favorietefrequentie > 4 then       
            exports['pepe-radio']:SetRadioState(true)
            exports['pepe-radio']:JoinRadio(favorietefrequentie, 1)
            Framework.Functions.Notify("Verbonden met "..favorietefrequentie, "info", 8500)
            else
                Framework.Functions.Notify("Je hebt nog geen favoriete frequentie ingesteld. Doe dit met /frequentie GETAL", "info", 8500)
            end
        else
            Framework.Functions.Notify("Je hebt geen radio..", "error", 4500)
        end
    end, "radio")
end)
RegisterNetEvent("pepe-radialmenu:client:enter:radio")
AddEventHandler("pepe-radialmenu:client:enter:radio",function(RadioNumber)
    Framework.Functions.TriggerCallback('Framework:HasItem', function(HasItem)
        if HasItem then
            exports['pepe-radio']:SetRadioState(true)
            exports['pepe-radio']:JoinRadio(RadioNumber, 1)
            Framework.Functions.Notify("Verbonden met OC-0"..RadioNumber, "info", 8500)
        else
            Framework.Functions.Notify("Je hebt geen radio..", "error", 4500)
        end
    end, "radio")
end)

RegisterNetEvent('pepe-radialmenu:client:setExtra')
AddEventHandler('pepe-radialmenu:client:setExtra', function(data)
    local extra = tonumber(data)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)
 
    if veh ~= nil then
        local plate = GetVehicleNumberPlateText(closestVehicle)
 
        if GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
            if DoesExtraExist(veh, extra) then 
                if IsVehicleExtraTurnedOn(veh, extra) then
                    enginehealth = GetVehicleEngineHealth(veh)
                    bodydamage = GetVehicleBodyHealth(veh)
                    SetVehicleExtra(veh, extra, 1)
                    -- SetVehicleEngineHealth(veh, enginehealth)
                    -- SetVehicleBodyHealth(veh, bodydamage)
                    Framework.Functions.Notify('Extra ' .. extra .. ' uitgezet', 'error', 2500)
                else
                    enginehealth = GetVehicleEngineHealth(veh)
                    bodydamage = GetVehicleBodyHealth(veh)
                    SetVehicleExtra(veh, extra, 0)
                    -- SetVehicleEngineHealth(veh, enginehealth)
                    -- SetVehicleBodyHealth(veh, bodydamage)
                    Framework.Functions.Notify('Extra ' .. extra .. ' aangezet', 'success', 2500)
                end    
            else
                Framework.Functions.Notify('Extra ' .. extra .. ' is niet beschikbaar', 'error', 2500)
            end
        else
            Framework.Functions.Notify(_U("notdriver"), 'error', 2500)
        end
    end
end)


RegisterNetEvent("pepe-radialmenu:client:tattooshop")
AddEventHandler("pepe-radialmenu:client:tattooshop", function()
    local coords = GetEntityCoords(PlayerPedId())
    local closest = 5000
    local closestCoords2

    for k,v in pairs(TattoShops) do 
        local dstcheck = GetDistanceBetweenCoords(coords, v)

        if dstcheck < closest then
            closest = dstcheck
            closestCoords2 = v
        end
    end
   
    SetNewWaypoint(closestCoords2)
    Framework.Functions.Notify('Het dichtsbijzijnde tattooshop is gemarkeerd', 'success', 2500)
end)

TattoShops = {
    vector3(1322.6,-1651.9,51.2),
    vector3(-1153.6,-1425.6,4.9),
    vector3(322.1,180.4,103.5),
    vector3(-3170.0,1075.0,20.8),
    vector3(1864.6,3747.7,33.0),
    vector3(-293.7,6200.0,31.4)
}


--Berber
RegisterNetEvent("pepe-radialmenu:client:barbershop")
AddEventHandler("pepe-radialmenu:client:barbershop", function()
    local coords = GetEntityCoords(PlayerPedId())
    local closest = 1000
    local closestCoords2

    for k,v in pairs(BarberShops) do 
        local dstcheck = GetDistanceBetweenCoords(coords, v) 

        if dstcheck < closest then
            closest = dstcheck
            closestCoords2 = v
        end
    end
   
    SetNewWaypoint(closestCoords2)
    Framework.Functions.Notify('Het dichtsbijzijnde kapper is gemarkeerd', 'success', 2500)
end)

BarberShops = {
    vector3(1932.0756835938,3729.6706542969,32.844413757324),
	vector3(-278.19036865234,6228.361328125,31.695510864258),
	vector3(1211.9903564453,-472.77117919922,66.207984924316),
	vector3(-33.224239349365,-152.62608337402,57.076496124268),
	vector3(136.7181854248,-1708.2673339844,29.291622161865),
	vector3(-815.18896484375,-184.53868103027,37.568943023682),
	vector3(-1283.2886962891,-1117.3210449219,6.9901118278503)
}

Gas = {
    vector3(259.85552,-1255.905,29.14289),
    vector3(623.18481,267.27166,103.08937),
    vector3(-527.314,-1210.852,18.184837),
    vector3(-2553.499,2330.7568,33.060066),
    vector3(175.22877,6601.7397,31.848894),
    vector3(2682.0939,3264.8037,55.240524),
    vector3(1787.4063,3330.8298,41.280876),
    vector3(1180.8928,-335.2229,69.177276),
    vector3(1209.2497,-1400.155,35.224136),
    vector3(-75.455,-1760.967,29.549264),
    vector3(815.65509,-1026.576,26.246015)
}   

RegisterNetEvent("pepe-radialmenu:client:benzine")
AddEventHandler("pepe-radialmenu:client:benzine", function()
    local coords = GetEntityCoords(PlayerPedId())
    local closest = 1000
    local closestCoords2

    for k,v in pairs(Gas) do 
        local dstcheck = GetDistanceBetweenCoords(coords, v)

        if dstcheck < closest then
            closest = dstcheck
            closestCoords2 = v
        end
    end
   
    SetNewWaypoint(closestCoords2)
    Framework.Functions.Notify('Het dichtsbijzijnde tankstation is gemarkeerd.', 'success', 2500)
end)

RegisterNetEvent("pepe-radialmenu:client:clothing")
AddEventHandler("pepe-radialmenu:client:clothing", function()
    local coords = GetEntityCoords(PlayerPedId())
    local closest = 1000
    local closestCoords2

    for k,v in pairs(clothShop) do 
        local dstcheck = GetDistanceBetweenCoords(coords, v)

        if dstcheck < closest then
            closest = dstcheck
            closestCoords2 = v
        end
    end
   
    SetNewWaypoint(closestCoords2)
    Framework.Functions.Notify('Het dichtsbijzijnde kledingwinkel is gemarkeerd.', 'success', 2500)
end)

clothShop = {
    vector3(1693.45667,4823.17725,42.1631294),
	vector3(-1177.865234375,-1780.5612792969,3.9084651470184),
	vector3(198.4602355957,-1646.7690429688,29.803218841553),
	vector3(298.19,-599.43,43.29),
	vector3(-712.215881,-155.352982,37.4151268),
	vector3(123.779823,-301.616455,54.557827),
	vector3(-1192.94495,-772.688965,17.3255997),
	vector3(471.61776, 25.734638,264.04019),
	vector3(425.236,-806.008,28.491),
	vector3(-162.658,-303.397,38.733),
	vector3(75.950,-1392.891,28.376),
	vector3(-822.194,-1074.134,10.328),
	vector3(-1450.711,-236.83,48.809),
	vector3(4.254,6512.813,30.877),
	vector3(615.180,2762.933,41.088),
	vector3(1196.785,2709.558,37.222),
	vector3(-3171.453,1043.857,19.863)
} 

RegisterNetEvent("pepe-radialmenu:client:deleteblips")
AddEventHandler("pepe-radialmenu:client:deleteblips", function()
    DeleteWaypoint()
    Framework.Functions.Notify('Blips verwijderd', 'success', 2500) -- notify 
end)