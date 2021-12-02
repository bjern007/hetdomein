Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

Config = Config or {}

Config.Timeout = 45 * (60 * 1000)

Config.RequiredCops = 3

Config.JewelleryLocation = {
    ["coords"] = {
            ["x"] = 157.0838, 
            ["y"] = -230.0955, 
            ["z"] = 54.42401,
    }
}
--[[
Config.WhitelistedWeapons = {
    [GetHashKey("weapon_crowbar")] = {
        ["timeOut"] = 25000
    },
    [GetHashKey("weapon_carbinerifle")] = {
        ["timeOut"] = 26000
    },
    [GetHashKey("weapon_pumpshotgun")] = {
        ["timeOut"] = 27000
    },
    [GetHashKey("weapon_sawnoffshotgun")] = {
        ["timeOut"] = 28000
    },
    [GetHashKey("weapon_compactrifle")] = {
        ["timeOut"] = 29000
    },
    [GetHashKey("weapon_microsmg")] = {
        ["timeOut"] = 30000
    },
    [GetHashKey("weapon_minismg")] = {
        ["timeOut"] = 31000
    },
    [GetHashKey("weapon_autoshotgun")] = {
        ["timeOut"] = 32000
    },
}]]--

Config.VitrineRewards = {
    [1] = {
        ["item"] = "laptop",
        ["amount"] = {
            ["min"] = 1,
            ["max"] = 4
        },
    },
    [2] = {
        ["item"] = "tablet",
        ["amount"] = {
            ["min"] = 1,
            ["max"] = 4
        },
    },
}

Config.Locations = {
    [1] = {
        ["coords"] = {
            ["x"] = 157.0838, 
            ["y"] = -230.0955, 
            ["z"] = 54.42401,
        },
        ["isOpened"] = false,
        ["isBusy"] = false,
    }, 
    [2] = {
        ["coords"] = {
            ["x"] = 158.7311, 
            ["y"] = -225.5713, 
            ["z"] = 54.42401,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [3] = {
        ["coords"] = {
            ["x"] = 155.6221, 
            ["y"] = -224.5015, 
            ["z"] = 54.42401,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [4] = {
        ["coords"] = {
            ["x"] = 153.8737, 
            ["y"] = -229.0323, 
            ["z"] = 54.42401,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [5] = {
        ["coords"] = {
            ["x"] = 151.9592, 
            ["y"] = -223.1847, 
            ["z"] = 54.42402,
        },
        ["isOpened"] = false,
        ["isBusy"] = false,
    }, 
    [6] = {
        ["coords"] = {
            ["x"] = 150.2838, 
            ["y"] = -227.8233, 
            ["z"] = 54.42402,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    }, 
    [7] = {
        ["coords"] = {
            ["x"] = 147.1916, 
            ["y"] = -226.4779, 
            ["z"] = 54.42402,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [8] = {
        ["coords"] = {
            ["x"] = 148.9756, 
            ["y"] = -221.8463, 
            ["z"] = 54.42402,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [9] = {
        ["coords"] = {
            ["x"] = 145.3721, 
            ["y"] = -226.1051, 
            ["z"] = 54.42402,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    }
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

Config.Items = {
        [1] = {
          ['Stolen'] = false,
          ['Item'] = 'stolen-tv',
          ['PropName'] = 'ex_prop_monitor_01_ex',
          ['Coords'] = {
            ['X'] = 149.0023,
            ['Y'] = -228.51,
            ['Z'] = 54.13,
          }
        },
        [2] = {
            ['Stolen'] = false,
            ['Item'] = 'stolen-tv',
            ['PropName'] = 'ex_prop_monitor_01_ex',
            ['Coords'] = {
              ['X'] = 145.9403,
              ['Y'] = -227.5003,
              ['Z'] = 54.19,
            }
        },
}