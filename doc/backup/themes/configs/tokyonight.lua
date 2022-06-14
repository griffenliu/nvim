local vim = vim
local notify = vim.notify
local cmd = vim.cmd

local base = require("core.plugin.base")

local _M = {
  name = "tokyonight",
  desc = "主题",
  github = " https://github.com/folke/tokyonight.nvim",
  packer = {
    'folke/tokyonight.nvim',
    config = function()
      require("themes.configs.tokyonight"):config()
    end
  }
}
setmetatable(_M, { __index = base })

return _M
