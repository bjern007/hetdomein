Framework = nil
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10) -- 
        if Framework == nil then
            TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)
            Citizen.Wait(200)
        end
    end
end)