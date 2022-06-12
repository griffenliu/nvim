local vim = vim
local notify = vim.notify
local cmd = vim.cmd

local base = require("core.plugin.base")

local _M = {
  name = "onedark",
  desc = "主题",
  packer = {
    "ful1e5/onedark.nvim",
    config = function()
      require("themes.configs.onedark"):config()
    end
  }
}
setmetatable(_M, { __index = base })

return _M
