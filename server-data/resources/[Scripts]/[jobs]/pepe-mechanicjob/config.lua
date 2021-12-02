Config = {}

Config.AttachedVehicle = nil

Config.Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}
Config.Locale = 'en'
Config.AuthorizedIds = {
}

Config.MaxStatusValues = {
    ["engine"] = 1000.0,
    ["body"] = 1000.0,
    ["radiator"] = 100,
    ["axle"] = 100,
    ["brakes"] = 100,
    ["clutch"] = 100,
    ["fuel"] = 100,
}

Config.ValuesLabels = {
    ["engine"] = "Engine",
    ["body"] = "Body",
    ["radiator"] = "Radiator",
    ["axle"] = "Axle",
    ["brakes"] = "Brakes",
    ["clutch"] = "Clutch",
    ["fuel"] = "Tank",
}

Config.RepairCost = {
    ["body"] = "plastic",
    ["radiator"] = "plastic",
    ["axle"] = "steel",
    ["brakes"] = "iron",
    ["clutch"] = "aluminum",
    ["fuel"] = "plastic",
}

Config.RepairCostAmount = {
    ["engine"] = {
        item = "metalscrap",
        costs = 2,
    },
    ["body"] = {
        item = "plastic",
        costs = 3,
    },
    ["radiator"] = {
        item = "steel",
        costs = 5,
    },
    ["axle"] = {
        item = "aluminum",
        costs = 7,
    },
    ["brakes"] = {
        item = "copper",
        costs = 5,
    },
    ["clutch"] = {
        item = "copper",
        costs = 6,
    },
    ["fuel"] = {
        item = "plastic",
        costs = 5,
    },
}

Config.Businesses = {
    "autocare",
}

Config.Plates = {
    [1] = {
        coords = {x = -583.13, y = -931.78, z = 23.89, h = 267.41, r = 1.0},
        AttachedVehicle = nil,
    },
    [2] = {
        coords = {x = -583.28, y = -924.51, z = 23.38, h = 267.41, r = 1.0}, 
        AttachedVehicle = nil,
    },
    [3] = {
        coords = {x = -583.28, y = -917.44, z = 23.38, h = 267.41, r = 1.0}, 
        AttachedVehicle = nil,
    },
    [4] = {
        coords = {x = -559.05, y = -903.22, z = 23.37, h = 267.41, r = 1.0}, 
        AttachedVehicle = nil,
    },
}
Config.Locations = {
    ["exit"] = {x = -560.01, y = -895.48, z = 24.57, h = 263.54, r = 1.0}, 
    ["stash"] = {x = -590.55, y = -928.44, z = 28.18, h = 262.18, r = 1.0},
    ["duty"] = {x = -346.925, y = -128.6472, z = 39.01, h = 80, r = 1.0},
    ["vehicle"] = {x = -561.51, y = -896.4, z = 24.41, h = 245.94, r = 1.0}, 
    ["boss"] = {x = -605.49, y = -918.73, z = 23.89, h = 268.37, r = 1.0},
    ["kleren"] = {x = -602.52, y = -915.54, z = 23.89, h = 273.71, r = 1.0}, 
}

Config.Vehicles = {
    ["towtruck"] = "Towtruck",
    ["flatbed3"] = "Flatbed",
    ["anwbt6"] = "Werkbus",
    ["blista"] = "Leenauto",
}

Config.MinimalMetersForDamage = {
    [1] = {
        min = 8000,
        max = 12000,
        multiplier = {
            min = 1,
            max = 8,
        }
    },
    [2] = {
        min = 12000,
        max = 16000,
        multiplier = {
            min = 8,
            max = 16,
        }
    },
    [3] = {
        min = 12000,
        max = 16000,
        multiplier = {
            min = 16,
            max = 24,
        }
    },
}

Config.Damages = {
    ["radiator"] = "Radiator",
    ["axle"] = "Axle",
    ["brakes"] = "Brakes",
    ["clutch"] = "Clutch",
    ["fuel"] = "Tank",
}