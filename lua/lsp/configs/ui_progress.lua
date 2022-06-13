local vim = vim
local notify = vim.notify
local cmd = vim.cmd


local base = require("core.plugin.base")

local _M = {
  name = "fidget",
  desc = "LSP 加载进度",
  packer = {
    'j-hui/fidget.nvim',
    config = function()
      require("lsp.configs.ui_progress"):config()
    end
  }
}
setmetatable(_M, { __index = base })

_M.plugin_setup = function(self, keymaps)
  self.plugin.setup {}
end

return _M
