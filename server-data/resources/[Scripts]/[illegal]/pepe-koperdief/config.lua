Config = Config or {}
Config.PoliceNeeded = 0
Config = Config or {}

Config.CurrentItems = {}

Config.SmeltTime = 20

Config.CanTake = false

Config.Smelting = false




Config.smelten = {
    ['Smeltery'] = {
        [1] = {['X'] = 1085.56, ['Y'] = -2002.05, ['Z'] = 31.4},
    },
}


Config.Locations = {
    ['Sell'] = {['X'] = 589.51, ['Y'] = -3270.06, ['Z'] = 6.07},
}


Config.PimpGuy = {
    { x= 593.07, y= -3263.99, z= 5.07, name = "Pimp", heading = 99.33, model = "s_m_y_garbage" },

}

Config.SellItems = {
 ['koperdraad'] = {
   ['Type'] = 'money',
   ['Amount'] = math.random(200, 320),
 },
}