-- tree display format when navigating filesystem using nvim
vim.cmd("let g:netrw_liststyle = 3")



local opt = vim.opt
opt.relativenumber = true  -- show line numbers relative to current line
opt.number = true  -- show absolute number of current line 
opt.tabstop = 2  -- 2 spaces for tabes
opt.shiftwidth = 2  -- 2 spaces for indent width
opt.expandtab = true  -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting a new line
opt.wrap = false  -- no line wrapping
opt.ignorecase = true  -- ignore case when searching
opt.smartcase = true  -- if you use mixed case when searching, use case-sensitive searching
opt.termguicolors = true  -- use terminal gui colors 
-- opt.background = "dark"  -- use dark color scheme when available 
opt.signcolumn = "yes"  -- show sign column
opt.backspace = "indent,eol,start"  -- backspace 
opt.clipboard:append("unnamedplus")  -- clipboard
opt.splitright = true  -- split vertical window to the right
opt.splitbelow = true  -- split horizontal window to the bottom


