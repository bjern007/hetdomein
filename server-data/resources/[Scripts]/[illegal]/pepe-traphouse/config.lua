Config = Config or {}

Config.HasCodeSet = false

Config.IsSelling = false
Config.TrapHouse = {
    ['Code'] = 1234,
    ['Owner'] = '',
    ['Coords'] = {
        ['Enter'] = {
            ['X'] = -1025.71,
            ['Y'] = -2127.809,
            ['Z'] = 13.597284,
            ['H'] = 350.71,
            ['Z-OffSet'] = 35.0,
        },
        ['Interact'] = {
            -- ['X'] = 223.40,
            -- ['Y'] = -589.76,
            -- ['Z'] = 11.02,
            ['X'] = -1025.71,
            ['Y'] = -2127.809,
            ['Z'] = -20.0,
        },
    },
}

Config.SellItems = {
 ['diamond-blue'] = {
   ['Type'] = 'money',
   ['Amount'] = math.random(4500, 6500),
 },
 ['diamond-red'] = {
   ['Type'] = 'money',
   ['Amount'] = math.random(5500, 7500),
 },
 ['gold-bar'] = {
   ['Type'] = 'money',
   ['Amount'] = math.random(1000, 3000),
 },
}