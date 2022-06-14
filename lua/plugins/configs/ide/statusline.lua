-- 资源管理器
local vim = vim
local notify = vim.notify
local cmd = vim.cmd

local base = require("core.plugin.base")

local _M = base.new {
    name = "lualine",
    desc = "状态条",
    github = "https://github.com/nvim-lualine/lualine.nvim",
    packer = {
        "nvim-lualine/lualine.nvim",
        requires = {"kyazdani42/nvim-web-devicons"},
        config = function()
            require("plugins.configs.ide.statusline"):config()
        end
    }
}

_M.setup = function(self, keymaps)
    self.plugin.setup({
        options = {
            theme = vim.g.options.theme,
            component_separators = {
                left = "|",
                right = "|"
            },
            -- https://github.com/ryanoasis/powerline-extra-symbols
            section_separators = {
                left = " ",
                right = ""
            }
        },
        extensions = {"nvim-tree", "toggleterm"},
        sections = {
            lualine_x = {"filesize", {
                "fileformat",
                symbols = {
                    unix = "LF",
                    dos = "CRLF",
                    mac = "CR"
                }
            }, "encoding", "filetype"}
        }
    })
end

return _M
