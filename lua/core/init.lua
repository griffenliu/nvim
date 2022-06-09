-- 基础配置
require("core.options")

-- Packer包管理
-- 因为这里可能是异步的，所以要确保各个插件都加载和设置后再配置KEY
-- 这里设置一个回调函数
local packer = require("core.packer")
packer.bootstrap()

-- 按键映射配置
require("core.keymaps")

-- 主题配置
-- tokyonight; onedark; OceanicNext; gruvbox; nord; nightfox;
local colorscheme = "tokyonight"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end
