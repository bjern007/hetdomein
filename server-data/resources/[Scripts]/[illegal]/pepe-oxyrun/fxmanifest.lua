fx_version 'cerulean'
game 'gta5'
author 'HighDevelopment'
description 'PEPE Oxyruns'
version '1.2.0'


shared_scripts {
    'locale.lua',
    'locales/*.lua',
	'config.lua'
}

server_scripts {
	'server/*.lua',
}

client_scripts {
	'client/*.lua',
}

dependencys {
    '/server:4700', -- ⚠️PLEASE READ⚠️; Requires at least server build 4700.
}