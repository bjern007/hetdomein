LoggedIn = false
Framework = exports["pepe-core"]:GetCoreObject()

RegisterNetEvent('Framework:Client:OnPlayerLoaded')
AddEventHandler('Framework:Client:OnPlayerLoaded', function()
     LoggedIn = true
end)