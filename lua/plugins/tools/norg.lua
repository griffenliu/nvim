-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
-- local api = vim.api
local base = require('core.plugin.base')

local _M = base.new({
    name = 'neorg',
    group = 'TOOL',
    desc = 'Norg笔记',
    github = 'https://github.com/nvim-neorg/neorg',
    packer = {
        'nvim-neorg/neorg',
        requires = 'nvim-lua/plenary.nvim',
        -- ft = 'norg',
        config = function()
            require('plugins.tools.norg'):config()
        end
    }
})

_M.setup = function(self)
    self.plugin.setup({
        load = {
            ['core.defaults'] = {},
            ['core.norg.dirman'] = {
                config = {
                    workspaces = vim.g.options.workspace
                }
            },
            ['core.norg.concealer'] = {}
            -- ['core.norg.completion'] = { config = { engine = 'cmp' } },
        }
    })
end

return _M
