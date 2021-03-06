local MISC = {}

MISC.name = "misc"

local misc = {
  windows = {
    ["<c-w>"] = {
      name = "window",
      s = "Split window",
      v = "Split window vertically",
      w = "Switch windows",
      q = "Quit a window",
      T = "Break out into a new tab",
      x = "Swap current with next",
      ["-"] = "Decrease height",
      ["+"] = "Increase height",
      ["<lt>"] = "Decrease width",
      [">"] = "Increase width",
      ["|"] = "Max out the width",
      ["="] = "Equally high and wide",
      h = "Go to the left window",
      l = "Go to the right window",
      k = "Go to the up window",
      j = "Go to the down window",
    },
  },
  z = {
    ["z"] = {
      o = "Open fold under cursor",
      O = "Open all folds under cursor",
      c = "Close fold under cursor",
      C = "Close all folds under cursor",
      a = "Toggle fold under cursor",
      A = "Toggle all folds under cursor",
      v = "Show cursor line",
      M = "Close all folds",
      R = "Open all folds",
      m = "Fold more",
      r = "Fold less",
      x = "Update folds",
      z = "Center this line",
      t = "Top this line",
      b = "Bottom this line",
      g = "Add word to spell list",
      w = "Mark word as bad/misspelling",
      e = "Right this line",
      s = "Left this line",
      H = "Half screen to the left",
      L = "Half screen to the right",
      ["="] = "Spelling suggestions",
    },
  },
  nav = {
    ["[{"] = "Previous {",
    ["[("] = "Previous (",
    ["[<lt>"] = "Previous <",
    ["[m"] = "Previous method start",
    ["[M"] = "Previous method end",
    ["[%"] = "Previous unmatched group",
    ["[s"] = "Previous misspelled word",
    ["]{"] = "Next {",
    ["]("] = "Next (",
    ["]<lt>"] = "Next <",
    ["]m"] = "Next method start",
    ["]M"] = "Next method end",
    ["]%"] = "Next unmatched group",
    ["]s"] = "Next misspelled word",
    ["H"] = "Home line of window (top)",
    ["M"] = "Middle line of window",
    ["L"] = "Last line of window",
  },
  g = {
    ["gf"] = "Go to file under cursor",
    ["gx"] = "Open the file under cursor with system app",
    ["gi"] = "Move to the last insertion and INSERT",
    ["gv"] = "Switch to VISUAL using last selection",
    ["gn"] = "Search forwards and select",
    ["gN"] = "Search backwards and select",
    ["g%"] = "Cycle backwards through results",
  },
}

function MISC.setup(wk)
  for _, mappings in pairs(misc) do
    wk.register(mappings, { mode = "n", prefix = "", preset = true })
  end
end

-- presets
local PRESETS = {}

PRESETS.name = "presets"

PRESETS.operators = {
  d = "??????",
  c = "Change",
  y = "Yank (copy)",
  ["g~"] = "???????????????",
  ["gu"] = "???????????????",
  ["gU"] = "???????????????",
  [">"] = "Indent right",
  ["<lt>"] = "Indent left",
  ["zf"] = "Create fold",
  ["!"] = "Filter though external program",
  ["v"] = "Visual Character Mode",
  -- ["V"] = "Visual Line Mode",
}

PRESETS.motions = {
  ["h"] = "Left",
  ["j"] = "Down",
  ["k"] = "Up",
  ["l"] = "Right",
  ["w"] = "Next word",
  ["%"] = "Matching character: '()', '{}', '[]'",
  ["b"] = "Previous word",
  ["e"] = "Next end of word",
  ["ge"] = "Previous end of word",
  ["0"] = "Start of line",
  ["^"] = "Start of line (non-blank)",
  ["$"] = "End of line",
  ["f"] = "Move to next char",
  ["F"] = "Move to previous char",
  ["t"] = "Move before next char",
  ["T"] = "Move before previous char",
  ["gg"] = "First line",
  ["G"] = "Last line",
  ["{"] = "Previous empty line",
  ["}"] = "Next empty line",
}

PRESETS.objects = {
  a = { name = "around" },
  i = { name = "inside" },
  ['a"'] = [[double quoted string]],
  ["a'"] = [[single quoted string]],
  ["a("] = [[same as ab]],
  ["a)"] = [[same as ab]],
  ["a<lt>"] = [[a <> from '<' to the matching '>']],
  ["a>"] = [[same as a<]],
  ["aB"] = [[a Block from [{ to ]} (with brackets)]],
  ["aW"] = [[a WORD (with white space)]],
  ["a["] = [[a [] from '[' to the matching ']']],
  ["a]"] = [[same as a[]],
  ["a`"] = [[string in backticks]],
  ["ab"] = [[a block from [( to ]) (with braces)]],
  ["ap"] = [[a paragraph (with white space)]],
  ["as"] = [[a sentence (with white space)]],
  ["at"] = [[a tag block (with white space)]],
  ["aw"] = [[a word (with white space)]],
  ["a{"] = [[same as aB]],
  ["a}"] = [[same as aB]],
  ['i"'] = [[double quoted string without the quotes]],
  ["i'"] = [[single quoted string without the quotes]],
  ["i("] = [[same as ib]],
  ["i)"] = [[same as ib]],
  ["i<lt>"] = [[inner <> from '<' to the matching '>']],
  ["i>"] = [[same as i<]],
  ["iB"] = [[inner Block from [{ and ]}]],
  ["iW"] = [[inner WORD]],
  ["i["] = [[inner [] from '[' to the matching ']']],
  ["i]"] = [[same as i[]],
  ["i`"] = [[string in backticks without the backticks]],
  ["ib"] = [[inner block from [( to ])]],
  ["ip"] = [[inner paragraph]],
  ["is"] = [[inner sentence]],
  ["it"] = [[inner tag block]],
  ["iw"] = [[inner word]],
  ["i{"] = [[same as iB]],
  ["i}"] = [[same as iB]],
}

---@param config Options
function PRESETS.setup(wk, config)
  MISC.setup(wk)

  -- Operators
  for op, label in pairs(PRESETS.operators) do
    config.operators[op] = label
  end


  -- Motions
  wk.register(PRESETS.motions, { mode = "n", prefix = "", preset = true })
  wk.register(PRESETS.motions, { mode = "o", prefix = "", preset = true })

  -- Text objects
  wk.register(PRESETS.objects, { mode = "o", prefix = "", preset = true })
end

return PRESETS
