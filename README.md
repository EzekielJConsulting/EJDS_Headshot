Sure! Here’s a `Readme.md` file for the `EJDS_Headshot` resource, including installation instructions and details on how to use the exports.

---

# EJDS_Headshot

EJDS_Headshot is a FiveM resource for generating player headshots based on their skin data stored in the `playerskins` database. This resource is integrated with the QBCore framework and includes a version check mechanism to ensure you are using the latest version.

## Features

- Generate player headshots based on skin data
- Integration with QBCore
- Version check to notify about available updates

## Installation

1. **Download the Resource:**

   Download the `EJDS_Headshot` resource from [GitHub](https://github.com/EzekielJConsulting/EJDS_Headshot) and extract it to your `resources` directory.

2. **Add to Server Configuration:**

   Add the following line to your `server.cfg` to ensure the resource is started when the server runs:

   ```plaintext
   ensure EJDS_Headshot
   ```

## Usage

### Exports

You can use the provided exports to generate a headshot for a player. Here’s an example of how to use the export in another script:

```lua
-- Trigger the headshot generation for a specific player
local citizenid = "OAI99725" -- Example citizen ID
TriggerServerEvent('EJDS_Headshot:server:generateHeadshot', citizenid)

-- Handle the received headshot on the client side
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
```

### Server Events

- **`EJDS_Headshot:server:generateHeadshot`**

  Trigger this event from the client to request a headshot generation. Pass the `citizenid` of the player as a parameter.

  ```lua
  TriggerServerEvent('EJDS_Headshot:server:generateHeadshot', citizenid)
  ```

### Client Events

- **`EJDS_Headshot:client:receiveHeadshot`**

  Listen for this event to receive the generated headshot. The event passes the `headshotTxd` (Texture Dictionary) string as a parameter.

  ```lua
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
  ```

## Version Check

The resource automatically performs a version check against the version file hosted at `https://fivemassets.s3.us-east-2.amazonaws.com/EJDS_Headshot/version.txt`. If an update is available, it will print a notification in the server console.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

This `Readme.md` file provides comprehensive installation and usage instructions for the `EJDS_Headshot` resource. Adjust the paths and URLs as necessary based on your hosting and server configuration.