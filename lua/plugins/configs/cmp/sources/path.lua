-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
-- local api = vim.api

local base = require("core.plugin.base")

local _M = base.new {
  name = "cmp_path",
  desc = "[补全]系统路径",
  github = "https://github.com/hrsh7th/cmp-path",
  auto_load = false,
  packer = {
    'hrsh7th/cmp-path',
    config = function()
      require("plugins.configs.cmp.sources.path"):config()
    end
  }
}

return _M
