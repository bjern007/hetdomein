local Framework = exports["pepe-core"]:GetCoreObject()

RegisterServerEvent('lscustoms:server:setGarageBusy')
AddEventHandler('lscustoms:server:setGarageBusy', function(garage, busy)
	TriggerClientEvent('lscustoms:client:setGarageBusy', -1, garage, busy)
end)

RegisterServerEvent("LSC:buttonSelected")
AddEventHandler("LSC:buttonSelected", function(name, button)
	local src = source
	local Player = Framework.Functions.GetPlayer(src)
	if not button.purchased then
		if button.price then -- check if button have price
			if Player.Functions.RemoveMoney("cash", button.price, "lscustoms-bought") then
				TriggerClientEvent("LSC:buttonSelected", source, name, button, true)
				TriggerEvent("pepe-logs:server:SendLog", "vehicleupgrades", "Upgrade gekocht", "green", "**"..GetPlayerName(src).."** heeft en upgrade gekocht ("..name..") voor €" .. button.price)
			elseif Player.Functions.RemoveMoney("bank", button.price, "lscustoms-bought") then
				TriggerClientEvent("LSC:buttonSelected", source, name, button, true)
				TriggerEvent("pepe-logs:server:SendLog", "vehicleupgrades", "Upgrade gekocht", "green", "**"..GetPlayerName(src).."** heeft en upgrade gekocht ("..name..") voor €" .. button.price)
			else
				TriggerClientEvent("LSC:buttonSelected", source, name, button, false)
			end
		end
	else
		TriggerClientEvent("LSC:buttonSelected", source, name, button, false)
	end
end)

Framework.Functions.CreateCallback('pepe-customs:server:IsMechanicAvailable', function(source, cb)
	local amount = 0
	for k, v in pairs(Framework.Functions.GetPlayers()) do
        local Player = Framework.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "mechanic" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
    end
    cb(amount)
end)


RegisterServerEvent("lscustoms:server:SaveVehicleProps")
AddEventHandler("lscustoms:server:SaveVehicleProps", function(vehicleProps)
	local src = source
    if IsVehicleOwned(vehicleProps.plate) then
        Framework.Functions.ExecuteSql(false, "UPDATE `characters_vehicles` SET `mods` = @mods WHERE `plate` = @plate", {
		['@plate'] = vehicleProps.plate,
		['@mods'] = json.encode(vehicleProps),
		})
    end
end)

function IsVehicleOwned(plate)
    local retval = false
    Framework.Functions.ExecuteSql(true, "SELECT * FROM `characters_vehicles` WHERE `plate` = @plate", {
		['@plate'] = plate,
	}, function(result)
        if result[1] ~= nil then
            retval = true
        end
    end)
    return retval
end