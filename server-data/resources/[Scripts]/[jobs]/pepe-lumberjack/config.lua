Config = {}

Config = {
    -- Lumberjack Job
    Prices = {
        ['wood_proc'] = {30, 50}
    },
    ChanceToGetItem = 20, -- if math.random(0, 100) <= ChanceToGetItem then give item
    Items = {'wood_cut','wood_cut','wood_cut','wood_cut','wood_cut'},
    Sell = vector3(1210.0, -1318.51, 35.23),
    Process = vector3(-584.66, 5285.63, 70.26),
    Cars = vector3(1204.48, -1265.63, 35.23),
    delVeh = vector3(1187.84, -1286.76, 34.95),
    Objects = {
        ['pickaxe'] = 'w_me_hatchet',
    },
    WoodPosition = {
        {coords = vector3(-493.0, 5395.37, 77.18-0.97), heading = 282.49},
        {coords = vector3(-503.69, 5392.12, 75.98-0.97), heading = 113.62},
        {coords = vector3(-456.85, 5397.37, 79.49-0.97), heading = 29.92},
        {coords = vector3(-457.42, 5409.05, 78.78-0.97), heading = 209.65}
    },
   
}

Config.textDel = '~g~[E]~w~ Houthakken'
Config.canve = '~g~[E]~w~ Parkeerplaats'
Config.textgar = '~g~[E]~w~ Voertuig '
Config.ModelCar = 'rumpo'

overpoweredvehicle = {}
overpoweredvehicle.SpawnVehicle = {
    x = 1205.31, 
    y = -1288.06, 
    z = 35.23, 
    h = 250.0,
}
Strings = {
    ['wood_info'] = 'Druk op ~INPUT_ATTACK~ om te hakken, ~INPUT_FRONTEND_RIGHT~ om te stoppen.',
    ['you_sold'] = 'Je hebt %sx %s verkocht voor €%s',
    ['e_sell'] = 'Druk op ~INPUT_CONTEXT~ om goederen te verkopen',
    ['someone_close'] = 'Er is nog een burger in de buurt!',
    ['wood'] = 'Houthak locatie',
    ['process'] = 'Houtverwerking',
    ['autotru'] = 'Houthakker voertuig',
    ['sell_wood'] = 'Verkoop hout',
    ['hevpark'] = 'Parking',
}