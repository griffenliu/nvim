local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
local base = require('core.plugin.base')

local _M = base.new({
    name = 'lspconfig',
    group = 'LSP',
    desc = '配置',
    github = 'https://github.com/neovim/nvim-lspconfig',
    packer = {
        'neovim/nvim-lspconfig',
        config = function()
            require('plugins.lsp.config'):config()
        end,
    },
})

_M.setup = function(self)
    require('plugins.lsp.installer'):config()
    -- 其他配置需要Lspsage，因此后移到Lspsaga加载完成后
end

return _M
