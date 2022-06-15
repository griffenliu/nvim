local vim = vim
local notify = vim.notify
local cmd = vim.cmd
local string_find = string.find
local string_sub = string.sub
local table_new = require("table.new")
-- require("table.nkeys")
-- require("table.clear")
-- require("table.clone")
-- require("table.isarray")
local tabler_insert = table.insert
-- table.concat
-- table.sort

local plugin_loader = require("core.plugins")

-- pakcer会截取 `/` 后面的作为after的KEY
local function get_packer_key(packer_name)
    local idx_start, idx_end = string_find(packer_name, "/", 1, true)
    if idx_end then
        return string_sub(packer_name, idx_end + 1)
    end
    return packer_name
end

local _M = {
    name = "default", -- require name(可以定义一个扩展名称，以便在不同的插件下使用)
    desc = "default",
    auto_load = true,
    packer = {}
    -- ext_name = "",   -- 有些插件加载的package名称和其插件名称是不同的，此时可以使用这个进行扩展
}

_M.new = function(def)
    local p = setmetatable(def, {
        __index = _M
    })
    plugin_loader.add(p)
    return p
end

_M.load = function(self)
    local status, plugin = pcall(require, self.name .. (self.ext_name or ""))
    if not status then
        notify(self.name .. " not found!")
        return false
    end
    self.plugin = plugin
    return true
end

-- _M.keymaps_setup = function(self)
--     local keymaps = require("core.keymaps")
--     self:set_keymaps(keymaps)
--     keymaps.bind(self.name)
--     return keymaps
-- end

-- _M.set_keymaps = function(self, keymaps)
--     -- do nothing...
-- end

_M.setup = function(self)
    -- self.plugin.setup({ ... })
end

-- plugin...
_M.after = function(self, ...)
    -- 解析名称
    local len = select('#', ...)
    local keys = table_new(len, 0)
    for i = 1, len do
        local p = select(i, ...)
        local key = get_packer_key(p.packer[1])
        tabler_insert(keys, key)
    end
    self.packer.after = keys
    print(self.name .. " after=" .. vim.inspect(keys))
    return self
end

-- ============================================================================
_M.config = function(self)
    local is_loaded = false
    if self.auto_load then
        is_loaded = self:load()
    end
    -- vim.notify("config " .. (self.desc or "") .. " " .. self.name)
    print("config " .. (self.desc or "") .. " " .. self.name)
    if not is_loaded then
        return
    end
    -- -- set key
    -- local keymaps = self:keymaps_setup()
    -- config
    self:setup()
end

return _M
