local vim = vim
local notify = vim.notify
local cmd = vim.cmd


local base = require("core.plugin.base")

local _M = {
  name = "lluminate",
  desc = "单词高亮",
  packer = {
    'RRethy/vim-illuminate.git',
    config = function()
      require("plugins.configs.code_word_highlight"):config()
    end
  }
}
setmetatable(_M, { __index = base })


_M.set_keymaps = function(self, keymaps)
  keymaps.set(self.name, "n", "<a-n>", "<cmd>lua require('illuminate').next_reference{wrap=true}<cr>", "下一个")
  keymaps.set(self.name, "n", "<a-p>", "<cmd>lua require('illuminate').next_reference{reverse=true,wrap=true}<cr>", "下一个")
end

_M.plugin_setup = function(self, keymaps)
  -- ...
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

-- -- ============================================================================
-- -- 如果有快捷键需求，这一块才需要处理和定制
-- -- set_keymaps = function(plugin_name, keymaps)
-- --   -- keymaps.set(plugin_name, "n", "<leader>ff", ":Telescope find_files<CR>", "[文件] 查找文件")
-- --   -- ... do keymaps
-- -- end

-- local _M = {
--   name = "telescope", -- require name
--   desc = "文件",
--   packer = {
--     'nvim-telescope/telescope.nvim',
--     requires = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-file-browser.nvim" },
--     config = function()
--       require("plugins.configs.file").config()
--     end
--   },
--   packer_ext = {
--     { "LinArcX/telescope-env.nvim" }
--   }
-- }

-- local function plugin_setup(plugin, plugin_name)
--   -- plugin.setup({ ... })
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

