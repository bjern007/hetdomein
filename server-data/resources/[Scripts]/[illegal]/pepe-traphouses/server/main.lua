Framework = nil
TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)

-- Code
Citizen.CreateThread(function()
	Framework.Functions.ExecuteSql(false, "SELECT * FROM `traphouses`", function(result)
		if result[1] ~= nil then
            for k, v in pairs(result) do
                local openeds = false
				if tonumber(v.opened) == 1 then
					openeds = true
                end
                local takingovers = false
                if tonumber(v.takingover) == 1 then
					takingovers = true
                end
				Config.TrapHouses[v.id] = {
					coords = json.decode(v.coords),
					keyholders = json.decode(v.keyholders),
					pincode = v.pincode,
					inventory = json.decode(v.inventory),
					opened = openeds,
					takingover = takingovers,
					money = v.money,
				}
            end
		end
	end)
end)

Framework.Functions.CreateCallback('pepe-traphouses:server:TakeoverHouse', function(source, cb, Traphouse)
	local src = source
    local Player = Framework.Functions.GetPlayer(src)
    local CitizenId = Player.PlayerData.citizenid

    if not HasCitizenIdHasKey(CitizenId, Traphouse) then
        if Player.Functions.RemoveMoney('cash', Config.TakeoverPrice) then
            TriggerClientEvent('pepe-traphouses:client:TakeoverHouse', src, Traphouse)
        else
            TriggerClientEvent('Framework:Notify', src, 'Je hebt niet genoeg contant geld..', 'error')
        end
    end
end)

Framework.Functions.CreateCallback('pepe-traphouses:server:AddHouseKeyHolder', function(source, cb, CitizenId, TraphouseId, IsOwner)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)

    if Config.TrapHouses[TraphouseId] ~= nil then
        if IsOwner then
            Config.TrapHouses[TraphouseId].keyholders = {}
            Config.TrapHouses[TraphouseId].pincode = math.random(11111, 55555) 
        end

        if Config.TrapHouses[TraphouseId].keyholders == nil then
            table.insert(Config.TrapHouses[TraphouseId].keyholders, {
                citizenid = CitizenId,
                owner = IsOwner,
            })
            SaveTrapHouseConfig(TraphouseId)
            TriggerClientEvent('pepe-traphouses:client:SyncData', -1, TraphouseId, Config.TrapHouses[TraphouseId])
        else
            if #Config.TrapHouses[TraphouseId].keyholders + 1 <= 6 then
                if not HasCitizenIdHasKey(CitizenId, TraphouseId) then
                    table.insert(Config.TrapHouses[TraphouseId].keyholders, {
                        citizenid = CitizenId,
                        owner = IsOwner,
                    })
                    SaveTrapHouseConfig(TraphouseId)
                    TriggerClientEvent('pepe-traphouses:client:SyncData', -1, TraphouseId, Config.TrapHouses[TraphouseId])
                end
            else
                TriggerClientEvent('Framework:Notify', src, 'Er zijn geen slots meer over..')
            end
        end
    else
        TriggerClientEvent('Framework:Notify', src, 'Foutje opgetreden..')
    end
end)

RegisterServerEvent('pepe-traphouses:server:TakeoverHouse')
AddEventHandler('pepe-traphouses:server:TakeoverHouse', function(Traphouse)
    Framework.Functions.BanInjection(source, 'pepe-traphouses (TakeoverHouse)')
end)

RegisterServerEvent('pepe-traphouses:server:set:selling:state')
AddEventHandler('pepe-traphouses:server:set:selling:state', function(bool)
    Config.IsSelling = bool
    TriggerClientEvent('pepe-traphouses:client:set:selling:state', -1, bool)
end)

RegisterServerEvent('pepe-traphouse:server:sell:item')
AddEventHandler('pepe-traphouse:server:sell:item', function()
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    for k, v in pairs(Config.SellItems) do
        local Item = Player.Functions.GetItemByName(k)
        if Item ~= nil then
          if Item.amount > 0 then
              for i = 1, Item.amount do
                  Player.Functions.RemoveItem(Item.name, 1)
                  TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items[Item.name], "remove")
                  if v['Type'] == 'info' then
                      Player.Functions.AddMoney('cash', Item.info.worth, 'sold-traphouse')
                  else
                      Player.Functions.AddMoney('cash', v['Amount'], 'sold-traphouse')
                  end
                  Citizen.Wait(500)
              end
          end
        end
    end
end)


Framework.Functions.CreateCallback("pepe-traphouses:server:has:sell:item", function(source, cb)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
     local BlueDiamondItem = Player.Functions.GetItemByName('diamond-blue')
     local RedDiamondItem = Player.Functions.GetItemByName('iamond-red')
     local BillsItem = Player.Functions.GetItemByName('markedbills')
     if BlueDiamondItem ~= nil or RedDiamondItem ~= nil or BillsItem ~= nil then
        cb(true)
     else
        cb(false)
     end
end)

RegisterServerEvent('pepe-traphouses:server:AddHouseKeyHolder')
AddEventHandler('pepe-traphouses:server:AddHouseKeyHolder', function(CitizenId, TraphouseId, IsOwner)
    Framework.Functions.BanInjection(source, 'pepe-traphouses (AddHouseKeyHolder)')
end)

function SaveTrapHouseConfig(TraphouseId)
    local openeds = 0
    if openeds == true then
        openeds = 1
    end
    local takingovers = 0
    if takingovers == true then
        takingovers = 1
    end
    Framework.Functions.ExecuteSql(true, "UPDATE `traphouses` SET coords='"..json.encode(Config.TrapHouses[TraphouseId].coords).."',keyholders='"..json.encode(Config.TrapHouses[TraphouseId].keyholders).."',pincode='"..Config.TrapHouses[TraphouseId].pincode.."',inventory='"..json.encode(Config.TrapHouses[TraphouseId].inventory).."',opened='"..openeds.."',takingover='"..takingovers.."',money='"..Config.TrapHouses[TraphouseId].money.."' WHERE `id` = '"..TraphouseId.."'")
end

function HasCitizenIdHasKey(CitizenId, Traphouse)
    local retval = false
    if Config.TrapHouses[Traphouse].keyholders ~= nil and next(Config.TrapHouses[Traphouse].keyholders) ~= nil then
        for _, data in pairs(Config.TrapHouses[Traphouse].keyholders) do
            if data.citizenid == CitizenId then
                retval = true
                break
            end
        end
    end
    return retval
end

function AddKeyHolder(CitizenId, Traphouse, IsOwner)
    if IsOwner then
        Config.TrapHouses[Traphouse].keyholders = {}
    end
    if #Config.TrapHouses[Traphouse].keyholders <= 6 then
        if not HasCitizenIdHasKey(CitizenId, Traphouse) then
            table.insert(Config.TrapHouses[Traphouse].keyholders, {
                citizenid = CitizenId,
                owner = IsOwner,
            })
        end
    end
end

function HasTraphouseAndOwner(CitizenId)
    local retval = nil
    for Traphouse,_ in pairs(Config.TrapHouses) do
        for k, v in pairs(Config.TrapHouses[Traphouse].keyholders) do
            if v.citizenid == CitizenId then
                if v.owner then
                    retval = Traphouse
                end
            end
        end
    end
    return retval
end

-- Framework.Commands.Add("entertraphouse", "Betreed traphouse", {}, false, function(source, args)
--     local src = source
--     local Player = Framework.Functions.GetPlayer(src)

--     TriggerClientEvent('pepe-traphouses:client:EnterTraphouse', src)
-- end)

Framework.Commands.Add("geeftrapsleutels", "Geef sleutels van het traphouse", {{name = "id", help = "Speler id"}}, true, function(source, args)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    local TargetId = tonumber(args[1])
    local TargetData = Framework.Functions.GetPlayer(TargetId)
    local IsOwner = false
    local Traphouse = HasTraphouseAndOwner(Player.PlayerData.citizenid)

    if TargetData ~= nil then
        if Traphouse ~= nil then
            if not HasCitizenIdHasKey(TargetData.PlayerData.citizenid, Traphouse) then
                if Config.TrapHouses[Traphouse] ~= nil then
                    if IsOwner then
                        Config.TrapHouses[Traphouse].keyholders = {}
                        Config.TrapHouses[Traphouse].pincode = math.random(11111, 55555) 
                    end
            
                    if Config.TrapHouses[Traphouse].keyholders == nil then
                        table.insert(Config.TrapHouses[Traphouse].keyholders, {
                            citizenid = TargetData.PlayerData.citizenid,
                            owner = IsOwner,
                        })
                        SaveTrapHouseConfig(Traphouse)
                        TriggerClientEvent('pepe-traphouses:client:SyncData', -1, Traphouse, Config.TrapHouses[Traphouse])
                    else
                        if #Config.TrapHouses[Traphouse].keyholders + 1 <= 6 then
                            if not HasCitizenIdHasKey(TargetData.PlayerData.citizenid, Traphouse) then
                                table.insert(Config.TrapHouses[Traphouse].keyholders, {
                                    citizenid = TargetData.PlayerData.citizenid,
                                    owner = IsOwner,
                                })
                                SaveTrapHouseConfig(Traphouse)
                                TriggerClientEvent('pepe-traphouses:client:SyncData', -1, Traphouse, Config.TrapHouses[Traphouse])
                                TriggerClientEvent('Framework:Notify', TargetData.PlayerData.source, 'Je hebt de sleutel gekregen')
                            end
                        else
                            TriggerClientEvent('Framework:Notify', src, 'Er zijn geen slots meer over..')
                        end
                    end
                else
                    TriggerClientEvent('Framework:Notify', src, 'Foutje opgetreden..')
                end
            else
                TriggerClientEvent('Framework:Notify', src, 'Deze persoon heeft al de sleutels..', 'error')
            end
        else
            TriggerClientEvent('Framework:Notify', src, 'Je bent niet in bezit van een Traphouse of bent niet de eigenaar..', 'error')
        end
    else
        TriggerClientEvent('Framework:Notify', src, 'Deze persoon is niet in de stad..', 'error')
    end
end)

Framework.Functions.CreateCallback('pepe-traphouses:server:TakeMoney', function(source, cb, TraphouseId)
	local src = source
    local Player = Framework.Functions.GetPlayer(src)
    if Config.TrapHouses[TraphouseId].money ~= 0 then
        Player.Functions.AddMoney('cash', Config.TrapHouses[TraphouseId].money)
        Config.TrapHouses[TraphouseId].money = 0
        SaveTrapHouseConfig(TraphouseId)
        TriggerClientEvent('pepe-traphouses:client:SyncData', -1, TraphouseId, Config.TrapHouses[TraphouseId])
    else
        TriggerClientEvent('Framework:Notify', src, 'Er zit geen geld in de kas', 'error')
    end
end)

RegisterServerEvent('pepe-traphouses:server:TakeMoney')
AddEventHandler('pepe-traphouses:server:TakeMoney', function(TraphouseId)
    Framework.Functions.BanInjection(source, 'pepe-traphouses (TakeMoney)')
end)

function SellTimeout(traphouseId, slot, itemName, amount, info)
    Citizen.CreateThread(function()
        if itemName == "markedbills" then
            SetTimeout(math.random(1000, 5000), function()
                if Config.TrapHouses[traphouseId].inventory[slot] ~= nil then
                    RemoveHouseItem(traphouseId, slot, itemName, 1)
                    Config.TrapHouses[traphouseId].money = Config.TrapHouses[traphouseId].money + math.ceil(info.worth / 100 * 80)
                    SaveTrapHouseConfig(traphouseId)
                    TriggerClientEvent('pepe-traphouses:client:SyncData', -1, traphouseId, Config.TrapHouses[traphouseId])
                end
            end)
        else
            for i = 1, amount, 1 do
                local SellData = Config.AllowedItems[itemName]
                SetTimeout(SellData.wait, function()
                    if Config.TrapHouses[traphouseId].inventory[slot] ~= nil then
                        RemoveHouseItem(traphouseId, slot, itemName, 1)
                        Config.TrapHouses[traphouseId].money = Config.TrapHouses[traphouseId].money + SellData.reward
                        SaveTrapHouseConfig(traphouseId)
                        TriggerClientEvent('pepe-traphouses:client:SyncData', -1, traphouseId, Config.TrapHouses[traphouseId])
                    end
                end)
                if amount > 1 then
                    Citizen.Wait(SellData.wait)
                end
            end
        end
    end)
end

function AddHouseItem(traphouseId, slot, itemName, amount, info, source)
    local amount = tonumber(amount)
    traphouseId = tonumber(traphouseId)
    if Config.TrapHouses[traphouseId].inventory[slot] ~= nil and Config.TrapHouses[traphouseId].inventory[slot].name == itemName then
        Config.TrapHouses[traphouseId].inventory[slot].amount = Config.TrapHouses[traphouseId].inventory[slot].amount + amount
    else
        local itemInfo = Framework.Shared.Items[itemName:lower()]
        Config.TrapHouses[traphouseId].inventory[slot] = {
            name = itemInfo["name"],
            amount = amount,
            info = info ~= nil and info or "",
            label = itemInfo["label"],
            description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
            weight = itemInfo["weight"], 
            type = itemInfo["type"], 
            unique = itemInfo["unique"], 
            useable = itemInfo["useable"], 
            image = itemInfo["image"],
            slot = slot,
        }
    end
    SellTimeout(traphouseId, slot, itemName, amount, info)
    SaveTrapHouseConfig(traphouseId)
    TriggerClientEvent('pepe-traphouses:client:SyncData', -1, traphouseId, Config.TrapHouses[traphouseId])
end

function RemoveHouseItem(traphouseId, slot, itemName, amount)
	local amount = tonumber(amount)
    traphouseId = tonumber(traphouseId)
	if Config.TrapHouses[traphouseId].inventory[slot] ~= nil and Config.TrapHouses[traphouseId].inventory[slot].name == itemName then
		if Config.TrapHouses[traphouseId].inventory[slot].amount > amount then
			Config.TrapHouses[traphouseId].inventory[slot].amount = Config.TrapHouses[traphouseId].inventory[slot].amount - amount
		else
			Config.TrapHouses[traphouseId].inventory[slot] = nil
			if next(Config.TrapHouses[traphouseId].inventory) == nil then
				Config.TrapHouses[traphouseId].inventory = {}
			end
		end
	else
		Config.TrapHouses[traphouseId].inventory[slot] = nil
		if Config.TrapHouses[traphouseId].inventory == nil then
			Config.TrapHouses[traphouseId].inventory[slot] = nil
		end
    end
    SaveTrapHouseConfig(traphouseId)
    TriggerClientEvent('pepe-traphouses:client:SyncData', -1, traphouseId, Config.TrapHouses[traphouseId])
end

function GetInventoryData(traphouse, slot)
    traphouse = tonumber(traphouse)
    if Config.TrapHouses[traphouse].inventory[slot] ~= nil then
        return Config.TrapHouses[traphouse].inventory[slot]
    else
        return nil
    end
end

function CanItemBeSaled(item)
    local retval = false
    if Config.AllowedItems[item] ~= nil then
        retval = true
    elseif item == "markedbills" then
        retval = true
    end
    return retval
end

Framework.Functions.CreateCallback('pepe-traphouses:server:RobNpc', function(source, cb, Traphouse)
	local src = source
    local Player = Framework.Functions.GetPlayer(src)
    local Chance = math.random(1, 500)
    --print(Chance)
    if Chance == 17 then
        local info = {
            label = "Traphouse Pincode: "..Config.TrapHouses[Traphouse].pincode
        }
        Player.Functions.AddItem("stickynote", 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, Framework.Shared.Items["stickynote"], "add")
    else
        local amount = math.random(3, 15)
        Player.Functions.AddMoney('cash', amount)
    end
end)

RegisterServerEvent('pepe-traphouses:server:RobNpc')
AddEventHandler('pepe-traphouses:server:RobNpc', function(Traphouse)
    Framework.Functions.BanInjection(source, 'pepe-traphouses (RobNpc)')
end)

Framework.Functions.CreateCallback('pepe-traphouses:server:GetTraphousesData', function(source, cb)
    cb(Config.TrapHouses)
end)