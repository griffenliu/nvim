local vim = vim
local notify = vim.notify
local cmd = vim.cmd

local base = require("core.plugin.base")

local _M = base.new {
    name = "nvim-autopairs",
    desc = "[IDE]自动配对",
    github = "https://github.com/windwp/nvim-autopairs",
    packer = {
        'windwp/nvim-autopairs',
        config = function()
            require("plugins.configs.ide.autopairs"):config()
        end
    }
}

_M.setup = function(self, keymaps)
    self.plugin.setup()
end

return _M
