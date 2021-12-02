local LoggedIn = false
local PlayerJob = {}
local PlayerData, Framework = nil, nil

Framework = exports["pepe-core"]:GetCoreObject()


RegisterNetEvent("Framework:Client:OnJobUpdate")
AddEventHandler("Framework:Client:OnJobUpdate", function(JobInfo)
	PlayerData.job = JobInfo
end)



RegisterNetEvent('Framework:Client:OnPlayerLoaded')
AddEventHandler('Framework:Client:OnPlayerLoaded', function()
    Citizen.SetTimeout(1250, function()
		Framework.Functions.TriggerCallback('pepe-crafting:server:get:config', function(ConfigData)
			Config.Locations = ConfigData
		end)
		PlayerData = Framework.Functions.GetPlayerData()
		PlayerJob = Framework.Functions.GetPlayerData().job
		SetupWeaponInfo()
		ItemsToItemInfo()
		SetupTrapInfo()
        LoggedIn = true
    end)
end)

RegisterNetEvent('pepe-crafting:client:open:craftstation')
AddEventHandler('pepe-crafting:client:open:craftstation', function()
	ItemsToItemInfo()
	local Crating = {}
	Crating.label = "Werkbank"
	Crating.items = GetThresholdItems()
	TriggerServerEvent('pepe-inventory:server:set:inventory:disabled', true)
	TriggerServerEvent("pepe-inventory:server:OpenInventory", "crafting", math.random(1, 99), Crating)
end)

RegisterNetEvent('pepe-crafting:client:trapstation')
AddEventHandler('pepe-crafting:client:trapstation', function()
	TriggerServerEvent("pepe-crafting:client:open:trapstation")
end)

RegisterNetEvent('pepe-crafting:client:open:trapstation')
AddEventHandler('pepe-crafting:client:open:trapstation', function()
	SetupTrapInfo()
	local crafting = {}
	crafting.label = "Traphouse Crafting"
	crafting.items = GetThresholdWeaponsTrap()
	TriggerServerEvent("pepe-inventory:server:OpenInventory", "crafting_traphouse", math.random(1, 99), crafting)
end)

CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
        local plyCoords = GetEntityCoords(plyPed)
        local letSleep = true
        
        if PlayerData and PlayerData.job.name == 'pizza' then

            local shop = Config.WeaponCrafting["location"]


            if (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, shop.x, shop.y, shop.z, true) < 10) and PlayerData.job.isboss then
                letSleep = false
                DrawMarker(2, shop.x, shop.y, shop.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                 if (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, shop.x, shop.y, shop.z, true) < 1.5) then
                    DrawText3D(shop.x, shop.y, shop.z, "~g~E~w~ - craft")
                    if IsControlJustReleased(0, 38) then
                        SetupWeaponInfo()
						local crafting = {}
					    crafting.label = "Weapon Crafting"
					    crafting.items = GetThresholdWeapons()
					    TriggerServerEvent("pepe-inventory:server:OpenInventory", "crafting_weapon", math.random(1, 99), crafting)
                    end
                end  
            end
        end


        if letSleep then
            Wait(2000)
        end

        Wait(1)
    end
end)

-- // Function \\ --

function GetThresholdItems()
	local items = {}
	for k, item in pairs(Config.CraftingItems) do
		if Framework.Functions.GetPlayerData().metadata["craftingrep"] >= Config.CraftingItems[k].threshold then
			items[k] = Config.CraftingItems[k]
		end
	end
	return items
end



function GetThresholdWeapons()
	local items = {}
	for k, item in pairs(Config.CraftingWeapons) do
		items[k] = Config.CraftingWeapons[k]
	end
	return items
end

function GetThresholdWeaponsTrap()
	local items = {}
	for k, item in pairs(Config.TrapHouseItems) do
		items[k] = Config.TrapHouseItems[k]
	end
	return items
end

function ItemsToItemInfo()
	itemInfos = {
		[1] = {costs = Framework.Shared.Items["metalscrap"]["label"] .. ": 5x, " ..Framework.Shared.Items["plastic"]["label"] .. ": 5x."},
		[2] = {costs = Framework.Shared.Items["metalscrap"]["label"] .. ": 30x, " ..Framework.Shared.Items["plastic"]["label"] .. ": 25x."},
		[3] = {costs = Framework.Shared.Items["metalscrap"]["label"] .. ": 20x, " ..Framework.Shared.Items["plastic"]["label"] .. ": 45x, "..Framework.Shared.Items["aluminum"]["label"] .. ": 28x."},
		[4] = {costs = Framework.Shared.Items["plastic"]["label"] .. ": 5x."},
		[5] = {costs = Framework.Shared.Items["metalscrap"]["label"] .. ": 36x, " ..Framework.Shared.Items["steel"]["label"] .. ": 24x, "..Framework.Shared.Items["aluminum"]["label"] .. ": 28x."},
		[6] = {costs = Framework.Shared.Items["metalscrap"]["label"] .. ": 25x, " ..Framework.Shared.Items["steel"]["label"] .. ": 37x, "..Framework.Shared.Items["copper"]["label"] .. ": 52x."},
		[7] = {costs = Framework.Shared.Items["iron"]["label"] .. ": 33x, " ..Framework.Shared.Items["steel"]["label"] .. ": 44x, "..Framework.Shared.Items["stofrol"]["label"] .. ": 10x, "..Framework.Shared.Items["aluminum"]["label"] .. ": 22x."},
		[8] = {costs = Framework.Shared.Items["metalscrap"]["label"] .. ": 32x, " ..Framework.Shared.Items["steel"]["label"] .. ": 43x, "..Framework.Shared.Items["iron"]["label"] .. ": 35x."},
		[9] = {costs = Framework.Shared.Items["iron"]["label"] .. ": 60x, " ..Framework.Shared.Items["glass"]["label"] .. ": 30x."},
		[10] = {costs = Framework.Shared.Items["aluminum"]["label"] .. ": 60x, " ..Framework.Shared.Items["glass"]["label"] .. ": 30x."},
		[11] = {costs = Framework.Shared.Items["katoen"]["label"] .. ": 10x, " ..Framework.Shared.Items["stofrol"]["label"] .. ": 5x."},
		[12] = {costs = Framework.Shared.Items["aluminum"]["label"] .. ": 75x, " ..Framework.Shared.Items["steel"]["label"] .. ": 50x, "..Framework.Shared.Items["rubber"]["label"] .. ": 5x., "..Framework.Shared.Items["iron"]["label"] .. ": 30x."},
		[13] = {costs = Framework.Shared.Items["aluminum"]["label"] .. ": 120x, " ..Framework.Shared.Items["steel"]["label"] .. ": 50x., " ..Framework.Shared.Items["plastic"]["label"] .. ": 70x., " ..Framework.Shared.Items["metalscrap"]["label"] .. ": 5x."},
		[14] = {costs = Framework.Shared.Items["aluminum"]["label"] .. ": 240x, " ..Framework.Shared.Items["steel"]["label"] .. ": 50x., " ..Framework.Shared.Items["plastic"]["label"] .. ": 130x, " ..Framework.Shared.Items["metalscrap"]["label"] .. ": 5x."},
		[15] = {costs = Framework.Shared.Items["glass"]["label"] .. ": 240x, " ..Framework.Shared.Items["rubber"]["label"] .. ": 25x., " ..Framework.Shared.Items["steel"]["label"] .. ": 70x., " ..Framework.Shared.Items["metalscrap"]["label"] .. ": 20x."},
		[16] = {costs = Framework.Shared.Items["stofrol"]["label"] .. ": 8x, " ..Framework.Shared.Items["katoen"]["label"] .. ": 40x."},
		[17] = {costs = Framework.Shared.Items["stofrol"]["label"] .. ": 38x, " ..Framework.Shared.Items["katoen"]["label"] .. ": 80x."},
		[18] = {costs = Framework.Shared.Items["plastic"]["label"] .. ": 38x, " ..Framework.Shared.Items["katoen"]["label"] .. ": 60x."},
		[19] = {costs = Framework.Shared.Items["plastic"]["label"] .. ": 75x, " ..Framework.Shared.Items["katoen"]["label"] .. ": 60x., " ..Framework.Shared.Items["glass"]["label"] .. ": 100x."},
	}
	local items = {}
	for k, item in pairs(Config.CraftingItems) do
		local itemInfo = Framework.Shared.Items[item.name:lower()]
		items[item.slot] = {
			name = itemInfo["name"],
			amount = tonumber(item.amount),
			info = itemInfos[item.slot],
			label = itemInfo["label"],
			description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
			weight = itemInfo["weight"], 
			type = itemInfo["type"], 
			unique = itemInfo["unique"], 
			useable = itemInfo["useable"], 
			image = itemInfo["image"],
			slot = item.slot,
			costs = item.costs,
			threshold = item.threshold,
			points = item.points,
		}
	end
	Config.CraftingItems = items
end

function SetupWeaponInfo()
	local items = {}
	for k, item in pairs(Config.CraftingWeapons) do
		local itemInfo = Framework.Shared.Items[item.name:lower()]
		items[item.slot] = {
			name = itemInfo["name"],
			amount = tonumber(item.amount),
			info = item.info,
			label = itemInfo["label"],
			description = item.description,
			weight = itemInfo["weight"], 
			type = itemInfo["type"], 
			unique = itemInfo["unique"], 
			useable = itemInfo["useable"], 
			image = itemInfo["image"],
			slot = item.slot,
			costs = item.costs,
			threshold = item.threshold,
			points = item.points,
		}
	end
	Config.CraftingWeapons = items
end


function SetupTrapInfo()
	itemInfos = {
		[1] = {costs = Framework.Shared.Items["metalscrap"]["label"] .. ": 25x, " ..Framework.Shared.Items["plastic"]["label"] .. ": 37x, "..Framework.Shared.Items["copper"]["label"] .. ": 52x."},
		[2] = {costs = Framework.Shared.Items["aluminum"]["label"] .. ": 240x, " ..Framework.Shared.Items["steel"]["label"] .. ": 50x, "..Framework.Shared.Items["plastic"]["label"] .. ": 130x, "..Framework.Shared.Items["metalscrap"]["label"] .. ": 5x."},
		[3] = {costs = Framework.Shared.Items["plastic"]["label"] .. ": 75x, " ..Framework.Shared.Items["katoen"]["label"] .. ": 60x, "..Framework.Shared.Items["glass"]["label"] .. ": 100x."},
	}
	local items = {}
	for k, item in pairs(Config.TrapHouseItems) do
		local itemInfo = Framework.Shared.Items[item.name:lower()]
		items[item.slot] = {
			name = itemInfo["name"],
			amount = tonumber(item.amount),
			info = itemInfos[item.slot],
			label = itemInfo["label"],
			description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
			weight = itemInfo["weight"], 
			type = itemInfo["type"], 
			unique = itemInfo["unique"], 
			useable = itemInfo["useable"], 
			image = itemInfo["image"],
			slot = item.slot,
			costs = item.costs,
			threshold = item.threshold,
			points = item.points,
		}
	end
	Config.TrapHouseItems = items
end


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
  ClearDrawOrigin()
end