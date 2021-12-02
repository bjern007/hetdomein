Framework = exports["pepe-core"]:GetCoreObject()

local PlayerData = {}
local isLoggedIn = false
local percent    = false
local searching  = false
local CurrentCops = 0

cachedBins = {}

closestBin = {
    'prop_rail_signals04',
    'prop_rail_signals03',
    'prop_elecbox_04a'
}



RegisterNetEvent('pepe-police:SetCopCount')
AddEventHandler('pepe-police:SetCopCount', function(Amount)
    CurrentCops = Amount
end)

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(10)
--         if Framework == nil then
--             TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)
--             Citizen.Wait(200)
--         end
--     end
-- end)

RegisterNetEvent("Framework:Client:OnPlayerLoaded")
AddEventHandler("Framework:Client:OnPlayerLoaded", function()
    Citizen.SetTimeout(1250, function()
    PlayerJob = Framework.Functions.GetPlayerData().job
    isLoggedIn = true
   end) 
end)


Citizen.CreateThread(function()
    for _,v in pairs(Config.PimpGuy) do
        loadmodel(v.model)
        loaddict("mini@strip_club@idles@bouncer@base")

        pimp =  CreatePed(1, v.model, v.x, v.y, v.z, v.heading, false, true)
        FreezeEntityPosition(pimp, true)
        SetEntityInvincible(pimp, true)
        SetBlockingOfNonTemporaryEvents(pimp, true)
        TaskPlayAnim(pimp,"mini@strip_club@idles@bouncer@base", "base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end
end)

function loadmodel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(10)
    end
end

function loaddict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end
end


DrawText3Ds = function(x, y, z, text)
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

Citizen.CreateThread(function()
    Citizen.Wait(3)
	while true do
		
        local sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
		
        for i = 1, #closestBin do
            local x = GetClosestObjectOfType(playerCoords, 1.0, GetHashKey(closestBin[i]), false, false, false)
            local entity = nil
			
            if DoesEntityExist(x) then
                sleep  = 5
                entity = x
                bin    = GetEntityCoords(entity)
				inRange = true
				
                DrawText3Ds(bin.x, bin.y, bin.z + 1.0, '[~g~E~w~] Koper stelen')
                if IsControlJustReleased(0, 38) then
                    if CurrentCops >= Config.PoliceNeeded then
					    if (IsInVehicle()) then
					        Framework.Functions.Notify('Lukt niet vanuit je voetuig luiaard!', 'error')
					    else 	
					        Framework.Functions.TriggerCallback('ks-koperdief:server:tang', function(HasItem)
						        if HasItem then
							        if not cachedBins[entity] then
                                        openBin(entity)
						                if not IsWearingHandshoes() then
                                            TriggerServerEvent("pepe-police:server:CreateFingerDrop", GetEntityCoords(PlayerPedId()))
                                        end
						                local luck = math.random(1, 100)
	                                    if luck <= 10 then
										    TriggerServerEvent('pepe-police:server:alert:koperdief', GetEntityCoords(PlayerPedId()), Framework.Functions.GetStreetLabel())
										end	
                                    else
						
                                        Framework.Functions.Notify('Koper is al gestolen',"error", 3500)
                                    end
								        
						        else
						            Framework.Functions.Notify('U heeft een kniptang nodig..', 'error')

       						    end
								
				            end)
						
					
					    end
					else	
					    Framework.Functions.Notify("Niet genoeg politie aanwezig ("..Config.PoliceNeeded.." Nodig)", "info")
					end	
                end
                break
            else
                sleep = 1000
            end
        end
        Citizen.Wait(sleep)
    end
end)

function IsInVehicle()
    local ply = PlayerPedId()
    if IsPedSittingInAnyVehicle(ply) then
      return true
    else
      return false
    end
  end

RegisterNetEvent('pepe-koperdief:client:verkoop')
AddEventHandler('pepe-koperdief:client:verkoop', function()
  TriggerServerEvent('pepe-koperdief:server:sell:items')
end)


function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
    local model = GetEntityModel(PlayerPedId())
    local retval = true
    if model == GetHashKey("mp_m_freemode_01") then
        if MaleNoHandshoes[armIndex] ~= nil and MaleNoHandshoes[armIndex] then
            retval = false
        end
    else
        if FemaleNoHandshoes[armIndex] ~= nil and FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval
end


Citizen.CreateThread(function()
    Citizen.Wait(100)
    while true do

        local sleep = 1000

        if percent then

            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            for i = 1, #closestBin do

                local x = GetClosestObjectOfType(playerCoords, 1.0, GetHashKey(closestBin[i]), false, false, false)
                local entity = nil
                
                if DoesEntityExist(x) then
                    sleep  = 5
                    entity = x
                    bin    = GetEntityCoords(entity)
                    DrawText3Ds(bin.x, bin.y, bin.z + 1.5, TimeLeft .. '~g~%~s~')
                    break
                end
            end
        end
        Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if searching then
            DisableControlAction(0, 73) 
        end
    end
end)

openBin = function(entity)
    TriggerEvent('pepe-sound:client:play', 'schaar', 0.8)
	Framework.Functions.Progressbar("search_register", "Koper stelen..", 9000, false, true, {
		disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,

	}, {
		animDict = "amb@prop_human_bbq@male@base",
		anim = "base",
	}, {
		model = "prop_tool_pliers",
        bone = 28422,
        coords = { x = 0.0, y = 0.0, z = 0.0 },
        rotation = { x = 60.0, y = -80.0, z = 0.20 },
	}, {}, function() -- Done]
	
        searching = true
        cachedBins[entity] = true
        Framework.Functions.TriggerCallback('pepe-koperdief:getItem', function(result)
        end)
        ClearPedTasks(PlayerPedId())
        StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
        searching = false  
    end, function() -- Cancel
        GetMoney = false
        StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
        ClearPedTasks(PlayerPedId())
        Framework.Functions.Notify("Proces geannuleerd..", "error")
    end)
	
end



MaleNoHandshoes = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = true,
    [14] = true,
    [15] = true,
    [18] = true,
    [26] = true,
    [52] = true,
    [53] = true,
    [54] = true,
    [55] = true,
    [56] = true,
    [57] = true,
    [58] = true,
    [59] = true,
    [60] = true,
    [61] = true,
    [62] = true,
    [112] = true,
    [113] = true,
    [114] = true,
    [118] = true,
    [125] = true,
    [132] = true,
}

FemaleNoHandshoes = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = true,
    [14] = true,
    [15] = true,
    [19] = true,
    [59] = true,
    [60] = true,
    [61] = true,
    [62] = true,
    [63] = true,
    [64] = true,
    [65] = true,
    [66] = true,
    [67] = true,
    [68] = true,
    [69] = true,
    [70] = true,
    [71] = true,
    [129] = true,
    [130] = true,
    [131] = true,
    [135] = true,
    [142] = true,
    [149] = true,
    [153] = true,
    [157] = true,
    [161] = true,
    [165] = true,
}

