local plugin_name = "telescope"
local status, telescope = pcall(require, plugin_name)
if not status then
  vim.notify(plugin_name .. "not found!")
  return
end

local keymaps = require("core.keymaps")
keymaps.set(plugin_name, "n", "<C-p>", ":Telescope find_files<CR>", "查找文件")
keymaps.set(plugin_name, "n", "<C-f>", ":Telescope live_grep<CR>", "全局搜索")
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

telescope.setup({
  defaults = {
    -- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
    initial_mode = "insert",
    -- 窗口内快捷键
    mappings = keymaps.get_local_keys(plugin_name)[0],
  },
  pickers = {
    -- 内置 pickers 配置
    find_files = {
      -- 查找文件换皮肤，支持的参数有： dropdown, cursor, ivy
      -- theme = "dropdown",
    }
  },
  extensions = {
    -- 扩展插件配置
  },
})

-- telescope extensions
pcall(telescope.load_extension, "env")
