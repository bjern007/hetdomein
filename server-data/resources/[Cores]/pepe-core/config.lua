Config = {}

Config.Money = {}
Config.Server = {} 
Config.Player = {}
Config.Server.PermissionList = {} 


Config.MaxPlayers = GetConvarInt('sv_maxclients', 64) 
Config.IdentifierType = "steam" 
Config.DefaultSpawn = {x=-1035.71,y=-2731.87,z=12.86,a=0.0}
Config.Money.MoneyTypes = {['cash'] = 500, ['bank'] = 5000, ['crypto'] = 0 }
Config.Money.DontAllowMinus = {'cash', 'crypto'}
Config.Server.whitelist = false 
Config.Server.discord = "https://discord.gg/vvYDfX6RC4"
Config.Server.firstmsg = "Checking steam account"
Config.Server.secondmsg = "Niks"
Config.Server.thirdmsg = "Niks"
Config.Server.Nosteam = "Turn on Steam if you want to play here."
Config.Server.Badchars = "You cannot use forbidden chars in your name"
Config.Server.Forbiddenname = "Wrong name (drop/table/database)"
Config.Server.Checkingsteam = "Checking identifiers..."
Config.Server.Nosocial = "No Social Account found."
Config.Server.License = "PEPE251IGAPLWBVJ2" -- Your licensekey obtained from HighDevelopment.eu
Config.Server.Shorttag = "pepe-" -- Wish to change shorttags ?
Config.Player.MaxWeight = 225000
Config.Player.MaxInvSlots = 30

Config.Player.Bloodtypes = {
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
}