-- ========== Main ==========

local map = vim.keymap.set
vim.g.mapleader = ' '

-- ========== Main ==========

-- all modes: n, i, c, v, o, t, l
-- map({ 'i', 'c', 'v', 'o', 't', 'l' }, '<D-j>', '<Esc>')  -- <D-j> is cmd-J
-- map('n', '<D-j>', ':nohl<CR><Esc>', { desc = 'Clear search highlighting', silent = true })

map('n', '<Esc>', ':nohl<CR>', { desc = 'Clear search highlighting', silent = true })

map('n', '<leader>so', ':update<CR> :source<CR>')
map('n', '<leader>w', ':write<CR>')
map('n', '<leader>b', '<Cmd>quit<CR>')
map('n', '<leader>r', ':update<CR> :make<CR>')
map('n', '<leader>re', '<cmd>restart<CR>', { desc = 'Restart config (:eestart)' })

-- ========== Navigation ==========

map('n', '<C-b>', ':bprevious<CR>', { silent = true })
map('n', '<C-l>', ':bnext<CR>', { silent = true })

-- close the current buffer without messing up your window splits
map('n', '<leader>l', ':bdelete<CR>', { silent = true })

map('n', '<leader>h', ':Pick files<CR>')
map('n', '<leader>a', ':Pick grep_live<CR>')
map('n', '<leader>e', ':Oil<CR>')
map('n', '<leader>i', ':Pick help<CR>')

-- local tsbuiltin = require('telescope.builtin')
-- map('n', '<leader>a', tsbuiltin.find_files, { desc = 'Telescope find files' })
-- map('n', '<leader>ff', function() tsbuiltin.find_files({ hidden = true }) end, { desc = 'Telescope find hidden files' })
-- map('n', '<leader>fg', tsbuiltin.live_grep, { desc = 'Telescope live grep' })
-- map('n', '<leader>fb', tsbuiltin.buffers, { desc = 'Telescope buffers' })
-- map('n', '<leader>fh', tsbuiltin.help_tags, { desc = 'Telescope help tags' })

-- ========== Standard enhancements ==========

map('x', 'p', [["_dP]], { desc = 'paste over selection without losing yanked text' })
map('n', 'J', 'mzJ`z', { desc = 'Join lines without moving cursor' })

map('v', 'J', ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

map('v', '<', '<gv', { desc = 'Unindent and keep selection' })
map('v', '>', '>gv', { desc = 'Indent and keep selection' })

map('n', 'X', '<Cmd>normal gcc<CR>', { desc = 'Comment one line' })
map('v', 'X', '<Cmd>normal gc<CR>', { desc = 'Comment selection' })

map('n', '<leader>lf', vim.lsp.buf.format)

map('n', '<leader>ss', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = 'Replace word cursor is on globally' })
map('n', '<leader>X', '<cmd>!chmod +x %<CR>', { silent = true, desc = 'makes file executable' })

map({ 'n', 'v' }, '<leader>d', [['_d]], { desc = 'Delete without yanking' })

map('n', '<leader>v', 'vg_', { noremap = true, desc = 'Select to last non-blank character' })

-- ========== Motion ==========

map({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
map('n', 'S', '<Plug>(leap-from-window)')

-- ========== Motion centering ==========

map('n', '<C-h>', '<C-d>zz', { desc = 'move down in buffer with cursor centered' })
map('n', '<C-a>', '<C-u>zz', { desc = 'move up in buffer with cursor centered' })

map('n', 'n', 'nzzzv', { desc = 'Next search result cursor centered' })
map('n', 'N', 'Nzzzv', { desc = 'Previous search result cursor centered' })

map('n', 'G', 'Gzz', { noremap = true, desc = 'Go to bottom and center' })

map('n', '*', '*zz', { noremap = true })
map('n', '#', '#zz', { noremap = true })
map('n', 'g*', 'g*zz', { noremap = true })
map('n', 'g#', 'g#zz', { noremap = true })

-- ========== Line Add/Delete ==========

map('n', '<leader>o', function()
    vim.fn.append(vim.fn.line('.'), '')
end, { desc = 'Add empty line below' })

map('n', '<leader>u', function()
    vim.fn.append(vim.fn.line('.') - 1, '')
end, { desc = 'Add empty line above' })

-- uses black hole register '_'
map('n', '<leader>do', function()
    local pos = vim.api.nvim_win_get_cursor(0)
    local target = pos[1] + 1
    if target <= vim.api.nvim_buf_line_count(0) then
        vim.cmd(target .. 'delete _')
        vim.api.nvim_win_set_cursor(0, pos)
    end
end, { desc = 'Delete line below' })

map('n', '<leader>du', function()
    local pos = vim.api.nvim_win_get_cursor(0)
    local target = pos[1] - 1
    if target >= 1 then
        vim.cmd(target .. 'delete _')
        vim.api.nvim_win_set_cursor(0, { pos[1] - 1, pos[2] })
    end
end, { desc = 'Delete line above' })

-- ========== Duplicate and comment ==========

local function duplicate_and_comment()
    -- Exit visual mode
    local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
    vim.api.nvim_feedkeys(esc, "x", false)

    -- Get selection range
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")

    -- Yank and paste below
    vim.cmd(start_line .. "," .. end_line .. "yank")
    vim.cmd((end_line + 1) .. "put")

    -- Reselect pasted block
    vim.api.nvim_feedkeys("gv", "n", false)

    -- Comment the original selection
    vim.api.nvim_feedkeys("gc", "v", false)
end

map('n', '<leader>yc', 'yy<cmd>normal gcc<CR>p', { noremap = true, desc = 'Duplicate line and comment original' })
map('v', '<leader>yc', duplicate_and_comment, { noremap = true, desc = 'Duplicate selection and comment original' })

-- ========== Native undotree ==========

map('n', '<leader>z', function()
    vim.cmd.packadd('nvim.undotree')
    require('undotree').open()
end, { desc = 'Toggle Builtin Undotree' })
