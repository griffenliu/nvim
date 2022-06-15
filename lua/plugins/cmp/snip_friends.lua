-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
-- local api = vim.api
local base = require("core.plugin.base")

local _M = base.new {
    name = "friendly-snippets",
    group = "CMP",
    desc = "默认代码片段",
    github = "https://github.com/rafamadriz/friendly-snippets",
    auto_load = false,
    packer = {
        "rafamadriz/friendly-snippets",
        config = function()
            require("plugins.cmp.snip_friends"):config()
        end
    }
}

return _M
