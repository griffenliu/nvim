-- 资源管理器
local vim = vim
local notify = vim.notify
local cmd = vim.cmd

local function check(plugin_name)
  local status, plugin = pcall(require, plugin_name)
  if not status then
    notify(plugin_name .. " not found!")
    return false
  end
  return plugin
end

local set_keymaps
local function setup_keymaps(plugin_name)
  if set_keymaps and type(set_keymaps) == "function" then
    local keymaps = require("core.keymaps")
    set_keymaps(plugin_name, keymaps)
    keymaps.bind(plugin_name)
  end
end

-- ============================================================================


local _M = {
  name = "null-ls", -- require name
  desc = "格式化",
  packer = {
    "jose-elias-alvarez/null-ls.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("lsp.formatter").config()
    end
  },
}

local function plugin_setup(plugin, plugin_name)
  local formatting = plugin.builtins.formatting
  local diagnostics = plugin.builtins.diagnostics
  local code_actions = plugin.builtins.code_actions

  plugin.setup({
    debug = false,
    sources = {
      -- Formatting ---------------------
      --  brew install shfmt
      formatting.shfmt,
      -- StyLua
      formatting.stylua,
      -- frontend
      formatting.prettier.with({ -- 比默认少了 markdown
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "css",
          "scss",
          "less",
          "html",
          "json",
          "yaml",
          "graphql",
        },
        prefer_local = "node_modules/.bin",
      }),
      -- rustfmt
      formatting.rustfmt,
      -- Python
      -- pip install black
      -- asdf reshim python
      formatting.black.with({ extra_args = { "--fast" } }),
      -----------------------------------------------------
      -- Diagnostics  ---------------------
      diagnostics.eslint.with({
        prefer_local = "node_modules/.bin",
      }),
      -- code actions ---------------------
      code_actions.gitsigns,
      code_actions.eslint.with({
        prefer_local = "node_modules/.bin",
      }),
    },
    -- #{m}: message
    -- #{s}: source name (defaults to null-ls if not specified)
    -- #{c}: code (if available)
    diagnostics_format = "[#{s}] #{m}",
    -- 保存自动格式化
    on_attach = function(client)
      vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()']])
    end,
  })
end

-- ============================================================================
_M.config = function()
  local plugin_name = _M.name
  local plugin = check(plugin_name)
  if not plugin then return end
  -- set key
  setup_keymaps(plugin_name)
  -- config
  plugin_setup(plugin, plugin_name)
end

return _M
