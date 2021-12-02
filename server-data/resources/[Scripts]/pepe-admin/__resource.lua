resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

client_scripts {
    'client/main.lua',
    'client/noclip.lua',
    'client/spectate.lua',
    -- 'client/entityiterc.lua',
    -- 'client/entityiterv.lua',
    '@warmenu/warmenu.lua',
}

ui_page {
    'ui/index.html'
  }
server_scripts {
    'server/main.lua'
}
files {
  'ui/index.html',
  'ui/style.css',
  'ui/main.js',
}