local plugins = {
    -- 文件树
    ["nvim-tree"] = {
        "kyazdani42/nvim-tree.lua",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("plugins.configs.nvim-tree")
        end
    },
    -- 页签
    bufferline = {
        "akinsho/bufferline.nvim",
        requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" },
        config = function()
            require("plugins.configs.bufferline")
        end
    },
    -- 状态条
    lualine = { "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" },
        config = function()
            require("plugins.configs.lualine")
        end
    },
    ["lualine-lsp-progress"] = { "arkav/lualine-lsp-progress" },
    -- 文件搜索
    { 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("plugins.configs.telescope")
        end
    },
    ["telescope-env"] = { "LinArcX/telescope-env.nvim" },
    -- dashboard
    alpha = {
        'goolord/alpha-nvim',
        config = function()
            require("plugins.configs.alpha")
            -- require 'alpha'.setup(require 'alpha.themes.dashboardq'.config)
        end
    }
}
return plugins
