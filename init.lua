local config_path = vim.fn.stdpath('config')
local data_path = vim.fn.stdpath('data')
vim.g.options = {
    leader = ' ', -- leader key
    -- "tokyonight"; "onedark"; "gruvbox"; "nord"; "nightfox";
    theme = 'tokyonight',
    config_path = config_path,
    data_path = data_path,
    workspace = {
        main = 'D:\\坚果云同步\\我的知识库\\笔记',
    },
    langs = { 'lua', 'rust' },
}

print(vim.fn.stdpath('data'))

require('core')
