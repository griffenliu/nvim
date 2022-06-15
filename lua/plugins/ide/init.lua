local _M = {}

_M.setup = function(after_plugin)
    -- 弹出信息窗口
    local ide_notify = require('plugins.ide.notify'):after(after_plugin)
    -- 快捷键预览
    local ide_which_key = require('plugins.ide.which-key'):after(ide_notify)
    -- 状态行
    require('plugins.ide.statusline'):after(ide_which_key)
    -- 色彩高亮显示
    require('plugins.ide.colorizer'):after(ide_which_key)
    -- 空白线
    require('plugins.ide.blankline'):after(ide_which_key)
    -- 资源管理器
    require('plugins.ide.explorer'):after(ide_which_key)
    -- 项目管理
    local ide_project = require('plugins.ide.project'):after(ide_which_key)
    -- 语法分析器
    local ide_treesitter = require('plugins.ide.treesitter'):after(ide_project)
    -- 自动配对括号
    require('plugins.ide.autopairs'):after(ide_treesitter)
    -- 注释
    require('plugins.ide.comment'):after(ide_treesitter)
    -- 搜索
    local ide_telescope = require('plugins.ide.telescope'):after(ide_treesitter)
    -- TOD O 高亮
    require('plugins.ide.todo'):after(ide_telescope)
    -- 剪贴板
    require('plugins.ide.clipboard'):after(ide_telescope)
    return ide_telescope
end

return _M
