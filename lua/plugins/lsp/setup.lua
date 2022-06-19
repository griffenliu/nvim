local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
-- local api = vim.api
-- local diagnostic = vim.diagnostic

local base = require('core.plugin.base')

local config_path = vim.g.options.config_path

local _M = base.new({
  name = 'lsp_finish_setup',
  group = "LSP",
  desc = '完成安装',
  packer = {
    config_path .. '/lua/plugins/lsp/finish_setup',
    as = "lsp_finish_setup",
    config = function()
      require('plugins.lsp.setup'):config()
    end
  }
})

_M.setup = function(self)
  self.plugin.enable_lspsaga = true
  local lspconfig = require("lspconfig")
  -- lua
  require('plugins.lsp.langs.lua').setup(lspconfig, self.plugin.merge({}))
  -- rust
  require("plugins.lsp.langs.rust").setup(lspconfig, self.plugin.merge({}))
end

return _M
