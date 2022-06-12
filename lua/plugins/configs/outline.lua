local vim = vim
local notify = vim.notify
local cmd = vim.cmd

local base = require("core.plugin.base")

local _M = {
  name = "aerial", -- require name
  desc = "大纲",
  packer = {
    'stevearc/aerial.nvim',
    config = function()
      require('plugins.configs.outline'):config()
    end
  },
}
setmetatable(_M, { __index = base })


_M.set_keymaps = function(self, keymaps)
  keymaps.set(self.name, "n", "<leader>dd", ":Alpha<cr>", "[Dashboard] 显示Dashboard")
end

_M.plugin_setup = function(self, keymaps)
  self.plugin.setup({
    backends = { "treesitter", "lsp", "markdown" },
    default_direction = "prefer_right",
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
-- 如果有快捷键需求，这一块才需要处理和定制
-- set_keymaps = function(plugin_name, keymaps)
--   -- keymaps.set(plugin_name, "n", "<leader>ff", ":Telescope find_files<CR>", "[文件] 查找文件")
--   -- ... do keymaps
-- end

-- local _M = {
--   name = "aerial", -- require name
--   desc = "大纲",
--   packer = {
--     'stevearc/aerial.nvim',
--     config = function()
--       require('plugins.configs.outline').config()
--     end
--   },
-- }

-- local function plugin_setup(plugin, plugin_name)
--   plugin.setup({
--     backends = { "treesitter", "lsp", "markdown" },
--     default_direction = "prefer_right",
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
