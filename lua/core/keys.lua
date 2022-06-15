local vim = vim
local keymap = vim.api.nvim_set_keymap
-- local buf_keymap = vim.api.nvim_buf_set_keymap

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", {
    noremap = true,
    silent = true
})
vim.g.mapleader = vim.g.options.leader
vim.g.maplocalleader = vim.g.options.leader

-- {
--     noremap = true,
--     silent = true,
--     desc = "@C " .. (desc or "")
-- }

local leader_mappings = {
    ["<leader>w"] = {
        name = "+window",
        w = {":vsp<CR>", "垂直分屏"},
        h = {":sp<CR>", "水平分屏"}, -- TODO: 实现一个默认的屏幕布局，快捷键自动布局
        x = {":close<CR>", "关闭当前窗口"},
        o = {":only<CR>", "关闭其他窗口"},
        ["="] = {"<C-w>=", "等比例分割窗口"}

    },
    ["<leader>f"] = {
        name = "+file",
        n = {"<cmd>enew<cr>", "创建文件"},
        f = {"<cmd>Telescope find_files<cr>", "查找文件"},
        r = {"<cmd>Telescope oldfiles<cr>", "打开最近文件"},
        g = {"<cmd>Telescope live_grep<cr>", "查找指定字符串"},
        s = {"<cmd>Telescope grep_string<cr>", "查找光标位置的字符串"},
        c = {"<cmd>Telescope commands<cr>", "查找Nvim命令"},
        h = {"<cmd>Telescope help_tags<cr>", "查找帮助"},
        k = {"<cmd>Telescope keymaps<cr>", "查找快捷键"},
        e = {"<cmd>Telescope env<cr>", "查找环境变量"},
        p = {"<cmd>Telescope projects<cr>", "项目列表"}
    },
    ["<leader>b"] = {
        name = "+buffer",
        b = {"<cmd>Telescope buffers<cr>", "打开缓冲区列表"},
        d = {"<cmd>bd<cr>", "删除当前缓冲区"},
        n = {"<cmd>bn<cr>", "下一个缓冲区"},
        p = {"<cmd>bp<cr>", "上一个缓冲区"},
        ad = {"<cmd>%bd<cr>", "删除所有缓冲区"},
        c = {"<cmd>Telescope neoclip<cr>", "剪贴板"}
    },
    ["<leader>t"] = {
        name = "+tool",
        d = {"<cmd>TodoTelescope<cr>", "显示TODO列表"},
        t = {":sp | terminal<CR>", "从下方打开终端"},
        v = {":vsp | terminal<CR>", "从右侧打开终端"}

    },
    ["<leader>v"] = {
        name = "+virtual",
        v = {"<cmd>ToggleLspVirtualLine<CR>", "虚拟诊断样式切换"}
    },
    ["<leader>m"] = {
        name = "+message",
        m = {":messages<CR>", "显示消息"},
        n = {":Notifications<CR>", "显示通知"}
    },
    ["<leader>s"] = {
        name = "+setting",
        s = {":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>", "编辑配置"},
        r = {":PackerSync<CR>", "同步插件"}
    },
    ["<leader>h"] = {
        name = "+help",
        c = {
            name = "+辅助记忆",
            c = {"<cmd>Cheatsheet<cr>", "查找信息"},
            e = {"<cmd>CheatsheetEdit<cr>", "编辑信息"}
        }
    },
    ["<leader>"] = {
        ["`"] = {"<cmd>ToggleExplorer<cr>", "打开文件树"},
        ["?"] = {"<cmd>Cheatsheet<cr>", "打开CheatSheet"}
    }
}
local _M = {}

-- 可以使用多种mapper，只要定义了register函数就可以使用
-- 这里简单使用which-key
_M.bind = function(mapper)
    mapper.register(leader_mappings)
end

local function opt(desc)
    return {
        noremap = true,
        silent = true,
        desc = desc or ""
    }
end
_M.setup = function()
    -- 窗口左右比例控制
    keymap("n", "<C-h>", ":vertical resize -2<CR>", opt("[窗口] 向左移动2个单位"))
    keymap("n", "<C-l>", ":vertical resize +2<CR>", opt("[窗口] 向右移动2个单位"))
    keymap("n", "<C-j>", ":resize +2<CR>", opt("[窗口] 向上移动2个单位"))
    keymap("n", "<C-k>", ":resize -2<CR>", opt("[窗口] 向下移动2个单位"))
    -- 编辑操作 =========================================
    keymap("n", "<C-s>", "<cmd> w <CR>", opt("[编辑] 保存文件"))
    -- TODO: 保存完毕自动恢复Normal模式
    keymap("i", "<C-s>", "<cmd> w <CR>", opt("[编辑] 保存文件"))
    keymap("n", "<C-c>", "<cmd> %y+ <CR>", opt("[编辑] 复制整个文件"))
    -- visual模式下缩进代码
    keymap("v", "<", "<gv", opt("[编辑] 向左缩进代码"))
    keymap("v", ">", ">gv", opt("[编辑] 向右缩进代码"))
    -- 上下移动选中文本
    keymap("v", "J", ":move '>+1<CR>gv-gv", opt("[编辑] 向上移动选中文本"))
    keymap("v", "K", ":move '<-2<CR>gv-gv", opt("[编辑] 向下移动选中文本"))

    -- Insert 模式快捷键 =================================
    keymap("i", "<C-a>", "<ESC>I", opt("[编辑] 光标跳转到行首")) -- <ESC>^i
    keymap("i", "<C-e>", "<ESC>A", opt("[编辑] 光标跳转到行尾")) -- <End>
    keymap("i", "<C-f>", "<Right>", opt("[编辑] 光标向右移动"))
    keymap("i", "<C-b>", "<Left>", opt("[编辑] 光标向左移动"))
    keymap("i", "<C-n>", "<Down>", opt("[编辑] 光标向下移动"))
    keymap("i", "<C-p>", "<Up>", opt("[编辑] 光标向上移动"))

    -- 编辑器 =========================================
    -- keymap("n", "q", ":q<CR>", opt("[Editor] 退出"))
    keymap("n", "qq", ":q!<CR>", opt("[Editor] 退出"))
    keymap("n", "Q", ":qa!<CR>", opt("[Editor] 退出"))
end

return _M
