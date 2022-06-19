local _M = {}

_M.setup = function()
    vim.lsp.set_log_level('debug')
    -- local fn = vim.fn
    -- local plugin_config_path = fn.stdpath('config') .. '/lua/plugins'

    -- ### Libs
    local libs = require('plugins.libs').setup()

    -- ### 主题
    local theme = require('plugins.themes').setup(libs)

    -- ### 编辑器增强
    local ide = require('plugins.ide').setup(theme)

    -- ### LSP
    local lsp = require('plugins.lsp').setup(ide)

    -- ### 补全
    require('plugins.cmp').setup(lsp)

    -- ### 其他辅助和工具类
    require('plugins.tools').setup(ide)
end

return _M
