local vim = vim
local table_insert = table.insert

local M = {}
-- 插件列表
M.plugins = {}

local function add_lazy_autocmd_hook(plugins, output_lua, should_profile)

    local output = [[
        local lazy_load = function(tb)
            vim.api.nvim_create_autocmd(tb.events, {
                pattern = "*",
                group = vim.api.nvim_create_augroup(tb.augroup_name, {}),
                callback = function()
                    if tb.condition() then
                        vim.api.nvim_del_augroup_by_name(tb.augroup_name)

                        -- dont defer for treesitter as it will show slow highlighting
                        -- This deferring only happens only when we do "nvim filename"
                        if tb.plugins ~= "nvim-treesitter" then
                            vim.defer_fn(function()
                                vim.cmd("PackerLoad " .. tb.plugins)
                            end, 0)
                        else
                            vim.cmd("PackerLoad " .. tb.plugins)
                        end
                    end
                end
            })
        end
        lazy_load {
            events = { "BufRead", "BufWinEnter", "BufNewFile" },
            augroup_name = "BeLazyOnFileOpen",
            plugins = "nvim-lsp-installer indent-blankline.nvim",

            condition = function()
                local file = vim.fn.expand "%"
                return file ~= "NvimTree_1" and file ~= "[packer]" and file ~= ""
            end
        }
    ]]
    return output
end

local function hook_compile(hook)
    local compile = require('packer.compile')
    local meta = getmetatable(compile)
    local call = meta.__call
    setmetatable(compile, { __call = function(this, plugins, output_lua, should_profile)
        --print(vim.inspect(this))
        local output = call(nil, plugins, output_lua, should_profile)
        output = output .. "\n" .. hook(plugins, output_lua, should_profile)
        return output
    end })
end

local function startup()
    local present, packer = pcall(require, "packer")
    if not present then
        return
    end
    -- packer.set_handler("after", function(plugins, plugin, value)
    --     vim.pretty_print(plugin)
    --     vim.pretty_print(value)
    -- end)

    -- local call = compile.__call
    -- compile.__call = function(_, plugins, output_lua, should_profile)
    --     print("befor...")
    --     local result = call(_, plugins, output_lua, should_profile)
    --     print("after...")
    --     return result
    -- end
    -- 添加编译hook，在编译结果中注入一些自定义代码
    hook_compile(add_lazy_autocmd_hook)
    -- 初始化packer
    packer.init(M.options)
    -- 启动packer
    packer.startup(function(use)
        -- Packer管理自己
        use('wbthomason/packer.nvim')
        -- 插件
        for _, p in ipairs(M.plugins) do
            use(p.packer)
            if p.packer_ext then
                for _, ext in ipairs(p.packer_ext) do
                    -- ext.after = get_plugin_key(p.packer[1])
                    use(ext)
                end
            end
        end
    end)

    -- 每次保存 plugins.lua 自动安装插件
    pcall(vim.cmd, [[
        augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
        augroup end
    ]])
end

M.options = {
    auto_clean = true,
    compile_on_sync = true,
    -- 并发数限制
    max_jobs = 16,
    git = {
        clone_timeout = 6000
        -- default_url_format = "https://hub.fastgit.xyz/%s",
        -- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
        -- default_url_format = "https://gitcode.net/mirrors/%s",
        -- default_url_format = "https://gitclone.com/github.com/%s",
    },
    display = {
        -- working_sym = " ﲊ",
        -- error_sym = "✗ ",
        -- done_sym = " ",
        -- removed_sym = " ",
        -- moved_sym = "",
        open_fn = function()
            return require("packer.util").float {
                border = "single"
            }
        end
    }
}

M.bootstrap = function()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    print("packer install path: " .. install_path)
    vim.api.nvim_set_hl(0, "NormalFloat", {
        bg = "#1e222a"
    })

    if fn.empty(fn.glob(install_path)) > 0 then
        print "Cloning packer ..."

        fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
        -- vim.fn.execute('!git clone --depth 1 https://github.com/wbthomason/packer.nvim ' .. install_path)
        -- install plugins + compile their configs
        vim.cmd "packadd packer.nvim"
    end
    startup()
    -- execute sync...
    -- vim.cmd "PackerSync"
end
-- 按照插入顺序进行排序
M.add = function(plugin)
    table_insert(M.plugins, plugin)
end

return M
