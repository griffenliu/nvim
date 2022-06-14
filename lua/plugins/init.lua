local _M = {}

_M.setup = function()
    local plugin_loader = require("core.plugins")

    -- libs
    local lib_icon_devions = require("plugins.configs.libs.icon_devicons")
    local lib_func_plenary = require("plugins.configs.libs.func_plenary"):after(lib_icon_devions)
    -- 主题
    local theme_tokyonight = require("plugins.configs.themes.tokyonight"):after(lib_func_plenary)
    -- 编辑器增强
    local ide_notify = require("plugins.configs.ide.notify"):after(theme_tokyonight)
    local ide_which_key = require("plugins.configs.ide.which-key"):after(ide_notify)
    require("plugins.configs.ide.statusline"):after(ide_which_key)
    require("plugins.configs.ide.colorizer"):after(ide_which_key)
    require("plugins.configs.ide.blankline"):after(ide_which_key)
    require("plugins.configs.ide.explorer"):after(ide_which_key)
    local ide_project = require("plugins.configs.ide.project"):after(ide_which_key)
    local ide_treesitter = require("plugins.configs.ide.treesitter"):after(ide_project)
    require("plugins.configs.ide.autopairs"):after(ide_treesitter)
    require("plugins.configs.ide.comment"):after(ide_treesitter)
    local ide_telescope = require("plugins.configs.ide.telescope"):after(ide_treesitter)
    require("plugins.configs.ide.clipboard"):after(ide_telescope)
    local lsp_config = require("plugins.configs.lsp.config"):after(ide_telescope)
    local lsp_installer = require("plugins.configs.lsp.installer"):after(lsp_config)

    -- -- base
    -- plugins.add(require("plugins.configs.ui_notify"))
    -- plugins.add(require("plugins.configs.ui_code_scope"):after({"nvim-notify"}))
    -- plugins.add(require("plugins.configs.ui_autopairs"):after({"nvim-notify"}))
    -- -- 主题插件安装
    -- require("themes").setup()
    -- plugins.add(require("plugins.configs.ide.which-key"):after({"nvim-notify"}))
    -- plugins.add(require("plugins.configs.ui_statusbar"):after({"nvim-notify"}))
    -- plugins.add(require("plugins.configs.code_comment"):after({"nvim-notify"}))
    -- plugins.add(require("plugins.configs.code_highlight"):after({"nvim-notify"}))
    -- plugins.add(require("plugins.configs.code_todo"):after({"nvim-notify"}))
    -- plugins.add(require("plugins.configs.telescope"):after({"nvim-notify", "which-key.nvim"}))
    -- plugins.add(require("plugins.configs.explorer"):after({"nvim-notify"}))
    -- plugins.add(require("plugins.configs.dashboard"):after({"nvim-notify"}))
    -- -- plugins.add(require("plugins.configs.project"))
    -- -- code
    -- require("lsp").setup()
    -- -- tool
    -- -- plugins.add(require("plugins.configs.outline"))
end

return _M
