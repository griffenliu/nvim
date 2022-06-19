-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
-- local api = vim.api
local base = require('core.plugin.base')

local _M = base.new({
    name = 'cmp_luasnip',
    group = 'CMP',
    desc = '代码片段',
    github = 'https://github.com/saadparwaiz1/cmp_luasnip',
    auto_config = false,
    packer = {
        'saadparwaiz1/cmp_luasnip',
        config = function()
            require('plugins.cmp.sources.snip'):config()
        end,
    },
})

return _M
