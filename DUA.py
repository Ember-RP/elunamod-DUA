import configparser, asyncio, sys, os # Standard Libs
import discord, mysql.connector # Requires from pip3: discord-py

apiKey = "apiKEY"

# NOT USED YET, DONT USE
# discordServerID = 123 # Your server ID
# logsChannelID = 123 # Output logs to channel
# staffRoleID = 123 # Role ID of Staff
# staffRoleRBAC = 3 # the RBAC ID associated with Staff roles

intents=discord.Intents.default()
intents.members = True
intents.guilds = True
client = discord.Client(intents=intents)

run_arg = sys.argv[1]
discordid = sys.argv[2]
account_name = sys.argv[3]
relevant_roles = [
123, # patron
123, # funserver supporter
123, # founder
123, # staff
123, # grandfathered
]

if run_arg == "load":
    if os.path.exists("DUA_DB.DUA") == True:
        print("[DUA]: Overwriting previous DUA_DB.DUA file.")
        os.remove("DUA_DB.DUA")
    @client.event
    async def on_ready():
        active_file = open("DUA_DB.DUA", "x")
        print(f"We have logged in as {client.user}")
        for guild in client.guilds:
            for member in guild.members:
                string_to_write = ""
                string_to_write = str(member.id) + " " + str(member.name.split())
                for role in member.roles:
                    if role.id in relevant_roles:
                        # string_to_write = string_to_write + " " + str(role.id)
                        string_to_write = string_to_write + " " + str(role.id)
                active_file.write(string_to_write + "\n")
        active_file.close()
        await client.close()
    client.run(apiKey)
def search_func():
    temp_table = []

    db_file = open("DUA_DB.DUA", "r")
    for line in db_file.readlines():
        if str(discordid) in line:
            temp_table.insert(0, str(discordid))
            print(temp_table)
            for m in relevant_roles:
                if str(m) in line:
                    temp_table.insert(len(temp_table)+1, m)
            db_file.close()
    if os.path.exists(account_name + ".DUA") == True:
        print("[DUA]: Overwriting previous .DUA file.")
        os.remove(account_name + ".DUA")
    new_file = open(account_name + ".DUA", "x")
    string_to_write = ""
    for x in temp_table:
        string_to_write = string_to_write + " " + str(x)
    new_file.write(string_to_write)
    new_file.close()
if run_arg == "search":
    search_func()