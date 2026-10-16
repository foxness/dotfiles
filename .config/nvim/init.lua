-- ========================================

-- river's nvim config
-- created on 2026/07/24

-- ========================================

require('vim._core.ui2').enable({}) -- enable new UI

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
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },

    { src = 'https://github.com/nvim-mini/mini.extra' },
    { src = 'https://github.com/nvim-mini/mini.surround' },
    { src = 'https://github.com/folke/snacks.nvim' },
    { src = 'https://github.com/nvim-mini/mini.animate' },
    { src = 'https://github.com/nvim-mini/mini.pairs' },
    { src = 'https://github.com/L3MON4D3/LuaSnip' },
    -- { src = 'https://github.com/m4xshen/hardtime.nvim' },

    { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
    { src = 'https://github.com/nvim-lualine/lualine.nvim' },

    { src = 'https://github.com/tpope/vim-repeat' },
    { src = 'https://codeberg.org/andyg/leap.nvim' },

    { src = 'https://github.com/saghen/blink.lib' },
    { src = 'https://github.com/saghen/blink.cmp' },
    -- { src = 'https://github.com/devswiftzone/swift.nvim' },

    -- themes
    { src = 'https://github.com/vague-theme/vague.nvim' },
    { src = 'https://github.com/bluz71/vim-moonfly-colors',                  name = 'moonfly' },
    { src = 'https://github.com/gbprod/nord.nvim' },
    { src = 'https://github.com/folke/tokyonight.nvim' },
    { src = 'https://github.com/ellisonleao/gruvbox.nvim' },
    { src = 'https://github.com/bluz71/vim-nightfly-colors',                 name = 'nightfly' },
    { src = 'https://github.com/catppuccin/nvim',                            name = 'catppuccin' },
    { src = 'https://github.com/rebelot/kanagawa.nvim' },
    { src = 'https://github.com/sainnhe/everforest' },
    { src = 'https://github.com/UtkarshVerma/molokai.nvim' },
    { src = 'https://github.com/rose-pine/neovim',                           name = 'rose-pine' },
    { src = 'https://github.com/sainnhe/sonokai' },
    { src = 'https://github.com/maxmx03/solarized.nvim' },
})

-- ========== PLUGIN: oil ==========

require('oil').setup()

-- ========== PLUGIN: snacks ==========

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

-- ========== PLUGIN: mini.pick ==========

require('mini.pick').setup()

-- ========== PLUGIN: mini.ai ==========

local ai = require('mini.ai')
local ts = ai.gen_spec.treesitter

local gen_ai_spec = require('mini.extra').gen_ai_spec

ai.setup {
    custom_textobjects = {
        -- Function definition
        F = ts { a = '@function.outer', i = '@function.inner' },

        -- Matches either conditional or loop
        o = ts {
            a = { '@conditional.outer', '@loop.outer' },
            i = { '@conditional.inner', '@loop.inner' },
        },

        -- Classes (explicit override to ensure treesitter handles it)
        c = ts { a = '@class.outer', i = '@class.inner' },

        -- Conditionals (if/else/switch blocks)
        i = ts { a = '@conditional.outer', i = '@conditional.inner' },

        -- Loops (for/while blocks)
        h = ts { a = '@loop.outer', i = '@loop.inner' },

        -- Assignments (var = value)
        -- 'a=' grabs the whole assignment, 'i=' grabs just the right-hand side
        ['='] = ts { a = '@assignment.outer', i = '@assignment.rhs' },

        -- Return statements
        r = ts { a = '@return.outer', i = '@return.inner' },

        B = gen_ai_spec.buffer(),
        D = gen_ai_spec.diagnostic(),
        I = gen_ai_spec.indent(),
        L = gen_ai_spec.line(),
        N = gen_ai_spec.number(),
    }
}

-- ========== PLUGIN: mini.pairs ==========

require('mini.pairs').setup {
    mappings = { -- todo: remove
        -- this is needed for the magic rule for OA to work (adds < to neigh_pattern)
        ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '^[^\\<]', register = { cr = false } },
    }
}

-- ========== PLUGIN: mini.animate ==========

local animationDuration = 20
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

-- ========== PLUGIN: mini.surround ==========

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

-- ========== TREESITTER LANGUAGES ==========

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

-- ========== MAGIC TYPING RULES ==========

local ls = require('luasnip')

ls.config.set_config {
    enable_autosnippets = true,
}

local function add_magic_rule(a, b)
    return ls.snippet(
        {
            trig = a,
            wordTrig = false,
            snippetType = 'autosnippet',
            desc = 'MAGIC: ' .. a .. ' -> ' .. b
        },
        { ls.text_node(b) }
    )
end

local function add_magic_rule_all_cases(a, b)
    if a:match('%a') ~= nil then -- if string has letters
        local a_lower = a:lower()
        local b_lower = b:lower()
        local a_upper = a:upper()
        local b_upper = b:upper()

        local lower_snip = add_magic_rule(a_lower, b_lower)
        local upper_snip = add_magic_rule(a_upper, b_upper)

        return { lower_snip, upper_snip }
    else
        return { add_magic_rule(a, b) }
    end
end

local function convert_to_magic_snippets(rules)
    local result = {}
    for _, rule in ipairs(rules) do
        local before = rule[1]
        local after = rule[2]

        local snippet_array = add_magic_rule_all_cases(before, after)
        table.insert(result, snippet_array)
    end
    return result
end

local function flatten(arr)
    local result = {}
    for _, inner in ipairs(arr) do
        for _, item in ipairs(inner) do
            table.insert(result, item)
        end
    end
    return result
end

local magic_rules = {
    -- { 'before', 'after' }
    { 'iuo', 'iou' }, -- has to go before 'ou' rule to take precedence over it
    { 'uio', 'iou' },

    { 'wg',  'pp' },

    { 'jh',  'ph' },
    { 'jjh', 'jh' },

    { 'rj',  'rl' },
    { 'jd',  'mb' },

    { 'uo',  'ue' },
    { 'uu',  'uo' },

    { 'sd',  'sc' },
    { 'sc',  'sd' },

    { 'sr',  'bl' },
    { 'ssr', 'sr' },

    { 'ih',  'oa' },
    { 'iih', 'ih' },

    { 'xm',  'br' },

    { 'qi',  'zi' },
    { 'zi',  'qi' },

    { 'qe',  'ze' },
    { 'ze',  'qe' },

    { 'qy',  'zy' },
    { 'zy',  'qy' },

    { 'qo',  'zo' },
    { 'zo',  'qo' },

    { 'qa',  'za' },
    { 'za',  'qa' },

    { 'qq',  'zz' },
    { 'zz',  'qq' },

    { 'sw',  'sx' },
    { 'sx',  'sw' },

    { 'eeg', 'eep' },

    { 'wj',  'ws' },
    { 'ws',  'wj' },
}

local magic_rule_snippets = convert_to_magic_snippets(magic_rules)
local magic_rules_flat = flatten(magic_rule_snippets)

ls.add_snippets('all', magic_rules_flat)

-- ========== PLUGIN: leap.nvim ==========

local leap = require('leap')
leap.opts.safe_labels = '' -- disables autojumping

-- Highly recommended: define a preview filter to reduce visual noise
-- and the blinking effect after the first keypress.
-- For example, define word boundaries as the common case, that is, skip
-- preview for matches starting with whitespace or an alphabetic
-- mid-word character: foobar[baaz] = quux
--                     ^    ^^^  ^^ ^ ^  ^
leap.opts.preview = function(ch0, ch1, ch2)
    return not (
        ch1:match('%s')
        or (ch0:match('%a') and ch1:match('%a') and ch2:match('%a'))
    )
end

-- ========== PLUGIN: hardtime.nvim ==========

-- require('hardtime').setup()

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

-- ========== AUTOCOMPLETION ==========

local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'default' },

    -- (Default) Only show the documentation popup when manually triggered
    completion = { documentation = { auto_show = false } },

    -- (Default) list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"`
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "rust" }
}

-- ========== APPEARANCE ==========

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    callback = function()
        vim.hl.on_yank {
            -- higroup = 'IncSearch', -- highlight group to use
            timeout = 160,         -- duration in milliseconds
        }
    end,
})

-- ========== THEMES ==========

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

-- ========== MINIMAP ==========

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

-- ========== BUFFERLINE ==========

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

-- ========== LUALINE ==========

local river_powerline = require('river-powerline')
require('lualine').setup {
    options = {
        theme = river_powerline
    }
}

-- ========== TREESITTER ==========

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

