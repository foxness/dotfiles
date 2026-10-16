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
map('n', '<leader>re', '<cmd>restart<CR>', { desc = 'Restart config (:restart)' })

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
map('n', '<leader>tu', function() snacks.picker.files { cwd = vim.fn.expand('$HOME/.config') } end, { desc = "Find Config File" })
map('n', '<leader>th', ':Oil<CR>', { desc = "Open File Explorer" })
map('n', '<leader>te', function() snacks.picker.grep() end, { desc = "Grep" })
map({ 'n', 'x' }, '<leader>ti', function() snacks.picker.grep_word() end, { desc = "Grep word" })
map('n', '<leader>tf', function() snacks.picker.help() end, { desc = "Find Help Pages" })

map("n", "<leader>dh", vim.diagnostic.open_float, { desc = "Show diagnostic" })
map("n", "<leader>da", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Previous diagnostic" })
map("n", "<leader>de", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next diagnostic" })

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

map('n', '<leader>ss', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace word cursor is on globally' })
map('n', '<leader>X', '<cmd>!chmod +x %<CR>', { silent = true, desc = 'makes file executable' })

map({ 'n', 'v' }, '<leader>dw', [["_d]], { desc = 'Delete without yanking' })

map('n', '<leader>v', 'vg_', { noremap = true, desc = 'Select to last non-blank character' })

-- ========== Motion ==========

-- Leap
map({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
map({ 'x', 'o' },      'x', '<Plug>(leap-next-to)')

-- Visit (jump - operate - jump back)
map({ 'n', 'x', 'o' }, 'gs', '<Plug>(leap-visit)')
map({ 'x', 'o' },      'ar', '<Plug>(leap-visit-text-object)')
map({ 'x', 'o' },      'ir', '<Plug>(leap-visit-inner-text-object)')

map('o', 'rr', function()  -- "visit line" shortcut
    return (vim.v.count == 0 and '1' or '') .. '<Plug>(leap-visit)'
end, { expr = true })

-- vim.api.nvim_create_autocmd('User', {  -- automatic paste on return
--     pattern = 'VisitDone',
--     group = vim.api.nvim_create_augroup('Visit', {}),
--     callback = function(event)
--         if
--             (event.data.mode:match('^[vV\22]') or (vim.v.operator == 'y'))
--             and event.data.register == '"'
--         then
--             vim.cmd('normal! p')
--         end
--     end,
-- })

-- Treeselect
map({ 'x', 'o' }, 'an', function()
    require('leap.treesitter').select {
        opts = require('leap.user').with_traversal_keys('n', 'N')
    }
end)

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

    map({ 'n', 'x', 'o' }, '<cr>', leapForward)
    map({ 'n', 'x', 'o' }, '<bs>', leapBackward)
end

map('n', '<leader>a', 'H')
map('n', '<leader>e', 'M')
map('n', '<leader>h', 'L')

map('n', 'H', '<nop>') -- should probably add some function to these
map('n', 'M', '<nop>')
map('n', 'L', '<nop>')
map('n', 'Q', '<nop>')

map({ 'n', 'v' }, '<PageDown>', '12j', { desc = 'move down in buffer' })
map({ 'n', 'v' }, '<PageUp>', '12k', { desc = 'move up in buffer' })

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

-- When Ghostty sees physical Alt+Left and Alt+Right, it converts them directly
-- into ESC b and ESC f behind the scenes to preserve standard Unix CLI
-- word-jumping (Alt-b / Alt-f). Because <M-...> and <A-...> are identical in
-- Neovim notation (Meta = Alt), Neovim receives those exact sequences and
-- registers them as <M-b> and <M-f> instead of <A-Left> and <A-Right>.
-- so Alt-Left and Alt-Right are M-b and M-f respectively.
map('n', '<M-b>', animate_scroll_and_center('<C-d>'), { desc = 'move down in buffer with cursor centered' })
map('n', '<M-f>', animate_scroll_and_center('<C-u>'), { desc = 'move up in buffer with cursor centered' })

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
    local cursor_pos = vim.api.nvim_win_get_cursor(0)

    -- Drop out of visual mode to lock in marks
    local esc = vim.api.nvim_replace_termcodes('<Esc>', true, false, true)
    vim.api.nvim_feedkeys(esc, 'x', false)

    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")

    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    local is_single_line = (start_line == end_line)
    local is_empty_last_line = (not is_single_line) and ((lines[#lines] or ""):match("^%s*$") ~= nil) and (end_line > start_line)

    local code_end = is_empty_last_line and (end_line - 1) or end_line
    local block_height = code_end - start_line + 1

    -- Yank and put
    vim.cmd(string.format('%d,%d yank', start_line, end_line))
    vim.cmd(string.format('%d put', end_line))

    local added_blank = 0
    if is_empty_last_line then
        added_blank = 1
    elseif not is_single_line then
        -- Multi-line selections (like vip) check below and inject empty line if missing
        -- Single-line visual selections skip blank injection entirely, matching normal mode
        local total_lines = vim.api.nvim_buf_line_count(0)
        local has_blank_below = false
        if end_line < total_lines then
            local next_line = vim.api.nvim_buf_get_lines(0, end_line, end_line + 1, false)[1]
            has_blank_below = next_line:match("^%s*$") ~= nil
        end

        if not has_blank_below then
            vim.api.nvim_buf_set_lines(0, end_line, end_line, false, { "" })
            added_blank = 1
        end
    end

    -- Comment the original code lines
    vim.cmd(string.format('normal! %dG%dV%dG', start_line, start_line, code_end))
    local gc_key = vim.api.nvim_replace_termcodes('gc', true, false, true)
    vim.api.nvim_feedkeys(gc_key, 'x', false)

    -- Snap cursor cleanly onto the duplicate block
    local new_row = cursor_pos[1] + block_height + added_blank
    vim.api.nvim_win_set_cursor(0, { new_row, cursor_pos[2] })
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
