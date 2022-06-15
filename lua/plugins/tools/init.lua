local _M = {}

_M.setup = function(after_plugin)
    require('plugins.tools.cheatsheet'):after(after_plugin)
end

return _M
