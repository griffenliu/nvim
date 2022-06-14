-- 资源管理器
local vim = vim
local notify = vim.notify
local cmd = vim.cmd
local opt = vim.opt

local base = require("core.plugin.base")

local _M = {
  name = "nvim-treesitter", -- require name
  ext_name = ".configs",
  desc = "高亮",
  packer = {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("plugins.configs.code_highlight"):config()
    end
  }
}
setmetatable(_M, { __index = base })


_M.plugin_setup = function(self, keymaps)
  self.plugin.setup({
    -- 安装 language parser
    -- :TSInstallInfo 命令查看支持的语言
    ensure_installed = {
      "norg",
      "json",
      "html",
      "css",
      "vim",
      "lua",
      "javascript",
      "typescript",
      "rust"
    },
    -- 启用代码高亮模块
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    -- 启用增量选择模块
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<CR>", -- Enter
        node_incremental = "<CR>", -- Enter
        node_decremental = "<BS>", -- Backspace
        scope_incremental = "<TAB>", -- Tab
      },
    },
    -- 启用代码缩进模块 (=)
    indent = {
      enable = true,
    },
  })
  -- 开启 Folding 模块
  -- 默认按键: zc: 折叠; zo: 打开折叠;
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  vim.opt.foldenable = false
  -- 默认不要折叠
  -- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
  vim.opt.foldlevel = 99
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
--   name = "nvim-treesitter", -- require name
--   desc = "高亮",
--   packer = {
--     "nvim-treesitter/nvim-treesitter",
--     run = ":TSUpdate",
--     config = function()
--       require("plugins.configs.highlight").config()
--     end
--   }
-- }

-- local function plugin_setup(plugin, plugin_name)
--   plugin.setup({
--     -- 安装 language parser
--     -- :TSInstallInfo 命令查看支持的语言
--     ensure_installed = {
--       "norg",
--       "json",
--       "html",
--       "css",
--       "vim",
--       "lua",
--       "javascript",
--       "typescript",
--       "rust"
--     },
--     -- 启用代码高亮模块
--     highlight = {
--       enable = true,
--       additional_vim_regex_highlighting = false,
--     },
--     -- 启用增量选择模块
--     incremental_selection = {
--       enable = true,
--       keymaps = {
--         init_selection = "<CR>", -- Enter
--         node_incremental = "<CR>", -- Enter
--         node_decremental = "<BS>", -- Backspace
--         scope_incremental = "<TAB>", -- Tab
--       },
--     },
--     -- 启用代码缩进模块 (=)
--     indent = {
--       enable = true,
--     },
--   })
--   -- 开启 Folding 模块
--   -- 默认按键: zc: 折叠; zo: 打开折叠;
--   opt.foldmethod = "expr"
--   opt.foldexpr = "nvim_treesitter#foldexpr()"
--   -- 默认不要折叠
--   -- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
--   opt.foldlevel = 99
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
