local vim = vim

local function get_plenary_log()
    local has_plenary, plenary_log = pcall(require, "plenary.log")
    if not has_plenary then
        return
    end

    local default_opts = {
        plugin = "mylog",
        use_console = 'async', -- values: 'sync','async',false
    }
    return plenary_log.new(default_opts)
end

local enable_plenary_log = false
local log_instance = {
    warn = vim.pretty_print
}

local function get_log()
    if not enable_plenary_log then
        local log = get_plenary_log()
        if log then
            log_instance = log
            enable_plenary_log = true
        end
    end
    return log_instance
end

local _M = { flag = true }

-- FIXME: 这种方式会导致文件定位出现问题，最好的方式还是获取到裸API
_M.warn = function(msg)
    get_log().warn(msg)
end


return _M
