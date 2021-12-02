Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DEL'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

Config = {}
Config.VehiclePrice = 1500
Config.CustomersFindPrice = 750
Config.WholesaleVehicle = "burrito2"
Config.MinWholesaleCount = 50
Config.RequiredCops = 0
Config.CopsRefreshTime = 30000 --MINIMUM 10000ms!!!

------------------------------ from 0% to 100%
Config.NormalSellChance = 55 -- 45% Normal Sale
Config.DruggedSellChance = 50 -- 5% NPC is drugged and paid 2x
Config.AttackSellChance = 35 -- 15% NPC robbing us
Config.PoliceSellChance = 0 -- 35% NPC notifies the LSPD
------------------------------

Config.Drugs = {
    Weed = {
        ItemName = "oxy",
        ItemWholesalePrice = 40,
        ItemSinglyPrice = 80,
    },
    Meth = {
        ItemName = "oxy",
        ItemWholesalePrice = 45,
        ItemSinglyPrice = 90,
    },
    Opium = {
        ItemName = "oxy",
        ItemWholesalePrice = 55,
        ItemSinglyPrice = 110,
    },
    Coke = {
        ItemName = "oxy",
        ItemWholesalePrice = 85,
        ItemSinglyPrice = 170,
    },
}

Config.SellDrugs = {
    Dealer = {
		Pos   = {x = 882.68, y = -1052.15, z = 33.01, h = 0.3},
		Size  = {x = 1.2, y = 1.2, z = 1.0},
		Color = {r = 78, g = 2453, b = 175},
		Type  = 27,
        WholesaleVehicleSpawnPointSize = {x = 2.5, y = 2.5, z = 1.0},
        WholesaleVehicleSpawnPoint = {x = 865.73, y = -1061.23, z = 28.72, h = 88.22},
        DealerPed = "a_m_m_soucent_03",
        DealerText = {
            [1] = {text = "Do you want to earn some cash?"},
            [2] = {text = "What's up, bro, you need money?"},
            [3] = {text = "I have an offer you can't refuse"},
            [4] = {text = "You got some drugs?"},
        },
        CustomerWholesaleText = {
            [1] = {text = "Do you have something good for me?"},
            [2] = {text = "Do you have what it was about?"},
            [3] = {text = "Fast action, people drive here..."},
            [4] = {text = "Move faster, we don't have time!"},
            [5] = {text = "Hope the drugs are top shelf"},
            [6] = {text = "Hope everything is converted to milligrams"},
        },
        CustomerSinglyText = {
            [1] = {text = "Yo, have you got any good for me?"},
            [2] = {text = "Hi buddy, do you have any drugs?"},
            [3] = {text = "How long can i wait for you... Do you have drugs?"},
            [4] = {text = "Wassup, hurry up, I don't have time!"},
            [5] = {text = "Yoo, hope the drugs are top shelf"},
            [6] = {text = "Hey, hope everything is converted to milligrams..."},
        },
        CustomerSinglyNormalText = {
            [1] = {text = "Thank you, I'm going to have a little fun"},
            [2] = {text = "All right bro, till the next..."},
            [3] = {text = "We are in touch mate!"},
            [4] = {text = "Today i'm going to be crazy"},
            [5] = {text = "I'll be in touch for more soon!"},
            [6] = {text = "I'm going to the club, take care of yourself"},
        },
        CustomerSinglyDruggedText = {
            [1] = {text = "I'm gonna get more high, cross your fingers"},
            [2] = {text = "Fuck, but these drugs are pounding"},
            [3] = {text = "Thanks, my dear, take care..."},
            [4] = {text = "Fuck! I had an appointment with someone, but i don't remember with who..."},
            [5] = {text = "I'm coming home to rest until the next one"},
            [6] = {text = "H... H... Hey buddy!"},
        },
        CustomerSinglyAttackText = {
            [1] = {text = "Get your hands up, bitch!"},
            [2] = {text = "Give up you fucker!"},
            [3] = {text = "What now bitch?! Give me the drugs!"},
            [4] = {text = "Haha! Choose well bastard!"},
            [5] = {text = "No jerky movements or i'll blow your head off!"},
            [6] = {text = "What would you say for that?"},
        },
        CustomerSinglyPoliceText = {
            [1] = {text = "I don't want your shit!"},
            [2] = {text = "Fuck off with this"},
            [3] = {text = "I'm not interested, thanks"},
            [4] = {text = "I'm calling the police"},
            [5] = {text = "Get away from me with it!"},
            [6] = {text = "Maybe another time"},
        },
	},
    SinglyPeds = {
        [1] = {ped = "a_m_y_beach_03"},
        [2] = {ped = "a_m_y_breakdance_01"},
        [3] = {ped = "g_m_m_chicold_01"},
        [4] = {ped = "s_m_y_dealer_01"},
        [5] = {ped = "a_m_y_downtown_01"},
        [6] = {ped = "g_m_y_famfor_01"},
        [7] = {ped = "csb_g"},
        [8] = {ped = "ig_jimmydisanto"},
        [9] = {ped = "u_m_y_militarybum"},
        [10] = {ped = "ig_ortega"},
	},
    DocksCustomer = {
        DocksPed = "s_m_m_gardener_01",
	},
    EastVinewoodCustomer = {
        EastVinewoodPed = "s_m_m_bouncer_01",
	},
    SandyShoresCustomer = {
        SandyShoresPed = "a_m_m_eastsa_01",
	},
    PaletoBayCustomer = {
        PaletoBayPed = "a_m_m_hillbilly_02",
	},
}

Config.SinglyLocations = {
    {Location = "Loc1"},
    {Location = "Loc2"},
    {Location = "Loc3"},
    {Location = "Loc4"},
    {Location = "Loc5"},
    {Location = "Loc6"},
    {Location = "Loc7"},
    {Location = "Loc8"},
    {Location = "Loc9"},
    {Location = "Loc10"},
    {Location = "Loc11"},
    {Location = "Loc12"},
    {Location = "Loc13"},
    {Location = "Loc14"},
    {Location = "Loc15"},
    {Location = "Loc16"},
    {Location = "Loc17"},
    {Location = "Loc18"},
    {Location = "Loc19"},
    {Location = "Loc20"},
}

Config.Loc1 = {
    {x = 581.66, 
    y = -2728.68, 
    z = 6.06 - 0.1, 
    h = 189.28,
    gx = 582.23,
    gy = -2723.09,
    gz = 7.19,
    blip,
    ped},
}

Config.Loc2 = {
    {x = 859.23,
    y = -2273.51, 
    z = 30.35 - 0.1, 
    h = 86.60,
    gx = 856.22,
    gy = -2284.15,
    gz = 30.35,
    blip,
    ped},
}

Config.Loc3 = {
    {x = 974.69,
    y = -2366.70, 
    z = 30.52 - 0.1, 
    h = 177.90,
    gx = 975.64,
    gy = -2358.18,
    gz = 31.82,
    blip,
    ped},
}

Config.Loc4 = {
    {x = 1078.17,
    y = -1967.82, 
    z = 31.01 - 0.1, 
    h = 63.56,
    gx = 1083.57,
    gy = -1974.09,
    gz = 31.01,
    blip,
    ped},
}

Config.Loc5 = {
    {x = 1411.30,
    y = -2048.84, 
    z = 52.00 - 0.1, 
    h = 173.76,
    gx = 1414.01,
    gy = -2042.01,
    gz = 52.00,
    blip,
    ped},
}

Config.Loc6 = {
    {x = 138.77,
    y = -1333.59, 
    z = 29.20 - 0.1, 
    h = 310.05,
    gx = 138.62,
    gy = -1348.53,
    gz = 29.20,
    blip,
    ped},
}

Config.Loc7 = {
    {x = 43.51,
    y = -1447.94, 
    z = 29.31 - 0.1, 
    h = 47.66,
    gx = 49.98,
    gy = -1453.60,
    gz = 29.31,
    blip,
    ped},
}

Config.Loc8 = {
    {x = -31.08,
    y = -1497.87, 
    z = 30.55 - 0.1, 
    h = 141.21,
    gx = -25.38,
    gy = -1491.27,
    gz = 30.36,
    blip,
    ped},
}

Config.Loc9 = {
    {x = -356.80,
    y = -1460.36, 
    z = 29.57 - 0.1, 
    h = 4.09,
    gx = -356.27,
    gy = -1466.82,
    gz = 30.87,
    blip,
    ped},
}

Config.Loc10 = {
    {x = -646.38,
    y = -1222.01, 
    z = 11.20 - 0.1, 
    h = 304.78,
    gx = -643.12,
    gy = -1227.65,
    gz = 11.55,
    blip,
    ped},
}

Config.Loc11 = {
    {x = -1407.18,
    y = -456.70, 
    z = 34.48 - 0.1, 
    h = 210.40,
    gx = -1402.51,
    gy = -452.20,
    gz = 34.48,
    blip,
    ped},
}

Config.Loc12 = {
    {x = -1470.42,
    y = -391.72, 
    z = 38.68 - 0.1, 
    h = 137.57,
    gx = -1467.74,
    gy = -387.50,
    gz = 38.77,
    blip,
    ped},
}

Config.Loc13 = {
    {x = -1560.84,
    y = -412.85, 
    z = 42.38 - 0.1, 
    h = 227.57,
    gx = -1567.30,
    gy = -403.89,
    gz = 42.39,
    blip,
    ped},
}

Config.Loc14 = {
    {x = -1696.27,
    y = -468.86, 
    z = 41.65 - 0.1, 
    h = 239.87,
    gx = -1700.22,
    gy = -474.50,
    gz = 41.65,
    blip,
    ped},
}

Config.Loc15 = {
    {x = -1776.32,
    y = -434.20, 
    z = 42.11 - 0.1, 
    h = 195.12,
    gx = -1778.11,
    gy = -427.52,
    gz = 41.45,
    blip,
    ped},
}

Config.Loc16 = {
    {x = 1923.26,
    y = 3733.66, 
    z = 32.77 - 0.1, 
    h = 25.40,
    gx = 1920.92,
    gy = 3728.55,
    gz = 32.79,
    blip,
    ped},
}

Config.Loc17 = {
    {x = 1781.21,
    y = 3644.36, 
    z = 34.44 - 0.1, 
    h = 296.70,
    gx = 1776.50,
    gy = 3640.95,
    gz = 34.52,
    blip,
    ped},
}

Config.Loc18 = {
    {x = 1442.02,
    y = 3650.48, 
    z = 34.34 - 0.1, 
    h = 221.48,
    gx = 1426.07,
    gy = 3644.88,
    gz = 37.89,
    blip,
    ped},
}

Config.Loc19 = {
    {x = 913.06,
    y = 3588.33, 
    z = 33.34 - 0.1, 
    h = 272.65,
    gx = 905.82,
    gy = 3586.49,
    gz = 33.42,
    blip,
    ped},
}

Config.Loc20 = {
    {x = 1769.44,
    y = 3337.62, 
    z = 41.43 - 0.1, 
    h = 299.44,
    gx = 1776.61,
    gy = 3327.63,
    gz = 41.43,
    blip,
    ped},
}

Config.WholesaleLocations = {
	{Location = "Docks"},
    {Location = "East Vinewood"},
    {Location = "Sandy Shores"},
    {Location = "Paleto Bay"},
}

Config.Docks = {
    {x = 1216.20, 
    y = -2990.94, 
    z = 5.68, 
    h = 89.91, 
    ped, 
    blip, 
    PedPosX = 1230.93, 
    PedPosY = -3002.17, 
    PedPosZ = 9.32, 
    PedPosH = 89.06,
    PedGoX = 1222.13,
    PedGoY = -2990.95,
    PedGoZ = 5.87,
    PedGoH = 85.69},
}

Config.EastVinewood = {
    {x = 601.46, 
    y = -454.80, 
    z = 24.56, 
    h = 355.60, 
    ped, 
    blip, 
    PedPosX = 608.72, 
    PedPosY = -459.64, 
    PedPosZ = 24.74, 
    PedPosH = 168.34,
    PedGoX = 604.93,
    PedGoY = -459.78,
    PedGoZ = 24.74,
    PedGoH = 39.70},
}

Config.SandyShores = {
    {x = 1354.00, 
    y = 3619.38, 
    z = 34.61, 
    h = 109.01, 
    ped, 
    blip, 
    PedPosX = 1363.69, 
    PedPosY = 3616.45, 
    PedPosZ = 34.89, 
    PedPosH = 22.83,
    PedGoX = 1359.42,
    PedGoY = 3621.19,
    PedGoZ = 34.81,
    PedGoH = 101.93},
}

Config.PaletoBay = {
    {x = -22.33, 
    y = 6457.40, 
    z = 31.20, 
    h = 223.36, 
    ped, 
    blip, 
    PedPosX = -29.62, 
    PedPosY = 6457.64, 
    PedPosZ = 31.46, 
    PedPosH = 221.25,
    PedGoX = -26.41,
    PedGoY = 6461.58,
    PedGoZ = 31.45,
    PedGoH = 220.46},
}