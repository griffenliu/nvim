-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
-- local api = vim.api
local base = require("core.plugin.base")

local _M = base.new {
    name = "alpha",
    desc = "仪表盘",
    github = "",
    packer = {
        'goolord/alpha-nvim',
        config = function()
            require("plugins.configs.dashboard"):config()
        end
    }
}

_M.setup = function(self)
    self.plugin.setup {}
end

return _M
