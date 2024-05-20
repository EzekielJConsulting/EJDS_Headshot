QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

function GeneratePlayerHeadshot(citizenid, source, callback)
    MySQL.Async.fetchAll('SELECT * FROM playerskins WHERE citizenid = @citizenid AND active = 1', {
        ['@citizenid'] = citizenid
    }, function(skinData)
        if skinData[1] then
            local skin = json.decode(skinData[1].skin)
            local playerModel = skinData[1].model

            TriggerClientEvent('qb-clothes:client:loadPlayerSkin', source, skin, playerModel)
            
            Citizen.Wait(500)

            local playerPed = GetPlayerPed(source)
            local headshot = RegisterPedheadshot(playerPed)
            
            while not IsPedheadshotReady(headshot) do
                Citizen.Wait(100)
            end
            
            local headshotTxd = GetPedheadshotTxdString(headshot)

            if IsPedheadshotValid(headshot) then
                callback(headshotTxd)
            else
                callback(nil)
            end

            UnregisterPedheadshot(headshot)
        else
            callback(nil)
        end
    end)
end

RegisterServerEvent('EJDS_Headshot:server:generateHeadshot')
AddEventHandler('EJDS_Headshot:server:generateHeadshot', function(citizenid)
    local src = source
    GeneratePlayerHeadshot(citizenid, src, function(headshotTxd)
        TriggerClientEvent('EJDS_Headshot:client:receiveHeadshot', src, headshotTxd)
    end)
end)

-- Version check
CreateThread(function()
    PerformHttpRequest('https://fivemassets.s3.us-east-2.amazonaws.com/EJDS_Headshot/version.txt', function(err, text, headers)
        if text then
            local curVersion = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)
            if text ~= curVersion then
                print("EJDS_Headshot: An update is available. Current version: " .. curVersion .. ", New version: " .. text)
            end
        else
            print("EJDS_Headshot: Unable to check for updates.")
        end
    end, 'GET')
end)
