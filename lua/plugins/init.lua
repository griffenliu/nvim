local plugins = {{
    "kyazdani42/nvim-tree.lua",
    name = "nvim-tree",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
        require "plugins.configs.nvim-tree"
    end
}}
return plugins
-- _G.PLUGINS.insert({
--     "kyazdani42/nvim-tree.lua",
--     name = "nvim-tree",
--     requires = "kyazdani42/nvim-web-devicons",
--     config = function()
--         require("plugins.configs.nvim-tree")
--     end
-- })
