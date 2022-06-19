local _M = {}

_M.setup = function(after_plugin)
    -- 定义插件列表
    local plugins = {
        cmp = require('plugins.cmp.cmp'),
        snip = require('plugins.cmp.snip'),
        snip_friends = require('plugins.cmp.snip_friends'),
        source_snip = require('plugins.cmp.sources.snip'),
        source_lsp = require('plugins.cmp.sources.lsp'),
        source_buffer = require('plugins.cmp.sources.buffer'),
        source_path = require('plugins.cmp.sources.path'),
        source_nvim_lua = require('plugins.cmp.sources.nvim-lua')
    }
    -- 代码片段引擎
    plugins.snip:after(after_plugin)
    plugins.snip_friends:after(plugins.snip)
    -- 补全
    plugins.cmp:after(plugins.snip)
    -- 补全源定义
    plugins.source_snip:after(plugins.cmp)
    plugins.source_lsp:after(plugins.cmp)
    plugins.source_buffer:after(plugins.cmp)
    plugins.source_path:after(plugins.cmp)
    plugins.source_nvim_lua:after(plugins.cmp)

    return plugins.snip
end

return _M
