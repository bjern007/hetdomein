# qb-signrobbery
 This script allows you to rob any stop sign around the map, it it's set up with bt-target.
You can easily add more props within the script.
You will have to make animations in dpemotes and add the item to you qb-core also make the item use an animation within qb-smallresources/client/consumables.lua and server/consumables.lua 
Here's an exampe of what I did in those 

--client/consumables.lua--
RegisterNetEvent("consumables:client:stopsign")
AddEventHandler("consumables:client:stopsign", function(itemName)
    TriggerEvent('animations:client:EmoteCommandStart', {"stopsign"})
end)

--server/consumables.lua--
QBCore.Functions.CreateUseableItem("stopsign", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
        TriggerClientEvent("consumables:client:stopsign", source, item.name)
end)

Here's my example of the animation 
["stopsign"] = {"amb@world_human_janitor@male@base", "base", "static", "Stop Sign", AnimationOptions =
   {
       Prop = "prop_sign_road_01a",
       PropBone = 57005,
       PropPlacement = {0.10, -1.0, 0.0, -90.0, -250.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},

Here's and example for my bt-target 
    ["StopSign"] = {
        models = {
            `prop_sign_road_01a`
        },
        options = {
            {
                type = "client",
                event = "stopsign:client:Target",
                icon = "fas fa-user-secret",
                label = "STEAL SIGN",
            },
        },
        distance = 2.0
    },
This was made by Obtaizen with the help of BerkieBb and pushkart2
