local DutyVehicles = {}
HasHandCuffs = false

Config = Config or {}

Config.Keys = {["F1"] = 288}
Config.Locale = "en"
Config.Menu = {
 [1] = {
    id = "citizen",
    displayName = "Burger",
    icon = "#citizen-action",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() then
            return true
        end
    end,
    subMenus = {"citizen:escort", 'citizen:steal', 'citizen:hostage', 'citizen:contact', 'citizen:vehicle:getout', 'citizen:vehicle:getin', 'citizen:corner:selling', 'favo:radio:one'}
 },
 [2] = {
    id = "animations",
    displayName = "Loopstijl",
    icon = "#walking",
    enableMenu = function()
       if not exports['pepe-hospital']:GetDeathStatus() then
           return true
        end
    end,
    subMenus = { "animations:brave", "animations:hurry", "animations:business", "animations:tipsy", "animations:injured","animations:tough", "animations:default", "animations:hobo", "animations:money", "animations:swagger", "animations:shady", "animations:maneater", "animations:chichi", "animations:sassy", "animations:sad", "animations:posh", "animations:alien" }
 },
 [3] = {
     id = "expressions",
     displayName = "Expressies",
     icon = "#expressions",
     enableMenu = function()
         if not exports['pepe-hospital']:GetDeathStatus() then
            return true
         end
     end,
     subMenus = { "expressions:normal", "expressions:drunk", "expressions:angry", "expressions:dumb", "expressions:electrocuted", "expressions:grumpy", "expressions:happy", "expressions:injured", "expressions:joyful", "expressions:mouthbreather", "expressions:oneeye", "expressions:shocked", "expressions:sleeping", "expressions:smug", "expressions:speculative", "expressions:stressed", "expressions:sulking", "expressions:weird", "expressions:weird2"}
 },
 [4] = {
    id = "police",
    displayName = "Politie",
    icon = "#police-action",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() and Framework.Functions.GetPlayerData().job.name == 'police' and Framework.Functions.GetPlayerData().job.onduty then
            return true
        end
    end,
    subMenus = {"police:panic", "police:search", "police:tablet", "police:impound", "police:resetdoor", "police:enkelband", "police:checkstatus"}
 },
 [5] = {
    id = "police",
    displayName = "Police Objects",
    icon = "#police-action",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() and Framework.Functions.GetPlayerData().job.name == 'police' and Framework.Functions.GetPlayerData().job.onduty then
            return true
        end
    end,
    subMenus = {"police:object:cone", "police:object:barrier", "police:object:tent", "police:object:light", "police:object:schot", "police:object:delete"}
 },
 [6] = {
    id = "police-down",
    displayName = "10-13A",
    icon = "#police-down",
    close = true,
    functiontype = "client",
    functionParameters = 'Urgent',
    functionName = "pepe-radialmenu:client:send:down",
    enableMenu = function()
        if exports['pepe-hospital']:GetDeathStatus() and Framework.Functions.GetPlayerData().job.name == 'police' and Framework.Functions.GetPlayerData().job.onduty then
            return true
        end
    end,
 },
 [7] = {
    id = "police-down",
    displayName = "10-13B",
    icon = "#police-down",
    close = true,
    functiontype = "client",
    functionParameters = 'Normal',
    functionName = "pepe-radialmenu:client:send:down",
    enableMenu = function()
        if exports['pepe-hospital']:GetDeathStatus() and Framework.Functions.GetPlayerData().job.name == 'police' and Framework.Functions.GetPlayerData().job.onduty then
            return true
        end
    end,
 },
 [8] = {
    id = "ambulance",
    displayName = "Ambulance",
    icon = "#ambulance-action",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() and Framework.Functions.GetPlayerData().job.name == 'ambulance' and Framework.Functions.GetPlayerData().job.onduty then
            return true
        end
    end,
    subMenus = {"ambulance:heal", "ambulance:revive", "police:panic", "ambulance:blood"}
 },
 [9] = {
    id = "vehicle",
    displayName = "Voertuig",
    icon = "#citizen-action-vehicle",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() then
            local Vehicle, Distance = Framework.Functions.GetClosestVehicle()
            if Vehicle ~= 0 and Distance < 2.3 then
                return true
            end
        end
    end,
    subMenus = {"vehicle:flip", "vehicle:key", "vehicle:extra", "vehicle:extra2", "vehicle:extra3", "vehicle:extra4"}
 },
 [10] = {
    id = "vehicle-doors",
    displayName = "Voertuig Deuren",
    icon = "#citizen-action-vehicle",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() then
            if IsPedSittingInAnyVehicle(PlayerPedId()) and not IsPedInAnyBoat(PlayerPedId()) and not IsPedInAnyHeli(PlayerPedId()) and not IsPedOnAnyBike(PlayerPedId()) then
                return true
            end
        end
    end,
    subMenus = {"vehicle:door:motor", "vehicle:door:left:front", "vehicle:door:right:front", "vehicle:door:trunk", "vehicle:door:right:back", "vehicle:door:left:back"}
 },
 [11] = {
    id = "police-garage",
    displayName = "Politie Garage",
    icon = "#citizen-action-garage",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() and Framework.Functions.GetPlayerData().job.name == 'police' and Framework.Functions.GetPlayerData().job.onduty then
            if exports['pepe-police']:GetGarageStatus() then
                return true
            end
        end
    end,
    subMenus = {}
 },
 [12] = {
    id = "garage",
    displayName = "Garage",
    icon = "#citizen-action-garage",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() then
            if exports['pepe-garages']:IsNearGarage() then
                return true
            end
        end
    end,
    subMenus = {"garage:putin", "garage:getout"}
 },
 [13] = {
    id = "door",
    displayName = "Deurslot",
    icon = "#global-doors",
    close = true,
    functiontype = "client",
    functionName = "pepe-doorlock:client:toggle:locks",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() then
           --if exports['pepe-doorlock']:CanOpenDoor() then
                return false
         --end
        end
  end,
 },
 [14] = {
    id = "atm",
    displayName = "ATM",
    icon = "#global-card",
    close = true,
    functiontype = "client",
    functionName = "pepe-banking:client:open:atm",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() then
            if exports['pepe-banking']:IsNearAtm() then
                return true
            end
        end
  end,
 },
 [15] = {
    id = "atm",
    displayName = "Bank",
    icon = "#global-bank",
    close = true,
    functiontype = "client",
    functionName = "pepe-banking:client:open:bank",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() then
            if exports['pepe-banking']:IsNearAnyBank() then
                return true
            end
        end
  end,
 },
 [16] = {
    id = "shop",
    displayName = "Winkel",
    icon = "#global-store",
    close = true,
    functiontype = "client",
    functionName = "pepe-stores:server:open:shop",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() then
            if exports['pepe-stores']:IsNearShop() then
                return true
            end
        end
  end,
 },
 [17] = {
    id = "appartment",
    displayName = "Naar Binnen",
    icon = "#global-appartment",
    close = true,
    functiontype = "client",
    functionParameters = false,
    functionName = "pepe-appartments:client:enter:appartment",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() then
            if exports['pepe-appartments']:IsNearHouse() then
                return true
            end
        end
  end,
 },
 [18] = {
    id = "depot",
    displayName = "Depot",
    icon = "#global-depot",
    close = true,
    functiontype = "client",
    functionParameters = false,
    functionName = "pepe-garages:client:open:depot",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() then
            if exports['pepe-garages']:IsNearDepot() then
                return true
            end
        end
  end,
 },
 [19] = {
    id = "housing",
    displayName = "Naar Binnen",
    icon = "#global-appartment",
    close = true,
    functiontype = "client",
    functionParameters = false,
    functionName = "pepe-housing:client:enter:house",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() then
            if exports['pepe-housing']:EnterNearHouse() then
                return true
            end
        end
  end,
 },
 [20] = {
    id = "housing-options",
    displayName = "Huis Opties",
    icon = "#citizen-action-garage",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() then
            if exports['pepe-housing']:HasEnterdHouse() then
                return true
            end
        end
    end,
    subMenus = {"house:setstash", "house:setlogout", "house:setclothes", "house:givekey", "house:decorate" }
 },
 [21] = {
    id = "judge-actions",
    displayName = "Rechter",
    icon = "#judge-actions",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() and Framework.Functions.GetPlayerData().job.name == 'judge' then
            return true
        end
    end,
    subMenus = {"judge:tablet", "judge:job", "police:tablet"}
 },
 [22] = {
    id = "ambulance-garage",
    displayName = "Ambulance Garage",
    icon = "#citizen-action-garage",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() and Framework.Functions.GetPlayerData().job.name == 'ambulance' and Framework.Functions.GetPlayerData().job.onduty then
            if exports['pepe-hospital']:NearGarage() then
                return true
            end
        end
    end,
    subMenus = {"ambulance:garage:sprinter", "ambulance:garage:touran", "ambulance:garage:heli", "vehicle:delete"}
 },
 [23] = {
    id = "scrapyard",
    displayName = "Scrap Voertuig",
    icon = "#police-action-vehicle-spawn",
    close = true,
    functiontype = "client",
    functionName = "pepe-materials:client:scrap:vehicle",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() then
          if exports['pepe-materials']:IsNearScrapYard() then
            return true
          end
        end
  end,
 },
 [24] = {
    id = "trash",
    displayName = "Prullenbak",
    icon = "#global-trash",
    close = true,
    functiontype = "client",
    functionName = "pepe-materials:client:search:trash",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() then
          if exports['pepe-materials']:GetBinStatus() then
            return true
          end
        end
  end,
 },
  [25] = {
    id = "cityhall",
    displayName = "Gemeentehuis",
    icon = "#global-cityhall",
    close = true,
    functiontype = "client",
    functionName = "pepe-cityhall:client:open:nui",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() then
            if exports['pepe-cityhall']:CanOpenCityHall() then
                return true
            end
        end
  end,
 },
 [26] = {
    id = "dealer",
    displayName = "Dealer",
    icon = "#global-dealer",
    close = true,
    functiontype = "client",
    functionName = "pepe-dealers:client:open:dealer",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() then
            if exports['pepe-dealers']:CanOpenDealerShop() then
                return true
            end
        end
  end,
 },
 [27] = {
    id = "traphouse",
    displayName = "Traphouse",
    icon = "#global-appartment",
    close = true,
    functiontype = "client",
    functionName = "pepe-traphouse:client:enter",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() then
            if exports['pepe-traphouse']:CanPlayerEnterTraphouse() then
                return true
            end
        end
  end,
 },
 [28] = {
    id = "tow-menu",
    displayName = "Berging",
    icon = "#citizen-action-garage",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() and Framework.Functions.GetPlayerData().job.name == 'tow' then
            return true
        end
    end,
    subMenus = {"tow:hook", "tow:npc"}
--  },
--  [29] = {
--     id = "police-impound",
--     displayName = "Police Impound",
--     icon = "#citizen-action-garage",
--     enableMenu = function()
--         if not exports['pepe-hospital']:GetDeathStatus() then
--             if exports['pepe-police']:GetImpoundStatus() then
--                 return true
--             end
--         end
--     end,
--     subMenus = {}
 },
 [29] = {
    id = "taxi",
    displayName = "Taxi",
    icon = "#taxi-action",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() and Framework.Functions.GetPlayerData().job.name == 'taxi' and Framework.Functions.GetPlayerData().job.onduty then
            return true
        end
    end,
    subMenus = {"taxi:togglemeter", "taxi:start", "taxi:npcmission"}
 },
 [30] = {
    id = "cuff",
    displayName = "Boeien",
    icon = "#citizen-action-cuff",
    close = true,
    functiontype = "client",
    functionName = "pepe-police:client:cuff:closest",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() and HasHandCuffs then
          return true
        end
  end,
 },
--  [31] = {
--     id = "recycle",
--     displayName = "Recycle",
--     icon = "#global-doors",
--     close = true,
--     functiontype = "client",
--     functionName = "pepe-recycle:openrecycle",
--     enableMenu = function()
--         if not exports['pepe-hospital']:GetDeathStatus() then
--             if exports['pepe-recycle']:RecycleStatus() then
--                 return true
--             end
--         end
--   end,
--  },
 [31] = {
    id = "mechanic",
    displayName = "Mechanic",
    icon = "#citizen-action-vehicle",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() and Framework.Functions.GetPlayerData().job.name == 'mechanic' and Framework.Functions.GetPlayerData().job.onduty then
            return true
        end
    end,
    
    subMenus = {"mechanic:repair", "tow:hook"}
 },
 [32] = {
    id = "police",
    displayName = "Radio",
    icon = "#police-radio-channel",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() and Framework.Functions.GetPlayerData().job.name == 'police' and Framework.Functions.GetPlayerData().job.onduty then
            return true
        end
    end,
    subMenus = {"police:radio:one", "police:radio:two", "police:radio:three", "police:radio:four", "police:radio:five"}
 },
 [33] = {
    id = "boat",
    displayName = "Depot",
    icon = "#global-boat",
    close = true,
    functiontype = "client",
    functionParameters = false,
    functionName = "pepe-garages:client:open:depot",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() then
            if exports['pepe-garages']:IsNearBoatDepot() then
                return true
            end
        end
  end,
 },
 [34] = {
    id = "blips",
    displayName = "Blips",
    icon = "#global-blips",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() then
            return true
        end
    end,
    subMenus = {"blips:tattooshop", "blips:barbershop", "blips:gas", "blips:clothing", "blips:deleteblips"}
 },
[35] = {
    id = "police-cameraz",
    displayName = "Camera",
    icon = "#police-cameras",
    enableMenu = function()
        if Framework.Functions.GetPlayerData().job.name == 'police' and Framework.Functions.GetPlayerData().job.onduty then
            return true
        end
    end,
    subMenus = {"camera:een", "camera:twee", "camera:drie", "camera:vier", "camera:vijf", "camera:zes", "camera:zeven", "camera:acht", "camera:negen", "camera:tien", "camera:11", "camera:12", "camera:13", "camera:14", "camera:15","camera:16", "camera:17", "camera:18", "camera:19", "camera:20", "camera:21", "camera:22", "camera:23", "camera:24", "camera:25", "camera:26", "camera:27", "camera:28", "camera:29", "camera:30", "camera:31", "camera:32", "camera:33", "camera:34", "camera:70", "camera:71", "camera:72", "camera:80", "camera:81", "camera:40", "camera:41", "camera:42", "camera:43", "camera:44", "camera:50", "camera:51", "camera:52", "camera:53", "camera:54", "camera:55", "camera:56", "camera:57", "camera:58", "camera:59", "camera:60", "camera:61", "camera:62"}
 },
 [36] = {
     id = "global-makelaar",
     displayName = "Makelaar",
     icon = "#global-makelaar",
     enableMenu = function()
         if Framework.Functions.GetPlayerData().job.name == 'realestate' then
             return true
         end
     end,
     subMenus = {"makelaar:blips", "makelaar:duty"}
  },
  [37] = {
      id = "global-makelaar",
      displayName = "Advocaat",
      icon = "#global-makelaar",
      enableMenu = function()
          if Framework.Functions.GetPlayerData().job.name == 'lawyer' then
              return true
          end
      end,
      subMenus = {"lawyer:duty"}
   },
  [38] = {
    id = "duikboot",
    displayName = "Duikboot",
    icon = "#citizen-put-in-veh",
    close = true,
    functiontype = "client",
    functionParameters = false,
    functionName = "pepe-duikboot:client:enter",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() then
            if exports['pepe-duikboot']:Enterduikboot() then
                return true
            end
        end
  end,
 },  
  [39] = {
    id = "duikboot",
    displayName = "Duikboot opbergen",
    icon = "#citizen-put-in-veh",
    close = true,
    functiontype = "client",
    functionParameters = false,
    functionName = "pepe-duikboot:client:store",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() then
            if exports['pepe-duikboot']:Storeduikboot() then
                return true
            end
        end
  end,
 }, 
 [40] = {
    id = "pizzascooter",
    displayName = "Scooter",
    icon = "#citizen-put-in-veh",
    close = true,
    functiontype = "client",
    functionParameters = false,
    functionName = "pepe-pizzeria:client:enter",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() and Framework.Functions.GetPlayerData().job.name == 'pizza' then
            if exports['pepe-pizzeria']:Pizzascooter() then
                return true
            end
        end
  end,
 },  
  [41] = {
    id = "pizzascooter",
    displayName = "Scooter opbergen",
    icon = "#citizen-put-in-veh",
    close = true,
    functiontype = "client",
    functionParameters = false,
    functionName = "pepe-pizzeria:client:store",
    enableMenu = function()
        if not exports['pepe-hospital']:GetDeathStatus() and Framework.Functions.GetPlayerData().job.name == 'pizza' then
            if exports['pepe-pizzeria']:StorePizzascooter() then
                return true
            end
        end
  end,
 },   
 [42] = {
    id = "inchecken",
    displayName = "Inchecken",
    icon = "#citizen-action-garage",
    close = true,
    functiontype = "client",
    functionParameters = false,
    functionName = "pepe-hospital:client:checking:radial",
    enableMenu = function()
        -- if exports['pepe-hospital']:GetDeathStatus() then
            if exports['pepe-hospital']:RangeCheck() then
                return true
            end
        -- end
    end,
 },
}

Config.SubMenus = {
    ["garbagejob:deposit"] = {
        title = "Voertuig Inleveren",
        icon = "makelaar-blips",
        close = true,
        functiontype = "client",
        functionName = "pepe-garbagejob:client:storewaggie",
    },
    ["garbagejob:withdraw"] = {
        title = "Voertuig Pakken",
        icon = "makelaar-blips",
        close = true,
        functiontype = "client",
        functionName = "pepe-garbagejob:client:pakwaggie",
        -- functionParameters = true,
    },
    ["makelaar:blips"] = {
        title = "Blips",
        icon = "makelaar-blips",
        close = true,
        functiontype = "client",
        functionName = "ToggleHouseBlips",
        -- functionParameters = true,
    },
    ["makelaar:duty"] = {
        title = "Dienstklokker",
        icon = "makelaar-duty",
        close = true,
        functiontype = "client",
        functionName = "pepe-housing:client:duty:checker",
        -- functionParameters = true,
    },
    ["lawyer:duty"] = {
        title = "Dienstklokker",
        icon = "makelaar-duty",
        close = true,
        functiontype = "client",
        functionName = "pepe-housing:client:duty:checker",
        -- functionParameters = true,
    },
    ["camera:een"] = {
        title = "Camera 1",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
        functionParameters = 1,
    },
    ["camera:twee"] = {
        title = "Camera 2",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",

        functionParameters = 2,
    },
    ["camera:drie"] = {
        title = "Camera 3",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",

        functionParameters = 3,
    },
    ["camera:vier"] = {
        title = "Camera 4",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",

        functionParameters = 4,
    },
    ["camera:vijf"] = {
        title = "Camera 5",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 5,
    },
    ["camera:zes"] = {
        title = "Camera 6",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 6,
    },
    
    ["camera:zeven"] = {
        title = "Camera 7",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 7,
    },
    
    ["camera:acht"] = {
        title = "Camera 8",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 8,
    },
    
    ["camera:negen"] = {
        title = "Camera 9",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 9,
    },
    
    ["camera:tien"] = {
        title = "Camera 10",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 10,
    },
    
    ["camera:11"] = {
        title = "Camera 11",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 11,
    },
    
    ["camera:12"] = {
        title = "Camera 12",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 12,
    },
    
    ["camera:13"] = {
        title = "Camera 13",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 13,
    },
    
    ["camera:14"] = {
        title = "Camera 14",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 14,
    },
    
    ["camera:15"] = {
        title = "Camera 15",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 15,
    },
    
    ["camera:16"] = {
        title = "Camera 16",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 16,
    },
    ["camera:17"] = {
        title = "Camera 17",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 17,
    },
    ["camera:18"] = {
        title = "Camera 18",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 18,
    },
    ["camera:19"] = {
        title = "Camera 19",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 19,
    },
    
    ["camera:20"] = {
        title = "Camera 20",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 20,
    },
    
    ["camera:21"] = {
        title = "Camera 21",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 21,
    },
    
    ["camera:22"] = {
        title = "Camera 22",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 22,
    },
    
    ["camera:23"] = {
        title = "Camera 23",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 23,
    },
    
    ["camera:24"] = {
        title = "Camera 24",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 24,
    },
    
    ["camera:25"] = {
        title = "Camera 25",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 25,
    },
    
    ["camera:26"] = {
        title = "Camera 26",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 26,
    },
    
    ["camera:27"] = {
        title = "Camera 27",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 27,
    },
    
    ["camera:28"] = {
        title = "Camera 28",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 28,
    },
    
    ["camera:29"] = {
        title = "Camera 29",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 29,
    },
    
    ["camera:30"] = {
        title = "Camera 30",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 30,
    },
    ["camera:31"] = {
        title = "Camera 31",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 31,
    },
    ["camera:32"] = {
        title = "Camera 32",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 32,
    },
    ["camera:33"] = {
        title = "Camera 33",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 33,
    },
    ["camera:34"] = {
        title = "Camera 34",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 34,
    },
    ["camera:70"] = {
        title = "Juwelier 70",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 70,
    },
    ["camera:71"] = {
        title = "Juwelier 71",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 71,
    },
    ["camera:72"] = {
        title = "Juwelier 72",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 72,
    },
    ["camera:80"] = {
        title = "Gevangenis 80",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 80,
    },
    ["camera:81"] = {
        title = "Gevangenis 81",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 81,
    },
    ["camera:40"] = {
        title = "Pacific 40",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 40,
    },
    ["camera:41"] = {
        title = "Pacific 41",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 41,
    },
    ["camera:42"] = {
        title = "Pacific 42",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 42,
    },
    ["camera:43"] = {
        title = "Pacific 43",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 43,
    },
    ["camera:44"] = {
        title = "Pacific 44",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 44,
    },
    ["camera:50"] = {
        title = "Fleeca BP 1",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 50,
    },
    ["camera:51"] = {
        title = "Fleeca BP 2",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 51,
    },
    ["camera:52"] = {
        title = "Fleeca Hawick 1",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 52,
    },
    ["camera:53"] = {
        title = "Fleeca Hawick 2",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 53,
    },
    ["camera:54"] = {
        title = "Fleeca Motel 1",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 54,
    },
    ["camera:55"] = {
        title = "Fleeca Motel 2",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 55,
    },
    ["camera:56"] = {
        title = "Fleeca Del Perro 1",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 56,
    },
    ["camera:57"] = {
        title = "Fleeca Del Perro 2",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 57,
    },
    ["camera:58"] = {
        title = "Fleeca Great ocean 1",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 58,
    },
    ["camera:59"] = {
        title = "Fleeca Great ocean 2",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 59,
    },
    ["camera:60"] = {
        title = "Paleto 1",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 60,
    },
    ["camera:61"] = {
        title = "Paleto 2",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 61,
    },
    ["camera:62"] = {
        title = "Paleto 3",
        icon = "police-camera",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CameraCommand",
   
        functionParameters = 62,
    },
    --blips
    ["blips:tattooshop"] = {
        title = "Tattooshop",
        icon = "global-tattoo",
        close = true,
        functiontype = "client",
        functionName = "pepe-radialmenu:client:tattooshop",
    },

    ["blips:barbershop"] = {
        title = "Kapper",
        icon = "#global-kapper",
        close = true,
        functiontype = "client",
        functionName = "pepe-radialmenu:client:barbershop",
    },
    ["blips:garage"] = {
        title = "Garage",
        icon = "global-garage",
        close = true,
        functiontype = "client",
        functionName = "pepe-radialmenu:client:garage",
    },
    ["blips:gas"] = {
        title = "Benzinestation",
        icon = "global-gas",
        close = true,
        functiontype = "client",
        functionName = "pepe-radialmenu:client:benzine",
    },
    ["blips:clothing"] = {
        title = "Klerenwinkel",
        icon = "global-kleren",
        close = true,
        functiontype = "client",
        functionName = "pepe-radialmenu:client:clothing",
    },
    
    ['favo:radio:one'] = {
        title = "Eig. Frequentie",
        icon = "#player-radio-channel",
        close = true,
        functiontype = "client",
        functionName = "pepe-radialmenu:client:enter:playerradio"
       },
    ['police:radio:one'] = {
        title = "OC-1 #1",
        icon = "#police-radio",
        close = true,
        functionParameters = 1,
        functiontype = "client",
        functionName = "pepe-radialmenu:client:enter:radio"
       },
       ['police:radio:two'] = {
        title = "OC-2 #2",
        icon = "#police-radio",
        close = true,
        functionParameters = 2,
        functiontype = "client",
        functionName = "pepe-radialmenu:client:enter:radio"
       },
       ['police:radio:three'] = {
        title = "MK-01 #3",
        icon = "#police-radio",
        close = true,
        functionParameters = 3,
        functiontype = "client",
        functionName = "pepe-radialmenu:client:enter:radio"
       },
       ['police:radio:four'] = {
        title = "MK-02 #4",
        icon = "#police-radio",
        close = true,
        functionParameters = 4,
        functiontype = "client",
        functionName = "pepe-radialmenu:client:enter:radio"
       },
       ['police:radio:five'] = {
        title = "Calamiteiten#5",
        icon = "#police-radio",
        close = true,
        functionParameters = 5,
        functiontype = "client",
        functionName = "pepe-radialmenu:client:enter:radio"
       },
       ['police:checkstatus'] = {
        title = "Check",
        icon = "#police-action-status",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:CheckStatus"
       },
    ["taxi:togglemeter"] = {
        title = "Show/Hide Meter",
        icon = "#taxi-meter",
        close = true,
        functiontype = "client",
        functionName = "pepe-taxi:client:toggleMeter",
    },
    ["taxi:start"] = {
        title = "Start/Stop Meter",
        icon = "#taxi-start",
        close = true,
        functiontype = "client",
        functionName = "pepe-taxi:client:enableMeter",
    },
    ["taxi:npcmission"] = {
        title = "Toggle NPC",
        icon = "#taxi-npc",
        close = true,
        functiontype = "client",
        functionName = "pepe-taxi:client:DoTaxiNpc",
    },
    ['police:panic'] = {
     title = "Noodknop",
     icon = "#police-action-panic",
     close = true,
     functiontype = "client",
     functionName = "pepe-radialmenu:client:send:panic:button"
    },
    ['police:tablet'] = {
     title = "MEOS Tablet",
     icon = "#police-action-tablet",
     close = true,
     functiontype = "client",
     functionName = "pepe-police:client:show:tablet"
    },
    ['police:impound'] = {
     title = "Zet Depot",
     icon = "#police-action-vehicle",
     close = true,
     functiontype = "client",
     functionName = "pepe-police:client:impound:closest"
    },
    ['police:impoundhard'] = {
        title = "Beslag voertuig",
        icon = "#police-action-vehicle",
        close = true,
        functiontype = "client",
        functionName = "pepe-police:client:impound:hard:closest"
       },
    ['police:search'] = {
     title = "Fouilleren",
     icon = "#police-action-search",
     close = true,
     functiontype = "client",
     functionName = "pepe-police:client:search:closest"
    },
    ['police:resetdoor'] = {
     title = "Reset Deur",
     icon = "#global-appartment",
     close = true,
     functiontype = "client",
     functionName = "pepe-housing:client:reset:house:door"
    },
    ['police:enkelband'] = {
     title = "Enkelband",
     icon = "#police-action-enkelband",
     close = true,
     functiontype = "client",
     functionName = "pepe-police:client:enkelband:closest"
    },

    -- POLICE VEHICLES START -- 

    ['police:vehicle:touran'] = {
        title = "Volkswagen Touran",
        icon = "#police-action-vehicle-spawn",
        close = true,
        functionParameters = 'ptouran',
        functiontype = "client",
        functionName = "pepe-police:client:spawn:vehicle"
        },
    ['police:vehicle:touran11'] = {
        title = "Volkswagen Touran",
        icon = "#police-action-vehicle-spawn",
        close = true,
        functionParameters = 'ptouran11',
        functiontype = "client",
        functionName = "pepe-police:client:spawn:vehicle"
        }, 
    ['police:vehicle:klasse'] = {
        title = "Mercedes B-Klasse",
        icon = "#police-action-vehicle-spawn",
        close = true,
        functionParameters = 'pbklasse',
        functiontype = "client",
        functionName = "pepe-police:client:spawn:vehicle"
        },
    ['police:vehicle:amarok'] = {
        title = "Volkswagen Amarok",
        icon = "#police-action-vehicle-spawn-bus",
        close = true,
        functionParameters = 'pamarok',
        functiontype = "client",
        functionName = "pepe-police:client:spawn:vehicle"
        },
    ['police:vehicle:pvito'] = {
        title = "Mercedes Vito",
        icon = "#police-action-vehicle-spawn",
        close = true,
        functionParameters = 'pvito',
        functiontype = "client",
        functionName = "pepe-police:client:spawn:vehicle"
        },
    ['police:vehicle:dsivito'] = {
        title = "Vito Unmarked",
        icon = "#police-action-vehicle-spawn",
        close = true,
        functionParameters = 'dsivito',
        functiontype = "client",
        functionName = "pepe-police:client:spawn:vehicle"
        },
    ['police:vehicle:fiets'] = {
        title = "Fiets",
        icon = "#police-action-vehicle-spawn",
        close = true,
        functionParameters = 'pfiets',
        functiontype = "client",
        functionName = "pepe-police:client:spawn:vehicle"
        },
    ['police:vehicle:pbal'] = {
        title = "Unmarked Baller",
        icon = "#police-action-vehicle-spawn",
        close = true,
        functionParameters = 'pbal',
        functiontype = "client",
        functionName = "pepe-police:client:spawn:vehicle"
        },
    ['police:vehicle:audi'] = {
        title = "Audi A6",
        icon = "#police-action-vehicle-spawn",
        close = true,
        functionParameters = 'paudi',
        functiontype = "client",
        functionName = "pepe-police:client:spawn:vehicle"
        },
    ['police:vehicle:velar'] = {
        title = "Oracle Unmarked",
        icon = "#police-action-vehicle-spawn",
        close = true,
        functionParameters = 'poracle',
        functiontype = "client",
        functionName = "pepe-police:client:spawn:vehicle"
        },
    ['police:vehicle:pyamahamotor'] = {
        title = "Yamaha Motor",
        icon = "#police-action-vehicle-spawn",
        close = true,
        functionParameters = 'pyamahamotor',
        functiontype = "client",
        functionName = "pepe-police:client:spawn:vehicle"
        },
    ['police:vehicle:dsimerc'] = {
        title = "Mercedes (DSI)",
        icon = "#police-action-vehicle-spawn",
        close = true,
        functionParameters = 'dsimerc',
        functiontype = "client",
        functionName = "pepe-police:client:spawn:vehicle"
        },
    ['police:vehicle:prs6'] = {
        title = "Audi RS6",
        icon = "#police-action-vehicle-spawn",
        close = true,
        functionParameters = 'prs6',
        functiontype = "client",
        functionName = "pepe-police:client:spawn:vehicle"
        },
    ['police:vehicle:gevang'] = {
        title = "Transport",
        icon = "#police-action-vehicle-spawn",
        close = true,
        functionParameters = 'pasprinter',
        functiontype = "client",
        functionName = "pepe-police:client:spawn:vehicle"
        },
    ['police:vehicle:pschafter'] = {
        title = "Unmarked Shafter",
        icon = "#police-action-vehicle-spawn",
        close = true,
        functionParameters = 'pschafter',
        functiontype = "client",
        functionName = "pepe-police:client:spawn:vehicle"
        },
    ['police:vehicle:pmas'] = {
        title = "Unmarked Maserati",
        icon = "#police-action-vehicle-spawn",
        close = true,
        functionParameters = 'pmas',
        functiontype = "client",
        functionName = "pepe-police:client:spawn:vehicle"
        },
    ['police:vehicle:dsiq5'] = {
        title = "Unmarked DSIQ 5",
        icon = "#police-action-vehicle-spawn",
        close = true,
        functionParameters = 'dsiq5',
        functiontype = "client",
        functionName = "pepe-police:client:spawn:vehicle"
        },
    ['police:vehicle:pfosprinter'] = {
        title = "FO Sprinter",
        icon = "#police-action-vehicle-spawn",
        close = true,
        functionParameters = 'pfosprinter',
        functiontype = "client",
        functionName = "pepe-police:client:spawn:vehicle"
        },
    ['police:vehicle:heli'] = {
        title = "Zulu",
        icon = "#police-action-vehicle-spawn-heli",
        close = true,
        functionParameters = 'pzulu',
        functiontype = "client",
        functionName = "pepe-police:client:spawn:vehicle"
        },
    ['police:vehicle:motor'] = {
        title = "BMW Motor",
        icon = "#police-action-vehicle-spawn-motor",
        close = true,
        functionParameters = 'pbmwmotor2',
        functiontype = "client",
        functionName = "pepe-police:client:spawn:vehicle"
        },
        
    -- POLICE VEHICLES END -- 

    ['police:object:cone'] = {
     title = "Pion",
     icon = "#global-box",
     close = true,
     functionParameters = 'cone',
     functiontype = "client",
     functionName = "pepe-police:client:spawn:object"
    },
    ['police:object:barrier'] = {
     title = "Barrier",
     icon = "#global-box",
     close = true,
     functionParameters = 'barrier',
     functiontype = "client",
     functionName = "pepe-police:client:spawn:object"
    },
    ['police:object:schot'] = {
     title = "Hek",
     icon = "#global-box",
     close = true,
     functionParameters = 'schot',
     functiontype = "client",
     functionName = "pepe-police:client:spawn:object"
    },
    ['police:object:tent'] = {
     title = "Tent",
     icon = "#global-tent",
     close = true,
     functionParameters = 'tent',
     functiontype = "client",
     functionName = "pepe-police:client:spawn:object"
    },
    ['police:object:light'] = {
     title = "Lampen",
     icon = "#global-box",
     close = true,
     functionParameters = 'light',
     functiontype = "client",
     functionName = "pepe-police:client:spawn:object"
    },
    ['police:object:delete'] = {
     title = "Verwijder Object",
     icon = "#global-delete",
     close = false,
     functiontype = "client",
     functionName = "pepe-police:client:delete:object"
    },
    ['ambulance:heal'] = {
      title = "Helen",
      icon = "#ambulance-action-heal",
      close = true,
      functiontype = "client",
      functionName = "pepe-hospital:client:heal:closest"
    },
    ['ambulance:revive'] = {
      title = "Revive",
      icon = "#ambulance-action-heal",
      close = true,
      functiontype = "client",
      functionName = "pepe-hospital:client:revive:closest"
    },
    ['ambulance:blood'] = {
      title = "Take Bloodsample",
      icon = "#ambulance-action-blood",
      close = true,
      functiontype = "client",
      functionName = "pepe-hospital:client:take:blood:closest"
    },
    ['ambulance:garage:heli'] = {
      title = "Ambulance Heli",
      icon = "#police-action-vehicle-spawn",
      close = true,
      functionParameters = 'alifeliner',
      functiontype = "client",
      functionName = "pepe-hospital:client:spawn:vehicle"
    },
    ['ambulance:garage:touran'] = {
     title = "Mercedes Klasse B",
     icon = "#police-action-vehicle-spawn",
     close = true,
     functionParameters = 'aeklasse',
     functiontype = "client",
     functionName = "pepe-hospital:client:spawn:vehicle"
    },
    ['ambulance:garage:sprinter'] = {
     title = "Ambulance Sprinter",
     icon = "#police-action-vehicle-spawn",
     close = true,
     functionParameters = 'asprinter',
     functiontype = "client",
     functionName = "pepe-hospital:client:spawn:vehicle"
    },
    ['vehicle:delete'] = {
     title = "Delete Vehicle",
     icon = "#police-action-vehicle-delete",
     close = true,
     functiontype = "client",
     functionName = "Framework:Command:DeleteVehicle"
    },
    ['judge:tablet'] = {
     title = "Rechter Tablet",
     icon = "#police-action-tablet",
     close = true,
     functiontype = "client",
     functionName = "pepe-judge:client:toggle"
    },
    ['judge:job'] = {
     title = "Huur Advocaat",
     icon = "#judge-actions",
     close = true,
     functiontype = "client",
     functionName = "pepe-judge:client:lawyer:add:closest"
    },
    ['citizen:contact'] = {
     title = "Deel Contact",
     icon = "#citizen-contact",
     close = true,
     functiontype = "client",
     functionName = "pepe-phone:client:GiveContactDetails"
    },
    ['citizen:escort'] = {
     title = "Escort",
     icon = "#citizen-action-escort",
     close = true,
     functiontype = "client",
     functionName = "pepe-police:client:escort:closest"
    },
    ['citizen:steal'] = {
     title = "Overvallen",
     icon = "#citizen-action-steal",
     close = true,
     functiontype = "client",
     functionName = "pepe-police:client:steal:closest"
    },
    ['citizen:hostage'] = {
     title = "Gijzelaar",
     icon = "#citizen-action-hostage",
     close = true,
     functiontype = "client",
     functionName = "A5:Client:TakeHostage"
    },
    ['citizen:vehicle:getout'] = {
     title = "Uit Voertuig",
     icon = "#citizen-put-out-veh",
     close = true,
     functiontype = "client",
     functionName = "pepe-police:client:SetPlayerOutVehicle"
    },
    ['citizen:vehicle:getin'] = {
     title = "In Voertuig",
     icon = "#citizen-put-in-veh",
     close = true,
     functiontype = "client",
     functionName = "pepe-police:client:PutPlayerInVehicle"
    },
    ['vehicle:flip'] = {
     title = "Flip Voertuig",
     icon = "#citizen-action-vehicle",
     close = true,
     functiontype = "client",
     functionName = "pepe-radialmenu:client:flip:vehicle"
    },
    ['vehicle:key'] = {
     title = "Geef Sleutels",
     icon = "#citizen-action-vehicle-key",
     close = true,
     functiontype = "client",
     functionName = "pepe-vehiclekeys:client:give:key"
    },

    ['vehicle:door:left:front'] = {
     title = "Links Voor",
     icon = "#global-arrow-left",
     close = true,
     functionParameters = 0,
     functiontype = "client",
     functionName = "pepe-radialmenu:client:open:door"
    },
    ['vehicle:door:motor'] = {
     title = "Motorkap",
     icon = "#global-arrow-up",
     close = true,
     functionParameters = 4,
     functiontype = "client",
     functionName = "pepe-radialmenu:client:open:door"
    },
    ['vehicle:door:right:front'] = {
     title = "Rechts Voor",
     icon = "#global-arrow-right",
     close = true,
     functionParameters = 1,
     functiontype = "client",
     functionName = "pepe-radialmenu:client:open:door"
    },
    ['vehicle:door:right:back'] = {
     title = "Rechts Achter",
     icon = "#global-arrow-right",
     close = true,
     functionParameters = 3,
     functiontype = "client",
     functionName = "pepe-radialmenu:client:open:door"
    },
    ['vehicle:door:trunk'] = {
     title = "Kofferbak",
     icon = "#global-arrow-down",
     close = true,
     functionParameters = 5,
     functiontype = "client",
     functionName = "pepe-radialmenu:client:open:door"
    },
    ['vehicle:door:left:back'] = {
     title = "Links Achter",
     icon = "#global-arrow-left",
     close = true,
     functionParameters = 2,
     functiontype = "client",
     functionName = "pepe-radialmenu:client:open:door"
    },
    ["mechanic:repair"] = {
        title = "Repareer",
        icon = "#citizen-action-vehicle",
        close = true,
        functiontype = "client",
        functionName = "pepe-repair:client:triggerMenu",
    },
    ['tow:hook'] = {
     title = "Sleep Voertuig",
     icon = "#citizen-action-vehicle",
     close = true,
     functiontype = "client",
     functionName = "pepe-tow:client:hook:car"
    },
    -- ['tow:npc'] = {
    --  title = "Toggle NPC",
    --  icon = "#citizen-action",
    --  close = true,
    --  functiontype = "client",
    --  functionName = "pepe-tow:client:toggle:npc"
    -- },
    ['citizen:corner:selling'] = {
        title = "Cornersell",
        icon = "#citizen-action-cornerselling",
        close = true,
        functiontype = "client",
        functionName = "pepe-illegal:client:toggle:corner:selling"
       },
    ['garage:putin'] = {
     title = "In Garage",
     icon = "#citizen-put-in-veh",
     close = true,
     functiontype = "client",
     functionName = "pepe-garages:client:check:owner"
    },
    ['garage:getout'] = {
     title = "Uit Garage",
     icon = "#citizen-put-out-veh",
     close = true,
     functiontype = "client",
     functionName = "pepe-garages:client:set:vehicle:out:garage"
    }, 
    ['house:setstash'] = {
     title = "Zet Stash",
     icon = "#citizen-put-out-veh",
     close = true,
     functionParameters = 'stash',
     functiontype = "client",
     functionName = "pepe-housing:client:set:location"
    },
    -- ['house:setlogout'] = {
    --  title = "Zet Logout",
    --  icon = "#citizen-put-out-veh",
    --  close = true,
    --  functionParameters = 'logout',
    --  functiontype = "client",
    --  functionName = "pepe-housing:client:set:location"
    -- },
    ['house:setclothes'] = {
     title = "Zet Klerenkast",
     icon = "#citizen-put-out-veh",
     close = true,
     functionParameters = 'clothes',
     functiontype = "client",
     functionName = "pepe-housing:client:set:location"
    },
    ['house:givekey'] = {
     title = "Geef Sleutels",
     icon = "#citizen-action-vehicle-key",
     close = true,
     functiontype = "client",
     functionName = "pepe-housing:client:give:keys"
    },
    ['house:decorate'] = {
     title = "Decoreren",
     icon = "#global-box",
     close = true,
     functiontype = "client",
     functionName = "pepe-housing:client:decorate"
    },
    -- // Anims and Expression \\ --
    ['animations:brave'] = {
        title = "Brave",
        icon = "#animation-brave",
        close = true,
        functionName = "AnimSet:Brave",
        functiontype = "client",
    },
    ['animations:hurry'] = {
        title = "Hurry",
        icon = "#animation-hurry",
        close = true,
        functionName = "AnimSet:Hurry",
        functiontype = "client",
    },
    ['animations:business'] = {
        title = "Business",
        icon = "#animation-business",
        close = true,
        functionName = "AnimSet:Business",
        functiontype = "client",
    },
    ['animations:tipsy'] = {
        title = "Tipsy",
        icon = "#animation-tipsy",
        close = true,
        functionName = "AnimSet:Tipsy",
        functiontype = "client",
    },
    ['animations:injured'] = {
        title = "Injured",
        icon = "#animation-injured",
        close = true,
        functionName = "AnimSet:Injured",
        functiontype = "client",
    },
    ['animations:tough'] = {
        title = "Tough",
        icon = "#animation-tough",
        close = true,
        functionName = "AnimSet:ToughGuy",
        functiontype = "client",
    },
    ['animations:sassy'] = {
        title = "Sassy",
        icon = "#animation-sassy",
        close = true,
        functionName = "AnimSet:Sassy",
        functiontype = "client",
    },
    ['animations:sad'] = {
        title = "Sad",
        icon = "#animation-sad",
        close = true,
        functionName = "AnimSet:Sad",
        functiontype = "client",
    },
    ['animations:posh'] = {
        title = "Posh",
        icon = "#animation-posh",
        close = true,
        functionName = "AnimSet:Posh",
        functiontype = "client",
    },
    ['animations:alien'] = {
        title = "Alien",
        icon = "#animation-alien",
        close = true,
        functionName = "AnimSet:Alien",
        functiontype = "client",
    },
    ['animations:nonchalant'] =
    {
        title = "Nonchalant",
        icon = "#animation-nonchalant",
        close = true,
        functionName = "AnimSet:NonChalant",
        functiontype = "client",
    },
    ['animations:hobo'] = {
        title = "Hobo",
        icon = "#animation-hobo",
        close = true,
        functionName = "AnimSet:Hobo",
        functiontype = "client",
    },
    ['animations:money'] = {
        title = "Money",
        icon = "#animation-money",
        close = true,
        functionName = "AnimSet:Money",
        functiontype = "client",
    },
    ['animations:swagger'] = {
        title = "Swagger",
        icon = "#animation-swagger",
        close = true,
        functionName = "AnimSet:Swagger",
        functiontype = "client",
    },
    ['animations:shady'] = {
        title = "Shady",
        icon = "#animation-shady",
        close = true,
        functionName = "AnimSet:Shady",
        functiontype = "client",
    },
    ['animations:maneater'] = {
        title = "Man Eater",
        icon = "#animation-maneater",
        close = true,
        functionName = "AnimSet:ManEater",
        functiontype = "client",
    },
    ['animations:chichi'] = {
        title = "ChiChi",
        icon = "#animation-chichi",
        close = true,
        functionName = "AnimSet:ChiChi",
        functiontype = "client",
    },
    ['animations:default'] = {
        title = "Default",
        icon = "#animation-default",
        close = true,
        functionName = "AnimSet:default",
        functiontype = "client",
    },
    ["expressions:angry"] = {
        title="Angry",
        icon="#expressions-angry",
        close = true,
        functionName = "expressions",
        functionParameters =  { "mood_angry_1" },
        functiontype = "client",
    },
    ["expressions:drunk"] = {
        title="Drunk",
        icon="#expressions-drunk",
        close = true,
        functionName = "expressions",
        functionParameters =  { "mood_drunk_1" },
        functiontype = "client",
    },
    ["expressions:dumb"] = {
        title="Dumb",
        icon="#expressions-dumb",
        close = true,
        functionName = "expressions",
        functionParameters =  { "pose_injured_1" },
        functiontype = "client",
    },
    ["expressions:electrocuted"] = {
        title="Electrocuted",
        icon="#expressions-electrocuted",
        close = true,
        functionName = "expressions",
        functionParameters =  { "electrocuted_1" },
        functiontype = "client",
    },
    ["expressions:grumpy"] = {
        title="Grumpy",
        icon="#expressions-grumpy",
        close = true,
        functionName = "expressions", 
        functionParameters =  { "mood_drivefast_1" },
        functiontype = "client",
    },
    ["expressions:happy"] = {
        title="Happy",
        icon="#expressions-happy",
        close = true,
        functionName = "expressions",
        functionParameters =  { "mood_happy_1" },
        functiontype = "client",
    },
    ["expressions:injured"] = {
        title="Injured",
        icon="#expressions-injured",
        close = true,
        functionName = "expressions",
        functionParameters =  { "mood_injured_1" },
        functiontype = "client",
    },
    ["expressions:joyful"] = {
        title="Joyful",
        icon="#expressions-joyful",
        close = true,
        functionName = "expressions",
        functionParameters =  { "mood_dancing_low_1" },
        functiontype = "client",
    },
    ["expressions:mouthbreather"] = {
        title="Mouthbreather",
        icon="#expressions-mouthbreather",
        close = true,
        functionName = "expressions",
        functionParameters = { "smoking_hold_1" },
        functiontype = "client",
    },
    ["expressions:normal"]  = {
        title="Normal",
        icon="#expressions-normal",
        close = true,
        functionName = "expressions:clear",
        functiontype = "client",
    },
    ["expressions:oneeye"]  = {
        title="One Eye",
        icon="#expressions-oneeye",
        close = true,
        functionName = "expressions",
        functionParameters = { "pose_aiming_1" },
        functiontype = "client",
    },
    ["expressions:shocked"]  = {
        title="Shocked",
        icon="#expressions-shocked",
        close = true,
        functionName = "expressions",
        functionParameters = { "shocked_1" },
        functiontype = "client",
    },
    ["expressions:sleeping"]  = {
        title="Sleeping",
        icon="#expressions-sleeping",
        close = true,
        functionName = "expressions",
        functionParameters = { "dead_1" },
        functiontype = "client",
    },
    ["expressions:smug"]  = {
        title="Smug",
        icon="#expressions-smug",
        close = true,
        functionName = "expressions",
        functionParameters = { "mood_smug_1" },
        functiontype = "client",
    },
    ["expressions:speculative"]  = {
        title="Speculative",
        icon="#expressions-speculative",
        close = true,
        functionName = "expressions",
        functionParameters = { "mood_aiming_1" },
        functiontype = "client",
    },
    ["expressions:stressed"]  = {
        title="Stressed",
        icon="#expressions-stressed",
        close = true,
        functionName = "expressions",
        functionParameters = { "mood_stressed_1" },
        functiontype = "client",
    },
    ["expressions:sulking"]  = {
        title="Sulking",
        icon="#expressions-sulking",
        close = true,
        functionName = "expressions",
        functionParameters = { "mood_sulk_1" },
        functiontype = "client",
    },
    ["expressions:weird"]  = {
        title="Weird",
        icon="#expressions-weird",
        close = true,
        functionName = "expressions",
        functionParameters = { "effort_2" },
        functiontype = "client",
    },
    ["expressions:weird2"]  = {
        title="Weird 2",
        icon="#expressions-weird2",
        close = true,
        functionName = "expressions",
        functionParameters = { "effort_3" },
        functiontype = "client",
    },
    ['vehicle:extra'] = {
        title = "Extra1",
        icon = "#vehicle-plus",
        close = false,
        functionParameters = 1,
        functiontype = "client",
        functionName = "pepe-radialmenu:client:setExtra"
    },
    ['vehicle:extra2'] = {
        title = "Extra2",
        icon = "#vehicle-plus",
        close = false,
        functionParameters = 2,
        functiontype = "client",
        functionName = "pepe-radialmenu:client:setExtra"
    },   
    ['vehicle:extra3'] = {
        title = "Extra3",
        icon = "#vehicle-plus",
        close = false,
        functionParameters = 3,
        functiontype = "client",
        functionName = "pepe-radialmenu:client:setExtra"
    },
    ['vehicle:extra4'] = {
        title = "Extra4",
        icon = "#vehicle-plus",
        close = false,
        functionParameters = 4,
        functiontype = "client",
        functionName = "pepe-radialmenu:client:setExtra"
    },
}

RegisterNetEvent('pepe-radialmenu:client:update:duty:vehicles')
AddEventHandler('pepe-radialmenu:client:update:duty:vehicles', function()
    Config.Menu[11].subMenus = exports['pepe-police']:GetVehicleList()
end)