resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

client_scripts {

    "locale.lua",
    "locales/*.lua",
 'config.lua',
 'client/dead.lua',
 'client/wounds.lua',
 'client/client.lua',
--  'client/main.lua',
}

server_scripts {
    "locale.lua",
    "locales/*.lua",
 'config.lua',
 'server/server.lua'
}

exports {
    'NearGarage',
    'RangeCheck',
 'GetDeathStatus',
}