local vim = vim
local notify = vim.notify
local cmd = vim.cmd


local base = require("core.plugin.base")

local _M = base.new({
    name = "which-key",
    group = "IDE",
    desc = "按键提示",
    github = "https://github.com/folke/which-key.nvim",
    packer = {
        "folke/which-key.nvim",
        config = function()
            require("plugins.ide.which-key"):config()
        end
    }
})

_M.setup = function(self)
    self.plugin.setup {
        -- presets = {
        --     operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
        --     motions = false, -- adds help for motions
        --     text_objects = false, -- help for text objects triggered after entering an operator
        --     windows = false, -- default bindings on <c-w>
        --     nav = false, -- misc bindings to work with windows
        --     z = false, -- bindings for folds, spelling and others prefixed with z
        --     g = false, -- bindings for prefixed with g
        -- },
    }

    -- require("plugins.ide.which-key-presets").setup(self.plugin, require("which-key.config"))
    require("core.keys").bind(self.plugin)
    self.plugin.register({
        ["g%"] = "向后循环",
        ["gb"] = "块注释",
        ["gc"] = "行注释",
        ["ge"] = "光标向前一个单词",
        ["gf"] = "跳转到光标位置的文件",
        ["gg"] = "跳转到第一行",
        ["gi"] = "跳转到上一个插入位置并插入",
        ["gn"] = "向前搜索并选择",
        ["gN"] = "向后搜索并选择",
        ["gv"] = "跳转到上一次选择并切换到V模式",
        ["gx"] = "使用系统应用打开光标位置文件",
        ["g'"] = "全局标记",
        ["g`"] = "本地标记",
        ["g~"] = "大小写转换",
        ["gU"] = "大写转换",
        ["gu"] = "小写转换"
    }, { mode = "n", prefix = "", preset = true })
end

return _M
