-- 资源管理器
local vim = vim
local notify = vim.notify
local cmd = vim.cmd
local opt = vim.opt

local base = require("core.plugin.base")

local _M = base.new {
    name = "nvim-treesitter", -- require name
    ext_name = ".configs",
    desc = "语法解析",
    github = "https://github.com/nvim-treesitter/nvim-treesitter",
    packer = {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            require("plugins.configs.ide.treesitter"):config()
        end
    }
}

_M.setup = function(self, keymaps)
    self.plugin.setup({
        -- 安装 language parser
        -- :TSInstallInfo 命令查看支持的语言
        ensure_installed = {"norg", "json", "html", "css", "vim", "lua", "javascript", "typescript", "rust"},
        -- 启用代码高亮模块
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false
        },
        -- 启用增量选择模块
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<TAB>", -- Enter
                node_incremental = "<CR>", -- Enter
                node_decremental = "<BS>", -- Backspace
                scope_incremental = "<TAB>" -- Tab
            }
        },
        -- 启用代码缩进模块 (=)
        indent = {
            enable = true
        }
    })
    -- 开启 Folding 模块
    -- 默认按键: zc: 折叠; zo: 打开折叠;
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt.foldenable = false
    -- 默认不要折叠
    -- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
    vim.opt.foldlevel = 99
end

return _M
