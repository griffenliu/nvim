-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
-- local api = vim.api

local base = require("core.plugin.base")

local _M = base.new {
  name = "cmp_buffer",
  desc = "[补全]缓冲区",
  github = "https://github.com/hrsh7th/cmp-buffer",
  auto_load = false,
  packer = {
    'hrsh7th/cmp-buffer',
    config = function()
      require("plugins.configs.cmp.sources.buffer"):config()
    end
  },
}

return _M
