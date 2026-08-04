--
-- =======================================
--

local map = vim.keymap.set
vim.g.mapleader = ' '

local snacks = require('snacks')
local leap = require('leap')
local animate = require('mini.animate')

-- ========== General ==========

-- all modes: n, i, c, v, o, t, l
-- map({ 'i', 'c', 'v', 'o', 't', 'l' }, '<D-j>', '<Esc>')  -- <D-j> is cmd-J
-- map('n', '<D-j>', ':nohl<CR><Esc>', { desc = 'Clear search highlighting', silent = true })

map('n', '<Esc>', ':nohl<CR>', { desc = 'Clear search highlighting', silent = true })

map('n', '<leader>so', ':update<CR> :source<CR>')
map('n', '<leader>w', ':write<CR>')
map('n', '<leader>b', '<Cmd>quit<CR>')
map('n', '<leader>r', ':update<CR> :make<CR>')
map('n', '<leader>re', '<cmd>restart<CR>', { desc = 'Restart config (:eestart)' })

-- ========== Other ==========

map('n', '<leader>si', snacks.rename.rename_file, { desc = "Rename file" })

-- ========== Navigation ==========

map('n', '<C-b>', ':bprevious<CR>', { silent = true })
map('n', '<C-l>', ':bnext<CR>', { silent = true })

-- close the current buffer without messing up your window splits
-- map('n', '<leader>l', ':bdelete<CR>', { silent = true })
map('n', '<leader>l', function() snacks.bufdelete() end, { desc = 'Delete buffer' })

-- map('n', '<leader>h', ':Pick files<CR>')
-- map('n', '<leader>a', ':Pick grep_live<CR>')
-- map('n', '<leader>e', ':Oil<CR>')
-- map('n', '<leader>i', ':Pick help<CR>')

map('n', '<leader>ta', function() snacks.picker.files() end, { desc = "Find Files" })
-- map('n', '<leader>tu', function() snacks.picker.files { cwd = vim.fn.stdpath("config") } end, { desc = "Find Config File" })
map('n', '<leader>tu', function() snacks.picker.files { cwd = vim.fn.expand('$HOME/.config') } end,
    { desc = "Find Config File" })
map('n', '<leader>th', ':Oil<CR>', { desc = "Open File Explorer" })
map('n', '<leader>te', function() snacks.picker.grep() end, { desc = "Grep" })
map({ 'n', 'x' }, '<leader>ti', function() snacks.picker.grep_word() end, { desc = "Grep word" })
map('n', '<leader>tf', function() snacks.picker.help() end, { desc = "Find Help Pages" })

map("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Show diagnostic" })
map("n", "<leader>dj", function() vim.diagnostic.jump({ count = -1, float = true }) end,
    { desc = "Previous diagnostic" })
map("n", "<leader>dw", function() vim.diagnostic.jump({ count = 1, float = true }) end,
    { desc = "Next diagnostic" })

-- ========== Standard enhancements ==========

map('x', 'p', [["_dP]], { desc = 'paste over selection without losing yanked text' })
map('n', 'J', 'mzJ`z', { desc = 'Join lines without moving cursor' })

map('v', 'J', ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

map('v', '<', '<gv', { desc = 'Unindent and keep selection' })
map('v', '>', '>gv', { desc = 'Indent and keep selection' })

map('n', 'X', '<Cmd>normal gcc<CR>', { desc = 'Comment one line' })
map('v', 'X', '<Cmd>normal gc<CR>', { desc = 'Comment selection' })

map('n', '<leader>df', vim.lsp.buf.format)

map('n', '<leader>ss', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = 'Replace word cursor is on globally' })
map('n', '<leader>X', '<cmd>!chmod +x %<CR>', { silent = true, desc = 'makes file executable' })

map({ 'n', 'v' }, '<leader>d', [['_d]], { desc = 'Delete without yanking' })

map('n', '<leader>v', 'vg_', { noremap = true, desc = 'Select to last non-blank character' })

-- ========== Motion ==========

map({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
map({ 'x', 'o' }, 'x', '<Plug>(leap-next-to)')

-- Enable the traversal keys to repeat the previous search without
-- explicitly invoking Leap (`<cr><cr>...` instead of `s<cr><cr>...`):
do
    local clever = require('leap.user').with_traversal_keys

    local function leapForward()
        leap.leap { ['repeat'] = true, opts = clever('<cr>', '<bs>') }
    end

    local function leapBackward()
        leap.leap { ['repeat'] = true, opts = clever('<bs>', '<cr>'), backward = true }
    end

    vim.keymap.set({ 'n', 'x', 'o' }, '<cr>', leapForward)
    vim.keymap.set({ 'n', 'x', 'o' }, '<bs>', leapBackward)
end

map('n', '<leader>a', 'H')
map('n', '<leader>e', 'M')
map('n', '<leader>h', 'L')

map('n', 'H', '<nop>') -- should probably add some function to these
map('n', 'M', '<nop>')
map('n', 'L', '<nop>')
map('n', 'Q', '<nop>')

-- ========== Animated motion centering ==========

local function animate_scroll_and_center(key)
    return function()
        animate.execute_after('scroll', 'normal! zvzz')
        local termcode = vim.api.nvim_replace_termcodes(key, true, false, true)
        -- 'm' mode ensures it respects mini.animate's keymaps
        vim.api.nvim_feedkeys(termcode, 'm', false)
    end
end

local function animate_motion_and_center(motion, post_keys)
    post_keys = post_keys or 'zvzz'
    return function()
        -- execute the motion without triggering user keymaps
        vim.cmd('normal! ' .. vim.api.nvim_replace_termcodes(motion, true, false, true))
        -- queue the centering hook right after the scroll animation completes
        animate.execute_after('scroll', 'normal! ' .. post_keys)
    end
end

map('n', '<PageDown>', animate_scroll_and_center('<C-d>'), { desc = 'move down in buffer with cursor centered' })
map('n', '<PageUp>', animate_scroll_and_center('<C-u>'), { desc = 'move up in buffer with cursor centered' })

-- search next/prev
map('n', 'n', animate_motion_and_center('n'), { desc = 'Next search result cursor centered' })
map('n', 'N', animate_motion_and_center('N'), { desc = 'Previous search result cursor centered' })

-- go to bottom
map('n', 'G', animate_motion_and_center('G', 'zz'), { desc = 'Go to bottom and center' })

-- word under cursor searches
map('n', '*', animate_motion_and_center('*', 'zz'), { desc = 'Search word forward and center' })
map('n', '#', animate_motion_and_center('#', 'zz'), { desc = 'Search word backward and center' })
map('n', 'g*', animate_motion_and_center('g*', 'zz'), { desc = 'Search exact word forward and center' })
map('n', 'g#', animate_motion_and_center('g#', 'zz'), { desc = 'Search exact word backward and center' })

-- manual center
map('n', '<leader>i', 'zz', { desc = 'Center cursor in window' })

-- ========== Unanimated motion centering ==========

-- map('n', '<C-h>', '<C-d>zz', { desc = 'move down in buffer with cursor centered' })
-- map('n', '<C-a>', '<C-u>zz', { desc = 'move up in buffer with cursor centered' })

-- map('n', 'n', 'nzzzv', { desc = 'Next search result cursor centered' })
-- map('n', 'N', 'Nzzzv', { desc = 'Previous search result cursor centered' })
--
-- map('n', 'G', 'Gzz', { noremap = true, desc = 'Go to bottom and center' })
--
-- map('n', '*', '*zz', { noremap = true })
-- map('n', '#', '#zz', { noremap = true })
-- map('n', 'g*', 'g*zz', { noremap = true })
-- map('n', 'g#', 'g#zz', { noremap = true })
--
-- map('n', '<leader>i', 'zz')

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

-- ========== Change directory ==========

local function changeDirectory()
    local dir = vim.fn.expand('%:p:h')
    if dir ~= '' and vim.fn.isdirectory(dir) == 1 then
        vim.api.nvim_set_current_dir(dir)
        local pretty_dir = vim.fn.fnamemodify(dir, ':~')
        print('CWD changed to: ' .. pretty_dir)
    else
        print('No valid directory found for current buffer')
    end
end

map('n', '<leader>di', changeDirectory, { desc = 'Change CWD to current file directory' })
