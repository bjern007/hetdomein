local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Framework = nil
local isLoggedIn = false
local PlayerData = {}
local PlayerJob = {}
local CurrentWorkObject_pizza = {}
local Bezig = false

local Nearby = false

local InRange = false

RegisterNetEvent('Framework:Client:OnPlayerLoaded')
AddEventHandler('Framework:Client:OnPlayerLoaded', function()
    Citizen.SetTimeout(1250, function()
    TriggerEvent("Framework:GetObject", function(obj) Framework = obj end)    
     Citizen.Wait(250)
      Framework.Functions.GetPlayerData(function(PlayerData)
        PlayerJob, onDuty = PlayerData.job, PlayerData.job.onduty 
        isLoggedIn = true 
     end)
    end) 
end)

RegisterNetEvent('Framework:Client:OnPlayerUnload')
AddEventHandler('Framework:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('Framework:Client:OnJobUpdate')
AddEventHandler('Framework:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)


RegisterNetEvent('pepe-pizzeria:client:SetStock')
AddEventHandler('pepe-pizzeria:client:SetStock', function(stock, amount)
	Config.JobData[stock] = amount
end)

-- Code
RegisterNetEvent('pepe-pizzeria:client:open:box')
AddEventHandler('pepe-pizzeria:client:open:box', function(PidId)
    TriggerServerEvent("pepe-inventory:server:OpenInventory", "stash", 'pizza_'..PidId, {maxweight = 29900, slots = 3})
    TriggerEvent("pepe-inventory:client:SetCurrentStash", 'pizza_'..PidId)
end)

-- // Loops \\ --


-- functions


RegisterNetEvent('pepe-pizzeria:client:open:payment')
AddEventHandler('pepe-pizzeria:client:open:payment', function()
  SetNuiFocus(true, true)
  SendNUIMessage({action = 'OpenPaymentPizza', payments = Config.ActivePaymentsPizza})
end)

RegisterNetEvent('pepe-pizzeria:client:open:register')
AddEventHandler('pepe-pizzeria:client:open:register', function()
	if isLoggedIn then
		if (PlayerJob ~= nil) and PlayerJob.name == "pizza" then
		SetNuiFocus(true, true)
		SendNUIMessage({action = 'OpenRegisterPizza'})
		else
		Framework.Functions.Notify('Je bent niet bevoegd hiervoor.')
		end
	end
end)

RegisterNetEvent('pepe-pizzeria:client:sync:register')
AddEventHandler('pepe-pizzeria:client:sync:register', function(RegisterConfig)
  Config.ActivePaymentsPizza = RegisterConfig
end)


function GetActiveRegister()
	return Config.ActivePaymentsPizza
  end
  
  RegisterNUICallback('Click', function()
	PlaySound(-1, "CLICK_BACK", "WEB_NAVIGATION_SOUNDS_PHONE", 0, 0, 1)
  end)
  
  RegisterNUICallback('ErrorClick', function()
	PlaySound(-1, "Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds", 0, 0, 1)
  end)
  
  RegisterNUICallback('AddPrice', function(data)
	TriggerServerEvent('pepe-pizzeria:server:add:to:register', data.Price, data.Note)
  end)
  
  RegisterNUICallback('PayReceipt', function(data)
	TriggerServerEvent('pepe-pizzeria:server:pay:receipt', data.Price, data.Note, data.Id)
  end)
  
  RegisterNUICallback('CloseNui', function()
	SetNuiFocus(false, false)
  end)

RegisterNetEvent('pepe-pizzeria:client:pizzabakken')
AddEventHandler('pepe-pizzeria:client:pizzabakken', function()
	Framework.Functions.TriggerCallback('pepe-pizza:server:get:ingredient', function(HasItems)  
	if HasItems then
	TriggerEvent('pepe-inventory:client:busy:status', true)
	TriggerEvent('pepe-sound:client:play', 'Meat', 0.5)
	Framework.Functions.Progressbar("pickup_sla", "Pizza maken...", 3500, false, true, {
		disableMovement = true,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = false,
	}, {
		animDict = "amb@prop_human_bbq@male@base",
		anim = "base",
		flags = 9,
	}, {
		model = "prop_fish_slice_01",
        bone = 28422,
        coords = { x = -0.00, y = 0.00, z = 0.00 },
        rotation = { x = 0.0, y = 0.0, z = 0.0 },
	}, {}, function() -- Done
	    StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
		TriggerEvent('pepe-inventory:client:busy:status', false)
		TriggerServerEvent('pepe-pizzeria:server:rem:stuff', "pizzameat")
		TriggerServerEvent('pepe-pizzeria:server:rem:stuff', "groenten")
		TriggerServerEvent('pepe-pizzeria:server:add:stuff', "pizza")
		TriggerEvent('pepe-inventory:client:ItemBox', Framework.Shared.Items['pizzameat'], 'remove')
		TriggerEvent('pepe-inventory:client:ItemBox', Framework.Shared.Items['groenten'], 'remove')
		TriggerEvent('pepe-inventory:client:ItemBox', Framework.Shared.Items['pizza'], 'add')
	    end, function()
		    TriggerEvent('pepe-inventory:client:busy:status', false)
		    Framework.Functions.Notify("Geannuleerd.", "error")
	    end)
    else
	    Framework.Functions.Notify("Je hebt nog niet alle ingrediënten!", "error")
        end
   end)

end)	

RegisterNetEvent('pepe-pizzeria:client:snijdgroenten')
AddEventHandler('pepe-pizzeria:client:snijdgroenten', function()
	TriggerEvent('pepe-sound:client:play', 'Pizzameat', 0.7)
	Framework.Functions.Progressbar("pickup_sla", "Groenten snijden...", 5000, false, true, {
		disableMovement = true,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = false,
	}, {
		animDict = "amb@prop_human_bbq@male@base",
		anim = "base",
		flags = 10,
	}, {
		model = "prop_knife",
        bone = 28422,
        coords = { x = -0.00, y = -0.10, z = 0.00 },
        rotation = { x = 175.0, y = 160.0, z = 0.0 },
	}, {}, function() -- Done
		StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
		TriggerServerEvent('pepe-pizzeria:server:add:stuff', 'groenten')
		TriggerEvent('pepe-inventory:client:ItemBox', Framework.Shared.Items['groenten'], 'add')
		Bezig = false
	end, function()
		Framework.Functions.Notify("Geannuleerd.", "error")
		Bezig = false
	end)
end)


RegisterNetEvent('pepe-pizzeria:client:togo')
AddEventHandler('pepe-pizzeria:client:togo', function()
	Framework.Functions.TriggerCallback('Framework:HasItem', function(HasItem)
	    if HasItem then
	        TriggerEvent('pepe-inventory:client:ItemBox', Framework.Shared.Items['pizza'], 'remove')
	        TriggerServerEvent('pepe-pizzeria:server:remove:verpak')
	        Framework.Functions.Progressbar("pickup_sla", "Pizza inpakken...", 4100, false, true, {
		        disableMovement = true,
		        disableCarMovement = false,
		        disableMouse = false,
		        disableCombat = false,
	        }, {
		        animDict = "amb@prop_human_bum_bin@idle_b",
		        anim = "idle_d",
		        flags = 10,
	        }, {}, {}, function() -- Done
		        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
	        end, function()
		        Framework.Functions.Notify("Geannuleerd.", "error")
		        Bezig = false
	        end)
	        Citizen.Wait(4100)
	        TriggerServerEvent('pepe-pizzeria:server:add:doos')
        else
            Framework.Functions.Notify("Je hebt geen pizza!", "error")
        end	
	end, 'pizza')	
end)


Citizen.CreateThread(function()
    while true do

        inRange = false
            if isLoggedIn then
                
            if (PlayerJob ~= nil) and PlayerJob.name == "pizza" then
                    local ped = PlayerPedId()
                    local pos = GetEntityCoords(ped)
                    local Bosje = GetDistanceBetweenCoords(pos, Config.Boss["Menu"]["x"], Config.Boss["Menu"]["y"], Config.Boss["Menu"]["z"])
                    if Bosje < 3 then
                        inRange = true
						Framework.Functions.DrawText3D(Config.Boss["Menu"]["x"], Config.Boss["Menu"]["y"], Config.Boss["Menu"]["z"], 'Baas')
                        if Bosje < 1.5 then
                                if IsControlJustReleased(0, Keys["E"]) then
									TriggerServerEvent('pepe-bossmenu:server:openMenu')
                                end
                        end
					end
                end
            end

        if not inRange then
            Citizen.Wait(3000)
        end

        Citizen.Wait(3)
    end
end)


RegisterNetEvent('pepe-pizzeria:client:drankjes')
AddEventHandler('pepe-pizzeria:client:drankjes', function()
    local ShopItems = {}
    ShopItems.label = "Drankautomaat"
    ShopItems.items = Config.drankjes
    ShopItems.slots = #Config.drankjes
    TriggerServerEvent("pepe-inventory:server:OpenInventory", "shop", "Drankjes_"..math.random(1, 99), ShopItems)
end)


RegisterNetEvent('pepe-pizzeria:client:vleesnemen')
AddEventHandler('pepe-pizzeria:client:vleesnemen', function()
	TriggerEvent('pepe-sound:client:play', 'fridge', 0.5)
	Framework.Functions.Progressbar("pickup_sla", "Vlees nemen...", 4100, false, true, {
		disableMovement = true,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = false,
	}, {
		animDict = "amb@prop_human_bum_bin@idle_b",
		anim = "idle_d",
		flags = 10,
	}, {}, {}, function() -- Done
		StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
		TriggerServerEvent('pepe-pizzeria:server:add:stuff', "pizzameat")
		TriggerEvent('pepe-inventory:client:ItemBox', Framework.Shared.Items['pizzameat'], 'add')
	end, function()
		Framework.Functions.Notify("Geannuleerd.", "error")
		Bezig = false
	end)
end)



---Voertuig
function Pizzascooter()
    local PlayerCoords = GetEntityCoords(PlayerPedId())
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local Area = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z, true)
    if Area < 4.0 then
        return true
    end
end

RegisterNetEvent('pepe-pizzeria:client:enter')
AddEventHandler('pepe-pizzeria:client:enter', function(House)
    local PlayerCoords = GetEntityCoords(PlayerPedId())
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
	local Area = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z, true)
    if Area < 4.0 then
        Framework.Functions.TriggerCallback('pepe-pizzeria:server:HasMoney', function(HasMoney)
            if HasMoney then
				local coords2 = Config.Locations["vehicle"].coords
                Framework.Functions.SpawnVehicle("pizzascoot", function(veh)
                    SetVehicleNumberPlateText(veh, "piz"..tostring(math.random(1000, 9999)))
                    SetEntityHeading(veh, coords2.h)
                    exports['pepe-fuel']:SetFuelLevel(veh, GetVehicleNumberPlateText(veh), 100, false)
                    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                    SetEntityAsMissionEntity(veh, true, true)
                    exports['pepe-vehiclekeys']:SetVehicleKey(GetVehicleNumberPlateText(veh), true)
                    SetVehicleEngineOn(veh, true, true)
                    Framework.Functions.Notify("Je hebt €500,- borg betaald.")
                end, coords2, true)
            else
                Framework.Functions.Notify("Je hebt niet genoeg geld voor de borg. Borg kosten zijn €500,-")
			end	
        end)
    end
end)

function StorePizzascooter()
    local PlayerCoords = GetEntityCoords(PlayerPedId())
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local Area = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z, true)
    if Area < 10.0 then
        return true
    end
end



RegisterNetEvent('pepe-pizzeria:client:store')
AddEventHandler('pepe-pizzeria:client:store', function(House)
    local PlayerCoords = GetEntityCoords(PlayerPedId())
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local Area = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z, true)
    local InVehicle = IsPedInAnyVehicle(PlayerPedId(), false)
    if Area < 10.0 then
	    if InVehicle then
            Framework.Functions.TriggerCallback('pepe-pizzeria:server:CheckBail', function(DidBail)
                if DidBail then
                    BringBackCar()
                    Framework.Functions.Notify("Je hebt €500,- borg terug ontvangen.")
                else
                    Framework.Functions.Notify("Je hebt geen borg betaald over dit voertuig.")
			    end	
            end)
        end
    end
end)




RegisterNetEvent('pepe-pizzeria:client:baasmenu')
AddEventHandler('pepe-pizzeria:client:baasmenu', function()
    if (PlayerJob ~= nil) and PlayerJob.name == "pizza" then
	    TriggerServerEvent("pepe-bossmenu:server:openMenu")
	end	
end)

RegisterNetEvent('pepe-pizzeria:client:kluis')
AddEventHandler('pepe-pizzeria:client:kluis', function()
    if (PlayerJob ~= nil) and PlayerJob.name == "pizza" then
	    TriggerServerEvent("pepe-inventory:server:OpenInventory", "stash", "pizza")
        TriggerEvent("pepe-inventory:client:SetCurrentStash", "pizza")
	end	
end)



function BringBackCar()
    local veh = GetVehiclePedIsIn(PlayerPedId())
    DeleteVehicle(veh)
end