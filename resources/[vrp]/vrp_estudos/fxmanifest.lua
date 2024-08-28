fx_version "adamant"

game "gta5"
shared_script "@vrp/lib/utils.lua"

server_scripts {
    "server.lua",
    "server2.lua",
    "@vrp/lib/utils.lua"
}

client_scripts {
    "client.lua",
    "@vrp/lib/utils.lua"
}