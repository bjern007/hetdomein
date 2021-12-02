Framework = exports["pepe-core"]:GetCoreObject()

RegisterNetEvent('pepe-christmas:client:use:kado')
AddEventHandler('pepe-christmas:client:use:kado', function()
    TriggerServerEvent('pepe-sound:server:play:distance', 3.0, 'unwrap', 0.2)
    Framework.Functions.Progressbar("christmas-present", "Cadeau Openmaken...", math.random(20000, 30000), false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done   
        TriggerServerEvent('Framework:Server:RemoveItem', 'kerstkado', 1)
        TriggerEvent("pepe-inventory:client:ItemBox", Framework.Shared.Items['kerstkado'], "remove")
        TriggerServerEvent('pepe-christmas:server:get:kado:prize')
    end, function() -- Cancel
        Framework.Functions.Notify("Of toch niet..", "error")
    end)
end)