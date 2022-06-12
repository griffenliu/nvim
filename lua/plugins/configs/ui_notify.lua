local vim = vim
local notify = vim.notify
local cmd = vim.cmd

-- TODO：需要自定义一个排序功能，在注册到packer时进行排序，因为目前packer只支持一个after，编写起来不太方便

local base = require("core.plugin.base")

local _M = {
  name = "notify",
  desc = "UI 通知",
  packer = {
    'rcarriga/nvim-notify',
    config = function()
      require("plugins.configs.ui_notify"):config()
    end
  }
}
setmetatable(_M, { __index = base })


_M.set_keymaps = function(self, keymaps)
  keymaps.set(self.name, "n", "<leader>dd", ":Alpha<cr>", "[Dashboard] 显示Dashboard")
end

_M.plugin_setup = function(self, keymaps)
  -- 替换默认的通知，因为这个，所以这个插件要非常靠前，这里将其排序定义为1
  vim.notify = self.plugin
end

return _M
