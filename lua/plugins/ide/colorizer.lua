-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
local base = require("core.plugin.base")

local _M = base.new {
    name = "colorizer",
    group = "IDE",
    desc = "色彩高亮",
    github = "https://github.com/norcalli/nvim-colorizer.lua",
    packer = {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require("plugins.ide.colorizer"):config()
        end
    }
}

_M.setup = function(self)
    self.plugin.setup {}
end

return _M
