-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
local base = require('core.plugin.base')

local _M = base.new({
    name = 'plenary.log',
    group = 'LIB',
    desc = '函数库',
    github = 'https://github.com/nvim-lua/plenary.nvim',
    packer = {
        'nvim-lua/plenary.nvim',
        config = function()
            require('plugins.libs.func_plenary'):config()
        end,
    },
})

_M.setup = function(self)
    local default_opts = {
        plugin = "mylog",
        use_console = 'async', -- values: 'sync','async',false
    }
    _G.log = self.plugin.new(default_opts)
end

return _M
