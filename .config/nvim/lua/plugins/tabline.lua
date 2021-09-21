require("tabline").setup {
    -- dont't enable this by default, instead load it inside lualine.lua
    enable = enable,
    options = {
        show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
        show_devicons = false, -- this shows devicons in buffer section
        show_bufnr = false, -- this appends [bufnr] to buffer section,
        show_filename_only = true, -- shows base filename only instead of relative path in filename
    }
}
