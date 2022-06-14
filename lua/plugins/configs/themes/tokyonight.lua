local vim = vim
local notify = vim.notify
local cmd = vim.cmd

local base = require("core.plugin.base")

local _M = base.new {
    name = "tokyonight",
    desc = "主题",
    github = " https://github.com/folke/tokyonight.nvim",
    packer = {
        'folke/tokyonight.nvim',
        config = function()
            require("plugins.configs.themes.tokyonight"):config()
        end
    }
}

-- TODO: 使用事件来通知设置
_M.setup = function(self, keymaps)
    cmd("colorscheme " .. vim.g.options.theme)
end

return _M
