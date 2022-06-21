local vim = vim
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

-- local base = require('plugins.lsp.langs.base')
local _M = {}
-- local _M = base.new({
-- settings = {
--     Lua = {
--         runtime = {
--             -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--             version = 'LuaJIT',
--             -- Setup your lua path
--             path = runtime_path,
--         },
--         diagnostics = {
--             -- Get the language server to recognize the `vim` global
--             globals = { 'vim' },
--         },
--         workspace = {
--             -- Make the server aware of Neovim runtime files
--             library = vim.api.nvim_get_runtime_file('', true),
--             checkThirdParty = false,
--         },
--         -- Do not send telemetry data containing a randomized but unique identifier
--         telemetry = {
--             enable = false,
--         },
--     },
-- },
-- flags = {
--     debounce_text_changes = 150,
-- },
-- on_attach = function(client, bufnr)
--   -- 禁用格式化功能，交给专门插件插件处理
--   client.resolved_capabilities.document_formatting = false
--   client.resolved_capabilities.document_range_formatting = false
--   -- 绑定快捷键
--   require("core.keymaps").bind("nvim-lsp-installer", bufnr)
--   -- 保存时自动格式化
--   -- FIXME: 暂时禁用，保存自动格式化还没有配好
--   -- vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
-- end,
-- })

_M.setup = function(lspconfig, opts)
    opts.settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    }
    lspconfig.sumneko_lua.setup(opts)
end

return _M
-- -- 查看目录等信息
-- return {
--     on_setup = function(server)
--         server:setup(opts)
--     end
-- }
