# Ember's Discord User Authentication Integration (LUA/PYTHON)

This is a mod for intended for Azerothcore's Eluna module, and should be compatible with Eluna's TrinityCore branch as well.

This mod is intended to be used in junction with [Ember's Discord Registration Bot](https://github.com/Ember-RP/discord_register_bot), or if you do not want to satisfy that requirement, users must have their discord ID associated with their email in your accounts database.

This somewhat acts as a whitelist for your World of Warcraft server. On server startup, the server starts "DUA.py" which runs a discord bot (ideally the registration bot in this case). You must configure your Discord API key in the PY file. DUA_DB.DUA is made, which is a file that holds all member IDs and relevant roles, if they have any. You must configure relevant role IDs in both the PY and LUA file. When a player logs in, the LUA script runs DUA.py, but this time DUA.py is only searching for that player's associated Discord role in the DUA_DB.DUA file. If any relevant roles are found, the server does nothing. But if no relevant roles are found, or if the user does not exist, then the server will inform the player and they will be kicked for failing to authenticate via Discord.

The intended purpose of this module is to ensure all players accessing your World of Warcraft server are registered via Discord. Some relevant role comments remain to provide ideas that might identify a use case for your server.

### Current Compatibility
- [Eluna TrinityCore 3.3.5](https://github.com/ElunaLuaEngine/ElunaTrinityWotlk)
- [Azerothcore Eluna Module 3.3.5](https://github.com/azerothcore/mod-eluna)

## Requirements
- Python3
   - Pip Packages: `mysql.connector`, `discord` via `pip install`
   - Easy Linux Command that installs the packages for you: `pip install mysql.connector && pip install discord`

## Installation Instructions

### Create a Discord Bot
1. Access Discord's [Developer Portal](https://discord.com/developers/applications) and create a `New Application`.
2. Navigate to the `Bot` section of your application settings and click `Add Bot`.
   - Set the username and profile icon of the bot.
   - Reset and save your bots `Token`.
   - No permissions are required, as the bot interacts via direct messages with users.
3. Navigate to `OAuth2` -> `URL Generator`.
   - In the `Scopes` section:
      - [x] `bot`
   - Copy the `Generated URL` and paste it into your browser to invite it to your server.
4. The bot should now be visible (_though offline_) in the server you invited it to.

### Edit DUA.py
1. In `DUA.py`, there is a list called "relevant_roles" where placeholder values "123" exist.
2. Replace the contents of this list with the Role ID you desire.
3. Ensure the values you enter are NOT in quotes.
4. Save and exit.

### Edit DiscordUserAuthentication.lua 
1. In `DiscordUserAuthentication.lua`, find the array "relevant_roles" where placeholder values "123" exist.
2. Replace the contents of this list with the Role ID you desire.
3. Ensure the values you enter are kept in quotes.
4. Replace `PATH_TO_DUA_EVENT = "/home/server/bin/DUA.py"` with the location of your `DUA.py` file.
  - Temporary `.DUA` character files are stored in the bin directory and may appear there.
6. Save and exit.

## To Do
- Provide a check for staff and validate their RBAC roles.
- Output log information to discord channels.

## Disclaimer
This is still in active development and will see updates in the future.

## Contribute
If you'd like to contribute, please fork and create a pull request. Your code will be reviewed and then merged with the main branch.
