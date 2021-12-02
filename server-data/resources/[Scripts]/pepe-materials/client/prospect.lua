local MapIsOpen = false

local blip_location = vector3(1580.9, 6592.204, 13.84828)
local blip = nil
local area_blip = nil
local area_size = 100.0
-- Work created by Jasper.
-- Bought officialy as supporting the creator by: HighDevelopment


RegisterNetEvent("r3_prospecting:Toggle")
AddEventHandler("r3_prospecting:Toggle", function()
    if not MapIsOpen then
        AddTextEntry("BLIP_TXT", Config.ProspectingBlipText)
        blip = AddBlipForCoord(blip_location)
        SetBlipSprite(blip, Config.ProspectingBlipSprite)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("BLIP_TXT")
        EndTextCommandSetBlipName(blip)
        area_blip = AddBlipForRadius(blip_location, area_size)
        SetBlipSprite(area_blip, Config.ProspectingAreaSprite)
        SetBlipColour(blip, Config.ProspectingBlipColor)
        SetBlipColour(area_blip, Config.ProspectingAreaColor)
        SetBlipAlpha(area_blip, Config.ProspectingAreaAlpha)
        MapIsOpen = true
    else
        RemoveBlip(area_blip)
        RemoveBlip(blip)
        MapIsOpen = false
    end
end)

RegisterNetEvent("r3_prospecting:startProspecting")
AddEventHandler("r3_prospecting:startProspecting", function()
    local pos = GetEntityCoords(PlayerPedId())

    -- Make sure the player is within the prospecting zone before they start
    local dist = #(pos - blip_location)
    if dist < area_size and MapIsOpen then
        TriggerServerEvent("r3_prospecting:activateProspecting")
    else
		Notify("Je bevind je niet in een Treasure locatie", "error", 5000)
	end
end, false)

RegisterNetEvent("r3_prospecting:useDetector")
AddEventHandler("r3_prospecting:useDetector", function()
	if IsPedInAnyVehicle(PlayerPedId()) then
		Notify("You can not prospect from a vehicle!", "error", 5000)
	else
		TriggerEvent("r3_prospecting:startProspecting")
	end
end)

RegisterNetEvent("r3_prospecting:OpenMap")
AddEventHandler("r3_prospecting:OpenMap", function()
    print("r3_prospecting: Opening map")
    blip_location = Config.BaseLocations[math.random(#Config.BaseLocations)]
    TriggerServerEvent("r3_prospecting:UpdateBase", blip_location)
    TriggerEvent("r3_prospecting:MapAnimation")
    Citizen.Wait(2000)
    TriggerEvent("r3_prospecting:Toggle")
    Notify("Je opende de Treasure map. Ga naar de locatie en zoek in de omgeving", "primary", 5000)
    Citizen.Wait(5000)
    TriggerEvent("r3_prospecting:MapAnimation")
end)

RegisterNetEvent("r3_prospecting:CloseMap")
AddEventHandler("r3_prospecting:CloseMap", function()
    print("r3_prospecting: Closing map")
    TriggerEvent("r3_prospecting:Toggle")
end)


local holdingMap = false
local mapModel = "prop_tourist_map_01"
local animDict = "amb@world_human_tourist_map@male@base"
local animName = "base"
local map_net = nil

-- Toggle Map --

RegisterNetEvent("r3_prospecting:MapAnimation")
AddEventHandler("r3_prospecting:MapAnimation", function()
    if not holdingMap then
        RequestModel(GetHashKey(mapModel))
        while not HasModelLoaded(GetHashKey(mapModel)) do
            Citizen.Wait(100)
        end

        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Citizen.Wait(100)
        end

        local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
        local mapspawned = CreateObject(GetHashKey(mapModel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
        Citizen.Wait(1000)
        local netid = ObjToNet(mapspawned)
        SetNetworkIdExistsOnAllMachines(netid, true)
        NetworkSetNetworkIdDynamic(netid, true)
        SetNetworkIdCanMigrate(netid, false)
        AttachEntityToEntity(mapspawned, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
        TaskPlayAnim(GetPlayerPed(PlayerId()), 1.0, -1, -1, 50, 0, 0, 0, 0) -- 50 = 32 + 16 + 2
        TaskPlayAnim(GetPlayerPed(PlayerId()), animDict, animName, 1.0, -1, -1, 50, 0, 0, 0, 0)
        map_net = netid
        holdingMap = true
    else
        ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
        DetachEntity(NetToObj(map_net), 1, 1)
        DeleteObject(NetToObj(map_net))
        map_net = nil
        holdingMap = false
    end
end)

function Notify(v, type, duration)
    Framework.Functions.Notify(v, type, duration)
end