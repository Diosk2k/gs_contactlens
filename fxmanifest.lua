fx_version 'cerulean'
game 'gta5'

author 'Goku Works'

description 'GS Designs | Contact lens'

version '1.0.0'

lua54 'yes'

client_scripts {
    'client/client.lua',
    'config.lua'
}

server_scripts {
    '@es_extended/locale.lua',
    'server/server.lua',
    'server/update.lua',
    -- 'locales.lua',
    'config.lua'
}

dependencies {
    'es_extended',
    'ox_inventory'
}

