local QBCore = exports['qb-core']:GetCoreObject()

-- Register a new Bleeter account
RegisterNetEvent('bleeter:server:Register', function(data)
    local src = source
    local { username, password, avatar, bio } = data

    local result = MySQL.query.await('SELECT * FROM bleeter_users WHERE username = ?', { username })
    if result[1] then
        TriggerClientEvent('bleeter:client:RegisterResult', src, false, 'Username already exists.')
        return
    end

    MySQL.insert('INSERT INTO bleeter_users (citizenid, username, password, avatar, bio) VALUES (?, ?, ?, ?, ?)', {
        QBCore.Functions.GetPlayer(src).PlayerData.citizenid,
        username, password, avatar, bio
    })

    TriggerClientEvent('bleeter:client:RegisterResult', src, true)
end)

-- Login to Bleeter
RegisterNetEvent('bleeter:server:Login', function(data)
    local src = source
    local { username, password } = data

    local result = MySQL.query.await('SELECT * FROM bleeter_users WHERE username = ? AND password = ?', { username, password })
    if result[1] then
        TriggerClientEvent('bleeter:client:LoginResult', src, true, result[1])
    else
        TriggerClientEvent('bleeter:client:LoginResult', src, false, 'Invalid credentials.')
    end
end)

-- Post a bleet
RegisterNetEvent('bleeter:server:PostBleet', function(data)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    if not player then return end

    local user = MySQL.query.await('SELECT * FROM bleeter_users WHERE citizenid = ?', { player.PlayerData.citizenid })
    if not user[1] then return end

    MySQL.insert('INSERT INTO bleeter_posts (citizenid, username, avatar, message, time) VALUES (?, ?, ?, ?, ?)', {
        player.PlayerData.citizenid, user[1].username, user[1].avatar, data.message, os.time()
    })

    TriggerClientEvent('bleeter:client:RefreshBleets', -1)
end)

-- Fetch bleets
QBCore.Functions.CreateCallback('bleeter:server:GetBleets', function(source, cb)
    local bleets = MySQL.query.await('SELECT * FROM bleeter_posts ORDER BY time DESC LIMIT 100')
    cb(bleets)
end)
