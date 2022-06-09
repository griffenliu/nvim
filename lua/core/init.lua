-- 基础配置
require("core.options")

-- _G.PLUGINS = {
--     data = {},
--     insert = function(plugin)
--         if not plugin.config then
--             plugin.config = function()
--                 vim.pretty_print(plugin)
--                 _G.PLUGINS[plugin.name] = nil
--                 plugin.loaded = true
--             end
--         else
--             if type(plugin.config) == "function" then
--                 plugin.config = function()
--                     vim.pretty_print(plugin)
--                     _G.PLUGINS[plugin.name] = nil
--                     plugin.config()
--                 end
--             else
--                 plugin.config = function()
--                     vim.pretty_print(plugin)
--                     _G.PLUGINS[plugin.name] = nil
--                     return plugin.config
--                 end
--             end
--         end
--         _G.PLUGINS.data[plugin.name] = plugin
--     end,
--     finished = function()
--         local count = 0
--         for _, p in pairs(_G.PLUGINS.data) do
--             count = count + 1
--         end
--         return count == 0
--     end
-- }

-- Packer包管理
-- 因为这里可能是异步的，所以要确保各个插件都加载和设置后再配置KEY
-- 这里设置一个回调函数
local packer = require("core.packer")
packer.bootstrap()

-- 按键映射配置
require("core.keymaps")

-- 主题配置
local colorscheme = "tokyonight"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end
