local _M = {}

_M.setup = function(after_plugin)
    -- 进度等
    require('plugins.lsp.loading'):after(after_plugin)
    -- 安装工具
    local lsp_installer = require('plugins.lsp.installer'):after(after_plugin)
    -- 常用配置
    local lsp_config = require('plugins.lsp.config'):after(lsp_installer)
    -- UI美化
    local lsp_kind = require('plugins.lsp.lspkind'):after(lsp_config)
    -- 提供代码诊断，格式化等
    require('plugins.lsp.null-ls'):after(lsp_config)

    -- Actions
    require('plugins.lsp.lspsaga'):after(lsp_config)
    -- 虚拟行切换
    require('plugins.lsp.virtual-line'):after(lsp_config)

    return lsp_kind
end

return _M
