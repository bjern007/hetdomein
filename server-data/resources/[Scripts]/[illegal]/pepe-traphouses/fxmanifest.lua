fx_version 'bodacious'
games { 'gta5' }

author 'PEPEFramework based on QBCore'
description 'Traphouses'
version '1.0.0'

ui_page "html/index.html"

client_scripts {
    'client/main.lua',
    'config.lua',
}

server_scripts {
    'server/main.lua',
    'config.lua'
}

exports {
    'CanPlayerEnterTraphouse',
}
   

server_exports {
    'AddHouseItem',
    'RemoveHouseItem',
    'GetInventoryData',
    'CanItemBeSaled',
    'CanPlayerEnterTraphouse',
}

files {
    'html/*',
}