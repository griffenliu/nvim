-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
local base = require("core.plugin.base")

local _M = base.new {
    name = "nvim-lspconfig",
    desc = "LSP-Config",
    github = "https://github.com/neovim/nvim-lspconfig",
    packer = {
        'neovim/nvim-lspconfig',
        config = function()
            require("plugins.configs.lsp.config"):config()
        end
    }
}

return _M
