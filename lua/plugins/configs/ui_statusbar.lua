-- 资源管理器
local vim = vim
local notify = vim.notify
local cmd = vim.cmd

local base = require("core.plugin.base")

local _M = {
  name = "lualine",
  desc = "状态条",
  packer = {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("plugins.configs.ui_statusbar"):config()
    end
  }
}
setmetatable(_M, { __index = base })


-- _M.set_keymaps = function(self, keymaps)
--   keymaps.set(self.name, "n", "<leader>dd", ":Alpha<cr>", "[Dashboard] 显示Dashboard")
-- end

_M.plugin_setup = function(self, keymaps)
  self.plugin.setup({
    options = {
      theme = vim.g.options.theme,
      component_separators = { left = "|", right = "|" },
      -- https://github.com/ryanoasis/powerline-extra-symbols
      section_separators = { left = " ", right = "" },
    },
    extensions = { "nvim-tree", "toggleterm" },
    sections = {
      lualine_x = {
        "filesize",
        {
          "fileformat",
          symbols = {
            unix = "LF",
            dos = "CRLF",
            mac = "CR",
          },
        },
        "encoding",
        "filetype",
      },
    },
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
--   name = "lualine",
--   desc = "状态条",
--   packer = {
--     "nvim-lualine/lualine.nvim",
--     requires = { "kyazdani42/nvim-web-devicons" },
--     config = function()
--       require("plugins.configs.statusbar").config()
--     end
--   },
--   packer_ext = {
--     { "arkav/lualine-lsp-progress" }
--   }
-- }


-- local plugin_setup = function(plugin)
--   plugin.setup({
--     options = {
--       theme = "tokyonight", -- TODO: 全局变量？
--       component_separators = { left = "|", right = "|" },
--       -- https://github.com/ryanoasis/powerline-extra-symbols
--       section_separators = { left = " ", right = "" },
--     },
--     extensions = { "nvim-tree", "toggleterm" },
--     sections = {
--       lualine_c = {
--         "filename",
--         {
--           "lsp_progress",
--           spinner_symbols = { " ", " ", " ", " ", " ", " " },
--         },
--       },
--       lualine_x = {
--         "filesize",
--         {
--           "fileformat",
--           -- symbols = {
--           --   unix = '', -- e712
--           --   dos = '', -- e70f
--           --   mac = '', -- e711
--           -- },
--           symbols = {
--             unix = "LF",
--             dos = "CRLF",
--             mac = "CR",
--           },
--         },
--         "encoding",
--         "filetype",
--       },
--     },
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
