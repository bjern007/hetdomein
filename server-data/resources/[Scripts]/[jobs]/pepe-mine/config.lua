Config = {
    pricexd = {
        -- ['item'] = {min, max} --
        steel = math.random(10, 40),
        iron = math.random(10, 60),
        -- copper = math.random(30, 160),
        diamond = math.random(10, 190),
        emerald = math.random(10, 110)
    },
    ChanceToGetItem = 30, -- if math.random(0, 100) <= ChanceToGetItem then give item
    Items = {'steel','steel','steel','steel', 'copper', 'copper', 'diamond', 'emerald'},
    Sell = vector3(-97.12, -1013.8, 26.3),
    Objects = {
        ['pickaxe'] = 'prop_tool_pickaxe',
    },
    MiningPositions = {
        {coords = vector3(2992.77, 2750.64, 42.78), heading = 209.29},
        {coords = vector3(2983.03, 2750.9, 42.02), heading = 214.08},
        {coords = vector3(2976.74, 2740.94, 43.63), heading = 246.21},
        {coords = vector3(2934.265, 2742.695, 43.1), heading = 96.1},
        {coords = vector3(2907.25, 2788.27, 45.4), heading = 109.39}
    },
}

Strings = {
    ['press_mine'] = 'Druk op ~INPUT_CONTEXT~ om te mijnen.',
    ['mining_info'] = 'Druk op ~INPUT_ATTACK~ om te hacken, ~INPUT_FRONTEND_RRIGHT~ om te stoppen.',
    ['you_sold'] = 'Je hebt %sx %s voor €%s verkocht',
    ['e_sell'] = 'Druk op ~INPUT_CONTEXT~ om materialen uit de mijn te verkopen.',
    ['someone_close'] = 'Burger te dichtbij!',
    ['mining'] = 'Mijnen',
    ['sell_mine'] = 'Mijnen verkoop'
}