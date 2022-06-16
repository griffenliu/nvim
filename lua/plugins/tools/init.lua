local _M = {}

_M.setup = function(after_plugin)
    require('plugins.tools.cheatsheet'):after(after_plugin)
    require("plugins.tools.dashboard"):after(after_plugin)
    require("plugins.tools.norg"):after(after_plugin)
    -- require("plugins.tools.help"):after(after_plugin)
end

return _M
