local g = vim.g
local opt = vim.opt
local cmd = vim.cmd

g.tokyonight_style = "storm"
g.tokyonight_transparent = true
g.tokyonight_italic_comments = true

opt.termguicolors = true
cmd('colorscheme tokyonight')
