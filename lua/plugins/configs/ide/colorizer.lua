-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
local base = require("core.plugin.base")

local _M = base.new {
    name = "colorizer",
    desc = "[IDE]色彩高亮",
    github = "https://github.com/norcalli/nvim-colorizer.lua",
    packer = {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require("plugins.configs.ide.colorizer"):config()
        end
    }
}

_M.setup = function(self, keymaps)
    self.plugin.setup {}
end

return _M
