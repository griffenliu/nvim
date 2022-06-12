local plugin_name = "nvim-treesitter"
local status, treesitter = pcall(require, plugin_name .. ".configs")
if not status then
  vim.notify(plugin_name .. "not found!")
  return
end

local opt = vim.opt

treesitter.setup({
  -- 安装 language parser
  -- :TSInstallInfo 命令查看支持的语言
  ensure_installed = { "norg", "json", "html", "css", "vim", "lua", "javascript", "typescript", "rust" },
  -- 启用代码高亮模块
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  -- 启用增量选择模块
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>", -- Enter
      node_incremental = "<CR>", -- Enter
      node_decremental = "<BS>", -- Backspace
      scope_incremental = "<TAB>", -- Tab
    },
  },
  -- 启用代码缩进模块 (=)
  indent = {
    enable = true,
  },
})
-- 开启 Folding 模块
-- 默认按键: zc: 折叠; zo: 打开折叠;
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
opt.foldlevel = 99
