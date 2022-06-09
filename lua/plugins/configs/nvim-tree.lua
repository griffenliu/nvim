local plugin_name = "nvim-tree"

local status, nvim_tree = pcall(require, plugin_name)
if not status then
    vim.notify(plugin_name .. " not found!")
    return
end
vim.pretty_print("nvim-tree 1========================================")
local keymaps = require("core.keymaps")
keymaps.add_plugin_key(plugin_name, "n", "<A-m>", ":NvimTreeToggle<CR>", "Alt + m 打开或关闭文件树")

keymaps.add_plugin_local_key(plugin_name, {
    key = {"<CR>", "o", "<2-LeftMouse>"},
    action = "edit",
    desc = "打开文件或文件夹"
})
keymaps.add_plugin_local_key(plugin_name, {
    key = "v",
    action = "vsplit",
    desc = "垂直分屏并打开文件"
})
keymaps.add_plugin_local_key(plugin_name, {
    key = "h",
    action = "split",
    desc = "水平分屏并打开文件"
})
keymaps.add_plugin_local_key(plugin_name, {
    key = "i",
    action = "toggle_custom",
    desc = "显示屏蔽的文件和文件夹"
})
keymaps.add_plugin_local_key(plugin_name, {
    key = "<F5>",
    action = "refresh",
    desc = "刷新"
})
keymaps.add_plugin_local_key(plugin_name, {
    key = ".",
    action = "toggle_dotfiles",
    desc = "隐藏文件"
})
keymaps.add_plugin_local_key(plugin_name, {
    key = "d",
    action = "remove",
    desc = "删除文件"
})
keymaps.add_plugin_local_key(plugin_name, {
    key = "r",
    action = "rename",
    desc = "重命名文件"
})
keymaps.add_plugin_local_key(plugin_name, {
    key = "x",
    action = "cut",
    desc = "剪切文件"
})
keymaps.add_plugin_local_key(plugin_name, {
    key = "c",
    action = "copy",
    desc = "复制文件"
})
keymaps.add_plugin_local_key(plugin_name, {
    key = "p",
    action = "paste",
    desc = "粘贴文件"
})
keymaps.add_plugin_local_key(plugin_name, {
    key = "s",
    action = "system_open",
    desc = "使用系统打开"
})
vim.pretty_print("nvim-tree 2========================================")
local local_mappings = keymaps.get_plugin_local_keys(plugin_name)

nvim_tree.setup({
    -- 不显示 git 状态图标
    git = {
        enable = false
    },
    -- project plugin 需要这样设置
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = true
    },
    -- 隐藏 .文件 和 node_modules 文件夹
    filters = {
        dotfiles = true,
        custom = {'node_modules'}
    },
    view = {
        -- 宽度
        width = 40,
        -- 也可以 'right'
        side = 'left',
        -- 隐藏根目录
        hide_root_folder = false,
        -- 自定义列表中快捷键
        mappings = {
            custom_only = false,
            list = local_mappings
        },
        -- 不显示行数
        number = false,
        relativenumber = false,
        -- 显示图标
        signcolumn = 'yes'
    },
    actions = {
        open_file = {
            -- 首次打开大小适配
            resize_window = true,
            -- 打开文件时关闭
            quit_on_open = true
        }
    }
    -- wsl install -g wsl-open
    -- https://github.com/4U6U57/wsl-open/
    -- system_open = {
    --     cmd = 'wsl-open' -- mac 直接设置为 open
    -- }
})
-- 自动关闭
vim.cmd([[
  autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]])
