require('lualine').setup {
    options = {
        theme = 'nightfly',
        icons_enabled = false,
        -- section_separators = '', 
        -- component_separators = '',
    },
    tabline = {
        lualine_a = { 'buffers' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'tabs' },
    },
}
