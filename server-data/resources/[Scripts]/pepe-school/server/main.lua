local Framework = exports["pepe-core"]:GetCoreObject()

RegisterNetEvent('pepe-school:Betalendiemeuk')
AddEventHandler('pepe-school:Betalendiemeuk', function()
	local src = source
    local xPlayer = Framework.Functions.GetPlayer(src)
	local bankamount = xPlayer.PlayerData.money["bank"]

	if bankamount >= 500 then
		xPlayer.Functions.RemoveMoney('bank', 500)
	end
end)



RegisterServerEvent('pepe-school:server:GetLicense')
AddEventHandler('pepe-school:server:GetLicense', function()
    local src = source
    local Player = Framework.Functions.GetPlayer(src)


    local info = {}
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        info.type = "B"


    Player.Functions.AddItem('drive-card', 1, nil, info)

    TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items['drive-card'], 'add')
end)

