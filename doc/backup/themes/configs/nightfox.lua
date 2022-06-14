local vim = vim
local notify = vim.notify
local cmd = vim.cmd

local base = require("core.plugin.base")

local _M = {
  name = "nightfox",
  desc = "主题",
  packer = {
    "EdenEast/nightfox.nvim",
    config = function()
      require("themes.configs.nightfox"):config()
    end
  }
}
setmetatable(_M, { __index = base })

return _M
