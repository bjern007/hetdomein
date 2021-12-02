Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DEL'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

Config = Config or {}
PEPEduikboot = PEPEduikboot or {}
Config.BailPrice = 1000

Config.Locations = {
    ["vehicle"] = {
        label = "Deur",
        coords = {x = 3807.85, y = 4478.59, z = 6.36, h = 24.99},
    },
	["vehiclespawn"] = {
        label = "Voertuig",
        coords = {x = 3860.66, y = 4453.75, z = -1.56, h = 265.36},
    }
}

Config.Vehicles = {
    ["trash"] = "Vuilniswagen",
}


PEPEduikboot.Locations = {
    [1] = {
        label = "Dit is locatie 1",
        coords = {
            Area = {
                x = 3744.19, 
                y = 4746.69, 
                z = -12.99
            },
            Vuiligheid = {
                [1] = {
                    coords = {
                        x = 3744.19, 
                        y = 4746.69, 
                        z = -12.99
                    },
                    PickedUp = false
                },

            }
        },
        DefaultVuiligheid = 1,
        TotalVuiligheid = 1,
    },
    [2] = {
        label = "Ha locatie 2",
        coords = {
            Area = {
                x = 3810.14, 
                y = 5328.61, 
                z = -81.51,
            },
            Vuiligheid = {
                [1] = {
                    coords = {
                        x = 3810.14, 
                        y = 5328.61, 
                        z = -81.51,
                    },
                    PickedUp = false
                },

            }
        },
        DefaultVuiligheid = 1,
        TotalVuiligheid = 1,
    },
	[3] = {
        label = "Ha locatie 3",
        coords = {
            Area = {
                x = 3629.03, 
                y = 5767.57, 
                z = -29.94,
            },
            Vuiligheid = {
                [1] = {
                    coords = {
                        x = 3629.03, 
                        y = 5767.57, 
                        z = -29.94,
                    },
                    PickedUp = false
                },

            }
        },
        DefaultVuiligheid = 1,
        TotalVuiligheid = 1,
    },
	[4] = {
        label = "Ha locatie 4",
        coords = {
            Area = {
                x = 3027.7, 
                y = 6545.74, 
                z = -34.25,
            },
            Vuiligheid = {
                [1] = {
                    coords = {
                        x = 3027.7, 
                        y = 6545.74, 
                        z = -34.25,
                    },
                    PickedUp = false
                },

            }
        },
        DefaultVuiligheid = 1,
        TotalVuiligheid = 1,
    },
	[5] = {
        label = "Ha locatie 5",
        coords = {
            Area = {
                x = 4257.15, 
                y = 4386.43, 
                z = -60.93,
            },
            Vuiligheid = {
                [1] = {
                    coords = {
                        x = 4257.15, 
                        y = 4386.43, 
                        z = -60.93,
                    },
                    PickedUp = false
                },

            }
        },
        DefaultVuiligheid = 1,
        TotalVuiligheid = 1,
    },
	
	
}

PEPEduikboot.VuilTypes = {
    [1] = {
        item = "iron",
        maxAmount = math.random(20, 25),
    },
    [2] = {
        item = "metalscrap",
        maxAmount = math.random(20, 25),

    }
}

