local _M = {}

_M.setup = function()
    -- ### Libs
    -- 图标库
    local lib_icon_devions = require("plugins.configs.libs.icon_devicons")
    -- 常用函数库
    local lib_func_plenary = require("plugins.configs.libs.func_plenary"):after(lib_icon_devions)
    -- 弹窗库(被其他插件依赖)
    local lib_ui_popup = require("plugins.configs.libs.ui_popup"):after(lib_func_plenary)
    -- FIXME: 最好可以在这里有一个阻挡，当基础库加载完毕再开始其他插件加载，虽然时间可能会慢一些
    -- ### 主题
    local theme_tokyonight = require("plugins.configs.themes.tokyonight"):after(lib_func_plenary)

    -- ### 编辑器增强
    -- 弹出信息窗口
    local ide_notify = require("plugins.configs.ide.notify"):after(theme_tokyonight)
    -- 快捷键预览
    local ide_which_key = require("plugins.configs.ide.which-key"):after(ide_notify)
    -- 状态行
    require("plugins.configs.ide.statusline"):after(ide_which_key)
    -- 色彩高亮显示
    require("plugins.configs.ide.colorizer"):after(ide_which_key)
    -- 空白线
    require("plugins.configs.ide.blankline"):after(ide_which_key)
    -- 资源管理器
    require("plugins.configs.ide.explorer"):after(ide_which_key)
    -- 项目管理
    local ide_project = require("plugins.configs.ide.project"):after(ide_which_key)
    -- 语法分析器
    local ide_treesitter = require("plugins.configs.ide.treesitter"):after(ide_project)
    -- 自动配对括号
    require("plugins.configs.ide.autopairs"):after(ide_treesitter)
    -- 注释
    require("plugins.configs.ide.comment"):after(ide_treesitter)
    -- 搜索
    local ide_telescope = require("plugins.configs.ide.telescope"):after(ide_treesitter)
    -- TOD O 高亮
    require("plugins.configs.ide.todo"):after(ide_telescope)
    -- 剪贴板
    require("plugins.configs.ide.clipboard"):after(ide_telescope)

    -- ### LSP
    -- 常用配置
    local lsp_config = require("plugins.configs.lsp.config"):after(ide_telescope)
    -- 安装工具
    local lsp_installer = require("plugins.configs.lsp.installer"):after(lsp_config)
    -- 提供代码诊断，格式化等
    require("plugins.configs.lsp.null-ls"):after(lsp_installer)
    -- UI美化
    local lsp_kind = require("plugins.configs.lsp.lspkind"):after(lsp_installer)
    -- 诊断进度等
    require("plugins.configs.lsp.loading"):after(lsp_installer)
    -- Actions
    require("plugins.configs.lsp.lspsaga"):after(lsp_installer)
    -- 虚拟行切换
    require("plugins.configs.lsp.virtual-line"):after(lsp_installer)

    -- ### 补全
    -- 代码片段引擎
    local cmp_snip = require("plugins.configs.cmp.snip"):after(lsp_installer)
    -- 默认代码片段
    require("plugins.configs.cmp.snip_friends"):after(cmp_snip)
    -- 补全源定义
    local cmp_source_snip = require("plugins.configs.cmp.sources.snip"):after(cmp_snip)
    local cmp_source_lsp = require("plugins.configs.cmp.sources.lsp"):after(cmp_snip)
    local cmp_source_buffer = require("plugins.configs.cmp.sources.buffer"):after(cmp_snip)
    local cmp_source_path = require("plugins.configs.cmp.sources.path"):after(cmp_snip)
    local cmp_source_nvim_lua = require("plugins.configs.cmp.sources.nvim-lua"):after(cmp_snip)
    require("plugins.configs.cmp.cmp"):after(lsp_kind, cmp_source_snip, cmp_source_lsp, cmp_source_buffer,
        cmp_source_path, cmp_source_nvim_lua)

    -- ### 其他辅助和工具类
    require("plugins.configs.tools.cheatsheet"):after(lib_ui_popup, ide_telescope)
end

return _M
