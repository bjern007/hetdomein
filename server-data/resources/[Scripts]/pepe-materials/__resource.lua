resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
 'config.lua',
 'client/client.lua',
 'client/scrapyard.lua',
 'client/trashcans.lua',
--  'client/prospect.lua', - COMMENT OUT UNTILL FURTHER NOTICE AND WORK - KAMATCHO
}

server_scripts {
 'config.lua',
 'server/server.lua',
}

exports {
 'IsNearScrapYard',
 'GetBinStatus',
}