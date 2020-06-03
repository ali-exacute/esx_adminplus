fx_version 'bodacious'
game 'gta5'
author 'Ali Exacute'
description 'Admin commands'
version '1.0.0'

shared_scripts {
    '@es_extended/locale.lua',
    'locales/en.lua',
    'locales/es.lua',
    'locales/fa.lua',
    'config.lua'
}
client_script 'client.lua'
server_script 'server.lua'

dependency "es_extended"
