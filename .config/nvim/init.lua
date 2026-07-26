----------------------------------------

---- river's nvim config
---- created on 2026/07/24

----------------------------------------

require('vim._core.ui2').enable({})

require('options')
require('keymaps')

---- PLUGINS ----

vim.pack.add({

    -- plugins
    { src = 'https://github.com/vague-theme/vague.nvim' },
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/nvim-mini/mini.pick' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = "https://github.com/Isrothy/neominimap.nvim" },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
    { src = 'https://github.com/akinsho/bufferline.nvim' },

    { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
    { src = 'https://github.com/nvim-lualine/lualine.nvim' },

    { src = 'https://github.com/nvim-lua/plenary.nvim' },
    { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' },
    { src = 'https://github.com/nvim-telescope/telescope.nvim' },

    -- themes
    { src = 'https://github.com/bluz71/vim-moonfly-colors',      name = 'moonfly' },
    { src = 'https://github.com/gbprod/nord.nvim' },
    { src = 'https://github.com/folke/tokyonight.nvim' },
    { src = 'https://github.com/ellisonleao/gruvbox.nvim' },
})


require('mini.pick').setup()
require('oil').setup()
require('oil').setup()
require('nvim-treesitter').install {
    'lua',
    'javascript',
    'typescript',
    'python',
    'swift',
    'json',
    'bash',
    'zsh',
    'markdown',
    'regex',
    'diff',
    'html',
    'clojure',
}

require("bufferline").setup {
    options = {
        show_buffer_close_icons = false,
        numbers = 'ordinal',
        tab_size = 24,
        max_name_length = 24,
    }
}

vim.g.neominimap = {
    auto_enable = true,
    float = {
        minimap_width = 20,

        margin = {
            right = 1,
            top = 0,
            bottom = 0,
        },

        window_border = 'none',
    },
}

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

---- THEME ----

require('lualine').setup({
    options = {
        theme = 'tokyonight'
    }
})

require('vague').setup({
    transparent = true,
})

require('nord').setup({
    transparent = true,
})

require('tokyonight').setup({
    transparent = true,
})

vim.cmd.colorscheme('tokyonight-night')
-- vim.cmd.colorscheme('moonfly')
