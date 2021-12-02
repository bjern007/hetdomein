local PlayersGeblindoekt = {}
Framework = nil

TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)


RegisterServerEvent('pepe-blinddoekserver:omdoen')
AddEventHandler('pepe-blinddoekserver:omdoen', function(target)
    local src = source
    local xPlayer = Framework.Functions.GetPlayer(src)
    if xPlayer ~= nil then
    if  not (PlayersGeblindoekt[target]) or PlayersGeblindoekt[target] == nil then
        TriggerClientEvent('pepe-blinddoekclient:omdoen',target)
        PlayersGeblindoekt[target] = true
      end
   end
 end)
  



Framework.Functions.CreateCallback('blinddoek:check', function(source, cb)
    local src = source
    local Ply = Framework.Functions.GetPlayer(src)
    local blindfold = Ply.Functions.GetItemByName("blinddoek")
    if blindfold ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('pepe-blinddoekserver:afdoen')
AddEventHandler('pepe-blinddoekserver:afdoen', function(target)
    local src = source
    local xPlayer = Framework.Functions.GetPlayer(src)
        TriggerClientEvent('pepe-blinddoekclient:afdoen',target)
        PlayersGeblindoekt[target] = false
end)

Framework.Functions.CreateUseableItem("blinddoek", function(source, item)
    local Player = Framework.Functions.GetPlayer(source)
        if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("pepe-blinddoekclient:omdoenanderespeler",source)
      end
end)

Framework.Functions.CreateUseableItem("knife", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("pepe-blinddoekclient:afdoenanderespeler",source)
    end
end)