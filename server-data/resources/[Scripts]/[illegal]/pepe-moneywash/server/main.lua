local Framework = exports["pepe-core"]:GetCoreObject()

RegisterNetEvent("pepe-moneywash:server:checkInv")
AddEventHandler("pepe-moneywash:server:checkInv", function()
    local src = source
    local Player = Framework.Functions.GetPlayer(src)

        if Player.Functions.GetItemByName('markedbills') ~= nil then
            
            local Item = Player.Functions.GetItemByName('markedbills')
            local amt = Player.Functions.GetItemByName('markedbills').amount
            TriggerClientEvent('pepe-moneywash:client:startTimer', src, Item.info.worth)
            TriggerClientEvent('Framework:Notify', src, 'Je hebt de marked bills in de wasmasjiennnn gestopt.', 'success')
            Player.Functions.RemoveItem('markedbills', 1)
        else
            TriggerClientEvent('Framework:Notify', src, 'Huts geen doekoe geen doekoe.', 'error') 
        end

end)

RegisterNetEvent("pepe-moneywash:server:giveMoney")
AddEventHandler("pepe-moneywash:server:giveMoney", function(amt)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
   
   Player.Functions.AddMoney('cash', amt, 'sold-traphouse')
   
end)
