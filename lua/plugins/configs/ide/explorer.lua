-- 资源管理器
local vim = vim
local notify = vim.notify
local cmd = vim.cmd

local base = require("core.plugin.base")

local _M = base.new {
    name = "nvim-tree",
    desc = "[IDE]导航树", -- 资源管理器
    github = "https://github.com/kyazdani42/nvim-tree.lua",
    packer = {
        "kyazdani42/nvim-tree.lua",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("plugins.configs.ide.explorer"):config()
        end
    }
}

_M.set_keymaps = function(self, keymaps)
    keymaps.set(self.name, "n", "<leader>`", "<cmd> NvimTreeToggle <CR>", "[文件树] 打开或关闭文件树")
    keymaps.set(self.name, "n", "<A-`>", "<cmd> NvimTreeFocus <CR>", "[文件树] 聚焦文件树")
end

_M.setup = function(self, keymaps)
    -- local local_mappings = keymaps.get_local_keys(self.name)
    -- TODO: 这里要判断一下，如果已经安装过了，则不要再次安装，否则会报警告信息
    self.plugin.setup({
        -- 不显示 git 状态图标
        git = {
            enable = false
        },
        -- project plugin 需要这样设置
        update_cwd = true,
        update_focused_file = {
            enable = true,
            update_cwd = true
        },
        -- 隐藏 .文件 和 node_modules 文件夹
        filters = {
            dotfiles = true,
            custom = { 'node_modules' }
        }
    })
end

return _M
