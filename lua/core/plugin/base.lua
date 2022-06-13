local vim = vim
local notify = vim.notify
local cmd = vim.cmd

local _M = {
  name = "default", -- require name(可以定义一个扩展名称，以便在不同的插件下使用)
  desc = "default",
  packer = {},
  -- ext_name = "",
}

_M.check = function(self)
  local status, plugin = pcall(require, self.name .. (self.ext_name or ""))
  if not status then
    notify(self.name .. " not found!")
    return false
  end
  self.plugin = plugin
  return true
end

_M.keymaps_setup = function(self)
  local keymaps = require("core.keymaps")
  self:set_keymaps(keymaps)
  keymaps.bind(self.name)
  return keymaps
end

_M.set_keymaps = function(self, keymaps)
  -- do nothing...
end

_M.plugin_setup = function(self, keymaps)
  -- self.plugin.setup({ ... })
end

-- string or []
_M.after = function(self, after)
  self.packer.after = after
  return self
end

-- ============================================================================
_M.config = function(self)
  local is_loaded = self:check()
  -- vim.notify("config " .. (self.desc or "") .. " " .. self.name)
  print("config " .. (self.desc or "") .. " " .. self.name)
  if not is_loaded then return end
  -- set key
  local keymaps = self:keymaps_setup()
  -- config
  self:plugin_setup(keymaps)
end

return _M
