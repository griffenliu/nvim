local plugin_name = "nvim-lsp-installer"
local status, lsp_installer = pcall(require, plugin_name)
if not status then
  vim.notify(plugin_name .. " not found!")
  return
end
-- 安装列表
-- { key: 语言 value: 配置文件 }
-- key 必须为下列网址列出的名称
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
  -- lua
  sumneko_lua = require("lsp.configs.lua"), -- lua/lsp/configs/lua.lua
  -- rust
  rust_analyzer = require("lsp.configs.rust"),
}
-- 自动安装 Language Servers
for name, _ in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      print("Installing " .. name)
      server:install()
    end
  end
end

lsp_installer.on_server_ready(function(server)
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

local keymaps = require("core.keymaps")
-- 默认通用缓冲区按键设置（这个需要在各个实际的配置中定义绑定）
-- rename
keymaps.set_buffer(plugin_name, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", "重命名变量")
-- code action
keymaps.set_buffer("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", "代码Action?")
-- go xx
keymaps.set_buffer(plugin_name, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "跳转到定义")
keymaps.set_buffer(plugin_name, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", "显示定义")
keymaps.set_buffer(plugin_name, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "跳转到声明")
keymaps.set_buffer(plugin_name, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", "跳转到实现")
keymaps.set_buffer(plugin_name, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", "跳转到引用")
-- diagnostic
keymaps.set_buffer(plugin_name, "n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", "打开错误信息")
keymaps.set_buffer(plugin_name, "n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "上一个错误")
keymaps.set_buffer(plugin_name, "n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", "下一个错误")
keymaps.set_buffer(plugin_name, "n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", "格式化")
-- 没用到
-- keymaps.set_buffer(plugin_name, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
-- keymaps.set_buffer(plugin_name, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
-- keymaps.set_buffer(plugin_name, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
-- keymaps.set_buffer(plugin_name, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
-- keymaps.set_buffer(plugin_name, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
-- keymaps.set_buffer(plugin_name, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)

require("lsp.cmp")
require("lsp.ui")
-- require("lsp.formatter")
require("lsp.null-ls")
