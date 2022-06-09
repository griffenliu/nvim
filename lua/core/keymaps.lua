local table_insert = table.insert
local keymap = vim.api.nvim_set_keymap
-- 复用 opt 参数
local opt = {
    noremap = true,
    silent = true
}
-- local mappings = {
--     n = {},
--     i = {},
--     t = {},
--     v = {}
-- }

-- local function add_nkey(key, cmd, desc)
--     table_insert(mappings.n, {key, cmd, opt, desc or ""})
-- end
-- local function add_ikey(key, cmd, desc)
--     table_insert(mappings.i, {key, cmd, opt, desc or ""})
-- end
-- local function add_tkey(key, cmd, desc)
--     table_insert(mappings.t, {key, cmd, opt, desc or ""})
-- end
-- local function add_vkey(key, cmd, desc)
--     table_insert(mappings.v, {key, cmd, opt, desc or ""})
-- end

-- 设置Leader Key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local _M = {}
-- 
_M.mappings = {
    default = {}
}

local function init_plugin_mapping(plugin_name)
    if not _M.mappings[plugin_name] then
        _M.mappings[plugin_name] = {}
    end
    if not _M.mappings[plugin_name]["global"] then
        _M.mappings[plugin_name]["global"] = {}
    end
    if not _M.mappings[plugin_name]["local"] then
        _M.mappings[plugin_name]["local"] = {}
    end
end

_M.add_key = function(mode, key, cmd, desc)
    table.insert(_M.mappings.default, {mode, key, cmd, opt, desc or ""})
end
_M.add_plugin_key = function(name, mode, key, cmd, desc)
    init_plugin_mapping(name)
    table_insert(_M.mappings[name]["global"], {mode, key, cmd, opt, desc or ""})
end
_M.add_plugin_local_key = function(name, mapping)
    init_plugin_mapping(name)
    table_insert(_M.mappings[name]["local"], mapping)
end

_M.get_plugin_keys = function(name)
    return _M.mappings[name]["global"]
end
_M.get_plugin_local_keys = function(name)
    return _M.mappings[name]["local"]
end
--[[
        {global=[{}, {}, {}...], other_plugins={global=[{}, {}, ...], local=[...]}}
    ]]
_M.bind = function(plugin_name)
    local plugins
    if plugin_name == "default" then
        plugins = _M.mappings.default
    else
        plugins = _M.get_plugin_keys(plugin_name)
    end

    if plugins then
        print("设置[" .. plugin_name .. "]快捷键")
        for _, v in ipairs(plugins) do
            -- vim.pretty_print(v)
            -- vim.pretty_print(v[1])
            -- vim.pretty_print(type(v[2]))
            -- vim.pretty_print(type(v[3]))
            keymap(v[1], v[2], v[3], v[4])
            -- TODO: 生成按键映射表，方便查阅
        end
    end

    -- for k, v in pairs(_M.mappings) do
    --     vim.pretty_print(k)
    --     if k == "default" then
    --         for _, v in ipairs(v) do
    --             -- vim.pretty_print(v)
    --             -- vim.pretty_print(v[1])
    --             -- vim.pretty_print(type(v[2]))
    --             -- vim.pretty_print(type(v[3]))
    --             keymap(v[1], v[2], v[3], v[4])
    --             -- TODO: 生成按键映射表，方便查阅
    --         end
    --     else
    --         for k, v in pairs(v) do
    --             vim.pretty_print("设置[" .. k .. "]快捷键")
    --             if v.global then
    --                 for _, v in ipairs(v.global) do
    --                     keymap(v[1], v[2], v[3], v[4])
    --                     -- TODO: 生成按键映射表，方便查阅
    --                 end
    --             end

    --             -- TODO: 生成按键映射表，方便查阅
    --         end
    --     end

    -- end
end

-- 默认按键 =========================================================================
-- 取消 s 默认功能
_M.add_key("n", "s", "")
-- windows 分屏快捷键
_M.add_key("n", "sv", ":vsp<CR>", "垂直分屏")
_M.add_key("n", "sh", ":sp<CR>", "水平分屏")
-- 关闭当前窗口
_M.add_key("n", "sc", "<C-w>c", "关闭当前窗口")
-- 关闭其他窗口
_M.add_key("n", "so", "<C-w>o", "关闭其他窗口")
-- Alt + hjkl 窗口之间跳转
_M.add_key("n", "<A-h>", "<C-w>h", "跳转到右侧窗口")
_M.add_key("n", "<A-j>", "<C-w>j", "跳转到上方窗口")
_M.add_key("n", "<A-k>", "<C-w>k", "跳转到下方窗口")
_M.add_key("n", "<A-l>", "<C-w>l", "跳转到左侧窗口")

-- 左右比例控制
_M.add_key("n", "<C-Left>", ":vertical resize -2<CR>", "向左移动2个单位")
_M.add_key("n", "<C-Right>", ":vertical resize +2<CR>", "向右移动2个单位")
_M.add_key("n", "s,", ":vertical resize -20<CR>", "向左移动20个单位")
_M.add_key("n", "s.", ":vertical resize +20<CR>", "向右移动20个单位")
-- 上下比例
_M.add_key("n", "sj", ":resize +10<CR>", "向上移动10个单位")
_M.add_key("n", "sk", ":resize -10<CR>", "向下移动10个单位")
_M.add_key("n", "<C-Down>", ":resize +2<CR>", "向下移动10个单位")
_M.add_key("n", "<C-Up>", ":resize -2<CR>", "向上移动10个单位")
-- 等比例
_M.add_key("n", "s=", "<C-w>=", "等比例分割窗口")

-- Terminal相关
_M.add_key("n", "<leader>t", ":sp | terminal<CR>", "从下方打开终端")
_M.add_key("n", "<leader>vt", ":vsp | terminal<CR>", "从右侧打开终端")
_M.add_key("t", "<Esc>", "<C-\\><C-n>", "关闭终端")
_M.add_key("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], "opt")
_M.add_key("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], "opt")
_M.add_key("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], "opt")
_M.add_key("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], "opt")

-- visual模式下缩进代码
_M.add_key("v", "<", "<gv", "Visual:向左缩进代码")
_M.add_key("v", ">", ">gv", "Visual:向右缩进代码")
-- 上下移动选中文本
_M.add_key("v", "J", ":move '>+1<CR>gv-gv", "向上移动选中文本")
_M.add_key("v", "K", ":move '<-2<CR>gv-gv", "向下移动选中文本")

-- 上下滚动浏览
_M.add_key("n", "<C-j>", "4j", "向上滚动4行")
_M.add_key("n", "<C-k>", "4k", "向下滚动4行")
-- ctrl u / ctrl + d  只移动9行，默认移动半屏
_M.add_key("n", "<C-u>", "9k", "向上滚动9行")
_M.add_key("n", "<C-d>", "9j", "向下滚动9行")

-- 在visual 模式里粘贴不要复制
_M.add_key("v", "p", '"_dP', "Visual: 粘贴时不复制")

-- 退出
_M.add_key("n", "qq", ":q!<CR>", "退出")
_M.add_key("n", "Q", ":qa!<CR>", "退出")

-- insert 模式下，跳到行首行尾
_M.add_key("i", "<C-a>", "<ESC>I", "光标跳转到行首")
_M.add_key("i", "<C-e>", "<ESC>A", "光标跳转到行尾")

_M.bind("default")

return _M
