-- 资源管理器
local vim = vim
local notify = vim.notify
local cmd = vim.cmd

local base = require("core.plugin.base")

local _M = {
  name = "nvim-tree",
  desc = "导航树", -- 资源管理器
  packer = {
    "kyazdani42/nvim-tree.lua",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("plugins.configs.explorer"):config()
    end
  },
}
setmetatable(_M, { __index = base })

_M.set_keymaps = function(self, keymaps)
  keymaps.set(self.name, "n", "<leader>`", "<cmd> NvimTreeToggle <CR>", "[文件树] 打开或关闭文件树")
  keymaps.set(self.name, "n", "<A-`>", "<cmd> NvimTreeFocus <CR>", "[文件树] 聚焦文件树")
  -- 默认的快捷键就很好，可以使用 g? 查看
  keymaps.set_local(self.name, {
    key = "#",
    action = "print_path",
    action_cb = function(node)
      print(node.absolute_path)
    end,
    desc = "使用资源管理器打开"
  })
end

_M.plugin_setup = function(self, keymaps)
  local local_mappings = keymaps.get_local_keys(self.name)
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
      custom = { 'node_modules' }
    },
    view = {
      -- 宽度
      width = 40,
      -- 也可以 'right'
      side = 'left',
      -- 隐藏根目录
      hide_root_folder = false,
      -- 自定义列表中快捷键
      mappings = {
        custom_only = false,
        list = local_mappings
      },
      -- 不显示行数
      number = false,
      relativenumber = false,
      -- 显示图标
      signcolumn = 'yes'
    },
    actions = {
      open_file = {
        -- 首次打开大小适配
        resize_window = true,
        -- 打开文件时关闭
        quit_on_open = true
      }
    }
    -- wsl install -g wsl-open
    -- https://github.com/4U6U57/wsl-open/
    -- system_open = {
    --     cmd = 'wsl-open' -- mac 直接设置为 open
    -- }
  })
  -- 自动关闭
  vim.cmd([[
      autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
    ]])
end

return _M
