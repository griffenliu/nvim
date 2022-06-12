-- 资源管理器
local vim = vim
local notify = vim.notify
local cmd = vim.cmd

local base = require("core.plugin.base")

local _M = {
  name = "indent_blankline", -- require name
  desc = "UI作用域",
  packer = { "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("plugins.configs.ui_code_scope"):config()
    end
  },
}
setmetatable(_M, { __index = base })


_M.set_keymaps = function(self, keymaps)
  keymaps.set(self.name, "n", "<leader>dd", ":Alpha<cr>", "[Dashboard] 显示Dashboard")
end

_M.plugin_setup = function(self, keymaps)
  self.plugin.setup({
    -- 空行占位
    space_char_blankline = " ",
    -- 用 treesitter 判断上下文
    show_current_context = true,
    show_current_context_start = true,
    context_patterns = {
      "class",
      "function",
      "method",
      "element",
      "^if",
      "^while",
      "^for",
      "^object",
      "^table",
      "block",
      "arguments",
    },
    -- :echo &filetype
    filetype_exclude = {
      "dashboard",
      "packer",
      "terminal",
      "help",
      "log",
      "markdown",
      "TelescopePrompt",
      "lsp-installer",
      "lspinfo",
      "toggleterm",
    },
    -- 竖线样式
    -- char = '¦'
    -- char = '┆'
    -- char = '│'
    -- char = "⎸",
    char = "▏",
  })
end

return _M

-- local function check(plugin_name)
--   local status, plugin = pcall(require, plugin_name)
--   if not status then
--     notify(plugin_name .. " not found!")
--     return false
--   end
--   return plugin
-- end

-- local set_keymaps
-- local function setup_keymaps(plugin_name)
--   if set_keymaps and type(set_keymaps) == "function" then
--     local keymaps = require("core.keymaps")
--     set_keymaps(plugin_name, keymaps)
--     keymaps.bind(plugin_name)
--   end
-- end

-- ============================================================================

-- local _M = {
--   name = "indent_blankline", -- require name
--   desc = "UI作用域",
--   packer = { "lukas-reineke/indent-blankline.nvim",
--     config = function()
--       require("plugins.configs.editor_code_scope").config()
--     end
--   },
-- }

-- local function plugin_setup(plugin, plugin_name)
--   plugin.setup({
--     -- 空行占位
--     space_char_blankline = " ",
--     -- 用 treesitter 判断上下文
--     show_current_context = true,
--     show_current_context_start = true,
--     context_patterns = {
--       "class",
--       "function",
--       "method",
--       "element",
--       "^if",
--       "^while",
--       "^for",
--       "^object",
--       "^table",
--       "block",
--       "arguments",
--     },
--     -- :echo &filetype
--     filetype_exclude = {
--       "dashboard",
--       "packer",
--       "terminal",
--       "help",
--       "log",
--       "markdown",
--       "TelescopePrompt",
--       "lsp-installer",
--       "lspinfo",
--       "toggleterm",
--     },
--     -- 竖线样式
--     -- char = '¦'
--     -- char = '┆'
--     -- char = '│'
--     -- char = "⎸",
--     char = "▏",
--   })
-- end

-- -- ============================================================================
-- _M.config = function()
--   local plugin_name = _M.name
--   local plugin = check(plugin_name)
--   if not plugin then return end
--   -- set key
--   setup_keymaps(plugin_name)
--   -- config
--   plugin_setup(plugin, plugin_name)
-- end

-- return _M
