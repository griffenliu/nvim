local vim = vim
local cmd = vim.cmd
local notify = vim.notify

local _M = {
    themes = {
        tokyonight = "themes.configs.tokyonight",
        onedark = "themes.configs.onedark",
        gruvbox = "themes.configs.gruvbox",
        nightfox = "themes.configs.nightfox",
        nord = "themes.configs.nord"
    }
}

_M.setup = function()
    local plugins = require("core.plugins")
    for k, path in pairs(_M.themes) do
        if k == vim.g.options.theme then
            local config = require(path)
            local raw_setup = config.plugin_setup
            config.plugin_setup = function(self, keymaps)
                raw_setup(self, keymaps)
                -- 设置主题
                cmd("colorscheme " .. vim.g.options.theme)
            end
            plugins.add(config:after({ "nvim-notify" }))
            break
        end
    end

end

-- -- tokyonight; onedark; gruvbox; nord; nightfox;
-- _M.use = function(name)
--     local status_ok, _ = pcall(cmd, "colorscheme " .. name)
--     if not status_ok then
--         notify("colorscheme[" .. name .. "] not found!")
--         return
--     end
-- end

return _M
