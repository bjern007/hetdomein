local Framework = exports["pepe-core"]:GetCoreObject()

-- Code

RegisterServerEvent('pepe-taxi:server:NpcPay')
AddEventHandler('pepe-taxi:server:NpcPay', function(Payment)
    local fooikansasah = math.random(1, 5)
    local r1, r2 = math.random(1, 5), math.random(1, 5)

    if fooikansasah == r1 or fooikansasah == r2 then
        Payment = Payment + math.random(394, 690)
    end

    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    
    Player.Functions.AddMoney('cash', math.ceil(Payment))
end)