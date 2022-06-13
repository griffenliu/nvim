## 环境变量

- [ ] TODO: insert模式下也可以使用Ctrl+s进行保存
- [ ] TODO: 帮助里面还需要把光标移动到缓冲区，还需要完善快捷指令，例如按 q 或者<esc>会退出等
- [ ] TODO: 明天把 norg 的集成完成，基本就差不多了，写一个文档，用来查阅帮助就行了
- [ ] TODO: 需要把文档都查阅一下，尽量都使用默认的配置，如果可行的化，UI 可能需要自定义，其他默认能用就用，快捷键也是一样
- [ ] TODO: 窗口选择，参考一下[gitlab.com/yorickpeterse/nvim-window](https://gitlab.com/yorickpeterse/nvim-window) ，看看是如何实现的，同时快捷键按修改一下，使用<leader>键直接触发，不要加 w 了
- [ ] TODO: 研究一下怎么取消 leader 的按键延迟

### Windows

设置环境变量:

- XDG_CONFIG_HOME 配置文件目录
- XDG_CONFIG_DATA 配置数据目录

### Linux

推荐使用默认配置
也可以使用 XDG_CONFIG_HOME 和 XDG_CONFIG_DATA 来设置
但是很多软件都使用这两个环境变量，所以不能设置的太私有化

## 常用 API 记录

### nvim_open_win({buffer}, {enter}, {\*config})

参数:

- {buffer} Buffer to display, or 0 for current buffer
- {enter} Enter the window (make it the current window)
- {config} Map defining the window configuration.
  - relative: 设置窗口浮动布局
    - "editor": 全局编辑器网格
    - "win": 通过"win"字段指定的窗口，或当前窗口
    - "cursor": 当前窗口的光标位置
  - win: 当 relative="win"时，这里指定窗口 ID
  - anchor: 决定将浮动窗口的哪个角放在(row, col)指定的位置
    - "NW" 西北 (默认)
    - "NE" 东北
    - "SW" 西南
    - "SE" 东南
  - width: 窗口宽度（字符单位），最小为 1
  - height: 窗口高度（字符单位），最小为 1
  - bufpos: 浮动文本相对于缓冲区文本放置（仅 relative="win"时)。取值为[line, column]的元组。如果设置了"row"和"col"则相对于这个位置，否则使用下面的默认值:
    - 如果`anchor="NW"/"NE"` 则 `row=1`, `col=0`
    - 如果`anchor="SW"/"SE"` 则 `row=0`, `col=0` (因为这样可以使提示更接近缓冲文本)
  - row: 行的位置，以 "屏幕单元高度" 为单位，可以是小数
  - col: 列的位置，以 "屏幕单元格宽度" 为单位，可以是小数
  - focusable: 通过用户行为(wincmds, mouse events)启用焦点。默认为 true。 无焦点的窗口可以通过|nvim_set_current_win()|进入。
  - external: GUI 使用
  - zindex: 堆叠顺序。`zindex'较大的浮动窗口放在索引较低的浮动窗口上面。必须大于零。以下屏幕元素有硬编码的 zindex:
    - 100: 插入补全弹出菜单
    - 200: 信息滚动回放
    - 250: [cmdline](https://neovim.io/doc/user/cmdline.html#cmdline) 补全弹出菜单，浮动窗口的默认值为 50，通常来说，推荐自定义浮动窗口的值低于 100， 除非有确定的原因要覆盖内置浮动窗口。
  - style: 配置窗口的外观。目前只接受一个非空值。
    - "minimal": Nvim 显示浮动窗口时，会禁用很多 UI 选项。当显示一个文本不会被编辑的临时浮动窗口时这很有用。 'number', 'relativenumber', 'cursorline', 'cursorcolumn', 'foldcolumn', 'spell' 和 'list' 等选项会被禁用， 'signcolumn'会被设置为`auto`，'colorcolumn'会被清除。通过将'fillchars'的`eob`标志设置为一个空格字符来隐藏缓冲区的末端区域。并清除'winhighlight'中的|EndOfBuffer|区域。
  - border： 窗口的边框选项（可选）。可以是 string 值或数组。字符串值:
    - "none": 没有边框(默认)
    - "single": 单线条边框
    - "double": 双线条边框
    - "rounded": 圆角单线条边框
    - "solid": 带填充单线条
    - "shadow": 很合阴影背景效果
    - 如果它是一个数组，它的长度应该是 8 或任何整除 8 的数。数组将指定从左上角开始，以顺时针方式建立边框的八个字符。作为一个例子，可以使用[ "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" ]指定双边框样式。
  - noautocmd： 如果为 "true"，则与缓冲区有关的自动命令事件，如|BufEnter|、|BufLeave|或|BufWinEnter|，都不会因调用此函数而触发

返回：
返回窗口句柄，或者错误时返回 0

```lua
vim.api.nvim_open_win(0, false,
      {relative='win', row=3, col=3, width=12, height=3})

```

### nvim_create_buf({listed}, {scratch})

Creates a new, empty, unnamed buffer.

参数：

- {listed}: Sets ['buflisted'](https://neovim.io/doc/user/options.html#'buflisted')，是否在缓冲区列表中显示。布尔值。
- {scratch}: 为临时的工作创建一个随时可丢弃的|scratch-buffer|（总是不可修改），同时设置'nomodeline'。布尔值，标记是否是临时缓冲区。

返回：
缓冲区句柄，错误时返回 0

### nvim_feedkeys({keys}, {mode}, {escape_ks})

向 Nvim 发送输入键，受`mode`标志控制的各种怪癖的影响。这是一个阻塞式调用，与|nvim_input()|不同.
在执行错误时：不会失败，但会更新 v:errmsg
To input sequences like <C-o> use |nvim_replace_termcodes()|
(typically with escape_ks=false) to replace |keycodes|, then
pass the result to nvim_feedkeys().

参数:

- {keys} 输入的按键
- {mode} 行为标记，见 |feedkeys()| ('m', 'n', 't', 'i', 'x', '!')
- {escape_ks} 如果为真，在`keys`中转义`K_SPECIAL`字节 如果你已经使用了|nvim_replace_termcodes()|，这应该是 false，否则就是 true

### api.nvim_set_current_win(winid)

## 插件列表

- https://github.com/rockerBOO/awesome-neovim
- https://neovimcraft.com/
- https://vimawesome.com/

### ★★★ 插件管理

| 分类                   | 名称                                                                                          | 选择 | Star | 描述                                                                                                                            |
| ---------------------- | --------------------------------------------------------------------------------------------- | ---- | ---- | ------------------------------------------------------------------------------------------------------------------------------- |
| ★ 插件管理             | [wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim)                           | [x]  | 3k   | 包管理器                                                                                                                        |
| ★ 启动                 | [goolord/alpha-nvim](https://github.com/goolord/alpha-nvim)                                   | [x]  | 504  | 一个快速且高度可定制的欢迎程序，例如用于 Neovim 的 vim-startify /dashboard-nvim.                                                |
| ★ 配色方案             | [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim)                             | [x]  | 1.6k | 用 Lua 编写的干净、深色和浅色的 Neovim 主题，支持 LSP、Tree-sitter 和许多插件。                                                 |
| ★ 编辑支持             | [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs)                             | [x]  | 977  | 由 Lua 编写的 Neovim 的极简自动配对。                                                                                           |
| ★ 状态栏               | [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)                     | [x]  | 1.9k | 一个快速且易于配置的 Neovim 状态行。                                                                                            |
| ★ 文件管理             | [kyazdani42/nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)                       | [x]  | 2.6k | Neovim 的简单快速的文件浏览器树。                                                                                               |
| ★ 文件查找             | [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)             | [x]  | 6k   | Telescope.nvim 是一个高度可扩展的列表模糊查找器。建立在 Neovim 核心的最新强大功能之上。Telescope 以模块化为中心，允许轻松定制。 |
| ★ 语法高亮             | [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)         | [x]  | 4k   | Neovim Treesitter 配置和抽象层。                                                                                                |
| ★ 注释                 | [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim)                             | [x]  | 1k   | Neovim 的智能和强大的注释插件。支持注释字符串、动作、点重复等。                                                                 |
| ★ 代码范围             | [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | [x]  | 1.5k | Lua 中的 IndentLine 替换，具有更多功能和 treesitter 支持                                                                        |
| ★ LSP                  | [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)                             | [x]  | 4.7k | Neovim LSP 客户端的快速启动配置                                                                                                 |
| ★ LSP                  | [williamboman/nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer)         | [X]  | 1.7k | 轻松安装 50 多个 LSP 服务器 - 完全支持 Windows。                                                                                |
| ★ Snippet              | [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)                                       | [x]  | 971  | 用 Lua 编写的 Neovim 片段引擎.                                                                                                  |
| ★ 补全                 | [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)                                       | [x]  | 3k   | 用 Lua 编写的 Neovim 补全插件。新版本的 nvim-compe。                                                                            |
| ★ 补全                 | [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)                               | [x]  | 261  | Neovim 内置 LSP 客户端的 nvim-cmp 源。                                                                                          |
| ★ 补全                 | [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)                       | [x]  | 165  | 用于 luasnip 补全的 nvim-cmp 源。                                                                                               |
| ★ 补全                 | [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path)                                       | [x]  | 163  | 文件系统路径的 nvim-cmp 源。                                                                                                    |
| ★ 笔记                 | [nvim-neorg/neorg](https://github.com/nvim-neorg/neorg)                                       | [ ]  | 2.4k | 现代性与疯狂的可扩展性相遇。在 Neovim 中组织您的生活的未来。                                                                    |
| ★ 格式化               | [mhartington/formatter.nvim](https://github.com/mhartington/formatter.nvim)                   | [ ]  | 512  | 用 Lua 编写的 Neovim 格式运行器。                                                                                               |
| ★ 按键绑定             | [people/which-key.nvim](https://github.com/folke/which-key.nvim)                              | [ ]  | 1.5k | Neovim 插件，显示一个弹出窗口，其中包含您开始输入的命令的可能键绑定                                                             |
| ★ 配色方案             | [navarasu/onedark.nvim](https://github.com/navarasu/onedark.nvim)                             | [ ]  | 385  | 基于 Atom 的 One Dark Theme 用 Lua 编写的 Neovim 0.5 的 One Dark Theme.                                                         |
| LSP 扩展               | [jose-elias-alvarez/null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim)         | [ ]  | 1.4k | 使用 Neovim 作为语言服务器，通过 Lua 注入 LSP 诊断、代码操作等。格式化可以使用，但是貌似有些问题，暂时不用了                    |
| LSP 扩展               | [people/trouble.nvim](https://github.com/folke/trouble.nvim)                                  | [ ]  | 1.7k | [参考] 一个漂亮的诊断列表，可帮助您解决代码造成的所有问题。                                                                     |
| LSP 扩展               | [tami5/lspsaga.nvim](https://github.com/tami5/lspsaga.nvim)                                   | [ ]  | 382  | [参考] 一个基于 Neovim 内置 lsp 的轻量级 lsp 插件，有一个高性能的用户界面. (这个插件在批量修改变量时弹出一个输入框，还是不错的) |
| LSP 扩展               | [stevearc/aerial.nvim](https://github.com/stevearc/aerial.nvim)                               | [ ]  | 423  | [参考] 用于浏览和快速导航的代码大纲窗口。                                                                                       |
| LSP 扩展               | [weilbith/nvim-code-action-menu](https://github.com/weilbith/nvim-code-action-menu)           | [ ]  | 332  | 代码操作的浮动弹出菜单，用于显示代码操作信息和差异预览。                                                                        |
| LSP 扩展               | [ldelossa/litee.nvim](https://github.com/ldelossa/litee.nvim)                                 | [ ]  | 251  | [参考] Neovim 缺少的 IDE 功能。                                                                                                 |
| LSP 扩展               | [fidget.nvim](https://github.com/j-hui/fidget.nvim)                                           | [ ]  | 500  | nvim-lsp 进度的独立 UI。                                                                                                        |
| LSP 扩展               | [git.sr.ht/~whynothugo/lsp_lines.nvim](https://git.sr.ht/~whynothugo/lsp_lines.nvim)          | [ ]  |      | [参考] 一个 Neovim 插件，它使用真实代码行之上的虚拟行来呈现诊断。                                                               |
| LSP 扩展               | [amrbashir/nvim-docs-view](https://github.com/amrbashir/nvim-docs-view)                       | [ ]  | 11   | [参考] Neovim 插件，用于在侧面板中显示 lsp 悬停文档。                                                                           |
| 启动                   | [glepnir/dashboard-nvim](https://github.com/glepnir/dashboard-nvim)                           | [ ]  | 877  | Neovim 的简约仪表板，灵感来自 doom-emacs.                                                                                       |
| 配色方案               | [mhartington/oceanic-next](https://github.com/mhartington/oceanic-next)                       | [ ]  | 1k   | Neovim 的 Oceanic Next 主题.                                                                                                    |
| 配色方案               | [sainnhe/gruvbox-material](https://github.com/sainnhe/gruvbox-material)                       | [ ]  | 939  | Gruvbox 修改，具有更柔和的对比度和 Tree-sitter 支持。                                                                           |
| 配色方案               | [sainnhe/everforest](https://github.com/sainnhe/everforest)                                   | [ ]  | 1.1k | 一种基于绿色的配色方案，设计为温暖、柔和且易于上眼。                                                                            |
| 配色方案               | [dracula/vim](https://github.com/dracula/vim)                                                 | [ ]  | 1.1k | 著名的美丽黑暗动力主题。                                                                                                        |
| 配色方案               | [EdenEast/nightfox.nvim](https://github.com/EdenEast/nightfox.nvim)                           | [ ]  | 913  | 一个柔和的深色、完全可定制的 Neovim 主题，支持 lsp、treesitter 和各种插件。                                                     |
| 浏览器集成             | [glacambre/firenvim](https://github.com/glacambre/firenvim)                                   | [x]  | 2.8k | 将 Neovim 直接嵌入到您的浏览器中，不问任何问题。                                                                                |
| Markdown               | [ellisonleao/glow.nvim](https://github.com/ellisonleao/glow.nvim)                             | [ ]  | 560  | Markdown 预览。                                                                                                                 |
| 终端                   | [akinsho/nvim-toggleterm.lua](https://github.com/akinsho/nvim-toggleterm.lua)                 | [ ]  | 1.2k | Neovim Lua 插件，可帮助轻松管理多个终端窗口。                                                                                   |
| 寄存器                 | [tversteeg/registers.nvim](https://github.com/tversteeg/registers.nvim)                       | [ ]  | 416  | vim 寄存器的非侵入式最小预览。                                                                                                  |
| 寄存器                 | [acksld/nvim-neoclip.lua](https://github.com/AckslD/nvim-neoclip.lua)                         | [ ]  | 413  | 带有 telescope 集成的剪贴板管理器 Neovim 插件。                                                                                 |
| Mark (after telescope) | [ThePrimeagen/harpoon](https://github.com/ThePrimeagen/harpoon)                               | [ ]  | 829  | 每个项目的自动更新和可编辑标记实用程序，用于快速文件导航。                                                                      |
| Color                  | [norcalli/nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua)                 | [ ]  | 1.3k | Neovim 的高性能颜色荧光笔，没有外部依赖！这个就是可以在颜色上面直接显示色彩                                                     |
| 工具                   | [rcarriga/nvim-notify](https://github.com/rcarriga/nvim-notify)                               | [ ]  | 1.2k | NeoVim 的精美、可配置的通知管理器。                                                                                             |
| 工具                   | [stevearc/dressing.nvim](https://github.com/stevearc/dressing.nvim)                           | [ ]  | 508  | 改进与望远镜、fzf 等的内置接口。                                                                                                |
| 图标                   | [kyazdani42/nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)               | [ ]  | 591  | vim-devicons 的 Lua 分支。                                                                                                      |
| 调试                   | [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap)                             | [ ]  | 1.7k | Neovim 的调试适配器协议客户端实现。                                                                                             |
| 调试                   | [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)                               | [ ]  | 598  | nvim-dap 的 UI。                                                                                                                |
| LUA 库                 | [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim)                             | [ ]  | 901  | 全体会议：完整；完全的; 全部的; 绝对; 不合格。我不想写两次的所有 Lua 函数。                                                     |
| LUA 库                 | [nvim-luadev](https://github.com/bfredl/nvim-luadev)                                          | [ ]  | 189  | Neovim Lua 插件的 REPL/调试控制台。该:Luadev 命令将打开一个临时窗口，该窗口将显示执行 Lua 代码的输出。                          |
| LUA 库                 | [tami5/sqlite.lua](https://github.com/tami5/sqlite.lua)                                       | [ ]  | 237  | Lua 和 Neovim 的 SQLite/LuaJIT 绑定。                                                                                           |
| LUA 库                 | [MuifTanjim/nui.nvim](https://github.com/MunifTanjim/nui.nvim)                                | [ ]  | 464  | Neovim 的 UI 组件库。                                                                                                           |
| Tabline                | [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim)                         | [ ]  | 1.3k | 使用 Lua 构建的 Neovim 的时髦缓冲线。                                                                                           |
| Tabline                | [romgrk/barbar.nvim](https://github.com/romgrk/barbar.nvim)                                   | [ ]  | 1.1k | The Neovim tabline plugin.                                                                                                      |
| 光标线                 | [RRethy/vim-illuminate](https://github.com/RRethy/vim-illuminate)                             | [ ]  | 1.1k | 突出显示光标下的单词。Neovim 的内置 LSP 可用，它可以用来更智能地突出显示。                                                      |
| 注释                   | [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim)                       | [ ]  | 865  | 突出显示、列出和搜索项目中的待办事项评论。                                                                                      |
| 快速移动 Motion        | [phaazon/hop.nvim](https://github.com/phaazon/hop.nvim)                                       | [ ]  | 1.3k | Hop 是一个类似于 EasyMotion 的插件，允许您以尽可能少的击键次数跳转到文档中的任何位置。                                          |
| 快速移动 Motion        | [ggandor/lightspeed.nvim](https://github.com/ggandor/lightspeed.nvim)                         | [ ]  | 1.2k | 一个类似 Sneak 的插件，通过提前显示的标签提供无与伦比的导航速度，消除了输入搜索模式和选择目标之间的暂停。                       |
| 项目                   | [windwp/nvim-spectre](https://github.com/windwp/nvim-spectre)                                 | [ ]  | 494  | Neovim 的搜索和替换面板。                                                                                                       |
| 项目                   | [ahmedkhalf/project.nvim](https://github.com/ahmedkhalf/project.nvim)                         | [ ]  | 448  | 一个多合一的 Neovim 插件，提供卓越的项目管理。                                                                                  |
| 格式化                 | [sbdchd/neoformat](https://github.com/sbdchd/neoformat)                                       | [ ]  | 1.5k | 用于格式化代码的 (Neo)vim 插件。                                                                                                |
| Media                  | [ekickx/clipboard-image.nvim](https://github.com/ekickx/clipboard-image.nvim)                 | [ ]  | 125  | Neovim Lua 插件，用于从剪贴板粘贴图像。                                                                                         |
| Command Line           | [gelguy/wilder.nvim](https://github.com/gelguy/wilder.nvim)                                   | [ ]  | 691  | 用于模糊命令行自动完成的插件。                                                                                                  |
| 按键绑定               | [mrjones2014/legendary.nvim](https://github.com/mrjones2014/legendary.nvim)                   | [ ]  | 343  | 将您的键盘映射、命令和自动命令定义为简单的 Lua 表，并同时为它们创建图例，与 which-key.nvim.                                     |
| Window                 | [gitlab.com/yorickpeterse/nvim-window](https://gitlab.com/yorickpeterse/nvim-window)          | [ ]  |      | [参考]在 Neovim 窗口之间轻松跳转。                                                                                              |

## 代码格式化

### Lua

- Stylua: https://github.com/JohnnyMorganz/StyLua
  cargo install stylua

## 参考记录

- [VIM LUA](https://neovim.io/doc/user/lua.html) LUA API
- [VIM API](https://neovim.io/doc/user/api.html) 常用 API
- [VIM 内置](https://neovim.io/doc/user/builtin.html) 变量，函数
- [VIM 帮助](https://yianwillis.github.io/vimcdoc/doc/help.html)
- [终端 Alacritty](https://github.com/alacritty/alacritty)
- [awesome-neovim](https://github.com/rockerBOO/awesome-neovim)
- [neorg(待研究)](https://github.com/nvim-neorg/neorg)
- [ref configs](https://neovim.discourse.group/t/the-300-line-init-lua-challenge/227)
- [Neovim配置实战](https://juejin.cn/book/7051157342770954277/section/7051399376945545252)
- [Nerd Font图标](https://www.nerdfonts.com/cheat-sheet)
- [nvim-lua-guide-zh](https://github.com/glepnir/nvim-lua-guide-zh)
- [luarocks.cn](https://luarocks.cn/)
- [Nerd Font](https://github.com/ryanoasis/nerd-fonts)
