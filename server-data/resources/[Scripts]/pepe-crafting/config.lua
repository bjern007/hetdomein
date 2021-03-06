Config = Config or {}

Config.WeaponCrafting = {
    ["location"] = {x = 319.16, y = -990.42, z = 24.78, h = 176.76, r = 1.0},
}

Config.CraftingItems = {
    [1] = {
      name = "lockpick",
      amount = 50,
      info = {},
      costs = {
        ["metalscrap"] = 5,
        ["plastic"] = 5,
      },
      type = "item",
      slot = 1,
      threshold = 0,
      points = 2,
  },
  [2] = {
    name = "toolkit",
    amount = 50,
    info = {},
    costs = {
      ["metalscrap"] = 30,
      ["plastic"] = 25,
    },
    type = "item",
    slot = 2,
    threshold = 10,
    points = 3,
  },
  [3] = {
    name = "electronickit",
    amount = 50,
    info = {},
    costs = {
      ["metalscrap"] = 20,
      ["plastic"] = 45,
      ["aluminum"] = 28,
    },
    type = "item",
    slot = 3,
    threshold = 100,
    points = 5,
  },
  [4] = {
    name = "plastic-bag",
    amount = 50,
    info = {},
    costs = {
      ["plastic"] = 5,
    },
    type = "item",
    slot = 4,
    threshold = 0,
    points = 2,
  },
  [5] = {
    name = "handcuffs",
    amount = 50,
    info = {},
    costs = {
      ["metalscrap"] = 36,
      ["steel"] = 24,
      ["aluminum"] = 28,
    },
    type = "item",
    slot = 5,
    threshold = 75,
    points = 6,
  },
  [6] = {
    name = "pistol-ammo",
    amount = 50,
    info = {},
    costs = {
      ["metalscrap"] = 25,
      ["steel"] = 37,
      ["copper"] = 52,
    },
    type = "item",
    slot = 6,
    threshold = 855,
    points = 8,
  },
  [7] = {
    name = "armor",
    amount = 50,
    info = {},
    costs = {
      ["iron"] = 33,
      ["steel"] = 44,
      ["stofrol"] = 10,
      ["aluminum"] = 22,
    },
    type = "item",
    slot = 7,
    threshold = 250,
    points = 11,
  },
  [8] = {
    name = "repairkit",
    amount = 50,
    info = {},
    costs = {
      ["metalscrap"] = 5,
      ["steel"] = 43,
      ["iron"] = 35,
    },
    type = "item",
    slot = 8,
    threshold = 40,
    points = 7,
  },
  [9] = {
    name = "ironoxide",
    amount = 50,
    info = {},
    costs = {
      ["iron"] = 60,
      ["glass"] = 30,
    },
    type = "item",
    slot = 9,
    threshold = 200,
    points = 6,
  },
  [10] = {
    name = "aluminumoxide",
    amount = 50,
    info = {},
    costs = {
      ["aluminum"] = 60,
      ["glass"] = 30,
    },
    type = "item",
    slot = 10,
    threshold = 310,
    points = 5,
  },
  [11] = {
    name = "blinddoek",
    amount = 50,
    info = {},
    costs = {
      ["katoen"] = 10,
      ["stofrol"] = 5,
    },
    type = "item",
    slot = 11,
    threshold = 220,
    points = 5,
  },
  [12] = {
    name = "gatecrack",
    amount = 50,
    info = {},
    costs = {
      ["aluminum"] = 75,
      ["steel"] = 50,
      ["rubber"] = 5,
      ["iron"] = 30,
    },
    type = "item",
    slot = 12,
    threshold = 810,
    points = 5,
  },
  [13] = {
    name = "explosive",
    amount = 10,
    info = {},
    costs = {
      ["aluminum"] = 120,
      ["steel"] = 50,
      ["plastic"] = 70,
      ["metalscrap"] = 5,
    },
    type = "item",
    slot = 13,
    threshold = 810,
    points = 5,
  },
  [14] = {
    name = "gasbomb",
    amount = 10,
    info = {},
    costs = {
      ["aluminum"] = 240,
      ["steel"] = 50,
      ["plastic"] = 130,
      ["metalscrap"] = 5,
    },
    type = "item",
    slot = 14,
    threshold = 1010,
    points = 5,
  },
  [15] = {
    name = "binoculars",
    amount = 2,
    info = {},
    costs = {
      ["glass"] = 240,
      ["rubber"] = 25,
      ["steel"] = 70,
      ["metalscrap"] = 20,
    },
    type = "item",
    slot = 15,
    threshold = 1010,
    points = 5,
  },
  [16] = {
    name = "bandage",
    amount = 10,
    info = {},
    costs = {
      ["stofrol"] = 8,
      ["katoen"] = 40,
    },
    type = "item",
    slot = 16,
    threshold = 1010,
    points = 5,
  },
  [17] = {
    name = "duffel-bag",
    amount = 1,
    info = {},
    costs = {
      ["stofrol"] = 38,
      ["katoen"] = 80,
    },
    type = "item",
    slot = 17,
    threshold = 1,
    points = 5,
  },
  [18] = {
    name = "gasmask",
    amount = 1,
    info = {},
    costs = {
      ["plastic"] = 38,
      ["katoen"] = 60,
    },
    type = "item",
    slot = 18,
    threshold = 1,
    points = 5,
  },
  [19] = {
    name = "weapon_molotov",
    amount = 1,
    info = {},
    costs = {
      ["plastic"] = 75,
      ["katoen"] = 60,
      ["glass"] = 100,
    },
    type = "weapon",
    slot = 19,
    threshold = 2550,
    points = 5,
  },
}

Config.TrapHouseItems = {
[1] = {
  name = "pistol-ammo",
  amount = 50,
  info = {},
  costs = {
    ["metalscrap"] = 25,
    ["steel"] = 37,
    ["copper"] = 52,
  },
  type = "item",
  slot = 6,
  threshold = 0,
  points = 8,
},
[2] = {
  name = "gasbomb",
  amount = 10,
  info = {},
  costs = {
    ["aluminum"] = 240,
    ["steel"] = 50,
    ["plastic"] = 130,
    ["metalscrap"] = 5,
  },
  type = "item",
  slot = 14,
  threshold = 0,
  points = 5,
},
[3] = {
  name = "weapon_molotov",
  amount = 1,
  info = {},
  costs = {
    ["plastic"] = 75,
    ["katoen"] = 60,
    ["glass"] = 100,
  },
  type = "weapon",
  slot = 19,
  threshold = 0,
  points = 5,
},
}

Config.CraftingWeapons = {
  [1] = {
    name = "weapon_snspistol_mk2",
    amount = 50,
    info = {
      ammo = 30,
      quality = 100.0,
    },
    costs = {
      ["steel"] = 200,
      ["rubber"] = 200,
      ["aluminum"] = 300,
      ["plastic"] = 100,
    },
    type = "weapon",
    slot = 1,
    description = '[200x Staal, 200x rubber, 300x aluminum, 100x plastic]', 
  },
  [2] = {
    name = "weapon_heavypistol",
    amount = 50,
    info = {
      ammo = 30,
      quality = 100.0,
    },
    costs = {
      ["steel"] = 200,
      ["rubber"] = 200,
      ["aluminum"] = 300,
      ["plastic"] = 100,
    },
    type = "weapon",
    slot = 2,
    description = '[200x Staal, 200x rubber, 300x aluminum, 100x plastic]', 
  },
  [3] = {
    name = "weapon_vintagepistol",
    amount = 50,
    info = {
      ammo = 30,
      quality = 100.0,
    },
    costs = {
      ["steel"] = 200,
      ["rubber"] = 200,
      ["aluminum"] = 300,
      ["plastic"] = 100,
    },
    type = "weapon",
    slot = 3,
    description = '[200x Staal, 200x rubber, 300x aluminum, 100x plastic]', 
  },
  [4] = {
    name = "weapon_machinepistol",
    amount = 50,
    info = {
      ammo = 30,
      quality = 100.0,
    },
    costs = {
      ["steel"] = 200,
      ["rubber"] = 200,
      ["aluminum"] = 300,
      ["plastic"] = 100,
    },
    type = "weapon",
    slot = 4,
    description = '[200x Staal, 200x rubber, 300x aluminum, 100x plastic]', 
  },
  [5] = {
    name = "weapon_appistol",
    amount = 50,
    info = {
      ammo = 30,
      quality = 100.0,
    },
    costs = {
      ["steel"] = 200,
      ["rubber"] = 200,
      ["aluminum"] = 300,
      ["plastic"] = 100,
    },
    type = "weapon",
    slot = 5,
    description = '[200x Staal, 200x rubber, 300x aluminum, 100x plastic]', 
  },
  [6] = {
    name = "weapon_sawnoffshotgun",
    amount = 50,
    info = {
      ammo = 30,
      quality = 100.0,
    },
    costs = {
      ["steel"] = 200,
      ["rubber"] = 200,
      ["aluminum"] = 300,
      ["plastic"] = 100,
    },
    type = "weapon",
    slot = 6,
    description = '[200x Staal, 200x rubber, 300x aluminum, 100x plastic]', 
  },
  [7] = {
    name = "weapon_assaultrifle_mk2",
    amount = 50,
    info = {
      ammo = 30,
      quality = 100.0,
    },
    costs = {
      ["steel"] = 200,
      ["rubber"] = 200,
      ["aluminum"] = 300,
      ["plastic"] = 100,
    },
    type = "weapon",
    slot = 7,
    description = '[200x Staal, 200x rubber, 300x aluminum, 100x plastic]', 
  },
  [8] = {
    name = "pistol-ammo",
    amount = 50,
    info = {
      ammo = 30,
      quality = 100.0,
    },
    costs = {
      ["metalscrap"] = 25,
      ["steel"] = 37,
      ["copper"] = 52,
    },
    type = "weapon",
    slot = 8,
    description = '[25x Metaal, 37x Staal, 52x Koper]', 
  },
  [9] = {
    name = "shotgun-ammo",
    amount = 50,
    info = {
      ammo = 30,
      quality = 100.0,
    },
    costs = {
      ["metalscrap"] = 25,
      ["steel"] = 37,
      ["copper"] = 52,
    },
    type = "weapon",
    slot = 9,
    description = '[25x Metaal, 37x Staal, 52x Koper]', 
  },
  [10] = {
    name = "rifle-ammo",
    amount = 50,
    info = {
      ammo = 30,
      quality = 100.0,
    },
    costs = {
      ["metalscrap"] = 25,
      ["steel"] = 37,
      ["copper"] = 52,
    },
    type = "weapon",
    slot = 10,
    description = '[25x Metaal, 37x Staal, 52x Koper]', 
  },
  [11] = {
    name = "pistol_suppressor",
    amount = 50,
    info = {
      ammo = 30,
      quality = 100.0,
    },
    costs = {
      ["steel"] = 50,
      ["rubber"] = 100,
      ["aluminum"] = 50,
      ["plastic"] = 50,
    },
    type = "weapon",
    slot = 11,
    description = '[50x Staal, 100x rubber, 50x aluminum, 50x plastic]', 
  },
  [12] = {
    name = "pistol_extendedclip",
    amount = 50,
    info = {
      ammo = 30,
      quality = 100.0,
    },
    costs = {
      ["steel"] = 50,
      ["rubber"] = 100,
      ["aluminum"] = 50,
      ["plastic"] = 50,
    },
    type = "weapon",
    slot = 12,
    description = '[50x Staal, 100x rubber, 50x aluminum, 50x plastic]', 
  },
  -- [13] = {
  --   name = "pizza-box",
  --   amount = 50,
  --   info = {
  --     ammo = 30,
  --     quality = 100.0,
  --   },
  --   costs = {
  --     ["wood_proc"] = 2,
  --   },
  --   type = "weapon",
  --   slot = 13,
  --   description = '[2x Verwerkt hout,]', 
  -- },
  
  
}