-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
-- local api = vim.api
local base = require("core.plugin.base")

local _M = base.new {
    name = "luadev",
    group = "TOOL",
    desc = "打印输出日志",
    github = "https://github.com/bfredl/nvim-luadev",
    packer = {
        "bfredl/nvim-luadev",
        config = function()
            require("plugins.libs.log"):config()
        end
    }
}

_M.setup = function(self)
    -- print = self.plugin.print
end

return _M
