-- 插件列表
local _M = {
    plugins = {}
}

_M.insert = function(plugin)
    if not plugin.config then
        plugin.config = function()
            plugin.loaded = true
        end
    else
        if type(plugin.config) == "function" then
            plugin.config = function()
                plugin.loaded = true
                plugin.config()
            end
        else
            plugin.config = function()
                plugin.loaded = true
                return plugin.config
            end
        end
    end
    table.insert(_M.plugins, plugin)
end
_M.is_loaded = function()
    local _finished = true
    for _, p in ipairs(_M.plugins) do
        if not p.loaded then
            _finished = false
            break
        end
    end
    return _finished
end

_M.get = function()
    return _M.plugins
end

return _M
