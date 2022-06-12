-- 资源管理器
local vim = vim
local notify = vim.notify
local cmd = vim.cmd

local base = require("core.plugin.base")

local _M = {
  name = "cmp", -- require name
  desc = "补全",
  packer = {
    "hrsh7th/nvim-cmp",
    config = function()
      require("lsp.configs.cmp"):config()
    end
  },
  packer_ext = {
    -- snippet 引擎
    { "hrsh7th/vim-vsnip" },
    { "rafamadriz/friendly-snippets" }, -- 常见编程语言代码段
    -- 补全源
    { "hrsh7th/cmp-vsnip" },
    { "hrsh7th/cmp-nvim-lsp" }, -- { name = nvim_lsp }
    { "hrsh7th/cmp-buffer" }, -- { name = 'buffer' },
    { "hrsh7th/cmp-path" }, -- { name = 'path' }
    { "hrsh7th/cmp-cmdline" }, -- { name = 'cmdline' }
  }
}
setmetatable(_M, { __index = base })

local mappings = {}
_M.set_keymaps = function(self, keymaps)
  keymaps.set_custom(self.name, "n", "<A-.>", function(_cmp)
    return _cmp.mapping(_cmp.mapping.complete(), { "i", "c" })
  end, "出现补全")
  keymaps.set_custom(self.name, "n", "<A-,>", function(_cmp)
    return _cmp.mapping({
      i = _cmp.mapping.abort(),
      c = _cmp.mapping.close()
    })
  end, "取消")
  keymaps.set_custom(self.name, "n", "<C-k>", function(_cmp)
    return _cmp.mapping.select_prev_item()
  end, "上一个")
  keymaps.set_custom(self.name, "n", "<C-j>", function(_cmp)
    return _cmp.mapping.select_next_item()
  end, "下一个")
  keymaps.set_custom(self.name, "n", "<CR>", function(_cmp)
    return _cmp.mapping.confirm({
      select = true,
      behavior = _cmp.ConfirmBehavior.Replace
    })
  end, "确认")
  keymaps.set_custom(self.name, "n", "<C-u>", function(_cmp)
    return _cmp.mapping(_cmp.mapping.scroll_docs(-4), { "i", "c" })
  end, "向上滚动")
  keymaps.set_custom(self.name, "n", "<C-d>", function(_cmp)
    return _cmp.mapping(_cmp.mapping.scroll_docs(4), { "i", "c" })
  end, "向下滚动")

  keymaps.bind(self.name, function(key, _cmp, _mappings)
    _mappings[key[2]] = key[3](_cmp)
  end, self.plugin, mappings)
end

_M.plugin_setup = function(self, keymaps)
  self.plugin.setup({
    -- 指定 snippet 引擎
    snippet = {
      expand = function(args)
        -- For `vsnip` users.
        vim.fn["vsnip#anonymous"](args.body)

        -- For `luasnip` users.
        -- require('luasnip').lsp_expand(args.body)

        -- For `ultisnips` users.
        -- vim.fn["UltiSnips#Anon"](args.body)

        -- For `snippy` users.
        -- require'snippy'.expand_snippet(args.body)
      end,
    },
    -- 补全源
    sources = self.plugin.config.sources({
      { name = "nvim_lsp" },
      -- For vsnip users.
      { name = "vsnip" },

      -- For luasnip users.
      -- { name = 'luasnip' },

      --For ultisnips users.
      -- { name = 'ultisnips' },

      -- -- For snippy users.
      -- { name = 'snippy' },
    }, { { name = "buffer" }, { name = "path" } }),

    -- 快捷键设置
    mapping = mappings,
    -- 使用lspkind-nvim显示类型图标 (新增)
    formatting = require('lsp.configs.ui').formatting
  })

  -- / 查找模式使用 buffer 源
  self.plugin.setup.cmdline("/", {
    mapping = self.plugin.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  -- : 命令行模式中使用 path 和 cmdline 源.
  self.plugin.setup.cmdline(":", {
    mapping = self.plugin.mapping.preset.cmdline(),
    sources = self.plugin.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })
end

return _M

-- local function check(plugin_name)
--   local status, plugin = pcall(require, plugin_name)
--   if not status then
--     notify(plugin_name .. " not found!")
--     return false
--   end
--   return plugin
-- end

-- local set_keymaps
-- local function setup_keymaps(plugin_name, plugin)
--   if set_keymaps and type(set_keymaps) == "function" then
--     local keymaps = require("core.keymaps")
--     set_keymaps(plugin_name, keymaps, plugin)
--     keymaps.bind(plugin_name)
--   end
-- end

-- ============================================================================
-- 如果有快捷键需求，这一块才需要处理和定制
-- local mappings = {}
-- set_keymaps = function(plugin_name, keymaps, plugin)
--   keymaps.set_custom(plugin_name, "n", "<A-.>", function(_cmp)
--     return _cmp.mapping(_cmp.mapping.complete(), { "i", "c" })
--   end, "出现补全")
--   keymaps.set_custom(plugin_name, "n", "<A-,>", function(_cmp)
--     return _cmp.mapping({
--       i = _cmp.mapping.abort(),
--       c = _cmp.mapping.close()
--     })
--   end, "取消")
--   keymaps.set_custom(plugin_name, "n", "<C-k>", function(_cmp)
--     return _cmp.mapping.select_prev_item()
--   end, "上一个")
--   keymaps.set_custom(plugin_name, "n", "<C-j>", function(_cmp)
--     return _cmp.mapping.select_next_item()
--   end, "下一个")
--   keymaps.set_custom(plugin_name, "n", "<CR>", function(_cmp)
--     return _cmp.mapping.confirm({
--       select = true,
--       behavior = _cmp.ConfirmBehavior.Replace
--     })
--   end, "确认")
--   keymaps.set_custom(plugin_name, "n", "<C-u>", function(_cmp)
--     return _cmp.mapping(_cmp.mapping.scroll_docs(-4), { "i", "c" })
--   end, "向上滚动")
--   keymaps.set_custom(plugin_name, "n", "<C-d>", function(_cmp)
--     return _cmp.mapping(_cmp.mapping.scroll_docs(4), { "i", "c" })
--   end, "向下滚动")

--   keymaps.bind(plugin_name, function(key, _cmp, _mappings)
--     _mappings[key[2]] = key[3](_cmp)
--   end, plugin, mappings)
-- end

-- local _M = {
--   name = "cmp", -- require name
--   desc = "补全",
--   packer = {
--     "hrsh7th/nvim-cmp",
--     config = function()
--       require("lsp.cmp").config()
--     end
--   },
--   packer_ext = {
--     -- snippet 引擎
--     { "hrsh7th/vim-vsnip" },
--     { "rafamadriz/friendly-snippets" }, -- 常见编程语言代码段
--     -- 补全源
--     { "hrsh7th/cmp-vsnip" },
--     { "hrsh7th/cmp-nvim-lsp" }, -- { name = nvim_lsp }
--     { "hrsh7th/cmp-buffer" }, -- { name = 'buffer' },
--     { "hrsh7th/cmp-path" }, -- { name = 'path' }
--     { "hrsh7th/cmp-cmdline" }, -- { name = 'cmdline' }
--   },
--   after = { "nvim-lsp-installer", "lspkind-nvim" }
-- }

-- local function plugin_setup(plugin, plugin_name)
--   plugin.setup({
--     -- 指定 snippet 引擎
--     snippet = {
--       expand = function(args)
--         -- For `vsnip` users.
--         vim.fn["vsnip#anonymous"](args.body)

--         -- For `luasnip` users.
--         -- require('luasnip').lsp_expand(args.body)

--         -- For `ultisnips` users.
--         -- vim.fn["UltiSnips#Anon"](args.body)

--         -- For `snippy` users.
--         -- require'snippy'.expand_snippet(args.body)
--       end,
--     },
--     -- 补全源
--     sources = plugin.config.sources({
--       { name = "nvim_lsp" },
--       -- For vsnip users.
--       { name = "vsnip" },

--       -- For luasnip users.
--       -- { name = 'luasnip' },

--       --For ultisnips users.
--       -- { name = 'ultisnips' },

--       -- -- For snippy users.
--       -- { name = 'snippy' },
--     }, { { name = "buffer" }, { name = "path" } }),

--     -- 快捷键设置
--     mapping = mappings,
--     -- 使用lspkind-nvim显示类型图标 (新增)
--     formatting = require('lsp.ui').formatting
--   })

--   -- / 查找模式使用 buffer 源
--   plugin.setup.cmdline("/", {
--     mapping = plugin.mapping.preset.cmdline(),
--     sources = {
--       { name = "buffer" },
--     },
--   })

--   -- : 命令行模式中使用 path 和 cmdline 源.
--   plugin.setup.cmdline(":", {
--     mapping = plugin.mapping.preset.cmdline(),
--     sources = plugin.config.sources({
--       { name = "path" },
--     }, {
--       { name = "cmdline" },
--     }),
--   })
-- end

-- -- ============================================================================
-- _M.config = function()
--   local plugin_name = _M.name
--   local plugin = check(plugin_name)
--   if not plugin then return end
--   -- set key
--   setup_keymaps(plugin_name, plugin)
--   -- config
--   plugin_setup(plugin, plugin_name)
-- end

-- return _M
