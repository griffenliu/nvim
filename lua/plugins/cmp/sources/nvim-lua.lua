-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
-- local api = vim.api
local base = require('core.plugin.base')

local _M = base.new({
    name = 'cmp_nvim_lua',
    group = 'CMP',
    desc = 'NeoVim-LuaApi',
    github = 'https://github.com/hrsh7th/cmp-nvim-lua',
    auto_load = false,
    auto_config = false,
    packer = {
        'hrsh7th/cmp-nvim-lua',
        config = function()
            require('plugins.cmp.sources.nvim-lua'):config()
        end,
    },
})

return _M
