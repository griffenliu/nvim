local plugin_name = "bufferline"

local status, bufferline = pcall(require, plugin_name)
if not status then
  vim.notify(plugin_name .. " not found!")
  return
end

local keymaps = require("core.keymaps")

-- bufferline
-- 左右Tab切换
keymaps.set(plugin_name, "n", "<A-h>", ":BufferLineCyclePrev<CR>", "向左切换Tab")
keymaps.set(plugin_name, "n", "<C-l>", ":BufferLineCycleNext<CR>", "向右切换Tab")
-- 关闭
--"moll/vim-bbye"
keymaps.set(plugin_name, "n", "<C-w>", ":Bdelete!<CR>", "关闭Tab")
keymaps.set(plugin_name, "n", "<leader>bl", ":BufferLineCloseRight<CR>", "关闭右侧Tab")
keymaps.set(plugin_name, "n", "<leader>bh", ":BufferLineCloseLeft<CR>", "关闭左侧Tab")
keymaps.set(plugin_name, "n", "<leader>bc", ":BufferLinePickClose<CR>", "关闭当前Tab")
keymaps.bind(plugin_name)
-- bufferline 配置
-- https://github.com/akinsho/bufferline.nvim#configuration
bufferline.setup({
  options = {
    -- 关闭 Tab 的命令，这里使用 moll/vim-bbye 的 :Bdelete 命令
    close_command = "Bdelete! %d",
    right_mouse_command = "Bdelete! %d",
    -- 侧边栏配置
    -- 左侧让出 nvim-tree 的位置，显示文字 File Explorer
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
      },
    },
    -- 使用 nvim 内置 LSP  后续课程会配置
    diagnostics = "nvim_lsp",
    -- 可选，显示 LSP 报错图标
    ---@diagnostic disable-next-line: unused-local
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " " or (e == "warning" and " " or "")
        s = s .. n .. sym
      end
      return s
    end,
  },
})
