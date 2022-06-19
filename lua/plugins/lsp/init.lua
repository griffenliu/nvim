local _M = {}

_M.setup = function(after_plugin)
    local plugins = {
        loading = require('plugins.lsp.loading'), -- 服务索引进度
        lsp_line = require('plugins.lsp.lsp-line'), -- 虚拟行切换
        lsp_kind = require('plugins.lsp.lspkind'), -- UI美化
        lsp_installer = require('plugins.lsp.installer'), -- 安装工具
        lsp_config = require('plugins.lsp.config'), -- 常用配置
        null_ls = require('plugins.lsp.null-ls'), -- 提供代码诊断，格式化等
        lspsaga = require('plugins.lsp.lspsaga'), -- 默认LSP操作美化
        rust_tools = require("plugins.lsp.rust-tools") -- RUST语言增强
    }
    plugins.lsp_kind:after(after_plugin)
    plugins.lsp_line:after(plugins.lsp_kind)
    plugins.loading:after(plugins.lsp_kind)
    -- ====
    plugins.lsp_installer:after(plugins.loading)
    plugins.lsp_config:after(plugins.lsp_installer)
    plugins.rust_tools:after(plugins.lsp_config)
    plugins.lspsaga:after(plugins.lsp_config)
    plugins.null_ls:after(plugins.lsp_config)
    local setup = require('plugins.lsp.setup'):after(plugins.lspsaga, plugins.rust_tools)

    return setup
end

return _M
