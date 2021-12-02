Config                 = {}
Config.DrawDistance    = 100.0
Config.MaxErrors       = 8
Config.SpeedMultiplier =  3.6


Config.SpeedLimits = {
	residence = 50,
	town      = 80,
	freeway   = 130
}


Config.Vehicles = {
    ["blista"] = "NAME HERE",
}

Config.Zones = {
	DMVSchool = {
		Pos   = {x = 240.02688, y = -1380.107, z = 33.741722},
		Size  = {x = 0.5, y = 0.3, z = 0.3},
		Color = {r = 255, g = 255, b = 255},
		Type  = 20
	},

}

Config.CheckPoints = {

	{
		Pos = {x = 255.139, y = -1400.731, z = 29.537},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			Framework.Functions.Notify("Max. snelheid: - "..Config.SpeedLimits['residence'].." ", "success", 5000)

		end
	},

	{
		Pos = {x = 271.874, y = -1370.574, z = 30.932},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			Framework.Functions.Notify('Ga naar het volgende punt', "success", 5000)
		end
	},

	{
		Pos = {x = 234.907, y = -1345.385, z = 29.542},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			Citizen.CreateThread(function()
				
				Framework.Functions.Notify('Stop voor voetgangers!', "error", 5000)
				PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
				FreezeEntityPosition(vehicle, true)
				Citizen.Wait(4000)

				FreezeEntityPosition(vehicle, false)
				Framework.Functions.Notify('Netjes rijd zo door', "error", 5000)
			end)
		end
	},

	{
		Pos = {x = 217.821, y = -1410.520, z = 28.292},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			setCurrentZoneType('town')

			Citizen.CreateThread(function()
				Framework.Functions.Notify("Look left and right. Max speed: - "..Config.SpeedLimits['town'].." ", "error", 5000)
				PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
				FreezeEntityPosition(vehicle, true)
				Citizen.Wait(6000)

				FreezeEntityPosition(vehicle, false)
				Framework.Functions.Notify('Netjes rijd zo door', "success", 5000)
			end)
		end
	},

	{
		Pos = {x = 183.73622, y = -1394.504, z = 28.425479},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			Framework.Functions.Notify('Let goed op het verkeerslicht!', "error", 5000)
		end
	},

	{
		Pos = {x = 234.23289, y = -1238.983, z = 28.218307},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			Framework.Functions.Notify('Ga naar het volgende punt', "success", 5000)
		end
	},

	{ 
		Pos = {x = 224.55731, y = -1069.657, z = 28.152294},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			Framework.Functions.Notify('Stop voor overstekend verkeer', "error", 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
			FreezeEntityPosition(vehicle, true)
			Citizen.Wait(6000)
			FreezeEntityPosition(vehicle, false)
		end
	},

	{
		Pos = {x = 587.50573, y = -1029.189, z = 36.099342},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			Framework.Functions.Notify('Ga naar het volgende punt', "success", 5000)
		end
	},

	{
		Pos = {x = 1137.8361, y = -952.9248, z = 47.097686},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			Framework.Functions.Notify('Ga naar het volgende punt', "success", 5000)
		end
	},

	{
		Pos = {x = 1201.3891, y = -734.4391, z = 57.839035},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			Framework.Functions.Notify('Ga naar het volgende punt', "success", 5000)
		end
	},

	{ 
		Pos = {x = 1043.0256, y = -202.6507, z = 69.097633},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			Framework.Functions.Notify('Ga naar het volgende punt', "success", 5000)
		end
	},
	
	{ 
		Pos = {x = 816.22613, y = -54.7724, z = 79.587684},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			Framework.Functions.Notify('Ga naar het volgende punt', "success", 5000)
		end
	},

	{
		Pos = {x = 1149.5267, y = 372.1109, z = 90.341171},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			Framework.Functions.Notify('Ga naar het volgende punt', "success", 5000)
		end
	},

	{
		Pos = {x = 949.3327, y = 262.78665, z = 80.055412},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			setCurrentZoneType('freeway')

			
			Framework.Functions.Notify("Let op! Maximale snelheid is: - "..Config.SpeedLimits['freeway'].." ", "error", 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},

	{ 
		Pos = {x = 637.54058, y = -230.6599, z = 42.168529},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			Framework.Functions.Notify('Ga naar het volgende punt', "success", 5000)
		end
	},

	{ 
		Pos = {x = 331.88369, y = -711.3079, z = 28.349275},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			Framework.Functions.Notify('Ga naar het volgende punt', "success", 5000)
		end
	},

	{
		Pos = {x = 291.35293, y = -831.4489, z = 28.309329},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			setCurrentZoneType('town')
			Framework.Functions.Notify("Let op! Maximale snelheid is: - "..Config.SpeedLimits['town'].." ", "error", 5000)
		end
	},

	{ 
		Pos = {x = 204.9886, y = -1116.451, z = 28.333709},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			Framework.Functions.Notify('Wakker blijven!', "error", 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},

	{ 
		Pos = {x = 235.283, y = -1398.329, z = 28.921},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DeleteVehicle(vehicle)
		end
	}

}
