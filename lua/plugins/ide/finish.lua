local base = require('core.plugin.base')

local _M = base.new({
    name = 'ide_finish',
    group = 'IDE',
    desc = 'IDE模块加载完成',
    auto_config = false,
    packer = {vim.g.options.config_path .. '/lua/plugins/ide/ide_finish'}
})

return _M
