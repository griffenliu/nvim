local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
local api = vim.api
local diagnostic = vim.diagnostic

local base = require('core.plugin.base')

local config_path = vim.fn.stdpath "config"

-- FIXME: 使用其git库下载比较费劲，这里直接使用本地目录
local _M = base.new({
    name = 'lsp_lines',
    group = "LSP",
    desc = '诊断行样式',
    github = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    packer = {
        config_path .. '/ext/lsp_lines.nvim',
        as = 'lsp_lines', -- 定义别名，否则创建目录报错
        config = function()
            require('plugins.lsp.virtual-line'):config()
        end
    }
})

-- _M.set_keymaps = function(self, keymaps)
--   keymaps.set(self.name, "n", "<leader>dd", ":Alpha<cr>", "[Dashboard] 显示Dashboard")
-- end

-- 默认使用单行虚拟行，可以使用快捷键进行切换
local is_virtual_text = true
local function toggle_virtual_line()
    if is_virtual_text then
        diagnostic.config({
            virtual_text = false,
            virtual_lines = true
        })
        is_virtual_text = false
    else
        diagnostic.config({
            virtual_text = {
                prefix = ''
            },
            virtual_lines = false
        })
        is_virtual_text = true
    end
end

_M.setup = function(self)
    -- 替换左侧符号栏的错误(E)，警告(W)等替换为图标
    -- Disable virtual_text since it's redundant due to lsp_lines.
    diagnostic.config({
        virtual_text = {
            prefix = ''
        },
        virtual_lines = false,
        signs = true
        -- 在输入模式下也更新提示，设置为 true 也许会影响性能
        -- update_in_insert = true
    })
    local signs = {
        Error = ' ',
        Warn = ' ',
        Hint = ' ',
        Info = ' '
    }
    for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, {
            text = icon,
            texthl = hl,
            numhl = hl
        })
    end

    self.plugin.register_lsp_virtual_lines()

    api.nvim_create_user_command('ToggleLspVirtualLine', toggle_virtual_line, {})
    -- api.nvim_set_keymap("n", "<leader>vv", "<cmd> ToggleLspVirtualLine <CR>",
    --   { noremap = true, silent = true, desc = "开关诊断增强" })
end

return _M
