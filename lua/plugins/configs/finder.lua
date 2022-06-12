-- 资源管理器
local vim = vim
local notify = vim.notify
local cmd = vim.cmd


local base = require("core.plugin.base")

local _M = {
  name = "telescope", -- require name
  desc = "文件",
  packer = {
    'nvim-telescope/telescope.nvim',
    requires = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-file-browser.nvim" },
    config = function()
      require("plugins.configs.finder"):config()
    end
  },
  packer_ext = {
    { "LinArcX/telescope-env.nvim" }
  }
}
setmetatable(_M, { __index = base })


_M.set_keymaps = function(self, keymaps)
  keymaps.set(self.name, "n", "<leader>ff", ":Telescope find_files<CR>", "[文件] 查找文件")
  keymaps.set(self.name, "n", "<leader>fe", ":Telescope file_browser<cr>", "[文件] 文件浏览")
  keymaps.set(self.name, "n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
    "[文件] 查找所有文件")
  keymaps.set(self.name, "n", "<leader>fs", "<cmd>lua require('telescope.builtin').grep_string()<cr>",
    "[文件] grep string查找")
  keymaps.set(self.name, "n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", "[文件] grep查找")
  keymaps.set(self.name, "n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", "[文件] 查找文件缓冲")
  keymaps.set(self.name, "n", "<leader>fh", "<cmd> Telescope help_tags <CR>", "[文件] 帮助页面")
  keymaps.set(self.name, "n", "<leader>fk", "<cmd> Telescope keymaps <CR>", "[文件] 查找快捷键")

  keymaps.set_local(self.name, {
    i = {
      -- 上下移动
      ["<C-j>"] = "move_selection_next",
      ["<C-k>"] = "move_selection_previous",
      ["<Down>"] = "move_selection_next",
      ["<Up>"] = "move_selection_previous",
      -- 历史记录
      ["<C-n>"] = "cycle_history_next",
      ["<C-p>"] = "cycle_history_prev",
      -- 关闭窗口
      ["<C-c>"] = "close",
      -- 预览窗口上下滚动
      ["<C-u>"] = "preview_scrolling_up",
      ["<C-d>"] = "preview_scrolling_down",
    },
  })
end

_M.plugin_setup = function(self, keymaps)
  local layout_config = {
    height = 0.95,
    preview_width = 0.6,
    width = 0.8,
  }
  local file_ignore_patterns = {
    ".git/",
    "node_modules",
  }
  local mappings = require("core.keymaps").get_local_keys(self.name)[0]
  self.plugin.setup({
    defaults = {
      -- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
      initial_mode = "insert",
      layout_config = layout_config,
      file_ignore_patterns = file_ignore_patterns,
      -- 窗口内快捷键
      mappings = mappings,
    },
    -- pickers = {
    --   -- 内置 pickers 配置
    --   find_files = {
    --     -- 查找文件换皮肤，支持的参数有： dropdown, cursor, ivy
    --     -- theme = "dropdown",
    --   }
    -- },
    pickers = {
      find_files = {
        hidden = true,
      },
      grep_string = {

        hidden = true,
      },
      live_grep = {
        hidden = true,
      },
    },
    extensions = {
      -- 扩展插件，文件浏览
      file_browser = {
        grouped = true,
        hidden = true,
        layout_config = layout_config,
        layout_strategy = "horizontal",
      },
    },
  })

  -- telescope extensions
  pcall(self.plugin.load_extension, "env")
  pcall(self.plugin.load_extension, "file_browser")
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
--   local keymaps = require("core.keymaps")
--   set_keymaps(plugin_name, keymaps)
--   keymaps.bind(plugin_name)
-- end

-- -- ============================================================================

-- set_keymaps = function(plugin_name, keymaps)
--   keymaps.set(plugin_name, "n", "<leader>ff", ":Telescope find_files<CR>", "[文件] 查找文件")
--   keymaps.set(plugin_name, "n", "<leader>fe", ":Telescope file_browser<cr>", "[文件] 文件浏览")
--   keymaps.set(plugin_name, "n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "[文件] 查找所有文件")
--   keymaps.set(plugin_name, "n", "<leader>fs", "<cmd>lua require('telescope.builtin').grep_string()<cr>", "[文件] grep string查找")
--   keymaps.set(plugin_name, "n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", "[文件] grep查找")
--   keymaps.set(plugin_name, "n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", "[文件] 查找文件缓冲")
--   keymaps.set(plugin_name, "n", "<leader>fh", "<cmd> Telescope help_tags <CR>", "[文件] 帮助页面")
--   keymaps.set(plugin_name, "n", "<leader>fk", "<cmd> Telescope keymaps <CR>", "[文件] 查找快捷键")

--   keymaps.set_local(plugin_name, {
--     i = {
--       -- 上下移动
--       ["<C-j>"] = "move_selection_next",
--       ["<C-k>"] = "move_selection_previous",
--       ["<Down>"] = "move_selection_next",
--       ["<Up>"] = "move_selection_previous",
--       -- 历史记录
--       ["<C-n>"] = "cycle_history_next",
--       ["<C-p>"] = "cycle_history_prev",
--       -- 关闭窗口
--       ["<C-c>"] = "close",
--       -- 预览窗口上下滚动
--       ["<C-u>"] = "preview_scrolling_up",
--       ["<C-d>"] = "preview_scrolling_down",
--     },
--   })
-- end

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
--   local layout_config = {
--     height = 0.95,
--     preview_width = 0.6,
--     width = 0.8,
--   }
--   local file_ignore_patterns = {
--     ".git/",
--     "node_modules",
--   }
--   local mappings = require("core.keymaps").get_local_keys(plugin_name)[0]
--   plugin.setup({
--     defaults = {
--       -- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
--       initial_mode = "insert",
--       layout_config = layout_config,
--       file_ignore_patterns = file_ignore_patterns,
--       -- 窗口内快捷键
--       mappings = mappings,
--     },
--     -- pickers = {
--     --   -- 内置 pickers 配置
--     --   find_files = {
--     --     -- 查找文件换皮肤，支持的参数有： dropdown, cursor, ivy
--     --     -- theme = "dropdown",
--     --   }
--     -- },
--     pickers = {
--       find_files = {
--         hidden = true,
--       },
--       grep_string = {

--         hidden = true,
--       },
--       live_grep = {
--         hidden = true,
--       },
--     },
--     extensions = {
--       -- 扩展插件，文件浏览
--       file_browser = {
--         grouped = true,
--         hidden = true,
--         layout_config = layout_config,
--         layout_strategy = "horizontal",
--       },
--     },
--   })

--   -- telescope extensions
--   pcall(plugin.load_extension, "env")
--   pcall(plugin.load_extension, "file_browser")
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
