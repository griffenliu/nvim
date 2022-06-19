local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
-- local api = vim.api
local base = require("core.plugin.base")

local _M = base.new {
    name = "lspsaga",
    group = "LSP",
    desc = "默认替换",
    -- github = "https://github.com/glepnir/lspsaga.nvim", -- 原版地址
    github = "https://github.com/tami5/lspsaga.nvim", -- 可用fork
    packer = {
        'tami5/lspsaga.nvim',
        config = function()
            require("plugins.lsp.lspsaga"):config()
        end
    }
}

-- _M.set_keymaps = function(self, keymaps)
--   keymaps.set(self.name, "n", "<leader>dd", ":Alpha<cr>", "[Dashboard] 显示Dashboard")
-- end

_M.setup = function(self)
    self.plugin.init_lsp_saga {}
    -- local opt = function(desc)
    --     return { noremap = true, silent = true, desc = desc, buffer = 0 }
    -- end
    -- local function keymaps(opt)
    --     -- vim.keymap.set('n', '<leader>lf', ":Lspsaga lsp_finder<CR>", opt("查找定义或引用"))
    --     -- vim.keymap.set('n', '<leader>la', ":Lspsaga code_action<CR>", opt("代码动作"))
    --     -- vim.keymap.set('v', '<leader>la', ":Lspsaga range_code_action<CR>", opt("范围代码动作"))
    --     -- vim.keymap.set('n', '<leader>lk', ":Lspsaga hover_doc<CR>", opt("悬停提示"))
    --     vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<cr>", opt("批量替换"))
    --     vim.keymap.set("n", "gx", "<cmd>Lspsaga code_action<cr>", opt("代码动作"))
    --     vim.keymap.set("x", "gx", ":<c-u>Lspsaga range_code_action<cr>", opt("范围代码动作"))
    --     vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", opt("悬停提示"))
    --     vim.keymap.set("n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>", opt("行诊断"))
    --     vim.keymap.set("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opt("下一个诊断"))
    --     vim.keymap.set("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opt("上一个诊断"))
    --     vim.keymap.set("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", {})
    --     vim.keymap.set("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", {})
    --     vim.cmd([[
    --         augroup lspsaga_filetypes
    --         autocmd!
    --         autocmd FileType LspsagaHover nnoremap <buffer><nowait><silent> <Esc> <cmd>close!<cr>
    --         augroup end
    --     ]])
    -- end


end

return _M
