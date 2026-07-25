require('vim._core.ui2').enable({})

require('options')
require('keymaps')

-- pack
vim.pack.add({

    -- plugins
    { src = 'https://github.com/vague-theme/vague.nvim' },
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/nvim-mini/mini.pick' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },

    -- themes
    { src = 'https://github.com/bluz71/vim-moonfly-colors', name = 'moonfly' },
    { src = 'https://github.com/gbprod/nord.nvim' },
})

require('mini.pick').setup()
require('oil').setup()

require('vague').setup({
    transparent = true,
})

require('nord').setup({
    transparent = true,
})

-- misc
vim.cmd('set completeopt+=noselect')

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    callback = function()
        vim.hl.on_yank()
    end,
})

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

vim.cmd.colorscheme('vague')
-- vim.cmd.colorscheme('moonfly')
