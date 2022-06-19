local vim = vim
local lsp = vim.lsp
local api = vim.api
local keymap = vim.keymap

local _M = {
    enable_lspsaga = false,
}

local default_keymaps = function(opt)
    local lsp_buf = vim.lsp.buf
    local cmd_rename = lsp_buf.rename
    local cmd_code_action = lsp_buf.code_action
    local cmd_hover = lsp_buf.hover
    local cmd_signature = lsp_buf.signature_help
    local cmd_diag_open = vim.diagnostic.open_float
    local cmd_diag_next = vim.diagnostic.goto_next
    local cmd_diag_prev = vim.diagnostic.goto_prev
    if _M.enable_lspsaga then
        cmd_rename = '<cmd>Lspsaga rename<cr>'
        cmd_code_action = '<cmd>Lspsaga code_action<cr>'
        cmd_hover = '<cmd>Lspsaga hover_doc<cr>'
        cmd_signature = '<cmd>Lspsaga signature_help<cr>'
        cmd_diag_open = '<cmd>Lspsaga show_line_diagnostics<cr>'
        cmd_diag_next = '<cmd>Lspsaga diagnostic_jump_next<cr>'
        cmd_diag_prev = '<cmd>Lspsaga diagnostic_jump_prev<cr>'
        -- 额外添加的命令
        keymap.set('n', 'gp', '<cmd>Lspsaga preview_definition<cr>', opt('预览定义'))
        keymap.set('x', 'ga', ':<c-u>Lspsaga range_code_action<cr>', opt('Range Code Action'))
        keymap.set('n', 'gF', '<cmd>Lspsaga lsp_finder<cr>', opt('查找光标位置定义和引用'))
        -- TODO: 这个快捷键定义还是有问题，因为终端无法进入normal模式，因此就无法使用这个快捷键直接关闭，还是需要C-或A-快捷键的支持
        keymap.set('n', '<C-u>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", {})
        keymap.set('n', '<C-d>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", {})
        keymap.set('n', '<A-d>', ':Lspsaga open_floaterm<CR>', { noremap = true, silent = true })
        keymap.set('t', '<A-d>', '<C-\\><C-n>:Lspsaga close_floaterm<CR>', { noremap = true, silent = true })
    end
    keymap.set('n', 'gr', cmd_rename, opt('批量替换'))
    keymap.set('n', 'ga', cmd_code_action, opt('代码提示'))
    keymap.set('n', 'gh', cmd_hover, opt('悬停文档'))
    keymap.set('n', 'gs', cmd_signature, opt('签名帮助'))
    keymap.set('n', 'go', cmd_diag_open, opt('诊断'))
    keymap.set('n', 'gj', cmd_diag_next, opt('下一个诊断'))
    keymap.set('n', 'gk', cmd_diag_prev, opt('上一个诊断'))
    -- ====
    keymap.set('n', 'gD', vim.lsp.buf.declaration, opt('跳转到声明'))
    keymap.set('n', 'gd', vim.lsp.buf.definition, opt('跳转到定义'))
    keymap.set('n', 'gm', vim.lsp.buf.implementation, opt('跳转到实现'))
    keymap.set('n', 'gR', vim.lsp.buf.references, opt('引用列表'))
    keymap.set('n', 'gO', vim.diagnostic.setloclist, opt('诊断列表'))
    keymap.set('n', 'gt', vim.lsp.buf.type_definition, opt('类型定义'))

    keymap.set('n', 'wa', vim.lsp.buf.add_workspace_folder, opt('添加工作空间目录'))
    keymap.set('n', 'wr', vim.lsp.buf.remove_workspace_folder, opt('移除工作空间目录'))
    keymap.set('n', 'wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opt('打印工作空间列表'))
end

local get_on_attach = function(keymaps)
    return function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        -- Enable completion triggered by <c-x><c-o>
        api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        -- Mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        -- local opts = { noremap = true, silent = true }
        -- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
        -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions

        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        local opt = function(desc)
            local newopt = vim.deepcopy(bufopts)
            newopt.desc = desc
            return newopt
        end
        default_keymaps(opt)
        if keymaps and type(keymaps) == 'function' then
            keymaps(opt)
        end

        -- vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
        -- 如果支持签名帮助，则自动弹出
        -- if client.supports_method('textDocument/signatureHelp') then
        --   api.nvim_create_autocmd({ 'CursorHoldI' }, {
        --     pattern = '*',
        --     group = api.nvim_create_augroup('LspSignature', {}),
        --     callback = function()
        --       lsp.buf.signature_help()
        --     end,
        --   })
        -- end
    end
end

local capabilities = lsp.protocol.make_client_capabilities()

-- capabilities.textDocument.completion.completionItem = {
--   documentationFormat = { 'markdown', 'plaintext' },
--   snippetSupport = true,
--   preselectSupport = true,
--   insertReplaceSupport = true,
--   labelDetailsSupport = true,
--   deprecatedSupport = true,
--   commitCharactersSupport = true,
--   tagSupport = {
--     valueSet = { 1 },
--   },
--   resolveSupport = {
--     properties = { 'documentation', 'detail', 'additionalTextEdits' },
--   },
-- }

_M.merge = function(opts)
    opts = opts or {}
    opts.on_attach = get_on_attach(opts.keymaps)
    opts.capabilities = capabilities
    return opts
end
-- _M.new = function(opts)
--     opts = opts or {}
--     opts.on_attach = get_on_attach(opts.keymaps)
--     opts.capabilities = capabilities
--     return { opts = opts }
-- end

return _M
