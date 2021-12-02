Framework = nil
TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)

local ItemTable = {
    "metalscrap",
    "plastic",
    "copper",
    "iron",
    "aluminum",
    "steel",
    "glass",
    "rubber",
}

--- Event For Getting Recyclable Material----

RegisterServerEvent("pepe-recycle:getrecyclablematerial")
AddEventHandler("pepe-recycle:getrecyclablematerial", function()
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    for i = 1, math.random(1, 5), 1 do
        local amount = math.random(2, 6)
        Player.Functions.AddItem("recyclablematerial", amount)
        TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items["recyclablematerial"], 'add')
        Citizen.Wait(500)
    end
end)

--------------------------------------------------

---- Trade Event Starts Over Here ------

RegisterServerEvent("pepe-recycle:server:TradeItems")
AddEventHandler("pepe-recycle:server:TradeItems", function()
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    for i = 1, math.random(1, 5), 1 do
        local randItem = ItemTable[math.random(1, #ItemTable)]
        local amount = math.random(1, 3)

        if Player.Functions.GetItemByName('recyclablematerial') ~= nil and Player.Functions.GetItemByName('recyclablematerial').amount >= 10 then
            Player.Functions.RemoveItem("recyclablematerial", "10")
        Player.Functions.AddItem(randItem, amount)
        TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items[randItem], 'add')
        Citizen.Wait(5000)
        Player.Functions.AddItem(randItem, amount)
        TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items[randItem], 'add')
        Citizen.Wait(5000)
        Player.Functions.AddItem(randItem, amount)
        TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items[randItem], 'add')
        else
            TriggerClientEvent('Framework:Notify', src, "You dont have enough bags")
    end
end
end)

RegisterServerEvent("pepe-recycle:server:TradeItemsBulk")
AddEventHandler("pepe-recycle:server:TradeItemsBulk", function()
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    for i = 1, math.random(1, 5), 1 do
        local randItem = ItemTable[math.random(1, #ItemTable)]
        local amount = math.random(1, 15)

        if Player.Functions.GetItemByName('recyclablematerial') ~= nil and Player.Functions.GetItemByName('recyclablematerial').amount >= 100 then
            Player.Functions.RemoveItem("recyclablematerial", "100")
            TriggerClientEvent('pepe-pepe-inventory:client:ItemBox', src, Framework.Shared.Items["recyclablematerial"], 'remove')
            Citizen.Wait(5000)

            local Kans = math.random(1, 50)
        Player.Functions.AddItem(randItem, amount)
        TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items[randItem], 'add')
        Citizen.Wait(3000)
        Player.Functions.AddItem(randItem, amount)
        TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items[randItem], 'add')
        Citizen.Wait(3000)
        Player.Functions.AddItem(randItem, amount)
        TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items[randItem], 'add')
        Citizen.Wait(3000)
        Player.Functions.AddItem(randItem, amount)
        TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items[randItem], 'add')
        Citizen.Wait(3000)
        Player.Functions.AddItem(randItem, amount)
        TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items[randItem], 'add')
        Citizen.Wait(3000)
        Player.Functions.AddItem(randItem, amount)
        TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items[randItem], 'add')
        Citizen.Wait(3000)
        Player.Functions.AddItem(randItem, amount)
        TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items[randItem], 'add')
        Citizen.Wait(3000)
        if Kans == 10 then
        Player.Functions.AddItem("lockpick", 1)
        TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items["lockpick"], 'add')
        Citizen.Wait(3000)
        end
        else
            TriggerClientEvent('Framework:Notify', src, "Je hebt niet genoeg recyclebaar materiaal op zak")
    end
end
end)