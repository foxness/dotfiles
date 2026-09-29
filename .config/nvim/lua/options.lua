-- vim.g.netrw_banner = 0

-- ========== General ==========

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

local normal_timeout = 500
local insert_timeout = 100
vim.o.timeoutlen = normal_timeout

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- vim.o.colorcolumn = 0

-- vim.o.termguicolors = true
-- vim.o.cursorcolumn = false

-- vim.o.mouse = ''
-- vim.o.mousescroll = ''

-- ========== Magic typing ==========

local magic_group = vim.api.nvim_create_augroup('MagicTypingTimeout', { clear = true })

-- Drop timeout to 100ms in insert mode for magic rules
vim.api.nvim_create_autocmd('InsertEnter', {
    group = magic_group,
    callback = function()
        vim.g.normal_timeoutlen = vim.o.timeoutlen
        vim.o.timeoutlen = insert_timeout
    end,
})

-- Restore standard timeout when leaving insert mode so normal keymaps aren't broken
vim.api.nvim_create_autocmd('InsertLeave', {
    group = magic_group,
    callback = function()
        vim.o.timeoutlen = vim.g.normal_timeoutlen or normal_timeout
    end,
})

