local _M = {}

-- 注意，这个会按照顺序自动进行排序，因此需要注意设置正确的排序路径
_M.setup = function()
  local plugins = require("core.plugins")
  plugins.add(require("lsp.configs.installer"):after({ "nvim-notify" }))
  plugins.add(require("lsp.configs.ui"):after({ "nvim-notify" }))
  plugins.add(require("lsp.configs.cmp"):after({ "nvim-notify", "nvim-lsp-installer", "lspkind-nvim" }))
end

return _M

-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd

-- local function check(plugin_name)
--   local status, plugin = pcall(require, plugin_name)
--   if not status then
--     notify(plugin_name .. " not found!")
--     return false
--   end
--   return plugin
-- end

-- local set_keymaps
-- local function setup_keymaps(plugin_name)
--   if set_keymaps and type(set_keymaps) == "function" then
--     local keymaps = require("core.keymaps")
--     set_keymaps(plugin_name, keymaps)
--     keymaps.bind(plugin_name)
--   end
-- end

-- -- ============================================================================
-- set_keymaps = function(plugin_name, keymaps)
--   -- 默认通用缓冲区按键设置（这个需要在各个实际的配置中定义绑定）
--   -- rename
--   keymaps.set_buffer(plugin_name, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", "重命名变量")
--   -- code action
--   keymaps.set_buffer("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", "代码Action?")
--   -- go xx
--   keymaps.set_buffer(plugin_name, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "跳转到定义")
--   keymaps.set_buffer(plugin_name, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", "显示定义")
--   keymaps.set_buffer(plugin_name, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "跳转到声明")
--   keymaps.set_buffer(plugin_name, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", "跳转到实现")
--   keymaps.set_buffer(plugin_name, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", "跳转到引用")
--   -- diagnostic
--   keymaps.set_buffer(plugin_name, "n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", "打开错误信息")
--   keymaps.set_buffer(plugin_name, "n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "上一个错误")
--   keymaps.set_buffer(plugin_name, "n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", "下一个错误")
--   keymaps.set_buffer(plugin_name, "n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", "格式化")
--   -- 没用到
--   -- keymaps.set_buffer(plugin_name, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
--   -- keymaps.set_buffer(plugin_name, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
--   -- keymaps.set_buffer(plugin_name, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
--   -- keymaps.set_buffer(plugin_name, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
--   -- keymaps.set_buffer(plugin_name, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
--   -- keymaps.set_buffer(plugin_name, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
-- end

-- local _M = {
--   name = "nvim-lsp-installer", -- require name
--   desc = "LSP",
--   packer = {
--     "williamboman/nvim-lsp-installer",
--     -- nvim-lsp-installer 近期更新了一个不兼容的改变，我们要锁定在指定的 commit 中
--     commit = "36b44679f7cc73968dbb3b09246798a19f7c14e0",
--     config = function()
--       require("lsp").config()
--     end
--   },
--   packer_ext = {
--     { "neovim/nvim-lspconfig" },
--     -- rust 语言增强
--     { "simrat39/rust-tools.nvim" }
--   }
-- }

-- local function plugin_setup(plugin, plugin_name)
--   -- 安装列表
--   -- { key: 语言 value: 配置文件 }
--   -- key 必须为下列网址列出的名称
--   -- https://github.com/williamboman/nvim-lsp-installer#available-lsps
--   local servers = {
--     -- lua
--     sumneko_lua = require("lsp.configs.lua"), -- lua/lsp/configs/lua.lua
--     -- rust
--     rust_analyzer = require("lsp.configs.rust"),
--   }
--   -- 自动安装 Language Servers
--   for name, _ in pairs(servers) do
--     local server_is_found, server = plugin.get_server(name)
--     if server_is_found then
--       if not server:is_installed() then
--         print("Installing " .. name)
--         server:install()
--       end
--     end
--   end

--   plugin.on_server_ready(function(server)
--     local config = servers[server.name]
--     if config == nil then
--       return
--     end
--     if config.on_setup then
--       config.on_setup(server)
--     else
--       server:setup({})
--     end
--   end)
-- end

-- -- ============================================================================
-- _M.config = function()
--   local plugin_name = _M.name
--   local plugin = check(plugin_name)
--   if not plugin then return end
--   -- set key
--   setup_keymaps(plugin_name)
--   -- config
--   plugin_setup(plugin, plugin_name)
-- end

-- return _M
