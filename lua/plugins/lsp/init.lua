local _M = {}

_M.setup = function(after_plugin)
    -- 常用配置
    local lsp_config = require('plugins.lsp.config'):after(after_plugin)
    -- 安装工具
    local lsp_installer = require('plugins.lsp.installer'):after(lsp_config)
    -- UI美化
    local lsp_kind = require('plugins.lsp.lspkind'):after(lsp_installer)
    -- 提供代码诊断，格式化等
    require('plugins.lsp.null-ls'):after(lsp_installer)
    -- 诊断进度等
    require('plugins.lsp.loading'):after(lsp_installer)
    -- Actions
    require('plugins.lsp.lspsaga'):after(lsp_installer)
    -- 虚拟行切换
    require('plugins.lsp.virtual-line'):after(lsp_installer)

    return lsp_kind
end

return _M
