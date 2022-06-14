-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
-- local api = vim.api

local base = require("core.plugin.base")

local _M = base.new {
    name = "cmp_luasnip",
    desc = "[补全]代码片段",
    github = "https://github.com/saadparwaiz1/cmp_luasnip",
    auto_load = false,
    packer = {
        'saadparwaiz1/cmp_luasnip',
        config = function()
            require("plugins.configs.cmp.sources.snip"):config()
        end
    }
}

return _M
