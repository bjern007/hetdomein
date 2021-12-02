local Framework;
local CIDS = {};
local Members = {};
local Accounts = {};
TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)

RegisterServerEvent("gangs:init")
AddEventHandler("gangs:init", function()
    local src = source
    local xPlayer = Framework.Functions.GetPlayer(src)
    local CID = xPlayer.PlayerData.citizenid
    if xPlayer then
        CIDS[src] = CID
        local char = xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname
        local results = Framework.Functions.ExecuteSql(true, "SELECT * FROM `gangs_members` WHERE `cid` = @cid", {
            ['@cid'] = CID,
        })
        local gang = { name = "none", grade = "none", char = char }
        
        if results[1] then
            gang =  { name = results[1].gang, grade = results[1].grade, char = char, id = CID }
            Members[CID] = gang
            Framework.Functions.ExecuteSql(true, "UPDATE `gangs_members` SET `char` = @char WHERE `cid` = @cid", {
                ['@char'] = char,
                ['@cid'] = CID,
            })
        end

        TriggerClientEvent("gangs:settings", src, Settings, gang)
        if gang.name ~= "none" then
            TriggerClientEvent("gangs:notify", -1, "fas fa-user", char .. " net aangekomen.", gang.name)
        end
    end
end)

RegisterServerEvent("gangs:refreshNearby")
AddEventHandler("gangs:refreshNearby", function(players)
    local src = source
    local xPlayer = Framework.Functions.GetPlayer(src)
    local xCID = xPlayer.PlayerData.citizenid
    local xGang = Members[xCID]
    local members = {}

    for k,v in pairs(players) do
        local player = Framework.Functions.GetPlayer(v)
        if player then
            local CID = player.PlayerData.citizenid
            local gang = Members[CID]
            local char = player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname
            if not gang or gang.name ~= xGang.name then
                members[#members+1] = { name = char, id = CID }
            end
        end
    end

    TriggerClientEvent("gangs:refreshNearby", src, members)
end)

RegisterNetEvent("gangs:refreshMembers")
AddEventHandler("gangs:refreshMembers", function(src)
    local src = src ~= nil and src or source
    local xPlayer = Framework.Functions.GetPlayer(src)
    local CID = xPlayer.PlayerData.citizenid
    local gang = Members[CID]
    local members = {}

    for k,v in pairs(Members) do
        local index = Settings.Grades[gang.grade]
        local xIndex = Settings.Grades[v.grade]
        if v.name == gang.name then
            local data = v
            data['editable'] = (k ~= CID and index and xIndex and index > xIndex) == true and "1" or "0"
            members[#members+1] = data
        end
    end

    TriggerClientEvent("gangs:refreshMembers", src, members)
end)

RegisterNetEvent("gangs:updateGrade")
AddEventHandler("gangs:updateGrade", function(member, grade)
    local src = source
    local xPlayer = Framework.Functions.GetPlayer(src)
    local xCID = xPlayer.PlayerData.citizenid
    local xGang = Members[xCID]

    local char = nil
    local xTarget = Framework.Functions.GetPlayerByCitizenId(member)
    if xTarget then
        char = xTarget.PlayerData.charinfo.firstname .. " " .. xTarget.PlayerData.charinfo.lastname
    else
        local results = Framework.Functions.ExecuteSql(true, "SELECT * FROM `gangs_members` WHERE `cid` = @cid", {
            ['@cid'] = member,
        })
        if results[1] then
            char = results[1].char
        end
    end

    if char then
        local gang = { name = xGang.name, grade = grade, char = char, id = member }

        if grade ~= "none" then
            if Framework.Functions.ExecuteSql(true, "UPDATE `gangs_members` SET `gang` = @gang, `grade` = @grade, `char` = @char WHERE `cid` = @cid", {
                ['@gang'] = xGang.name,
                ['@grade'] = grade,
                ['@char'] = char,
                ['@cid'] = member,
            })['affectedRows'] <= 0 then
                -- Framework.Functions.ExecuteSqlOld(false, "INSERT INTO `gangs_members` (`cid`, `gang`, `grade`, `char`) VALUES ('" .. member .. "','" .. xGang.name .. "', '" .. grade .. "', '" .. char .. "')")
                Framework.Functions.ExecuteSql(false, "INSERT INTO `gangs_members` (`cid`, `gang`, `grade`, `char`) VALUES (@cid, @gang, @grade, @char)", {
                    ['@cid'] = member,
                    ['@gang'] = xGang.name,
                    ['@grade'] = grade,
                    ['@char'] = char,
                })
            end
    
            Members[member] = gang
        else
            Members[member] = nil
            Framework.Functions.ExecuteSql(false, "DELETE FROM `gangs_members` WHERE `cid` = @cid", {
                ['@cid'] = member,
            })
        end
    
        if xTarget then
            TriggerClientEvent("gangs:refresh", xTarget.PlayerData.source, gang)
        end
    
        TriggerEvent("gangs:refreshMembers", src)
    end
end)

RegisterNetEvent("gangs:refreshMoney")
AddEventHandler("gangs:refreshMoney", function()
    local src = source
    local xPlayer = Framework.Functions.GetPlayer(src)
    local xCID = xPlayer.PlayerData.citizenid
    local xGang = Members[xCID]
    local money = Accounts[xGang.name]

    if money then
        TriggerClientEvent("gangs:refreshMoney", src, xGang.name, money)
    end
end)

RegisterNetEvent("gangs:saveMoney")
AddEventHandler("gangs:saveMoney", function()
    local src = source
    local xPlayer = Framework.Functions.GetPlayer(src)
    local xCID = xPlayer.PlayerData.citizenid
    local xGang = Members[xCID]
    local money = Accounts[xGang.name]

    if money then
        if Framework.Functions.ExecuteSql(true, "UPDATE `gangs_money` SET `amount` = @amount WHERE `gang` = @gang", {
            ['@amount'] = money,
            ['@gang'] = xGang.name,
        })['affectedRows'] <= 0 then
            Framework.Functions.ExecuteSql(false, "INSERT INTO `gangs_money` (`gang`, `amount`) VALUES (@gang, @amount)", {
                ['@gang'] = xGang.name,
                ['@amount'] = money,
            })
        end
    end
end)

RegisterNetEvent("gangs:withdraw")
AddEventHandler("gangs:withdraw", function(amount)
    local src = source
    local xPlayer = Framework.Functions.GetPlayer(src)
    local xCID = xPlayer.PlayerData.citizenid
    local xGang = Members[xCID]
    local money = Accounts[xGang.name] or 0

    local new = money - amount
    if not (new < 0) then
        xPlayer.Functions.AddMoney("cash", amount)
        Accounts[xGang.name] = new
        TriggerClientEvent("gangs:refreshMoney", -1, xGang.name, Accounts[xGang.name])
    end
end)

RegisterNetEvent("gangs:deposit")
AddEventHandler("gangs:deposit", function(amount)
    local src = source
    local xPlayer = Framework.Functions.GetPlayer(src)
    local xCID = xPlayer.PlayerData.citizenid
    local xGang = Members[xCID]
    local money = Accounts[xGang.name] or 0
    if xPlayer.Functions.RemoveMoney("cash", amount) then
        Accounts[xGang.name] = money + amount
        TriggerClientEvent("gangs:refreshMoney", -1, xGang.name, Accounts[xGang.name])
    end
end)

Framework.Commands.Add("bende", "Controleer je bende.", {}, true, function(source, args)
    local src = source
    local CID = CIDS[src]
    if CID and Members[CID] then
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div class="chat-message" style="background-color: rgba(219, 52, 235, 0.75);"><b>Bende Stats:</b> {0} | {1}</div>',
            args = { Members[CID].name, Members[CID].grade }
        })
    end
end)

Framework.Commands.Add("geefbende", "Geef een bende aan een speler.", {{name="id", help="Speler ID"}, {name="gang", help="Bende naam"}, {name="grade", help="Gradatie"}}, true, function(source, args)
    local src = source
    local id = tonumber(args[1])
    local Player = Framework.Functions.GetPlayer(id)
    local Gang = Settings.Gangs[args[2]]
    local Grade = Settings.Grades[args[3]]
    if Player ~= nil then
        local CID = Player.PlayerData.citizenid
        --if Gang ~= nil and Grade ~= nil then
            local char = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
            local gang = { name = args[2], grade = args[3], char = char, id = CID }
            Members[CID] = gang
            TriggerClientEvent("gangs:refresh", id, gang)
            TriggerClientEvent('chat:addMessage', src, {template = '<div class="chat-message" style="background-color: green;"><b>ADMIN</b> Bende bijgewerkt!</div>'})
            if args[2] ~= "none" then
                if Framework.Functions.ExecuteSql(true, "UPDATE `gangs_members` SET `gang` = @gang, `grade` = @grade, `char` = @char WHERE `cid` = @cid", {
                    ['@gang'] = args[2],
                    ['@grade'] = args[3],
                    ['@char'] = char,
                    ['@cid'] = CID,
                })['affectedRows'] <= 0 then
                    Framework.Functions.ExecuteSql(false, "INSERT INTO `gangs_members` (`cid`, `gang`, `grade`, `char`) VALUES (@cid, @gang, @grade, @char)", {
                        ['@cid'] = CID,
                        ['@gang'] = args[2],
                        ['@grade'] = args[3],
                        ['@char'] = char,
                    })
                end
            else
                Members[CID] = nil
                Framework.Functions.ExecuteSql(false, "DELETE FROM `gangs_members` WHERE `cid` = @cid", {
                    ['@cid'] = CID,
                })
            end
        --else
        --    TriggerClientEvent('chat:addMessage', src, {template = '<div class="chat-message" style="background-color: rgba(48, 48, 48, 0.75);"><b>ADMIN</b> Invaild gang or gang grade!</div>'})
        --end
    else
        TriggerClientEvent('chat:addMessage', src, {template = '<div class="chat-message" style="background-color: rgba(48, 48, 48, 0.75);"><b>ADMIN</b> Speler is niet online!</div>'})
    end
end, "admin")

CreateThread(function()
    Wait(500)
    local results = Framework.Functions.ExecuteSql(true, "SELECT * FROM `gangs_members`", {})
    for i=1, #results do
        local result = results[i]
        Members[result.cid] = { name = result.gang, grade = result.grade, char = result.char, id = result.cid }
    end

    local accounts = Framework.Functions.ExecuteSql(true, "SELECT * FROM `gangs_money`", {})
    for i=1, #accounts do
        local account = accounts[i]
        Accounts[account.gang] = tonumber(account.amount)
    end

    for k,v in pairs(Settings.Gangs) do
        if Accounts[k] == nil then
            Accounts[k] = 0
        end
    end
end)

AddEventHandler("playerDropped", function()
    local src = source
    local CID = CIDS[src]
    if CID and Members[CID] then
    local xPlayer = Framework.Functions.GetPlayer(src)
        local char = xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname
        TriggerClientEvent("gangs:notify", -1, "fas fa-user", char .. " verliet de partij.", Members[CID].name)
    end
end)
