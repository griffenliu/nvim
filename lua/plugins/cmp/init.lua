local _M = {}

_M.setup = function(after_plugin)
    local cmp_cmp = require('plugins.cmp.cmp'):after(after_plugin)
    -- 代码片段引擎
    local cmp_snip = require('plugins.cmp.snip'):after(cmp_cmp)
    require('plugins.cmp.snip_friends'):after(cmp_snip)
    -- 补全源定义
    local cmp_source_snip = require('plugins.cmp.sources.snip'):after(cmp_snip)
    local cmp_source_lsp = require('plugins.cmp.sources.lsp'):after(cmp_cmp)
    local cmp_source_buffer = require('plugins.cmp.sources.buffer'):after(cmp_cmp)
    local cmp_source_path = require('plugins.cmp.sources.path'):after(cmp_cmp)
    local cmp_source_nvim_lua = require('plugins.cmp.sources.nvim-lua'):after(cmp_cmp)
    return cmp_cmp
end

return _M
