-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
local base = require("core.plugin.base")

local _M = base.new {
    name = "neoclip",
    desc = "[IDE]剪贴板",
    github = "https://github.com/AckslD/nvim-neoclip.lua",
    packer = {
        "AckslD/nvim-neoclip.lua",
        requires = { { 'nvim-telescope/telescope.nvim' } },
        config = function()
            require("plugins.configs.ide.clipboard"):config()
        end
    }
}

_M.set_keymaps = function(self, keymaps)
    local wk = require("which-key")
    wk.register({
        ["<leader>b"] = {
            c = { "<cmd>Telescope neoclip<cr>", "剪贴板" }
        }
    })
end

-- TODO: 未安装成功，回去再研究
_M.setup = function(self, keymaps)
    self.plugin.setup {}
end

return _M
