local _M = {}

_M.setup = function()
    local fn = vim.fn
    local plugin_config_path = fn.stdpath('config') .. '/lua/plugins'

    -- ### Libs
    local libs = require('plugins.libs').setup()

    -- ### 主题
    local theme = require('plugins.themes').setup(libs)

    -- ### 编辑器增强
    local ide = require('plugins.ide').setup(theme)

    -- ### LSP
    local lsp = require('plugins.lsp').setup(ide)

    -- ### 补全
    local cmp = require('plugins.cmp').setup(lsp)

    -- ### 其他辅助和工具类
    require('plugins.tools').setup(cmp)
end

return _M
