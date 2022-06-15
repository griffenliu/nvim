-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
-- local api = vim.api
local base = require("core.plugin.base")

local _M = base.new {
    name = "cheatsheet",
    desc = "[工具]辅助记忆",
    github = "https://github.com/sudormrfbin/cheatsheet.nvim",

    packer = {
        'sudormrfbin/cheatsheet.nvim',
        requires = {{'nvim-telescope/telescope.nvim'}, {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
        config = function()
            require("plugins.configs.tools.cheatsheet"):config()
        end
    }
}

-- _M.set_keymaps = function(self)
--     local wq = require("which-key")
--     wk.register({
--         ["<leader>t"] = {
--             name = "+工具",
--             n = {"<cmd>Cheatsheet<cr>", "创建文件"},
--             f = {"<cmd>CheatsheetEdit<cr>", "查找文件"}
--         }
--     })
-- end

_M.setup = function(self)
    self.plugin.setup {}
end

return _M
