local Framework = exports["pepe-core"]:GetCoreObject()

local VehicleStatus = {}
local VehicleDrivingDistance = {}

Framework.Functions.CreateCallback('pepe-vehicletuning:server:GetDrivingDistances', function(source, cb)
    cb(VehicleDrivingDistance)
end)


RegisterServerEvent('pepe-mechanicjob:server:stash:doekjes')
AddEventHandler('pepe-mechanicjob:server:stash:doekjes', function()
	local src = source
    local player = Framework.Functions.GetPlayer(src)
    if player.PlayerData.job.name == "mechanic" then 
        player.Functions.AddItem('cleankit', 5)
        TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items['cleankit'], "add")
    end
end)

Framework.Functions.CreateCallback('vehiclemod:server:setupVehicleStatus', function(source, cb, plate, engineHealth, bodyHealth)
	local src = source
    local engineHealth = engineHealth ~= nil and engineHealth or 1000.0
    local bodyHealth = bodyHealth ~= nil and bodyHealth or 1000.0
    if VehicleStatus[plate] == nil then 
        if IsVehicleOwned(plate) then
            local statusInfo = GetVehicleStatus(plate)
            if statusInfo == nil then 
                statusInfo =  {
                    ["engine"] = engineHealth,
                    ["body"] = bodyHealth,
                    ["radiator"] = Config.MaxStatusValues["radiator"],
                    ["axle"] = Config.MaxStatusValues["axle"],
                    ["brakes"] = Config.MaxStatusValues["brakes"],
                    ["clutch"] = Config.MaxStatusValues["clutch"],
                    ["fuel"] = Config.MaxStatusValues["fuel"],
                }
            end
            VehicleStatus[plate] = statusInfo
            TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, statusInfo)
        else
            local statusInfo = {
                ["engine"] = engineHealth,
                ["body"] = bodyHealth,
                ["radiator"] = Config.MaxStatusValues["radiator"],
                ["axle"] = Config.MaxStatusValues["axle"],
                ["brakes"] = Config.MaxStatusValues["brakes"],
                ["clutch"] = Config.MaxStatusValues["clutch"],
                ["fuel"] = Config.MaxStatusValues["fuel"],
            }
            VehicleStatus[plate] = statusInfo
            TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, statusInfo)
        end
    else
        TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, VehicleStatus[plate])
    end
end)

Framework.Functions.CreateCallback('pepe-vehicletuning:server:IsVehicleOwned', function(source, cb, plate)
    local retval = false
    Framework.Functions.ExecuteSql(false, "SELECT * FROM `characters_vehicles` WHERE `plate` = @plate", {
        ['@plate'] = plate,
    }, function(result)
        if result[1] ~= nil then
            retval = true
        end
        cb(retval)
    end)
end)

Framework.Functions.CreateCallback('pepe-vehicletuning:server:LoadStatus', function(source, cb, veh, plate)
	VehicleStatus[plate] = veh
    TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, veh)
end)

Framework.Functions.CreateCallback('vehiclemod:server:updatePart', function(source, cb, plate, part, level)
	if VehicleStatus[plate] ~= nil then
        if part == "engine" or part == "body" then
            VehicleStatus[plate][part] = level
            if VehicleStatus[plate][part] < 0 then
                VehicleStatus[plate][part] = 0
            elseif VehicleStatus[plate][part] > 1000 then
                VehicleStatus[plate][part] = 1000.0
            end
        else
            VehicleStatus[plate][part] = level
            if VehicleStatus[plate][part] < 0 then
                VehicleStatus[plate][part] = 0
            elseif VehicleStatus[plate][part] > 100 then
                VehicleStatus[plate][part] = 100
            end
        end
        TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, VehicleStatus[plate])
    end
end)

Framework.Functions.CreateCallback('pepe-vehicletuning:server:SetPartLevel', function(source, cb, plate, part, level)
	if VehicleStatus[plate] ~= nil then
        VehicleStatus[plate][part] = level
        TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, VehicleStatus[plate])
    end
end)

Framework.Functions.CreateCallback('vehiclemod:server:fixEverything', function(source, cb, plate)
	if VehicleStatus[plate] ~= nil then 
        for k, v in pairs(Config.MaxStatusValues) do
            VehicleStatus[plate][k] = v
        end
        TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, VehicleStatus[plate])
    end
end)

Framework.Functions.CreateCallback('vehiclemod:server:saveStatus', function(source, cb, plate)
	if VehicleStatus[plate] ~= nil then
        exports['ghmattimysql']:execute('UPDATE characters_vehicles SET status = @status WHERE plate = @plate', {['@status'] = json.encode(VehicleStatus[plate]), ['@plate'] = plate})
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

function GetVehicleStatus(plate)
    local retval = nil
    Framework.Functions.ExecuteSql(true, "SELECT `status` FROM `characters_vehicles` WHERE `plate` = @plate", {
        ['plate'] = plate,
    }, function(result)
        if result[1] ~= nil then
            retval = result[1].status ~= nil and json.decode(result[1].status) or nil
        end
    end)
    return retval
end

Framework.Commands.Add("setvehiclestatus", "Zet vehicle status", {{name="part", help="Type status dat je wilt bewerken"}, {name="amount", help="Level van de status"}}, true, function(source, args)
    local part = args[1]:lower()
    local level = tonumber(args[2])
    TriggerClientEvent("vehiclemod:client:setPartLevel", source, part, level)
end, "god")

Framework.Functions.CreateCallback('pepe-vehicletuning:server:GetAttachedVehicle', function(source, cb)
    cb(Config.Plates)
end)

Framework.Functions.CreateCallback('pepe-vehicletuning:server:IsMechanicAvailable', function(source, cb)
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

Framework.Functions.CreateCallback('pepe-vehicletuning:server:SetAttachedVehicle', function(source, cb, veh, k)
	if veh ~= false then
        Config.Plates[k].AttachedVehicle = veh
        TriggerClientEvent('pepe-vehicletuning:client:SetAttachedVehicle', -1, veh, k)
    else
        Config.Plates[k].AttachedVehicle = nil
        TriggerClientEvent('pepe-vehicletuning:client:SetAttachedVehicle', -1, false, k)
    end
end)

Framework.Functions.CreateCallback('pepe-vehicletuning:server:CheckForItems', function(source, cb, part)
	local src = source
    local Player = Framework.Functions.GetPlayer(src)
    local RepairPart = Player.Functions.GetItemByName(Config.RepairCostAmount[part].item)

    if RepairPart ~= nil then
        if RepairPart.amount >= Config.RepairCostAmount[part].costs then
            TriggerClientEvent('pepe-vehicletuning:client:RepaireeePart', src, part)
            Player.Functions.RemoveItem(Config.RepairCostAmount[part].item, Config.RepairCostAmount[part].costs)

            for i = 1, Config.RepairCostAmount[part].costs, 1 do
                TriggerClientEvent('inventory:client:ItemBox', src, Framework.Shared.Items[Config.RepairCostAmount[part].item], "remove")
                Citizen.Wait(500)
            end
        else
            TriggerClientEvent('Framework:Notify', src, "Je hebt niet genoeg "..Framework.Shared.Items[Config.RepairCostAmount[part].item]["label"].." (min. "..Config.RepairCostAmount[part].costs.."x)", "error")
        end
    else
        TriggerClientEvent('Framework:Notify', src, "Je hebt geen "..Framework.Shared.Items[Config.RepairCostAmount[part].item]["label"].." bij je!", "error")
    end
end)

function IsAuthorized(CitizenId)
    local retval = false
    for _, cid in pairs(Config.AuthorizedIds) do
        if cid == CitizenId then
            retval = true
            break
        end
    end
    return retval
end

Framework.Commands.Add("repairv", "Quick fix", {}, false, function(source, args)
    local _player = Framework.Functions.GetPlayer(source)
    if _player.PlayerData.job.name == "mechanic" then 
    TriggerClientEvent('pepe-repair:client:triggerMenu', source)
    end
end)


Framework.Commands.Add("repair", "Quick fix", {}, false, function(source, args)
    local _player = Framework.Functions.GetPlayer(source)
    if _player.PlayerData.job.name == "mechanic" then 
    TriggerClientEvent('pepe-mechanicjob:client:triggerMenu', source)
    end
end)

Framework.Commands.Add("takemechanic", "Neem iemand zijn Mechanic baan af", {{name="id", help="ID van de speler"}}, false, function(source, args)
    local Player = Framework.Functions.GetPlayer(source)

    if IsAuthorized(Player.PlayerData.citizenid) then
        local TargetId = tonumber(args[1])
        if TargetId ~= nil then
            local TargetData = Framework.Functions.GetPlayer(TargetId)
            if TargetData ~= nil then
                if TargetData.PlayerData.job.name == "mechanic" then
                    TargetData.Functions.SetJob("unemployed")
                    TriggerClientEvent('Framework:Notify', TargetData.PlayerData.source, "Je bent ontslagen als Autocare medewerker!")
                    TriggerClientEvent('Framework:Notify', source, "Je hebt ("..TargetData.PlayerData.charinfo.firstname..") ontslagen als Autocare medewerker!")
                else
                    TriggerClientEvent('Framework:Notify', source, "Dit is geen medewerker van Autocare!", "error")
                end
            end
        else
            TriggerClientEvent('Framework:Notify', source, "Je moet wel een Speler ID meegeven!", "error")
        end
    else
        TriggerClientEvent('Framework:Notify', source, "Je kan dit niet doen!", "error")
    end
end)

Framework.Functions.CreateCallback('pepe-vehicletuning:server:GetStatus', function(source, cb, plate)
    if VehicleStatus[plate] ~= nil and next(VehicleStatus[plate]) ~= nil then
        cb(VehicleStatus[plate])
    else
        cb(nil)
    end
end)