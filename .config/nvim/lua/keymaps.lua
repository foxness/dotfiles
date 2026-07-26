local map = vim.keymap.set
vim.g.mapleader = ' '

----- Escape -----

map({ 'v', 'i', 'c', 't' }, '<D-j>', '<Esc>') -- <D-j> is cmd-J
map('n', '<D-j>', ':nohl<CR>', { desc = 'Clear search highlighting', silent = true })

----- Navigation -----

map('n', '<S-h>', ':bprevious<CR>', { silent = true })
map('n', '<S-l>', ':bnext<CR>', { silent = true })

-- Close the current buffer without messing up your window splits
map('n', '<leader>bd', ':bdelete<CR>', { silent = true })

----- Centering -----

map('n', '<C-d>', '<C-d>zz', { desc = 'move down in buffer with cursor centered' })
map('n', '<C-u>', '<C-u>zz', { desc = 'move up in buffer with cursor centered' })

map('n', 'n', 'nzzzv', { desc = 'Next search result cursor centered' })
map('n', 'N', 'Nzzzv', { desc = 'Previous search result cursor centered' })

map('n', 'G', 'Gzz', { noremap = true, desc = 'Go to bottom and center' })

map('n', '*', '*zz', { noremap = true })
map('n', '#', '#zz', { noremap = true })
map('n', 'g*', 'g*zz', { noremap = true })
map('n', 'g#', 'g#zz', { noremap = true })

----- Standard enhancements -----

map('x', 'p', [["_dP]], { desc = 'paste over selection without losing yanked text' })
map('n', 'J', 'mzJ`z', { desc = 'Join lines without moving cursor' })

map('v', 'J', ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

map('v', '<', '<gv', { desc = 'Unindent and keep selection' })
map('v', '>', '>gv', { desc = 'Indent and keep selection' })

map('n', '<leader>v', 'vg_', { noremap = true, desc = 'Select to last non-blank character' })

----- Leader -----

map('n', '<leader>so', ':update<CR> :source<CR>')
map('n', '<leader>w', ':write<CR>')
map('n', '<leader>b', '<Cmd>quit<CR>')

map('n', '<leader>lf', vim.lsp.buf.format)
map('n', '<leader>f', ':Pick files<CR>')
map('n', '<leader>i', ':Pick help<CR>')
map('n', '<leader>h', ':Oil<CR>')

map('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = 'Replace word cursor is on globally' })
map('n', '<leader>X', '<cmd>!chmod +x %<CR>', { silent = true, desc = 'makes file executable' })

map('n', '<leader>re', '<cmd>restart<cr>', { desc = 'Restart config (:eestart)' })

map({ 'n', 'v' }, '<leader>l', [['_d]], { desc = 'Delete without yanking' })

map('n', '<leader>o', 'mzo<Esc>`z')
map('n', '<leader>O', 'mzO<Esc>`z')

map('n', '<leader>d', 'mzjdd`z')
map('n', '<leader>D', 'mzkdd`z')

map('n', '<leader>r', ':update<CR> :make<CR>')
-- map('n', '<C-U>', '<C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>')
-- map('n', '<C-D>', '<C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>')

----- Duplicate and comment -----

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

map('n', 'yc', 'yy<cmd>normal gcc<CR>p', { noremap = true, desc = 'Duplicate line and comment original' })
map('v', 'yc', duplicate_and_comment, { noremap = true, desc = 'Duplicate selection and comment original' })

----- Native undotree -----

map('n', '<leader>u', function()
    vim.cmd.packadd('nvim.undotree')
    require('undotree').open()
end, { desc = 'Toggle Builtin Undotree' })
