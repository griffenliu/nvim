local base = require('core.plugin.base')

local _M = base.new({
    name = 'cmp_finish',
    group = 'CMP',
    desc = '补全模块加载完成',
    auto_config = false,
    packer = {
        vim.g.options.config_path .. '/lua/plugins/cmp/cmp_finish',
        -- config = function()
        --     require('plugins.lsp.virtual-line'):config()
        -- end,
    },
})

return _M
