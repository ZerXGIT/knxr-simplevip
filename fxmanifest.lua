fx_version "cerulean"
games { "gta5" }
lua54 "yes"
shared_script "@es_extended/imports.lua"

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "sv_main.lua",
}

-- Dependencies
dependencies {
    "es_extended",
    "oxmysql",
}