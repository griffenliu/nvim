-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd

local base = require("core.plugin.base")

local _M = base.new {
  name = "lspkind", -- require name
  desc = "[LSP]UI美化",
  github = "https://github.com/onsails/lspkind.nvim",
  packer = {
    "onsails/lspkind-nvim",
    config = function()
      require("plugins.configs.lsp.lspkind"):config()
    end
  },
}

_M.setup = function(self, keymaps)
  -- lspkind: 美化补全提示界面
  self.plugin.init({
    -- default: true
    -- with_text = true,
    -- defines how annotations are shown
    -- default: symbol
    -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
    mode = 'symbol_text',
    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    --
    -- default: 'default'
    preset = 'codicons',
    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
      Text = "",
      Method = "",
      Function = "",
      Constructor = "",
      Field = "ﰠ",
      Variable = "",
      Class = "ﴯ",
      Interface = "",
      Module = "",
      Property = "ﰠ",
      Unit = "塞",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "פּ",
      Event = "",
      Operator = "",
      TypeParameter = ""
    },
  })
end

return _M
