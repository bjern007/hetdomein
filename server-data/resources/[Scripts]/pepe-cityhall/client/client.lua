Framework = exports["pepe-core"]:GetCoreObject()

-- Code

-- // Events \\ --

RegisterNetEvent('pepe-cityhall:client:open:nui')
AddEventHandler('pepe-cityhall:client:open:nui', function()
    Citizen.SetTimeout(350, function()
        OpenCityHall()
    end)
end)

RegisterNetEvent('pepe-cityhall:client:sendDriverEmail')
AddEventHandler('pepe-cityhall:client:sendDriverEmail', function(charinfo)
    SetTimeout(math.random(2500, 4000), function()
        local gender = "meneer"
        if Framework.Functions.GetPlayerData().charinfo.gender == 1 then
            gender = "mevrouw"
        end
        local charinfo = Framework.Functions.GetPlayerData().charinfo
        TriggerServerEvent('pepe-phone:server:sendNewMail', {
            sender = "Gemeente",
            subject = "Aanvraag Rijles",
            message = "Beste " .. gender .. " " .. charinfo.lastname .. ",<br /><br />Wij hebben zojuist een bericht gehad dat er iemand rijles wilt volgen.<br />Mocht u bereid zijn om les te geven kunt u contact opnemen:<br />Naam: <strong>".. charinfo.firstname .. " " .. charinfo.lastname .. "</strong><br />Telefoonnummer: <strong>"..charinfo.phone.."</strong><br/><br/>Met vriendelijke groet,<br />Gemeente Quackcity",
            button = {}
        })
    end)
end)

local creatingCompany = false
local currentName = nil
Citizen.CreateThread(function()
    while true do

        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        inRange = false

        local dist2 = GetDistanceBetweenCoords(pos, Config.DrivingSchool.coords.x, Config.DrivingSchool.coords.y, Config.DrivingSchool.coords.z, true)
        if dist2 < 20 then
            inRange = true
            DrawMarker(2, Config.DrivingSchool.coords.x, Config.DrivingSchool.coords.y, Config.DrivingSchool.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.2, 155, 152, 234, 155, false, false, false, true, false, false, false)
            if GetDistanceBetweenCoords(pos, Config.DrivingSchool.coords.x, Config.DrivingSchool.coords.y, Config.DrivingSchool.coords.z, true) < 1.5 then
                qbCityhall.DrawText3Ds(Config.DrivingSchool.coords, '~g~E~w~ - Rijles aanvragen')
                if IsControlJustPressed(0, Keys["E"]) then
                    if Framework.Functions.GetPlayerData().metadata["licences"]["driver"] then
                        Framework.Functions.Notify("Je hebt al je rijbewijs gehaald, haal deze op bij het gemeentehuis!")
                    else
                        TriggerServerEvent("pepe-cityhall:server:sendDriverTest")
                    end
                end
            end
        end

        if not inRange then
            Citizen.Wait(2000)
        end

        Citizen.Wait(2)
    end
end)
-- // Functions \\ 

function OpenCityHall()
 SetNuiFocus(true, true)  
 SendNUIMessage({
     action = "open"
 }) 
end

RegisterNUICallback('Close', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('Click', function()
    PlaySound(-1, "CLICK_BACK", "WEB_NAVIGATION_SOUNDS_PHONE", 0, 0, 1)
end)

RegisterNUICallback('requestId', function(data)
    local idType = data.idType
    TriggerServerEvent('pepe-cityhall:server:requestId', Config.IdTypes[idType])
    Framework.Functions.Notify('Je verzocht een '..Config.IdTypes[idType].label..' voor €50', 'success', 3500)
end)

RegisterNUICallback('requestLicenses', function(data, cb)
    local PlayerData = Framework.Functions.GetPlayerData()
    local licensesMeta = PlayerData.metadata["licences"]
    local availableLicenses = {}
    for type,_ in pairs(licensesMeta) do
        if licensesMeta[type] then
            local licenseType = nil
            local label = nil
            if type == "driver" then licenseType = "rijbewijs" label = "Driverlicense" end
            table.insert(availableLicenses, {
                idType = licenseType,
                label = label
            })
        end
    end
    cb(availableLicenses)
end)

RegisterNUICallback('applyJob', function(data)
    TriggerServerEvent('pepe-cityhall:server:ApplyJob', data.job)
end)

-- // Functions \\ --

function CanOpenCityHall()
    local PlayerCoords = GetEntityCoords(PlayerPedId())
    local Distance = GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, Config.Location['X'], Config.Location['Y'], Config.Location['Z'], true)
    if Distance < 3.0 then  
      return true
    end
end