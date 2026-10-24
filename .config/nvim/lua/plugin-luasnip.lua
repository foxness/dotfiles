
-- ========================================

vim.pack.add {
    { src = 'https://github.com/L3MON4D3/LuaSnip' },
}

-- ========================================

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

    { 'jjy',  'jy' },
    { 'jy',  'py' },

    { 'yyj',  'yj' },
    { 'yj',  'yp' },
}

local magic_rule_snippets = convert_to_magic_snippets(magic_rules)
local magic_rules_flat = flatten(magic_rule_snippets)

ls.add_snippets('all', magic_rules_flat)

