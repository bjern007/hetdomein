local CurrentPawn = nil
local NearPawnShop = false
local PawnClosed = false

-- Code

Citizen.CreateThread(function()
    while true do
        local sleep = 1400
      if LoggedIn then
          local PlayerCoords = GetEntityCoords(PlayerPedId())
          NearPawnShop = false
           for k, v in pairs(Config.Locations['PawnShops']) do 
             local Area = #(PlayerCoords - vector3(v['X'], v['Y'], v['Z']))
             if Area <= 1.5 then
                sleep = 5
                local Hour = GetClockHours()
                NearPawnShop = true
                CurrentPawn = k
                if Hour >= v['Open-Time'] and Hour <= v['Close-Time'] then
                    PawnClosed = false
                else
                    PawnClosed = true
                end
             end
           end
         if not NearPawnShop then
          PawnClosed = nil
          CurrentPawn = nil
         end
      end
      
      Wait(sleep)
    end
end)

-- Citizen.CreateThread(function()
--     while true do
--        Citizen.Wait(4)
--        if LoggedIn then
--           if NearPawnShop and CurrentPawn ~= nil then
--               if PawnClosed then
--                 DrawText3D(Config.Locations['PawnShops'][CurrentPawn]['X'], Config.Locations['PawnShops'][CurrentPawn]['Y'], Config.Locations['PawnShops'][CurrentPawn]['Z'], '~r~Closed')
--               else
--                 -- DrawText3D(Config.Locations['PawnShops'][CurrentPawn]['X'], Config.Locations['PawnShops'][CurrentPawn]['Y'], Config.Locations['PawnShops'][CurrentPawn]['Z'], '~g~E~s~ - Sell Goods')
--                     -- TriggerServerEvent('pepe-doorlock:server:updateState', 84, false)
--                 -- if IsControlJustReleased(0, 38) then
--                 --     if Config.Locations['PawnShops'][CurrentPawn]['Type'] == 'Bars' then
--                 --       SellGoldBars(CurrentPawn)
--                 --     else
--                 --       SellGoldItems(CurrentPawn)
--                 --     end
--                 -- end
--             end
--           end
--        end
--     end
-- end)


RegisterNetEvent('pepe-pawnshop:client:sellitems')
AddEventHandler('pepe-pawnshop:client:sellitems', function()
        if not PawnClosed then
            Framework.Functions.TriggerCallback('pepe-pawnshop:server:has:gold', function(HasItems)
                if HasItems then
                    TriggerEvent('pepe-inventory:client:set:busy', true)
                Framework.Functions.Progressbar("sell-gold", "Goederen verkopen...", math.random(5000, 7000), false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    TriggerServerEvent('pepe-pawnshop:server:sell:gold:items')
                    StopAnimTask(PlayerPedId(), "random@shop_robbery", "robbery_action_b", 1.0)
                    Framework.Functions.Notify("Niemand in de buurt", "error")
                    TriggerEvent('pepe-inventory:client:set:busy', false)
                end, function() -- Cancel
                    StopAnimTask(PlayerPedId(), "random@shop_robbery", "robbery_action_b", 1.0)
                    Framework.Functions.Notify("Geannuleerd.", "error")
                    TriggerEvent('pepe-inventory:client:set:busy', false)
                end)
                else
                    Framework.Functions.Notify("Je hebt geen acceptabele goederen bij je.", "error")
                    TriggerEvent('pepe-inventory:client:set:busy', false)
                end
            end)     
        else
            Framework.Functions.Notify("De pawnshop neemt nog niets aan.", "error")   
        end
end)
RegisterNetEvent('pepe-pawnshop:client:sellgoldbars')
AddEventHandler('pepe-pawnshop:client:sellgoldbars', function()
    if not PawnClosed then
            Framework.Functions.TriggerCallback('Framework:HasItem', function(HasGold)
                if HasGold then
                    TriggerEvent('pepe-inventory:client:set:busy', true)
                Framework.Functions.Progressbar("sell-gold", "Goederen verkopen...", math.random(5000, 7000), false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    TriggerServerEvent('pepe-pawnshop:server:sell:gold:bars')
                    StopAnimTask(PlayerPedId(), "random@shop_robbery", "robbery_action_b", 1.0)
                end, function() -- Cancel
                    StopAnimTask(PlayerPedId(), "random@shop_robbery", "robbery_action_b", 1.0)
                    Framework.Functions.Notify("Geannuleerd.", "error")
                    TriggerEvent('pepe-inventory:client:set:busy', false)
                end)
                else
                    Framework.Functions.Notify("Je hebt geen acceptabele goederen bij je.", "error")
                    TriggerEvent('pepe-inventory:client:set:busy', false)
                end
            end, 'gold-bar')
        
        else
            Framework.Functions.Notify("De pawnshop neemt nog niets aan.", "error")   
    end 
end)