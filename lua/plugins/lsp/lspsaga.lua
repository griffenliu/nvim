-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
-- local api = vim.api
local base = require("core.plugin.base")

local _M = base.new {
    name = "lspsaga",
    group = "LSP",
    desc = "默认替换",
    github = "https://github.com/glepnir/lspsaga.nvim",
    packer = {
        'glepnir/lspsaga.nvim',
        config = function()
            require("plugins.lsp.lspsaga"):config()
        end
    }
}

-- _M.set_keymaps = function(self, keymaps)
--   keymaps.set(self.name, "n", "<leader>dd", ":Alpha<cr>", "[Dashboard] 显示Dashboard")
-- end

_M.setup = function(self)
    self.plugin.init_lsp_saga {}
end

return _M
