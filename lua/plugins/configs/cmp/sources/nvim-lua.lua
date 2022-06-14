-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
-- local api = vim.api

local base = require("core.plugin.base")

local _M = base.new {
  name = "cmp_nvim_lua",
  desc = "[补全]NvimLuaApi",
  github = "https://github.com/hrsh7th/cmp-nvim-lua",
  auto_load = false,
  packer = {
    'hrsh7th/cmp-nvim-lua',
    config = function()
      require("plugins.configs.cmp.sources.nvim-lua"):config()
    end
  }
}

return _M
