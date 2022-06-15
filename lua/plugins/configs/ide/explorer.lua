-- 资源管理器
local vim = vim
local notify = vim.notify
local cmd = vim.cmd
local api = vim.api

local base = require("core.plugin.base")

local _M = base.new {
    name = "nvim-tree",
    desc = "[IDE]导航树", -- 资源管理器
    github = "https://github.com/kyazdani42/nvim-tree.lua",
    packer = {
        "kyazdani42/nvim-tree.lua",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("plugins.configs.ide.explorer"):config()
        end
    }
}

-- _M.set_keymaps = function(self, keymaps)
--     keymaps.set(self.name, "n", "<leader>`", "<cmd> NvimTreeToggle <CR>", "[文件树] 打开或关闭文件树")
--     keymaps.set(self.name, "n", "<A-`>", "<cmd> NvimTreeFocus <CR>", "[文件树] 聚焦文件树")
-- end

_M.setup = function(self)
    -- local local_mappings = keymaps.get_local_keys(self.name)
    -- TODO: 这里要判断一下，如果已经安装过了，则不要再次安装，否则会报警告信息
    self.plugin.setup({
        -- 不显示 git 状态图标
        git = {
            enable = false
        },
        -- project plugin 需要这样设置
        update_cwd = true,
        update_focused_file = {
            enable = true,
            update_cwd = true
        },
        -- 隐藏 .文件 和 node_modules 文件夹
        filters = {
            dotfiles = true,
            custom = {'node_modules'}
        }
    })

    local view = require "nvim-tree.view"
    local function has_focus()
        local tabpage = api.nvim_get_current_tabpage()
        local tree_winnr = view.get_winnr(tabpage)
        local curr_winnr = api.nvim_get_current_win()
        return curr_winnr == tree_winnr
    end

    -- 实现效果：
    -- 失去焦点，自动关闭
    -- 在没有焦点时，则获得焦点
    -- 点击快捷键，如果没打开，则自动打开，如果打开，则关闭
    local function toggle_explorer()
        if view.is_visible() then
            if has_focus() then
                -- 关闭
                view.close()
            else
                view.focus()
            end
        else
            _M.plugin.toggle(true, false)
        end
    end

    -- 失去焦点自动关闭
    local function autocmd_onblur_close()
        if not has_focus() then
            view.close()
        end
    end
    -- 使用autogroup包装起来，避免多次执行？
    -- 注册自动命令和自动命令
    api.nvim_create_user_command("ToggleExplorer", toggle_explorer, {})
end

return _M
