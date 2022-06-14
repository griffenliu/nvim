local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
local api = vim.api
local lsp = vim.lsp

local base = require("core.plugin.base")

local _M = base.new {
  name = "null-ls",
  desc = "[LSP]Server",
  github = "https://github.com/jose-elias-alvarez/null-ls.nvim",
  packer = {
    'jose-elias-alvarez/null-ls.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      require("plugins.configs.lsp.null-ls"):config()
    end
  }
}

local lsp_formatting = function(bufnr)
  lsp.buf.format({
    filter = function(client)
      -- apply whatever logic you want (in this example, we'll only use null-ls)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end
_M.setup = function(self, keymaps)
  local formatting = self.plugin.builtins.formatting
  local diagnostics = self.plugin.builtins.diagnostics
  local code_actions = self.plugin.builtins.code_actions
  local augroup = api.nvim_create_augroup("LspFormatting", {})
  self.plugin.setup {
    sources = {
      formatting.stylua, -- lua
      formatting.rustfmt, -- rust
      formatting.nginx_beautifier, --nginx
    },
    debug = true, -- 开启调试
    -- you can reuse a shared lspconfig on_attach callback here
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            lsp_formatting(bufnr)
          end,
        })
      end
    end,
  }
end

return _M
