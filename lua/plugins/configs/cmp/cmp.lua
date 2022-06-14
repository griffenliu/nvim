-- local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd

local base = require("core.plugin.base")

local _M = base.new {
  name = "cmp", -- require name
  desc = "[补全]引擎",
  packer = {
    "hrsh7th/nvim-cmp",
    config = function()
      require("plugins.configs.cmp.cmp"):config()
    end
  }
}
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

_M.setup = function(self, keymaps)

  local config = {
    -- 指定 snippet 引擎
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end
    },
    -- 补全源
    sources = self.plugin.config.sources(
      {
        { name = "nvim_lsp" },
        { name = 'luasnip' },
      },
      {
        { name = "buffer" },
        { name = "path" },
        { name = 'nvim_lua' }
      }
    ),

    -- 快捷键设置
    mapping = mappings,
  }

  local ok, lspkind = pcall(require, "lspkind")
  if ok then
    -- 使用lspkind-nvim显示类型图标
    config.formatting = {
      format = lspkind.cmp_format({
        mode = 'symbol_text',
        --mode = 'symbol', -- show only symbol annotations
        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        -- The function below will be called before any actual modifications from lspkind
        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
        before = function(entry, vim_item)
          -- Source 显示提示来源
          vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
          return vim_item
        end
      })
    }
  end

  self.plugin.setup(config)

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

  -- Setup lspconfig.
  -- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  -- -- TODO: 这里还未搞明白，多半是直接设置成null-ls就行了
  -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
  --   capabilities = capabilities
  -- }
end

return _M
