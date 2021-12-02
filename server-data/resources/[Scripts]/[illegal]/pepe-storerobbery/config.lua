Config = Config or {}

Config.Inverval = 1000

Config.PoliceNeeded = 0

Config.ResetTime = ((1000 * 60) * 10)

Config.SpecialItems = {
   'blue-card', 
  --  'red-card', 
  --  'green-card', 
  --  'purple-card', 
}

Config.Registers = {
  [1] =  {['X'] = -47.24,   ['Y'] = -1757.65, ['Z'] = 29.53,   ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 1}, -- Davis Ave Grove St CAM#1
  [2] =  {['X'] = -48.58,   ['Y'] = -1759.21, ['Z'] = 29.59,   ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 1}, -- Davis Ave Grove St CAM#1
  [3] =  {['X'] = -1486.26, ['Y'] = -378.00,  ['Z'] = 40.16,   ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 2}, -- Prosperity St  CAM#1
  [4] =  {['X'] = -1222.03, ['Y'] = -908.32,  ['Z'] = 12.32,   ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 3}, -- Andreas Ave. CAM#1
  [5] =  {['X'] = -706.08,  ['Y'] = -915.42,  ['Z'] = 19.21,   ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 4}, -- Palomino Ave Ginger St CAM#1
  [6] =  {['X'] = -706.16,  ['Y'] = -913.50,  ['Z'] = 19.21,   ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 4}, -- Palomino Ave Ginger St CAM#1
  [7] =  {['X'] = 24.47,    ['Y'] = -1344.99, ['Z'] = 29.49,   ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 5}, -- Innocence Blvd Elgin Ave. CAM#1
  [8] =  {['X'] = 24.45,    ['Y'] = -1347.37, ['Z'] = 29.59,   ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 5}, -- Innocence Blvd Elgin Ave. CAM#1
  [9] =  {['X'] = 1134.15,  ['Y'] = -982.53,  ['Z'] = 46.41,   ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 7}, -- Rancho Blvd Vespucci Blvd. CAM#1
  [10] = {['X'] = 1165.05,  ['Y'] = -324.49,  ['Z'] = 69.2,    ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 8}, -- Mirror Park Blvd CAM#1
  [11] = {['X'] = 1164.7,   ['Y'] = -322.58,  ['Z'] = 69.2,    ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 8}, -- Mirror Park Blvd CAM#1
  [12] = {['X'] = 373.14,   ['Y'] = 328.62,   ['Z'] = 103.56,  ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 9}, -- Clinton Ave CAM#1
  [13] = {['X'] = 372.57,   ['Y'] = 326.42,   ['Z'] = 103.56,  ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 9}, -- Clinton Ave CAM#1
  [14] = {['X'] = -1818.9,  ['Y'] = 792.9,    ['Z'] = 138.08,  ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 11}, -- Banham Canyon Dr CAM#1
  [15] = {['X'] = -1820.17, ['Y'] = 794.28,   ['Z'] = 138.08,  ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 11}, -- Banham Canyon Dr CAM#1
  [16] = {['X'] = -2966.46, ['Y'] = 390.89,   ['Z'] = 15.04,   ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 12}, -- Great Ocean Hwy CAM#1
  [17] = {['X'] = -3041.14, ['Y'] = 583.87,   ['Z'] = 7.9,     ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 13}, -- Ineseno Road CAM#1
  [18] = {['X'] = -3038.92, ['Y'] = 584.5,    ['Z'] = 7.9,     ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 13}, -- Ineseno Road CAM#1
  [19] = {['X'] = -3244.56, ['Y'] = 1000.14,  ['Z'] = 12.83,   ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 15}, -- Barbareno Rd. CAM#1
  [20] = {['X'] = -3242.24, ['Y'] = 999.98,   ['Z'] = 12.83,   ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 15}, -- Barbareno Rd. CAM#1
  [21] = {['X'] = 549.42,   ['Y'] = 2669.06,  ['Z'] = 42.15,   ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 17}, -- Route 68 Winkel CAM#1
  [22] = {['X'] = 549.05,   ['Y'] = 2671.39,  ['Z'] = 42.15,   ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 17}, -- Route 68 Winkel CAM#1
  [23] = {['X'] = 1165.9,   ['Y'] = 2710.81,  ['Z'] = 38.15,   ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 19}, -- Route 68 slijter CAM#1
  [24] = {['X'] = 2676.02,  ['Y'] = 3280.52,  ['Z'] = 55.24,   ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 20}, -- Senora Fwy CAM#1
  [25] = {['X'] = 2678.07,  ['Y'] = 3279.39,  ['Z'] = 55.24,   ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 20}, -- Senora Fwy CAM#1
  [26] = {['X'] = 1958.96,  ['Y'] = 3741.98,  ['Z'] = 32.34,   ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 22}, --Alhambra Dr. CAM#1
  [27] = {['X'] = 1960.13,  ['Y'] = 3740.0,   ['Z'] = 32.34,   ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 22}, -- Alhambra Dr. CAM#1
  [28] = {['X'] = 1728.86,  ['Y'] = 6417.26,  ['Z'] = 35.03,   ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 24}, -- Great Ocean Hwy Paleto CAM#1
  [29] = {['X'] = 1727.85,  ['Y'] = 6415.14,  ['Z'] = 35.03,   ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 24}, -- Great Ocean Hwy Paleto CAM#1
  [30] = {['X'] = -161.07,  ['Y'] = 6321.23,  ['Z'] = 31.5,    ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 26}, -- Pyrite Ave Paleto Blvd
  [31] = {['X'] = 160.52,   ['Y'] = 6641.74,  ['Z'] = 31.6,    ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 27}, -- Paleto Bay CAM#1
  [32] = {['X'] = 162.16,   ['Y'] = 6643.22,  ['Z'] = 31.6,    ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 27}, -- Paleto Bay CAM#1
  [33] = {['X'] = 1696.63,  ['Y'] = 4923.93,  ['Z'] = 42.06,   ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 29}, -- Grapeseed Mainstreet Cam#1
  [34] = {['X'] = 1698.10,  ['Y'] = 4922.83,  ['Z'] = 42.06,   ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 29}, -- Grapeseed Mainstreet Cam#1
  [35] = {['X'] = 2557.13,  ['Y'] = 380.84,   ['Z'] = 108.62,  ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 30}, -- Palomino Freeway CAM#1
  [36] = {['X'] = 2554.84,  ['Y'] = 380.88,   ['Z'] = 108.62,  ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 30}, -- Palomino Freeway CAM#1
  [37] = {['X'] = 1334.5541,  ['Y'] = -1651.897,   ['Z'] = 52.24905, ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 30}, -- Lab
  [38] = {['X'] = 73.885017,  ['Y'] = -1392.123,   ['Z'] = 29.376127, ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 30}, -- Kledingwinkel 1
  [39] = {['X'] = 74.875312,  ['Y'] = -1387.689,   ['Z'] = 29.376125, ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 30}, -- Kledingwinkel 2
  [40] = {['X'] = 78.089317,  ['Y'] = -1387.691,   ['Z'] = 29.376125, ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 30}, -- Kledingwinkel 3
  [41] = {['X'] = 78.089317,  ['Y'] = -1387.691,   ['Z'] = 29.376125, ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 30}, -- Kledingwinkel 3
  [40] = {['X'] = 422.86386,  ['Y'] = -811.4902,   ['Z'] = 29.491125, ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 30}, -- Kledingwinkel 4
  [41] = {['X'] = 426.03799,  ['Y'] = -811.4564,   ['Z'] = 29.376125, ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 30}, -- Kledingwinkel 5
  [42] = {['X'] = 426.9909,  ['Y'] = -807.021,   ['Z'] = 29.491123, ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 30}, -- Kledingwinkel 6
  [43] = {['X'] = -822.491,  ['Y'] = -1071.981,   ['Z'] = 11.32811, ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 30}, -- Kledingwinkel 7
  [44] = {['X'] = -818.1769,  ['Y'] = -1070.431,   ['Z'] = 11.327926, ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 30}, -- Kledingwinkel 8
  [45] = {['X'] = -816.4123,  ['Y'] = -1073.236,   ['Z'] = 11.328101, ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 30}, -- Kledingwinkel 9
  [46] = {['X'] = -709.2186,  ['Y'] = -151.3658,   ['Z'] = 37.415142, ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 30}, -- Kledingwinkel 10
  [47] = {['X'] = -165.1135,  ['Y'] = -303.4886,   ['Z'] = 39.73328, ['Robbed'] = false, ['Busy'] = false, ['Time'] = 0, ['SafeKey'] = 30}, -- Kledingwinkel 11
}

Config.Safes = {
  [1] =  {['X'] = -43.43,    ['Y'] = -1748.3,  ['Z'] = 29.42,   ['Robbed'] = false, ['Busy'] = false}, -- Davis Ave Grove St CAM#1
  [2] =  {['X'] = -1478.94,  ['Y'] = -375.5,   ['Z'] = 39.16,   ['Robbed'] = false, ['Busy'] = false}, -- Prosperity St  CAM#1
  [3] =  {['X'] = -1220.85,  ['Y'] = -916.05,  ['Z'] = 11.32,   ['Robbed'] = false, ['Busy'] = false}, -- Andreas Ave. CAM#1
  [4] =  {['X'] = -709.74,   ['Y'] = -904.15,  ['Z'] = 19.21,   ['Robbed'] = false, ['Busy'] = false}, -- Palomino Ave Ginger St CAM#1
  [6] =  {['X'] = 28.21,     ['Y'] = -1339.14, ['Z'] = 29.49,   ['Robbed'] = false, ['Busy'] = false}, --Innocence Blvd Elgin Ave. CAM#2
  [7] =  {['X'] = 1126.77,   ['Y'] = -980.1,   ['Z'] = 45.41,   ['Robbed'] = false, ['Busy'] = false}, -- Rancho Blvd Vespucci Blvd. CAM#1
  [8] =  {['X'] = 1159.46,   ['Y'] = -314.05,  ['Z'] = 69.2,    ['Robbed'] = false, ['Busy'] = false}, -- Mirror Park Blvd CAM#1
  [10] = {['X'] = 378.17,    ['Y'] = 333.44,   ['Z'] = 103.56,  ['Robbed'] = false, ['Busy'] = false}, -- Clinton Ave CAM#2
  [11] = {['X'] = -1829.27,  ['Y'] = 798.76,   ['Z'] = 138.19,  ['Robbed'] = false, ['Busy'] = false}, -- Banham Canyon Dr CAM#1
  [12] = {['X'] = -2959.64,  ['Y'] = 387.08,   ['Z'] = 14.04,   ['Robbed'] = false, ['Busy'] = false}, -- Great Ocean Hwy CAM#1
  [14] = {['X'] = -3047.88,  ['Y'] = 585.61,   ['Z'] = 7.9,     ['Robbed'] = false, ['Busy'] = false}, -- Ineseno Road CAM#2
  [16] = {['X'] = -3250.02,  ['Y'] = 1004.43,  ['Z'] = 12.83,   ['Robbed'] = false, ['Busy'] = false}, -- Barbareno Rd. CAM#2
  [18] = {['X'] = 546.41,    ['Y'] = 2662.8,   ['Z'] = 42.15,   ['Robbed'] = false, ['Busy'] = false}, -- Route 68 Winkel CAM#2
  [19] = {['X'] = 1169.31,   ['Y'] = 2717.79,  ['Z'] = 37.15,   ['Robbed'] = false, ['Busy'] = false}, -- Route 68 Slijter CAM#1
  [21] = {['X'] = 2672.69,   ['Y'] = 3286.63,  ['Z'] = 55.24,   ['Robbed'] = false, ['Busy'] = false}, -- Senora Fwy CAM#2
  [23] = {['X'] = 1959.26,   ['Y'] = 3748.92,  ['Z'] = 32.34,   ['Robbed'] = false, ['Busy'] = false}, --Alhambra Dr. CAM#2
  [25] = {['X'] = 1734.78,   ['Y'] = 6420.84,  ['Z'] = 35.03,   ['Robbed'] = false, ['Busy'] = false}, -- Great Ocean Hwy Paleto CAM#2
  [26] = {['X'] = -168.40,   ['Y'] = 6318.80,  ['Z'] = 30.58,   ['Robbed'] = false, ['Busy'] = false}, --  Pyrite Ave Paleto Blvd
  [28] = {['X'] = 168.95,    ['Y'] = 6644.74,  ['Z'] = 31.70,   ['Robbed'] = false, ['Busy'] = false}, -- Paleto Bay CAM#2
  [29] = {['X'] = 1707.88,   ['Y'] = 4920.41,  ['Z'] = 42.06,   ['Robbed'] = false, ['Busy'] = false}, -- Grapeseed Mainstreet Cam#1
  [31] = {['X'] = 2549.19,   ['Y'] = 384.90,   ['Z'] = 108.62,  ['Robbed'] = false, ['Busy'] = false}, -- Palomino Freeway CAM#2
  [32] = {['X'] = 1334.6182,   ['Y'] = -1654.753,   ['Z'] = 52.249084,  ['Robbed'] = false, ['Busy'] = false}, -- Lab
}

Config.MaleNoHandshoes = {
  [0] = true,
  [1] = true,
  [2] = true,
  [3] = true,
  [4] = true,
  [5] = true,
  [6] = true,
  [7] = true,
  [8] = true,
  [9] = true,
  [10] = true,
  [11] = true,
  [12] = true,
  [13] = true,
  [14] = true,
  [15] = true,
  [18] = true,
  [118] = true,
}

Config.FemaleNoHandshoes = {
  [0] = true,
  [1] = true,
  [2] = true,
  [3] = true,
  [4] = true,
  [5] = true,
  [6] = true,
  [7] = true,
  [8] = true,
  [9] = true,
  [10] = true,
  [11] = true,
  [12] = true,
  [13] = true,
  [14] = true,
  [20] = true,
  [129] = true,
  [130] = true,
  [131] = true,
  [153] = true,
  [161] = true,
}