local vim = vim
local api = vim.api

local function termcodes(str)
  -- https://github.com/neovim/neovim/issues/17369
  local ret = vim.api.nvim_replace_termcodes(str, false, true, true):gsub("\128\254X", "\128")
  return ret
end

-- 如果安装了nvim-tree则进行判断
local function get_nvim_tree_winid(tabpage)
  local status, view = pcall(require, "nvim-tree.view")
  if not status then
    return -1
  end
  return view.get_winnr(tabpage)
end

-- 创建一个显示编号的浮动窗口
local function create_float_win(bufid, winid, width, height)
  local float_win = api.nvim_open_win(bufid, false, {
    relative = 'win',
    win = winid,
    row = height / 2,
    col = width / 2,
    width = 3,
    height = 1,
    style = "minimal",
    border = "single",
    zindex = 300,
  })
  api.nvim_win_set_option(float_win, "winhl", "Normal:PmenuSel")
  return float_win
end

local _M = {}
-- 定义leader key
_M.leader_key = "<leader>"
-- 窗口编号和ID的映射
-- data: { wid = wid, nwid = num_wid, nbufid = bufid }
_M.wins = {}
-- 触发窗口编号后输入的按键序列
_M.keys = ""

-- remove
local function reg_keys()
  -- 绑定按键 api.nvim_set_current_win(winid)
  -- pcall(vim.api.nvim_set_keymap, "n",
  --   _M.leader_key .. real_index, '<cmd>lua require("core.window").active(' .. real_index .. ')<cr>', {
  --   noremap = true,
  --   silent = true
  -- })
  -- for num, win in pairs(_M.wins) do
  pcall(vim.api.nvim_set_keymap, "n",
    _M.leader_key .. _M.keys, '<cmd>lua require("core.window").active()<cr>', {
    noremap = true,
    silent = true
  })
  -- end
end

-- remove
local function clear_keys()
  -- 清除按键绑定
  pcall(vim.api.nvim_del_keymap, "n", _M.leader_key .. _M.keys)
end

-- 显示窗口编号，代码参考自 nvim-tree: pcik_window()
local function show_pick_window()
  local tabpage = api.nvim_get_current_tabpage()
  local win_ids = api.nvim_tabpage_list_wins(tabpage)
  local tree_winid = get_nvim_tree_winid(tabpage)
  -- 窗口编号
  local count = 1
  for _, wid in ipairs(win_ids) do
    -- 获取窗口的宽和高，用于定位浮动窗口
    local width = api.nvim_win_get_width(wid)
    local height = api.nvim_win_get_height(wid)
    -- 创建一个临时缓冲区，用于显示数字
    local bufid = api.nvim_create_buf(false, true)
    local real_index = count
    if tree_winid == wid then
      real_index = 0
    else
      count = count + 1
    end
    api.nvim_buf_set_lines(bufid, 0, 0, false, { " " .. tostring(real_index) .. " " })
    -- 创建浮动窗口
    local num_wid = create_float_win(bufid, wid, width, height)
    _M.wins[real_index] = { wid = wid, nwid = num_wid, nbufid = bufid }
  end
  vim.cmd [[redraw!]]
end

local function hide()
  vim.pretty_print(_M.wins)
  for _, win in pairs(_M.wins) do
    -- 隐藏浮动窗口
    -- local bufid = api.nvim_win_get_buf(win.nwid) -- bufid 也存储了，省略一次获取操作
    if api.nvim_buf_is_valid(win.nbufid) then
      api.nvim_buf_delete(win.nbufid, { force = true })
    end
    if api.nvim_win_is_valid(win.nwid) then
      vim.api.nvim_win_close(win.nwid, { force = true })
    end
  end
  -- clear_keys()
  _M.keys = ""
  _M.wins = {}
  vim.cmd [[redraw!]]
end

-- 读取用户输入按键序列 代码参考自 WhichKey
local function read_pending()
  local esc = ""
  while true do
    local n = vim.fn.getchar(0) -- 从输入流获取一个字符
    if n == 0 then
      break
    end
    local c = (type(n) == "number" and vim.fn.nr2char(n) or n)

    -- HACK: for some reason, when executing a :norm command,
    -- vim keeps feeding <esc> at the end
    if c == termcodes("<esc>") then
      esc = esc .. c
      -- more than 10 <esc> in a row? most likely the norm bug
      if #esc > 10 then
        return
      end
    else
      -- we have <esc> characters, so add them to keys
      if esc ~= "" then
        _M.keys = _M.keys .. esc
        esc = ""
      end
      _M.keys = _M.keys .. c
    end
  end
  if esc ~= "" then
    _M.keys = _M.keys .. esc
    esc = ""
  end
end

local function pick_window()
  _M.keys = "" -- 重置按键序列
  show_pick_window()
  while true do
    -- loop
    read_pending()
    -- 如果是指定的退出按键，直接退出
    if _M.keys == "<esc>" or _M.keys == "q" then
      hide()
      return
    end
    -- 如果是指定的数字，则执行指令
    local number = tonumber(_M.keys)
    if number ~= nil then
      -- 这种按键序列的方式还不太会用，总是会有问题，结果会延迟一次操作，暂时不用了
      -- api.nvim_feedkeys(_M.keys, "m", true)
      -- defer hooking WK until after the keys were executed
      -- vim.defer_fn(reg_keys, 0)  -- 这个是为了将修改的按键重置回去?
      -- 直接激活窗口就很好，也避免了快捷键的来回注册和取消
      _M.active_win(number)

      return
    end
    if _M.keys ~= "" then
      hide()
      -- 直接退出，方便执行其他操作
      return
    end
    -- vim.cmd([[redraw]])
  end
end

_M.active_win = function(number)
  if number then
    local win = _M.wins[number]
    if win then
      api.nvim_set_current_win(win.wid)
    end
  end

  hide()
end
-- secret character that will be used to create <nop> mappings
local secret = "Þ"
_M.setup = function()
  api.nvim_create_user_command("PickWindow", pick_window, {})
  api.nvim_set_keymap("n", "<leader> ", "<cmd> PickWindow <CR>", { noremap = true,
    silent = true, nowait = true, expr = false, desc = "@C [WINDOW] 选择窗口" })
  -- vim.api.nvim_set_keymap("n", _M.leader_key .. secret, "<nop>", { noremap = true,
  --   silent = true, nowait = true, expr = false, desc = "@C [WINDOW] 选择窗口" })
end

return _M
