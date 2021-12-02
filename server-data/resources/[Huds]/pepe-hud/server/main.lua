local ResetStress = false -- stress
local Framework = exports["pepe-core"]:GetCoreObject()
RegisterServerEvent("pepe-hud:Server:UpdateStress")
AddEventHandler('pepe-hud:Server:UpdateStress', function(StressGain)
	local src = source
    local Player = Framework.Functions.GetPlayer(src)
    local newStress
    if Player ~= nil then
        if not ResetStress then
            if Player.PlayerData.metadata["stress"] == nil then
                Player.PlayerData.metadata["stress"] = 0
            end
            newStress = Player.PlayerData.metadata["stress"] + StressGain
            if newStress <= 0 then newStress = 0 end
        else
            newStress = 0
        end
        if newStress > 100 then
            newStress = 100
        end
        Player.Functions.SetMetaData("stress", newStress)
		TriggerClientEvent("pepe-hud:client:update:stress", src, newStress)
	end
end)

RegisterServerEvent('pepe-hud:server:gain:stress')
AddEventHandler('pepe-hud:server:gain:stress', function(amount)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    local newStress
    if Player ~= nil then
        if not ResetStress then
            if Player.PlayerData.metadata["stress"] == nil then
                Player.PlayerData.metadata["stress"] = 0
            end
            newStress = Player.PlayerData.metadata["stress"] + amount
            if newStress <= 0 then newStress = 0 end
        else
            newStress = 0
        end
        if newStress > 100 then
            newStress = 100
        end
        Player.Functions.SetMetaData("stress", newStress)
        TriggerClientEvent("pepe-hud:client:update:stress", src, newStress)
        TriggerClientEvent('Framework:Notify', src, '+ Stress', 'error', 1500)
	end
end)

RegisterServerEvent('pepe-hud:Server:RelieveStress')
AddEventHandler('pepe-hud:Server:RelieveStress', function(amount)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    local newStress
    if Player ~= nil then
        if not ResetStress then
            if Player.PlayerData.metadata["stress"] == nil then
                Player.PlayerData.metadata["stress"] = 0
            end
            newStress = Player.PlayerData.metadata["stress"] - amount
            if newStress <= 0 then newStress = 0 end
        else
            newStress = 0
        end
        if newStress > 100 then
            newStress = 100
        end
        Player.Functions.SetMetaData("stress", newStress)
        TriggerClientEvent("pepe-hud:client:update:stress", src, newStress)
        TriggerClientEvent('Framework:Notify', src, '- Stress')
	end
end)

RegisterServerEvent('pepe-hud:server:remove:stress')
AddEventHandler('pepe-hud:server:remove:stress', function(Amount)
    local Player = Framework.Functions.GetPlayer(source)
    local NewStress = nil
    if Player ~= nil then
      NewStress = Player.PlayerData.metadata["stress"] - Amount
      if NewStress <= 0 then NewStress = 0 end
      if NewStress > 105 then NewStress = 100 end
      Player.Functions.SetMetaData("stress", NewStress)
      TriggerClientEvent("pepe-hud:client:update:stress", Player.PlayerData.source, NewStress)
    end
end)