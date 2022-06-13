# Telescope

- github: https://github.com/nvim-telescope/telescope.nvim

## 快捷键

### 自定义的激活按键
搜索都是相对于当前的工作目录的:

- <leader>ff: 文件搜索
- <leader>fa: 搜索所有文件，包括忽略的文件，隐藏的文件等
- <leader>fb: 当前工作目录浏览，和nvim-tree的作用相同
- <leader>fg: 文本搜索
- <leader>fs: 光标位置的字符串搜索
- <leader>fc: Nvim命令列表
- <leader>fh: Nvim帮助搜索
- <leader>bb: 文件缓冲列表
- <leader>ba: 所有缓冲列表（包括被隐藏的，未实现）
- <leader>bp: 前一个缓冲文件（未实现）
- <leader>bn: 下一个缓冲文件（未实现）


```
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
```

### 默认按键
| mode | mapping | action |
| --- | ---- | ---- |
| * | <C-n> | 下一项 |
| * | <C-p> | 上一项 |
| n | j / k | 下/上一项 |
| n | H/M/L | 选择高/中/低|
| n | gg/G | 选择 第一 / 最后一项 |
| * | <CR> | 确认选择 |
| * | <C-x> | 选择文件，水平分割窗口 |
| * | <C-v> | 选择文件，垂直分割 |
| * | <C-t> | 在新标签页打开文件 |
| * | <C-u> | 向上滚动预览窗口 |
| * | <C-d> | 向下混动预览窗口 |
| i | <C-/> | 显示picker actions的按键 |
| n | ? | 显示picker actions的按键 |
| * | <C-c> | 关闭telescope |
| * | <Esc> | 关闭tesescope(n mode)，i mode会返回 n mode|
| * | <Tab> | 多选模式，向上选择 |
| * | <S-Tab> | 多选模式，向下选择 |
| * | <C-q> | 发送所有的未过滤的项目到快速修复列表(qflist) |
| * | <M-q> | 发送所有的项目到快速修复列表) |
