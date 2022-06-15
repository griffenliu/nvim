local vim = vim
local notify = vim.notify
local cmd = vim.cmd

local ascii1 = {
  "                                                     ",
  "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
  "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
  "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
  "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
  "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
  "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
  "                                                     ",
}
local ascii2 = {
  "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
  "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
  "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
  "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
  "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
  "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
  "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
  " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
  " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
  "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
  "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
}
local ascii3 = {
  '              ▄▄▄▄▄▄▄▄▄            ',
  '           ▄█████████████▄          ',
  '   █████  █████████████████  █████  ',
  '   ▐████▌ ▀███▄       ▄███▀ ▐████▌  ',
  '    █████▄  ▀███▄   ▄███▀  ▄█████    ',
  '    ▐██▀███▄  ▀███▄███▀  ▄███▀██▌    ',
  '     ███▄▀███▄  ▀███▀  ▄███▀▄███    ',
  '     ▐█▄▀█▄▀███ ▄ ▀ ▄ ███▀▄█▀▄█▌    ',
  '      ███▄▀█▄██ ██▄██ ██▄█▀▄███      ',
  '       ▀███▄▀██ █████ ██▀▄███▀      ',
  '      █▄ ▀█████ █████ █████▀ ▄█      ',
  '      ███        ███        ███      ',
  '      ███▄    ▄█ ███ █▄    ▄███      ',
  '      █████ ▄███ ███ ███▄ █████      ',
  '      █████ ████ ███ ████ █████      ',
  '      █████ ████▄▄▄▄▄████ █████      ',
  '       ▀███ █████████████ ███▀      ',
  '         ▀█ ███ ▄▄▄▄▄ ███ █▀        ',
  '            ▀█▌▐█████▌▐█▀            ',
  '               ███████              ',
}
local ascii4 = {
  "                         .^!^                                           .!~:                        ",
  "                    ^!JPB&B!.                                            !&&BPJ!:                   ",
  "                ^?P#@@@@@G.                   :       :                   !@@@@@&BY!:               ",
  "             ^JB@@@@@@@@@7                   .#~     ?P                   .&@@@@@@@@&G?:            ",
  "          .7G@@@@@@@@@@@@#!                  ?@#^   ~@@^                 .5@@@@@@@@@@@@@G7.         ",
  "        .?#@@@@@@@@@@@@@@@@BY!^.             B@@&BBB&@@Y              :~Y&@@@@@@@@@@@@@@@@#?.       ",
  "       !#@@@@@@@@@@@@@@@@@@@@@@#G5Y?!~^:..  !@@@@@@@@@@#.   ..::^!7J5B&@@@@@@@@@@@@@@@@@@@@@B!      ",
  "     .5@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&##B#@@@@@@@@@@@BBBB##&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Y     ",
  "    :B@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@5    ",
  "   .B@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@?   ",
  "   5@&#BGGPPPPPGGB&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&BGGPP5PPPGBB#&#.  ",
  "   ^:..           .^!YB@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&57^.            .:^.  ",
  "                       ~G@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Y.                      ",
  "                         P@@@#BGGGGB#@@@@@@@@@@@@@@@@@@@@@@@@@#BP5555PG#@@@P                        ",
  "                         :J!:.      .^!JG&@@@@@@@@@@@@@@@@#57^.        .:!5~                        ",
  "                                         :?G@@@@@@@@@@@@P!.                                         ",
  "                                            ~5@@@@@@@@5^                                            ",
  "                                              ^P@@@@G^                                              ",
  "                                                !#@?                                                ",
}

-- ================================================================================================

local function theme_config()
  local dashboard = require("alpha.themes.dashboard")
  -- Set header
  dashboard.section.header.val = ascii1

  -- Set menu
  dashboard.section.buttons.val = {
    dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("f", "  > Find file", ":cd $HOME/ | Telescope find_files<CR>"),
    dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
    dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
    dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
  }
  return dashboard
end

-- ================================================================================================

-- local function check(plugin_name)
--   local status, plugin = pcall(require, plugin_name)
--   if not status then
--     notify(plugin_name .. " not found!")
--     return false
--   end
--   return plugin
-- end

-- local set_keymaps
-- local function setup_keymaps(plugin_name)
--   if set_keymaps and type(set_keymaps) == "function" then
--     local keymaps = require("core.keymaps")
--     set_keymaps(plugin_name, keymaps)
--     keymaps.bind(plugin_name)
--   end
-- end

-- ============================================================================
-- set_keymaps = function(plugin_name, keymaps)
--   keymaps.set(plugin_name, "n", "<leader>dd", ":Alpha<cr>", "[Dashboard] 显示Dashboard")
-- end

-- local _M = {
--   name = "alpha",
--   desc = "仪表盘",
--   packer = {
--     'goolord/alpha-nvim',
--     config = function()
--       require("plugins.configs.dashboard").config()
--     end
--   }
-- }

-- local plugin_setup = function(plugin)
--   -- Send config to alpha
--   plugin.setup(theme_config().opts)
--   -- Disable folding on alpha buffer
--   cmd([[ autocmd FileType alpha setlocal nofoldenable ]])
--   -- autocmd
--   -- hide/unhide tabs when toggling Alpha
--   cmd([[ autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2 ]])
-- end

-- -- ============================================================================
-- _M.config = function()
--   local plugin_name = _M.name
--   local plugin = check(plugin_name)
--   if not plugin then return end
--   -- set key
--   setup_keymaps(plugin_name)
--   -- config
--   plugin_setup(plugin)
-- end

-- return _M

local base = require("core.plugin.base")

local _M = {
  name = "alpha",
  desc = "仪表盘",
  packer = {
    'goolord/alpha-nvim',
    config = function()
      require("plugins.configs.dashboard"):config()
    end
  }
}
setmetatable(_M, { __index = base })


_M.set_keymaps = function(self, keymaps)
  keymaps.set(self.name, "n", "<leader>dd", ":Alpha<cr>", "[Dashboard] 显示Dashboard")
end

_M.plugin_setup = function(self, keymaps)
  -- Send config to alpha
  self.plugin.setup(theme_config().opts)
  -- Disable folding on alpha buffer
  cmd([[ autocmd FileType alpha setlocal nofoldenable ]])
  -- autocmd
  -- hide/unhide tabs when toggling Alpha
  cmd([[ autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2 ]])
end

return _M
