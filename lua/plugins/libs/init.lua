local _M = {}

_M.setup = function()
    -- 打印输出
    local lib_log = require("plugins.libs.log")
    -- 图标库
    local lib_icon_devions = require('plugins.libs.icon_devicons'):after(lib_log)
    -- 常用函数库
    local lib_func_plenary = require('plugins.libs.func_plenary'):after(lib_icon_devions)
    -- 弹窗库(被其他插件依赖)
    local lib_ui_popup = require('plugins.libs.ui_popup'):after(lib_func_plenary)

    return lib_ui_popup
end

return _M
