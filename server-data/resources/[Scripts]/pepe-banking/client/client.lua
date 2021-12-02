local CanOpenBank = false
local LoggedIn = false

local sendnotify = false

Framework = exports["pepe-core"]:GetCoreObject()
RegisterNetEvent('Framework:Client:OnPlayerLoaded')
AddEventHandler('Framework:Client:OnPlayerLoaded', function()
      LoggedIn = true
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 1300
        if LoggedIn then
         IsNearBank = false
          for k, v in pairs(Config.Banks) do
            local PlayerCoords = GetEntityCoords(PlayerPedId())
            -- local Distance = GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, v['X'], v['Y'], v['Z'], true)
            
                local Distance = #(PlayerCoords - vector3(v['X'], v['Y'], v['Z']))
            if Distance < 2.5 then
                sleep = 5
                if v['IsOpen'] then
                    CanOpenBank = true
                    sendnotify = true
                    DrawMarker(2, v['X'], v['Y'], v['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 48, 255, 58, 255, false, false, false, 1, false, false, false)
                else
                    CanOpenBank = false
                    sendnotify = false
                    DrawMarker(2, v['X'], v['Y'], v['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 72, 48, 255, false, false, false, 1, false, false, false)
                end
                IsNearBank = true
                sendnotify = true
            end
          end
          if not IsNearBank then
            CanOpenBank = false
            sendnotify = false
          end
        end
        Citizen.Wait(sleep)
    end
end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(10)
-- 		-- if LoggedIn then
-- 		     	if sendnotify then
-- 					exports["pepe-ui"]:DrawNotify("pepe-ui:drawnotify", "Gebruik F1 voor de Bank", "#147efb", "fas fa icons")
-- 		     	else
-- 					exports["pepe-ui"]:Clear("pepe-ui:drawnotify")
-- 		     	end
-- 		  Citizen.Wait(1500)
-- 		-- end
-- 	end
-- end)

RegisterNetEvent('pepe-banking:client:open:bank')
AddEventHandler('pepe-banking:client:open:bank', function()
    Citizen.SetTimeout(450, function()
        OpenBank(true)
    end)
end)

RegisterNetEvent('pepe-banking:client:open:atm')
AddEventHandler('pepe-banking:client:open:atm', function()
    Citizen.SetTimeout(450, function()
        OpenBank(false)
    end)
end)

RegisterNUICallback('ClickSound', function(data)
    if data.success == 'bank-error' then
     PlaySound(-1, "Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds", 0, 0, 1)
    elseif data.success == 'click' then
     PlaySound(-1, "CLICK_BACK", "WEB_NAVIGATION_SOUNDS_PHONE", 0, 0, 1)
    else
     TriggerEvent("pepe-sound:client:play", data.success, 0.25)
    end
end)

RegisterNUICallback('Withdraw', function(data)
    if IsNearAnyBank() or IsNearAtm() then
      TriggerServerEvent('pepe-banking:server:withdraw', data.RemoveAmount, data.BankId) 
    end
end)

RegisterNUICallback('Deposit', function(data)
    if IsNearAnyBank() then
      TriggerServerEvent('pepe-banking:server:deposit', data.AddAmount, data.BankId) 
    end
end)

RegisterNUICallback('CreateAccount', function(data)
     if IsNearAnyBank() or IsNearAtm() then
       TriggerServerEvent('pepe-banking:server:create:account', data.Name, data.Type)
    end
end)

RegisterNUICallback('AddUserToAccount', function(data)
     if IsNearAnyBank() or IsNearAtm() then
       TriggerServerEvent('pepe-banking:server:add:user', data.BankId, data.TargetBsn)
    end
end)

RegisterNUICallback('DeleteFromAccount', function(data)
     if IsNearAnyBank() or IsNearAtm() then
       TriggerServerEvent('pepe-banking:server:remove:user', data.BankId, data.TargetBsn)
     end
end)

RegisterNUICallback('DeleteAccount', function(data)
    if IsNearAnyBank() or IsNearAtm() then
        TriggerServerEvent('pepe-banking:server:remove:account', data.BankId)
      end
end)

RegisterNUICallback('GetTransactions', function(data)
    if IsNearAnyBank() or IsNearAtm() then
        Framework.Functions.TriggerCallback('pepe-banking:server:get:account:transactions', function(Transactions)
         SendNUIMessage({
           action = 'SetupTransaction',
           transaction = Transactions,
         })    
        end, data.BankId)
    end
end)

RegisterNUICallback('GetPersonalBalance', function(data, cb)
    local Player = Framework.Functions.GetPlayerData()
    local Data = {
        Balance = Player.money['bank'],
        BankId = Player.charinfo.account,
        CitizenId = Player.citizenid,
        Name = Player.charinfo.firstname..' '.. Player.charinfo.lastname,
    }
    cb(Data)
end)

RegisterNUICallback('GetSharedAccounts', function(data, cb)
    Framework.Functions.TriggerCallback('pepe-banking:server:get:shared:account', function(Accounts)
        cb(Accounts)
    end)  
end)

RegisterNUICallback('GetPrivateAcounts', function(data, cb)
    Framework.Functions.TriggerCallback('pepe-banking:server:get:private:account', function(Accounts)
        cb(Accounts)
    end)  
end)

RegisterNUICallback('CloseApp', function()
    SetNuiFocus(false, false)
    TaskPlayAnim(PlayerPedId(), "amb@prop_human_atm@male@exit", "exit", 1.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Framework.Functions.Progressbar("bank", "Kaart terughalen...", 2000, false, false, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        ClearPedTasks(PlayerPedId())
    end, function()
        Framework.Functions.Notify("Geannuleerd.", "error")
    end)
end)

RegisterNUICallback('GetAccountUsers', function(data)
    Framework.Functions.TriggerCallback('pepe-banking:server:get:account:users', function(Accounts)
        SendNUIMessage({
          action = 'SetupUsers',
          accounts = Accounts,
          citizenid = Framework.Functions.GetPlayerData().citizenid,
        })    
    end, data.BankId)
end)

RegisterNetEvent('pepe-banking:client:check:players:near')
AddEventHandler('pepe-banking:client:check:players:near', function(TargetPlayer, Amount)
    local Player, Distance = Framework.Functions.GetClosestPlayer()
    if Player ~= -1 and Distance < 3.0 then
        if GetPlayerServerId(Player) == TargetPlayer then
            exports['pepe-assets']:RequestAnimationDict('friends@laf@ig_5')
            TaskPlayAnim(PlayerPedId(), 'friends@laf@ig_5', 'nephew', 5.0, 1.0, 5.0,48, 0.0, 0, 0, 0)
            TriggerServerEvent('pepe-banking:server:give:cash', TargetPlayer, Amount) 
        else
            Framework.Functions.Notify("De burger klopt niet.", "error")
        end
    else
        Framework.Functions.Notify("Geen burger gevonden.", "error")
    end
end)

function OpenBank(CanDeposit, UseAnim)
    exports['pepe-assets']:RequestAnimationDict('amb@prop_human_atm@male@idle_a')
    exports['pepe-assets']:RequestAnimationDict('amb@prop_human_atm@male@exit')
    TaskPlayAnim(PlayerPedId(), "amb@prop_human_atm@male@idle_a", "idle_b", 1.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Framework.Functions.Progressbar("bank", "Kaart insteken...", 2100, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'openbank',
            candeposit = CanDeposit,
            chardata = Framework.Functions.GetPlayerData(),
        })
    end, function()
        Framework.Functions.Notify("Geannuleerd.", "error")
    end)
end

function IsNearAtm()
    local PlayerCoords = GetEntityCoords(PlayerPedId())
    for k, v in pairs(Config.AtmObject) do
        local AtmObject = GetClosestObjectOfType(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, 3.0, v, false, 0, 0)
        local ObjectCoords = GetEntityCoords(AtmObject)
        -- local Distance = GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, ObjectCoords.x, ObjectCoords.y, ObjectCoords.z, true)
        local Distance = #(PlayerCoords - vector3(ObjectCoords.x, ObjectCoords.y, ObjectCoords.z))
        if Distance < 2.0 then
            return true
        end
    end
end

function IsNearAnyBank()
    return CanOpenBank
end