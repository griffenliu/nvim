local keymap = vim.api.nvim_set_keymap
-- 复用 opt 参数
local opt = {
    noremap = true,
    silent = true
}

local mappings = {{
    mode = "n",
    key = "s",
    cmd = "",
    opt = opt,
    desc = ""
}}

local function add_key(mode, key, cmd, desc)

end

-- 设置Leader Key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 取消 s 默认功能
keymap("n", "s", "", opt)
-- windows 分屏快捷键
keymap("n", "sv", ":vsp<CR>", opt)
keymap("n", "sh", ":sp<CR>", opt)
-- 关闭当前窗口
keymap("n", "sc", "<C-w>c", opt)
-- 关闭其他窗口
keymap("n", "so", "<C-w>o", opt)
-- Alt + hjkl 窗口之间跳转
keymap("n", "<A-h>", "<C-w>h", opt)
keymap("n", "<A-j>", "<C-w>j", opt)
keymap("n", "<A-k>", "<C-w>k", opt)
keymap("n", "<A-l>", "<C-w>l", opt)

-- 左右比例控制
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opt)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opt)
keymap("n", "s,", ":vertical resize -20<CR>", opt)
keymap("n", "s.", ":vertical resize +20<CR>", opt)
-- 上下比例
keymap("n", "sj", ":resize +10<CR>", opt)
keymap("n", "sk", ":resize -10<CR>", opt)
keymap("n", "<C-Down>", ":resize +2<CR>", opt)
keymap("n", "<C-Up>", ":resize -2<CR>", opt)
-- 等比例
keymap("n", "s=", "<C-w>=", opt)

-- Terminal相关
keymap("n", "<leader>t", ":sp | terminal<CR>", opt)
keymap("n", "<leader>vt", ":vsp | terminal<CR>", opt)
keymap("t", "<Esc>", "<C-\\><C-n>", opt)
keymap("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], opt)
keymap("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], opt)
keymap("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], opt)
keymap("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opt)

-- visual模式下缩进代码
keymap("v", "<", "<gv", opt)
keymap("v", ">", ">gv", opt)
-- 上下移动选中文本
keymap("v", "J", ":move '>+1<CR>gv-gv", opt)
keymap("v", "K", ":move '<-2<CR>gv-gv", opt)

-- 上下滚动浏览
keymap("n", "<C-j>", "4j", opt)
keymap("n", "<C-k>", "4k", opt)
-- ctrl u / ctrl + d  只移动9行，默认移动半屏
keymap("n", "<C-u>", "9k", opt)
keymap("n", "<C-d>", "9j", opt)

-- 在visual 模式里粘贴不要复制
keymap("v", "p", '"_dP', opt)

-- 退出
keymap("n", "qq", ":q!<CR>", opt)
keymap("n", "Q", ":qa!<CR>", opt)

-- insert 模式下，跳到行首行尾
keymap("i", "<C-a>", "<ESC>I", opt)
keymap("i", "<C-e>", "<ESC>A", opt)
