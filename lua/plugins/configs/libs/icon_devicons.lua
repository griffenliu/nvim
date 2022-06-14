-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
local base = require("core.plugin.base")

local _M = base.new {
    name = "nvim-web-devicons",
    desc = "图标库",
    packer = {
        'kyazdani42/nvim-web-devicons',
        github = "https://github.com/kyazdani42/nvim-web-devicons",
        config = function()
            require("plugins.configs.libs.icon_devicons"):config()
        end
    }
}

_M.setup = function(self, keymaps)
    self.plugin.setup {}
end

return _M
