Config = Config or {}

Config.TrunkData = {}

Config.ObjectOptions = {
    [GetHashKey('prop_atm_01')] = {
        [1] = {
            ['Name'] = 'ATM',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="far fa-credit-card"></i>',
            ['EventName'] = 'pepe-banking:client:open:atm',
        },
    },
    [GetHashKey('S_M_Y_Doorman_01')] = {
        [1] = {
            ['Name'] = 'Paardenrace',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-coins"></i>',
            ['EventName'] = 'chCasinoWall:openbethorses',
        },
    },
    [GetHashKey('vw_prop_vw_luckywheel_02a')] = {
        [1] = {
            ['Name'] = 'Test je geluk',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-sync-alt"></i>',
            ['EventName'] = 'luckywheel:client:startWheel',
        },
    },
    [GetHashKey('prop_beach_bag_01b')] = {
        [1] = {
            ['Name'] = 'Zoeken',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="far fa-credit-card"></i>',
            ['EventName'] = 'pepe-eye:client:start:zoeken:strand',
        },
    },
    [GetHashKey('prop_atm_02')] = {
        [1] = {
            ['Name'] = 'ATM',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="far fa-credit-card"></i>',
            ['EventName'] = 'pepe-banking:client:open:atm',
        },
    },
    -- Koffie
    [GetHashKey('prop_vend_coffe_01')] = {
        [1] = {
            ['Name'] = 'Koffie Machine',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-coffee"></i>',
            ['EventName'] = 'pepe-stores:client:open:custom:store',
            ['EventParameter'] = 'Coffee',
        },
    },
    -- Vending
    [GetHashKey('prop_vend_snak_01')] = {
        [1] = {
            ['Name'] = 'Snoep Machine',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-candy-cane"></i>',
            ['EventName'] = 'pepe-stores:client:open:custom:store',
            ['EventParameter'] = 'Vending',
        },
    },
    [GetHashKey('prop_parknmeter_02')] = {
        [1] = {
            ['Name'] = 'Openbreken',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="far fa-credit-card"></i>',
            ['EventName'] = 'pepe-parkmeter:client:open',
        },
    },
    [GetHashKey('prop_arcade_01')] = {
        [1] = {
            ['Name'] = 'Memory',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="far fa-credit-card"></i>',
            ['EventName'] = 'pepe-eye:client:open:memory',
        },
        [2] = {
            ['Name'] = 'Optellen',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="far fa-credit-card"></i>',
            ['EventName'] = 'pepe-eye:client:open:optellen',
        },
    },
    [GetHashKey('prop_parknmeter_01')] = {
        [1] = {
            ['Name'] = 'Openbreken',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="far fa-credit-card"></i>',
            ['EventName'] = 'pepe-parkmeter:client:open',
        },
    },
    [GetHashKey('prop_atm_03')] = {
        [1] = {
            ['Name'] = 'ATM',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="far fa-credit-card"></i>',
            ['EventName'] = 'pepe-banking:client:open:atm',
        },
    },
    [GetHashKey('prop_fleeca_atm')] = {
        [1] = {
            ['Name'] = 'ATM',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="far fa-credit-card"></i>',
            ['EventName'] = 'pepe-banking:client:open:atm',
        },
    },
    [GetHashKey('v_ind_cs_bucket')] = {
        ['Job'] = 'police',
        [1] = {
            ['Name'] = 'In / Uit Dienst',
            ['EventType'] = 'Server',
            ['Logo'] = '<i class="fas fa-user-clock"></i>',
            ['EventName'] = 'Framework:ToggleDuty',
        },
    },
    [GetHashKey('vw_prop_casino_roulette_01')] = {
        [1] = {
            ['Name'] = 'Play',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = 'route68_ruletka:start',
        },
    },
    [GetHashKey('prop_beach_bag_01b')] = {
        [1] = {
            ['Name'] = 'Openmaken',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = '',
        },
    },
    [GetHashKey('p_amb_clipboard_01')] = {
        ['Job'] = 'ambulance',
        [1] = {
            ['Name'] = 'In / Uit Dienst',
            ['EventType'] = 'Server',
            ['Logo'] = '<i class="fas fa-bell"></i>',
            ['EventName'] = 'Framework:ToggleDuty',
        },
    },
    [789652940] = {
        ['Job'] = 'ambulance',
        [1] = {
            ['Name'] = 'Baas Menu',
            ['EventType'] = 'Server',
            ['Logo'] = '<i class="fas fa-bell"></i>',
            ['EventName'] = 'pepe-bossmenu:server:openMenu',
        },
    },
    -- Police
    [GetHashKey('p_cs_laptop_02_w')] = {
        ['Job'] = 'police',
        [1] = {
            ['Name'] = 'Baas Menu',
            ['EventType'] = 'Server',
            ['Logo'] = '<i class="fas fa-bell"></i>',
            ['EventName'] = 'pepe-bossmenu:server:openMenu',
        },
    },
    -- [GetHashKey('prop_till_01')] = {
    --     [1] = {
    --         ['Name'] = 'Winkel',
    --         ['EventType'] = 'Client',
    --         ['Logo'] = '<i class="fas fa-shopping-basket"></i>',
    --         ['EventName'] = 'pepe-stores:server:open:shop',
    --     },
    -- },
    -- [GetHashKey('prop_till_02')] = {
    --     [1] = {
    --         ['Name'] = 'Winkel',
    --         ['EventType'] = 'Client',
    --         ['Logo'] = '<i class="fas fa-shopping-basket"></i>',
    --         ['EventName'] = 'pepe-stores:server:open:shop',
    --     },
    -- },
    [1746653202] = {
        [1] = {
            ['Name'] = 'Praat met persoon',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = 'pepe-illegal:client:talk:to:npc',
        },
    },
    [2023152276] = {
        [1] = {
            ['Name'] = 'Praat met persoon',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = 'pepe-illegal:client:talk:to:npc',
        },
    },
    [-306958529] = {
        [1] = {
            ['Name'] = 'Praat met persoon',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = 'pepe-illegal:client:talk:to:npc',
        },
    },
    [GetHashKey('cs_old_man1a')] = {
        [1] = {
            ['Name'] = 'Locksmith',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-key"></i>',
            ['EventName'] = 'pepe-illegal:client:talk:to:npc',
        },
    },
    [GetHashKey('s_m_m_gardener_01')] = {
        [1] = {
            ['Name'] = 'Tool Shop',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-tools"></i>',
            ['EventName'] = 'pepe-illegal:client:talk:to:npc',
        },
    },
    [GetHashKey('a_f_m_prolhost_01')] = {
        [1] = {
            ['Name'] = 'Fishing Shop',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-fish"></i>',
            ['EventName'] = 'pepe-illegal:client:talk:to:npc',
        },
    },
    [GetHashKey('s_m_y_ammucity_01')] = {
        [1] = {
            ['Name'] = 'Start Hunten',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-play-circle"></i>',
            ['EventName'] = 'pepe-hunting:client:sync:start',
        },
        [2] = {
            ['Name'] = 'Stop Hunten',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-stop-circle"></i>',
            ['EventName'] = 'pepe-hunting:client:sync:stop',
        },
        [3] = {
            ['Name'] = 'Verkoop Goederen',
            ['EventType'] = 'Server',
            ['Logo'] = '<i class="fas fa-wallet"></i>',
            ['EventName'] = 'pepe-hunt:sell',
        },
    },
    [GetHashKey('cs_beverly')] = {
        [1] = {
            ['Name'] = 'Praten',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = 'pepe-illegal:client:talk:to:npc',
        },
    },
    -- Koffie
    [GetHashKey('prop_vend_coffe_01')] = {
        [1] = {
            ['Name'] = 'Koffie Machine',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-coffee"></i>',
            ['EventName'] = 'pepe-stores:client:open:custom:store',
            ['EventParameter'] = 'Coffee',
        },
    },
    -- Vending
    [GetHashKey('prop_vend_snak_01')] = {
        [1] = {
            ['Name'] = 'Snoep Machine',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-candy-cane"></i>',
            ['EventName'] = 'pepe-stores:client:open:custom:store',
            ['EventParameter'] = 'Vending',
        },
    },
    -- -- Winkel
    -- [GetHashKey('prop_till_03')] = {
    --     [1] = {
    --         ['Name'] = 'Shop',
    --         ['EventType'] = 'Client',
    --         ['Logo'] = '<i class="fas fa-shopping-basket"></i>',
    --         ['EventName'] = 'pepe-stores:server:open:shop',
    --     },
    -- },
    -- Dumpsters
    [GetHashKey('prop_cs_dumpster_01a')] = {
        [1] = {
            ['Name'] = 'Zoeken',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-dumpster"></i>',
            ['EventName'] = 'pepe-materials:client:search:trash',
        },
    },
    [GetHashKey('prop_dumpster_02a')] = {
        [1] = {
            ['Name'] = 'Zoeken',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-dumpster"></i>',
            ['EventName'] = 'pepe-materials:client:search:trash',
        },
    },
    [GetHashKey('prop_dumpster_01a')] = {
        [1] = {
            ['Name'] = 'Zoeken',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-dumpster"></i>',
            ['EventName'] = 'pepe-materials:client:search:trash',
        },
    },
    [GetHashKey('prop_dumpster_02b')] = {
        [1] = {
            ['Name'] = 'Zoeken',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-dumpster"></i>',
            ['EventName'] = 'pepe-materials:client:search:trash',
        },
    },
    [GetHashKey('prop_dumpster_4b')] = {
        [1] = {
            ['Name'] = 'Zoeken',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-dumpster"></i>',
            ['EventName'] = 'pepe-materials:client:search:trash',
        },
    },
    [GetHashKey('prop_dumpster_3a')] = {
        [1] = {
            ['Name'] = 'Zoeken',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-dumpster"></i>',
            ['EventName'] = 'pepe-materials:client:search:trash',
        },
    },
    [GetHashKey('prop_sign_road_01a')] = {
        [1] = {
            ['Name'] = 'Stelen',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-dumpster"></i>',
            ['EventName'] = 'stopsign:client:Target',
        },
   },
   [GetHashKey('prop_sign_road_05a')] = {
       [1] = {
           ['Name'] = 'Stelen',
           ['EventType'] = 'Client',
           ['Logo'] = '<i class="fas fa-dumpster"></i>',
           ['EventName'] = 'stopsign:client:Target',
       },
  },
    [GetHashKey('prop_bin_05a')] = {
        [1] = {
            ['Name'] = 'Zoeken',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-dumpster"></i>',
            ['EventName'] = 'pepe-materials:client:search:trash',
        },
   },
   [GetHashKey('prop_printer_02')] = {
       [1] = {
           ['Name'] = 'Printen',
           ['EventType'] = 'Client',
           ['Logo'] = '<i class="fas fa-dumpster"></i>',
           ['EventName'] = 'pepe-printer:client:oogie',
       },
  },
  [GetHashKey('prop_printer_01')] = {
      [1] = {
          ['Name'] = 'Printen',
          ['EventType'] = 'Client',
          ['Logo'] = '<i class="fas fa-dumpster"></i>',
          ['EventName'] = 'pepe-printer:client:oogie',
      },
 },
   -- Mechanic
	[GetHashKey('prop_mouse_01')] = {
        ['Job'] = 'mechanic',
        ['UseDuty'] = true,
		[1] = {
            ['Name'] = 'Baas menu',
            ['EventType'] = 'Server',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = 'pepe-bossmenu:server:openMenu',
        },
    },
	[GetHashKey('prop_paper_box_05')] = {
        ['Job'] = 'mechanic',
        ['UseDuty'] = true,
		[1] = {
            ['Name'] = 'Pak doekjes',
            ['EventType'] = 'Server',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = 'pepe-mechanicjob:server:stash:doekjes',
        },
    },
	[GetHashKey('prop_toolchest_01')] = {
        ['Job'] = 'mechanic',
        ['UseDuty'] = true,
		[1] = {
            ['Name'] = 'Onderdelen',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = 'pepe-mechanicjob:client:stash:open',
        },
    },
	[GetHashKey('prop_big_bag_01')] = {
        ['Job'] = 'mechanic',
        ['UseDuty'] = true,
		[1] = {
            ['Name'] = 'Kleren',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = 'fivem-appearance:outfitsMenu',
        },
    },
    -- BurgerShot
    [GetHashKey('v_ind_bin_01')] = {
        [1] = {
            ['Job'] = 'burger',
            ['UseDuty'] = true,
            ['Name'] = 'Kassa',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-coins"></i>',
            ['EventName'] = 'pepe-burgershot:client:open:register',
        },
        [2] = {
            ['Name'] = 'Betalen',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-coins"></i>',
            ['EventName'] = 'pepe-burgershot:client:open:payment',
        },
    },
    [GetHashKey('prop_food_bs_tray_01')] = {
        [1] = {
            ['Name'] = 'Dienblad',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-utensils"></i>',
            ['EventName'] = 'pepe-burgershot:client:open:tray',
            ['EventParameter'] = 1,
        },
    },
    [GetHashKey('prop_food_bs_tray_02')] = {
        [1] = {
            ['Name'] = 'Dienblad',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-utensils"></i>',
            ['EventName'] = 'pepe-burgershot:client:open:tray',
            ['EventParameter'] = 2,
        },
    },
    [GetHashKey('v_ind_cf_chickfeed')] = {
        ['Job'] = 'burger',
        ['UseDuty'] = true,
        [1] = {
            ['Name'] = 'Warmhouden',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-hamburger"></i>',
            ['EventName'] = 'pepe-burgershot:client:open:hot:storage',
        },
    },
    [GetHashKey('v_ret_gc_bag01')] = {
        ['Job'] = 'burger',
        ['UseDuty'] = true,
        [1] = {
            ['Name'] = 'Bak Vlees',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-drumstick-bite"></i>',
            ['EventName'] = 'pepe-burgershot:client:bake:meat',
        },
    },
    [GetHashKey('v_ret_gc_bag02')] = {
        ['Job'] = 'burger',
        ['UseDuty'] = true,
        [1] = {
            ['Name'] = 'Bak Patat',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-drumstick-bite"></i>',
            ['EventName'] = 'pepe-burgershot:client:bake:fries',
        },
    },
    [GetHashKey('v_ilev_fib_frame03')] = {
        ['Job'] = 'burger',
        ['UseDuty'] = true,
        [1] = {
            ['Name'] = 'Koelkast',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-boxes"></i>',
            ['EventName'] = 'pepe-burgershot:client:open:cold:storage',
        },
    },
    [GetHashKey('v_ilev_fib_frame02')] = {
        ['Job'] = 'burger',
        ['UseDuty'] = true,
        [1] = {
            ['Name'] = 'Maak Soda',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-wine-bottle"></i>',
            ['EventName'] = 'pepe-burgershot:client:create:drink',
            ['EventParameter'] = 'burger-softdrink',
        },
        [2] = {
            ['Name'] = 'Maak Koffie',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-wine-bottle"></i>',
            ['EventName'] = 'pepe-burgershot:client:create:drink',
            ['EventParameter'] = 'burger-coffee',
        },
    },
    [GetHashKey('v_ilev_m_sofacushion')] = {
        ['Job'] = 'burger',
        [1] = {
            ['Name'] = 'In / Out Duty',
            ['EventType'] = 'Server',
            ['Logo'] = '<i class="fas fa-user-clock"></i>',
            ['EventName'] = 'Framework:ToggleDuty',
        },
    },
    [GetHashKey('h4_prop_battle_bar_fridge_02')] = {
        ['Job'] = 'burger',
        ['UseDuty'] = true,
        [1] = {
            ['Name'] = 'Bereid Bleeder',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-hamburger"></i>',
            ['EventName'] = 'pepe-burgershot:client:create:burger',
            ['EventParameter'] = 'burger-bleeder',
        },
        [2] = {
            ['Name'] = 'Bereid Heartstopper',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-hamburger"></i>',
            ['EventName'] = 'pepe-burgershot:client:create:burger',
            ['EventParameter'] = 'burger-heartstopper',
        },
        [3] = {
            ['Name'] = 'Bereid Moneyshot',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-hamburger"></i>',
            ['EventName'] = 'pepe-burgershot:client:create:burger',
            ['EventParameter'] = 'burger-moneyshot',
        },
        [4] = {
            ['Name'] = 'Bereid Torpedo',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-hamburger"></i>',
            ['EventName'] = 'pepe-burgershot:client:create:burger',
            ['EventParameter'] = 'burger-torpedo',
        },
    },
    --Stripclub
    [GetHashKey('ch_prop_casino_till_01a')] = {
     [1] = {
         ['Job'] = 'vanilla',
         ['UseDuty'] = true,
         ['Name'] = 'Kassa',
         ['EventType'] = 'Client',
         ['Logo'] = '<i class="fas fa-coins"></i>',
         ['EventName'] = 'pepe-stripclub:client:open:register',
     },
     [2] = {
         ['Name'] = 'Betalen',
         ['EventType'] = 'Client',
         ['Logo'] = '<i class="fas fa-coins"></i>',
         ['EventName'] = 'pepe-stripclub:client:open:payment',
     },
    },
    [GetHashKey('ba_prop_battle_club_computer_02')] = {
        [1] = {
            ['Job'] = 'vanilla',
            ['UseDuty'] = true,
            ['Name'] = 'Baas Menu',
            ['EventType'] = 'Server',
            ['Logo'] = '<i class="fas fa-utensils"></i>',
            ['EventName'] = 'pepe-bossmenu:server:openMenu',
            ['EventParameter'] = 1,
        },
    },
    [GetHashKey('v_ret_ml_beerbla1')] = {
        [1] = {
            ['Job'] = 'vanilla',
            ['UseDuty'] = true,
            ['Name'] = 'Opslag',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-utensils"></i>',
            ['EventName'] = 'pepe-stripclub:client:open:opslag',
            ['EventParameter'] = 1,
        },
    },
    [GetHashKey('vw_prop_casino_champset')] = {
        [1] = {
            ['Name'] = 'Pak Bestelling',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-utensils"></i>',
            ['EventName'] = 'pepe-stripclub:client:open:tray',
            ['EventParameter'] = 1,
        },
    },
    [GetHashKey('ba_prop_battle_dj_deck_01a')] = {
        ['Job'] = 'vanilla',
        [1] = {
            ['Name'] = 'Gebruiken',
            ['EventType'] = 'Server',
            ['Logo'] = '<i class="fas fa-user-clock"></i>',
            ['EventName'] = 'cs-hall:integration:toggleControllerInterface',
            ['EventParameter'] = currentAreaKey,
        },
    },   
    [GetHashKey('ba_prop_battle_dj_mixer_01a')] = {
        ['Job'] = 'vanilla',
        [1] = {
            ['Name'] = 'Gebruiken',
            ['EventType'] = 'Server',
            ['Logo'] = '<i class="fas fa-user-clock"></i>',
            ['EventName'] = 'cs-hall:integration:toggleControllerInterface',
            ['EventParameter'] = currentAreaKey,
        },
    },    
    [GetHashKey('prop_vend_fags_01')] = {
        --['Job'] = 'vanilla',
        [1] = {
            ['Name'] = 'Gebruiken',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-user-clock"></i>',
            ['EventName'] = 'pepe-stripclub:client:open:cigarettes',
            ['EventParameter'] = 2,
        },
    },    
    [GetHashKey('prop_bar_fruit')] = {
        ['Job'] = 'vanilla',
        [1] = {
            ['Name'] = 'Cocktail Maken',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-user-clock"></i>',
            ['EventName'] = 'pepe-stripclub:client:cocktailmaken',
            ['EventParameter'] = 'mojito',
        },
        [2] = {
            ['Name'] = 'Whiskey Maken',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-user-clock"></i>',
            ['EventName'] = 'pepe-stripclub:client:cocktailmaken',
            ['EventParameter'] = 'whiskey',
        },
        [3] = {
            ['Name'] = 'Tequila Maken',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-user-clock"></i>',
            ['EventName'] = 'pepe-stripclub:client:cocktailmaken',
            ['EventParameter'] = 'tequila',
        },
    },    
    [GetHashKey('prop_juice_dispenser')] = {
        ['Job'] = 'vanilla',
        [1] = {
            ['Name'] = 'Slushy Maken',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-user-clock"></i>',
            ['EventName'] = 'pepe-stripclub:client:maken',
            -- ['EventParameter'] = 2,
        },
    },    
    -- [GetHashKey('prop_pinacolada')] = {
    --     --['Job'] = 'vanilla',
    --     [1] = {
    --         ['Name'] = 'Pak drankje',
    --         ['EventType'] = 'Client',
    --         ['Logo'] = '<i class="fas fa-user-clock"></i>',
    --         ['EventName'] = 'pepe-stripclub:client:open:tray',
    --         ['EventParameter'] = 2,
    --     },
    -- },    
    [GetHashKey('ba_prop_club_laptop_dj')] = {
        ['Job'] = 'vanilla',
        [1] = {
            ['Name'] = 'Vuur',
            ['EventType'] = 'Server',
            ['Logo'] = '<i class="fas fa-user-clock"></i>',
            ['EventName'] = 'vuurtje:maken',
        },
        [2] = {
            ['Name'] = 'Bubbels',
            ['EventType'] = 'Server',
            ['Logo'] = '<i class="fas fa-user-clock"></i>',
            ['EventName'] = 'stripclub:server:bubbles',
        },
        [3] = {
            ['Name'] = 'Vuurwerk',
            ['EventType'] = 'Server',
            ['Logo'] = '<i class="fas fa-user-clock"></i>',
            ['EventName'] = 'stripclub:server:stars',
        },
        [4] = {
            ['Name'] = 'Strippers',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-user-clock"></i>',
            ['EventName'] = 'pepe-stripclub:client:call:strippers',
        },
    },
    [GetHashKey('U_F_M_CasinoCash_01')] = {
        [1] = {
            ['Name'] = 'Cashout',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-exchange-alt"></i>',
            ['EventName'] = 'doj:casinoChipMenu',
        },
        [2] = {
            ['Name'] = 'Koop Chips',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-coins"></i>',
            ['EventName'] = 'doj:casinoChipMenuBuy',
        },
        [3] = {
            ['Name'] = 'Bekijk Lidmaatschappen',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-id-card"></i>',
            ['EventName'] = 'pepe-casino:client:openCasinoMembersips',
        },
    },
    [GetHashKey('v_ret_fh_pot01')] = {
        ['Job'] = 'burger',
        ['UseDuty'] = true,
        [1] = {
            ['Name'] = 'Bereid Bleeder',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-hamburger"></i>',
            ['EventName'] = 'pepe-burgershot:client:create:burger',
            ['EventParameter'] = 'burger-bleeder',
        },
        [2] = {
            ['Name'] = 'Bereid Heartstopper',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-hamburger"></i>',
            ['EventName'] = 'pepe-burgershot:client:create:burger',
            ['EventParameter'] = 'burger-heartstopper',
        },
        [3] = {
            ['Name'] = 'Bereid Moneyshot',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-hamburger"></i>',
            ['EventName'] = 'pepe-burgershot:client:create:burger',
            ['EventParameter'] = 'burger-moneyshot',
        },
        [4] = {
            ['Name'] = 'Bereid Torpedo',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-hamburger"></i>',
            ['EventName'] = 'pepe-burgershot:client:create:burger',
            ['EventParameter'] = 'burger-torpedo',
        },
    },
    [GetHashKey('v_ilev_m_sofacushion')] = {
        ['Job'] = 'burger',
        [1] = {
            ['Name'] = 'In / Uit Dienst',
            ['EventType'] = 'Server',
            ['Logo'] = '<i class="fas fa-user-clock"></i>',
            ['EventName'] = 'Framework:ToggleDuty',
        },
    },
    -- [GetHashKey('s_m_m_highsec_02')] = {
    --     ['Job'] = 'burger',
    --     ['UseDuty'] = true,
    --     [1] = {
    --         ['Name'] = 'Lever Bonnen In',
    --         ['EventType'] = 'Client',
    --         ['Logo'] = '<i class="fas fa-receipt"></i>',
    --         ['EventName'] = 'pepe-illegal:client:talk:to:npc',
    --     },
    -- },
    [GetHashKey('s_m_m_highsec_02')] = {
        [1] = {
            ['Name'] = 'Lever Bonnen In',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-receipt"></i>',
            ['EventName'] = 'pepe-illegal:client:talk:to:npc',
        },
    },
	[1471401001] = {
        ['Job'] = 'burger',
        ['UseDuty'] = true,
		[1] = {
            ['Name'] = 'Baas Menu',
            ['EventType'] = 'Server',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = 'pepe-bossmenu:server:openMenu',
        },
    },
    [GetHashKey('s_m_y_garbage')] = {
        [1] = {
            ['Name'] = 'Verkoop koper',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = 'pepe-koperdief:client:verkoop',
        },
    },
	--pizzeria stuff--
	[GetHashKey('prop_bar_stirrers')] = {
        [1] = {
            ['Job'] = 'pizza',
            ['UseDuty'] = true,
            ['Name'] = 'Kassa',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-coins"></i>',
            ['EventName'] = 'pepe-pizzeria:client:open:register',
        },
        [2] = {
            ['Name'] = 'Betalen',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-coins"></i>',
            ['EventName'] = 'pepe-pizzeria:client:open:payment',
        },
    },
	[GetHashKey('prop_pizza_box_02')] = {
        ['Job'] = 'pizza',
        ['UseDuty'] = true,
		[1] = {
            ['Name'] = 'Pizza bezorgen',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = 'pepe-pizzeria:client:bezorgen',
        },
    },
	[GetHashKey('prop_beach_fire')] = {
        ['Job'] = 'pizza',
        ['UseDuty'] = true,
		[1] = {
            ['Name'] = 'Pizza bakken',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = 'pepe-pizzeria:client:pizzabakken',
        },
    },
	[GetHashKey('p_kitch_juicer_s')] = {
        ['Job'] = 'pizza',
        ['UseDuty'] = true,
		[1] = {
            ['Name'] = 'Snijd Groenten',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = 'pepe-pizzeria:client:snijdgroenten',
        },
    },
	[GetHashKey('v_res_foodjara')] = {
        ['Job'] = 'pizza',
        ['UseDuty'] = true,
		[1] = {
            ['Name'] = 'Vlees nemen',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = 'pepe-pizzeria:client:vleesnemen',
        },
    },
	[-2084757382] = {
        ['Job'] = 'pizza',
        ['UseDuty'] = true,
		[1] = {
            ['Name'] = 'Neem drank',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = 'pepe-pizzeria:client:drankjes',
        },
    },
	[124188622] = {
        ['Job'] = 'pizza',
        ['UseDuty'] = true,
		[1] = {
            ['Name'] = 'Baas menu',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = 'pepe-pizzeria:client:baasmenu',
        },
    },
    [-307229238] = {
        ['Job'] = 'pizza',
        ['UseDuty'] = true,
		[1] = {
            ['Name'] = 'Kluis',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = 'pepe-pizzeria:client:kluis',
        },
    },
	[-835359795] = {
        ['Job'] = 'pizza',
        ['UseDuty'] = true,
		[1] = {
            ['Name'] = 'Pizza to go',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = 'pepe-pizzeria:client:togo',
        },
    },
	[-286280212] = {
        ['Job'] = 'cardealer',
        ['UseDuty'] = true,
		[1] = {
            ['Name'] = 'Baas Menu',
            ['EventType'] = 'Server',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = 'pepe-bossmenu:server:openMenu',
        },
    },
	[743064848] = {
        ['Job'] = 'realestate',
        ['UseDuty'] = true,
		[1] = {
            ['Name'] = 'Baas Menu',
            ['EventType'] = 'Server',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = 'pepe-bossmenu:server:openMenu',
        },
    },
	[1729671130] = {
        ['Job'] = 'realestate',
        ['UseDuty'] = true,
		[1] = {
            ['Name'] = 'Opslag',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = 'pepe-lawyers:client:openstashrealestate',
        },
    },
	[743064848] = {
        ['Job'] = 'lawyer',
        ['UseDuty'] = true,
		[1] = {
            ['Name'] = 'Baas Menu',
            ['EventType'] = 'Server',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = 'pepe-bossmenu:server:openMenu',
        },
    },
	[1729671130] = {
        ['Job'] = 'lawyer',
        ['UseDuty'] = true,
		[1] = {
            ['Name'] = 'Opslag',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = 'pepe-lawyers:client:openstashlawyer',
        },
    },
	[1373326460] = {
		[1] = {
            ['Name'] = 'Verkopen',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = 'pepe-pawnshop:client:sellitems',
        },
    },
    [375485823] = {
        [1] = {
            ['Name'] = 'Verkopen',
            ['EventType'] = 'Client',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = 'pepe-pawnshop:client:sellgoldbars',
        },
    },
    [-573669520] = {
        [1] = {
            ['Name'] = 'Craften',
            ['EventType'] = 'Server',
            ['Logo'] = '<i class="fas fa-comments"></i>',
            ['EventName'] = 'pepe-crafting:client:open:craftstation',
        },
    },
}

Config.VehicleMenu = {
    [1] = {
        ['Name'] = 'Kofferbak',
        ['EventType'] = 'Client',
        ['Logo'] = '<i class="fas fa-truck-loading"></i>',
        ['EventName'] = 'pepe-eye:client:open:trunk',
    },
    [2] = {
        ['Name'] = 'In Kofferbak',
        ['EventType'] = 'Client',
        ['Logo'] = '<i class="fas fa-couch"></i>',
        ['EventName'] = 'pepe-eye:client:getin:trunk',
    },
    [3] = {
        ['Name'] = 'Uit Kofferbak',
        ['EventType'] = 'Client',
        ['Logo'] = '<i class="fas fa-couch"></i>',
        ['EventName'] = 'pepe-eye:client:getout:trunk',
    },
}

Config.PlayerMenu = {
    [1] = {
        ['Name'] = 'Geef contact gegevens',
        ['EventType'] = 'Client',
        ['Logo'] = '<i class="fas fa-mobile"></i>',
        ['EventName'] = 'pepe-phone:client:GiveContactDetails',
    },
    [2] = {
        ['Name'] = 'Geef voertuig sleutels',
        ['EventType'] = 'Client',
        ['Logo'] = '<i class="fas fa-key"></i>',
        ['EventName'] = 'pepe-vehiclekeys:client:give:key',
    },
}

Config.CarDealerVehicleMenu = {
    [1] = {
        ['Name'] = 'Verkoop Voertuig',
        ['EventType'] = 'Client',
        ['Logo'] = '<i class="fas fa-file-signature"></i>',
        ['EventName'] = 'pepe-cardealer:client:sell:closest:vehicle',
    },
    [2] = {
        ['Name'] = 'Testrit Voertuig',
        ['EventType'] = 'Client',
        ['Logo'] = '<i class="fas fa-file-signature"></i>',
        ['EventName'] = 'pepe-cardealer:client:testrit:closest:vehicle',
    },
}

Config.PedMenu = {
    [1] = {
        ['Name'] = 'Verkoop',
        ['EventType'] = 'Client',
        ['Logo'] = '<i class="fas fa-handshake"></i>',
        ['EventName'] = 'pepe-illegal:client:sell:to:ped',
    }, 
}

Config.VehicleOFfsets = {
    [0]  = {['CanEnter'] = true, ['X-Offset'] = 0.0, ['Y-Offset'] = -1.5, ['Z-Offset'] = 0.0},
    [1]  = {['CanEnter'] = true, ['X-Offset'] = 0.0, ['Y-Offset'] = -2.0, ['Z-Offset'] = 0.0},
    [2]  = {['CanEnter'] = true, ['X-Offset'] = 0.0, ['Y-Offset'] = -1.0, ['Z-Offset'] = 0.25},
    [3]  = {['CanEnter'] = true, ['X-Offset'] = 0.0, ['Y-Offset'] = -1.5, ['Z-Offset'] = 0.0},
    [4]  = {['CanEnter'] = true, ['X-Offset'] = 0.0, ['Y-Offset'] = -2.0, ['Z-Offset'] = 0.0},
    [5]  = {['CanEnter'] = true, ['X-Offset'] = 0.0, ['Y-Offset'] = -2.0, ['Z-Offset'] = 0.0},
    [6]  = {['CanEnter'] = true, ['X-Offset'] = 0.0, ['Y-Offset'] = -2.0, ['Z-Offset'] = 0.0},
    [7]  = {['CanEnter'] = true, ['X-Offset'] = 0.0, ['Y-Offset'] = -2.0, ['Z-Offset'] = 0.0},
    [8]  = {['CanEnter'] = false, ['X-Offset'] = 0.0, ['Y-Offset'] = -1.5, ['Z-Offset'] = 0.0},
    [9]  = {['CanEnter'] = true, ['X-Offset'] = 0.0, ['Y-Offset'] = -1.0, ['Z-Offset'] = 0.25},
    [10]  = {['CanEnter'] = true, ['X-Offset'] = 0.0, ['Y-Offset'] = -1.0, ['Z-Offset'] = 0.25},
    [11]  = {['CanEnter'] = true, ['X-Offset'] = 0.0, ['Y-Offset'] = -1.0, ['Z-Offset'] = 0.25},
    [12]  = {['CanEnter'] = true, ['X-Offset'] = 0.0, ['Y-Offset'] = -1.0, ['Z-Offset'] = 0.25},
    [13]  = {['CanEnter'] = true, ['X-Offset'] = 0.0, ['Y-Offset'] = -1.0, ['Z-Offset'] = 0.25},
    [14]  = {['CanEnter'] = true, ['X-Offset'] = 0.0, ['Y-Offset'] = -1.0, ['Z-Offset'] = 0.25},
    [15]  = {['CanEnter'] = true, ['X-Offset'] = 0.0, ['Y-Offset'] = -1.0, ['Z-Offset'] = 0.25},
    [16]  = {['CanEnter'] = true, ['X-Offset'] = 0.0, ['Y-Offset'] = -1.0, ['Z-Offset'] = 0.25},
    [17]  = {['CanEnter'] = true, ['X-Offset'] = 0.0, ['Y-Offset'] = -1.0, ['Z-Offset'] = 0.25},
    [18]  = {['CanEnter'] = true, ['X-Offset'] = 0.0, ['Y-Offset'] = -1.0, ['Z-Offset'] = 0.25},
    [19]  = {['CanEnter'] = true, ['X-Offset'] = 0.0, ['Y-Offset'] = -1.0, ['Z-Offset'] = 0.25},
    [20]  = {['CanEnter'] = true, ['X-Offset'] = 0.0, ['Y-Offset'] = -1.0, ['Z-Offset'] = 0.25},
    [21]  = {['CanEnter'] = true, ['X-Offset'] = 0.0, ['Y-Offset'] = -1.0, ['Z-Offset'] = 0.25}
}