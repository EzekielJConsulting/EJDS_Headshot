RegisterNetEvent('EJDS_Headshot:client:receiveHeadshot')
AddEventHandler('EJDS_Headshot:client:receiveHeadshot', function(headshotTxd)
    if headshotTxd and headshotTxd ~= "" then
        print("Received headshot: " .. headshotTxd)
        -- Handle the headshot (e.g., display it on the screen, save it, etc.)
    else
        print("Failed to generate headshot.")
        -- Handle the failure (e.g., use a default image or notify the user)
    end
end)
