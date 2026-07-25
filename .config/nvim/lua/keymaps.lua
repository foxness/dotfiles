local map = vim.keymap.set
vim.g.mapleader = ' '

map({ 'v', 'i' }, '<D-j>', '<Esc>') -- <D-j> is cmd-J
map('n', '<D-j>', ':nohl<CR>', { desc = 'Clear search highlighting', silent = true })

map('n', '<leader>so', ':update<CR> :source<CR>')
map('n', '<leader>w', ':write<CR>')
map('n', '<leader>b', '<Cmd>quit<CR>')

map('n', '<leader>lf', vim.lsp.buf.format)
map('n', '<leader>f', ':Pick files<CR>')
map('n', '<leader>i', ':Pick help<CR>')
map('n', '<leader>h', ':Oil<CR>')

map('x', 'p', [["_dP]], { desc = 'paste over selection without losing yanked text' })

map({ 'n', 'v' }, '<leader>d', [['_d]], { desc = 'Delete without yanking' })

map('v', 'J', ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

map('v', '<', '<gv', { desc = 'Unindent and keep selection' })
map('v', '>', '>gv', { desc = 'Indent and keep selection' })

map('n', 'J', 'mzJ`z', { desc = 'Join lines without moving cursor' })

map('n', '<C-d>', '<C-d>zz', { desc = 'move down in buffer with cursor centered' })
map('n', '<C-u>', '<C-u>zz', { desc = 'move up in buffer with cursor centered' })

map('n', 'n', 'nzzzv', { desc = 'Next search result cursor centered' })
map('n', 'N', 'Nzzzv', { desc = 'Previous search result cursor centered' })

map('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace word cursor is on globally' })
map('n', '<leader>X', '<cmd>!chmod +x %<CR>', { silent = true, desc = 'makes file executable' })

map('n', '<leader>re', '<cmd>restart<cr>', { desc = 'Restart config (:eestart)' })

-- native undotree
map('n', '<leader>u', function()
    vim.cmd.packadd('nvim.undotree')
    require('undotree').open()
end, { desc = 'Toggle Builtin Undotree' })
