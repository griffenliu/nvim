-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
-- local api = vim.api
local base = require('core.plugin.base')

local _M = base.new({
    name = 'cmp_nvim_lsp',
    group = 'CMP',
    desc = 'Lsp',
    github = 'https://github.com/hrsh7th/cmp-nvim-lsp',
    auto_load = false,
    auto_config = false,
    packer = {
        'hrsh7th/cmp-nvim-lsp',
        config = function()
            require('plugins.cmp.sources.lsp'):config()
        end,
    },
})

-- _M.setup = function(self, keymaps)
--   require('cmp').setup {
--     sources = {
--       { name = 'nvim_lsp' }
--     }
--   }

-- -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- -- The following example advertise capabilities to `clangd`.
-- require 'lspconfig'.clangd.setup {
--   capabilities = capabilities,
-- }
-- end

return _M
