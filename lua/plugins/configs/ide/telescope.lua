-- 资源管理器
local vim = vim
local notify = vim.notify
local cmd = vim.cmd

local base = require("core.plugin.base")

local _M = base.new {
    name = "telescope", -- require name
    desc = "[IDE]搜索",
    github = "https://github.com/nvim-telescope/telescope.nvim",
    packer = {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function()
            require("plugins.configs.ide.telescope"):config()
        end
    },
    packer_ext = { { "LinArcX/telescope-env.nvim" } }
}

_M.set_keymaps = function(self, keymaps)
    local wk = require("which-key")
    wk.register({
        ["<leader>f"] = {
            name = "+文件",
            n = { "<cmd>enew<cr>", "创建文件" },
            f = { "<cmd>Telescope find_files<cr>", "查找文件" },
            r = { "<cmd>Telescope oldfiles<cr>", "打开最近文件" },
            g = { "<cmd>Telescope live_grep<cr>", "查找指定字符串" },
            s = { "<cmd>Telescope grep_string<cr>", "查找光标位置的字符串" },
            c = { "<cmd>Telescope commands<cr>", "查找Nvim命令" },
            h = { "<cmd>Telescope help_tags<cr>", "查找帮助" },
            k = { "<cmd>Telescope keymaps<cr>", "查找快捷键" },
            e = { "<cmd>Telescope env<cr>", "查找环境变量" },
            p = { "<cmd>Telescope projects<cr>", "项目列表" }
        },
        ["<leader>b"] = {
            name = "+buffer",
            b = { "<cmd>Telescope buffers<cr>", "打开文件列表" }
            -- a = {"<cmd>Telescope projects<cr>", "项目列表"}
        }
    })
    -- keymaps.set(self.name, "n", "<leader>ff", ":Telescope find_files<CR>", "[文件] 查找文件")
    -- keymaps.set(self.name, "n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "[文件] 查找所有文件")

    -- keymaps.set(self.name, "n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", "[文件] 在当前工作目录查找指定字符串")
    -- keymaps.set(self.name, "n", "<leader>fs", "<cmd>lua require('telescope.builtin').grep_string()<cr>", "[文件] 在当前工作目录查找光标位置的字符串")
    -- keymaps.set(self.name, "n", "<leader>fc", "<cmd>lua require('telescope.builtin').commands()<cr>", "[文件] 列出有效的命令")
    -- keymaps.set(self.name, "n", "<leader>fh", "<cmd> Telescope help_tags <CR>", "[文件] 帮助页面")
    -- keymaps.set(self.name, "n", "<leader>fk", "<cmd> Telescope keymaps <CR>", "[文件] 查找快捷键")
    -- keymaps.set(self.name, "n", "<leader>fe", "<cmd> Telescope env <CR>", "[文件] 环境变量列表")
    -- keymaps.set(self.name, "n", "<leader>bb", "<cmd>lua require('telescope.builtin').buffers()<cr>", "[文件] 查找文件缓冲")
    -- keymaps.set(self.name, "n", "<leader>ba", "<cmd>lua require('telescope.builtin').buffers()<cr>", "[文件] 查找所有文件缓冲")
end

_M.setup = function(self, keymaps)
    -- TODO: 这个应该全局定义，这里使用
    local file_ignore_patterns = { ".git", "node_modules" }
    -- local mappings = require("core.keymaps").get_local_keys(self.name)[0]
    local actions = require("telescope.actions")
    self.plugin.setup({
        defaults = {
            file_ignore_patterns = file_ignore_patterns,
            -- 窗口内快捷键
            mappings = {
                i = {
                    --     -- 按一次ESC就可以退出
                    --     ["<esc>"] = actions.close,
                    ["<A- "] = actions.close
                }
            }
        }
    })

    -- telescope extensions
    pcall(self.plugin.load_extension, "env")
    pcall(self.plugin.load_extension, "projects")
end

return _M
