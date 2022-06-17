-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
-- local api = vim.api
-- 辅助工具需要，所以这里加进来
local base = require('core.plugin.base')

local _M = base.new({
    name = 'popup',
    group = 'LIB',
    desc = '弹出窗口',
    github = 'https://github.com/nvim-lua/popup.nvim',
    auto_load = false,
    auto_config = false,
    packer = {
        'nvim-lua/popup.nvim',
        config = function()
            require('plugins.libs.ui_popup'):config()
        end,
    },
})

return _M
