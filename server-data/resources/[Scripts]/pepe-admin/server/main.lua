local Framework = exports["pepe-core"]:GetCoreObject()

local permissions = {
    ["kick"] = "admin",
    ["ban"] = "admin",
    ["noclip"] = "admin",
    ["kickall"] = "admin",
}


Framework.Commands.Add("spec", "emm1", {}, false, function(source, args)
	TriggerClientEvent('spectatelu:spectate', source, target)
end, "admin")

Framework.Functions.CreateCallback('spectatelu:getPlayerData', function(source, cb, id)
    local Player = Framework.Functions.GetPlayers()
    if Player ~= nil then
        cb(Player)
    end
end)


RegisterServerEvent('pepe-admin:server:togglePlayerNoclip')
AddEventHandler('pepe-admin:server:togglePlayerNoclip', function(playerId, reason)
    local src = source
    if Framework.Functions.HasPermission(src, permissions["noclip"]) then
        TriggerClientEvent("pepe-admin:client:toggleNoclip", playerId)
    end
end)

RegisterServerEvent('pepe-admin:server:killPlayer')
AddEventHandler('pepe-admin:server:killPlayer', function(playerId)
    TriggerClientEvent('hospital:client:KillPlayer', playerId)
end)

RegisterServerEvent('pepe-admin:server:kickPlayer')
AddEventHandler('pepe-admin:server:kickPlayer', function(playerId, reason)
    local src = source
    if Framework.Functions.HasPermission(src, permissions["kick"]) then
        DropPlayer(playerId, "Je bent uit QuackCity gekickt vanwege:\n"..reason.."\n\n🔸 Discord: https://quackcity.nl")
    else
    end
end)

RegisterServerEvent('pepe-admin:server:Freeze')
AddEventHandler('pepe-admin:server:Freeze', function(playerId, toggle)
    local src = source
    TriggerClientEvent('pepe-admin:client:Freeze', playerId, toggle)
end)

RegisterServerEvent('pepe-admin:server:OpenSkinMenu')
AddEventHandler('pepe-admin:server:OpenSkinMenu', function(targetId, menu)
    TriggerClientEvent("raid_clothes:hasEnough", targetId, menu)
end)

RegisterServerEvent('pepe-admin:server:banPlayer')
AddEventHandler('pepe-admin:server:banPlayer', function(playerId, time, reason)
    local src = source
    if Framework.Functions.HasPermission(src, permissions["ban"]) then
        Framework.Functions.ExecuteSql(false, "INSERT INTO `server_bans` (`name`, `steam`, `license`, `reason`, `bannedby`) VALUES (@name, @steam, @license, @reason, @bannedby)" , {
            ['@name'] = GetPlayerName(playerId),
            ['@steam'] = GetPlayerIdentifiers(playerId)[1],
            ['@license'] = GetPlayerIdentifiers(playerId)[2],
            ['@reason'] = reason,
            ['@bannedby'] = GetPlayerName(src),
        })
        DropPlayer(playerId, "Je bent verbannen. De reden hiervoor luid:\n"..reason.."\n")
    end
end)

RegisterServerEvent('pepe-admin:server:revivePlayer')
AddEventHandler('pepe-admin:server:revivePlayer', function(target)
    TriggerClientEvent('pepe-hospital:client:revive', target)
end)

RegisterServerEvent('pepe-admin:server:open:inventory')
AddEventHandler('pepe-admin:server:open:inventory', function(TagetId)
  if Framework.Functions.HasPermission(source, 'admin') then
    TriggerClientEvent('pepe-admin:client:open:target:inventory', source, TagetId)
  else
    TriggerClientEvent('Framework:Notify', source, "Je hebt geen permissie hiervoor.", 'error')
  end
end)

RegisterServerEvent('pepe-admin:server:give:clothing')
AddEventHandler('pepe-admin:server:give:clothing', function(TargetId)
  if Framework.Functions.HasPermission(source, 'admin') then
    TriggerClientEvent("pepe-clothing:client:openMenu", TargetId)
  else
    TriggerClientEvent('Framework:Notify', source, "Je hebt geen permissie hiervoor.", 'error')
  end
end)

RegisterServerEvent('pepe-admin:server:OpenSkinMenu')
AddEventHandler('pepe-admin:server:OpenSkinMenu', function(targetId, menu)
    TriggerClientEvent("raid_clothes:hasEnough", targetId, menu)
end)


Framework.Commands.Add("admin", "Open admin menu", {}, false, function(source, args)
    local group = Framework.Functions.GetPermission(source)
    if group == "admin" or group == 'god' then
    TriggerClientEvent('pepe-admin:client:openMenu:84848484', source, group)
	end
end)

Framework.Commands.Add("sm", "Server melding", {}, false, function(source, args)
    local msg = table.concat(args, " ")
    for k, v in pairs(Framework.Functions.GetPlayers()) do
        local Player = Framework.Functions.GetPlayer(v)
        if Player ~= nil then 
	        TriggerClientEvent('chat:addMessage', v, {
            template = '<div class="chat-message" style="background-color: rgba(66, 66, 66, 0.75); color: white;"><b>MEDEDELING</b> {0}</div>',
            args = {msg}
            })
		end
	end
end, "god")

RegisterServerEvent('pepe-admin:checkperms')
AddEventHandler('pepe-admin:checkperms', function(target)
    local Player = Framework.Functions.GetPlayer(src)
    local group = Framework.Functions.GetPermission(source)   
    if group == "admin" or group == 'god' then
        TriggerClientEvent("pepe-admin:client:toggleNoclip", source)
    end
end)

RegisterServerEvent('pepe-admin:checkperm')
AddEventHandler('pepe-admin:checkperm', function(target)
    local Player = Framework.Functions.GetPlayer(src)
    local group = Framework.Functions.GetPermission(source)   
    if group == "admin" or group == 'god' then
        TriggerClientEvent('pepe-admin:client:openMenu:84848484', source, group)
    end
end)


Framework.Commands.Add("givenuifocus", "Give nui focus", {{name="id", help="Speler id"}, {name="focus", help="Turn focus on / off"}, {name="mouse", help="Turn mouse on / off"}}, true, function(source, args)
    local playerid = tonumber(args[1])
    local focus = args[2]
    local mouse = args[3]

    TriggerClientEvent('pepe-admin:client:GiveNuiFocus', playerid, focus, mouse)
end, "admin")

Framework.Commands.Add("enablekeys", "Enable all keys for player.", {{name="id", help="Player id"}}, true, function(source, args)
    local playerid = tonumber(args[1])

    TriggerClientEvent('pepe-admin:client:EnableKeys', playerid)
end, "admin")

Framework.Commands.Add("vehwipe", "Vehicle wiper.", {}, false, function(source, args)
    local group = Framework.Functions.GetPermission(source)
	    local src = source
    if group == "admin" or group == 'god' then
        TriggerClientEvent("pepe-admin:cleanup:delallveh", -1)
    -- for k, v in pairs(Framework.Functions.GetPlayers()) do
    --     local Player = Framework.Functions.GetPlayer(v)
    --     if Player ~= nil then
    --      TriggerClientEvent('Framework:Notify', v, "Unoccupied vehicles wiped.", "info", 15000)
	-- 	 end
	-- end
	end
end)


Framework.Commands.Add("objectwipe", "Object wiper.", {}, false, function(source, args)
    local group = Framework.Functions.GetPermission(source)
	    local src = source
    if group == "admin" or group == 'god' then
	TriggerClientEvent("pepe-admin:cleanup:objectwipe", -1)
    -- for k, v in pairs(Framework.Functions.GetPlayers()) do
    --     local Player = Framework.Functions.GetPlayer(v)
    --     if Player ~= nil then
    --      TriggerClientEvent('Framework:Notify', v, "Objecten gewiped.", "info", 15000)
	-- 	 end
	-- end
	end
end)

Framework.Commands.Add("warn", "Geef speler een waarschuwing", {{name="ID", help="Person"}, {name="Reden", help="Wat is de reden?"}}, true, function(source, args)
    local targetPlayer = Framework.Functions.GetPlayer(tonumber(args[1]))
    local senderPlayer = Framework.Functions.GetPlayer(source)
    table.remove(args, 1)
    local msg = table.concat(args, " ")

    local myName = senderPlayer.PlayerData.name

    local warnId = "WARN-"..math.random(1111, 9999)

    if targetPlayer ~= nil then
        TriggerClientEvent('chatMessage', targetPlayer.PlayerData.source, "SYSTEM", "error", "Je bent gewaarschuwd door: "..GetPlayerName(source)..", met als reden: "..msg)
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Je hebt "..GetPlayerName(targetPlayer.PlayerData.source).." gewaarschuwd voor: "..msg)
        Framework.Functions.ExecuteSql(false, "INSERT INTO `characters_warns` (`senderIdentifier`, `targetIdentifier`, `reason`, `warnId`) VALUES (@senderIdentifier, @targetIdentifier, @msg, @warnId)", {
            ['@senderIdentifier'] = senderPlayer.PlayerData.steam,
            ['@targetIdentifier'] = targetPlayer.PlayerData.steam,
            ['@reason'] = msg,
            ['@warnId'] = warnId,
        })
    else
        TriggerClientEvent('Framework:Notify', source, 'Niet aanwezig.', 'error')
    end 
end, "admin")

Framework.Commands.Add("checkwarns", "Check waarschuwingen op speler", {{name="ID", help="Persoon"}, {name="Warning", help="Number of warning, (1, 2 of 3 etc..)"}}, false, function(source, args)
    if args[2] == nil then
        local targetPlayer = Framework.Functions.GetPlayer(tonumber(args[1]))
        Framework.Functions.ExecuteSql(false, "SELECT * FROM `characters_warns` WHERE `targetIdentifier` = @target", {
            ['@target'] = targetPlayer.PlayerData.steam,
        }, function(result)
            TriggerClientEvent('chatMessage', source, "SYSTEM", "warning", targetPlayer.PlayerData.name.." heeft "..tablelength(result).." warnings!")
        end)
    else
        local targetPlayer = Framework.Functions.GetPlayer(tonumber(args[1]))

        Framework.Functions.ExecuteSql(false, "SELECT * FROM `characters_warns` WHERE `targetIdentifier` = @target", {
            ['@target'] = targetPlayer.PlayerData.steam,
        }, function(warnings)
            local selectedWarning = tonumber(args[2])

            if warnings[selectedWarning] ~= nil then
                local sender = Framework.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)

                TriggerClientEvent('chatMessage', source, "SYSTEM", "warning", targetPlayer.PlayerData.name.." door "..sender.PlayerData.name..", Reden: "..warnings[selectedWarning].reason)
            end
        end)
    end
end, "admin")

Framework.Commands.Add("remove", "Remove warning from person", {{name="ID", help="Persoon"}, {name="Warning", help="Number of warning, (1, 2 of 3 etc..)"}}, true, function(source, args)
    local targetPlayer = Framework.Functions.GetPlayer(tonumber(args[1]))

    Framework.Functions.ExecuteSql(false, "SELECT * FROM `characters_warns` WHERE `targetIdentifier` = @target", {
        ['@target'] = targetPlayer.PlayerData.steam,
    }, function(warnings)
        local selectedWarning = tonumber(args[2])

        if warnings[selectedWarning] ~= nil then
            local sender = Framework.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)

            TriggerClientEvent('chatMessage', source, "SYSTEM", "warning", "You have warning ("..selectedWarning..") removed, Reason: "..warnings[selectedWarning].reason)
            Framework.Functions.ExecuteSql(false, "DELETE FROM `characters_warns` WHERE `warnId` = @warnId", {
                ['@warnId'] = warnings[selectedWarning].warnId,
            })
        end
    end)
end, "admin")

function tablelength(table)
    local count = 0
    for _ in pairs(table) do 
        count = count + 1 
    end
    return count
end

Framework.Commands.Add("setmodel", "Change into a model of your choice..", {{name="model", help="Name of the model"}, {name="id", help="Player ID (leave blank for yourself)"}}, false, function(source, args)
    local model = args[1]
    local target = tonumber(args[2])

    if model ~= nil or model ~= "" then
        if target == nil then
            TriggerClientEvent('pepe-admin:client:SetModel', source, tostring(model))
        else
            local Trgt = Framework.Functions.GetPlayer(target)
            if Trgt ~= nil then
                TriggerClientEvent('pepe-admin:client:SetModel', target, tostring(model))
            else
                TriggerClientEvent('Framework:Notify', source, "This person is not in town yeet..", "error")
            end
        end
    else
        TriggerClientEvent('Framework:Notify', source, "You have not provided a Model ..", "error")
    end
end, "admin")

Framework.Commands.Add("setspeed", "Change into a model of your choice ..", {}, false, function(source, args)
    local speed = args[1]

    if speed ~= nil then
        TriggerClientEvent('pepe-admin:client:SetSpeed', source, tostring(speed))
    else
        TriggerClientEvent('Framework:Notify', source, "You did not specify Speed ​​.. (`fast` for super-run,` normal` for normal)", "error")
    end
end, "admin")

RegisterServerEvent('pepe-admin:server:SaveCar')
AddEventHandler('pepe-admin:server:SaveCar', function(mods, vehicle, hash, plate)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    Framework.Functions.ExecuteSql(false, "SELECT * FROM `player_vehicles` WHERE `plate` = @plate", {
        ['@plate'] = plate,
    }, function(result)
        if result[1] == nil then
            -- Framework.Functions.ExecuteSqlOld(false, "INSERT INTO `player_vehicles` (`steam`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `state`) VALUES ('"..Player.PlayerData.steam.."', '"..Player.PlayerData.citizenid.."', '"..vehicle.model.."', '"..vehicle.hash.."', '"..json.encode(mods).."', '"..plate.."', 0)")
            Framework.Functions.ExecuteSql(false, "INSERT INTO `player_vehicles` (`steam`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `state`) VALUES (@steam, @citizenid, @vehicle, @hash, @mods, @plate, @state)", {
                ['@steam'] = Player.PlayerData.steam,
                ['@citizenid'] = Player.PlayerData.citizenid,
                ['@vehicle'] = vehicle.model,
                ['@hash'] = vehicle.hash,
                ['@mods'] = json.encode(mods),
                ['@plate'] = plate,
                ['@state'] = '0',
            })
            TriggerClientEvent('Framework:Notify', src, 'The vehicle is now in your name!', 'success', 5000)
        else
            TriggerClientEvent('Framework:Notify', src, 'This vehicle is already in your garage..', 'error', 3000)
        end
    end)
end)

RegisterServerEvent('pepe-admin:server:bringTp')
AddEventHandler('pepe-admin:server:bringTp', function(targetId, coords)
    TriggerClientEvent('pepe-admin:client:bringTp', targetId, coords)
end)

RegisterServerEvent('pepe-admin:server:gotoTp')
AddEventHandler('pepe-admin:server:gotoTp', function(targetid, playerid)
    TriggerClientEvent('pepe-admin:client:gotoTp', targetid, playerid)
end)

RegisterServerEvent('pepe-admin:server:gotoTpstage2')
AddEventHandler('pepe-admin:server:gotoTpstage2', function(targetid, coords)
    TriggerClientEvent('pepe-admin:client:gotoTp2', targetid, coords)
end)

Framework.Functions.CreateCallback('pepe-admin:server:hasPermissions', function(source, cb, group)
    local src = source
    local retval = false

    if Framework.Functions.HasPermission(src, group) then
        retval = true
    end
    cb(retval)
end)

RegisterServerEvent('pepe-admin:server:setPermissions')
AddEventHandler('pepe-admin:server:setPermissions', function(targetId, group)
    Framework.Functions.AddPermission(targetId, group.rank)
    TriggerClientEvent('Framework:Notify', targetId, 'Permissie gezet op '..group.label)
end)

RegisterServerEvent('pepe-admin:server:spawnWeapon')
AddEventHandler('pepe-admin:server:spawnWeapon', function(weapon)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    Player.Functions.AddItem(weapon, 1)
end)

RegisterServerEvent('pepe-admin:server:crash')
AddEventHandler('pepe-admin:server:crash', function(id)
    TriggerClientEvent("pepe-admin:client:crash", id)
end)

RegisterServerEvent('pepe-admin:server:SendReport')
AddEventHandler('pepe-admin:server:SendReport', function(name, targetSrc, msg)
    local src = source
    local Players = Framework.Functions.GetPlayers()

    if Framework.Functions.HasPermission(src, "admin") then
        if Framework.Functions.IsOptin(src) then
            --TriggerClientEvent('chatMessage', src, "REPORT - "..name.." ("..targetSrc..")", "report", msg)
			
			
            TriggerClientEvent('chat:addMessage', src , {
                template = '<div class="chat-message server">'..name..' ('..targetSrc..') - {0}</div>',
                args = { "Report - " .. msg }
            })
			
        end
    end
end)
Framework.Commands.Add("reporttoggle", "Reports aan of uit zetten", {}, false, function(source, args)
    Framework.Functions.ToggleOptin(source)
    if Framework.Functions.IsOptin(source) then
        TriggerClientEvent('Framework:Notify', source, "Je ontvangt nu reports", "success")
    else
        TriggerClientEvent('Framework:Notify', source, "Je ontvangt geen reports meer.", "error")
    end
end, "admin")

RegisterServerEvent('pepe-admin:server:StaffChatMessage')
AddEventHandler('pepe-admin:server:StaffChatMessage', function(name, msg)
    local src = source
    local Players = Framework.Functions.GetPlayers()

    if Framework.Functions.HasPermission(src, "admin") then
        if Framework.Functions.IsOptin(src) then

            TriggerClientEvent('chat:addMessage', src , {
                template = '<div class="chat-message server"><b>{0}</b> {1}</div>',
                args = { "Staff - " .. name, msg }
            })
        end
    end
end)

Framework.Commands.Add("report", "Stuur een report naar staffleden.", {{name="message", help="Message"}}, true, function(source, args)
    local msg = table.concat(args, " ")
    local Player = Framework.Functions.GetPlayer(source)
    TriggerClientEvent('pepe-admin:client:SendReport', -1, GetPlayerName(source), source, msg)
	
            TriggerClientEvent('chat:addMessage', source , {
                template = '<div class="chat-message server">Report verstuurd wacht op reactie.</div>',
                args = { "Report - " .. msg }
            })
    TriggerEvent("pepe-log:server:CreateLog", "report", "Report", "green", "**"..GetPlayerName(source).."** (CitizenID: "..Player.PlayerData.citizenid.." | ID: "..source..") **Report:** " ..msg, false)
    TriggerEvent("pepe-log:server:sendLog", Player.PlayerData.citizenid, "reportreply", {message=msg})
end)

Framework.Commands.Add("sc", "Send a message to all staff members", {{name="message", help="Message"}}, true, function(source, args)
    local msg = table.concat(args, " ")

    TriggerClientEvent('pepe-admin:client:SendStaffChat', -1, GetPlayerName(source), msg)
end, "admin")

Framework.Commands.Add("reportr", "Reageer op een report", {}, false, function(source, args)
    local playerId = tonumber(args[1])
    table.remove(args, 1)
    local msg = table.concat(args, " ")
    local OtherPlayer = Framework.Functions.GetPlayer(playerId)
    local Player = Framework.Functions.GetPlayer(source)
    if OtherPlayer ~= nil then
            TriggerClientEvent('chat:addMessage', playerId , {
                template = '<div class="chat-message server">{0}</div>',
                args = { "Reactie: " .. msg }
				            })
				
				
        TriggerClientEvent('Framework:Notify', source, "Sent reply")
        TriggerEvent("pepe-log:server:sendLog", Player.PlayerData.citizenid, "reportreply", {otherCitizenId=OtherPlayer.PlayerData.citizenid, message=msg})
        for k, v in pairs(Framework.Functions.GetPlayers()) do
            if Framework.Functions.HasPermission(v, "admin") then
                if Framework.Functions.IsOptin(v) then
		
            TriggerClientEvent('chat:addMessage', v , {
                template = '<div class="chat-message server">{0}</div>',
                args = { "Staff Reactie ("..source..") - " .. msg }
				            })
				
                    TriggerEvent("pepe-log:server:CreateLog", "report", "Report Reply", "red", "**"..GetPlayerName(source).."** heeft gereageerd op: **"..OtherPlayer.PlayerData.name.. " **(ID: "..OtherPlayer.PlayerData.source..") **Bericht:** " ..msg, false)
                end
            end
        end
    else
        TriggerClientEvent('Framework:Notify', source, "Player is not online", "error")
    end
end, "admin")

Framework.Commands.Add("setammo", "Staff: Set manual ammo for a weapon.", {{name="amount", help="The amount of bullets, e.g .: 20"}, {name="weapon", help="Name of weapon, eg: WEAPON_RAILGUN"}}, false, function(source, args)
    local src = source
    local weapon = args[2] ~= nil and args[2] or "current"
    local amount = tonumber(args[1]) ~= nil and tonumber(args[1]) or 250

    TriggerClientEvent('pepe-weapons:client:SetWeaponAmmoManual', src, weapon, amount)
end, 'admin')
