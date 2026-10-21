
-- ========================================

vim.pack.add {
    { src = 'https://codeberg.org/andyg/leap.nvim' },
    { src = 'https://github.com/tpope/vim-repeat' },
}

-- ========================================

local leap = require('leap')

-- disables autojumping, so you always have to choose a label
-- but this feels much more predictable and consistent
leap.opts.safe_labels = ''

-- default is
-- leap.opts.labels = 'sfnjklhodweimbuyvrgtaqpcxz/SFNJKLHODWEIMBUYVRGTAQPCXZ?'

-- labels are based on Graphite keyboard layout and prioritize:
-- - left hand > right hand (because typically the 2 char sequence ends on a vowel on the right hand)
-- - home row > top row > bottom row
-- - index > middle > ring > pinky
-- - top row pinkies are the worst so dead last
leap.opts.labels = 'strnwdlgjcmxvqhaeifouykpbz/STRNWDLGJCMXVQHAEIFOUYKPBZ'

-- Highly recommended: define a preview filter to reduce visual noise
-- and the blinking effect after the first keypress.
-- For example, define word boundaries as the common case, that is, skip
-- preview for matches starting with whitespace or an alphabetic
-- mid-word character: foobar[baaz] = quux
--                     ^    ^^^  ^^ ^ ^  ^

-- leap.opts.preview = function(ch0, ch1, ch2)
--     return not (
--         ch1:match('%s')
--         or (ch0:match('%a') and ch1:match('%a') and ch2:match('%a'))
--     )
-- end

-- leap.opts.preview = false
leap.opts.preview = function(ch0, ch1, ch2)
    -- Skip matches starting with whitespace altogether.
    if ch1:match('%s') then
        return false
    end

    -- ASCII non-alpha (includes whitespace).
    local delim = '[\1-\64\91-\96\123-\127]'
    return (
        -- Show matches touching a delimiter or line start/end.
        ch0:match(delim) or ch2:match(delim) or (ch0 == '') or (ch2 == '')
        -- To cover the edge case of a single non-whitespace delimiter
        -- between letters (`foo:bar`).
        or ch1:match(delim)
    )
end

-- grey out buffer during preview
vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('LeapBackdrop', {}),
    callback = function()
        if vim.g.colors_name == 'gruvbox' then
            require('leap.user').set_backdrop_highlight('Comment')
        end
    end
})

