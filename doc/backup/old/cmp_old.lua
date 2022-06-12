local plugin_name = "cmp"
local status, cmp = pcall(require, plugin_name)
if not status then
  vim.notify(plugin_name .. " not found!")
  return
end

-- 按键绑定
local keymaps = require("core.keymaps")
keymaps.set_custom(plugin_name, "n", "<A-.>", function(_cmp)
  return _cmp.mapping(_cmp.mapping.complete(), { "i", "c" })
end, "出现补全")
keymaps.set_custom(plugin_name, "n", "<A-,>", function(_cmp)
  return _cmp.mapping({
    i = _cmp.mapping.abort(),
    c = _cmp.mapping.close()
  })
end, "取消")
keymaps.set_custom(plugin_name, "n", "<C-k>", function(_cmp)
  return _cmp.mapping.select_prev_item()
end, "上一个")
keymaps.set_custom(plugin_name, "n", "<C-j>", function(_cmp)
  return _cmp.mapping.select_next_item()
end, "下一个")
keymaps.set_custom(plugin_name, "n", "<CR>", function(_cmp)
  return _cmp.mapping.confirm({
    select = true,
    behavior = _cmp.ConfirmBehavior.Replace
  })
end, "确认")
keymaps.set_custom(plugin_name, "n", "<C-u>", function(_cmp)
  return _cmp.mapping(_cmp.mapping.scroll_docs(-4), { "i", "c" })
end, "向上滚动")
keymaps.set_custom(plugin_name, "n", "<C-d>", function(_cmp)
  return _cmp.mapping(_cmp.mapping.scroll_docs(4), { "i", "c" })
end, "向下滚动")

local mappings = {}
keymaps.bind(plugin_name, function(key, _cmp, _mappings)
  _mappings[key[2]] = key[3](_cmp)
end, cmp, mappings)


cmp.setup({
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
  sources = cmp.config.sources({
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
  formatting = require('lsp.ui').formatting
})

-- / 查找模式使用 buffer 源
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- : 命令行模式中使用 path 和 cmdline 源.
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
