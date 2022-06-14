-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
-- local api = vim.api

local base = require("core.plugin.base")

local _M = base.new {
    name = "alpha",
    desc = "仪表盘",
    github = "",
    packer = {
        'goolord/alpha-nvim',
        config = function()
            require("plugins.configs.dashboard"):config()
        end
    }
}

_M.set_keymaps = function(self, keymaps)
    keymaps.set(self.name, "n", "<leader>dd", ":Alpha<cr>", "[Dashboard] 显示Dashboard")
end

_M.setup = function(self, keymaps)
    self.plugin.setup {}
end

return _M
