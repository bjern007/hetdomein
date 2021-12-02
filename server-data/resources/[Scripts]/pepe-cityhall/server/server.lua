-- Framework = nil
local Framework = exports["pepe-core"]:GetCoreObject()

-- TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)

local DrivingSchools = {
    "XBZ60578",
}

RegisterServerEvent('pepe-cityhall:server:requestId')
AddEventHandler('pepe-cityhall:server:requestId', function(identityData)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    local licenses = {
        ["driver"] = false,
    }
    local info = {}
    if identityData.item == "id-card" then
        info.citizenid = Player.PlayerData.citizenid
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        info.gender = Player.PlayerData.charinfo.gender
        info.nationality = Player.PlayerData.charinfo.nationality
    elseif identityData.item == "drive-card" then
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        info.type = "A1-A2-A | AM-B | C1-C-CE"
    end
    Player.Functions.AddItem(identityData.item, 1, false, info)
    TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items[identityData.item], 'add')
end)

RegisterServerEvent('pepe-cityhall:server:ApplyJob')
AddEventHandler('pepe-cityhall:server:ApplyJob', function(job)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    local JobInfo = Framework.Shared.Jobs[job]

    Player.Functions.SetJob(job, 0)

    TriggerClientEvent('Framework:Notify', src, 'Gefeliciteerd als '..JobInfo.label..' zijnde!')
end)


RegisterServerEvent('pepe-cityhall:server:sendDriverTest')
AddEventHandler('pepe-cityhall:server:sendDriverTest', function()
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    for k, v in pairs(DrivingSchools) do 
        local SchoolPlayer = Framework.Functions.GetPlayerByCitizenId(v)
        if SchoolPlayer ~= nil then 
            TriggerClientEvent("pepe-cityhall:client:sendDriverEmail", SchoolPlayer.PlayerData.source, SchoolPlayer.PlayerData.charinfo)
        else
            local mailData = {
                sender = "Gemeente",
                subject = "Aanvraag Rijles",
                message = "Beste,<br /><br />Wij hebben zojuist een bericht gehad dat er iemand rijles wilt volgen.<br />Mocht u bereid zijn om les te geven kunt u contact opnemen:<br />Naam: <strong>".. Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. "<br />Telefoonnummer: <strong>"..Player.PlayerData.charinfo.phone.."</strong><br/><br/>Met vriendelijke groet,<br />Gemeente Los Santos",
                button = {}
            }
            TriggerEvent("pepe-phone:server:sendNewEventMail", v, mailData)
        end
    end
    TriggerClientEvent('Framework:Notify', src, 'Er is een mail verstuurd naar rijscholen, er wordt vanzelf contact met je opgenomen', "success", 5000)
end)

Framework.Commands.Add("geefrijbewijs", "Geef een rijbewijs aan iemand", {{"id", "ID van een persoon"}}, true, function(source, args)
    local src = source
    local Player = Framework.Functions.GetPlayer(source)
    if IsWhitelistedSchool(Player.PlayerData.citizenid) then
        local SearchedPlayer = Framework.Functions.GetPlayer(tonumber(args[1]))
        if SearchedPlayer ~= nil then
            local driverLicense = SearchedPlayer.PlayerData.metadata["licences"]["driver"]
            if not driverLicense then
                local licenses = {
                    ["driver"] = true,
                }
                SearchedPlayer.Functions.SetMetaData("licences", licenses)
                TriggerClientEvent('Framework:Notify', SearchedPlayer.PlayerData.source, "Je bent geslaagd! Haal je rijbewijs op bij het gemeentehuis", "success", 5000)
            else
                TriggerClientEvent('Framework:Notify', src, "Kan rijbewijs niet geven..", "error")
            end
        end
    end
end)

function IsWhitelistedSchool(citizenid)
    local retval = false
    for k, v in pairs(DrivingSchools) do 
        if v == citizenid then
            retval = true
        end
    end
    return retval
end