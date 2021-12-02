--[ Breathalyzer Script 0.1 Created By JKSensation ]--
--[ DO NOT RELEASE/LEAK/SHARE CODE WITHOUT PERMISSION FROM JKSENSATION ]--

fx_version 'adamant'
games { 'gta5'}

author "JKSensation"
description "Breathalyzer 0.1"

client_script "client.lua"
client_script "client_functions.lua"
server_script "server.lua"

ui_page "web/index.html"

files {
    "web/index.html",
    "web/index.js",
    "web/styles.css",
    "web/portablebreathalyzer.png",
    "web/digital-7.ttf",
}