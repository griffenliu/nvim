local vim = vim
local notify = vim.notify
local cmd = vim.cmd

local base = require("core.plugin.base")

local _M = {
  name = "gruvbox",
  desc = "主题",
  packer = {
    "ellisonleao/gruvbox.nvim",
    requires = { "rktjmp/lush.nvim" },
    config = function()
      require("themes.configs.gruvbox"):config()
    end
  }
}
setmetatable(_M, { __index = base })

return _M
