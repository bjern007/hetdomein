resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

description "pizza Job"

ui_page {'html/index.html'}

exports {
 'StorePizzascooter',
 'Pizzascooter',
 'GetActiveRegister',
}

client_scripts {
  'client/*.lua',
  'config.lua',
}

server_scripts {
  'server/*.lua',
  'config.lua',
}


files {
  'html/index.html',
  'html/css/style.css',
  'html/js/script.js',
}