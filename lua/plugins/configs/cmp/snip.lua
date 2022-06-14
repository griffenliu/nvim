-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
-- local api = vim.api

local base = require("core.plugin.base")

local _M = base.new {
  name = "luasnip",
  desc = "[补全]代码片段引擎",
  github = "https://github.com/L3MON4D3/LuaSnip",
  auto_load = false,
  packer = {
    'L3MON4D3/LuaSnip',
    config = function()
      require("plugins.configs.cmp.snip"):config()
    end
  }
}

return _M
