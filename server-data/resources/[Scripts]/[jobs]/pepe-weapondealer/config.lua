Config = Config or {}

Config.Locations = {
    ['stash'] = { ['x'] = -57.90592, ['y'] = 981.89343, ['z'] = 234.57723, ['h'] = 202.22789 },
    ['shop'] = { ['x'] = -60.31894, ['y'] = 981.64099, ['z'] = 234.57734, ['h'] = 23.484317 }
}

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

Config.Items = {
    label = "Ilse Gang",
    slots = 1,
    items = {
        [1] = {
            name = "weapon_appistol",
            price = 5000,
            amount = 5,
            info = {
                quality = 100,
            },
            type = "weapon",
            slot = 1,
        },
        [2] = {
            name = "weapon_snspistol_mk2",
            price = 0,
            amount = 5,
            info = {
                quality = 100
            },
            type = "weapon",
            slot = 2,
        },
        [3] = {
            name = "weapon_sawnoffshotgun",
            price = 0,
            amount = 5,
            info = {
                quality = 100
            },
            type = "weapon",
            slot = 3,
        },
        [4] = {
            name = "handcuffs",
            price = 0,
            amount = 300,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "heavyarmor",
            price = 10,
            amount = 150,
            info = {},
            type = "item",
            slot = 5,
        },
        [6] = {
            name = "radio",
            price = 0,
            amount = 350,
            info = {},
            type = "item",
            slot = 6,
        },
        [7] = {
            name = "pistol-ammo",
            price = 0,
            amount = 900,
            info = {},
            type = "item",
           slot = 7,
        },    
        [8] = {
            name = "smg-ammo",
            price = 10,
            amount = 0,
            info = {},
            type = "item",
           	slot = 8,
        },
        [9] = {
            name = "rifle-ammo",
            price = 10,
            amount = 0,
            info = {},
            type = "item",
            slot = 9,
        },
        [10] = {
            name = "shotgun-ammo",
            price = 10,
            amount = 0,
            info = {},
            type = "item",
            slot = 10,
        },
    }
}