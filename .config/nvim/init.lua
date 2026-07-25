require('vim._core.ui2').enable({})

require('options')
require('keymaps')

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    callback = function()
        vim.hl.on_yank()
    end,
})

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








