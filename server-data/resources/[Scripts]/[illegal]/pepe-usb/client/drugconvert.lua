local converting = false

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 0 )
    end
end

-- COKE BRICK >> COKE (10G)
RegisterNetEvent("BrickToCoke10g")
AddEventHandler("BrickToCoke10g", function()
    if converting then
      return
    end
    converting = true
	if not IsPedInAnyVehicle(PlayerPedId()) then
		loadAnimDict("anim@amb@business@coc@coc_unpack_cut@")
		TaskPlayAnim(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter", 1.0, 1.0, -1, 1, -1, 0, 0, 0)
		Progressbar(5000,"Cocaïne brick snijden tot 10g's")
		StopAnimTask(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter", 1.0)
	end
    converting = false
end)

-- COKE (10G) >> COKE (1G)
RegisterNetEvent("Coke10gToCoke1g")
AddEventHandler("Coke10gToCoke1g", function()
    if converting then
      return
    end
    converting = true
	if not IsPedInAnyVehicle(PlayerPedId()) then
		loadAnimDict("anim@amb@business@coc@coc_unpack_cut@")
		TaskPlayAnim(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter", 1.0, 1.0, -1, 1, -1, 0, 0, 0)
		Progressbar(5000,"10g's cocaïne sorteren in 1g's")
		StopAnimTask(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter", 1.0)
	end
    converting = false
end)

-- METH BRICK >> METH (10G)
RegisterNetEvent("BrickToMeth10g")
AddEventHandler("BrickToMeth10g", function()
    if converting then
      return
    end
    converting = true
	if not IsPedInAnyVehicle(PlayerPedId()) then
		loadAnimDict("anim@amb@business@coc@coc_unpack_cut@")
		TaskPlayAnim(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter", 1.0, 1.0, -1, 1, -1, 0, 0, 0)
		Progressbar(5000,"Meth brick snijden tot 10g's")
		StopAnimTask(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter", 1.0)
	end
    converting = false
end)

-- METH (10G) >> METH (1G)
RegisterNetEvent("Meth10gToMeth1g")
AddEventHandler("Meth10gToMeth1g", function()
    if converting then
      return
    end
    converting = true
	if not IsPedInAnyVehicle(PlayerPedId()) then
		loadAnimDict("anim@amb@business@coc@coc_unpack_cut@")
		TaskPlayAnim(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter", 1.0, 1.0, -1, 1, -1, 0, 0, 0)
		Progressbar(5000,"10g's meth sorteren in 1g's")
		StopAnimTask(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter", 1.0)
	end
    converting = false
end)