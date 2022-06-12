local plugin_name = "nvim-tree"

local status, nvim_tree = pcall(require, plugin_name)
if not status then
    vim.notify(plugin_name .. " not found!")
    return
end
local keymaps = require("core.keymaps")
keymaps.set(plugin_name, "n", "<leader>ft", "<cmd> NvimTreeToggle <CR>", "[文件树] 打开或关闭文件树")

-- 默认的快捷键就很好，可以使用 g? 查看
keymaps.set_local(plugin_name, {
    key = "#",
    action = "print_path",
    action_cb = function(node)
        print(node.absolute_path)
    end,
    desc = "使用资源管理器打开"
})
keymaps.bind(plugin_name)

local local_mappings = keymaps.get_local_keys(plugin_name)
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
        custom = { 'node_modules' }
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
