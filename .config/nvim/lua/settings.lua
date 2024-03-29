-- meta accessors for nvim apis
local opt = vim.opt -- vim options
local cmd = vim.cmd -- execute vim commands
local g   = vim.g   -- set global variables

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.history = 500             -- remember n lines in history
opt.swapfile = true           -- swapfiles can help to recover unsaved changes
opt.dir = '/tmp'              -- put all swapfiles in /tmp
opt.clipboard = 'unnamedplus' -- use system clipboard
opt.hidden = true             -- enable hiding of a buffer, even if it has unsaved changes
opt.timeoutlen = 100          -- time in milliseconds to wait for a mapped sequence to complete


-----------------------------------------------------------
-- User Interface
-----------------------------------------------------------
opt.mouse = 'a'           -- enable mouse support
opt.laststatus = 2        -- always show the statusline
opt.showtabline = 2       -- always show the tabline
opt.cursorline = true     -- highlight the line where the cursor is at
opt.number = true         -- show line numbers
opt.relativenumber = true -- show line numbers relative to the cursor
opt.ruler = true          -- show current line and column numbers in the statusline
opt.showmatch = true      -- highlight matching parenthesis
opt.splitright = true     -- vertical split to the right
opt.splitbelow = true     -- orizontal split to the bottom
opt.scrolloff = 10        -- always show n lines above and below the cursor
opt.sidescrolloff = 10    -- always show n columns to the right and to the left of the cursor
opt.synmaxcol = 240       -- max column number for syntax highlight (better performance)
opt.lazyredraw = true     -- don't redraw while executing macros (better performance)


-----------------------------------------------------------
-- Command completion
-----------------------------------------------------------
opt.wildmode = {'longest', 'list', 'full'}  -- command-line completion mode
opt.wildmenu = false                        -- no visual highlight in the command bar


-----------------------------------------------------------
-- Search
-----------------------------------------------------------
opt.hlsearch = false  -- do not highlight search matches
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true  -- override the 'ignorecase' option if the search pattern contains uppercase characters


-----------------------------------------------------------
-- Indentation
-----------------------------------------------------------
opt.expandtab = true   -- use spaces instead of tabs
opt.shiftwidth = 4     -- shift 4 spaces when tab
opt.tabstop = 4        -- 1 tab == 4 spaces
opt.smartindent = true -- autoindent new lines


-----------------------------------------------------------
-- Autocommands
-----------------------------------------------------------
cmd[[au BufEnter * set fo-=c fo-=r fo-=o]] -- don't auto comment new lines
cmd[[au VimResized * wincmd =]]            -- always keep splits equally sized
cmd[[au BufEnter * silent! cd %:p:h]]      -- set the working directory to the path of the focused buffer
cmd[[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]] -- return to last edit position when opening files


-----------------------------------------------------------
-- LaTex specific
-----------------------------------------------------------
g.tex_indent_items = 0
g.tex_indent_and = 0
g.tex_indent_brace = 0
