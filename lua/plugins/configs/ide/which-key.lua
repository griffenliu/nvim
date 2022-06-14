local vim = vim
local notify = vim.notify
local cmd = vim.cmd

local base = require("core.plugin.base")

local _M = base.new({
    name = "which-key",
    desc = "[IDE]按键提示",
    github = "https://github.com/folke/which-key.nvim",
    packer = {
        "folke/which-key.nvim",
        config = function()
            require("plugins.configs.ide.which-key"):config()
        end
    }
})

_M.setup = function(self, keymaps)
    self.plugin.setup {}
end

return _M
