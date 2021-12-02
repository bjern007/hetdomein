local IsBankBeingRobbed = false
cooldowntime = Config.Cooldown 
atmcooldown = false
local Framework = exports["pepe-core"]:GetCoreObject()
-- Code

Framework.Functions.CreateCallback("pepe-bankrobbery:server:get:status", function(source, cb)
  cb(IsBankBeingRobbed)
end)

Framework.Functions.CreateCallback("pepe-bankrobbery:server:get:key:config", function(source, cb)
  cb(Config)
end)

Framework.Functions.CreateCallback("pepe-atmrobbery:getHackerDevice",function(source,cb)
	local xPlayer = Framework.Functions.GetPlayer(source)
	if xPlayer.Functions.GetItemByName("electronickit") and xPlayer.Functions.GetItemByName("drill") then
		cb(true)
	else
		cb(false)
		TriggerClientEvent('Framework:Notify', source, _U("needdrill"))
	end
end)

Framework.Functions.CreateCallback('pepe-bankrobbery:server:HasItem', function(source, cb, ItemName)
  local Player = Framework.Functions.GetPlayer(source)
  local Item = Player.Functions.GetItemByName(ItemName)
  if Player ~= nil then
     if Item ~= nil then
       cb(true)
     else
       cb(false)
     end
  end
end)

Framework.Functions.CreateCallback('pepe-bankrobbery:server:HasLockpickItems', function(source, cb)
  local Player = Framework.Functions.GetPlayer(source)
  local LockpickItem = Player.Functions.GetItemByName('lockpick')
  local ToolkitItem = Player.Functions.GetItemByName('toolkit')
  local AdvancedLockpick = Player.Functions.GetItemByName('advancedlockpick')
  if Player ~= nil then
    if LockpickItem ~= nil and ToolkitItem ~= nil or AdvancedLockpick ~= nil then
      cb(true)
    else
      cb(false)
    end
  end
end)

RegisterServerEvent('pepe-atm:rem:drill')
AddEventHandler('pepe-atm:rem:drill', function()
local xPlayer = Framework.Functions.GetPlayer(source)
	xPlayer.Functions.RemoveItem('drill', 1)
end)

Framework.Functions.CreateUseableItem('electronickit', function(source)
	TriggerClientEvent('pepe-atm:item', source)
end)


RegisterServerEvent("pepe-atmrobbery:success")
AddEventHandler("pepe-atmrobbery:success",function()
	local xPlayer = Framework.Functions.GetPlayer(source)
    local reward = math.random(Config.MinReward,Config.MaxReward)
		xPlayer.Functions.AddMoney(Config.RewardAccount, tonumber(reward))

		TriggerClientEvent("Framework:Notify",source,_U("success") ..""..reward.. " !")
end)

RegisterServerEvent('pepe-atm:CooldownServer')
AddEventHandler('pepe-atm:CooldownServer', function(bool)
    atmcooldown = bool
	if bool then 
		cooldown()
	end	 
end)

RegisterServerEvent('pepe-atm:CooldownNotify')
AddEventHandler('pepe-atm:CooldownNotify', function()
	TriggerClientEvent("Framework:Notify",source,_U("atmrob") ..""..cooldowntime.." Minutes!")
end)

function cooldown()

	while true do 
	Citizen.Wait(60000)

	cooldowntime = cooldowntime - 1 

	if cooldowntime <= 0 then
		atmcooldown = false
		break
	end

end
end

Framework.Functions.CreateCallback("pepe-atm:GetCooldown",function(source,cb)
	cb(atmcooldown)
end)


RegisterServerEvent('pepe-bankrobbery:server:set:state')
AddEventHandler('pepe-bankrobbery:server:set:state', function(BankId, LockerId, Type, bool)
 Config.BankLocations[BankId]['Lockers'][LockerId][Type] = bool
 TriggerClientEvent('pepe-bankrobbery:client:set:state', -1, BankId, LockerId, Type, bool)
end)

RegisterServerEvent('pepe-bankrobbery:server:set:open')
AddEventHandler('pepe-bankrobbery:server:set:open', function(BankId, bool)
 IsBankBeingRobbed = bool
 Config.BankLocations[BankId]['IsOpened'] = bool
 TriggerClientEvent('pepe-bankrobbery:client:set:open', -1, BankId, bool)
 StartRestart(BankId)
end)

RegisterServerEvent('pepe-bankrobbery:server:random:reward')
AddEventHandler('pepe-bankrobbery:server:random:reward', function(Tier, BankId)
  local Player = Framework.Functions.GetPlayer(source)
  local RandomValue = math.random(1, 110)
  TriggerEvent('pepe-board:server:SetActivityBusy', "bankrobbery", true)
  Player.Functions.AddItem('markedbills', 1, false, {worth = math.random(15000, 18000)})
  TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['markedbills'], "add")

  if BankId == 1 then -- BLOKKENPARK
    if RandomValue >= 1 and RandomValue <= 18 then
      if Tier == 2 then
        Player.Functions.AddItem('yellow-card', 1)
        TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['yellow-card'], "add")
      elseif Tier == 3 then
        Player.Functions.AddItem('purple-card', 1)
        TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['purple-card'], "add")
      end
    -- elseif Tier == 4 then
    -- elseif Tier == 5 then
      -- Player.Functions.AddMoney('cash', math.random(26000, 38500), "Bank Robbery")
    elseif RandomValue >= 22 and RandomValue <= 35 then
      Player.Functions.AddItem('markedbills', 1, false, {worth = math.random(15000, 35000)})
      TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['markedbills'], "add")
    elseif RandomValue >= 40 and RandomValue <= 52 then
      Player.Functions.AddItem('gold-bar', math.random(3,6))
      TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['gold-bar'], "add") 
    elseif RandomValue >= 55 and RandomValue <= 75 then
      Player.Functions.AddItem('gold-necklace', math.random(8,12))
      TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['gold-necklace'], "add") 
    elseif RandomValue >= 76 and RandomValue <= 96 then
      Player.Functions.AddItem('gold-rolex', math.random(6,10))
      TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['gold-rolex'], "add")
    else
      TriggerClientEvent('Framework:Notify', source, _U("nopes"), "error", 4500)
    end
  -- end
elseif BankId ~= 6 then -- ALLE ANDERE BANKEN NAAST WATER ETC
  
  Player.Functions.AddItem('markedbills', 1, false, {worth = math.random(25000, 35000)})
  TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['markedbills'], "add")

      if RandomValue >= 1 and RandomValue <= 18 then
        if Tier == 2 then
          Player.Functions.AddItem('yellow-card', 1)
          TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['yellow-card'], "add")
        elseif Tier == 3 then
          Player.Functions.AddItem('purple-card', 1)
          TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['purple-card'], "add")
        elseif Tier == 4 then
        Player.Functions.AddItem('money-roll', 1, false, {worth = math.random(100, 600)})
        TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['money-roll'], "add")
        elseif Tier == 5 then
        Player.Functions.AddItem('purple-card', 1)
        TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['purple-card'], "add")
        end
      if RandomValue >= 22 and RandomValue <= 35 then
        Player.Functions.AddItem('markedbills', 1, false, {worth = math.random(15000, 25000)})
        TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['markedbills'], "add")
      elseif RandomValue >= 40 and RandomValue <= 52 then
        Player.Functions.AddItem('gold-bar', math.random(9,13))
        TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['gold-bar'], "add") 
      elseif RandomValue >= 55 and RandomValue <= 75 then
        Player.Functions.AddItem('gold-necklace', math.random(10,25))
        TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['gold-necklace'], "add") 
      elseif RandomValue >= 76 and RandomValue <= 96 then
        Player.Functions.AddItem('gold-rolex', math.random(8,20))
        TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['gold-rolex'], "add")
      else
        TriggerClientEvent('Framework:Notify', source, _U("nopes"), "error", 4500)
      end
    end
  else
    Player.Functions.AddItem('money-roll', 1, false, {worth = math.random(100, 600)})
    TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['money-roll'], "add")
      if RandomValue >= 1 and RandomValue <= 18 then
        if Tier == 2 then
          Player.Functions.AddItem('yellow-card', 1)
          TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['yellow-card'], "add")
        elseif Tier == 3 then
          Player.Functions.AddItem('black-card', 1)
          TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['black-card'], "add")
        end
      elseif RandomValue >= 22 and RandomValue <= 36 then
        Player.Functions.AddItem('markedbills', 1, false, {worth = math.random(35000, 36000)})
        TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['markedbills'], "add")
      elseif RandomValue >= 40 and RandomValue <= 55 then
        Player.Functions.AddItem('gold-bar', math.random(4,8))
        TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['gold-bar'], "add") 
      elseif RandomValue >= 62 and RandomValue <= 96 then
        Player.Functions.AddItem('gold-rolex', math.random(6,12))
        TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['gold-rolex'], "add")
      elseif RandomValue >= 33 and RandomValue <= 36 then
        Player.Functions.AddItem('gold-necklace', math.random(12,16))
        TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['gold-necklace'], "add")
      elseif RandomValue == 110 or RandomValue == 97 or RandomValue == 98 or RandomValue == 105 then
        if Tier == 1 then
          Player.Functions.AddItem('blue-card', 1)
          TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['blue-card'], "add")
        elseif Tier == 2 then
          Player.Functions.AddItem('black-card', 1)
          TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['black-card'], "add")
        elseif Tier == 3 then
          -- Player.Functions.AddItem('weapon_snspistol_mk2', 1)
          -- TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['weapon_snspistol_mk2'], "add")
          Player.Functions.AddItem('burner-phone', math.random(3, 4))
          TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['burner-phone'], "add")
        elseif Tier == 4 then
          Player.Functions.AddItem('burner-phone', math.random(3, 4))
          TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['burner-phone'], "add")
        elseif Tier == 5 then
          Player.Functions.AddItem('pistol-ammo', math.random(1,3))
          TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['pistol-ammo'], "add")
        end
      else
        TriggerClientEvent('Framework:Notify', source, _U("nopes"), "error", 4500)
      end
      
  end
end)

RegisterServerEvent('pepe-bankrobbery:server:rob:pacific:money')
AddEventHandler('pepe-bankrobbery:server:rob:pacific:money', function()
  local Player = Framework.Functions.GetPlayer(source)
  local RandomValue = math.random(1, 130)
  Player.Functions.AddMoney('cash', math.random(2000, 10000), "Bank Robbery")

  if RandomValue > 15 and  RandomValue < 20 then
     Player.Functions.AddItem('money-roll', 1, false, {worth = math.random(25, 300)})
     TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['money-roll'], "add")
  end

  if RandomValue > 33 and  RandomValue <  34 then
    Player.Functions.AddItem('weapon_heavypistol', 1)
    TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['weapon_heavypistol'], "add")
  end

  if RandomValue > 35 and  RandomValue <  66 then
    Player.Functions.AddItem('diamond-blue', math.random(1,2))
    TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['diamond-blue'], "add")
  end

  if RandomValue > 66 and  RandomValue <  69 then
    Player.Functions.AddItem('diamond-red', math.random(1,2))
    TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['diamond-red'], "add")
  end

  if RandomValue > 70 and  RandomValue <  75 then
    Player.Functions.AddItem('burner-phone', math.random(1,10))
    TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['burner-phone'], "add")
  end

  if RandomValue > 75 and  RandomValue <  130 then
    Player.Functions.AddItem('markedbills', 1, false, {worth = math.random(20000, 40000)})
    TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items['markedbills'], "add")
  end

end)

RegisterServerEvent('pepe-bankrobbery:server:pacific:start')
AddEventHandler('pepe-bankrobbery:server:pacific:start', function()
  Config.SpecialBanks[1]['Open'] = true
  IsBankBeingRobbed = true
  TriggerClientEvent('pepe-bankrobbery:client:pacific:start', -1)
  Citizen.SetTimeout((1000 * 60) * math.random(20,30), function()
    TriggerClientEvent('pepe-bankrobbery:client:clear:trollys', -1)
    TriggerClientEvent('pepe-doorlock:server:reset:door:looks', -1)
    IsBankBeingRobbed = false
    for k,v in pairs(Config.Trollys) do 
      v['Open-State'] = false
    end

    for k,v in pairs(Config.DrillLocations) do 
      v['Open-State'] = false
    end
    
  end)
end)

RegisterServerEvent('pepe-bankrobbery:server:set:trolly:state')
AddEventHandler('pepe-bankrobbery:server:set:trolly:state', function(TrollyNumber, bool)
 Config.Trollys[TrollyNumber]['Open-State'] = bool
 TriggerClientEvent('pepe-bankrobbery:client:set:trolly:state', -1, TrollyNumber, bool)
end)

RegisterServerEvent('pepe-bankrobbery:server:set:drill:state')
AddEventHandler('pepe-bankrobbery:server:set:drill:state', function(DrillNumber, bool)
 Config.DrillLocations[DrillNumber]['Open-State'] = bool
 TriggerClientEvent('pepe-bankrobbery:client:set:drill:state', -1, DrillNumber, bool)
end)

function StartRestart(BankId)
  Citizen.SetTimeout((1000 * 60) * math.random(20,30), function()
    IsBankBeingRobbed = false
    Config.BankLocations[BankId]['IsOpened'] = false
    TriggerClientEvent('pepe-bankrobbery:client:set:open', -1, BankId, false)
    --DOORS reset
    for k, v in pairs(Config.BankLocations[BankId]['DoorId']) do
      TriggerEvent('pepe-doorlock:server:updateState', v, true)
    end
    -- Lockers
    for k,v in pairs(Config.BankLocations[BankId]['Lockers']) do
     v['IsBusy'] = false
     v['IsOpend'] = false
    TriggerClientEvent('pepe-bankrobbery:client:set:state', -1, BankId, k, 'IsBusy', false)
    TriggerClientEvent('pepe-bankrobbery:client:set:state', -1, BankId, k, 'IsOpend', false)
    end
    
    TriggerEvent('pepe-board:server:SetActivityBusy', "bankrobbery", false)
  end)
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(4)
    for k, v in pairs(Config.BankLocations) do
      local RandomCard = Config.CardType[math.random(1, #Config.CardType)]
      Config.BankLocations[k]['card-type'] = RandomCard
      TriggerClientEvent('pepe-bankrobbery:client:set:cards', -1, k, Config.BankLocations[k]['card-type'])
    end
    Citizen.Wait((1000 * 60) * 60)
  end
end)


Citizen.CreateThread(function()
  while true do
      Citizen.Wait(1000 * 60 * 10)
      if blackoutActive then
          TriggerEvent("pepe-weathersync:server:toggleBlackout")
          TriggerClientEvent("pepe-police:client:EnableAllCameras", -1)
          TriggerClientEvent("pepe-bankrobbery:client:enableAllBankSecurity", -1)
          blackoutActive = false
      end
  end
end)


Citizen.CreateThread(function()
  while true do
      Citizen.Wait(1000 * 60 * 45)
      TriggerClientEvent("pepe-bankrobbery:client:enableAllBankSecurity", -1)
      TriggerClientEvent("pepe-police:client:EnableAllCameras", -1)
  end
end)


RegisterServerEvent('pepe-bankrobbery:server:SetStationStatus')
AddEventHandler('pepe-bankrobbery:server:SetStationStatus', function(key, isHit)
    Config.PowerStations[key].hit = isHit
    TriggerClientEvent("pepe-bankrobbery:client:SetStationStatus", -1, key, isHit)
    if AllStationsHit() then
        TriggerEvent("pepe-weathersync:server:toggleBlackout")
        TriggerClientEvent("pepe-police:client:DisableAllCameras", -1)
        TriggerClientEvent("pepe-bankrobbery:client:disableAllBankSecurity", -1)
        blackoutActive = true
    else
        CheckStationHits()
    end
end)

RegisterServerEvent('thermite:StartServerFire')
AddEventHandler('thermite:StartServerFire', function(coords, maxChildren, isGasFire)
    TriggerClientEvent("thermite:StartFire", -1, coords, maxChildren, isGasFire)
end)

RegisterServerEvent('thermite:StopFires')
AddEventHandler('thermite:StopFires', function(coords, maxChildren, isGasFire)
    TriggerClientEvent("thermite:StopFires", -1)
end)

function CheckStationHits()
    if Config.PowerStations[1].hit and Config.PowerStations[2].hit and Config.PowerStations[3].hit then
        TriggerClientEvent("pepe-police:client:SetCamera", -1, 19, false)
    end
    if Config.PowerStations[3].hit then
        TriggerClientEvent("pepe-police:client:SetCamera", -1, 18, false)
        TriggerClientEvent("pepe-police:client:SetCamera", -1, 7, false)
    end
    if Config.PowerStations[4].hit and Config.PowerStations[5].hit and Config.PowerStations[6].hit then
        TriggerClientEvent("pepe-police:client:SetCamera", -1, 4, false)
        TriggerClientEvent("pepe-police:client:SetCamera", -1, 8, false)
        TriggerClientEvent("pepe-police:client:SetCamera", -1, 5, false)
        TriggerClientEvent("pepe-police:client:SetCamera", -1, 6, false)
    end
    if Config.PowerStations[1].hit and Config.PowerStations[2].hit and Config.PowerStations[3].hit and Config.PowerStations[4].hit and Config.PowerStations[5].hit and Config.PowerStations[6].hit then
        TriggerClientEvent("pepe-police:client:SetCamera", -1, 1, false)
        TriggerClientEvent("pepe-police:client:SetCamera", -1, 2, false)
        TriggerClientEvent("pepe-police:client:SetCamera", -1, 3, false)
    end
    if Config.PowerStations[7].hit and Config.PowerStations[8].hit then
        TriggerClientEvent("pepe-police:client:SetCamera", -1, 9, false)
        TriggerClientEvent("pepe-police:client:SetCamera", -1, 10, false)
    end
    if Config.PowerStations[9].hit then
        TriggerClientEvent("pepe-police:client:SetCamera", -1, 11, false)
        TriggerClientEvent("pepe-police:client:SetCamera", -1, 12, false)
        TriggerClientEvent("pepe-police:client:SetCamera", -1, 13, false)
    end
    if Config.PowerStations[9].hit and Config.PowerStations[10].hit then
        TriggerClientEvent("pepe-police:client:SetCamera", -1, 14, false)
        TriggerClientEvent("pepe-police:client:SetCamera", -1, 17, false)
        TriggerClientEvent("pepe-police:client:SetCamera", -1, 19, false)
    end
    if Config.PowerStations[7].hit and Config.PowerStations[9].hit and Config.PowerStations[10].hit then
        TriggerClientEvent("pepe-police:client:SetCamera", -1, 15, false)
        TriggerClientEvent("pepe-police:client:SetCamera", -1, 16, false)
    end
    if Config.PowerStations[10].hit then
        TriggerClientEvent("pepe-police:client:SetCamera", -1, 20, false)
    end
    if Config.PowerStations[11].hit and Config.PowerStations[1].hit and Config.PowerStations[2].hit then
        TriggerClientEvent("pepe-police:client:SetCamera", -1, 21, false)
        TriggerClientEvent("pepe-bankrobbery:client:BankSecurity", 1, false)
        TriggerClientEvent("pepe-police:client:SetCamera", -1, 22, false)
        TriggerClientEvent("pepe-bankrobbery:client:BankSecurity", 2, false)
    end
    if Config.PowerStations[8].hit and Config.PowerStations[4].hit and Config.PowerStations[5].hit and Config.PowerStations[6].hit then
        TriggerClientEvent("pepe-police:client:SetCamera", -1, 23, false)
        TriggerClientEvent("pepe-bankrobbery:client:BankSecurity", 3, false)
    end
    if Config.PowerStations[12].hit and Config.PowerStations[13].hit then
        TriggerClientEvent("pepe-police:client:SetCamera", -1, 24, false)
        TriggerClientEvent("pepe-bankrobbery:client:BankSecurity", 4, false)
        TriggerClientEvent("pepe-police:client:SetCamera", -1, 25, false)
        TriggerClientEvent("pepe-bankrobbery:client:BankSecurity", 5, false)
    end
end

function AllStationsHit()
    local retval = true
    for k, v in pairs(Config.PowerStations) do
        if not Config.PowerStations[k].hit then
            retval = false
        end
    end
    return retval
end


RegisterServerEvent('kwk-robparking:server:1I1i01I1')
AddEventHandler('kwk-robparking:server:1I1i01I1', function(count)
    local src = source
    local xPlayer = Framework.Functions.GetPlayer(src)
    --print("haha")
    local data = {
        worth = math.random(50,200)
    }

    xPlayer.Functions.AddItem('markedbills', 1, false, data)
    TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items["markedbills"], 'add')
    TriggerClientEvent('Framework:Notify', src, 'Totaal bedrag uit de parkeermeter getrokken: € ' ..data.worth, "success")end)

Framework.Functions.CreateUseableItem("thermite", function(source, item)
    local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('lighter') ~= nil then
        TriggerClientEvent("thermite:UseThermite", source)
    else
        TriggerClientEvent('Framework:Notify', source, "Je mist iets om het mee te vlammen..", "error")
    end
end)
-- // Card Types \\ --
-- pepe-bankrobbery:client:openVault

RegisterServerEvent('pepe-bankrobbery:server:doorFix')
AddEventHandler('pepe-bankrobbery:server:doorFix', function(hash, heading, pos)
    TriggerClientEvent('pepe-bankrobbery:client:doorFix', -1, hash, heading, pos)
end)

RegisterServerEvent('pepe-bankrobbery:server:openVault')
AddEventHandler('pepe-bankrobbery:server:openVault', function(index)
    TriggerClientEvent('pepe-bankrobbery:client:openVault', -1, index)
end)

Framework.Functions.CreateUseableItem("red-card", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-bankrobbery:client:use:card', source, 'red-card')
    end
end)

Framework.Functions.CreateUseableItem("purple-card", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-bankrobbery:client:use:card', source, 'purple-card')
    end
end)

Framework.Functions.CreateUseableItem("black-card", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-bankrobbery:client:use:black-card', source)
    end
end)

Framework.Functions.CreateUseableItem("gasbomb", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-bankrobbery:client:use:gasbomb', source)
    end
end)

Framework.Functions.CreateUseableItem("blue-card", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-bankrobbery:client:use:card', source, 'blue-card')
    end
end)