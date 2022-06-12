local vim = vim
local table_insert = table.insert
local keymap = vim.api.nvim_set_keymap
local buf_keymap = vim.api.nvim_buf_set_keymap


local _M = {
    leader_key = " ",
}

_M.mappings = {
    default = { global = {} }
}

local function init_plugin_mapping(plugin_name, target)
    if not _M.mappings[plugin_name] then
        _M.mappings[plugin_name] = {}
    end
    if not _M.mappings[plugin_name][target] then
        _M.mappings[plugin_name][target] = {}
    end
end

local function set_keymap(name, target, mode, key, cmd, desc)
    init_plugin_mapping(name, target)
    if target == "local" then
        table_insert(_M.mappings[name][target], mode)
    else
        -- 添加自定义标记
        table_insert(_M.mappings[name][target], { mode, key, cmd, {
            noremap = true,
            silent = true,
            desc = "@C " .. (desc or "")
        } })
    end
end

-- 设置内部
local set = function(mode, key, cmd, desc)
    _M.set("default", mode, key, cmd, desc)
end
-- 设置插件
_M.set = function(name, mode, key, cmd, desc)
    set_keymap(name, "global", mode, key, cmd, desc)
end
-- 设置本地快捷键(用于返回结果给设置使用)
_M.set_local = function(name, mapping)
    set_keymap(name, "local", mapping)
end
-- 设置缓冲区特定快捷键(绑定执行时要指定缓冲区才能正常使用)
_M.set_buffer = function(name, mode, key, cmd, desc)
    set_keymap(name, "buffer", mode, key, cmd, desc)
end
-- 设置自定义快捷按键（绑定时第二个参数是一个函数，由配置自行处理绑定方式）
_M.set_custom = function(name, mode, key, cmd, desc)
    set_keymap(name, "custom", mode, key, cmd, desc)
end


_M.get_keys = function(name)
    return _M.mappings[name] and _M.mappings[name]["global"]
end

_M.get_local_keys = function(name)
    return _M.mappings[name] and _M.mappings[name]["local"]
end

_M.get_buffer_keys = function(name)
    return _M.mappings[name] and _M.mappings[name]["buffer"]
end

_M.get_custom_keys = function(name)
    return _M.mappings[name] and _M.mappings[name]["custom"]
end
--[[
    {global=[{}, {}, {}...], other_plugins={global=[{}, {}, ...], local=[...]}}
]]

_M.bind = function(plugin_name, bind_buffer, ...)
    plugin_name = plugin_name or "default"
    local plugins
    if bind_buffer then
        if type(bind_buffer) == "function" then
            -- 由插件配置自定义的绑定方式
            plugins = _M.get_custom_keys(plugin_name)
        else
            -- 默认为buffer按键设置
            plugins = _M.get_buffer_keys(plugin_name)
        end
    else
        plugins = _M.get_keys(plugin_name)
    end

    -- TODO: 生成按键映射表，方便查阅
    if plugins then
        -- print("设置[" .. plugin_name .. "]快捷键")
        for _, v in ipairs(plugins) do
            if bind_buffer then
                if type(bind_buffer) == "function" then
                    bind_buffer(v, ...)
                else
                    buf_keymap(bind_buffer, v[1], v[2], v[3], v[4])
                end
            else
                keymap(v[1], v[2], v[3], v[4])
            end
        end
    end
end

_M.setup = function()
    -- 默认按键 =========================================================================
    vim.g.mapleader = _M.leader_key
    vim.g.maplocalleader = _M.leader_key
    -- 窗口操作 =========================================
    -- TODO: 插件对象增加分类，可以直接标记到描述里面
    -- {name: "", key: "", cat: "",...}

    -- windows 分屏快捷键
    set("n", "wv", ":vsp<CR>", "[窗口] 垂直分屏")
    set("n", "wh", ":sp<CR>", "[窗口] 水平分屏")
    -- set("n", "<C-=>", ":sp<CR> :vsp<CR>", "四分屏")
    -- 关闭当前窗口
    set("n", "wc", ":close<CR>", "[窗口] 关闭当前窗口")
    -- 关闭其他窗口
    set("n", "wo", ":only<CR>", "[窗口] 关闭其他窗口")

    -- 等比例
    set("n", "ww", "<C-w>=", "[窗口] 等比例分割窗口")
    -- 左右比例控制
    set("n", "<C-h>", ":vertical resize +2<CR>", "[窗口] 向左移动2个单位")
    set("n", "<C-l>", ":vertical resize -2<CR>", "[窗口] 向右移动2个单位")
    set("n", "<C-j>", ":resize +2<CR>", "[窗口] 向上移动2个单位")
    set("n", "<C-k>", ":resize -2<CR>", "[窗口] 向下移动2个单位")
    set("n", "<C-Left>", ":vertical resize +10<CR>", "[窗口] 向左移动10个单位")
    set("n", "<C-Right>", ":vertical resize -10<CR>", "[窗口] 向右移动10个单位")
    set("n", "<C-Down>", ":resize -10<CR>", "[窗口] 向下移动10个单位")
    set("n", "<C-Up>", ":resize +10<CR>", "[窗口] 向上移动10个单位")
    -- 缓冲区维护 =========================================
    set("n", "<leader>bd", ":bd<cr>", "[缓冲] 删除当前缓冲区") -- delete current buffer
    set("n", "<leader>bn", ":bn<cr>", "[缓冲] 下一个缓冲区") -- goto next buffer
    set("n", "<leader>bp", ":bp<cr>", "[缓冲] 上一个缓冲区") -- goto previous buffer
    set("n", "<leader>bad", ":%bd<cr>", "[缓冲] 删除所有缓冲区") -- delete all buffers
    -- Terminal相关 =========================================
    set("n", "<leader>tt", ":sp | terminal<CR>", "[终端] 从下方打开终端")
    set("n", "<leader>tv", ":vsp | terminal<CR>", "[终端] 从右侧打开终端")
    set("t", "<Esc>", "<C-\\><C-n>", "[终端] 关闭终端")
    set("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], "[终端] 需要测试opt")
    set("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], "[终端] 需要测试opt")
    set("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], "[终端] 需要测试opt")
    set("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], "[终端] 需要测试opt")
    -- 编辑操作 =========================================
    set("n", "<C-s>", "<cmd> w <CR>", "[编辑] 保存文件")
    set("n", "<C-c>", "<cmd> %y+ <CR>", "[编辑] 复制整个文件")
    -- visual模式下缩进代码
    set("v", "<", "<gv", "[编辑] 向左缩进代码")
    set("v", ">", ">gv", "[编辑] 向右缩进代码")
    -- 上下移动选中文本
    set("v", "J", ":move '>+1<CR>gv-gv", "[编辑] 向上移动选中文本")
    set("v", "K", ":move '<-2<CR>gv-gv", "[编辑] 向下移动选中文本")

    -- Insert 模式快捷键 =================================
    set("i", "<C-a>", "<ESC>I", "[编辑] 光标跳转到行首") -- <ESC>^i
    set("i", "<C-e>", "<ESC>A", "[编辑] 光标跳转到行尾") -- <End>

    set("i", "<C-f>", "<Right>", "[编辑] 光标向右移动")
    set("i", "<C-b>", "<Left>", "[编辑] 光标向左移动")
    set("i", "<C-n>", "<Down>", "[编辑] 光标向下移动")
    set("i", "<C-p>", "<Up>", "[编辑] 光标向上移动")

    -- 占用快捷键，4k，也是很方便的
    -- -- 上下滚动浏览
    -- set("n", "<C-j>", "4j", "向上滚动4行")
    -- set("n", "<C-k>", "4k", "向下滚动4行")
    -- -- ctrl u / ctrl + d  只移动9行，默认移动半屏
    -- set("n", "<C-u>", "9k", "向上滚动9行")
    -- set("n", "<C-d>", "9j", "向下滚动9行")

    -- 在visual 模式里粘贴不要复制
    --set("v", "p", '"_dP', "Visual: 粘贴时不复制")

    -- 编辑器 =========================================
    set("n", "mm", ":messages<CR>", "[Editor] 显示消息")
    set("n", "<f5>", ":PackerSync<CR>", "[Editor] 显示消息")
    set("n", "q", ":q<CR>", "[Editor] 退出")
    set("n", "qq", ":q!<CR>", "[Editor] 退出")
    set("n", "Q", ":qa!<CR>", "[Editor] 退出")

    _M.bind()
end

return _M
