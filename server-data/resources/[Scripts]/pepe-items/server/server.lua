local Framework = exports["pepe-core"]:GetCoreObject()

-- Code

-- BurgerShot

Framework.Functions.CreateUseableItem("burger-bleeder", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:eat', source, 'burger-bleeder', 'hamburger')
    end
end)

Framework.Functions.CreateUseableItem("burger-moneyshot", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:eat', source, 'burger-moneyshot', 'hamburger')
    end
end)

Framework.Functions.CreateUseableItem("burger-torpedo", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:eat', source, 'burger-torpedo', 'hamburger')
    end
end)

Framework.Functions.CreateUseableItem("burger-heartstopper", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:eat', source, 'burger-heartstopper', 'hamburger')
    end
end)

Framework.Functions.CreateUseableItem("burger-softdrink", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:drink', source, 'burger-softdrink', 'burger-soft')
    end
end)

Framework.Functions.CreateUseableItem("burger-fries", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:eat', source, 'burger-fries', 'burger-fries')
    end
end)


Framework.Functions.CreateUseableItem("420-choco", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:eat', source, '420-choco', 'chocolade')
    end
end)

Framework.Functions.CreateUseableItem("burger-box", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-burgershot:client:open:box', source, item.info.boxid)
    end
end)

Framework.Functions.CreateUseableItem("pizza-box", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-pizzeria:client:open:box', source, item.info.pidid)
    end
end)


Framework.Functions.CreateUseableItem("sekspop", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:sekspop', source)
    end
end)

Framework.Functions.CreateUseableItem("boombox", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:boombox', source)
    end
end)

Framework.Functions.CreateUseableItem("dildo", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:dildo', source)
    end
end)

Framework.Functions.CreateUseableItem("burger-coffee", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:drink', source, 'burger-coffee', 'coffee')
    end
end)

Framework.Functions.CreateUseableItem("coffee", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:drink', source, 'coffee', 'coffee')
    end
end)
-- // Lockpick \\ --
Framework.Functions.CreateUseableItem("advancedlockpick", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:use:lockpick', source, true)
    end
end)

Framework.Functions.CreateUseableItem("drill", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:use:drill', source)
    end
end)

Framework.Functions.CreateUseableItem("lockpick", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:use:lockpick', source, false)
    end
end)
-- // Eten \\ --

Framework.Functions.CreateUseableItem("water", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:drink', source, 'water', 'water')
    end
end)


Framework.Functions.CreateUseableItem("mojito", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:drinkbeer', source, 'mojito', 'mojito')
    end
end)

Framework.Functions.CreateUseableItem("ecola", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:drink', source, 'ecola', 'cola')
    end
end)

Framework.Functions.CreateUseableItem("glasschampagne", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:drinkbeer', source, 'glasschampagne', 'cola')
    end
end)

Framework.Functions.CreateUseableItem("whiskey", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:drinkbeer', source, 'whiskey', 'whiskey')
    end
end)

Framework.Functions.CreateUseableItem("tequila", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:drinkbeer', source, 'tequila', 'tequila')
    end
end)

Framework.Functions.CreateUseableItem("sprunk", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:drink', source, 'sprunk', 'cola')
    end
end)

Framework.Functions.CreateUseableItem("slushy", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:drink:slushy', source)
    end
end)

Framework.Functions.CreateUseableItem("sandwich", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:eat', source, 'sandwich', 'sandwich')
    end
end)

Framework.Functions.CreateUseableItem("carapils", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:drinkbeer', source, 'beer', 'beer')
    end
end)

Framework.Functions.CreateUseableItem("pizza", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:eat', source, 'pizza', 'pizza')
    end
end)


Framework.Functions.CreateUseableItem("chocolade", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:eat', source, 'chocolade', 'chocolade')
    end
end)

Framework.Functions.CreateUseableItem("donut", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:eat', source, 'donut', 'donut')
    end
end)


Framework.Functions.CreateUseableItem("cleankit", function(source, item)
    local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        Player.Functions.RemoveItem('cleankit', 1)
        TriggerClientEvent("pepe-mechanic:client:clean:kit", source)
    end
end)

-- Drugs --


Framework.Functions.CreateUseableItem("packed-coke-brick", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-illegal:client:unpack:coke', source)
    end
end)
Framework.Functions.CreateUseableItem("burner-phone", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-illegal:client:start:burner-call', source)
    end
end)

Framework.Functions.CreateUseableItem("weed_nutrition", function(source, item)
    local Player = Framework.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-houseplants:client:feed:plants', source)
    end
end)

Framework.Functions.CreateUseableItem("oxy", function(source, item)
    local Player = Framework.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("pepe-hospital:client:use:painkillers", source)
    end
end)

Framework.Functions.CreateUseableItem("white-widow-seed", function(source, item)
    local Player = Framework.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-houseplants:client:plant', source, 'White Widow', 'White-Widow', 'white-widow-seed')
    end
end)

Framework.Functions.CreateUseableItem("weed_white-widow_seed", function(source, item)
    local Player = Framework.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-houseplants:client:plant', source, 'White Widow', 'White-Widow', 'weed_white-widow_seed')
    end
end)

Framework.Functions.CreateUseableItem("skunk-seed", function(source, item)
    local Player = Framework.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-houseplants:client:plant', source, 'Skunk', 'Skunk', 'skunk-seed')
    end
end)

Framework.Functions.CreateUseableItem("purple-haze-seed", function(source, item)
    local Player = Framework.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-houseplants:client:plant', source, 'Purple Haze', 'Purple-Haze', 'purple-haze-seed')
    end
end)

Framework.Functions.CreateUseableItem("og-kush-seed", function(source, item)
    local Player = Framework.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-houseplants:client:plant', source, 'OG Kush', 'Og-Kush', 'og-kush-seed')
    end
end)

Framework.Functions.CreateUseableItem("amnesia-seed", function(source, item)
    local Player = Framework.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-houseplants:client:plant', source, 'Amnesia', 'Amnesia', 'amnesia-seed')
    end
end)

Framework.Functions.CreateUseableItem("ak47-seed", function(source, item)
    local Player = Framework.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-houseplants:client:plant', source, 'AK47', 'AK47', 'ak47-seed')
    end
end)

-- // Other \\ --

Framework.Functions.CreateUseableItem("binoculars", function(source, item)
    local Player = Framework.Functions.GetPlayer(source)
    TriggerClientEvent("binoculars:Toggle", source)
end)

Framework.Functions.CreateUseableItem("duffel-bag", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:use:duffel-bag', source, item.info.bagid)
    end
end)





Framework.Functions.CreateUseableItem("bag", function(source, item)
    local Player = Framework.Functions.GetPlayer(source)
    TriggerClientEvent("pepe-inventory:bag:UseBag", source)
    TriggerEvent("pepe-log:server:CreateLog", "inventory", "Bags", "white", "Burger opent een tas **"..GetPlayerName(source).."** Burger ID: **"..Player.PlayerData.citizenid.. "**", false)
end)

Framework.Functions.CreateUseableItem("armor", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:use:armor', source)
    end
end)

Framework.Functions.CreateUseableItem("heavy-armor", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:use:heavy', source)
    end
end)

Framework.Functions.CreateUseableItem("repairkit", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:use:repairkit', source)
    end
end)


Framework.Functions.CreateUseableItem("jerrycan", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:use:jerrycan', source)
    end
end)

Framework.Functions.CreateUseableItem("bandage", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-hospital:client:use:bandage', source)
    end
end)

Framework.Functions.CreateUseableItem("health-pack", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-hospital:client:use:health-pack', source)
    end
end)

Framework.Functions.CreateUseableItem("painkillers", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-hospital:client:use:painkillers', source)
    end
end)

Framework.Functions.CreateUseableItem("sigaret", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:use:ciga', source)
    end
end)
Framework.Functions.CreateUseableItem("joint", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:use:joint', source)
    end
end)

Framework.Functions.CreateUseableItem("superjoint", function(source, item)
    local Player = Framework.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:use:superjoint', source)
    end
end)

Framework.Functions.CreateUseableItem("coke-bag", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:use:coke', source)
    end
end)

Framework.Functions.CreateUseableItem("lsd-strip", function(source, item)
    local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("pepe-items:client:use:lsd", source)
    end
end)

Framework.Functions.CreateUseableItem("meth-bag", function(source, item)
    local Player = Framework.Functions.GetPlayer(source)
    TriggerClientEvent("pepe-items:client:use:meth", source)
end)

Framework.Functions.CreateUseableItem("coin", function(source, item)
	local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('pepe-items:client:coinflip', source)
    end
end)

Framework.Functions.CreateUseableItem("dice", function(source, item)
    local Player = Framework.Functions.GetPlayer(source)
    local DiceItems = Player.Functions.GetItemByName("dice")
      local Amount = 2
      local Sides = 6
      if DiceItems ~= nil then
             TriggerClientEvent('pepe-items:client:dobbel', source, Amount, Sides)
      else
        TriggerClientEvent('Framework:Notify', source, "Je hebt geen dobbelstenen.", "error", 3500)
      end
end)

Framework.Commands.Add("dobbelen", "Speel met wat dobbelstenen!", {{name="aantal", help="Aantal dobbelstenen"}, {name="zijdes", help="Aantal zijdes"}}, true, function(source, args)
    local Player = Framework.Functions.GetPlayer(source)
    local DiceItems = Player.Functions.GetItemByName("dice")
    if args[1] ~= nil and args[2] ~= nil then 
      local Amount = tonumber(args[1])
      local Sides = tonumber(args[2])
      if DiceItems ~= nil then
         if (Sides > 0 and Sides <= 20) and (Amount > 0 and Amount <= 5) then 
             TriggerClientEvent('pepe-items:client:dobbel', source, Amount, Sides)
         else
             TriggerClientEvent('Framework:Notify', source, "Te veel dobbelstenen 0 (max: 5) of te veel zijden 0 (max: 20)", "error", 3500)
         end
      else
        TriggerClientEvent('Framework:Notify', source, "Je hebt geen dobbelstenen.", "error", 3500)
      end
  end
end)

Framework.Commands.Add("armoroff", "Take of your armor", {}, false, function(source, args)
    local Player = Framework.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("pepe-items:client:reset:armor", source)
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Deze commando is enkel voor Diensten vd staat.")
    end
end)

Framework.Commands.Add("zoekv", "Zoek voertuig met hond", {}, false, function(source, args)
    local Player = Framework.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("K9:SearchVehicle", source)
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Deze commando is enkel voor Diensten vd staat.")
    end
end)

Framework.Functions.CreateCallback('pepe-items:server:giveitem', function(ItemName, Amount)
    local Player = Framework.Functions.GetPlayer(source)
    Player.Functions.AddItem(ItemName, Amount)
    TriggerClientEvent('pepe-inventory:client:ItemBox', source, Framework.Shared.Items[ItemName], "add")
end)

Framework.Functions.CreateUseableItem("diving_gear", function(source, item)
    local Player = Framework.Functions.GetPlayer(source)

    TriggerClientEvent("pepe-diving:client:UseGear", source, true)
end)

Framework.Functions.CreateUseableItem("parachute", function(source, item)
    local Player = Framework.Functions.GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("pepe-items:client:UseParachute", source)
    end
end)

Framework.Commands.Add("parachuteuit", "Doe je parachute uit", {}, false, function(source, args)
    local Player = Framework.Functions.GetPlayer(source)
        TriggerClientEvent("pepe-items:client:ResetParachute", source)
end)

Framework.Commands.Add("duikpak", "Trek je duikpak uit", {}, false, function(source, args)
    local Player = Framework.Functions.GetPlayer(source)
    TriggerClientEvent("pepe-diving:client:UseGear", source, false)
end)


RegisterServerEvent("pepe-items:server:AddParachute")
AddEventHandler("pepe-items:server:AddParachute", function()
    local src = source
    local Ply = Framework.Functions.GetPlayer(src)

    Ply.Functions.AddItem("parachute", 1)
end)

RegisterServerEvent('pepe-diving:server:RemoveGear')
AddEventHandler('pepe-diving:server:RemoveGear', function()
    local src = source
    local Player = Framework.Functions.GetPlayer(src)


    Player.Functions.RemoveItem("diving_gear", 1)
    TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items["diving_gear"], "remove")
end)

RegisterServerEvent('pepe-diving:server:GiveBackGear')
AddEventHandler('pepe-diving:server:GiveBackGear', function()
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    
    Player.Functions.AddItem("diving_gear", 1)
    TriggerClientEvent('pepe-inventory:client:ItemBox', src, Framework.Shared.Items["diving_gear"], "add")
end)



-- Dieren


Framework.Functions.CreateUseableItem("pet_shepherd", function(source, item)
	local src = source
    local Player = Framework.Functions.GetPlayer(src)
	TriggerClientEvent("pepe-animals:client:ToggleCompanion", src, "a_c_shepherd")
end)

Framework.Functions.CreateUseableItem("pet_cat", function(source, item)
	local src = source
    local Player = Framework.Functions.GetPlayer(src)
	TriggerClientEvent("pepe-animals:client:ToggleCompanion", src, "a_c_cat_01")
end)

Framework.Functions.CreateUseableItem("pet_husky", function(source, item)
	local src = source
    local Player = Framework.Functions.GetPlayer(src)
	TriggerClientEvent("pepe-animals:client:ToggleCompanion", src, "a_c_husky")
end)

Framework.Functions.CreateUseableItem("pet_chicken", function(source, item)
	local src = source
    local Player = Framework.Functions.GetPlayer(src)
	TriggerClientEvent("pepe-animals:client:ToggleCompanion", src, "a_c_hen")
end)

Framework.Functions.CreateUseableItem("pet_pug", function(source, item)
	local src = source
    local Player = Framework.Functions.GetPlayer(src)
	TriggerClientEvent("pepe-animals:client:ToggleCompanion", src, "a_c_pug")
end)

Framework.Functions.CreateUseableItem("pet_rabbit", function(source, item)
	local src = source
    local Player = Framework.Functions.GetPlayer(src)
	TriggerClientEvent("pepe-animals:client:ToggleCompanion", src, "a_c_rabbit_01")
end)

Framework.Functions.CreateUseableItem("pet_poodle", function(source, item)
	local src = source
    local Player = Framework.Functions.GetPlayer(src)
	TriggerClientEvent("pepe-animals:client:ToggleCompanion", src, "a_c_poodle")
end)

Framework.Functions.CreateUseableItem("pet_westy", function(source, item)
	local src = source
    local Player = Framework.Functions.GetPlayer(src)
	TriggerClientEvent("pepe-animals:client:ToggleCompanion", src, "a_c_westy")
end)

Framework.Functions.CreateUseableItem("pet_retriever", function(source, item)
	local src = source
    local Player = Framework.Functions.GetPlayer(src)
	TriggerClientEvent("pepe-animals:client:ToggleCompanion", src, "a_c_retriever")
end)

Framework.Functions.CreateUseableItem("pet_rottweiler", function(source, item)
	local src = source
    local Player = Framework.Functions.GetPlayer(src)
	TriggerClientEvent("pepe-animals:client:ToggleCompanion", src, "a_c_rottweiler")
end)

Framework.Functions.CreateUseableItem("pet_mtlion", function(source, item)
	local src = source
    local Player = Framework.Functions.GetPlayer(src)
	TriggerClientEvent("pepe-animals:client:ToggleCompanion", src, "a_c_mtlion")
end)