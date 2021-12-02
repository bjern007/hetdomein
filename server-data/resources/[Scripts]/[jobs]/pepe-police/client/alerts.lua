RegisterNetEvent('pepe-police:client:send:officer:down')
AddEventHandler('pepe-police:client:send:officer:down', function(Coords, StreetName, Info, Priority)
    if (Framework.Functions.GetPlayerData().job.name == "police") and Framework.Functions.GetPlayerData().job.onduty then
        local Title, Callsign = 'Agent neer', '10-13B'
        if Priority == 3 then
            Title, Callsign = 'Agent neer (Urgent)', '10-13A'
        end
        TriggerEvent('pepe-alerts:client:send:alert', {
            timeOut = 7500,
            alertTitle = Title,
            priority = Priority,
            coords = {
                x = Coords.x,
                y = Coords.y,
                z = Coords.z,
            },
            details = {
                [1] = {
                    icon = '<i class="fas fa-id-badge"></i>',
                    detail = Info['Callsign']..' | '..Info['Firstname'].. ' ' ..Info['Lastname'],
                },
                [2] = {
                    icon = '<i class="fas fa-globe-europe"></i>',
                    detail = StreetName,
                },
            },
            callSign = Callsign,
        })
        AddAlert(Title, 306, 250, Coords, false)
    end
end)

RegisterNetEvent('pepe-police:client:send:alert:panic:button')
AddEventHandler('pepe-police:client:send:alert:panic:button', function(Coords, StreetName, Info)
    if (Framework.Functions.GetPlayerData().job.name == "police") and Framework.Functions.GetPlayerData().job.onduty then
        TriggerEvent('pepe-alerts:client:send:alert', {
            timeOut = 7500,
            alertTitle = "Noodknop",
            priority = 3,
            coords = {
                x = Coords.x,
                y = Coords.y,
                z = Coords.z,
            },
            details = {
                [1] = {
                    icon = '<i class="fas fa-id-badge"></i>',
                    detail = Info['Callsign']..' | '..Info['Firstname'].. ' ' ..Info['Lastname'],
                },
                [2] = {
                    icon = '<i class="fas fa-globe-europe"></i>',
                    detail = StreetName,
                },
            },
            callSign = '10-13C',
        })
        AddAlert('Noodknop', 487, 250, Coords, false)
    end
end)

RegisterNetEvent('pepe-police:client:send:alert:gunshots')
AddEventHandler('pepe-police:client:send:alert:gunshots', function(Coords, GunType, StreetName, InVeh)
   if (Framework.Functions.GetPlayerData().job.name == "police") and Framework.Functions.GetPlayerData().job.onduty then
    local Area = GetDistanceBetweenCoords(Coords.x, Coords.y, Coords.z, -1095.1264648438, -1269.3354492188, 5.8505229949951, true)
    if Area > 50.0 then
     local AlertMessage, CallSign = 'Schoten gelost', '10-47A'
     if InVeh then
         AlertMessage, CallSign = 'Schoten gelost uit voertuig', '10-47B'
     end
     TriggerEvent('pepe-alerts:client:send:alert', {
        timeOut = 7500,
        alertTitle = AlertMessage,
        priority = 1,
        coords = {
            x = Coords.x,
            y = Coords.y,
            z = Coords.z,
        },
        details = {
            [1] = {
                icon = '<i class="far fa-arrow-alt-circle-right"></i>',
                detail = GunType,
            },
            [2] = {
                icon = '<i class="fas fa-globe-europe"></i>',
                detail = StreetName,
            },
        },
        callSign = CallSign,
    })
    AddAlert(AlertMessage, 313, 250, Coords, false)
    end
  end
end)

RegisterNetEvent('pepe-police:client:send:alert:dead')
AddEventHandler('pepe-police:client:send:alert:dead', function(Coords, StreetName)
    if (Framework.Functions.GetPlayerData().job.name == "police" or Framework.Functions.GetPlayerData().job.name == "ambulance") and Framework.Functions.GetPlayerData().job.onduty then
        TriggerEvent('pepe-alerts:client:send:alert', {
            timeOut = 7500,
            alertTitle = "Gewonde Burger",
            priority = 1,
            coords = {
                x = Coords.x,
                y = Coords.y,
                z = Coords.z,
            },
            details = {
                [1] = {
                    icon = '<i class="fas fa-globe-europe"></i>',
                    detail = StreetName,
                },
            },
            callSign = '10-30B',
        }, true)
        AddAlert('Gewonde Burger', 480, 250, Coords, false)
    end
end)

RegisterNetEvent('pepe-police:client:send:bank:alert')
AddEventHandler('pepe-police:client:send:bank:alert', function(Coords, StreetName)
    if (Framework.Functions.GetPlayerData().job.name == "police") and Framework.Functions.GetPlayerData().job.onduty then
        TriggerEvent('pepe-alerts:client:send:alert', {
            timeOut = 15000,
            alertTitle = "Fleeca Bank",
            priority = 1,
            coords = {
                x = Coords.x,
                y = Coords.y,
                z = Coords.z,
            },
            details = {
                [1] = {
                    icon = '<i class="fas fa-globe-europe"></i>',
                    detail = StreetName,
                },
            },
            callSign = '10-42A',
        }, true)
        AddAlert('Fleeca Bank', 108, 250, Coords, false)
    end
end)

RegisterNetEvent('pepe-police:client:send:alert:jewellery')
AddEventHandler('pepe-police:client:send:alert:jewellery', function(Coords, StreetName)
 if (Framework.Functions.GetPlayerData().job.name == "police") and Framework.Functions.GetPlayerData().job.onduty then 
    TriggerEvent('pepe-alerts:client:send:alert', {
        timeOut = 15000,
        alertTitle = "Vangelico Juwelier",
        priority = 1,
        coords = {
            x = Coords.x,
            y = Coords.y,
            z = Coords.z,
        },
        details = {
            [1] = {
                icon = '<i class="fas fa-globe-europe"></i>',
                detail = StreetName,
            },
        },
        callSign = '10-42A',
    }, true)
    AddAlert('Vangelico Juwelier', 617, 250, Coords, false)
 end
end)

RegisterNetEvent('pepe-police:client:send:alert:humanelabs')
AddEventHandler('pepe-police:client:send:alert:humanelabs', function(Coords, StreetName)
 if (Framework.Functions.GetPlayerData().job.name == "police") and Framework.Functions.GetPlayerData().job.onduty then 
    TriggerEvent('pepe-alerts:client:send:alert', {
        timeOut = 15000,
        alertTitle = "Humanelabs Overval",
        priority = 1,
        coords = {
            x = Coords.x,
            y = Coords.y,
            z = Coords.z,
        },
        details = {
            [1] = {
                icon = '<i class="fas fa-globe-europe"></i>',
                detail = StreetName,
            },
        },
        callSign = '10-42A',
    }, true)
    AddAlert('Humanelabs Overval', 617, 250, Coords, false)
 end
end)

RegisterNetEvent('pepe-police:client:send:alert:store')
AddEventHandler('pepe-police:client:send:alert:store', function(Coords, StreetName, StoreNumber)
 if (Framework.Functions.GetPlayerData().job.name == "police") and Framework.Functions.GetPlayerData().job.onduty then 
    TriggerEvent('pepe-alerts:client:send:alert', {
        timeOut = 15000,
        alertTitle = "Winkel Alarm",
        priority = 0,
        coords = {
            x = Coords.x,
            y = Coords.y,
            z = Coords.z,
        },
        details = {
            [1] = {
                icon = '<i class="fas fa-shopping-basket"></i>',
                detail = 'Winkel: '..StoreNumber,
            },
            [2] = {
                icon = '<i class="fas fa-globe-europe"></i>',
                detail = StreetName,
            },
        },
        callSign = '10-98A',
    }, true)
    AddAlert('Winkel Alarm', 59, 250, Coords, false)
 end
end)

RegisterNetEvent('pepe-police:client:send:house:alert')
AddEventHandler('pepe-police:client:send:house:alert', function(Coords, StreetName)
 if (Framework.Functions.GetPlayerData().job.name == "police") and Framework.Functions.GetPlayerData().job.onduty then 
    TriggerEvent('pepe-alerts:client:send:alert', {
        timeOut = 15000,
        alertTitle = "Huis Alarm",
        priority = 0,
        coords = {
            x = Coords.x,
            y = Coords.y,
            z = Coords.z,
        },
        details = {
            [1] = {
                icon = '<i class="fas fa-globe-europe"></i>',
                detail = StreetName,
            },
        },
        callSign = '10-63B',
    }, true)
    AddAlert('Huis Alarm', 40, 250, Coords, false)
 end
end)

RegisterNetEvent('pepe-police:client:send:banktruck:alert')
AddEventHandler('pepe-police:client:send:banktruck:alert', function(Coords, Plate, StreetName)
 if (Framework.Functions.GetPlayerData().job.name == "police") and Framework.Functions.GetPlayerData().job.onduty then 
    TriggerEvent('pepe-alerts:client:send:alert', {
        timeOut = 15000,
        alertTitle = "Bank Truck Alarm",
        priority = 0,
        coords = {
            x = Coords.x,
            y = Coords.y,
            z = Coords.z,
        },
        details = {
            [1] = {
                icon = '<i class="fas fa-closed-captioning"></i>',
                detail = 'Kenteken: '..Plate,
            },
            [2] = {
                icon = '<i class="fas fa-globe-europe"></i>',
                detail = StreetName,
            },
        },
        callSign = '10-03A',
    }, true)
    AddAlert('Banktruck Alarm', 67, 250, Coords, false)
 end
end)


RegisterNetEvent('pepe-police:client:send:cornerselling:alert')
AddEventHandler('pepe-police:client:send:cornerselling:alert', function(Coords, StreetName)
 if (Framework.Functions.GetPlayerData().job.name == "police") and Framework.Functions.GetPlayerData().job.onduty then 
    TriggerEvent('pepe-alerts:client:send:alert', {
        timeOut = 15000,
        alertTitle = "Drugsverkoop",
        priority = 1,
        coords = {
            x = Coords.x,
            y = Coords.y,
            z = Coords.z,
        },
        details = {
            [1] = {
                icon = '<i class="fas fa-globe-europe"></i>',
                detail = StreetName,
            },
        },
        callSign = '10-02C',
    }, false)
    AddAlert('Drugsverkoop', 626, 250, Coords, false, true)
 end
end)

RegisterNetEvent('pepe-police:client:send:koperdief:alert')
AddEventHandler('pepe-police:client:send:koperdief:alert', function(Coords, StreetName)
 if (Framework.Functions.GetPlayerData().job.name == "police") and Framework.Functions.GetPlayerData().job.onduty then 
    TriggerEvent('pepe-alerts:client:send:alert', {
        timeOut = 15000,
        alertTitle = "Koper diefstal",
        priority = 1,
        coords = {
            x = Coords.x,
            y = Coords.y,
            z = Coords.z,
        },
        details = {
            [1] = {
                icon = '<i class="fas fa-globe-europe"></i>',
                detail = StreetName,
            },
        },
        callSign = '10-02C',
    }, false)
    AddAlert('Koperdiefstal', 626, 250, Coords, false, true)
 end
end)


RegisterNetEvent('pepe-police:client:send:tracker:alert')
AddEventHandler('pepe-police:client:send:tracker:alert', function(Coords, Name)
    if (Framework.Functions.GetPlayerData().job.name == "police") and Framework.Functions.GetPlayerData().job.onduty then
      AddAlert('Enkelband Locatie: '..Name, 480, 250, Coords, true)
    end
end)

-- // Funtions \\ --

function AddAlert(Text, Sprite, Transition, Coords, Tracker)
 local Transition = Transition
 local Blips = AddBlipForCoord(Coords.x, Coords.y, Coords.z)
 SetBlipSprite(Blips, Sprite)
 SetBlipColour(Blips, 6)
 SetBlipDisplay(Blips, 4)
 SetBlipAlpha(Blips, transG)
 SetBlipScale(Blips, 1.0)
 SetBlipAsShortRange(Blips, false)
 SetBlipFlashes(Blips, true)
 BeginTextCommandSetBlipName('STRING')
 if not Tracker then
  AddTextComponentString('Melding: '..Text)
 else
  AddTextComponentString(Text)
 end
 EndTextCommandSetBlipName(Blips)
 while Transition ~= 0 do
     Wait(180 * 4)
     Transition = Transition - 1
     SetBlipAlpha(Blips, Transition)
     if Transition == 0 then
         SetBlipSprite(Blips, 2)
         RemoveBlip(Blips)
         return
     end
 end
end