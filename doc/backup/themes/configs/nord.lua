local vim = vim
local notify = vim.notify
local cmd = vim.cmd

local base = require("core.plugin.base")

local _M = {
  name = "nord",
  desc = "主题",
  packer = {
    "shaunsingh/nord.nvim",
    config = function()
      require("themes.configs.nord"):config()
    end
  }
}
setmetatable(_M, { __index = base })

return _M
