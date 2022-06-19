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
        -- 研究半天，觉得这个懒加载是有BUG的，还是自己实现一个？
        -- ft = "*", -- 懒加载
        -- cond = function()
        --     -- print("111111111111111111")
        --     -- local file = vim.fn.expand "%"
        --     -- -- vim.notify("current file" .. vim.inspect(file))
        --     -- return file ~= "NvimTree_1" and file ~= "[packer]" and file ~= ""
        --     return true
        -- end,
        opt = true
        -- config = function()
        --     print("1111111111111111111111111111")
        --     require('plugins.lsp.installer'):config()
        -- end
    }
})

_M.setup = function(self)
    -- print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    self.plugin.setup {
        automatic_installation = true,
        ui = {
            icons = {
                server_installed = "✓",
                server_pending = "➜",
                server_uninstalled = "✗"
            }
        },
        max_concurrent_installers = 20
    }

    -- for _, s in ipairs(self.plugin.get_installed_servers()) do
    --     s:setup()
    -- end

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
