local QBCore = exports['qb-core']:GetCoreObject()

-- Register UI Callbacks
RegisterNUICallback('bleeter:Register', function(data, cb)
    TriggerServerEvent('bleeter:server:Register', data)
    cb({})
end)

RegisterNUICallback('bleeter:Login', function(data, cb)
    TriggerServerEvent('bleeter:server:Login', data)
    cb({})
end)

RegisterNUICallback('bleeter:PostBleet', function(data, cb)
    TriggerServerEvent('bleeter:server:PostBleet', data)
    cb({})
end)

RegisterNUICallback('bleeter:GetBleets', function(_, cb)
    QBCore.Functions.TriggerCallback('bleeter:server:GetBleets', function(bleets)
        cb(bleets)
    end)
end)

-- Receive login result
RegisterNetEvent('bleeter:client:LoginResult', function(success, data)
    SendNUIMessage({
        app = 'bleeter',
        action = 'loginResult',
        success = success,
        data = data
    })
end)

-- Receive register result
RegisterNetEvent('bleeter:client:RegisterResult', function(success, message)
    SendNUIMessage({
        app = 'bleeter',
        action = 'registerResult',
        success = success,
        message = message
    })
end)

-- Refresh bleets on new post
RegisterNetEvent('bleeter:client:RefreshBleets', function()
    SendNUIMessage({
        app = 'bleeter',
        action = 'refresh'
    })
end)
