Config = {}

Config['TrainHeist'] = {
    ['requiredPoliceCount'] = -0, -- required police count for start heist
    ['nextRob'] = 3600, -- seconds for next heist
    ['requiredItems'] = { -- add those to database or shared
        'kniptang',
        'duffel-bag'
    },
    ['reward'] = {
        itemName = 'gold-bar', -- gold item name
        grabCount = 5, -- gold grab count
        sellPrice = 1850 -- buyer sell price
    },
    ['startHeist'] ={ -- heist start coords
        pos = vector3(-687.82, -2417.1, 13.9445),
        peds = {
            {pos = vector3(-686.43, -2417.5, 13.8945), heading = 23.22, ped = 's_m_m_highsec_01'},
            {pos = vector3(-687.82, -2417.1, 13.8945), heading = 320.78, ped = 's_m_m_highsec_02'},
            {pos = vector3(-688.89, -2416.3, 13.8945), heading = 291.42, ped = 's_m_m_fiboffice_02'}
        }
    },
    ['guardPeds'] = { -- guard ped list (you can add new)
            { coords = vector3(2850.67, 4535.49, 45.3924), heading = 270.87, model = 's_m_y_blackops_01'},
            { coords = vector3(2856.28, 4544.12, 45.3354), heading = 177.93, model = 's_m_y_blackops_01'},
            { coords = vector3(2869.90, 4530.26, 47.7877), heading = 354.93, model = 's_m_y_blackops_01'},
            { coords = vector3(2859.08, 4519.85, 47.9145), heading = 177.88, model = 's_m_y_blackops_01'},
            -- { coords = vector3(2843.78, 4521.66, 47.4138), heading = 268.28, model = 's_m_y_blackops_01'},
            -- { coords = vector3(2856.90, 4526.85, 48.6552), heading = 268.3, model = 's_m_y_blackops_01'},
            -- { coords = vector3(2878.67, 4556.77, 48.4119), heading = 359.44, model = 's_m_y_blackops_01'},
            -- { coords = vector3(2886.69, 4556.21, 48.4262), heading = 265.05, model = 's_m_y_blackops_01'},
    },
    ['finishHeist'] = { -- finish heist coords
        buyerPos = vector3(-1690.6, -916.19, 6.78323)
    },
    ['setupTrain'] = { -- train and containers coords
        pos = vector3(2872.028, 4544.253, 47.758),
        part = vector3(2883.305, 4557.646, 47.758),
        heading = 140.0,
        ['containers'] = {
            {
                pos = vector3(2885.97, 4560.83, 48.0551), 
                heading = 320.0, 
                lock = {pos = vector3(2884.76, 4559.38, 49.22561), taken = false},
                table = vector3(2886.55, 4561.53, 48.23),
                golds = {
                    {pos = vector3(2886.05, 4561.93, 49.14), taken = false},
                    {pos = vector3(2887.05, 4561.13, 49.14), taken = false},
                } 
            },
            {
                pos = vector3(2880.97, 4554.83, 48.0551), 
                heading = 140.0, 
                lock = {pos = vector3(2882.15, 4556.26, 49.22561), taken = false},
                table = vector3(2880.45, 4554.23, 48.23),
                golds = {
                    {pos = vector3(2881.05, 4553.93, 49.14), taken = false},
                    {pos = vector3(2880.25, 4554.63, 49.14), taken = false},
                } 
            }
        }
    }
}

Strings = {
    ['start_heist'] = 'Druk ~INPUT_CONTEXT~ om een Train Heist te starten',
    ['cutting'] = 'Druk ~INPUT_CONTEXT~ om te knippen',
    ['grab'] = 'Druk ~INPUT_CONTEXT~ om te pakken',
    -- ['start_heist'] = 'Druk ~INPUT_CONTEXT~ to Start Train Heist',
    ['goto_ambush'] = 'Ga naar de Ambush locatie en vermoord de wachters. doorzoek de Merryweather containers en steel het goud.',
    ['wait_nextrob'] = 'You have to wait this long to undress again',
    ['minute'] = 'minute.',
    ['ambush_blip'] = 'Ambush punt',
    ['need_this'] = 'Je mist dit: ',
    ['deliver_to_buyer'] = 'Lever de spullen af check je gps.',
    ['buyer_blip'] = 'Koper',
    ['need_police'] = 'Niet genoeg agenten in de stad.',
    ['total_money'] = 'Je hebt dit als verdiensten gekregen: ',
    ['police_alert'] = 'Train robbery alert! Check your gps.',
}

--Dont change. Main and required things.
TrainAnimation = {
    ['objects'] = {
        'tr_prop_tr_grinder_01a',
        'ch_p_m_bag_var02_arm_s'
    },
    ['animations'] = {
        {'action', 'action_container', 'action_lock', 'action_angle_grinder', 'action_bag'}
    },
    ['scenes'] = {},
    ['sceneObjects'] = {}
}

GrabGold = {
    ['objects'] = {
        'hei_p_m_bag_var22_arm_s'
    },
    ['animations'] = {
        {'enter', 'enter_bag'},
        {'grab', 'grab_bag', 'grab_gold'},
        {'grab_idle', 'grab_idle_bag'},
        {'exit', 'exit_bag'},
    },
    ['scenes'] = {},
    ['scenesObjects'] = {}
}