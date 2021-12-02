Config = {}

Config.Reward = {
	["meth"] = math.random(1, 3),
	["coke"] = math.random(1, 3),
	["golden"] = math.random(3, 6),
}

Config.Locations = {
	-- ['shop'] = { ['x'] = 131.99, ['y'] = -1279.15, ['z'] = 29.26, ['h'] = 117.58 },
	['shop'] = { ['x'] = 93.8, ['y'] = -1292.01, ['z'] = 29.27, ['h'] = 295.18 },
}

Config.Items = {
	label = "Drugsdealer",
	items = {
		[1] = {
            name = "methburn",
            price = 9000,
            amount = 1,
            type = "item",
		},
		[2] = {
            name = "cokeburn",
            price = 9000,
            amount = 1,
            type = "item",
		},
		[3] = {
            name = "goldenburn",
            price = 6000,
            amount = 1,
            type = "item",
        },
	}
}

Config.MissionPosition = {
	{
		Location = vector3(-520.1247,-2877.795,7.295938), 
		InUse = false,
		GoonSpawns = {
			vector3(-523.3846,-2877.983,7.295937),
			vector3(-512.6961,-2867.888,7.295936),
			vector3(-540.0925,-2848.624,6.000387),
			vector3(-516.5098,-2872.221,11.55055),
		}
	},
	{
		Location = vector3(485.3236,-3383.7,6.069912), 
		InUse = false,
		GoonSpawns = {
			vector3(489.7149,-3382.499,6.069914),
			vector3(478.4058,-3382.275,6.069916),
			vector3(471.6081,-3371.956,6.069911),
			vector3(495.6046,-3370.103,6.069911),
			vector3(483.8217,-3386.293,9.25804),
		}
	},
	{
		Location = vector3(141.8366,-3102.032,5.896308), 
		InUse = false,
		GoonSpawns = {
			vector3(141.8366,-3102.032,5.896308),
			vector3(152.8683,-3112.24,5.896309),
			vector3(128.81,-3112.42,5.91),
			vector3(126.78,-3075.39,5.94),
			vector3(152.46,-3076.02,5.9),
		}
	},
	{
		Location = vector3(-106.08,-2230.32,7.81), 
		InUse = false,
		GoonSpawns = {
			vector3(-106.08,-2230.32,7.81),
			vector3(-112.27,-2212.6,7.81),
			vector3(-124.87,-2232.4,7.81),
			vector3(-136.17,-2214.41,7.81),
			vector3(-137.2,-2228.82,7.81),
		}
	},
	{
		Location = vector3(1515.7,-2137.4,76.73), 
		InUse = false,
		GoonSpawns = {
			vector3(1515.7,-2137.4,76.73),
			vector3(1523.94,-2139.34,76.99),
			vector3(1509.22,-2151.57,77.39),
			vector3(1494.6,-2140.0,76.54),
			vector3(1494.96,-2129.02,76.09),
			vector3(1508.75,-2121.41,76.56),
			vector3(1519.0,-2120.57,76.42),
		}
	},
	{
		Location = vector3(2368.46,3039.25,48.15), 
		InUse = false,
		GoonSpawns = {
			vector3(2368.46,3039.25,48.15),
			vector3(2368.75,3034.93,51.08),
			vector3(2367.93,3052.35,48.3),
			vector3(2368.35,3061.55,48.3),
			vector3(2371.41,3049.48,48.15),
		}
	}
}