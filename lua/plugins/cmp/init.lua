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
    plugins.cmp:after(after_plugin)
    -- 代码片段引擎
    plugins.snip:after(plugins.cmp)
    plugins.snip_friends:after(plugins.snip)
    -- 补全源定义
    plugins.source_snip:after(plugins.snip)
    plugins.source_lsp:after(plugins.snip)
    plugins.source_buffer:after(plugins.snip)
    plugins.source_path:after(plugins.snip)
    plugins.source_nvim_lua:after(plugins.snip)
    local finish = require('plugins.cmp.finish')
    local afters = {}
    for _, p in pairs(plugins) do
        table.insert(afters, p)
    end
    finish:after(unpack(afters))
    return finish
end

return _M
