local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
local base = require("core.plugin.base")

local _M = base.new {
    name = "lspconfig",
    group = "LSP",
    desc = "配置",
    github = "https://github.com/neovim/nvim-lspconfig",
    auto_load = false,
    packer = {
        'neovim/nvim-lspconfig',
        config = function()
            -- require('plugins.lsp.installer'):config()
            require("plugins.lsp.config"):config()
        end
    }
}

_M.setup = function(self)
    -- lua
    self.plugin.sumneko_lua.setup {}
    -- rust
    self.plugin.rust_analyzer.setup {}
end

return _M
