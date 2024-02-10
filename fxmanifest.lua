fx_version 'cerulean'
game 'gta5'

lua54 'yes'

shared_scripts {
    'shared/sh_*.lua',
}

client_scripts {
    '@quantum-assets/client/cl_errorlog.lua',
    '@quantum-base/shared/sh_shared.lua',
    'client/cl_*.lua',
}

server_scripts {
    '@quantum-assets/server/sv_errorlog.lua',
    '@quantum-base/shared/sh_shared.lua',
    'server/sv_*.lua',
}