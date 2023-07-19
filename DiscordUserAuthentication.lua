-- when a player logs in the discord bot will check if they have the required role to access the server
-- the bot also checks if the player has staff privileges and should be logged in with those

PATH_TO_DUA_EVENT = "/home/server/bin/lua_scripts/elunamod-DUA/DUA.py" -- path to event where the python file is located.

function getCommandParameters(command) -- Takes a string and splits it up by spaces into a table. Used for player commands.
    local pattern = "%S+" -- Separate by spaces
    local parameters = {}
    for parameter in string.gmatch(command, pattern) do -- Take the entire command and split it by spaces, put into a table.
        table.insert(parameters, parameter) 
    end
    return parameters
end

relevant_roles = {
"123", -- patron
"123", -- funserver supporter
"123", -- founder
"123", -- staff
"123", -- grandfathered
}

local function DUA_Kick(eventid, delay, repeats, player)
	player:KickPlayer()
end

local function DUA_LoginCheckTimed(eventid, delay, repeats, player) -- after timer, search for filename which is accountname, and search those contents for relevant IDs
	local f = assert(io.open(player:GetAccountName() .. ".DUA", "r"))
	local content = f:read("*all")
	f:close()
	params = getCommandParameters(content)
	local temp_table = {}
	for x=1,#relevant_roles,1 do
		for z=1,#params,1 do
			if tostring(params[z]) == tostring(relevant_roles[x]) then
				table.insert(temp_table, tostring(params[z]))
			end
		end
	end
	if #temp_table >= 1 then
		return
	end
	player:SendBroadcastMessage("[DUA]: You are either not in the discord server or do not have the required roles to access this server. You will be kicked in 30 seconds.")
	player:SetPlayerLock( true )
	player:RegisterEvent(DUA_Kick, 60 * 1000, 1)
end

local function DUA_LoginCheck(event, player)
	local user_query = AuthDBQuery("SELECT `email` FROM `account` WHERE `id` = " .. player:GetAccountId() .. ";")
	local user_discord = user_query:GetString(0)
	os.execute("python3 " .. PATH_TO_DUA_EVENT .. " 'search' '" .. user_discord .. "' '" .. player:GetAccountName() .. "' &")
	player:RegisterEvent(DUA_LoginCheckTimed, 5000, 1) -- find the file after 5 seconds
end

local function DUA_Load(event)
	-- run a python script that generates a list of members in the guild/server/discord along with the attributes we will need later. this is to prevent spamming, but makes it so users have to check every X seconds that we will define.
	os.execute("python3 " .. PATH_TO_DUA_EVENT .. " 'load' 0 0 &")
end

RegisterServerEvent( 33, DUA_Load )
RegisterPlayerEvent( 3 , DUA_LoginCheck )