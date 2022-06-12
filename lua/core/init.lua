-- 定义全局自定义变量
_G.configs = {
    neorg = {
        workspaces = {
            work = "~/notes/work",
            home = "~/notes/home",
            gtd = "~/notes/gtd"
        }
    }
}

-- 基础配置
require("core.options")
-- 配置插件
require("plugins").setup()
-- 插件管理
require("core.plugins").bootstrap()
-- 按键映射配置
require("core.keymaps").setup()
-- 添加数字选择窗口的功能
require("core.window").setup()
-- 添加自定义帮助
require("core.help").setup()
