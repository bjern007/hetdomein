local playerData, playerJob = nil, nil
Citizen.CreateThread(function()
	while Framework == nil do
		TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)
		Citizen.Wait(200)
	end

	while Framework.Functions.GetPlayerData() == nil do
		Wait(0)
	end

	while Framework.Functions.GetPlayerData().job == nil do
		Wait(0)
	end

	playerData = Framework.Functions.GetPlayerData()
    playerJob = Framework.Functions.GetPlayerData().job
end)

RegisterNetEvent("Framework:Client:OnJobUpdate")
AddEventHandler("Framework:Client:OnJobUpdate", function(jobInfo)
    playerJob = jobInfo
    playerData = Framework.Functions.GetPlayerData()
end)

CreateThread(function()
    for k,v in pairs(Config.Items.items) do
        v.slot = k
    end

    while true do
        Wait(1)
        local plyPed = PlayerPedId()
        local plyCoords = GetEntityCoords(plyPed)
        local letSleep = true
            local ShopDistance = GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, Config.Locations['shop'].x, Config.Locations['shop'].y, Config.Locations['shop'].z, true)
                
            if ShopDistance < 20 then
                letSleep = false
                if ShopDistance < 2.5 then
                    DrawText3Ds(Config.Locations['shop']["x"], Config.Locations['shop']["y"], Config.Locations['shop']["z"], "[E] - Winkel")
                    if IsControlJustPressed(0, 38) then
                        TriggerServerEvent("pepe-inventory:server:OpenInventory", "shop", "drugdealer", Config.Items)
                    end
                end
            end

        if letSleep then
            Wait(1500)
        end
    end
end)