local vim = vim
local notify = vim.notify
local cmd = vim.cmd


local base = require("core.plugin.base")

local _M = base.new {
  name = "fidget",
  desc = "[LSP]加载进度",
  github = "https://github.com/j-hui/fidget.nvim",
  packer = {
    'j-hui/fidget.nvim',
    config = function()
      require("plugins.configs.lsp.loading"):config()
    end
  }
}

_M.setup = function(self, keymaps)
  self.plugin.setup {}
end

return _M
