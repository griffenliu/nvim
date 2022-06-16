-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
-- local api = vim.api
local base = require("core.plugin.base")
local config_path = vim.fn.stdpath "config"

local _M = base.new({
    name = 'help',
    group = "TOOL",
    desc = '帮助',
    github = '',
    packer = {
        config_path .. '/lua/core/plugin',
        config = function()
            require('plugins.tool.help'):config()
        end
    }
})

_M.setup = function(self)
    vim.notify("加载帮助模块...")
end

return _M
