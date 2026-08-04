-- vim.g.netrw_banner = 0

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.g.have_nerd_font = true

vim.o.tabstop = 4
-- vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.wrap = false
vim.o.smartindent = true
vim.o.breakindent = true

vim.o.inccommand = 'split'
vim.o.incsearch = true

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.laststatus = 3

vim.o.winborder = 'rounded'
vim.o.swapfile = false
vim.o.undofile = true

vim.opt.clipboard:append('unnamedplus')
vim.opt.isfname:append('@-@')

vim.o.guicursor = ''
vim.o.showmode = false
vim.o.scrolloff = 10
vim.o.sidescrolloff = 36
vim.o.mousescroll = 'ver:1,hor:1' -- only needed for mousescrolling with mini.animate

vim.o.cursorline = true
vim.o.updatetime = 250
vim.o.timeoutlen = 500

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- vim.o.colorcolumn = 0

-- vim.o.termguicolors = true
-- vim.o.cursorcolumn = false

-- vim.o.mouse = ''
-- vim.o.mousescroll = ''
