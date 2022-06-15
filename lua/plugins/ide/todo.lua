local vim = vim
local notify = vim.notify
local cmd = vim.cmd

local base = require("core.plugin.base")

local _M = base.new {
    name = "todo-comments",
    group = "IDE",
    desc = "TODO高亮",
    packer = {
        'folke/todo-comments.nvim',
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("plugins.ide.todo"):config()
        end
    }
}

-- _M.set_keymaps = function(self, keymaps)
--   keymaps.set(self.name, "n", "<leader>tt", ":TodoTelescope<cr>", "搜索TODO")
-- end

_M.setup = function(self)
    self.plugin.setup({
        keywords = {
            NOTE = {
                icon = " ",
                color = "hint",
                alt = {"INFO", "FIXME"}
            }
        }
    })
end

return _M
