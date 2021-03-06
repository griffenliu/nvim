-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
local base = require("core.plugin.base")

local _M = base.new {
    name = "project_nvim",
    group = "IDE",
    desc = "项目管理",
    github = "https://github.com/ahmedkhalf/project.nvim",
    packer = {
        "ahmedkhalf/project.nvim",
        config = function()
            require("plugins.ide.project"):config()
        end
    }
}

-- TODO: 添加快捷键
-- _M.set_keymaps = function(self, keymaps)
--     keymaps.set(self.name, "n", "<leader>dd", ":Alpha<cr>", "[Dashboard] 显示Dashboard")
-- end

_M.setup = function(self)
    self.plugin.setup {}
end

return _M
