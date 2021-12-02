Config = {}

local StringCharset = {}
local NumberCharset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(StringCharset, string.char(i)) end
for i = 97, 122 do table.insert(StringCharset, string.char(i)) end

Config.RandomStr = function(length)
	if length > 0 then
		return Config.RandomStr(length-1) .. StringCharset[math.random(1, #StringCharset)]
	else
		return ''
	end
end

Config.RandomInt = function(length)
	if length > 0 then
		return Config.RandomInt(length-1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

Config.CurrentId = nil

Config.IsEscorted = false
Config.IsHandCuffed = false

Config.Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

-- Config.Keys = {["E"] = 38, ["G"] = 47, ["H"] = 74, ["BACKSPACE"] = 177}

Config.AmmoLabels = {
 ["AMMO_PISTOL"] = "9x19mm Parabellum kogel",
 ["AMMO_SMG"] = "9x19mm Parabellum kogel",
 ["AMMO_RIFLE"] = "7.62x39mm kogel",
 ["AMMO_MG"] = "7.92x57mm Mauser kogel",
 ["AMMO_SHOTGUN"] = "12-gauge kogel",
 ["AMMO_SNIPER"] = "Groot kaliber kogel",
}

Config.StatusList = {
 ["fight"] = "Rode handen",
 ["widepupils"] = "Verwijde pupillen",
 ["redeyes"] = "Rode ogen",
 ["weedsmell"] = "Ruikt naar wiet",
 ["alcohol"] = "Adem ruikt naar alcohol",
 ["gunpowder"] = "Kruitsporen in kleding",
 ["chemicals"] = "Ruikt chemisch",
 ["heavybreath"] = "Ademt zwaar",
 ["sweat"] = "Zweet erg",
 ["handbleed"] = "Bloed op handen",
 ["confused"] = "Verward",
 ["alcohol"] = "Ruikt naar alcohol",
 ["heavyalcohol"] = "Ruikt erg naar alcohol",
}

Config.SilentWeapons = {
 "WEAPON_UNARMED",
 "WEAPON_SNOWBALL",
 "WEAPON_PETROLCAN",
 "WEAPON_STUNGUN",
 "WEAPON_FIREEXTINGUISHER",
}

Config.WeaponHashGroup = {
 [416676503] =   {['name'] = "Pistool"},
 [860033945] =   {['name'] = "Shotgun"},
 [970310034] =   {['name'] = "Semi-Automatisch"},
 [1159398588] =  {['name'] = "Automatisch"},
 [-1212426201] = {['name'] = "Scherpschutter"},
 [-1569042529] = {['name'] = "Zwaar"},
 [1548507267] =  {['name'] = "Granaat"},
}
-- Config.ClothingRooms = {
--   [1] = {requiredJob = "police", x = 462.07, y = -999.08, z = 30.68, cameraLocation = {x = 462.02, y = -998.90, z = 30.68, h = 87.96}},
--   [3] = {requiredJob = "ambulance", x = 300.16, y = -598.93, z = 43.28, cameraLocation = {x = 301.09, y = -596.09, z = 43.28, h = 157.5}},
-- }
Config.Locations = {
    ['checkin'] = {
      [1] = {['X'] = 441.27, ['Y'] = -981.96, ['Z'] = 30.68},
      [2] = {['X'] = -449.1583, ['Y'] = 6012.7314, ['Z'] = 31.716451},
    },
    ['fingerprint'] = {
      [1] = {['X'] = 474.39303, ['Y'] = -1013.305, ['Z'] = 26.273303},
      [2] = {['X'] = -442.1316, ['Y'] = 6011.3369, ['Z'] = 27.985635},
    },
    ['personal-safe'] = {
      [1] = {['X'] = 473.152, ['Y'] = -1007.612, ['Z'] = 26.273305},
      [2] = {['X'] = -437.2376, ['Y'] = 6001.0878, ['Z'] = 31.716094},
    },
    ['work-shops'] = {
      [1] = {['X'] = 482.52151, ['Y'] = -995.268, ['Z'] = 30.689649},
      [2] = {['X'] = -436.93, ['Y'] = 5996.86, ['Z'] = 31.71},
    },
    ['boss'] = {
      [1] = {['X'] = 456.58859, ['Y'] = -994.1072, ['Z'] = 30.68},
      [2] = {['X'] = -447.0238, ['Y'] = 6014.1552, ['Z'] = 36.507064}, -- Paleto
    },
    ['impound'] = {
      [1] = {['X'] = 452.76489, ['Y'] = -1019.815, ['Z'] = 28.391712}, -- Politie impound
    },
    ['clothing'] = {
      [1] = {['X'] = 457.98931, ['Y'] = -979.4179, ['Z'] = 34.297359},
      [2] = {['X'] = -453.2829, ['Y'] = 6013.7529, ['Z'] = 31.716428}, -- Paleto
    },
    ['garage'] = {
        [1] = {
         ['X'] = 441.05, 
         ['Y'] = -992.93, 
         ['Z'] = 25.69,
         ['Spawns'] = {
            [1] = {
             ['X'] = 436.87,
             ['Y'] = -994.17,
             ['Z'] = 25.69,
             ['H'] = 88.02,
            },
            [2] = {
             ['X'] = 437.08,
             ['Y'] = -988.96,
             ['Z'] = 25.89,
             ['H'] = 90.94,
            },
            [3] = {
             ['X'] = 445.19,
             ['Y'] = -991.56,
             ['Z'] = 25.69,
             ['H'] = 268.71,
            },
          },
       },
      [2] = { -- Paleto PD
        ['X'] = -460.3319, 
        ['Y'] = 6000.0693, 
        ['Z'] = 31.340539,
        ['Spawns'] = {
           [1] = {
            ['X'] = -452.7386,
            ['Y'] = 5998.256,
            ['Z'] = 31.34054,
            ['H'] = 269.477,
           },
         },
      },
    },
}

Config.Objects = {
  ["cone"] = {model = `prop_roadcone02a`, freeze = false},
  ["barrier"] = {model = `prop_barrier_work06a`, freeze = true},
  ["schot"] = {model = `prop_snow_sign_road_06g`, freeze = true},
  ["tent"] = {model = `prop_gazebo_03`, freeze = true},
  ["light"] = {model = `prop_worklight_03b`, freeze = true},
}

Config.Items = {
  label = "Politie Wapenkluis",
  slots = 30,
  items = {
      [1] = {
        name = "weapon_pistol_mk2",
        price = 0,
        amount = 1,
        info = {
            serie = "",  
            quality = 100.0,              
            attachments = {{component = "COMPONENT_AT_PI_FLSH_02", label = "Flashlight"}}
        },
        type = "weapon",
        slot = 1,
      },
      [2] = {
        name = "weapon_stungun",
        price = 0,
        amount = 1,
        info = {
            serie = "",   
            quality = 100.0,         
        },
        type = "weapon",
        slot = 2,
      },
      [3] = {
        name = "weapon_carbinerifle_mk2",
        price = 0,
        amount = 1,
        info = {
          serie = "",  
          quality = 100.0,
          attachments = {{component = "COMPONENT_AT_SCOPE_MEDIUM_MK2", label = "Scope"}, {component = "COMPONENT_AT_MUZZLE_05", label = "Muzzle Demper"}, {component = "COMPONENT_AT_AR_AFGRIP_02", label = "Grip"}, {component = "COMPONENT_AT_AR_FLSH", label = "Falshlight"}}    
        },
        type = "weapon",
        slot = 3,
      },
      [4] = {
        name = "weapon_flashlight",
        price = 0,
        amount = 1,
        info = {
          quality = 100.0
        },
        type = "weapon",
        slot = 4,
      },
      [5] = {
        name = "weapon_nightstick",
        price = 0,
        amount = 1,
        info = {
          quality = 100.0
        },
        type = "weapon",
        slot = 5,
      },
      [6] = {
        name = "pistol-ammo",
        price = 100,
        amount = 50,
        info = {},
        type = "item",
        slot = 6,
      },
      [7] = {
        name = "rifle-ammo",
        price = 250,
        amount = 50,
        info = {},
        type = "item",
        slot = 7,
      },
      [8] = {
        name = "armor",
        price = 150,
        amount = 50,
        info = {},
        type = "item",
        slot = 8,
      },
      [9] = {
        name = "heavy-armor",
        price = 350,
        amount = 50,
        info = {},
        type = "item",
        slot = 9,
      },
      [10] = {
        name = "handcuffs",
        price = 0,
        amount = 1,
        info = {},
        type = "item",
        slot = 10,
      },
      [11] = {
        name = "empty_evidence_bag",
        price = 0,
        amount = 50,
        info = {},
        type = "item",
        slot = 11,
      },
      [12] = {
        name = "radio",
        price = 0,
        amount = 50,
        info = {},
        type = "item",
        slot = 12,
      },
      [13] = {
        name = "police_stormram",
        price = 0,
        amount = 50,
        info = {},
        type = "item",
        slot = 13,
      }, 
      [14] = {
        name = "spikestrip",
        price = 0,
        amount = 50,
        info = {},
        type = "item",
        slot = 14,
      },
        [15] = {
          name = "signalradar",
          price = 0,
          amount = 150,
          info = {},
          type = "item",
          slot = 15,
      },
      [16] = {
        name = "repairkit",
        price = 10,
        amount = 150,
        info = {},
        type = "item",
        slot = 16,
      },
      [17] = {
        name = "pet_shepherd",
        price = 300,
        amount = 1,
        info = {},
        type = "item",
        slot = 17,
      },
      [18] = {
        name = "health-pack",
        price = 75,
        amount = 10,
        info = {},
        type = "item",
        slot = 18,
      },
      [19] = {
        name = "bandage",
        price = 25,
        amount = 10,
        info = {},
        type = "item",
        slot = 19,
      },
      [20] = {
        name = "gasmask",
        price = 100,
        amount = 10,
        info = {},
        type = "item",
        slot = 20,
      },
   }
}


Config.SecurityCameras = {
  hideradar = false,
  cameras = {
      [1] = {label = "Davis Ave Grove St CAM#1", x = -43.88, y = -1755.40, z = 31.546, r = {x = -35.0, y = 0.0, z = 100.9182}, canRotate = false, isOnline = true},
      [2] = {label = "Prosperity St  CAM#1", x = -1482.9, y = -380.463, z = 42.363, r = {x = -35.0, y = 0.0, z = 79.53281}, canRotate = false, isOnline = true},
      [3] = {label = "Andreas Ave. CAM#1", x = -1224.874, y = -911.094, z = 14.401, r = {x = -35.0, y = 0.0, z = -6.778894}, canRotate = false, isOnline = true},
      [4] = {label = "Palomino Ave Ginger St CAM#1", x = -705.47, y = -909.66, z = 21.49, r = {x = -35.0, y = 0.0, z = 480.065}, canRotate = false, isOnline = true},
      [5] = {label = "Innocence Blvd Elgin Ave. CAM#1", x = 23.885, y = -1342.441, z = 31.672, r = {x = -35.0, y = 0.0, z = -142.9191}, canRotate = false, isOnline = true},
      [6] = {label = "Innocence Blvd Elgin Ave. CAM#2", x = 30.73, y = -1340.42, z = 32.672, r = {x = -50.0, y = 0.0, z = 75.9191}, canRotate = false, isOnline = true},
      [7] = {label = "Rancho Blvd Vespucci Blvd. CAM#1", x = 1133.024, y = -978.712, z = 48.515, r = {x = -35.0, y = 0.0, z = -137.302}, canRotate = false, isOnline = true},
      [8] = {label = "Mirror Park Blvd CAM#1", x = 1164.95, y = -318.98, z = 71.33, r = {x = -35.0, y = 0.0, z = -200.4468}, canRotate = false, isOnline = true},
      [9] = {label = "Clinton Ave CAM#1", x = 383.402, y = 328.915, z = 105.541, r = {x = -35.0, y = 0.0, z = 118.585}, canRotate = false, isOnline = true},
      [10] = {label = "Clinton Ave CAM#2", x = 380.73, y = 330.36, z = 105.80, r = {x = -55.0, y = 0.0, z = 380.9191}, canRotate = false, isOnline = true},
      [11] = {label = "Banham Canyon Dr CAM#1", x = -1822.90, y = 798.75, z = 140.436, r = {x = -35.0, y = 0.0, z = -190.481}, canRotate = false, isOnline = true},
      [12] = {label = "Great Ocean Hwy CAM#1", x = -2966.15, y = 387.067, z = 17.393, r = {x = -35.0, y = 0.0, z = 32.92229}, canRotate = false, isOnline = true},
      [13] = {label = "Ineseno Road CAM#1", x = -3040.85, y = 592.73, z = 9.808, r = {x = -35.0, y = 0.0, z = -180.673}, canRotate = false, isOnline = true},
      [14] = {label = "Ineseno Road CAM#2", x = -3047.10, y = 589.15, z = 9.808, r = {x = -35.0, y = 0.0, z = -180.673}, canRotate = false, isOnline = true},
      [15] = {label = "Barbareno Rd. CAM#1", x = -3240.46, y = 1009.16, z = 14.705, r = {x = -35.0, y = 0.0, z = -205.2151}, canRotate = false, isOnline = true},
      [16] = {label = "Barbareno Rd. CAM#2", x = -3247.44, y = 1007.41, z = 14.705, r = {x = -35.0, y = 0.0, z = -205.2151}, canRotate = false, isOnline = true},
      [17] = {label = "Route 68 Winkel CAM#1", x = 539.71, y = 2671.14, z = 44.056, r = {x = -35.0, y = 0.0, z = -90.947}, canRotate = false, isOnline = true},
      [18] = {label = "Route 68 Winkel CAM#2", x = 542.94, y = 2664.60, z = 44.056, r = {x = -35.0, y = 0.0, z = -90.947}, canRotate = false, isOnline = true},
      [19] = {label = "Route 68 slijter CAM#1", x = 1169.855, y = 2711.493, z = 40.432, r = {x = -35.0, y = 0.0, z = 127.17}, canRotate = false, isOnline = true},
      [20] = {label = "Senora Fwy CAM#1", x = 2683.37, y = 3286.98, z = 57.541, r = {x = -35.0, y = 0.0, z = 150.242}, canRotate = false, isOnline = true},
      [21] = {label = "Senora Fwy CAM#2", x = 2676.20, y = 3288.358, z = 57.541, r = {x = -35.0, y = 0.0, z = 80.78}, canRotate = false, isOnline = true},
      [22] = {label = "Alhambra Dr. CAM#1", x = 1957.61, y = 3743.855, z = 34.143, r = {x = -35.0, y = 0.0, z = 253.065}, canRotate = false, isOnline = true},
      [23] = {label = "Alhambra Dr. CAM#2", x = 1961.81, y = 3747.87, z = 34.262, r = {x = -35.0, y = 0.0, z = 80.78}, canRotate = false, isOnline = true},
      [24] = {label = "Great Ocean Hwy Paleto CAM#1", x = 1729.522, y = 6419.87, z = 37.262, r = {x = -35.0, y = 0.0, z = -160.089}, canRotate = false, isOnline = true},
      [25] = {label = "Great Ocean Hwy Paleto CAM#2", x = 1736.65, y = 6417.42, z = 37.262, r = {x = -35.0, y = 0.0, z = 50.089}, canRotate = false, isOnline = true},
      [26] = {label = "Pyrite Ave Paleto Blvd", x = -163.75, y = 6323.45, z = 33.424, r = {x = -35.0, y = 0.0, z = 260.00}, canRotate = false, isOnline = true},
      [27] = {label = "Paleto Bay CAM#1", x = 163.74, y = 6644.34, z = 33.69, r = {x = -35.0, y = 0.0, z = 168.00}, canRotate = false, isOnline = true},
      [28] = {label = "Paleto Bay CAM#2", x = 169.54, y = 6640.89, z = 33.69, r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = false, isOnline = true},
      [29] = {label = "Grapeseed Mainstreet Cam#1", x = 1702.27, y = 4919.27, z = 43.806384, r = {x = -35.0, y = 0.0, z = -320.00}, canRotate = true, isOnline = true},
      [30] = {label = "Palomino Freeway CAM#1", x = 2558.50, y = 390.08, z = 111.00, r = {x = -35.0, y = 0.0, z = -190.00}, canRotate = true, isOnline = true},
      [31] = {label = "Palomino Freeway CAM#2", x = 2551.76, y = 387.55, z = 111.00, r = {x = -35.0, y = 0.0, z = -210.00}, canRotate = true, isOnline = true},
      [32] = {label = "App Store CAM#1", x = 147.14, y = -214.45, z = 58.60, r = {x = -35.0, y = 0.0, z = -50.00}, canRotate = true, isOnline = true},
      [33] = {label = "App Store CAM#2", x = 159.46955, y = -229.387, z = 56.424053, r = {x = -35.0, y = 0.0, z = 75.00}, canRotate = true, isOnline = true},
      [34] = {label = "App Store CAM#3", x = 147.52073, y = -170.1805, z = 66.122169, r = {x = -35.0, y = 0.0, z = 175.00}, canRotate = true, isOnline = true},
      [40] = {label = "Pacific Bank Voordeur CAM#1", x = 232.86, y = 221.46, z = 107.83, r = {x = -25.0, y = 0.0, z = -140.9}, canRotate = false, isOnline = true},
      [41] = {label = "Pacific Bank Achterdeur CAM#2", x = 257.45, y = 210.07, z = 109.08, r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = false, isOnline = true},
      [42] = {label = "Pacific Bank Lobby CAM#3", x = 266.29, y = 215.72, z = 107.95, r = {x = -25.0, y = 0.0, z = 135.49}, canRotate = false, isOnline = true},
      [43] = {label = "Pacific Bank Lobby CAM#4", x = 241.97, y = 215.10, z = 107.95, r = {x = -25.0, y = 0.0, z = -80.49}, canRotate = false, isOnline = true},
      [44] = {label = "Pacific Bank kluis CAM#5", x = 252.27, y = 225.52, z = 103.99, r = {x = -35.0, y = 0.0, z = -74.87}, canRotate = false, isOnline = true},
      [50] = {label = "Fleeca Bank Legion Square CAM#1", x = 153.14, y = -1042.07, z = 31.017, r = {x = -35.0, y = 0.0, z = 20.97}, canRotate = false, isOnline = true},
      [51] = {label = "Fleeca Bank Legion Square CAM#2", x = 149.82, y = -1051.40, z = 31.017, r = {x = -45.0, y = 0.0, z = 20.97}, canRotate = false, isOnline = true},
      [52] = {label = "Fleeca Bank Hawick Ave CAM#1", x = -347.50, y = -51.26, z = 50.88, r = {x = -35.0, y = 0.0, z = 20.97}, canRotate = false, isOnline = true},
      [53] = {label = "Fleeca Bank Hawick Ave CAM#2", x = -350.82, y = -60.506, z = 50.746, r = {x = -45.0, y = 0.0, z = 20.97}, canRotate = false, isOnline = true},
      [54] = {label = "Fleeca Bank Motel CAM#1", x = 317.63, y = -280.45, z = 55.746, r = {x = -35.0, y = 0.0, z = 20.97}, canRotate = false, isOnline = true},
      [55] = {label = "Fleeca Bank Motel CAM#2", x = 314.35, y = -289.60, z = 55.746, r = {x = -45.0, y = 0.0, z = 20.97}, canRotate = false, isOnline = true},
      [56] = {label = "Fleeca Bank Del Perro Blvd CAM#1", x = -1209.40, y = -329.30, z = 39.51, r = {x = -35.0, y = 0.0, z = 90.97}, canRotate = false, isOnline = true},
      [57] = {label = "Fleeca Bank Del Perro Blvd CAM#2", x = -1204.90, y = -337.80, z = 39.51, r = {x = -55.0, y = 0.0, z = 50.97}, canRotate = false, isOnline = true},
      [58] = {label = "Fleeca Bank Great Ocean Hwy CAM#1", x = -2962.28, y = 486.60, z = 17.406, r = {x = -35.0, y = 0.0, z = 150.00}, canRotate = false, isOnline = true},
      [59] = {label = "Fleeca Bank Great Ocean Hwy CAM#2", x = -2952.20, y = 486.00, z = 17.406, r = {x = -45.0, y = 0.0, z = 100.97}, canRotate = false, isOnline = true},
      [60] = {label = "Paleto Bank CAM#1", x = -104.19, y = 6466.97, z = 33.424, r = {x = -35.0, y = 0.0, z = 124.66}, canRotate = false, isOnline = true},
      [61] = {label = "Paleto Bank CAM#1", x = -102.939, y = 6467.668, z = 33.424, r = {x = -35.0, y = 0.0, z = 24.66}, canRotate = false, isOnline = true},
      [62] = {label = "Paleto Bank CAM#1", x = -104.53, y = 6479.55, z = 33.424, r = {x = -52.0, y = 0.0, z = 150.66}, canRotate = false, isOnline = true},
      [70] = {label = "Juwelier CAM#1", x = -620.2418, y = -224.2597, z = 39.85, r = {x = -25.0, y = 0.0, z = 175.66}, canRotate = false, isOnline = true},
      [71] = {label = "Juwelier CAM#2", x = -627.7718, y = -230.0077, z = 39.85, r = {x = -25.0, y = 0.0, z = 170.00}, canRotate = false, isOnline = true},
      [72] = {label = "Juwelier CAM#3", x = -628.1018, y = -239.9446, z = 39.85, r = {x = -25.0, y = 0.0, z = -25.66}, canRotate = false, isOnline = true},
      [80] = {label = "Gevangenis Hoofdingang CAM#1", x = 1897.31, y = 2607.65, z = 50.17, r = {x = 10.41, y = 0.0, z = 120.82}, canRotate = true, isOnline = true},
      [81] = {label = "Gevangenis Hoofdingang CAM#2", x = 1834.67, y = 2604.61, z = 46.98, r = {x = -10.13, y = 0.0, z = -70.82}, canRotate = true, isOnline = true},
      
  },
}