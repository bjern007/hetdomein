Config = {}

Config.Doors = {
	-- Politie
	[1] = {
	  ['DoorName'] = 'Politie Voordeur',
	  ['TextCoords'] = vector3(434.81, -981.93, 30.89),
	  ['Autorized'] = {
	   [1] = 'police',
	   [2] = 'judge',
	  },
	  ['Locking'] = false,
	  ['Locked'] = false,
	  ["Pickable"] = false,
	  ["Distance"] = 2.5,
	  ['Doors'] = {
	  	[1] = {
	  	 ['ObjName'] = 'gabz_mrpd_reception_entrancedoor',
	  	 ['ObjYaw'] = -90.0,
	  	 ['ObjCoords'] = vector3(434.7, -980.6, 30.8)
	  	},
	  	[2] = {
	  	 ['ObjName'] = 'gabz_mrpd_reception_entrancedoor',
	  	 ['ObjYaw'] =  90.0,
	  	 ['ObjCoords'] = vector3(434.7, -983.2, 30.8)
	  	},
	   }
   },
   [2] = {
	['DoorName'] = 'Politie  Zij Deur garage zijde',
	['TextCoords'] = vector3(441.94, -999.29, 30.72),
	['Autorized'] = {
	 [1] = 'police',
	 [2] = 'judge',
	},
	['Locking'] = false,
	['Locked'] = true,
	["Pickable"] = false,
	["Distance"] = 2.5,
	['Doors'] = {
		[1] = {
		 ['ObjName'] = 'gabz_mrpd_reception_entrancedoor',
		 ['ObjYaw'] = 180.0,
		 ['ObjCoords'] = vector3(442.92, -999.28, 30.72)
		},
		[2] = {
		 ['ObjName'] = 'gabz_mrpd_reception_entrancedoor',
		 ['ObjYaw'] =  0.0,
		 ['ObjCoords'] = vector3(440.91, -999.29, 30.72)
		},
	 }
   },
   [3] = {
	['DoorName'] = 'Politie boven  Zij Deur richting kleding winkel',
	['TextCoords'] = vector3(457.04, -971.75, 30.70),
	['Autorized'] = {
	 [1] = 'police',
	 [2] = 'judge',
	},
	['Locking'] = false,
	['Locked'] = true,
	["Pickable"] = true,
	["Distance"] = 2.5,
	['Doors'] = {
		[1] = {
		 ['ObjName'] = 'gabz_mrpd_reception_entrancedoor',
		 ['ObjYaw'] = 180.0,
		 ['ObjCoords'] = vector3(457.84, -971.84, 30.70)
		},
		[2] = {
		 ['ObjName'] = 'gabz_mrpd_reception_entrancedoor',
		 ['ObjYaw'] =  0.0,
		 ['ObjCoords'] = vector3(456.08, -971.69, 30.70)
		},
	 }
	 },
	 [4] = {
		['DoorName'] = 'Garage Deur Beneden',
		['TextCoords'] = vector3(463.69, -996.76, 26.27),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = false,
		["Distance"] = 3.0,
		['ObjYaw'] = 90.0,
		['ObjName'] = 'gabz_mrpd_room13_parkingdoor',
		['ObjCoords'] = vector3(463.69, -996.76, 26.27)
	 },
	 [5] = {
		['DoorName'] = 'Garage Deur Beneden 2',
		['TextCoords'] = vector3(463.68, -975.37, 26.27),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = false,
		["Distance"] = 3.0,
		['ObjYaw'] = 270.0,
		['ObjName'] = 'gabz_mrpd_room13_parkingdoor',
		['ObjCoords'] = vector3(463.68, -975.37, 26.27)
	 },
	 [6] = {
		['DoorName'] = 'Receptie Zijdeuren',
		['TextCoords'] = vector3(441.16, -978.11, 30.68),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = false,
		["Distance"] = 3.0,
		['ObjYaw'] = 0.0,
		['ObjName'] = 'gabz_mrpd_door_04',
		['ObjCoords'] = vector3(441.16, -978.11, 30.68)
	 },
	 [7] = {
		['DoorName'] = 'Receptie Zijdeuren 2',
		['TextCoords'] = vector3(441.30, -985.71, 30.68),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = false,
		["Distance"] = 3.0,
		['ObjYaw'] = 180.0,
		['ObjName'] = 'gabz_mrpd_door_05',
		['ObjCoords'] = vector3(441.30, -985.71, 30.68)
	 },
	 [8] = {
		['DoorName'] = 'Cell Deur 1',
		['TextCoords'] = vector3(477.05, -1008.22, 26.27),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = false,
		["Distance"] = 2.0,
		['ObjYaw'] = 270.0,
		['ObjName'] = 'gabz_mrpd_cells_door',
		['ObjCoords'] = vector3(477.05, -1008.22, 26.27)
	 },
	 [9] = {
		['DoorName'] = 'Cell Deur 2',
		['TextCoords'] = vector3(481.66, -1004.56, 26.27),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = false,
		["Distance"] = 2.0,
		['ObjYaw'] = 180.0,
		['ObjName'] = 'gabz_mrpd_cells_door',
		['ObjCoords'] = vector3(481.66, -1004.56, 26.27)
	 },
	 [10] = {
		['DoorName'] = 'Cell Deur 3',
		['TextCoords'] = vector3(484.82, -1008.17, 26.27),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = false,
		["Distance"] = 2.0,
		['ObjYaw'] = 180.0,
		['ObjName'] = 'gabz_mrpd_cells_door',
		['ObjCoords'] = vector3(484.82, -1008.17, 26.27)
	 },
	 [11] = {
		['DoorName'] = 'Cell Deur 4',
		['TextCoords'] = vector3(486.28, -1011.74, 26.27),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = false,
		["Distance"] = 2.0,
		['ObjYaw'] = 0.0,
		['ObjName'] = 'gabz_mrpd_cells_door',
		['ObjCoords'] = vector3(486.28, -1011.74, 26.27)
	 },
	 [12] = {
		['DoorName'] = 'Cell Deur 5',
		['TextCoords'] = vector3(483.25, -1011.70, 26.27),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = false,
		["Distance"] = 2.0,
		['ObjYaw'] = 0.0,
		['ObjName'] = 'gabz_mrpd_cells_door',
		['ObjCoords'] = vector3(483.25, -1011.70, 26.27)
	 },
	 [13] = {
		['DoorName'] = 'Cell Deur 6',
		['TextCoords'] = vector3(480.21, -1011.66, 26.27),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = false,
		["Distance"] = 2.0,
		['ObjYaw'] = 0.0,
		['ObjName'] = 'gabz_mrpd_cells_door',
		['ObjCoords'] = vector3(480.21, -1011.66, 26.27)
	 },
	 [14] = {
		['DoorName'] = 'Cell Deur 7',
		['TextCoords'] = vector3(477.15, -1011.75, 26.27),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = false,
		["Distance"] = 2.0,
		['ObjYaw'] = 0.0,
		['ObjName'] = 'gabz_mrpd_cells_door',
		['ObjCoords'] = vector3(477.15, -1011.75, 26.27)
	 },
	 [15] = {
		['DoorName'] = 'Politie Achter Deuren',
		['TextCoords'] = vector3(468.64, -1014.86, 26.38),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = false,
		["Pickable"] = true,
		["Distance"] = 2.5,
		['Doors'] = {
			[1] = {
			 ['ObjName'] = 'gabz_mrpd_door_03',
			 ['ObjYaw'] = 180.06,
			 ['ObjCoords'] = vector3(469.52, -1014.88, 26.38)
			},
			[2] = {
			 ['ObjName'] = 'gabz_mrpd_door_03',
			 ['ObjYaw'] =  0.0,
			 ['ObjCoords'] = vector3(467.71, -1014.87, 26.38)
			},
		 }
		 },
								-- Politie End

-- Ambulance

	 [16] = {
		['DoorName'] = 'Ambulance OK 1',
		['TextCoords'] = vector3(312.94, -572.42, 43.28),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		 [3] = 'ambulance',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = false,
		["Distance"] = 2.5,
		['Doors'] = {
			[1] = {
			 ['ObjName'] = 'gabz_pillbox_doubledoor_r',
			 ['ObjYaw'] = -20.0,
			 ['ObjCoords'] = vector3(314.14, -572.61, 43.28)
			},
			[2] = {
			 ['ObjName'] = 'gabz_pillbox_doubledoor_l',
			 ['ObjYaw'] = -20.0,
			 ['ObjCoords'] = vector3(311.91, -571.78, 43.28)
			},
		 }
	 },
	 [17] = {
		['DoorName'] = 'Ambulance OK 2',
		['TextCoords'] = vector3(318.96, -574.26, 43.28),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		 [3] = 'ambulance',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = false,
		["Distance"] = 2.5,
		['Doors'] = {
			[1] = {
			 ['ObjName'] = 'gabz_pillbox_doubledoor_r',
			 ['ObjYaw'] = -20.0,
			 ['ObjCoords'] = vector3(319.89, -574.69, 43.28)
			},
			[2] = {
			 ['ObjName'] = 'gabz_pillbox_doubledoor_l',
			 ['ObjYaw'] = -20.0,
			 ['ObjCoords'] = vector3(317.66, -573.87, 43.28)
			},
		 }
	 },
								-- End Ambulance
-- Gevangenis
	 [18] = {
		['DoorName'] = 'Gevangenis Gate 1',
		['TextCoords'] = vector3(1844.9, 2608.5, 48.0),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = false,
		["Distance"] = 11.0,
		['ObjYaw'] = 90.0,
		['ObjName'] = 'prop_gate_prison_01',
		['ObjCoords'] = vector3(1844.99, 2604.81, 44.63)
	 },
	 [19] = {
		['DoorName'] = 'Gevangenis Gate 2',
		['TextCoords'] = vector3(1818.5, 2608.4, 48.0),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = false,
		["Distance"] = 11.0,
		['ObjYaw'] = 90.0,
		['ObjName'] = 'prop_gate_prison_01',
		['ObjCoords'] = vector3(1818.5, 2604.8, 44.6)
	 },
	 [20] = {
		['DoorName'] = 'Gevangenis Gate Binnen 1',
		['TextCoords'] = vector3(1831.788, 2594.387, 46.01),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = false,
		["Distance"] = 2.5,
		['ObjName'] = 'sanhje_Prison_recep_door02',
		['ObjCoords'] = vector3(1831.788, 2594.387, 46.01)
	 },
	 [21] = {
		['DoorName'] = 'Gevangenis Gate Binnen 2',
		['TextCoords'] = vector3(1837.082, 2590.521, 46.01),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = false,
		["Distance"] = 2.5,
		['ObjName'] = 'sanhje_Prison_recep_cagedoor',
		['ObjCoords'] = vector3(1837.373, 2589.837, 46.01)
	 },

									 -- End Gevangenis
	 -- Banken
	 [22] = {
		['DoorName'] = 'Bank Gate 1',
		['TextCoords'] = vector3(148.96, -1047.12, 29.7),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = false,
		["Pickable"] = true,
		["Distance"] = 1.5,
		['ObjName'] = 'v_ilev_gb_vaubar',
		['ObjCoords'] = vector3(148.96, -1047.12, 29.7)
	 },
	 [23] = {
		['DoorName'] = 'Bank Gate 2',
		['TextCoords'] = vector3(314.61, -285.82, 54.49),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = false,
		["Pickable"] = true,
		["Distance"] = 1.5,
		['ObjName'] = 'v_ilev_gb_vaubar',
		['ObjCoords'] = vector3(314.61, -285.82, 54.49)
	 },
	 [24] = {
		['DoorName'] = 'Bank Gate 3',
		['TextCoords'] = vector3(-351.7, -56.28, 49.38),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = false,
		["Pickable"] = true,
		["Distance"] = 1.5,
		['ObjName'] = 'v_ilev_gb_vaubar',
		['ObjCoords'] = vector3(-351.7, -56.28, 49.38)
	 },
	 [25] = {
		['DoorName'] = 'Bank Gate 4',
		['TextCoords'] = vector3(-2956.18, -335.76, 38.11),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = false,
		["Pickable"] = true,
		["Distance"] = 1.5,
		['ObjName'] = 'v_ilev_gb_vaubar',
		['ObjCoords'] = vector3(-2956.18, -335.76, 38.11)
	 },
	 [26] = {
		['DoorName'] = 'Bank Gate 5',
		['TextCoords'] = vector3(-2956.18, 483.96, 16.02),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = false,
		["Pickable"] = true,
		["Distance"] = 1.5,
		['ObjName'] = 'v_ilev_gb_vaubar',
		['ObjCoords'] = vector3(-2956.18, 483.96, 16.02)
	 },
	 [27] = {
		['DoorName'] = 'Bank Gate 6',
		['TextCoords'] = vector3(-1208.52, -335.60, 37.75),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = false,
		["Pickable"] = true,
		["Distance"] = 1.5,
		['ObjName'] = 'v_ilev_gb_vaubar',
		['ObjCoords'] = vector3(-1208.52, -335.60, 37.75)
	 },
								-- End Banken
-- Juwelier
     [28] = {
 	  ['DoorName'] = 'Juwelier Deuren',
 	  ['TextCoords'] = vector3(-631.9554, -236.3333, 38.20653),
 	  ['Autorized'] = {
		[1] = 'police',
		[2] = 'judge',
 	  },
 	  ['Locking'] = false,
 	  ['Locked'] = false,
 	  ["Pickable"] = false,
 	  ["Distance"] = 2.5,
 	  ['Doors'] = {
 	  	[1] = {
 	  	 ['ObjName'] = 'p_jewel_door_l',
 	  	 ['ObjYaw'] = -54.0,
 	  	 ['ObjCoords'] = vector3(-631.9554, -236.3333, 38.20653)
 	  	},
 	  	[2] = {
 	  	 ['ObjName'] = 'p_jewel_door_r1',
 	  	 ['ObjYaw'] = -54.0,
 	  	 ['ObjCoords'] = vector3(-630.4265, -238.4376, 38.20653)
 	  	},
 	   }
    },

-- End Juwelier	

	[29] = {
		['DoorName'] = 'Humane Labs',
		['TextCoords'] = vector3(3525.326, 3702.961, 20.9918),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = true,
		["Distance"] = 2.5,
		['ObjName'] = 'v_ilev_bl_doorpool',
		['ObjCoords'] = vector3(3525.326, 3702.961, 20.9918)
	 },
	 [30] = {
		['DoorName'] = 'Humane Labs',
		['TextCoords'] = vector3(3621.109, 3751.822, 28.69323),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = true,
		["Distance"] = 3.5,
		['ObjName'] = 'v_ilev_bl_shutter2',
		['ObjCoords'] = vector3(3621.109, 3751.822, 28.69323)
	 },
	 [31] = {
		['DoorName'] = 'Humane Labs',
		['TextCoords'] = vector3(3628.873, 3746.595, 28.68423),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = true,
		["Distance"] = 3.5,
		['ObjName'] = 'v_ilev_bl_shutter2',
		['ObjCoords'] = vector3(3628.873, 3746.595, 28.68423)
	 },
	 [32] = {
		['DoorName'] = 'Tequila LaLa',
		['TextCoords'] = vector3(-564.49, 277.03, 83.13),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = true,
		["Distance"] = 3.5,
		['ObjName'] = 'v_ilev_roc_door4',
		['ObjCoords'] = vector3(-564.49, 277.03, 83.13)
	 },
	 [33] = {
		['DoorName'] = 'Tequila LaLa',
		['TextCoords'] = vector3(-560.45, 292.48, 82.17),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = true,
		["Distance"] = 3.5,
		['ObjName'] = 'v_ilev_roc_door2',
		['ObjCoords'] = vector3(-560.45, 292.48, 82.17)
	 },
	 [34] = {
		['DoorName'] = 'Tequila LaLa',
		['TextCoords'] = vector3(-569.96, 293.17, 79.17),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = true,
		["Distance"] = 3.5,
		['ObjName'] = 'v_ilev_roc_door2',
		['ObjCoords'] = vector3(-569.96, 293.17, 79.17)
	 },
	 -- pizzeria
	 [35] = {
		['DoorName'] = 'Koelcel pizza',
		['TextCoords'] = vector3(297.43, -985.82, 29.68),
		['Autorized'] = {
		 [1] = 'pizza',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = true,
		["Distance"] = 1.5,
		['ObjName'] = 'k4mb1_pizza_door3',
		['ObjCoords'] = vector3(297.43, -985.82, 29.68)
	 },
	 [36] = {
		['DoorName'] = 'deur naar keuken',
		['TextCoords'] = vector3(285.43, -977.42, 29.58),
		['Autorized'] = {
		 [1] = 'pizza',
		 [2] = 'police',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = true,
		["Distance"] = 1.5,
		['ObjName'] = 'v_ilev_roc_door3',
		['ObjCoords'] = vector3(285.43, -977.42, 29.58)
	 },
	 [37] = {
		['DoorName'] = 'deur bureau',
		['TextCoords'] = vector3(284.77, -990.77, 29.58),
		['Autorized'] = {
		 [1] = 'pizza',
		 [2] = 'police',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = true,
		["Distance"] = 1.5,
		['ObjName'] = 'v_ilev_roc_door2',
		['ObjCoords'] = vector3(284.77, -990.77, 29.58)
	 },
	 [38] = {
		['DoorName'] = 'achterdeur pizzeria',
		['TextCoords'] = vector3(297.06, -993.70, 29.58),
		['Autorized'] = {
		 [1] = 'pizza',
		 [2] = 'police',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = true,
		["Distance"] = 1.5,
		['ObjName'] = 'v_ilev_roc_door5',
		['ObjCoords'] = vector3(297.06, -993.70, 29.58)
	 },
	 [39] = {
		['DoorName'] = 'achterdeur pizzeria',
		['TextCoords'] = vector3(286.74, -964.38, 29.60),
		['Autorized'] = {
		 [1] = 'pizza',
		 [2] = 'police',
		},
		['Locking'] = false,
		['Locked'] = false,
		["Pickable"] = true,
		["Distance"] = 1.5,
		['ObjName'] = 'k4mb1_door_pizza_pizza',
		['ObjCoords'] = vector3(286.74, -964.38, 29.60)
	 },
	 [40] = {
		['DoorName'] = 'deuren voorkant burgershot',
		['TextCoords'] = vector3(-1183.097, -885.098, 13.799),
		['Autorized'] = {
		 [1] = 'burger',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = false,
		["Distance"] = 2,
		['Doors'] = {
		[1] = {
			['ObjName'] = 'bs_prop_door_02_l',
			['ObjYaw'] = 125.00,
			['ObjCoords'] = vector3(-1183.097, -885.098, 13.799)
		},
		[2] = {
			['ObjName'] = 'bs_prop_door_02_r',
			['ObjYaw'] =  125.00,
			['ObjCoords'] = vector3(-1184.034, -883.7188, 13.799)
		},
		},
	},
	[41] = {
	   ['DoorName'] = 'deuren zijkant burgershot',
	   ['TextCoords'] = vector3(-1198.796, -884.4071, 13.799),
	   ['Autorized'] = {
		[1] = 'burger',
	   },
	   ['Locking'] = false,
	   ['Locked'] = true,
	   ["Pickable"] = false,
	   ["Distance"] = 2,
	   ['Doors'] = {
	   [1] = {
		   ['ObjName'] = 'bs_prop_door_02_l',
		   ['ObjYaw'] = 210.00,
		   ['ObjCoords'] = vector3(-1197.353, -883.4214, 13.799)
	   },
	   [2] = {
		   ['ObjName'] = 'bs_prop_door_02_r',
		   ['ObjYaw'] =  220.00,
		   ['ObjCoords'] = vector3(-1198.796, -884.4071, 13.799)
	   },
	   },
   },
   [42] = {
	  ['DoorName'] = 'burgershot medewerker ingang',
	  ['TextCoords'] = vector3(-1200.534, -892.06, 13.99),
	  ['Autorized'] = {
	   [1] = 'burger',
	  },
	  ['Locking'] = false,
	  ['Locked'] = true,
	  ["Pickable"] = true,
	  ["Distance"] = 1.5,
	  ['ObjName'] = 'bs_prop_door_01',
	  ['ObjCoords'] = vector3(-1200.534, -892.06, 13.99)
   },
   [43] = {
	  ['DoorName'] = 'burgershot medewerker ingang 2',
	  ['TextCoords'] = vector3(-1178.601, -891.8434, 13.787311),
	  ['Autorized'] = {
	   [1] = 'burger',
	  },
	  ['Locking'] = false,
	  ['Locked'] = true,
	  ["Pickable"] = true,
	  ["Distance"] = 1.5,
	  ['ObjYaw'] =  120.00,
	  ['ObjName'] = 'bs_prop_door_staff_01',
	  ['ObjCoords'] = vector3(-1178.601, -891.8434, 13.787311)
   },
   [44] = {
	  ['DoorName'] = 'Pawn voor',
	  ['TextCoords'] = vector3(182.26, -1319.10, 29.31),
	  ['Autorized'] = {
	   [1] = 'burger',
	  },
	  ['Locking'] = false,
	  ['Locked'] = false,
	  ["Pickable"] = true,
	  ["Distance"] = 1.5,
	  ['ObjYaw'] =  245.00,
	  ['ObjName'] = 'k4mb1_door_pawn_main',
	  ['ObjCoords'] = vector3(182.26, -1319.10, 29.31)
   },
   [45] = {
	  ['DoorName'] = 'Pawn achter',
	  ['TextCoords'] = vector3(161.80, -1307.262, 29.35),
	  ['Autorized'] = {
	   [1] = 'burger',
	  },
	  ['Locking'] = false,
	  ['Locked'] = true,
	  ["Pickable"] = true,
	  ["Distance"] = 1.5,
	  ['ObjYaw'] =  -25.00,
	  ['ObjName'] = 'v_ilev_247_offdorr',
	  ['ObjCoords'] = vector3(161.80, -1307.262, 29.35)
   },
   [46] = {
	  ['DoorName'] = 'burgershot medewerker achteringang',
	  ['TextCoords'] = vector3(-1199.855, -903.53, 13.76),
	  ['Autorized'] = {
	   [1] = 'burger',
	  },
	  ['Locking'] = false,
	  ['Locked'] = true,
	  ["Pickable"] = true,
	  ["Distance"] = 1.5,
	--   ['ObjYaw'] =  0.00,
	  ['ObjName'] = 'bs_prop_door_staff_01',
	  ['ObjCoords'] = vector3(-1199.855, -903.53, 13.76)
   },

   -- Grote bank
   [47] = {
	  ['DoorName'] = 'Pacificbank deur 1',
	  ['TextCoords'] = vector3(256.4673, 229.0986, 101.6964),
	  ['Autorized'] = {
	   [1] = 'police',
	  },
	  ['Locking'] = false,
	  ['Locked'] = true,
	  ["Pickable"] = false,
	  ["Distance"] = 3.0,
	--   ['ObjYaw'] =  0.00,
	  ['ObjName'] = 'k4mb1_pac_door',
	  ['ObjCoords'] = vector3(256.4673, 229.0986, 101.6964)
   }, 
   [48] = {
	  ['DoorName'] = 'Pacificbank hal 1',
	  ['TextCoords'] = vector3(257.06085, 220.84403, 106.28543),
	  ['Autorized'] = {
	   [1] = 'police',
	  },
	  ['Heavy-Door'] = true,
	  ['Locking'] = false,
	  ['Locked'] = true,
	  ["Pickable"] = false,
	  ["Distance"] = 2.0,
	  ['ObjYaw'] =  -17.00,
	  ['ObjName'] = 'hei_v_ilev_bk_gate_pris',
	  ['ObjCoords'] = vector3(257.06085, 220.84403, 106.28543)
   }, 
   [49] = {
	  ['DoorName'] = 'Pacificbank hal 2',
	  ['TextCoords'] = vector3(261.65429, 222.13363, 106.2837),
	  ['Autorized'] = {
	   [1] = 'police',
	  },
	  ['Heavy-Door'] = true,
	  ['Locking'] = false,
	  ['Locked'] = true,
	  ["Pickable"] = false,
	  ["Distance"] = 2.0,
	--   ['ObjYaw'] =  -17.00,
	  ['ObjName'] = 'hei_v_ilev_bk_gate2_pris',
	  ['ObjCoords'] = vector3(261.65429, 222.13363, 106.2837)
   }, 
  								   -- End Grote bank 
	[50] = {
		['DoorName'] = 'Vanilla Unicorn Entree',
		['TextCoords'] = vector3(128.608, -1298.282, 29.24),
		['Autorized'] = {
		 [1] = 'vanilla',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = true,
		["Distance"] = 3.5,
		['ObjYaw'] = 37.0,
		['ObjName'] = 'prop_strip_door_01',
		['ObjCoords'] = vector3(128.608, -1298.282, 29.24)
	},
	[51] = {
		['DoorName'] = 'Vanilla Unicorn Dressior',
		['TextCoords'] = vector3(124.111, -1282.264, 29.27),
		['Autorized'] = {
		 [1] = 'vanilla',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = true,
		["Distance"] = 3.5,
		['ObjYaw'] = 10.0,
		['ObjName'] = 'ch_prop_casino_door_01c',
		['ObjCoords'] = vector3(124.111, -1282.264, 29.27)
	 },
	 [52] = {
		['DoorName'] = 'Vanilla Unicorn Baas',
		['TextCoords'] = vector3(103.0464, -1301.233, 29.26),
		['Autorized'] = {
		 [1] = 'vanilla',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = true,
		["Distance"] = 3.5,
		['ObjYaw'] = -60.0,
		['ObjName'] = 'ch_prop_casino_door_01c',
		['ObjCoords'] = vector3(103.0464, -1301.233, 29.26)
	 },
	 [53] = {
		['DoorName'] = 'Vanilla Unicorn Achterdeur',
		['TextCoords'] = vector3(97.416976, -1292.361, 29.28),
		['Autorized'] = {
		 [1] = 'vanilla',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = true,
		["Distance"] = 3.5,
		['ObjYaw'] = -60.0,
		['ObjName'] = 'ch_prop_casino_door_01c',
		['ObjCoords'] = vector3(97.416976, -1292.361, 29.28)
	},
								-- Politie New HB nieuwe deuren
	[54] = {
		['DoorName'] = 'Line up deur',
		['TextCoords'] = vector3(479.06, -1003.173, 26.4065),   
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = false,
		["Distance"] = 2.0,
		['ObjYaw'] = 90.00,
		['ObjName'] = 'gabz_mrpd_door_01',
		['ObjCoords'] = vector3(479.06, -1003.173, 26.4065)	 		
	 },

	 [55] = {
		['DoorName'] = 'Deur na lobby garage',
		['TextCoords'] = vector3(468.98776, -1000.549, 26.373983),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = true,
		["Distance"] = 2.0,
		['Doors'] = {
			[1] = {
			 ['ObjName'] = 'gabz_mrpd_door_01',
			 ['ObjYaw'] = 180.0,
			 ['ObjCoords'] = vector3(469.92, -1000.54, 26.40)
			},
			[2] = {
			 ['ObjName'] = 'gabz_mrpd_door_01',
			 ['ObjYaw'] =  0,
			 ['ObjCoords'] = vector3(467.52, -1000.54, 26.40)
		 },
		}
	},	
	[56] = {
		['DoorName'] = 'Deur na bewijs/lineup',
		['TextCoords'] = vector3(479.48464, -986.2446, 26.273277),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = true,
		["Distance"] = 2.0,
		['Doors'] = {
			[1] = {
			 ['ObjName'] = 'gabz_mrpd_door_02',
			 ['ObjYaw'] = 90.16,
			 ['ObjCoords'] = vector3(479.06, -987.43, 26.40)
			},
			[2] = {
			 ['ObjName'] = 'gabz_mrpd_door_02',
			 ['ObjYaw'] =  269.85,
			 ['ObjCoords'] = vector3(479.06, -985.03, 26.40)
		 },
		}
	},	
	[57] = {
		['DoorName'] = 'Mugshot',
		['TextCoords'] = vector3(475.04296, -1010.62, 26.311616),   
	   ['Autorized'] = {
		[1] = 'police',
		[2] = 'judge',
	   },
	   ['Locking'] = false,
	   ['Locked'] = true,
	   ["Pickable"] = true,
	   ["Distance"] = 2.0,
	   ['ObjYaw'] = 179.62,
	   ['ObjName'] = 'gabz_mrpd_door_04',
	   ['ObjCoords'] = vector3(475.95, -1010.81, 26.40)	 
	 
	},
	[58] = {
	   ['DoorName'] = 'Processing',
	   ['TextCoords'] = vector3(475.06857, -1007.399, 26.273302),   
	   ['Autorized'] = {
		[1] = 'police',
		[2] = 'judge',
	   },
	   ['Locking'] = false,
	   ['Locked'] = true,
	   ["Pickable"] = true,
	   ["Distance"] = 2.0,
	   ['ObjYaw'] = 179.88,
	   ['ObjName'] = 'gabz_mrpd_door_01',
	   ['ObjCoords'] = vector3(475.95, -1006.93, 26.40)	 
	 
	},
	[59] = {
		['DoorName'] = 'Observation I',
		['TextCoords'] = vector3(482.37655, -984.8576, 26.291194),   
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = false,
		["Distance"] = 2.0,
		['ObjYaw'] = 269.85,
		['ObjName'] = 'gabz_mrpd_door_04',
		['ObjCoords'] = vector3(482.6694, -983.9868, 26.40548)	 			
	 },
	 [60] = {
		['DoorName'] = 'Interrogation I',
		['TextCoords'] = vector3(482.17877, -988.4218, 26.273277),   
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = true,
		["Distance"] = 2.0,
		['ObjYaw'] = 269.85,
		['ObjName'] = 'gabz_mrpd_door_04',
		['ObjCoords'] = vector3(482.67, -987.57, 26.40)	 			
	 },
	 [61] = {
		['DoorName'] = 'Observation II',
		['TextCoords'] = vector3(482.43176, -993.1405, 26.366186),   
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = false,
		["Distance"] = 2.0,
		['ObjYaw'] = 269.85,
		['ObjName'] = 'gabz_mrpd_door_04',
		['ObjCoords'] = vector3(482.6699, -992.2991, 26.40548)	 
	  
	 },		
	 [62] = {
		['DoorName'] = 'Interrogation II',
		['TextCoords'] = vector3(482.25213, -996.4808, 26.273326),   
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = true,
		["Distance"] = 2.0,
		['ObjYaw'] = 269.85,
		['ObjName'] = 'gabz_mrpd_door_04',
		['ObjCoords'] = vector3(482.6703, -995.7285, 26.40548)	 
	  
	 },			  		 

	 [63] = {
		['DoorName'] = 'Poort Verdachte ingang',
		['TextCoords'] = vector3(488.8, -1020.2, 30.0),
		['Autorized'] = {
		[1] = 'police',
		[2] = 'judge',
	},
			['Locking'] = false,
			['Locked'] = true,
			["Pickable"] = false,
			["Distance"] = 14.0,
			['ObjYaw'] = 90.0,
			['ObjName'] = 'hei_prop_station_gate',
			['ObjCoords'] = vector3(488.8948, -1017.212, 27.14935)
	},
	[64] = {
		['DoorName'] = 'Dubbele Deur na wapenkluis',
		['TextCoords'] = vector3(469.2192, -986.1312, 30.786214),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = true,
		["Distance"] = 2.0,
		['Doors'] = {
			[1] = {
			 ['ObjName'] = 'gabz_mrpd_door_01',
			 ['ObjYaw'] = 269.92,
			 ['ObjCoords'] = vector3(469.44, -985.03, 30.82)
			},
			[2] = {
			 ['ObjName'] = 'gabz_mrpd_door_01',
			 ['ObjYaw'] =  90.15,
			 ['ObjCoords'] = vector3(469.44, -987.43, 30.82)
		 },
		}
	},		
	[65] = {
		['DoorName'] = 'Rooftop',
		['TextCoords'] = vector3(464.14971, -983.8411, 43.774711),
		['Autorized'] = {
		[1] = 'police',
		[2] = 'judge',
	},
			['Locking'] = false,
			['Locked'] = true,
			["Pickable"] = false,
			["Distance"] = 2.0,
			['ObjYaw'] = 90.66,
			['ObjName'] = 'gabz_mrpd_door_03',
			['ObjCoords'] = vector3(464.3086, -984.5284, 43.77124)
	},											
									-- End New politie hb	
-- Gevangenis Extra Deuren
[66] = {
	['DoorName'] = 'Gevangenis Gate 3',
	['TextCoords'] = vector3(1804.6993, 2615.624, 45.55339), 
	['Autorized'] = {
	 [1] = 'police',
	 [2] = 'judge',
	},
	['Locking'] = false,
	['Locked'] = true,
	["Pickable"] = true,
	["Distance"] = 11.0,
	['ObjYaw'] = 179.99,
	['ObjName'] = 'prop_gate_prison_01',
	['ObjCoords'] = vector3(1799.61, 2616.97, 44.60)
 },
 [67] = {
	['DoorName'] = 'Deur bij tussen ruimte buiten',
	['TextCoords'] = vector3(1796.5687, 2596.0566, 45.796127),
	['Autorized'] = {
	 [1] = 'police',
	 [2] = 'judge',
	},
	['Locking'] = false,
	['Locked'] = true,
	["Pickable"] = true,
	["Distance"] = 2,
	['ObjYaw'] = 181.48,
	['ObjName'] = 'prop_fnclink_03gate5',
	['ObjCoords'] = vector3(1797.76, 2596.56, 46.38)
 },
 [68] = {
	['DoorName'] = 'Gate 1 Tussen ruimte',
	['TextCoords'] = vector3(1833.475, 2692.7773, 45.430118),
	['Autorized'] = {
	 [1] = 'police',
	 [2] = 'judge',
	},
	['Locking'] = false,
	['Locked'] = true,
	["Pickable"] = true,
	["Distance"] = 4,
	['ObjYaw'] = 109.99,
	['ObjName'] = 'prop_gate_prison_01',
	['ObjCoords'] = vector3(1835.28, 2689.10, 44.44)
 },
 [69] = {
	['DoorName'] = 'Gate 2 Tussen ruimte',
	['TextCoords'] = vector3(1831.156, 2699.2285, 45.428592),
	['Autorized'] = {
	 [1] = 'police',
	 [2] = 'judge',
	},
	['Locking'] = false,
	['Locked'] = true,
	["Pickable"] = true,
	["Distance"] = 4,
	['ObjYaw'] = 289.16,
	['ObjName'] = 'prop_gate_prison_01',
	['ObjCoords'] = vector3(1830.13, 2703.5, 44.44)
 },
 [70] = {
	['DoorName'] = 'Gate 3 Tussen ruimte',
	['TextCoords'] = vector3(1772.0676, 2748.0524, 45.431034),
	['Autorized'] = {
	 [1] = 'police',
	 [2] = 'judge',
	},
	['Locking'] = false,
	['Locked'] = true,
	["Pickable"] = true,
	["Distance"] = 4,
	['ObjYaw'] = 160.00,
	['ObjName'] = 'prop_gate_prison_01',
	['ObjCoords'] = vector3(1776.70, 2747.14, 44.44)
 },
 [71] = {
	['DoorName'] = 'Gate 4 Tussen ruimte',
	['TextCoords'] = vector3(1765.2312, 2751.0207, 45.427448),
	['Autorized'] = {
	 [1] = 'police',
	 [2] = 'judge',
	},
	['Locking'] = false,
	['Locked'] = true,
	["Pickable"] = true,
	["Distance"] = 4,
	['ObjYaw'] = 339.62,
	['ObjName'] = 'prop_gate_prison_01',
	['ObjCoords'] = vector3(1762.19, 2752.49, 44.44)
 },
 [72] = {
	['DoorName'] = 'Gate 5 Tussen ruimte',
	['TextCoords'] = vector3(1658.0871, 2746.3898, 45.440666),
	['Autorized'] = {
	 [1] = 'police',
	 [2] = 'judge',
	},
	['Locking'] = false,
	['Locked'] = true,
	["Pickable"] = true,
	["Distance"] = 4,
	['ObjYaw'] = 207.17,
	['ObjName'] = 'prop_gate_prison_01',
	['ObjCoords'] = vector3(1662.01, 2748.70, 44.44) 
 },
 [73] = {
	['DoorName'] = 'Gate 6 Tussen ruimte',
	['TextCoords'] = vector3(1652.494, 2743.2133, 45.443908),
	['Autorized'] = {
	 [1] = 'police',
	 [2] = 'judge',
	},
	['Locking'] = false,
	['Locked'] = true,
	["Pickable"] = true,
	["Distance"] = 4,
	['ObjYaw'] = 27.17,
	['ObjName'] = 'prop_gate_prison_01',
	['ObjCoords'] = vector3(1648.41, 2741.66, 44.44) 
 },
 [74] = {
	['DoorName'] = 'Gate 7 Tussen ruimte',
	['TextCoords'] = vector3(1582.8048, 2676.333, 45.481754),
	['Autorized'] = {
	 [1] = 'police',
	 [2] = 'judge',
	},
	['Locking'] = false,
	['Locked'] = true,
	["Pickable"] = true,
	["Distance"] = 4,
	['ObjYaw'] = 233.70,
	['ObjName'] = 'prop_gate_prison_01',
	['ObjCoords'] = vector3(1584.65, 2679.75, 44.50) 
 },
 [75] = {
	['DoorName'] = 'Gate 8 Tussen ruimte',
	['TextCoords'] = vector3(1578.8055, 2670.309, 45.483646),
	['Autorized'] = {
	 [1] = 'police',
	 [2] = 'judge',
	},
	['Locking'] = false,
	['Locked'] = true,
	["Pickable"] = true,
	["Distance"] = 4,
	['ObjYaw'] = 54.54,
	['ObjName'] = 'prop_gate_prison_01',
	['ObjCoords'] = vector3(1575.71, 2667.15, 44.50) 
 },
 [76] = {
	['DoorName'] = 'Gate 9 Tussen ruimte',
	['TextCoords'] = vector3(1547.8594, 2587.9487, 45.388713),
	['Autorized'] = {
	 [1] = 'police',
	 [2] = 'judge',
	},
	['Locking'] = false,
	['Locked'] = true,
	["Pickable"] = true,
	["Distance"] = 4,
	['ObjYaw'] = 267.01,
	['ObjName'] = 'prop_gate_prison_01',
	['ObjCoords'] = vector3(1547.70, 2591.28, 44.50) 
 },
 [77] = {
	['DoorName'] = 'Gate 10 Tussen ruimte',
	['TextCoords'] = vector3(1547.809, 2580.0502, 45.393344),
	['Autorized'] = {
	 [1] = 'police',
	 [2] = 'judge',
	},
	['Locking'] = false,
	['Locked'] = true,
	["Pickable"] = true,
	["Distance"] = 4,
	['ObjYaw'] = 87.01,
	['ObjName'] = 'prop_gate_prison_01',
	['ObjCoords'] = vector3(1546.98, 2576.12, 44.38) 
 },
 [78] = {
	['DoorName'] = 'Gate 11 Tussen ruimte',
	['TextCoords'] = vector3(1553.7321, 2478.4792, 45.388282),
	['Autorized'] = {
	 [1] = 'police',
	 [2] = 'judge',
	},
	['Locking'] = false,
	['Locked'] = true,
	["Pickable"] = true,
	["Distance"] = 4,
	['ObjYaw'] = 298.04,
	['ObjName'] = 'prop_gate_prison_01',
	['ObjCoords'] = vector3(1550.93, 2482.74, 44.39) 
 },
 [79] = {
	['DoorName'] = 'Gate 12 Tussen ruimte',
	['TextCoords'] = vector3(1557.2692, 2472.1584, 45.387924),
	['Autorized'] = {
	 [1] = 'police',
	 [2] = 'judge',
	},
	['Locking'] = false,
	['Locked'] = true,
	["Pickable"] = true,
	["Distance"] = 4,
	['ObjYaw'] = 118.04,
	['ObjName'] = 'prop_gate_prison_01',
	['ObjCoords'] = vector3(1558.22, 2469.34, 44.39) 
 },
 [80] = {
	['DoorName'] = 'Gate 13 Tussen ruimte',
	['TextCoords'] = vector3(1656.107, 2409.8498, 45.406753),
	['Autorized'] = {
	 [1] = 'police',
	 [2] = 'judge',
	},
	['Locking'] = false,
	['Locked'] = true,
	["Pickable"] = true,
	["Distance"] = 4,
	['ObjYaw'] = 353.00,
	['ObjName'] = 'prop_gate_prison_01',
	['ObjCoords'] = vector3(1652.92, 2409.57, 44.44) 
 },
 [81] = {
	['DoorName'] = 'Gate 14 Tussen ruimte',
	['TextCoords'] = vector3(1663.9781, 2408.4934, 45.40105),
	['Autorized'] = {
	 [1] = 'police',
	 [2] = 'judge',
	},
	['Locking'] = false,
	['Locked'] = true,
	["Pickable"] = true,
	["Distance"] = 4,
	['ObjYaw'] = 173.00,
	['ObjName'] = 'prop_gate_prison_01',
	['ObjCoords'] = vector3(1667.67, 2407.65, 44.42) 
 },
 [82] = {
	['DoorName'] = 'Gate 15 Tussen ruimte',
	['TextCoords'] = vector3(1751.6209, 2421.7492, 45.422458),
	['Autorized'] = {
	 [1] = 'police',
	 [2] = 'judge',
	},
	['Locking'] = false,
	['Locked'] = true,
	["Pickable"] = true,
	["Distance"] = 4,
	['ObjYaw'] = 26.75,
	['ObjName'] = 'prop_gate_prison_01',
	['ObjCoords'] = vector3(1749.14, 2419.81, 44.42) 
 },
 [83] = {
	['DoorName'] = 'Gate 16 Tussen ruimte',
	['TextCoords'] = vector3(1759.3581, 2425.6823, 45.423049),
	['Autorized'] = {
	 [1] = 'police',
	 [2] = 'judge',
	},
	['Locking'] = false,
	['Locked'] = true,
	["Pickable"] = true,
	["Distance"] = 4,
	['ObjYaw'] = 206.12,
	['ObjName'] = 'prop_gate_prison_01',
	['ObjCoords'] = vector3(1762.54, 2426.50, 44.43) 
 },
 [84] = {
	['DoorName'] = 'Gate 17 Tussen ruimte',
	['TextCoords'] = vector3(1810.0235, 2477.9174, 45.445049),
	['Autorized'] = {
	 [1] = 'police',
	 [2] = 'judge',
	},
	['Locking'] = false,
	['Locked'] = true,
	["Pickable"] = true,
	["Distance"] = 4,
	['ObjYaw'] = 70.90,
	['ObjName'] = 'prop_gate_prison_01',
	['ObjCoords'] = vector3(1808.99, 2474.54, 44.48) 
 },
 [85] = {
	['DoorName'] = 'Gate 18 Tussen ruimte',
	['TextCoords'] = vector3(1812.387, 2486.5104, 45.445861),
	['Autorized'] = {
	 [1] = 'police',
	 [2] = 'judge',
	},
	['Locking'] = false,
	['Locked'] = true,
	["Pickable"] = true,
	["Distance"] = 4,
	['ObjYaw'] = 251.97,
	['ObjName'] = 'prop_gate_prison_01',
	['ObjCoords'] = vector3(1813.75, 2488.90, 44.46) 
 },


-- End Gevangenis Extra Deuren
-- Ambulance Extra deuren
[86] = {
		['DoorName'] = 'Adminstation Ambulance',
		['TextCoords'] = vector3(339.76431, -586.5017, 43.284095),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		 [3] = 'ambulance',		 
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = false,
		["Distance"] = 2,
		['ObjYaw'] = 340.00,
		['ObjName'] = 'gabz_pillbox_singledoor',
		['ObjCoords'] = vector3(339.00, -586.70, 44.43) 
	 },

[87] = {
		['DoorName'] = 'Mri Ambulance',
		['TextCoords'] = vector3(336.7965, -580.5773, 43.284088),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		 [3] = 'ambulance',		 
		},
		['Locking'] = false,
		['Locked'] = false,
		["Pickable"] = true,
		["Distance"] = 2,
		['ObjYaw'] = 340.00,
		['ObjName'] = 'gabz_pillbox_singledoor',
		['ObjCoords'] = vector3(336.16, -580.14, 44.43) 
	 },	

[88] = {
		['DoorName'] = 'X-ray Ambulance',
		['TextCoords'] = vector3(347.59606, -583.8252, 43.284088),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		 [3] = 'ambulance',		 
		},
		['Locking'] = false,
		['Locked'] = false,
		["Pickable"] = true,
		["Distance"] = 2,
		['ObjYaw'] = 339.74,
		['ObjName'] = 'gabz_pillbox_singledoor',
		['ObjCoords'] = vector3(346.77, -584.00, 44.43) 
	 },

[89] = {
		['DoorName'] = 'Receptie',
		['TextCoords'] = vector3(313.77502, -596.0397, 43.284072),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		 [3] = 'ambulance',		 
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = true,
		["Distance"] = 2,
		['ObjYaw'] = 249.74,
		['ObjName'] = 'gabz_pillbox_singledoor',
		['ObjCoords'] = vector3(313.48, -595.45, 43.43) 
	 },

[90] = {
		['DoorName'] = 'Receptie Staff Only',
		['TextCoords'] = vector3(308.52407, -597.095, 43.284072),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		 [3] = 'ambulance',		 
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = true,
		["Distance"] = 2,
		['ObjYaw'] = 159.75,
		['ObjName'] = 'gabz_pillbox_singledoor',
		['ObjCoords'] = vector3(309.13, -597.75, 43.43) 
	 },	

[91] = {
		['DoorName'] = 'Laboratory Staff Only',
		['TextCoords'] = vector3(307.7835, -570.2176, 43.284088),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		 [3] = 'ambulance',		 
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = false,
		["Distance"] = 2,
		['ObjYaw'] = 339.98,
		['ObjName'] = 'gabz_pillbox_singledoor',
		['ObjCoords'] = vector3(307.11, -569.56, 43.43) 
	 },

[92] = {
		['DoorName'] = 'Ambulance behandel ruimte (Ward A/B)',
		['TextCoords'] = vector3(325.90829, -579.2751, 43.284065),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		 [3] = 'ambulance',
		},
		['Locking'] = false,
		['Locked'] = false,
		["Pickable"] = true,
		["Distance"] = 2,
		['Doors'] = {
			[1] = {
			 ['ObjName'] = 'gabz_pillbox_doubledoor_r',
			 ['ObjYaw'] = 249.68,
			 ['ObjCoords'] = vector3(325.66, -580.45, 43.43)
			},
			[2] = {
			 ['ObjName'] = 'gabz_pillbox_doubledoor_l',
			 ['ObjYaw'] = 250.13,
			 ['ObjCoords'] = vector3(326.54, -578.04, 43.43)
			},
		 }
	 },

[93] = {
		['DoorName'] = 'Ambulance behandel ruimte (Ward C/B)',
		['TextCoords'] = vector3(326.48086, -579.3354, 43.28408),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		 [3] = 'ambulance',
		},
		['Locking'] = false,
		['Locked'] = false,
		["Pickable"] = true,
		["Distance"] = 2,
		['Doors'] = {
			[1] = {
			 ['ObjName'] = 'gabz_pillbox_doubledoor_r',
			 ['ObjYaw'] = 250.12,
			 ['ObjCoords'] = vector3(348.43, -588.74, 43.43)
			},
			[2] = {
			 ['ObjName'] = 'gabz_pillbox_doubledoor_l',
			 ['ObjYaw'] = 249.86,
			 ['ObjCoords'] = vector3(349.31, -586.32, 43.43)
			},
		 }
	 },	

[94] = {
		['DoorName'] = 'Ambulance Lift ruimte',
		['TextCoords'] = vector3(327.34069, -593.8452, 43.284103),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		 [3] = 'ambulance',
		},
		['Locking'] = false,
		['Locked'] = false,
		["Pickable"] = true,
		["Distance"] = 2,
		['Doors'] = {
			[1] = {
			 ['ObjName'] = 'gabz_pillbox_doubledoor_r',
			 ['ObjYaw'] = 249.84,
			 ['ObjCoords'] = vector3(327.25, -595.19, 43.43)
			},  
			[2] = {
			 ['ObjName'] = 'gabz_pillbox_doubledoor_l',
			 ['ObjYaw'] = 249.79,
			 ['ObjCoords'] = vector3(328.13, -592.77, 43.43)
			},
		 }
	 },	

[95] = {
		['DoorName'] = 'Ambulance O.K ruimte',
		['TextCoords'] = vector3(324.45159, -576.3568, 43.284088),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		 [3] = 'ambulance',
		},
		['Locking'] = false,
		['Locked'] = false,
		["Pickable"] = true,
		["Distance"] = 2,
		['Doors'] = {
			[1] = {
			 ['ObjName'] = 'gabz_pillbox_doubledoor_r',
			 ['ObjYaw'] = -20.0,
			 ['ObjCoords'] = vector3(325.65, -576.30, 43.43)
			}, 
			[2] = {
			 ['ObjName'] = 'gabz_pillbox_doubledoor_l',
			 ['ObjYaw'] = -20.0,
			 ['ObjCoords'] = vector3(323.23, -575.42, 43.43)
			},
		 }
	 },	

[96] = {
		['DoorName'] = 'Diag Staff Only',
		['TextCoords'] = vector3(341.31735, -582.3255, 43.284065),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		 [3] = 'ambulance',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = false,
		["Distance"] = 2,
		['ObjYaw'] = 339.98,
		['ObjName'] = 'gabz_pillbox_singledoor',
		['ObjCoords'] = vector3(340.78, -581.82, 43.43) 
	 },	

[97] = {
		['DoorName'] = 'Ambulance behandel ruimte (Ward B/main)',
		['TextCoords'] = vector3(325.19805, -589.6081, 43.288398),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		 [3] = 'ambulance',
		},
		['Locking'] = false,
		['Locked'] = false,
		["Pickable"] = true,
		["Distance"] = 2,
		['Doors'] = {
			[1] = {
			 ['ObjName'] = 'gabz_pillbox_doubledoor_r',
			 ['ObjYaw'] = 339.74,
			 ['ObjCoords'] = vector3(326.65, -590.10, 43.43)
			},
			[2] = {
			 ['ObjName'] = 'gabz_pillbox_doubledoor_l',
			 ['ObjYaw'] = 340.16,
			 ['ObjCoords'] = vector3(324.23, -589.22, 43.43)
			},
		 }
	 },	 
										-- Ambulance Extra deuren End
-- Politie HB Paleto
[98] = {
		['DoorName'] = 'Ingang cell 1 Paleto HB',
		['TextCoords'] = vector3(-438.6781, 6005.7075, 27.985612),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = true,
		["Distance"] = 2,
		['ObjYaw'] = 44.87,
		['ObjName'] = 'v_ilev_ph_cellgate1',
		['ObjCoords'] = vector3(-438.22, 6006.16, 28.13)
	 },

[99] = {
		['DoorName'] = 'Ingang cell 2 Paleto HB',
		['TextCoords'] = vector3(-442.941, 6009.8178, 27.985612),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = true,
		["Distance"] = 2,
		['ObjYaw'] = 44.98,
		['ObjName'] = 'v_ilev_ph_cellgate1',
		['ObjCoords'] = vector3(-442.10, 6010.05, 28.13)	   
	 },

[100] = {
		['DoorName'] = 'Cell Paleto HB',
		['TextCoords'] = vector3(-444.5569, 6011.352, 27.985609),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = true,
		["Distance"] = 2,
		['ObjYaw'] = 45.18,
		['ObjName'] = 'v_ilev_ph_cellgate1',
		['ObjCoords'] = vector3(-444.36, 6012.22, 28.13)	 
	 },

[101] = {
		['DoorName'] = 'Verhoor paleto',
		['TextCoords'] = vector3(-437.3365, 6002.5029, 27.98561),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = true,
		["Distance"] = 2,
		['ObjYaw'] = 45.0,
		['ObjName'] = 'v_ilev_arm_secdoor',
		['ObjCoords'] = vector3(-436.62, 6002.54, 28.14)
	 },

[102] = {
		['DoorName'] = 'Wapenkamer paleto',
		['TextCoords'] = vector3(-438.64, 5998.51, 31.71),
		['Autorized'] = {
		 [1] = 'police',
		 [2] = 'judge',
		},
		['Locking'] = false,
		['Locked'] = true,
		["Pickable"] = false,
		["Distance"] = 2,
		['ObjYaw'] = -135.0,
		['ObjName'] = 'v_ilev_arm_secdoor',
		['ObjCoords'] = vector3(-439.1576, 5998.157, 31.86815)
	 },

[103] = {
		 ['DoorName'] = 'Bewijsruimte Paleto HB',
		 ['TextCoords'] = vector3(-435.57, 6008.76, 27.98),
		 ['Autorized'] = {
		  [1] = 'police',
		  [2] = 'judge',
		 },
		 ['Locking'] = false,
		 ['Locked'] = true,
		 ["Pickable"] = false,
		 ["Distance"] = 2.5,
		 ['Doors'] = {
		 [1] = {
			 ['ObjName'] = 'v_ilev_ph_gendoor002',
			 ['ObjYaw'] = -135.0,
			 ['ObjCoords'] = vector3(-436.5157, 6007.844, 28.13839)
		 },
		 [2] = {
			 ['ObjName'] = 'v_ilev_ph_gendoor002',
			 ['ObjYaw'] =  45.0,
			 ['ObjCoords'] = vector3(-434.6776, 6009.681, 28.13839)
	 },
	 }
	 },

[104] = {
	['DoorName'] = 'achterdeur links Paleto HB',
	['TextCoords'] = vector3(-451.38, 6006.55, 31.84),
	['Autorized'] = {
	 [1] = 'police',
	 [2] = 'judge',
	},
	['Locking'] = false,
	['Locked'] = true,
	["Pickable"] = true,
	["Distance"] = 1,
	['ObjYaw'] = 135.0,
	['ObjName'] = 'v_ilev_rc_door2',
	['ObjCoords'] = vector3(-450.9664, 6006.086, 31.99004)
 },

[105] = {
	['DoorName'] = 'achterdeur rechts Paleto HB',
	['TextCoords'] = vector3(-446.77, 6001.84, 31.68),
	['Autorized'] = {
	 [1] = 'police',
	 [2] = 'judge',
	},
	['Locking'] = false,
	['Locked'] = true,
	["Pickable"] = true,
	["Distance"] = 1,
	['ObjYaw'] = -45.0,
	['ObjName'] = 'v_ilev_rc_door2',
	['ObjCoords'] = vector3(-447.2363, 6002.317, 31.84003)
 },

[106] = {
	 ['DoorName'] = 'deuren gang achterkant Paleto HB',
	 ['TextCoords'] = vector3(-448.67, 6007.52, 31.86523),
	 ['Autorized'] = {
	  [1] = 'police',
	  [2] = 'judge',
	 },
	 ['Locking'] = false,
	 ['Locked'] = true,
	 ["Pickable"] = true,
	 ["Distance"] = 2.5,
	 ['Doors'] = {
	 [1] = {
		 ['ObjName'] = 'v_ilev_rc_door2',
		 ['ObjYaw'] = 135.0,
		 ['ObjCoords'] = vector3(-447.7283, 6006.702, 31.86523)
	 },
	 [2] = {
		 ['ObjName'] = 'v_ilev_rc_door2',
		 ['ObjYaw'] =  -45.0,
		 ['ObjCoords'] = vector3(-449.5656, 6008.538, 31.86523)
 },
 }
 },  
 
[107] = {
	 ['DoorName'] = 'deuren gang lockers Paleto HB',
	 ['TextCoords'] = vector3(-441.6432, 6011.6064, 31.71639),
	 ['Autorized'] = {
	  [1] = 'police',
	  [2] = 'judge',
	 },
	 ['Locking'] = false,
	 ['Locked'] = true,
	 ["Pickable"] = false,
	 ["Distance"] = 2,
	 ['Doors'] = {
	 [1] = {
		 ['ObjName'] = 'v_ilev_rc_door2',
		 ['ObjYaw'] = 225.0,
		 ['ObjCoords'] = vector3(-441.0185, 6012.795, 31.86523)
	 },
	 [2] = {
		 ['ObjName'] = 'v_ilev_rc_door2',
		 ['ObjYaw'] =  45.0,
		 ['ObjCoords'] = vector3(-442.8578, 6010.958, 31.86523)
 },
 }
 }, 

[108] = {
	 ['DoorName'] = 'Wapenkamer paleto',
	 ['TextCoords'] = vector3(-441.0989, 5998.9946, 31.716432),
	 ['Autorized'] = {
	  [1] = 'police',
	  [2] = 'judge',
	 },
	 ['Locking'] = false,
	 ['Locked'] = true,
	 ["Pickable"] = false,
	 ["Distance"] = 1,
	 ['ObjYaw'] = 314.99,
	 ['ObjName'] = 'v_ilev_arm_secdoor',
	 ['ObjCoords'] = vector3(-440.42, 5998.60, 31.86815)
 },        
[109] = {
	 ['DoorName'] = 'Wapenkamer paleto',
	 ['TextCoords'] = vector3(-436.8145, 6003.0742, 31.716093),
	 ['Autorized'] = {
	  [1] = 'police',
	  [2] = 'judge',
	 },
	 ['Locking'] = false,
	 ['Locked'] = true,
	 ["Pickable"] = false,
	 ["Distance"] = 1,
	 ['ObjYaw'] = 135.0,
	 ['ObjName'] = 'v_ilev_arm_secdoor',
	 ['ObjCoords'] = vector3(-437.04, 6003.70, 31.86)
 },

[110] = {
	['DoorName'] = 'Deur kleedkamer HB',
	['TextCoords'] = vector3(-453.56, 6010.73, 31.71),
	['Autorized'] = {
	 [1] = 'police',
	 [2] = 'judge',
	},
	['Locking'] = false,
	['Locked'] = true,
	["Pickable"] = true,
	["Distance"] = 2,
	['ObjYaw'] = 45.0,
	['ObjName'] = 'v_ilev_rc_door2',
	['ObjCoords'] = vector3(-454.0435, 6010.243, 31.86106)
 },

 [111] = {
	['DoorName'] = 'Deur kleedkamer HB',
	['TextCoords'] = vector3(-450.15, 6015.96, 31.71),
	['Autorized'] = {
	 [1] = 'police',
	 [2] = 'judge',
	},
	['Locking'] = false,
	['Locked'] = true,
	["Pickable"] = true,
	["Distance"] = 2,
	['ObjYaw'] = -45.0,
	['ObjName'] = 'v_ilev_rc_door2',
	['ObjCoords'] = vector3(-450.7136, 6016.371, 31.86523)
	}, 

[112] = {
	 ['DoorName'] = 'deuren voorkant Paleto HB',
	 ['TextCoords'] = vector3(-441.6432, 6011.6064, 31.71639),
	 ['Autorized'] = {
	  [1] = 'police',
	  [2] = 'judge',
	 },
	 ['Locking'] = false,
	 ['Locked'] = true,
	 ["Pickable"] = false,
	 ["Distance"] = 2,
	 ['Doors'] = {
	 [1] = {
		 ['ObjName'] = 'v_ilev_rc_door2',
		 ['ObjYaw'] = 315.16,
		 ['ObjCoords'] = vector3(-442.6553, 6009.3, 31.87136)
	 },
	 [2] = {
		 ['ObjName'] = 'v_ilev_rc_door2',
		 ['ObjYaw'] =  135.06,
		 ['ObjCoords'] = vector3(-440.81, 6007.46, 31.87136)
 },
 }
 },     
									-- End Politie HB Paleto
								
}

