local Framework = exports["pepe-core"]:GetCoreObject()

-- Code

Framework.Functions.CreateUseableItem("kerstkado", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-christmas:client:use:kado', source)
    end
end)

Framework.Commands.Add("kerstmis", "Geef iedereen een cadeau", {}, false, function(source, args)
    local src = source
    for k, v in pairs(Framework.Functions.GetPlayers()) do
        local Player = Framework.Functions.GetPlayer(v)
        if Player ~= nil then
         Player.Functions.AddItem('kerstkado', 1)
        --  TriggerClientEvent('Framework:Notify', v, "Fijne kerst en alvast een gelukkig nieuwjaar!", "info", 15000)
         TriggerClientEvent('pepe-inventory:client:ItemBox', v, Framework.Shared.Items['kerstkado'], "add")
        end
    end
end, 'god')

RegisterServerEvent('pepe-christmas:server:get:kado:prize')
AddEventHandler('pepe-christmas:server:get:kado:prize', function()
	local Player = Framework.Functions.GetPlayer(source)
    local RandomValue = math.random(1,100)
    Player.Functions.AddItem('lsd-strip', 5)
    Player.Functions.AddMoney('cash', math.random(1000, 2500), "Gift")

    TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['lsd-strip'], "add")
    if RandomValue >= 1 and RandomValue < 15 then
        Player.Functions.AddItem('health-pack', 3, false)
        TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['health-pack'], "add")
    elseif RandomValue > 15 and RandomValue < 30 then
        local info = {quality = 100.0}
        Player.Functions.AddItem('weapon_molotov', 1, false, info)
        TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['weapon_molotov'], "add")
    elseif RandomValue > 30 and RandomValue < 45 then
        Player.Functions.AddItem('diamond-blue', math.random(12,23))
        TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['diamond-blue'], "add")
    elseif RandomValue > 45 and RandomValue < 60 then
        Player.Functions.AddItem('advancedlockpick', 5)
        TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['advancedlockpick'], "add")
    elseif RandomValue > 61 and RandomValue < 65 then
        Player.Functions.AddItem('bandage', math.random(5,10))
        TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['bandage'], "add")
    elseif RandomValue > 66 and RandomValue < 70 then
        Player.Functions.AddItem('plastic', math.random(50,150))
        TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['plastic'], "add")
    elseif RandomValue > 71 and RandomValue < 75 then
        Player.Functions.AddItem('lotto-card', math.random(2,3))
        TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['lotto-card'], "add")
    end
end)