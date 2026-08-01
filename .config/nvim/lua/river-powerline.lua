local colors = {
    white        = '#ffffff',
    darkestgreen = '#005f00',
    brightgreen  = '#afdf00',
    darkestcyan  = '#005f5f',
    mediumcyan   = '#87dfff',
    darkestblue  = '#005f87',
    darkred      = '#870000',
    brightred    = '#df0000',
    brightorange = '#ff8700',
    gray1        = '#262626',
    gray2        = '#303030',
    gray4        = '#585858',
    gray5        = '#606060',
    gray7        = '#9e9e9e',
    gray10       = '#f0f0f0',
    pink         = '#d7005f',
}

local theme = {
    normal = {
        a = { fg = colors.darkestgreen, bg = colors.brightgreen, gui = 'bold' },
        b = { fg = colors.gray10, bg = colors.gray5 },
        c = { fg = colors.gray7, bg = colors.gray2 },
    },
    insert = {
        a = { fg = colors.darkestcyan, bg = colors.white, gui = 'bold' },
        b = { fg = colors.darkestcyan, bg = colors.mediumcyan },
        c = { fg = colors.mediumcyan, bg = colors.darkestblue },
    },
    visual = { a = { fg = colors.darkred, bg = colors.brightorange, gui = 'bold' } },
    replace = { a = { fg = colors.white, bg = colors.brightred, gui = 'bold' } },
    inactive = {
        a = { fg = colors.gray1, bg = colors.gray5, gui = 'bold' },
        b = { fg = colors.gray1, bg = colors.gray5 },
        c = { bg = colors.gray1, fg = colors.gray5 },
    },
}

theme.terminal = theme.insert

return theme
