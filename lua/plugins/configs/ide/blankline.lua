-- 资源管理器
local vim = vim
local notify = vim.notify
local cmd = vim.cmd

local base = require("core.plugin.base")

local _M = base.new {
    name = "indent_blankline", -- require name
    desc = "[IDE]空白线",
    github = "https://github.com/lukas-reineke/indent-blankline.nvim",
    packer = {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("plugins.configs.ide.blankline"):config()
        end
    }
}

--[[

{
        -- 空行占位
        space_char_blankline = " ",
        -- 用 treesitter 判断上下文
        show_current_context = true,
        show_current_context_start = true,
        context_patterns = {"class", "function", "method", "element", "^if", "^while", "^for", "^object", "^table",
                            "block", "arguments"},
        -- :echo &filetype
        filetype_exclude = {"dashboard", "packer", "terminal", "help", "log", "markdown", "TelescopePrompt",
                            "lsp-installer", "lspinfo", "toggleterm"},
        -- 竖线样式
        -- char = '¦'
        -- char = '┆'
        -- char = '│'
        -- char = "⎸",
        char = "▏"
    }
--]]
_M.setup = function(self, keymaps)
    self.plugin.setup {
        -- space_char_blankline = " ",
        -- show_end_of_line = true,
        -- show_current_context = true,
        -- show_current_context_start = true
    }
end

return _M
