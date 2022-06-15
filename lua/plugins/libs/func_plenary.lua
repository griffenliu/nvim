-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
local base = require("core.plugin.base")

local _M = base.new {
    name = "plenary",
    desc = "函数库",
    auto_load = false,
    packer = {
        'nvim-lua/plenary.nvim',
        github = "https://github.com/nvim-lua/plenary.nvim",
        config = function()
            require("plugins.libs.func_plenary"):config()
        end
    }
}

return _M
