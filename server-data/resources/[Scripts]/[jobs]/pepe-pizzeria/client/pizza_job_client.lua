local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local isLoggedIn = false
local PlayerData = {}
local PlayerJob = {}
Framework = exports["pepe-core"]:GetCoreObject()

RegisterNetEvent('Framework:Client:OnPlayerLoaded')
AddEventHandler('Framework:Client:OnPlayerLoaded', function()
    PlayerJob = Framework.Functions.GetPlayerData().job
	isLoggedIn = true    
end)

RegisterNetEvent('Framework:Client:OnPlayerUnload')
AddEventHandler('Framework:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('Framework:Client:OnJobUpdate')
AddEventHandler('Framework:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

local DropOffs = {
	[1] =  { ['x'] = 142.79,['y'] = -832.47,['z'] = 31.18,['h'] = 0.0, ['info'] = 'Blokkenpark mansion richard'},
	[2] =  { ['x'] = -122.49,['y'] = -887.97,['z'] = 29.67,['h'] = 0.0, ['info'] = 'ALTA STREET'},
	[3] =  { ['x'] = 372.65,['y'] = -1073.33,['z'] = 29.73,['h'] = 0.0, ['info'] = 'Downtown liquor'},
	[4] =  { ['x'] = 494.03,['y'] = -729.42,['z'] = 24.89,['h'] = 0.0, ['info'] = 'Material Wealth'},
	[5] =  { ['x'] = 222.38,['y'] = -595.41,['z'] = 43.87,['h'] = 0.0, ['info'] = 'Swiss Street'},
	[6] =  { ['x'] = 269.02,['y'] = -433.34,['z'] = 45.32,['h'] = 0.0, ['info'] = 'Atlee Street 1'},
	[7] =  { ['x'] = 241.06,['y'] = -1378.91,['z'] = 33.74,['h'] = 0.0, ['info'] = 'Cursade road'},
	--[8] =  { ['x'] = -657.77,['y'] = -679.26,['z'] = 31.47,['h'] = 0.0, ['info'] = 'Palomino Avenue 1'},
	--[9] =  { ['x'] = -814.18,['y'] = -1114.65,['z'] = 11.18,['h'] = 0.0, ['info'] = 'South Rockford Drive 1'},
	--[10] =  { ['x'] = -697.63,['y'] = -1182.29,['z'] = 10.71,['h'] = 0.0, ['info'] = 'South Rockford Drive 2'},
	--[11] =  { ['x'] = -1268.93,['y'] = -877.842,['z'] = 11.93,['h'] = 0.0, ['info'] = 'San Andreas 1'},
	--[12] =  { ['x'] = -601.30,['y'] = 279.34,['z'] = 82.03,['h'] = 0.0, ['info'] = 'West Eclipse Boulevard 1'},
	--[13] =  { ['x'] = -257.57,['y'] = 245.03,['z'] = 91.87,['h'] = 0.0, ['info'] = 'West Eclipse Boulevard 2'},
	--[14] =  { ['x'] = -1469.06,['y'] = -197.62,['z'] = 48.83,['h'] = 0.0, ['info'] = 'Cougar Avenue 1'},
	--[15] =  { ['x'] = -1580.60,['y'] = -34.07,['z'] = 57.56,['h'] = 0.0, ['info'] = 'Sam Austin Dr 1'},
	--[16] =  { ['x'] = -458.23,['y'] = 264.30,['z'] = 83.14,['h'] = 0.0, ['info'] = 'Eclipse Boulevard 1'},
	--[17] =  { ['x'] = 751.50,['y'] = 223.92,['z'] = 87.42,['h'] = 0.0, ['info'] = 'Clinton Avenue 1'},
	--[18] =  { ['x'] = 1199.87,['y'] = -501.53,['z'] = 65.17,['h'] = 0.0, ['info'] = 'Mirror Park Boulevard 1'},
}

local pizzaShop = {
	[1] =  { ['x'] = 292.09,['y'] = -984.84,['z'] = 29.43,['h'] = 0.0, ['info'] = 'pizzeria'},
}

-- Code
local JobBusy = false
local Tasks = false
local rnd = 0

RegisterNetEvent('pepe-pizzeria:client:bezorgen')
AddEventHandler('pepe-pizzeria:client:bezorgen', function(PidId)
	Framework.Functions.TriggerCallback('Framework:HasItem', function(HasItem)
		if JobBusy == false then
			if HasItem then
			    JobBusy = true
		        TriggerServerEvent('pepe-pizza:server:start:black')
				TriggerServerEvent('pepe-pizzeria:server:rem:pizza')
			else
                Framework.Functions.Notify("Ga je een lege doos bezorgen??", "error")			
            end				
           			
		else
			Framework.Functions.Notify("U heeft nog een bestelign openstaan!", "error")
		end 
 	end, 'pizza')
	
end)




RegisterNetEvent('pepe-pizza:start:black:job')
AddEventHandler('pepe-pizza:start:black:job', function()
	rnd = math.random(1,#DropOffs)
	CreateBlip()
	Framework.Functions.Notify("Lever deze pizza af bij "..DropOffs[rnd]["info"], "success", 10000)
	if Tasks then
		return
	end
	Tasks = true
	while Tasks do
		Citizen.Wait(1)
		local pos = GetEntityCoords(PlayerPedId(), false)
		local Gebied = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, DropOffs[rnd]["x"], DropOffs[rnd]["y"], DropOffs[rnd]["z"], false)
		if Gebied <= 5.0 then
			DrawText3D(DropOffs[rnd]["x"], DropOffs[rnd]["y"], DropOffs[rnd]["z"]+0.1, '~g~E~s~ - Bezorgen') 
			DrawMarker(2, DropOffs[rnd]["x"], DropOffs[rnd]["y"], DropOffs[rnd]["z"], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 155, false, false, false, true, false, false, false)
				if IsControlJustReleased(0,38) then
					if not IsPedInAnyVehicle(PlayerPedId(), false) then
						EndJob()
					else
			        	Framework.Functions.Notify("Je kunt niet bezorgen in je voertuig.", "error")
				end
			end
		else
			Citizen.Wait(2000)
		end
	end
end)




function Animatie()
	loadAnimDict( "mp_safehouselost@" )
    TaskPlayAnim( PlayerPedId(), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end 

function DeleteBlip()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
	end
end

function CreateBlip()
	if JobBusy then
	blip = AddBlipForCoord(DropOffs[rnd]["x"],DropOffs[rnd]["y"],DropOffs[rnd]["z"])
	end
	SetNewWaypoint(DropOffs[rnd]["x"], DropOffs[rnd]["y"])
	SetBlipSprite(blip, 501)
	SetBlipScale(blip, 0.9)
	SetBlipColour(blip, 48) 
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Bezorg Adres")
    EndTextCommandSetBlipName(blip)
end

function EndJob()
	Framework.Functions.TriggerCallback('Framework:HasItem', function(HasItem)
		if JobBusy == true and HasItem then
			Tasks = false
			JobBusy = false
			TriggerEvent('pepe-sound:client:play', 'house-doorbell', 0.5)
			Citizen.Wait(1000)
			Animatie()
			Citizen.Wait(200)
			DeleteBlip()
			TriggerServerEvent('pepe-pizza:server:reward:money')
			TriggerServerEvent('pepe-pizza:server:set:pizza:count', 'Plus', 'register', math.random(100,200))    
		else
			Framework.Functions.Notify("Je hebt de bestelling niet eens meegenomen.", "error")
		end 
 	end, 'pizza-doos')
end

-- Functions 

DrawText3D = function(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local scale = 0.30
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
	end
end