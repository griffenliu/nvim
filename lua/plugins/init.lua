local _M = {}

_M.setup = function()
  local plugins = require("core.plugins")
  -- base
  plugins.add(require("plugins.configs.ui_notify"))
  plugins.add(require("plugins.configs.ui_code_scope"):after({ "nvim-notify" }))
  plugins.add(require("plugins.configs.ui_autopairs"):after({ "nvim-notify" }))
  -- 主题插件安装
  require("themes").setup()
  plugins.add(require("plugins.configs.ui_statusbar"):after({ "nvim-notify" }))
  plugins.add(require("plugins.configs.code_comment"):after({ "nvim-notify" }))
  plugins.add(require("plugins.configs.code_highlight"):after({ "nvim-notify" }))
  plugins.add(require("plugins.configs.code_todo"):after({ "nvim-notify" }))
  plugins.add(require("plugins.configs.telescope"):after({ "nvim-notify" }))
  plugins.add(require("plugins.configs.explorer"):after({ "nvim-notify" }))
  plugins.add(require("plugins.configs.dashboard"):after({ "nvim-notify" }))
  -- plugins.add(require("plugins.configs.project"))
  -- code
  require("lsp").setup()
  -- tool
  -- plugins.add(require("plugins.configs.outline"))
end

return _M
