-- Framework = nil
-- TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)
local Framework = exports["pepe-core"]:GetCoreObject()

local DoorLocked = true
RegisterServerEvent('pepe-lawyers:server:doorState')
AddEventHandler('pepe-lawyers:server:doorState', function(bool)
	if bool == nil then
		TriggerClientEvent('pepe-lawyers:client:doorState', source, DoorLocked)
		return
	end

	DoorLocked = bool
	TriggerClientEvent('pepe-lawyers:client:doorState', -1, DoorLocked)
end)