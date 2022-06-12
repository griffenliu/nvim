local vim = vim
local notify = vim.notify
local cmd = vim.cmd


local base = require("core.plugin.base")

local _M = {
  name = "nvim-autopairs",
  desc = "UI 自动配对",
  packer = {
    'windwp/nvim-autopairs',
    config = function()
      require("plugins.configs.ui_autopairs"):config()
    end
  }
}
setmetatable(_M, { __index = base })


_M.set_keymaps = function(self, keymaps)
  keymaps.set(self.name, "n", "<leader>dd", ":Alpha<cr>", "[Dashboard] 显示Dashboard")
end

_M.plugin_setup = function(self, keymaps)
  self.plugin.setup()
end

return _M
