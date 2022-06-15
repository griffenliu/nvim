local _M = {}

_M.setup = function(after_plugin)
    local theme_tokyonight = require('plugins.themes.tokyonight'):after(after_plugin)

    return theme_tokyonight
end

return _M
