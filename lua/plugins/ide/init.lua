local _M = {}

_M.setup = function(after_plugin)
    local plugins = {
        notify = require('plugins.ide.notify'), -- 弹出信息窗口
        which_key = require('plugins.ide.which-key'), -- 快捷键预览
        statuline = require('plugins.ide.statusline'), -- 状态行
        colorizer = require('plugins.ide.colorizer'), -- 色彩高亮显示
        blankline = require('plugins.ide.blankline'), -- 空白线
        explorer = require('plugins.ide.explorer'), -- 资源管理器
        project = require('plugins.ide.project'), -- 项目管理
        treesitter = require('plugins.ide.treesitter'), -- 语法分析器
        autopairs = require('plugins.ide.autopairs'), -- 自动配对括号
        comment = require('plugins.ide.comment'), -- 注释
        telescope = require('plugins.ide.telescope'), -- 搜索
        todo = require('plugins.ide.todo'), -- TOD0 高亮
        clipboard = require('plugins.ide.clipboard') -- 剪贴板
    }

    plugins.notify:after(after_plugin)
    plugins.which_key:after(plugins.notify)
    plugins.statuline:after(plugins.which_key)
    plugins.colorizer:after(plugins.which_key)
    plugins.blankline:after(plugins.which_key)
    plugins.explorer:after(plugins.which_key)
    plugins.project:after(plugins.which_key)
    plugins.treesitter:after(plugins.project)
    plugins.autopairs:after(plugins.treesitter)
    plugins.comment:after(plugins.treesitter)
    plugins.telescope:after(plugins.treesitter)
    plugins.todo:after(plugins.telescope)
    plugins.clipboard:after(plugins.telescope)

    local finish = require("plugins.ide.finish")
    local afters = {}
    for _, p in pairs(plugins) do
        table.insert(afters, p)
    end
    finish:after(unpack(afters))
    return finish
end

return _M
