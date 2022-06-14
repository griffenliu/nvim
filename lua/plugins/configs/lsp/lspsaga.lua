-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
-- local api = vim.api

local base = require("core.plugin.base")

local _M = base.new {
  name = "lspsaga",
  desc = "[LSP]Actions",
  github = "https://github.com/glepnir/lspsaga.nvim",
  packer = {
    'glepnir/lspsaga.nvim',
    config = function()
      require("plugins.configs.lsp.lspsaga"):config()
    end
  }
}

-- _M.set_keymaps = function(self, keymaps)
--   keymaps.set(self.name, "n", "<leader>dd", ":Alpha<cr>", "[Dashboard] 显示Dashboard")
-- end

_M.setup = function(self, keymaps)
  self.plugin.init_lsp_saga {}
end

return _M
