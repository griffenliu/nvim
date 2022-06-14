local vim = vim
local notify = vim.notify
local cmd = vim.cmd

local base = require("core.plugin.base")

local _M = base.new {
    name = "nvim-lsp-installer", -- require name
    desc = "LSP-Installer",
    github = "https://github.com/williamboman/nvim-lsp-installer",
    packer = {
        "williamboman/nvim-lsp-installer",
        -- nvim-lsp-installer 近期更新了一个不兼容的改变，我们要锁定在指定的 commit 中
        commit = "36b44679f7cc73968dbb3b09246798a19f7c14e0",
        config = function()
            require("plugins.configs.lsp.installer"):config()
        end
    },
    packer_ext = { -- rust 语言增强
    {"simrat39/rust-tools.nvim"}}
}

-- _M.set_keymaps = function(self, keymaps)
-- TODO: 看一下文档，全部使用默认值，除非有必要自定义
-- -- 默认通用缓冲区按键设置（这个需要在各个实际的配置中定义绑定）
-- -- rename
-- keymaps.set_buffer(self.name, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", "重命名变量")
-- -- code action
-- keymaps.set_buffer("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", "代码Action?")
-- -- go xx
-- keymaps.set_buffer(self.name, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "跳转到定义")
-- keymaps.set_buffer(self.name, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", "显示定义")
-- keymaps.set_buffer(self.name, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "跳转到声明")
-- keymaps.set_buffer(self.name, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", "跳转到实现")
-- keymaps.set_buffer(self.name, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", "跳转到引用")
-- -- diagnostic
-- keymaps.set_buffer(self.name, "n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", "打开错误信息")
-- keymaps.set_buffer(self.name, "n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "上一个错误")
-- keymaps.set_buffer(self.name, "n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", "下一个错误")
-- keymaps.set_buffer(self.name, "n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", "格式化")
-- 没用到
-- keymaps.set_buffer(plugin_name, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
-- keymaps.set_buffer(plugin_name, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
-- keymaps.set_buffer(plugin_name, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
-- keymaps.set_buffer(plugin_name, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
-- keymaps.set_buffer(plugin_name, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
-- keymaps.set_buffer(plugin_name, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
-- end

_M.setup = function(self, keymaps)

    -- 安装列表
    -- { key: 语言 value: 配置文件 }
    -- key 必须为下列网址列出的名称
    -- https://github.com/williamboman/nvim-lsp-installer#available-lsps
    -- TODO: 这个也安排到全局选项参数中，这样可以动态配置语言，想要的配置，不想要的不配置
    local servers = {
        -- lua
        sumneko_lua = require("plugins.configs.lsp.langs.lua")
        -- rust
        -- rust_analyzer = require("plugins.configs.lsp.langs.rust")
    }
    -- 自动安装 Language Servers
    for name, _ in pairs(servers) do
        local server_is_found, server = self.plugin.get_server(name)
        if server_is_found then
            if not server:is_installed() then
                print("Installing " .. name)
                server:install()
            end
        end
    end

    self.plugin.on_server_ready(function(server)
        local config = servers[server.name]
        if config == nil then
            return
        end
        if config.on_setup then
            config.on_setup(server)
        else
            server:setup({})
        end
    end)
end

return _M
