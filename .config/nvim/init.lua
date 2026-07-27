-- ========================================

-- river's nvim config
-- created on 2026/07/24

-- ========================================

require('vim._core.ui2').enable({})

-- ========== PLUGINS ==========

vim.pack.add({

    -- plugins
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/nvim-mini/mini.pick' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = "https://github.com/Isrothy/neominimap.nvim" },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
    { src = 'https://github.com/akinsho/bufferline.nvim' },
    { src = 'https://github.com/lukas-reineke/indent-blankline.nvim' },

    { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
    { src = 'https://github.com/nvim-lualine/lualine.nvim' },

    { src = 'https://github.com/nvim-lua/plenary.nvim' },
    { src = 'https://github.com/nvim-telescope/telescope-fzy-native.nvim' },
    { src = 'https://github.com/nvim-telescope/telescope.nvim' },

    { src = 'https://github.com/tpope/vim-repeat' },
    { src = 'https://codeberg.org/andyg/leap.nvim' },

    -- themes
    { src = 'https://github.com/vague-theme/vague.nvim' },
    { src = 'https://github.com/bluz71/vim-moonfly-colors',               name = 'moonfly' },
    { src = 'https://github.com/gbprod/nord.nvim' },
    { src = 'https://github.com/folke/tokyonight.nvim' },
    { src = 'https://github.com/ellisonleao/gruvbox.nvim' },
    { src = "https://github.com/bluz71/vim-nightfly-colors",              name = "nightfly" },
})

-- ========== IMPORT ==========

require('options')
require('keymaps')

-- ========== PLUGIN CONFIG ==========

-- require('mini.pick').setup()
-- require('oil').setup()
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

local ts = require('telescope')
ts.setup {
    -- extensions = {
    --     fzy_native = {
    --         override_generic_sorter = true,
    --         override_file_sorter = true,
    --     }
    -- },
    defaults = {
        file_ignore_patterns = {
            '.git/',
            'Library/',
            'node_modules',
            'site-packages',
            '.Trash/',
            '.photoslibrary',
            '.app/',
            '.cache',
            '.zsh-sessions',
            'Music/',
            'Pictures/',
        },
    },
}

ts.load_extension('fzy_native')

-- ========== LEAP CONFIG ==========

-- Highly recommended: define a preview filter to reduce visual noise
-- and the blinking effect after the first keypress.
-- For example, define word boundaries as the common case, that is, skip
-- preview for matches starting with whitespace or an alphabetic
-- mid-word character: foobar[baaz] = quux
--                     ^    ^^^  ^^ ^ ^  ^
require('leap').opts.preview = function(ch0, ch1, ch2)
    return not (
        ch1:match('%s')
        or (ch0:match('%a') and ch1:match('%a') and ch2:match('%a'))
    )
end

-- Enable the traversal keys to repeat the previous search without
-- explicitly invoking Leap (`<cr><cr>...` instead of `s<cr><cr>...`):
do
    local clever = require('leap.user').with_traversal_keys
    vim.keymap.set({ 'n', 'x', 'o' }, '<cr>', function()
        require('leap').leap {
            ['repeat'] = true, opts = clever('<cr>', '<bs>'),
        }
    end)

    vim.keymap.set({ 'n', 'x', 'o' }, '<bs>', function()
        require('leap').leap {
            ['repeat'] = true, opts = clever('<bs>', '<cr>'), backward = true,
        }
    end)
end

-- ========== MISC ==========

vim.cmd('set completeopt+=noselect')

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

-- ========== INDENT COLORS ==========

-- local rainbow_colors = {
--     { name = "RainbowRed",    fg = "#E06C75" },
--     { name = "RainbowYellow", fg = "#E5C07B" },
--     { name = "RainbowBlue",   fg = "#61AFEF" },
--     { name = "RainbowOrange", fg = "#D19A66" },
--     { name = "RainbowGreen",  fg = "#98C379" },
--     { name = "RainbowViolet", fg = "#C678DD" },
--     { name = "RainbowCyan",   fg = "#56B6C2" },
-- }

local rainbow_colors = {
    { name = "RainbowBlue",   fg = "#214564" },
    { name = "RainbowYellow", fg = "#454944" },
    { name = "RainbowRed",    fg = "#443343" },
    { name = "RainbowGreen",  fg = "#304A44" },
    { name = "RainbowViolet", fg = "#3D365F" },
    { name = "RainbowOrange", fg = "#403F3F" },
    { name = "RainbowCyan",   fg = "#1E4758" },
}

local hooks = require("ibl.hooks")

-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    for _, color in ipairs(rainbow_colors) do
        vim.api.nvim_set_hl(0, color.name, { fg = color.fg })
    end
end)

local highlight_names = vim.tbl_map(function(c) return c.name end, rainbow_colors)

require("ibl").setup({ -- indent blackline
    indent = { highlight = highlight_names },
})

-- ========== APPEARANCE ==========

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    callback = function()
        vim.hl.on_yank()
    end,
})

-- vim.api.nvim_create_autocmd('TextYankPost', {
--   desc = 'Highlight when yanking (copying) text',
--   group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
--   callback = function()
--     vim.hl.on_yank({
--       higroup = 'IncSearch', -- highlight group to use
--       timeout = 200,         -- duration in milliseconds
--     })
--   end,
-- })

require('vague').setup({
    transparent = true,
})

require('nord').setup({
    transparent = true,
})

require('tokyonight').setup({
    transparent = true,
})

vim.g.nightflyTransparent = true

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

require("bufferline").setup {
    options = {
        show_buffer_close_icons = false,
        numbers = 'ordinal',
        tab_size = 24,
        max_name_length = 24,
    }
}

require('lualine').setup({
    options = {
        theme = 'nightfly'
    }
})

-- vim.cmd.colorscheme('tokyonight-night')
vim.cmd.colorscheme('nightfly')
