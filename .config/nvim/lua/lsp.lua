-- LSPs

vim.lsp.config('lua_ls', {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = { library = { vim.env.VIMRUNTIME } },
        },
    },
})

-- vim.lsp.config('sourcekit', {
--     cmd = { 'sourcekit-lsp' },
--     filetypes = { 'swift' },
--     root_markers = {
--         '.git',
--         'compile_commands.json',
--         '.sourcekit-lsp',
--         'Package.swift',
--     },
--     get_language_id = function(_, ftype)
--         return ftype
--     end,
--     capabilities = {
--         workspace = {
--             didChangeWatchedFiles = {
--                 dynamicRegistration = true,
--             },
--         },
--         textDocument = {
--             diagnostic = {
--                 dynamicRegistration = true,
--                 relatedDocumentSupport = true,
--             },
--         },
--     },
-- })

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP Buffer Keymaps',
    callback = function(args)
        -- only map gd because neovim's gr* defaults didn't touch it
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf, silent = true })
    end,
})

-- Language Server Protocols:
-- lua: lua_ls
-- python: pyright, ruff
-- swift: sourcekit

vim.lsp.enable({ 'lua_ls', 'pyright', 'ruff' })
