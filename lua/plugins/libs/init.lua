local _M = {}

_M.setup = function()
    -- 图标库
    local lib_icon_devions = require('plugins.libs.icon_devicons')
    -- 常用函数库
    local lib_func_plenary = require('plugins.libs.func_plenary'):after(lib_icon_devions)
    -- 弹窗库(被其他插件依赖)
    local lib_ui_popup = require('plugins.libs.ui_popup'):after(lib_func_plenary)

    return lib_ui_popup
end

return _M
