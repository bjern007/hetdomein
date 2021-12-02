local Framework = exports["pepe-core"]:GetCoreObject()

RegisterServerEvent('pepe-appartments:server:set:appartment:data')
AddEventHandler('pepe-appartments:server:set:appartment:data', function(AppartmentName)
local Player = Framework.Functions.GetPlayer(source)
local NewAppartmentData = {Id = Player.PlayerData.metadata['appartment-data'].Id, Name = AppartmentName}
    Player.Functions.SetMetaData("appartment-data", NewAppartmentData)
    TriggerClientEvent('pepe-appartments:client:enter:appartment', source, true, AppartmentName)
end)

RegisterServerEvent('pepe-appartments:server:logout')
AddEventHandler('pepe-appartments:server:logout', function()
 local src = source
 local Player = Framework.Functions.GetPlayer(src)
 local PlayerItems = Player.PlayerData.items
 TriggerClientEvent('pepe-radio:onRadioDrop', src)
 if PlayerItems ~= nil then
    Framework.Functions.ExecuteSql(true, "UPDATE `characters_metadata` SET `inventory` = @inventory WHERE `citizenid` = @cid", {
        ['@inventory'] = json.encode(MyItems),
        ['@cid'] = Player.PlayerData.citizenid,
    })
 else
    Framework.Functions.ExecuteSql(true, "UPDATE `characters_metadata` SET `inventory` = '{}' WHERE `citizenid` = @cid", {
        ['@cid'] = Player.PlayerData.citizenid,
    })
 end
 Framework.Player.Logout(src)
 Citizen.Wait(450)
 TriggerClientEvent('pepe-multichar:client:open:select', src)
end)

function GetAppartmentName(AppartmentId)
    return Config.Locations[AppartmentId]['Label']
end

Framework.Commands.Add("doorzoekhuis", "Open appartement Opslag", {{name="id", help="Appartement ID"}}, true, function(source, args)
    local Player = Framework.Functions.GetPlayer(source)
    local AppartementID = args[1]
    if Player.PlayerData.job.name == 'police' or Player.PlayerData.job.name == 'judge' and Player.PlayerData.metadata['ishighcommand'] then
        TriggerClientEvent('pepe-appartments:client:open:appartment:stash', source, AppartementID)
    end
end)