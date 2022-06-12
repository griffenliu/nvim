local plugin_name = "telescope"
local status, telescope = pcall(require, plugin_name)
if not status then
  vim.notify(plugin_name .. "not found!")
  return
end

local keymaps = require("core.keymaps")
keymaps.set(plugin_name, "n", "<leader>ff", ":Telescope find_files<CR>", "[文件] 查找文件")
keymaps.set(plugin_name, "n", "<leader>fe", ":Telescope file_browser<cr>", "[文件] 文件浏览")
keymaps.set(plugin_name, "n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "[文件] 查找所有文件")
keymaps.set(plugin_name, "n", "<leader>fs", "<cmd>lua require('telescope.builtin').grep_string()<cr>", "[文件] grep string查找")
keymaps.set(plugin_name, "n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", "[文件] grep查找")
keymaps.set(plugin_name, "n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", "[文件] 查找文件缓冲")
keymaps.set(plugin_name, "n", "<leader>fh", "<cmd> Telescope help_tags <CR>", "[文件] 帮助页面")
keymaps.set(plugin_name, "n", "<leader>fk", "<cmd> Telescope keymaps <CR>", "[文件] 查找快捷键")

keymaps.set_local(plugin_name, {
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
keymaps.bind(plugin_name)

local layout_config = {
  height = 0.95,
  preview_width = 0.6,
  width = 0.8,
}
local file_ignore_patterns = {
  ".git/",
  "node_modules",
}
telescope.setup({
  defaults = {
    -- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
    initial_mode = "insert",
    layout_config = layout_config,
    file_ignore_patterns = file_ignore_patterns,
    -- 窗口内快捷键
    mappings = keymaps.get_local_keys(plugin_name)[0],
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
pcall(telescope.load_extension, "env")
pcall(telescope.load_extension, "file_browser")
