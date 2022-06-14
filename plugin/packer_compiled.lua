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
local package_path_str = "C:\\Users\\jon\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?.lua;C:\\Users\\jon\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?\\init.lua;C:\\Users\\jon\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?.lua;C:\\Users\\jon\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?\\init.lua"
local install_cpath_pattern = "C:\\Users\\jon\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\lua\\5.1\\?.so"
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
    after_files = { "D:\\softs\\Neovim\\nvim0.7\\config\\nvim-data\\site\\pack\\packer\\opt\\Comment.nvim\\after\\plugin\\Comment.lua" },
    config = { "\27LJ\2\nN\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig plugins.configs.ide.comment\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "D:\\softs\\Neovim\\nvim0.7\\config\\nvim-data\\site\\pack\\packer\\opt\\Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\nP\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\"plugins.configs.ide.blankline\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "D:\\softs\\Neovim\\nvim0.7\\config\\nvim-data\\site\\pack\\packer\\opt\\indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\nQ\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig#plugins.configs.ide.statusline\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "D:\\softs\\Neovim\\nvim0.7\\config\\nvim-data\\site\\pack\\packer\\opt\\lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\nP\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\"plugins.configs.ide.autopairs\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "D:\\softs\\Neovim\\nvim0.7\\config\\nvim-data\\site\\pack\\packer\\opt\\nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\nP\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\"plugins.configs.ide.colorizer\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "D:\\softs\\Neovim\\nvim0.7\\config\\nvim-data\\site\\pack\\packer\\opt\\nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-lsp-installer"] = {
    config = { "\27LJ\2\nP\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\"plugins.configs.lsp.installer\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "D:\\softs\\Neovim\\nvim0.7\\config\\nvim-data\\site\\pack\\packer\\opt\\nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    after = { "nvim-lsp-installer" },
    config = { "\27LJ\2\nM\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\31plugins.configs.lsp.config\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "D:\\softs\\Neovim\\nvim0.7\\config\\nvim-data\\site\\pack\\packer\\opt\\nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-neoclip.lua"] = {
    config = { "\27LJ\2\nP\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\"plugins.configs.ide.clipboard\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "D:\\softs\\Neovim\\nvim0.7\\config\\nvim-data\\site\\pack\\packer\\opt\\nvim-neoclip.lua",
    url = "https://github.com/AckslD/nvim-neoclip.lua"
  },
  ["nvim-notify"] = {
    after = { "which-key.nvim" },
    config = { "\27LJ\2\nM\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\31plugins.configs.ide.notify\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "D:\\softs\\Neovim\\nvim0.7\\config\\nvim-data\\site\\pack\\packer\\opt\\nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\nO\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig!plugins.configs.ide.explorer\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "D:\\softs\\Neovim\\nvim0.7\\config\\nvim-data\\site\\pack\\packer\\opt\\nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    after = { "Comment.nvim", "telescope.nvim", "nvim-autopairs" },
    config = { "\27LJ\2\nQ\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig#plugins.configs.ide.treesitter\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "D:\\softs\\Neovim\\nvim0.7\\config\\nvim-data\\site\\pack\\packer\\opt\\nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    after = { "plenary.nvim" },
    loaded = true,
    only_config = true
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "D:\\softs\\Neovim\\nvim0.7\\config\\nvim-data\\site\\pack\\packer\\start\\packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    after = { "tokyonight.nvim" },
    config = { "\27LJ\2\nT\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig&plugins.configs.libs.func_plenary\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "D:\\softs\\Neovim\\nvim0.7\\config\\nvim-data\\site\\pack\\packer\\opt\\plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["project.nvim"] = {
    after = { "nvim-treesitter" },
    config = { "\27LJ\2\nN\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig plugins.configs.ide.project\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "D:\\softs\\Neovim\\nvim0.7\\config\\nvim-data\\site\\pack\\packer\\opt\\project.nvim",
    url = "https://github.com/ahmedkhalf/project.nvim"
  },
  ["rust-tools.nvim"] = {
    loaded = true,
    path = "D:\\softs\\Neovim\\nvim0.7\\config\\nvim-data\\site\\pack\\packer\\start\\rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["telescope-env.nvim"] = {
    loaded = true,
    path = "D:\\softs\\Neovim\\nvim0.7\\config\\nvim-data\\site\\pack\\packer\\start\\telescope-env.nvim",
    url = "https://github.com/LinArcX/telescope-env.nvim"
  },
  ["telescope.nvim"] = {
    after = { "nvim-lspconfig", "nvim-neoclip.lua" },
    config = { "\27LJ\2\nP\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\"plugins.configs.ide.telescope\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = true,
    path = "D:\\softs\\Neovim\\nvim0.7\\config\\nvim-data\\site\\pack\\packer\\opt\\telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    after = { "nvim-notify" },
    config = { "\27LJ\2\nT\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig&plugins.configs.themes.tokyonight\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "D:\\softs\\Neovim\\nvim0.7\\config\\nvim-data\\site\\pack\\packer\\opt\\tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["which-key.nvim"] = {
    after = { "indent-blankline.nvim", "lualine.nvim", "nvim-colorizer.lua", "project.nvim", "nvim-tree.lua" },
    config = { "\27LJ\2\nP\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\"plugins.configs.ide.which-key\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "D:\\softs\\Neovim\\nvim0.7\\config\\nvim-data\\site\\pack\\packer\\opt\\which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\2\nU\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig'plugins.configs.libs.icon_devicons\frequire\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd plenary.nvim ]]

-- Config for: plenary.nvim
try_loadstring("\27LJ\2\nT\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig&plugins.configs.libs.func_plenary\frequire\0", "config", "plenary.nvim")

vim.cmd [[ packadd tokyonight.nvim ]]

-- Config for: tokyonight.nvim
try_loadstring("\27LJ\2\nT\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig&plugins.configs.themes.tokyonight\frequire\0", "config", "tokyonight.nvim")

vim.cmd [[ packadd nvim-notify ]]

-- Config for: nvim-notify
try_loadstring("\27LJ\2\nM\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\31plugins.configs.ide.notify\frequire\0", "config", "nvim-notify")

vim.cmd [[ packadd which-key.nvim ]]

-- Config for: which-key.nvim
try_loadstring("\27LJ\2\nP\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\"plugins.configs.ide.which-key\frequire\0", "config", "which-key.nvim")

vim.cmd [[ packadd lualine.nvim ]]

-- Config for: lualine.nvim
try_loadstring("\27LJ\2\nQ\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig#plugins.configs.ide.statusline\frequire\0", "config", "lualine.nvim")

vim.cmd [[ packadd indent-blankline.nvim ]]

-- Config for: indent-blankline.nvim
try_loadstring("\27LJ\2\nP\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\"plugins.configs.ide.blankline\frequire\0", "config", "indent-blankline.nvim")

vim.cmd [[ packadd nvim-colorizer.lua ]]

-- Config for: nvim-colorizer.lua
try_loadstring("\27LJ\2\nP\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\"plugins.configs.ide.colorizer\frequire\0", "config", "nvim-colorizer.lua")

vim.cmd [[ packadd project.nvim ]]

-- Config for: project.nvim
try_loadstring("\27LJ\2\nN\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig plugins.configs.ide.project\frequire\0", "config", "project.nvim")

vim.cmd [[ packadd nvim-treesitter ]]

-- Config for: nvim-treesitter
try_loadstring("\27LJ\2\nQ\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig#plugins.configs.ide.treesitter\frequire\0", "config", "nvim-treesitter")

vim.cmd [[ packadd telescope.nvim ]]

-- Config for: telescope.nvim
try_loadstring("\27LJ\2\nP\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\"plugins.configs.ide.telescope\frequire\0", "config", "telescope.nvim")

vim.cmd [[ packadd nvim-lspconfig ]]

-- Config for: nvim-lspconfig
try_loadstring("\27LJ\2\nM\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\31plugins.configs.lsp.config\frequire\0", "config", "nvim-lspconfig")

vim.cmd [[ packadd nvim-lsp-installer ]]

-- Config for: nvim-lsp-installer
try_loadstring("\27LJ\2\nP\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\"plugins.configs.lsp.installer\frequire\0", "config", "nvim-lsp-installer")

vim.cmd [[ packadd nvim-neoclip.lua ]]

-- Config for: nvim-neoclip.lua
try_loadstring("\27LJ\2\nP\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\"plugins.configs.ide.clipboard\frequire\0", "config", "nvim-neoclip.lua")

vim.cmd [[ packadd nvim-autopairs ]]

-- Config for: nvim-autopairs
try_loadstring("\27LJ\2\nP\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig\"plugins.configs.ide.autopairs\frequire\0", "config", "nvim-autopairs")

vim.cmd [[ packadd Comment.nvim ]]

-- Config for: Comment.nvim
try_loadstring("\27LJ\2\nN\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig plugins.configs.ide.comment\frequire\0", "config", "Comment.nvim")

vim.cmd [[ packadd nvim-tree.lua ]]

-- Config for: nvim-tree.lua
try_loadstring("\27LJ\2\nO\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\vconfig!plugins.configs.ide.explorer\frequire\0", "config", "nvim-tree.lua")

time([[Sequenced loading]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
