local vim = vim
local notify = vim.notify
local cmd = vim.cmd

local base = require("core.plugin.base")

local _M = base.new {
    name = "Comment",
    group = "IDE",
    desc = "注释",
    github = "https://github.com/numToStr/Comment.nvim",
    packer = {
        'numToStr/Comment.nvim',
        config = function()
            require("plugins.ide.comment"):config()
        end
    }
}

--[[

NORMAL mode
`gcc` - Toggles the current line using linewise comment
`gbc` - Toggles the current line using blockwise comment
`[count]gcc` - Toggles the number of line given as a prefix-count using linewise
`[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
`gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
`gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment
VISUAL mode
`gc` - Toggles the region using linewise comment
`gb` - Toggles the region using blockwise comment

Extra mappings
These mappings are enabled by default. (config: mappings.extra)

NORMAL mode
`gco` - Insert comment to the next line and enters INSERT mode
`gcO` - Insert comment to the previous line and enters INSERT mode
`gcA` - Insert comment to end of the current line and enters INSERT mode

Extended mappings
These mappings are disabled by default. (config: mappings.extended)

NORMAL mode
`g>[count]{motion}` - (Op-pending) Comments the region using linewise comment
`g>c` - Comments the current line using linewise comment
`g>b` - Comments the current line using blockwise comment
`g<[count]{motion}` - (Op-pending) Uncomments the region using linewise comment
`g<c` - Uncomments the current line using linewise comment
`g<b`- Uncomments the current line using blockwise comment
VISUAL mode
`g>` - Comments the region using single line
`g<` - Unomments the region using single line
Examples
# Linewise

`gcw` - Toggle from the current cursor position to the next word
`gc$` - Toggle from the current cursor position to the end of line
`gc}` - Toggle until the next blank line
`gc5j` - Toggle 5 lines after the current cursor position
`gc8k` - Toggle 8 lines before the current cursor position
`gcip` - Toggle inside of paragraph
`gca}` - Toggle around curly brackets

# Blockwise

`gb2}` - Toggle until the 2 next blank line
`gbaf` - Toggle comment around a function (w/ LSP/treesitter support)
`gbac` - Toggle comment around a class (w/ LSP/treesitter support)
--]]

-- _M.set_keymaps = function(self, keymaps)
--   keymaps.set(self.name, "n", "<leader>dd", ":Alpha<cr>", "[Dashboard] 显示Dashboard")
-- end

_M.setup = function(self)
    self.plugin.setup()
end

return _M
