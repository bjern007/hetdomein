resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
    'locale.lua',
    'locales/*.lua',
    'client/gui.lua',
    'client/main.lua',
    'config.lua',
}

server_scripts {
    'locale.lua',
    'locales/*.lua',
    'server/main.lua',
    'config.lua',
}


exports {
    "RecycleStatus",
}