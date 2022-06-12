-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "C:\\Users\\lgf\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?.lua;C:\\Users\\lgf\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?\\init.lua;C:\\Users\\lgf\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?.lua;C:\\Users\\lgf\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?\\init.lua"
local install_cpath_pattern = "C:\\Users\\lgf\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\lua\\5.1\\?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    after_files = { "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\opt\\Comment.nvim\\after\\plugin\\Comment.lua" },
    config = { "\27LJ\2\nO\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig!plugins.configs.code_comment\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\opt\\Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["alpha-nvim"] = {
    config = { "\27LJ\2\nL\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\30plugins.configs.dashboard\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\opt\\alpha-nvim",
    url = "https://github.com/goolord/alpha-nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\start\\cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\start\\cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\start\\cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\start\\cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-vsnip"] = {
    loaded = true,
    path = "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\start\\cmp-vsnip",
    url = "https://github.com/hrsh7th/cmp-vsnip"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\start\\friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\nP\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\"plugins.configs.ui_code_scope\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\opt\\indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lspkind-nvim"] = {
    after = { "nvim-cmp" },
    config = { "\27LJ\2\nA\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\19lsp.configs.ui\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\opt\\lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lualine-lsp-progress"] = {
    loaded = true,
    path = "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\start\\lualine-lsp-progress",
    url = "https://github.com/arkav/lualine-lsp-progress"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\nO\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig!plugins.configs.ui_statusbar\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\opt\\lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["nightfox.nvim"] = {
    config = { "\27LJ\2\nJ\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\28themes.configs.nightfox\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\opt\\nightfox.nvim",
    url = "https://github.com/EdenEast/nightfox.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\nO\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig!plugins.configs.ui_autopairs\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\opt\\nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\nB\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\20lsp.configs.cmp\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\opt\\nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lsp-installer"] = {
    after = { "nvim-cmp" },
    config = { "\27LJ\2\nH\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\26lsp.configs.installer\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\opt\\nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\start\\nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    after = { "nvim-cmp", "alpha-nvim", "nvim-tree.lua", "telescope.nvim", "nvim-treesitter", "nvim-lsp-installer", "lualine.nvim", "nvim-autopairs", "lspkind-nvim", "Comment.nvim", "nightfox.nvim", "indent-blankline.nvim" },
    loaded = true,
    only_config = true
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\nK\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\29plugins.configs.explorer\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\opt\\nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nQ\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig#plugins.configs.code_highlight\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\opt\\nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\start\\nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\start\\packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\start\\plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["rust-tools.nvim"] = {
    loaded = true,
    path = "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\start\\rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["telescope-env.nvim"] = {
    loaded = true,
    path = "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\start\\telescope-env.nvim",
    url = "https://github.com/LinArcX/telescope-env.nvim"
  },
  ["telescope-file-browser.nvim"] = {
    loaded = true,
    path = "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\start\\telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\nI\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\27plugins.configs.finder\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = true,
    path = "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\opt\\telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "D:\\software\\nvim-win64\\config\\nvim-data\\site\\pack\\packer\\start\\vim-vsnip",
    url = "https://github.com/hrsh7th/vim-vsnip"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-notify
time([[Config for nvim-notify]], true)
try_loadstring("\27LJ\2\nL\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\30plugins.configs.ui_notify\frequire\0", "config", "nvim-notify")
time([[Config for nvim-notify]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd lspkind-nvim ]]

-- Config for: lspkind-nvim
try_loadstring("\27LJ\2\nA\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\19lsp.configs.ui\frequire\0", "config", "lspkind-nvim")

vim.cmd [[ packadd nvim-lsp-installer ]]

-- Config for: nvim-lsp-installer
try_loadstring("\27LJ\2\nH\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\26lsp.configs.installer\frequire\0", "config", "nvim-lsp-installer")

vim.cmd [[ packadd nvim-cmp ]]

-- Config for: nvim-cmp
try_loadstring("\27LJ\2\nB\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\20lsp.configs.cmp\frequire\0", "config", "nvim-cmp")

vim.cmd [[ packadd nvim-treesitter ]]

-- Config for: nvim-treesitter
try_loadstring("\27LJ\2\nQ\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig#plugins.configs.code_highlight\frequire\0", "config", "nvim-treesitter")

vim.cmd [[ packadd nightfox.nvim ]]

-- Config for: nightfox.nvim
try_loadstring("\27LJ\2\nJ\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\28themes.configs.nightfox\frequire\0", "config", "nightfox.nvim")

vim.cmd [[ packadd indent-blankline.nvim ]]

-- Config for: indent-blankline.nvim
try_loadstring("\27LJ\2\nP\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\"plugins.configs.ui_code_scope\frequire\0", "config", "indent-blankline.nvim")

vim.cmd [[ packadd telescope.nvim ]]

-- Config for: telescope.nvim
try_loadstring("\27LJ\2\nI\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\27plugins.configs.finder\frequire\0", "config", "telescope.nvim")

vim.cmd [[ packadd nvim-tree.lua ]]

-- Config for: nvim-tree.lua
try_loadstring("\27LJ\2\nK\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\29plugins.configs.explorer\frequire\0", "config", "nvim-tree.lua")

vim.cmd [[ packadd alpha-nvim ]]

-- Config for: alpha-nvim
try_loadstring("\27LJ\2\nL\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\30plugins.configs.dashboard\frequire\0", "config", "alpha-nvim")

vim.cmd [[ packadd lualine.nvim ]]

-- Config for: lualine.nvim
try_loadstring("\27LJ\2\nO\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig!plugins.configs.ui_statusbar\frequire\0", "config", "lualine.nvim")

vim.cmd [[ packadd Comment.nvim ]]

-- Config for: Comment.nvim
try_loadstring("\27LJ\2\nO\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig!plugins.configs.code_comment\frequire\0", "config", "Comment.nvim")

vim.cmd [[ packadd nvim-autopairs ]]

-- Config for: nvim-autopairs
try_loadstring("\27LJ\2\nO\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig!plugins.configs.ui_autopairs\frequire\0", "config", "nvim-autopairs")

time([[Sequenced loading]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
