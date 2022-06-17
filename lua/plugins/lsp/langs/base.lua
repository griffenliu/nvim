local _M = {}

local on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
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
    local a = vim.deepcopy(bufopts)
    vim.pretty_print(a)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, a)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wl', function()
    --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, bufopts)
    -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    -- vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)

    if client.supports_method('textDocument/signatureHelp') then
        vim.api.nvim_create_autocmd({ 'CursorHoldI' }, {
            pattern = '*',
            group = vim.api.nvim_create_augroup('LspSignature', {}),
            callback = function()
                vim.lsp.buf.signature_help()
            end,
        })
    end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
    documentationFormat = { 'markdown', 'plaintext' },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = {
        valueSet = { 1 },
    },
    resolveSupport = {
        properties = { 'documentation', 'detail', 'additionalTextEdits' },
    },
}

_M.new = function(opts)
    opts.on_attach = on_attach
    opts.capabilities = capabilities
    return { opts = opts }
end

return _M
