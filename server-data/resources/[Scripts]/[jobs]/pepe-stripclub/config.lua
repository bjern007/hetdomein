Config = Config or {}

Config.ActivePaymentsStrip = {}

Config.Locations = {
	['shop'] = { ['x'] = 129.76, ['y'] = -1281.82, ['z'] = 29.26, ['h'] = 295.61 },
	['vip'] = { ['x'] = 118.81668 , ['y'] = -1302.461, ['z'] = 29.269309, ['h'] = 211.85334 },
	['stripper'] = { ['x'] = 108.55, ['y'] = -1305.98, ['z'] = 28.76, ['h'] = 212.00  },
	['boss'] = { ['x'] = 95.15, ['y'] = -1293.38, ['z'] = 29.26, ['h'] = 290.99  },
}

Config.Strippers = {
    ['locations'] ={
        {
            ['taken'] = 0,
            ['model'] = nil,
            ['sit'] = vector4(118.77422, -1302.212, 28.269432, 31.382211),
            ['stand'] = vector4(118.42105, -1301.561, 28.269502, 208.21502),
        },
        {
            ['taken'] = 0,
            ['model'] = nil,
            ['sit'] = vector4(116.74626, -1303.393, 28.273693, 32.705486),
            ['stand'] = vector4(116.29303, -1302.636, 28.269521, 207.09544),
        },
        {
            ['taken'] = 0,
            ['model'] = nil,
            ['sit'] = vector4(114.60829, -1304.639, 28.269498, 25.138725),
            ['stand'] = vector4(114.19611, -1303.985, 28.269498, 207.37702),
        },
        {
            ['taken'] = 0,
            ['model'] = nil,
            ['sit'] = vector4(112.82508, -1305.668, 28.2695, 30.056648),
            ['stand'] = vector4(112.34696, -1305.062, 28.269504, 202.59379),
        },
        {
            ['taken'] = 0,
            ['model'] = nil,
            ['sit'] = vector4(112.82508, -1305.668, 28.2695, 30.056648),
            ['stand'] = vector4(112.34696, -1305.062, 28.269504, 202.59379),
        },
    },
    ['peds'] = {
       'csb_stripper_01', -- White Stripper
	   's_f_y_stripperlite', -- Black Stripper
       'mp_f_stripperlite', -- Black Stripper
    }
}



Config.Vuur = {
	['Plek'] = { ['x'] = -168.07, ['y'] = -1662.8, ['z'] = 33.31 },
}
Config.Items = {
    label = "Vanilla Unicorn",
    slots = 2,
    items = {
        [1] = {
            name = "mojito",
            price = 10,
            amount = 125,
            info = {},
            type = "item",
            slot = 1,
		},
        [2] = {
            name = "whiskey",
            price = 11,
            amount = 125,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "tequila",
            price = 15,
            amount = 125,
            info = {},
            type = "item",
            slot = 3,
        },
    }
}


Config.DrankItems = {
    [1] = 'lemon',
    [2] = 'ice',
    [3] = 'vodka',
  }

Config.ItemsSigaretten = {
    label = "Sigaretten Machine",
    slots = 2,
    items = {
        [1] = {
            name = "sigaret",
            price = 5,
            amount = 85,
            info = {},
            type = "item",
            slot = 1,
		},
        [2] = {
            name = "condoom",
            price = 11,
            amount = 45,
            info = {},
            type = "item",
            slot = 2,
        },
    }
}


Config.BossItems = {
    label = "Vanilla Unicorn VIP",
    slots = 1,
    items = {
        [1] = {
            name = "mojito",
            price = 6,
            amount = 125,
            info = {},
            type = "item",
            slot = 1,
        },
    }
}