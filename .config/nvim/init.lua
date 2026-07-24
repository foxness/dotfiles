vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.winborder = 'rounded'
vim.o.swapfile = false
vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>b', '<Cmd>quit<CR>')

vim.pack.add({
    { src = 'https://github.com/vague-theme/vague.nvim' },
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/nvim-mini/mini.pick' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
})

vim.cmd('set completeopt+=noselect')

require 'mini.pick'.setup()
require 'oil'.setup()

vim.cmd.colorscheme('vague')

vim.lsp.config('lua_ls', {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = { library = { vim.env.VIMRUNTIME } },
        },
    },
})

vim.lsp.enable({ "lua_ls" })

vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>i', ':Pick help<CR>')
vim.keymap.set('n', '<leader>h', ':Oil<CR>')

vim.keymap.set({ 'n', 'v', 'i' }, '<D-j>', '<Esc>') -- <D-j> is cmd-J








