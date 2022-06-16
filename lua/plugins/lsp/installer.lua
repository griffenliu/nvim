local vim = vim
local notify = vim.notify
local cmd = vim.cmd

local base = require('core.plugin.base')

local _M = base.new({
    name = 'nvim-lsp-installer', -- require name
    group = "LSP",
    desc = '安装器',
    github = 'https://github.com/williamboman/nvim-lsp-installer',
    packer = {
        'williamboman/nvim-lsp-installer',
        config = function()
            require('plugins.lsp.installer'):config()
        end
    },
    packer_ext = { -- rust 语言增强
    {'simrat39/rust-tools.nvim'}}
})

_M.setup = function(self)
    self.plugin.setup {
        ensure_installed = {"sumneko_lua", "rust_analyzer"},
        ui = {
            icons = {
                server_installed = "✓",
                server_pending = "➜",
                server_uninstalled = "✗"
            }
        }
    }

    -- 安装列表
    -- { key: 语言 value: 配置文件 }
    -- key 必须为下列网址列出的名称
    -- https://github.com/williamboman/nvim-lsp-installer#available-lsps
    -- TODO: 这个也安排到全局选项参数中，这样可以动态配置语言，想要的配置，不想要的不配置
    -- local servers = {
    --     sumneko_lua = require('plugins.lsp.langs.lua'), -- lua
    --     -- ansiblels = {}, -- ansible
    --     -- bashls = {}, -- Bash
    --     -- dockerls = {}, -- Docker
    --     -- eslint = {}, -- Eslint
    --     -- html = {},
    --     -- jsonls = {}, -- json
    --     -- jdtls = {}, -- java
    --     -- tsserver = {}, -- javascript, typescript
    --     remark_ls = {}, -- markdown
    --     -- rust_analyzer = require('plugins.configs.lsp.langs.rust'), -- rust
    --     -- sqls = {}, -- sql
    --     -- taplo = {}, -- toml
    --     -- volar = {}, -- vue
    --     -- lemminx = {}, -- xml
    --     -- yamlls = {}, -- yaml
    -- }
    -- -- 自动安装 Language Servers
    -- for name, _ in pairs(servers) do
    --     local server_is_found, server = self.plugin.get_server(name)
    --     if server_is_found then
    --         if not server:is_installed() then
    --             print('Installing ' .. name)
    --             server:install()
    --         end
    --     end
    -- end

    -- self.plugin.on_server_ready(function(server)
    --     local config = servers[server.name]
    --     if config == nil then
    --         return
    --     end
    --     if config.on_setup then
    --         config.on_setup(server)
    --     else
    --         server:setup({})
    --     end
    -- end)
end

return _M
