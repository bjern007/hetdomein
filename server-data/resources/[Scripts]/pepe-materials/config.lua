Config = Config or {}

Config.ScrapyardLocations = {
    [1] = {['Name'] = 'Yellow Jack', ['X'] = 2352.27, ['Y'] = 3133.19, ['Z'] = 48.20},
   -- [2] = {['Name'] = 'Secret Location', ['X'] = 2352.27, ['Y'] = 3133.19, ['Z'] = 48.20}
}

-- Prospecting blip
Config.ProspectingBlipText = "Treasure location"    -- Text that shows for blip
Config.ProspectingBlipSprite = 587  -- Sprite for blip inside the circle
Config.ProspectingBlipColor = 5     -- Color for blip inside the circle
Config.ProspectingAreaSprite = 9    -- Sprite for the area. Use 9 or 10, other ones won't be accurate. 9 shows a filled circle and 10 shows only the outline.
Config.ProspectingAreaColor = 71    -- Color for the area
Config.ProspectingAreaAlpha = 64    -- Transparency for the area

Config.CanScrap = true

Config.OpenedBins = {}

Config.BaseLocations = {
  vector3(1580.9, 6592.204, 13.84828), -- default
  vector3(-88.6, 2595.32, 100.26), -- great chaparral
  vector3(3445.75, 3370.62, 192.73), -- under humane labs
  vector3(2830.57, -1456.56, 10.79), -- island near city
  vector3(-1571.66, 2065.07, 80.26), -- near wine fields
}

Config.Dumpsters = {
  [1] = {['Model'] = 666561306,    ['Name'] = 'Blauwe Bak'},
  [2] = {['Model'] = 218085040,    ['Name'] = 'Licht Blauwe Bak'},
  [3] = {['Model'] = -58485588,    ['Name'] = 'Grijze Bak'},
  [4] = {['Model'] = 682791951,    ['Name'] = 'Grote Blauwe Bak'},
  [5] = {['Model'] = -206690185,   ['Name'] = 'Grote Groene Bak'},
  [6] = {['Model'] = 364445978,    ['Name'] = 'Grote Groene Bak'},
  [7] = {['Model'] = 143369,       ['Name'] = 'Kleine Bak'},
  [8] = {['Model'] = -2140438327,  ['Name'] = 'Onbekende Bak'},
  [9] = {['Model'] = -1851120826,  ['Name'] = 'Onbekende Bak'},
  [10] = {['Model'] = -1543452585, ['Name'] = 'Onbekende Bak'},
  [11] = {['Model'] = -1207701511, ['Name'] = 'Onbekende Bak'},
  [12] = {['Model'] = -918089089,  ['Name'] = 'Onbekende Bak'},
  [13] = {['Model'] = 1511880420,  ['Name'] = 'Onbekende Bak'},
  [14] = {['Model'] = 1329570871,  ['Name'] = 'Onbekende Bak'},
}


Config.Locations = {
  {x = 1600.185, y = 6622.714, z = 15.85106, data = {
      item = "bones",
      label = "Bones",
      -- default
  }},
  {x = 1634.586, y = 6596.688, z = 22.55633, data = {
      item = "metalscrap",
      label = "Metal Scrap",
      -- default
  }},
  {x = -50.7, y = 2626.4, z = 79.99, data = {
      item = "bones",
      label = "Bones",
      -- great chaparral
  }},
  {x = 3403.83, y = 3415.43, z = 176.79, data = {
      item = "nuts_and_bolts",
      label = "Nuts and Bolts"
      -- under humane labs
  }},
  {x = 3497.59, y = 3335.5, z = 174.04, data = {
      item = "gold-rolex",
      label = "a Golden ring",
      -- under humane labs
  }},
  {x = 2870.4, y = -1409.93, z = 2.2, data = {
      item = "gold-rolex",
      label = "a Golden ring",
      -- island near city
  }},
  {x = 2801.08, y = -1505.06, z = 9.05, data = {
      item = "key-b",
      label = "Sleutel B",
      -- island near city
  }},
  {x = -1577.1, y = 2102.16, z = 68.04, data = {
      item = "gold-bar",
      label = "a Golden ring",
      -- near wine fields
  }},
  {x = -1579.77, y = 2045.29, z = 85.33, data = {
      item = "nuts_and_bolts",
      label = "Nuts and Bolts"
      -- near wine fields
  }},
}

Config.BinItems = {
 'plastic',  
 'metalscrap',  
--  'copper', 
 'aluminum',
 'iron',
 'steel',
 'rubber',
 'glass',
}

Config.CarItems = {
  'plastic',  
  'metalscrap',  
  -- 'copper', 
  'aluminum',
  'iron',
  'steel',
  'glass',
}

Config.Items = {
  {item = "bones", label = "Bones"},
  {item = "nuts_and_bolts", label = "Nuts and Bolts"},
  {item = "dragon_scales", label = "Dragon Scales"},
}