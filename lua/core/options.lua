--[[
全局选项：
vim.api.nvim_set_option(string, value)
vim.api.nvim_get_option(string, value)
缓冲区选项: Buffer-local 选项需要缓冲区编号（使用 0 将设置 / 获取当前缓冲区的选项）：
vim.api.nvim_buf_set_option(num, string, value)
vim.api.nvim_buf_get_option(num, string, value)
窗口选项：Window-local 选项需要窗口编号（使用 0 将设置 / 获取当前窗口的选项）：
vim.api.nvim_win_set_option(num, string, value)
vim.api.nvim_win_get_option(num, string, value)

元访问器：它们本质上包装了上述 API 函数，并允许您像处理变量一样操作选项
vim.o: 行为类似于 :let &{option-name}
vim.go: 行为类似于 :let &g:{option-name}
vim.bo: 适用于 buffer-local 选项，行为类似于 :let &l:{option-name}
vim.wo: 适用于 window-local 选项，行为类似于 :let &l:{option-name}
您可以为缓冲区本地和窗口本地选项指定一个数字。如果未给出编号，则使用当前缓冲区 / 窗口
vim.bo[4].expandtab = true -- same as vim.api.nvim_buf_set_option(4, 'expandtab', true)

这些访问器还有更为复杂的 vim.opt* 变体，
它们为在 Lua 中设置选项提供了更为灵活便利的机制，
就像你在 init.vim 中使用的 :set/:setglobal/:setlocal:
vim.opt: 行为类似于 :set
vim.opt_global: 行为类似于 :setglobal
vim.opt_local: 行为类似于 :setlocal

内部变量也有自己的 api 函数：

全局变量 (g:):
vim.api.nvim_set_var()
vim.api.nvim_get_var()
vim.api.nvim_del_var()
缓冲区变量 (b:):
vim.api.nvim_buf_set_var()
vim.api.nvim_buf_get_var()
vim.api.nvim_buf_del_var()
窗口变量 (w:):
vim.api.nvim_win_set_var()
vim.api.nvim_win_get_var()
vim.api.nvim_win_del_var()
选项卡变量 (t:):
vim.api.nvim_tabpage_set_var()
vim.api.nvim_tabpage_get_var()
vim.api.nvim_tabpage_del_var()
预定义的 vim 变量 (v:):
vim.api.nvim_set_vvar()
vim.api.nvim_get_vvar()

元访问器
使用这些元访问器可以更直观地操作内部变量：
vim.g: 全局变量
vim.b: 缓冲区变量
vim.w: 窗口变量
vim.t: 选项卡变量
vim.v: 预定义变量
vim.env: 环境变量

一些变量名可能包含不能在 Lua 中用作标识符的字符。你可以使用以下语法操作这些变量：vim.g['my#variable']

删除变量只需要将它的值设置为 nil
--]] local vim = vim
local o = vim.o
local g = vim.g
local wo = vim.wo
local bo = vim.bo
local opt = vim.opt
-- utf8
g.encoding = "UTF-8"
o.fileencoding = 'utf-8'
-- jkhl 移动时光标周围保留8行
o.scrolloff = 8
o.sidescrolloff = 8
-- 使用相对行号
wo.number = true
wo.numberwidth = 2
wo.relativenumber = true
-- 高亮所在行
wo.cursorline = true
-- 显示左侧图标指示列
wo.signcolumn = "yes"
-- 右侧参考线，超过表示代码太长了，考虑换行
wo.colorcolumn = "80"
-- 缩进2个空格等于一个Tab
o.tabstop = 4
bo.tabstop = 4
o.softtabstop = 4
o.shiftround = true
-- >> << 时移动长度
o.shiftwidth = 2
bo.shiftwidth = 2
-- 空格替代tab
o.expandtab = true
bo.expandtab = true
-- 新行对齐当前行
o.autoindent = true
bo.autoindent = true
o.smartindent = true
-- 搜索大小写不敏感，除非包含大写
o.ignorecase = true
o.smartcase = true
-- 搜索不要高亮
o.hlsearch = false
-- 边输入边搜索
o.incsearch = true
-- 命令行高为2，提供足够的显示空间
o.cmdheight = 2
-- 当文件被外部程序修改时，自动加载
o.autoread = true
bo.autoread = true
-- 禁止折行
wo.wrap = false
-- 光标在行首尾时<Left><Right>可以跳到下一行
o.whichwrap = '<,>,[,]'
-- 允许隐藏被修改过的buffer
o.hidden = true
-- 鼠标支持
o.mouse = "a"
-- 禁止创建备份文件
o.backup = false
o.writebackup = false
o.swapfile = false
-- smaller updatetime
o.updatetime = 300
-- 设置 timeoutlen 为等待键盘快捷键连击时间500毫秒，可根据需要设置
o.timeoutlen = 500
-- split window 从下边和右边出现
o.splitbelow = true
o.splitright = true
-- 自动补全不自动选中
g.completeopt = "menu,menuone,noselect,noinsert"

-- 样式
o.background = "dark"
o.termguicolors = true
opt.termguicolors = true

-- 不可见字符的显示，这里只把空格显示为一个点
opt.list = true
opt.listchars:append("space:⋅")
opt.listchars:append("eol:↴")

-- 补全增强
o.wildmenu = true
-- Dont' pass messages to |ins-completin menu|
o.shortmess = vim.o.shortmess .. 'c'
-- 补全最多显示10行
o.pumheight = 10
-- 永远显示 tabline
o.showtabline = 2
-- 使用增强状态栏插件后不再需要 vim 的模式提示
o.showmode = false
