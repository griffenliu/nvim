local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
-- local api = vim.api
local base = require("core.plugin.base")
-- local base_lang = require('plugins.lsp.langs.base')
local _M = base.new {
  name = "rust-tools",
  group = "LSP",
  desc = "RUST语言增强工具",
  github = "https://github.com/simrat39/rust-tools.nvim",
  -- auto_config = false,
  packer = {
    'simrat39/rust-tools.nvim',
    -- config = function()
    --   require("plugins.lsp.langs.rust-tools"):config()
    -- end
  }
}

-- _M.setup = function(self, opts)
--   -- rust
--   -- local rust_config = base_lang.merge({
--   --   keymaps = function(opt)
--   --     vim.keymap.set('n', 'gp', require 'rust-tools.parent_module'.parent_module, opt("类型定义"))
--   --   end
--   -- })
--   -- require('plugins.lsp.langs.rust').setup(self.plugin)
--   self.plugin.setup {
--     server = opts,
--   }
--   -- self.plugin.start_standalone_if_required()
-- end

return _M
