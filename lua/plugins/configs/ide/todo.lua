local vim = vim
local notify = vim.notify
local cmd = vim.cmd


local base = require("core.plugin.base")

local _M = base.new {
  name = "todo-comments",
  desc = "[IDE]TODO高亮",
  packer = {
    'folke/todo-comments.nvim',
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("plugins.configs.ide.todo"):config()
    end
  }
}

_M.set_keymaps = function(self, keymaps)
  keymaps.set(self.name, "n", "<leader>tt", ":TodoTelescope<cr>", "搜索TODO")
end

_M.setup = function(self, keymaps)
  self.plugin.setup({
    keywords = {
      NOTE = { icon = " ", color = "hint", alt = { "INFO", "FIXME" } },
    }
  })
end

return _M