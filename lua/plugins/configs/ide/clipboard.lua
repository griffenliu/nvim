-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
local base = require("core.plugin.base")

local _M = base.new {
    name = "neoclip",
    desc = "[IDE]剪贴板",
    github = "https://github.com/AckslD/nvim-neoclip.lua",
    packer = {
        "AckslD/nvim-neoclip.lua",
        requires = {{'nvim-telescope/telescope.nvim'}},
        config = function()
            require("plugins.configs.ide.clipboard"):config()
        end
    }
}

_M.setup = function(self)
    self.plugin.setup()
    require('telescope').load_extension('neoclip')
end

return _M
