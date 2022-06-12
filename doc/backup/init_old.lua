-- TODO: 没有搞明白的是，这里每次都需要PackerSync一下才可以生效
local plugins = {
    -- 文件树
    ["nvim-tree"] = {
        "kyazdani42/nvim-tree.lua",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("plugins.configs.nvim-tree")
        end
    },
    -- 页签，不太需要这样的配置
    -- bufferline = {
    --     "akinsho/bufferline.nvim",
    --     requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" },
    --     config = function()
    --         require("plugins.configs.bufferline")
    --     end
    -- },
    -- 状态条
    lualine = { "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" },
        config = function()
            require("plugins.configs.statusbar_lualine")
        end
    },
    ["lualine-lsp-progress"] = { "arkav/lualine-lsp-progress" },
    -- 文件搜索
    { 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-file-browser.nvim" },
        config = function()
            require("plugins.configs.file_telescope")
        end
    },
    ["telescope-env"] = { "LinArcX/telescope-env.nvim" },
    -- dashboard
    alpha = {
        'goolord/alpha-nvim',
        config = function()
            require("plugins.configs.dashboard_alpha")
            -- require 'alpha'.setup(require 'alpha.themes.dashboardq'.config)
        end
    },
    -- 项目
    project = { "ahmedkhalf/project.nvim",
        config = function()
            require("plugins.configs.project")
        end
    },
    -- 显示作用域范围
    ["indent-blankline"] = { "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("plugins.configs.indent-blankline")
        end
    },
    -- [code]==========================================
    -- 代码高亮
    treesitter = { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate",
        config = function()
            require("plugins.configs.highlight_treesitter")
        end
    },
    -- LSP (Language Server Protocol)
    -- nvim-lsp-installer 近期更新了一个不兼容的改变，我们要锁定在指定的 commit 中
    lspconfig = { "neovim/nvim-lspconfig" },
    ["lsp-installer"] = { "williamboman/nvim-lsp-installer", commit = "36b44679f7cc73968dbb3b09246798a19f7c14e0",
        config = function()
            require("lsp")
        end
    },
    --[补全]=================================================
    -- 补全引擎
    ["nvim-cmp"] = { "hrsh7th/nvim-cmp" },
    -- snippet 引擎
    ["vim-vsnip"] = { "hrsh7th/vim-vsnip" },
    -- 补全源
    ["cmp-vsnip"] = { "hrsh7th/cmp-vsnip" },
    ["cmp-nvim-lsp"] = { "hrsh7th/cmp-nvim-lsp" }, -- { name = nvim_lsp }
    ["cmp-buffer"] = { "hrsh7th/cmp-buffer" }, -- { name = 'buffer' },
    ["cmp-path"] = { "hrsh7th/cmp-path" }, -- { name = 'path' }
    ["cmp-cmdline"] = { "hrsh7th/cmp-cmdline" }, -- { name = 'cmdline' }
    -- 常见编程语言代码段
    ["friendly-snippets"] = { "rafamadriz/friendly-snippets" },
    -- lsp ui
    ["lspkind-nvim"] = { "onsails/lspkind-nvim" },

    -- 代码格式化
    -- formatter = { "mhartington/formatter.nvim" },
    ["null-ls"] = { "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" },

    -- 语言
    -- rust 增强
    ["rust-tools"] = { "simrat39/rust-tools.nvim" },
    -- [工具] ========================================================
    -- 类似于emacs的org mode，可以使用tag固定版本
    ["neorg"] = { "nvim-neorg/neorg", requires = "nvim-lua/plenary.nvim", tag = "*",
        -- 异步加载
        ft = "norg",
        after = { "nvim-treesitter", "telescope.nvim" }, -- You may want to specify Telescope here as well
        config = function()
            require('neorg').setup {
                require("plugins.configs.neorg")
            }
        end
    }
}
return plugins
