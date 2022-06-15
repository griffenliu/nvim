local vim = vim
local notify = vim.notify
local cmd = vim.cmd

local base = require("core.plugin.base")

local _M = base.new({
    name = "notify",
    group = "IDE",
    desc = "通知",
    github = "https://github.com/rcarriga/nvim-notify",
    packer = {
        'rcarriga/nvim-notify',
        config = function()
            require("plugins.ide.notify"):config()
        end
    }
})

_M.setup = function(self)
    -- 替换默认的通知，因为这个，所以这个插件要非常靠前，这里将其排序定义为1
    self.plugin.setup({
        background_colour = "#000000"
    })
    vim.notify = self.plugin
end

return _M
