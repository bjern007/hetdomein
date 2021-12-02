Framework = nil

sendMail = false

local jobid = math.random(1,1)
TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)


RegisterServerEvent('pepe-secretjob:server:SignIn')
AddEventHandler('pepe-secretjob:server:SignIn', function()
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    if Player.Functions.RemoveMoney('cash', Config.DefaultPrice, "secretjob") then
        Framework.Functions.ExecuteSql(false, "INSERT INTO `jobs_secret` (`cid`, `recieved`) VALUES (@cid, @recieved)", {
            ['@cid'] = Player.PlayerData.citizenid,
            ['@recieved'] = '1',
        })
        TriggerClientEvent("pepe-secretjob:client:SignIn", src)
    else
        TriggerClientEvent('Framework:Notify', src, 'Niet genoeg inleg.', 'error')
    end
end)

Citizen.CreateThread(function()
    local src = source
    local hour2 = "21:10"
	while true do
        
curTime = os.time();

    local tijd = os.date('%H:%M', curTime)
 Citizen.Wait(22000)
--  print(tijd)
    if (tijd == hour2) then
        if not sendMail then
            -- print(sendMail)
            for k, v in pairs(Framework.Functions.GetPlayers()) do
                local Player = Framework.Functions.GetPlayer(v)
                    if Player ~= nil then
                            local missionHeader = Config.Jobs[jobid]["label"];
                            local missionText = Config.Jobs[jobid]["bericht"];
                            TriggerClientEvent('pepe-secretjob:sendmail', -1, missionHeader, missionText)
                            sendMail = true
                            -- print('Mail send')
                        Citizen.Wait(1000)
                    end                    
            -- print(sendMail)
	        end
        end
    end
end)

Framework.Commands.Add("startjob", "Start secret job", {}, false, function(source, args)
    local src = source
    for k, v in pairs(Framework.Functions.GetPlayers()) do
        local Player = Framework.Functions.GetPlayer(v)
        if Player ~= nil then
            -- Framework.Functions.ExecuteSqlOld(true, "SELECT * FROM `jobs` WHERE `cid` = '"..Player.PlayerData.citizenid.."'", function(result)
            --     if (result[1] ~= nil) then

                -- else
                -- TriggerClientEvent('Framework:Notify', src, 'Nieuwe secretjob is verstuurd, helaas ben je niet uitgekozen.', 'error')
                -- end
            --end)
        end
        sendMail = true
    end
    local missionHeader = Config.Jobs[jobid]["label"];
    local missionText = Config.Jobs[jobid]["bericht"];
    TriggerClientEvent('pepe-secretjob:sendmail', -1, missionHeader, missionText)

    if sendMail then

    else
        TriggerClientEvent('Framework:Notify', src, 'Iets is fout gegaan in de mail', 'error')
    end
end)

AddEventHandler('playerDropped', function()
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    Framework.Functions.ExecuteSql(false, "DELETE FROM `jobs_secret` where `cid` = @cid", {
        ['@cid'] = Player.PlayerData.citizenid,
    })
 end)
-- AddEventHandler('onResourceStart', function()
--         Framework.Functions.ExecuteSqlOld(false, "TRUNCATE `jobs_secret`")
--         print("Table jobs getruncate")
--  end)