local vim         = vim
local config_path = vim.fn.stdpath('config')
local data_path   = vim.fn.stdpath('data')
local cache_path  = vim.fn.stdpath('cache')

-- 定义一个全局日志
_G.log = {
    warn = vim.pretty_print
}

vim.g.options = {
    leader = ' ', -- leader key
    -- "tokyonight"; "onedark"; "gruvbox"; "nord"; "nightfox";
    theme = 'tokyonight',
    home = vim.env.HOME,
    config_path = config_path,
    data_path = data_path,
    cache_path = cache_path,
    workspace = {
        main = 'D:\\坚果云同步\\我的知识库\\笔记',
    },
    langs = { 'lua', 'rust' },

}

require('core')
