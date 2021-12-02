local isOpened = false
RegisterNetEvent('pepe-policeActives:client:createNUI')
AddEventHandler('pepe-policeActives:client:createNUI', function(data, draggable)
    local html = ""
    
    for _, cop in pairs(data) do
        html = html .. "<span style=\"position: relative; top: 7.5px; font-size: 15px; color: white; font-family: heebo; padding-right: 10px; padding-left: 10px; padding-bottom: 10px;\">"
        local dutyLogo = cop.onduty == true and "<i style=\"color: rgb(25, 212, 0)\" class=\"fas fa-bullseye fa-lg\"></i>" or "<i style=\"color: rgb(232, 8, 0)\" class=\"fas fa-bullseye fa-lg\"></i>" 
        html = html .. dutyLogo .. '<span style=\"margin-left: 5px\">' .. cop.name .. ' (' .. (cop.grade ~= nil and cop.grade or 'Regular') .. ')</span>'
        html = html .. '<span style=\"margin-left: 5px; background-color: rgba(0, 98, 245, 0.75); padding-left: 7px; padding-right: 7px; border-radius: 5px;\">' .. cop.callsign .. '</span></span></br>'
    end

    SendNUIMessage({
        type = 'update-title',
        data = "Actieve Agenten",
    })

    if draggable == 2 then
        isOpened = not isOpened
        SetNuiFocus(false, false)
        SendNUIMessage({
            type = 'police-actives',
            data = html,
            close = isOpened
        })
        TriggerEvent("debug", 'Police Actives: ' .. (isOpened and 'Open UI' or 'Close UI'), (isOpened and 'success' or 'error'))
    elseif draggable > 0 then
        SetNuiFocus(true, true)
        SendNUIMessage({
            type = 'police-actives',
            data = html,
            drag = draggable
        })
    else
        SetNuiFocus(false, false)
        SendNUIMessage({
            type = 'police-actives',
            data = html,
            drag = draggable
        })
    end
end)

RegisterNUICallback('closeUI', function()
    SetNuiFocus(false, false)
end)

RegisterNetEvent("Framework:Client:OnJobUpdate")
AddEventHandler("Framework:Client:OnJobUpdate", function(JobInfo)
    TriggerServerEvent('pepe-policeActives:server:updateOfficers')

    if isOpened and JobInfo.name ~= 'police' then
        SendNUIMessage({
            type = 'close',
        })
    end
end)

RegisterNetEvent('Framework:Client:OnPlayerLoaded')
AddEventHandler('Framework:Client:OnPlayerLoaded', function()
    TriggerServerEvent('pepe-policeActives:server:updateOfficers')
end)

RegisterNetEvent('Framework:Client:SetDuty')
AddEventHandler('Framework:Client:SetDuty', function(duty)
    TriggerServerEvent('pepe-policeActives:server:updateOfficers')

    if isOpened and not duty then
        SendNUIMessage({
            type = 'close',
        })
    end
end)

RegisterNetEvent('pepe-policeActives:client:updateOfficers')
AddEventHandler('pepe-policeActives:client:updateOfficers', function(data)
    if not Framework or not Framework.Functions.GetPlayerData().job or Framework.Functions.GetPlayerData().job.name ~= 'police' then
        return
    end

    local html = ""
    
    for _, cop in pairs(data) do
        html = html .. "<span style=\"position: relative; top: 7.5px; font-size: 15px; color: white; font-family: heebo; padding-right: 10px; padding-left: 10px; padding-bottom: 10px;\">"
        local dutyLogo = cop.onduty == true and "<i style=\"color: rgb(25, 212, 0)\" class=\"fas fa-bullseye fa-lg\"></i>" or "<i style=\"color: rgb(232, 8, 0)\" class=\"fas fa-bullseye fa-lg\"></i>" 
        html = html .. dutyLogo .. '<span style=\"margin-left: 5px\">' .. cop.name .. ' (' .. (cop.grade ~= nil and cop.grade or 'Geen rang') .. ')</span>'
        html = html .. '<span style=\"margin-left: 5px; background-color: rgba(0, 98, 245, 0.75); padding-left: 7px; padding-right: 7px; border-radius: 5px;\">' .. cop.callsign .. '</span></span></br>'
    end

    SendNUIMessage({
        type = 'update-officers',
        data = html,
    })

    TriggerEvent("debug", 'Police Actives: Refresh', 'success')
end)