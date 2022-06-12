local _M = {}

-- 注意，这个会按照顺序自动进行排序，因此需要注意设置正确的排序路径
_M.setup = function()
  local plugins = require("core.plugins")
  -- base
  plugins.add(require("plugins.configs.ui_notify"))
  plugins.add(require("plugins.configs.ui_code_scope"):after({ "nvim-notify" }))
  plugins.add(require("plugins.configs.ui_autopairs"):after({ "nvim-notify" }))
  -- 主题插件安装
  require("themes").setup()
  plugins.add(require("plugins.configs.ui_statusbar"):after({ "nvim-notify" }))
  plugins.add(require("plugins.configs.ui_comment"):after({ "nvim-notify" }))
  plugins.add(require("plugins.configs.code_highlight"):after({ "nvim-notify" }))
  plugins.add(require("plugins.configs.finder"):after({ "nvim-notify" }))
  plugins.add(require("plugins.configs.explorer"):after({ "nvim-notify" }))
  plugins.add(require("plugins.configs.dashboard"):after({ "nvim-notify" }))

  -- plugins.add(require("plugins.configs.project"))
  -- code
  require("lsp").setup()
  -- plugins.add(require("lsp"))
  -- plugins.add(require("lsp.ui"))
  -- plugins.add(require("lsp.cmp"))
  -- plugins.add(require("lsp.formatter"))
  -- tool
  -- plugins.add(require("plugins.configs.outline"))
end

return _M
