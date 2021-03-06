local plugin_name = "alpha"

local status, alpha = pcall(require, plugin_name)
if not status then
  vim.notify(plugin_name .. " not found!")
  return
end

local keymaps = require("core.keymaps")
keymaps.set(plugin_name, "n", "<leader>dd", ":Alpha<cr>", "[Dashboard] 显示Dashboard")
keymaps.bind(plugin_name)

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

local default_ascii = ascii4
-- ================================================================================================
-- local dashboard = require("alpha.themes.dashboard")

-- -- Set header
-- dashboard.section.header.val = {
--   "                                                     ",
--   "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
--   "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
--   "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
--   "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
--   "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
--   "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
--   "                                                     ",
-- }

-- -- Set menu
-- dashboard.section.buttons.val = {
--   dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
--   dashboard.button("f", "  > Find file", ":cd $HOME/Workspace | Telescope find_files<CR>"),
--   dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
--   dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
--   dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
-- }

-- -- Send config to alpha
-- alpha.setup(dashboard.opts)

-- -- Disable folding on alpha buffer
-- vim.cmd([[
--     autocmd FileType alpha setlocal nofoldenable
-- ]])
-- ================================================================================================
local function button(sc, txt, keybind)
  local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")
  local opts = {
    position = "center",
    text = txt,
    shortcut = sc,
    cursor = 5,
    width = 36,
    align_shortcut = "right",
    hl = "AlphaButtons",
  }

  if keybind then
    opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
  end

  return {
    type = "button",
    val = txt,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
      vim.api.nvim_feedkeys(key, "normal", false)
    end,
    opts = opts,
  }
end

local col = function(strlist, opts)
  -- strlist is a TABLE of TABLES, representing columns of text
  -- opts is a text display option

  -- column spacing
  local padding = 6
  -- fill lines up to the maximim length with 'fillchar'
  local fillchar = " "
  -- columns padding char (for testing)
  local padchar = " "

  -- define maximum string length in a table
  local maxlen = function(str)
    local max = 0
    for i in pairs(str) do
      if #str[i] > max then
        max = #str[i]
      end
    end
    return max
  end

  -- add as much right-padding to align the text block
  local pad = function(str, max)
    local strlist = {}
    for i in pairs(str) do
      if #str[i] < max then
        local newstr = str[i] .. string.rep(fillchar, max - #str[i])
        table.insert(strlist, newstr)
      else
        table.insert(strlist, str[i])
      end
    end
    return strlist
  end

  -- this is a table for text strings
  local values = {}
  -- process all the lines
  for i = 1, maxlen(strlist) do
    local str = ""
    -- process all the columns but last, because we dont wand extra padding
    -- after last column
    for column = 1, #strlist - 1 do
      local maxstr = maxlen(strlist[column])
      local padded = pad(strlist[column], maxstr)
      if strlist[column][i] == nil then
        str = str .. string.rep(fillchar, maxstr) .. string.rep(padchar, padding)
      else
        str = str .. padded[i] .. string.rep(padchar, padding)
      end
    end

    -- lets process the last column, no extra padding
    do
      local maxstr = maxlen(strlist[#strlist])
      local padded = pad(strlist[#strlist], maxstr)
      if strlist[#strlist][i] == nil then
        str = str .. string.rep(fillchar, maxlen(strlist[#strlist]))
      else
        str = str .. padded[i]
      end
    end

    -- insert result into output table
    table.insert(values, { type = "text", val = str, opts = opts })
  end

  return values
end

-- DEFAULT THEME
local default = {}

default.header = {
  type = "text",
  val = default_ascii,
  opts = {
    position = "center",
    hl = "SpecialComment",
  },
}

-- key reference
local telescope = {
  "<spc>ff  查找文件",
  "<spc>fs  find under cur",
  "<spc>fg  全局检索",
  "<spc>fb  buffers",
  "<spc>fh  help",
}

local buffers = {
  "<spc>w    cycle window",
  "<spc>bd   buff delete",
  "<spc>bn   buff next",
  "<spc>bp   buff prev",
  "<spc>bad  buff all del",
}

local git_blame_and_lsp_utils = {
  "<spc>gbt  toggle blame",
  "<spc>gbo  open blame url",
  "",
  "<spc>lio  lsp organize",
  "<spc>lrn  lsp rename file",
  "<spc>ll   lsp import all",
}

local preview = {
  "<spc>pd  preview def",
  "<spc>pi  preview impl",
  "<spc>pr  preview refs",
  "<spc>P   close all",
}

local lsp_nav1 = {
  "<spc>vc  goto decl",
  "<spc>vd  goto def",
  "<spc>vt  goto tdef",
  "<spc>vi  goto impl",
  "<spc>vn  goto next",
  "<spc>vp  goto prev",
}

local lsp_nav2 = {
  "<spc>vh   view hover",
  "<spc>ve   open float",
  "<spc>vf   formatting",
  "<spc>vsh  sig help",
  "<spc>vrn  rn var",
  "<spc>vca  code action",
  "<spc>vgr  get refs",
}

default.buttons = {
  type = "group",
  val = {
    button("e", "  new", ":ene <BAR> startinsert <CR>"),
    button("c", "  config", ":e ~/.config/nvim/init.lua <CR>"),
    button("u", "  update", ":PackerSync<CR>"),
    button("q", "  quit", ":qa<CR>"),
  },
  position = "center",
}

default.block1 = {
  type = "group",
  val = col({ telescope, buffers, preview }, {
    position = "center",
    hl = {
      { "SpecialKey", 0, -1 },
      -- { "MoreMsg", 13, 20 },
      -- { "MoreMsg", 39, 47 },
      -- { "MoreMsg", 67, 74 },
    },
  }),
  opts = {
    spacing = 0,
  },
}

default.block2 = {
  type = "group",
  val = col({ git_blame_and_lsp_utils, lsp_nav1, lsp_nav2 }, {
    position = "center",
    hl = {
      { "SpecialKey", 0, -1 },
      -- { "MoreMsg", 12, 20 },
      -- { "MoreMsg", 43, 51 },
      -- { "MoreMsg", 67, 75 },
    },
  }),
  opts = {
    spacing = 0,
  },
}

-- load config
alpha.setup({
  layout = {
    { type = "padding", val = 1 },
    default.header,
    { type = "padding", val = 1 },
    default.buttons,
    { type = "padding", val = 1 },
    default.block1,
    { type = "padding", val = 1 },
    default.block2,
    { type = "padding", val = 20 },
  },
  opts = {},
})

-- autocmd
-- hide/unhide tabs when toggling Alpha
vim.cmd([[ autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2 ]])
