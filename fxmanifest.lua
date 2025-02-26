fx_version 'cerulean'
game 'gta5'

author 'Sedres <https://github.com/Sedres>'
description 'Rockstar Editor'
version '1.0.0'

client_scripts {
    'client/*.lua',
}

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/assets/*.*'
}

shared_scripts {
    'config/*.lua',
    'locales/*.lua'
}
