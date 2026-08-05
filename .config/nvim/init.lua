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
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter-context' },
    { src = 'https://github.com/nvim-mini/mini.ai' },
    { src = 'https://github.com/nvim-mini/mini.surround' },
    { src = 'https://github.com/folke/snacks.nvim' },
    { src = 'https://github.com/nvim-mini/mini.animate' },
    { src = 'https://github.com/nvim-mini/mini.pairs' },

    { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
    { src = 'https://github.com/nvim-lualine/lualine.nvim' },

    { src = 'https://github.com/tpope/vim-repeat' },
    { src = 'https://codeberg.org/andyg/leap.nvim' },

    -- themes
    { src = 'https://github.com/vague-theme/vague.nvim' },
    { src = 'https://github.com/bluz71/vim-moonfly-colors',              name = 'moonfly' },
    { src = 'https://github.com/gbprod/nord.nvim' },
    { src = 'https://github.com/folke/tokyonight.nvim' },
    { src = 'https://github.com/ellisonleao/gruvbox.nvim' },
    { src = 'https://github.com/bluz71/vim-nightfly-colors',             name = 'nightfly' },
    { src = 'https://github.com/catppuccin/nvim',                        name = 'catppuccin' },
    { src = 'https://github.com/rebelot/kanagawa.nvim' },
    { src = 'https://github.com/sainnhe/everforest' },
    { src = 'https://github.com/UtkarshVerma/molokai.nvim' },
    { src = 'https://github.com/rose-pine/neovim',                       name = 'rose-pine' },
    { src = 'https://github.com/sainnhe/sonokai' },
    { src = 'https://github.com/maxmx03/solarized.nvim' },
})

-- ========== PLUGIN CONFIG ==========

require('oil').setup()
require('snacks').setup {
    bigfile = { enabled = false },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    indent = { enabled = false },
    input = { enabled = false },
    notifier = {
        enabled = false,
        timeout = 3000,
    },
    picker = { enabled = true },
    quickfile = { enabled = false },
    scope = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    rename = { enabled = true },
    words = { enabled = false },
    -- styles = {
    --     notification = {
    --         -- wo = { wrap = true } -- Wrap notifications
    --     }
    -- }
}

require('mini.pick').setup()
require('mini.ai').setup()
require('mini.pairs').setup()

local animationDuration = 30
local animate = require('mini.animate')
animate.setup {
    cursor = {
        enable = false
    },
    scroll = { -- Vertical scroll
        enable = true,
        timing = animate.gen_timing.cubic { duration = animationDuration, unit = 'total' }
    },
    resize = {
        enable = false
    },
    open = {
        enable = false
    },
    close = {
        enable = false
    },
}

require('mini.surround').setup {
    mappings = {
        add = 'Sa',        -- Add surrounding in Normal and Visual modes
        delete = 'Sd',     -- Delete surrounding
        find = 'Sf',       -- Find surrounding (to the right)
        find_left = 'SF',  -- Find surrounding (to the left)
        highlight = 'Sh',  -- Highlight surrounding
        replace = 'Sr',    -- Replace surrounding

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
    }
}

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
    'css',
    'clojure',
}

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

-- ========== MISC ==========

vim.cmd('set completeopt+=noselect')

-- ========== LSP ==========

require('lsp')

-- ========== INDENT COLORS ==========

local function lerp(a, b, t)
    return a + (b - a) * t
end

local function hex_to_rgb(hex)
    hex = hex:gsub('#', '')
    return tonumber(hex:sub(1, 2), 16),
        tonumber(hex:sub(3, 4), 16),
        tonumber(hex:sub(5, 6), 16)
end

--- Linearly interpolates between two hex colors.
--- @param color_a string -- e.g., "#3D365F"
--- @param color_b string -- e.g., "#8EC07C"
--- @param t number      -- progress from 0.0 to 1.0
--- @return string hex   -- interpolated hex string
local function lerp_color(color_a, color_b, t)
    -- Clamp t between 0 and 1
    t = math.max(0, math.min(1, t))

    local r1, g1, b1 = hex_to_rgb(color_a)
    local r2, g2, b2 = hex_to_rgb(color_b)

    local r = math.floor(lerp(r1, r2, t) + 0.5)
    local g = math.floor(lerp(g1, g2, t) + 0.5)
    local b = math.floor(lerp(b1, b2, t) + 0.5)

    return string.format('#%02X%02X%02X', r, g, b)
end

-- original order: red, yellow, blue, orange, green, violet, cyan
local rainbow_colors = {
    { name = "RainbowBlue",   fg = "#61AFEF" },
    { name = "RainbowYellow", fg = "#E5C07B" },
    { name = "RainbowRed",    fg = "#E06C75" },
    { name = "RainbowGreen",  fg = "#98C379" },
    { name = "RainbowViolet", fg = "#C678DD" },
    { name = "RainbowCyan",   fg = "#56B6C2" },
    { name = "RainbowOrange", fg = "#D19A66" },
}

local bg_color = "#141B1E"
local bg_amount = 0.6

local hooks = require("ibl.hooks")

-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    for _, color in ipairs(rainbow_colors) do
        local lerped_color = lerp_color(color.fg, bg_color, bg_amount)
        vim.api.nvim_set_hl(0, color.name, { fg = lerped_color })
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

require('tokyonight').setup {
    transparent = true,
}

require('catppuccin').setup {
    transparent_background = true,
    float = {
        transparent = true, -- enable transparent floating windows
        solid = true,       -- use solid styling for floating windows, see |winborder|
    },
}

require('kanagawa').setup {
    transparent = true,
}

require('rose-pine').setup {
    styles = {
        transparency = true
    },
}

local palette = require("gruvbox").palette
require("gruvbox").setup {
    overrides = {
        -- legacy vim syntax
        -- String = { fg = palette.bright_aqua },

        -- tree-sitter highlight groups (what modern neovim actually renders)
        ["@string"] = { fg = palette.bright_aqua, italic = true },
        ["@string.documentation"] = { fg = palette.neutral_aqua },
        ["@string.escape"] = { fg = palette.bright_orange },
    },
    transparent_mode = true
}

vim.g.nightflyTransparent = true
vim.g.moonflyTransparent = true
vim.g.sonokai_transparent_background = true
vim.g.sonokai_style = 'andromeda'

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
        z_index = 3, -- so that it is above treesitter context
    },
}

local mocha = require("catppuccin.palettes").get_palette "mocha"
require("bufferline").setup {
    options = {
        show_buffer_close_icons = false,
        numbers = 'ordinal',
        tab_size = 24,
        max_name_length = 24,
    },
    -- you only need this highlights section if you want to make the bufferline transparent in catppuccin
    highlights = require("catppuccin.special.bufferline").get_theme {
        styles = { "italic", "bold" },
        custom = {
            all = {
                fill = { bg = "None" },
            },
            mocha = {
                background = { fg = mocha.text },
            },
            latte = {
                background = { fg = "#000000" },
            },
        },
    },
}

local river_powerline = require('river-powerline')
require('lualine').setup {
    options = {
        theme = river_powerline
    }
}

require('treesitter-context').setup {
    zindex = 2 -- so that it is below minimap
}

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        -- === make treesitter-context transparent ===
        -- strip the solid background from the sticky context header

        -- nuke the link explicitly
        vim.cmd("highlight link TreesitterContext NONE")
        vim.cmd("highlight link TreesitterContextLineNumber NONE")

        -- apply transparent background
        vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "none" })
        vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { bg = "none" })

        -- add underline #5b3829 #214564
        vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true, sp = "#254852" })

        -- === make bufferline transparent ===
        -- vim.schedule defers the execution until AFTER the current event loop tick.
        -- this ensures bufferline has already finished generating its highlights
        -- before we march in and destroy them.
        vim.schedule(function()
            -- 1. nuke the native tabline background (which sits under bufferline)
            vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })

            -- 2. dynamically find every single highlight group starting with "BufferLine"
            local groups = vim.fn.getcompletion("BufferLine", "highlight")

            -- 3. iterate through them and strip the background
            for _, group in ipairs(groups) do
                local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
                -- it's ok because nvim accepts none as a value
                ---@diagnostic disable-next-line: assign-type-mismatch
                hl.bg = "none"
                ---@diagnostic disable-next-line: param-type-mismatch
                vim.api.nvim_set_hl(0, group, hl)
            end
        end)
    end,
})

vim.cmd.colorscheme('gruvbox')

-- ========== IMPORT ==========

require('options')
require('keybinds')
