local vim = vim
local api = vim.api
-- FIXME: 这个已经不需要，使用其他插件代替了

local layout = {}

local function is_float(value)
    local _, p = math.modf(value)
    return p ~= 0
end

local function calc_float(value, max_value)
    if value and is_float(value) then
        return math.min(max_value, value * max_value)
    else
        return value
    end
end

local function calc_list(values, max_value, aggregator, limit)
    local ret = limit
    if type(values) == "table" then
        for _, v in ipairs(values) do
            ret = aggregator(ret, calc_float(v, max_value))
        end
        return ret
    else
        ret = aggregator(ret, calc_float(values, max_value))
    end
    return ret
end

local function calculate_dim(desired_size, size, min_size, max_size, total_size)
    local ret = calc_float(size, total_size)
    local min_val = calc_list(min_size, total_size, math.max, 1)
    local max_val = calc_list(max_size, total_size, math.min, total_size)
    if not ret then
        if not desired_size then
            ret = (min_val + max_val) / 2
        else
            ret = calc_float(desired_size, total_size)
        end
    end
    ret = math.min(ret, max_val)
    ret = math.max(ret, min_val)
    return math.floor(ret)
end

local function get_max_width(relative, winid)
    if relative == "editor" then
        return vim.o.columns
    else
        return vim.api.nvim_win_get_width(winid or 0)
    end
end

local function get_max_height(relative, winid)
    if relative == "editor" then
        return vim.o.lines - vim.o.cmdheight
    else
        return vim.api.nvim_win_get_height(winid or 0)
    end
end

layout.calculate_col = function(relative, width, winid)
    if relative == "cursor" then
        return 1
    else
        return math.floor((get_max_width(relative, winid) - width) / 2)
    end
end

layout.calculate_row = function(relative, height, winid)
    if relative == "cursor" then
        return 1
    else
        return math.floor((get_max_height(relative, winid) - height) / 2)
    end
end

layout.calculate_width = function(relative, desired_width, config, winid)
    return
        calculate_dim(desired_width, config.width, config.min_width, config.max_width, get_max_width(relative, winid))
end

layout.calculate_height = function(relative, desired_height, config, winid)
    return calculate_dim(desired_height, config.height, config.min_height, config.max_height,
        get_max_height(relative, winid))
end

local function create_help_buffer()
    local help_bufnr = api.nvim_create_buf(false, true)
    -- 在这个缓冲区设置一个退出按键
    api.nvim_buf_set_keymap(help_bufnr, "n", "q", "<cmd> ToggleHelp <CR>", {
        silent = true,
        noremap = true
    })
    api.nvim_buf_set_option(help_bufnr, "buftype", "nofile")
    api.nvim_buf_set_option(help_bufnr, "bufhidden", "wipe")
    api.nvim_buf_set_option(help_bufnr, "buflisted", false)
    api.nvim_buf_set_option(help_bufnr, "swapfile", false)
    api.nvim_buf_set_option(help_bufnr, "modifiable", false)
    return help_bufnr
end

local float_config = {
    -- Controls border appearance. Passed to nvim_open_win
    border = "rounded",

    -- Enum: cursor, editor, win
    --   cursor - Opens float on top of the cursor
    --   editor - Opens float centered in the editor
    --   win    - Opens float centered in the window
    relative = "editor",

    -- These control the height of the floating window.
    -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_height and max_height can be a list of mixed types.
    -- min_height = {8, 0.1} means "the greater of 8 rows or 10% of total"
    max_height = 0.9,
    height = nil,
    min_height = {8, 0.1},

    override = function(conf)
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        return conf
    end
}
local config = {
    max_width = {100, 0.5},
    width = 80,
    min_width = 10
}
local go_win_no_au = function(winid)
    if winid == nil or winid == api.nvim_get_current_win() then
        return
    end
    local winnr = api.nvim_win_get_number(winid)
    vim.cmd(string.format("noau %dwincmd w", winnr))
end

local update_help_buffer = function(bufid)
    local lines = {}
    local mode = "n"
    local buf = api.nvim_get_current_buf()
    local keymaps = buf and vim.api.nvim_buf_get_keymap(buf, mode) or vim.api.nvim_get_keymap(mode)
    for _, keymap in pairs(keymaps) do
        -- vim.pretty_print(keymap)
        table.insert(lines, keymap.lhs .. ": " .. (keymap.desc or keymap.rhs))
    end

    vim.api.nvim_buf_set_option(bufid, "modifiable", true)
    vim.api.nvim_buf_set_lines(bufid, 0, -1, false, lines)
    vim.api.nvim_buf_set_option(bufid, "modifiable", false)

    local ns = vim.api.nvim_create_namespace("help")
    vim.api.nvim_buf_clear_namespace(bufid, ns, 0, -1)

end

local function create_help_window()

    local help_bufnr = create_help_buffer()
    local my_winid = api.nvim_get_current_win()

    local rel = float_config.relative
    local width = layout.calculate_width(rel, nil, config)
    local height = layout.calculate_height(rel, nil, float_config)
    local row = layout.calculate_row(rel, height)
    local col = layout.calculate_col(rel, width)
    local win_config = {
        relative = rel,
        row = row,
        col = col,
        width = width,
        height = height,
        zindex = 125,
        style = "minimal",
        border = float_config.border
    }
    if rel == "win" then
        win_config.win = api.nvim_get_current_win()
    end
    local new_config = float_config.override(win_config) or win_config
    local winid = vim.api.nvim_open_win(help_bufnr, true, new_config)
    -- We store this as a window variable because relative=cursor gets
    -- turned into relative=win when checking nvim_win_get_config()
    api.nvim_win_set_var(winid, "relative", new_config.relative)
    api.nvim_win_set_option(0, "listchars", "tab:> ")
    api.nvim_win_set_option(0, "winfixwidth", true)
    api.nvim_win_set_option(0, "number", false)
    api.nvim_win_set_option(0, "signcolumn", "no")
    api.nvim_win_set_option(0, "foldcolumn", "0")
    api.nvim_win_set_option(0, "relativenumber", false)
    api.nvim_win_set_option(0, "wrap", false)
    api.nvim_win_set_option(0, "spell", false)
    api.nvim_win_set_var(0, "is_aerial_win", true)
    -- Set the filetype only after we enter the buffer so that FileType autocmds
    -- behave properly
    api.nvim_buf_set_option(help_bufnr, "filetype", "help")

    local aer_winid = api.nvim_get_current_win()
    go_win_no_au(my_winid)
    update_help_buffer(help_bufnr)
    return aer_winid
end

local function hide_help_window(wid, bufid)
    if bufid and api.nvim_buf_is_valid(bufid) then
        api.nvim_buf_delete(bufid, {
            force = true
        })
    end
    if wid and api.nvim_win_is_valid(wid) then
        vim.api.nvim_win_close(wid, {
            force = true
        })
    end
end

local _M = {}

_M.active = false

local function toggle_help()
    -- local mode = "n"
    -- local buf = api.nvim_get_current_buf()
    -- local keymaps = buf and vim.api.nvim_buf_get_keymap(buf, mode) or vim.api.nvim_get_keymap(mode)
    -- for _, keymap in pairs(keymaps) do
    --   vim.pretty_print(keymap)
    -- end
    if not _M.active then
        local wid, bufid = create_help_window()
        _M.wid = wid
        _M.bufid = bufid
        _M.active = true
    else
        hide_help_window(_M.wid, _M.bufid)
        _M.active = false
    end
end

_M.setup = function()
    api.nvim_create_user_command("ToggleHelp", toggle_help, {})
    vim.api.nvim_set_keymap("n", "<leader>hh", "<cmd> ToggleHelp <CR>", {
        noremap = true,
        silent = true,
        nowait = true,
        expr = false,
        desc = "@C [HELP] 显示我的帮助"
    })
end

return _M
