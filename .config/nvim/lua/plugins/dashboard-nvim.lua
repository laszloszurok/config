vim.g.dashboard_default_executive = 'telescope'

vim.g.dashboard_custom_header = {
    '     ⠀⠀⠀⠀⠀⣠⣶⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣄⠀⠀⠀⠀⠀      ',
    '     ⠀⠀⠀⣠⣾⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣷⣄⠀⠀⠀      ',
    '     ⠀⡀⢺⣿⣿⣿⣿⣿⣿⣧⡀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣷⣄⠀      ',
    '     ⣾⣿⡄⠻⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣷      ',
    '     ⣿⣿⣿⣦⠙⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿      ',
    '     ⣿⣿⣿⣿⣷⡈⢿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿      ',
    '     ⣿⣿⣿⣿⣿⣿⡄⠻⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⢸⣿⣿⣿⣿⣿⣿      ',
    '     ⣿⣿⣿⣿⣿⣿⡇⠀⠙⣿⣿⣿⣿⣿⣿⣿⣄⠀⢸⣿⣿⣿⣿⣿⣿      ',
    '     ⣿⣿⣿⣿⣿⣿⡇⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⣦⠘⣿⣿⣿⣿⣿⣿      ',
    '     ⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠻⣿⣿⣿⣿⣿⣿⣷⡈⢿⣿⣿⣿⣿      ',
    '     ⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠙⣿⣿⣿⣿⣿⣿⣿⣄⠹⣿⣿⣿      ',
    '     ⢿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⣦⠘⢿⡿      ',
    '     ⠀⠙⢿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠻⣿⣿⣿⣿⣿⣿⡷⠈⠀      ',
    '     ⠀⠀⠀⠙⢿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣿⣿⡿⠋⠀⠀⠀      ',
    '     ⠀⠀⠀⠀⠀⠙⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠿⠋⠀⠀⠀⠀⠀      ',
}

vim.g.dashboard_custom_section = {
    a = {
        description = { '  Empty buffer                                  SPC b e' },
        command = ':enew',
    },
    b = {
        description = { '  File history                                  SPC f h' },
        command = ':Telescope oldfiles',
    },
    c = {
        description = { '  Load last session                             SPC o s' },
        command = ':SessionLoad',
    },
    d = {
        description = { '  Find file                                     SPC f f' },
        command = ':Telescope find_files',
    },
    e = {
        description = { '  Find text                                     SPC f t' },
        command = ':Telescope live_grep',
    },
    f = {
        description = { '  Quit                                            SPC q' },
        command = ':q',
    },
}
