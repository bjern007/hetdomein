Framework = nil
BezigMetSecretJob = false
Citizen.CreateThread(function()
	while Framework == nil do
		TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)
		Citizen.Wait(0)
	end
end)

local InUse = false

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
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

-- Citizen.CreateThread(function()
--     while true do
--         local inRange = false
--         local PlayerPed = PlayerPedId()
--         local PlayerPos = GetEntityCoords(PlayerPed)
--         local PedVehicle = GetVehiclePedIsIn(PlayerPed)
--         local Driver = GetPedInVehicleSeat(PedVehicle, -1)

--             for k, v in pairs(Config.Locations) do
--                 local dist = GetDistanceBetweenCoords(PlayerPos, Config.Locations[k]["coords"]["x"], Config.Locations[k]["coords"]["y"], Config.Locations[k]["coords"]["z"])

--                 if dist <= 7 then
--                     inRange = true
--                     --print(BezigMetSecretJob)
--                     if dist <= 4.5 then
--                             if not InUse then
--                                 DrawText3Ds(Config.Locations[k]["coords"]["x"], Config.Locations[k]["coords"]["y"], Config.Locations[k]["coords"]["z"], '~g~E~w~ Inschrijven')
--                                 if IsControlJustPressed(0, Keys["E"]) then

                                                                    
--                                     Framework.Functions.Progressbar("search_cabin", "Aanmelden...", math.random(1000, 2000), false, true, {
--                                         disableMovement = true,
--                                         disableCarMovement = true,
--                                         disableMouse = false,
--                                         disableCombat = true,
--                                     }, {}, {}, {}, function() -- Done

--                                         BezigMetSecretJob = true
--                                         TriggerServerEvent('pepe-secretjob:server:SignIn')
--                                         InUse = true          
                                    
--                                     end, function() -- Cancel
--                                         Framework.Functions.Notify("Aanmelden..", "error")
--                                         InUse = false
                                        
--                                     BezigMetSecretJob = false
--                                     end)
--                                 end
--                             else
--                                 DrawText3Ds(Config.Locations[k]["coords"]["x"], Config.Locations[k]["coords"]["y"], Config.Locations[k]["coords"]["z"], 'Al Aangemeld.')
--                             end
--                     end
--                 end
--             end

--         if not inRange then
--             Citizen.Wait(5000)
--         end

--         Citizen.Wait(3)
--     end
-- end)

-- RegisterNetEvent('pepe-secretjob:sendmail')
-- AddEventHandler('pepe-secretjob:sendmail', function(job, msg)
--     SetTimeout(math.random(2500, 4000), function()
--         local charinfo = Framework.Functions.GetPlayerData().charinfo
--             if BezigMetSecretJob then
--         TriggerServerEvent('pepe-phone:server:sendNewMail', {
--             sender = "Gangsta Willy",
--             subject = job,
--             message = msg,
--             button = {}
--         })
--             end
--         end)
-- end)


RegisterNetEvent('pepe-secretjob:inschrijven')
AddEventHandler('pepe-secretjob:inschrijven', function()
    if not BezigMetSecretJob then
            Framework.Functions.Progressbar("search_cabin", "Aanmelden...", math.random(1000, 2000), false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done

                BezigMetSecretJob = true
                TriggerServerEvent('pepe-secretjob:server:SignIn')
                InUse = true          
            
            end, function() -- Cancel
                Framework.Functions.Notify("Aanmelden..", "error")
                InUse = false
                
            BezigMetSecretJob = false
            end)
    else
        Framework.Functions.Notify("Al Aangemeld..", "error")
    end
end)

RegisterNetEvent('pepe-secretjob:sendmail')
AddEventHandler('pepe-secretjob:sendmail', function(job, msg)
    SetTimeout(math.random(2500, 4000), function()
        local charinfo = Framework.Functions.GetPlayerData().charinfo
            if BezigMetSecretJob then
        TriggerServerEvent('pepe-phone:server:sendNewMail', {
            sender = "Gangsta Willy",
            subject = job,
            message = msg,
            button = {}
        })
            end
        end)
        
		    --AddObjBlip(TargetPos)
end)


function CanDoMissions()
    if BezigMetSecretJob then  
      return true
    end
end

function AddObjBlip(TargetPos)
    Blipy['obj'] = AddBlipForCoord(xxx, yyy, zzz)
    SetBlipRoute(Blipy['obj'], true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Klant')
	EndTextCommandSetBlipName(Blipy['obj'])
end