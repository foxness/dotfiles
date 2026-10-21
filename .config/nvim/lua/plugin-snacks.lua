
-- ========================================

vim.pack.add {
    { src = 'https://github.com/folke/snacks.nvim' },
}

-- ========================================

require('snacks').setup {
    bigfile = { enabled = false },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    indent = { enabled = false },
    input = { enabled = false },
    notifier = {
        enabled = true,
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

