
-- ========================================

vim.pack.add {
    { src = 'https://github.com/nvim-mini/mini.ai' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },
    { src = 'https://github.com/nvim-mini/mini.extra' },
}

-- ========================================

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


