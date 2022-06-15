local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
local base = require("core.plugin.base")

local _M = base.new {
    name = "lspconfig",
    desc = "[LSP]Config",
    github = "https://github.com/neovim/nvim-lspconfig",
    auto_load = false,
    packer = {
        'neovim/nvim-lspconfig',
        config = function()
            require("plugins.configs.lsp.config"):config()
        end
    }
}

-- _M.setup = function(self)
--     vim.lsp.buf.format({ timeout_ms = 2000 })
-- end

return _M
