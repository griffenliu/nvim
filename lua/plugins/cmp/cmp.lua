local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
local base = require('core.plugin.base')

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end
local _M = base.new({
    name = 'cmp', -- require name
    group = 'CMP',
    desc = '引擎',
    github = 'https://github.com/hrsh7th/nvim-cmp',
    packer = {
        'hrsh7th/nvim-cmp',
        config = function()
            require('plugins.cmp.cmp'):config()
        end,
    },
})

_M.setup = function(self)
    local luasnip = require('luasnip')
    local cmp = self.plugin
    local config = {
        -- 指定 snippet 引擎
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        -- 补全源
        sources = cmp.config.sources(
            { {
                name = 'nvim_lsp',
            }, {
                name = 'luasnip',
            } },
            {
                {
                    name = 'buffer',
                },
                {
                    name = 'path',
                },
                {
                    name = 'nvim_lua',
                },
            }
        ),

        -- 快捷键设置
        mapping = {
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { 'i', 's' }),

            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 's' }),
        },
    }

    local ok, lspkind = pcall(require, 'lspkind')
    if ok then
        -- 使用lspkind-nvim显示类型图标
        config.formatting = {
            format = lspkind.cmp_format({
                mode = 'symbol_text',
                -- mode = 'symbol', -- show only symbol annotations
                maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                -- The function below will be called before any actual modifications from lspkind
                -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                before = function(entry, vim_item)
                    -- Source 显示提示来源
                    vim_item.menu = '[' .. string.upper(entry.source.name) .. ']'
                    return vim_item
                end,
            }),
        }
    end

    cmp.setup(config)

    -- / 查找模式使用 buffer 源
    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { {
            name = 'buffer',
        } },
    })

    -- : 命令行模式中使用 path 和 cmdline 源.
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
            { {
                name = 'path',
            } },
            { {
                name = 'cmdline',
            } }
        ),
    })
end

return _M
