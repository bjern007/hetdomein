local Framework = exports["pepe-core"]:GetCoreObject()

RegisterNetEvent("Mx :: GetTattoos")
AddEventHandler("Mx :: GetTattoos", function()
    local idJ = source
    local Player = Framework.Functions.GetPlayer(idJ)
    local citizenid = Player.PlayerData.citizenid
    if citizenid ~= nil then
        exports.ghmattimysql:execute("SELECT * FROM tattoos where identifier = @identifier",
        {['@identifier'] = citizenid},
        function(result)
            if result and #result > 0 then
                for i,k in pairs(result) do
                    k.tattoos = json.decode(k.tattoos)
                end
                TriggerClientEvent("Mx :: TattoosGeted", idJ, result[1].tattoos)
            else
                TriggerClientEvent("Mx :: TattoosGeted", idJ, {})
            end
        end)  
    end
end)

RegisterNetEvent("Mx :: RegisterTattoos")
AddEventHandler("Mx :: RegisterTattoos", function(tattoos, total_price, free)
    local idJ = source
    
    local Player = Framework.Functions.GetPlayer(source)
    local citizenid = Player.PlayerData.citizenid
    local MoneyPlayer = Player.PlayerData.money['cash']

    if (total_price == 0 or MoneyPlayer >= total_price) or free then
        exports.ghmattimysql:execute('UPDATE tattoos SET tattoos = @tattoos WHERE identifier = @identifier', {
            ['@tattoos'] = json.encode(tattoos), 
            ['@identifier'] = citizenid
        }, function (rows)
            if rows.affectedRows == 0 then
                exports.ghmattimysql:execute('INSERT INTO tattoos (identifier, tattoos) VALUES (@identifier, @tattoos)', {
                    ['@identifier'] = citizenid,
                    ['@tattoos'] = json.encode(tattoos)
                }, function (rows)
                    if not free then Player.Functions.RemoveMoney('cash', tonumber(total_price)) end
                    TriggerClientEvent("Mx :: ClosedStore", idJ, tattoos, total_price)
                end)
            else
                if not free then Player.Functions.RemoveMoney('cash', tonumber(total_price)) end
                TriggerClientEvent("Mx :: ClosedStore", idJ, tattoos, total_price)
            end
        end)
    else
        TriggerClientEvent("Mx :: ClosedStore", idJ, -1, -1)
    end
end)

