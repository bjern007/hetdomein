local Framework = exports["pepe-core"]:GetCoreObject()

local PaymentTax = 15

local Bail = {}

RegisterServerEvent('pepe-trucker:server:DoBail')
AddEventHandler('pepe-trucker:server:DoBail', function(bool, vehInfo)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)

    if bool then
        if Player.PlayerData.money.cash >= Config.BailPrice then
            Bail[Player.PlayerData.citizenid] = Config.BailPrice
            Player.Functions.RemoveMoney('cash', Config.BailPrice, "tow-received-bail")
            TriggerClientEvent('Framework:Notify', src, 'Je hebt de borg van 500,- betaald (Cash)', 'success')
            TriggerClientEvent('pepe-trucker:client:SpawnVehicle', src, vehInfo)
        elseif Player.PlayerData.money.bank >= Config.BailPrice then
            Bail[Player.PlayerData.citizenid] = Config.BailPrice
            Player.Functions.RemoveMoney('bank', Config.BailPrice, "tow-received-bail")
            TriggerClientEvent('Framework:Notify', src, 'Je hebt de borg van 500,- betaald (Bank)', 'success')
            TriggerClientEvent('pepe-trucker:client:SpawnVehicle', src, vehInfo)
        else
            TriggerClientEvent('Framework:Notify', src, 'Je hebt niet genoeg contant, de borg is 500,-', 'error')
        end
    else
        if Bail[Player.PlayerData.citizenid] ~= nil then
            Player.Functions.AddMoney('cash', Bail[Player.PlayerData.citizenid], "trucker-bail-paid")
            Bail[Player.PlayerData.citizenid] = nil
            TriggerClientEvent('Framework:Notify', src, 'Je hebt de borg van 500,- terug gekregen', 'success')
        end
    end
end)

RegisterNetEvent('pepe-trucker:server:01101110')
AddEventHandler('pepe-trucker:server:01101110', function()
    Framework.Functions.BanInjection(source, 'pepe-trucker (01101110)')
end)

Framework.Functions.CreateCallback('pepe-trucker:01101110', function(source, cb, drops)
    local src = source 
    local Player = Framework.Functions.GetPlayer(src)
    local drops = tonumber(drops)
    local bonus = 0
    local DropPrice = math.random(330, 380)
    if drops > 5 then 
        bonus = math.ceil((DropPrice / 100) * 5) + 12110
    elseif drops > 10 then
        bonus = math.ceil((DropPrice / 100) * 7) + 181230
    elseif drops > 15 then
        bonus = math.ceil((DropPrice / 100) * 10) + 155400
    elseif drops > 20 then
        bonus = math.ceil((DropPrice / 100) * 12) + 155500
    end
    local price = (DropPrice * drops) + bonus
    local taxAmount = math.ceil((price / 100) * PaymentTax)
    local payment = price - taxAmount
    Player.Functions.AddMoney("cash", payment, "trucker-salary")
    TriggerClientEvent('chatMessage', source, "BAAN", "warning", "Je hebt je salaris ontvangen van: €"..payment..", bruto: €"..price.." (waarvan €"..bonus.." bonus) en €"..taxAmount.." belasting ("..PaymentTax.."%)")
end)

