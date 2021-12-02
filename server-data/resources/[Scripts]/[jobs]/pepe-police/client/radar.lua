local radar =
{
	shown = false,
	freeze = false,
	info = "----------   --- Km/h",
	info2 = "----------   --- Km/h",
	minSpeed = 5.0,
	maxSpeed = 75.0,
}

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end

RegisterCommand("radar", function()
    if radar.shown then 
        radar.shown = false 
        radar.info = string.format("----------   --- Km/h")
        radar.info2 = string.format("----------   --- Km/h")
    else 
        radar.shown = true 
    end        
    Wait(75)
end)

Citizen.CreateThread( function()
	
	while true do
		Wait(0)
		if IsControlJustPressed(1, 118) and IsPedInAnyPoliceVehicle(PlayerPedId()) then
			if radar.freeze then radar.freeze = false else radar.freeze = true end
		end
		if radar.shown  then
			if radar.freeze == false then
				local veh = GetVehiclePedIsIn(PlayerPedId(), false)
				local coordA = GetOffsetFromEntityInWorldCoords(veh, 0.0, 1.0, 1.0)
				local coordB = GetOffsetFromEntityInWorldCoords(veh, 0.0, 105.0, 0.0)
				local frontcar = StartShapeTestCapsule(coordA, coordB, 3.0, 10, veh, 7)
				local a, b, c, d, e = GetShapeTestResult(frontcar)
					
				if IsEntityAVehicle(e) then
						
					local fvspeed = GetEntitySpeed(e)*3.6
					local fplate = GetVehicleNumberPlateText(e)
					radar.info = string.format("%s   %s Km/h", fplate, math.ceil(fvspeed))
				end
					
				local bcoordB = GetOffsetFromEntityInWorldCoords(veh, 0.0, -105.0, 0.0)
				local rearcar = StartShapeTestCapsule(coordA, bcoordB, 3.0, 10, veh, 7)
				local f, g, h, i, j = GetShapeTestResult(rearcar)
					
				if IsEntityAVehicle(j) then
					
					local bvspeed = GetEntitySpeed(j)*3.6
					local bplate = GetVehicleNumberPlateText(j)
					radar.info2 = string.format("%s   %s Km/h", bplate, math.ceil(bvspeed))
				end
			end
			DrawRect(0.250, 0.83, 0.15, 0.116, 0, 0, 0, 100) -- esquerda , cima, direita , baixo
			DrawAdvancedText(0.345, 0.793, 0.005, 0.0028, 0.4, "Radar Frontal", 0, 153, 51, 255, 6, 0)
			DrawAdvancedText(0.345, 0.843, 0.005, 0.0028, 0.4, "Radar Traseira", 0, 153, 51, 255, 6, 0)
			DrawAdvancedText(0.345, 0.813, 0.005, 0.0028, 0.55, radar.info, 255, 255, 255, 255, 6, 0)
			DrawAdvancedText(0.345, 0.863, 0.005, 0.0028, 0.55, radar.info2, 255, 255, 255, 255, 6, 0)
		end
		if(not IsPedInAnyVehicle(PlayerPedId())) then
			radar.shown = false
			radar.info = string.format("----------   --- Km/h")
			radar.info2 = string.format("----------   --- Km/h")
		end
	end
end)