local require = require
local unpack = unpack
local type = type
local tostring = tostring
local select = select
local pcall = pcall
local setmetatable = setmetatable
local ngx = ngx
local WARN = ngx.WARN
local ngx_log = ngx.log
local worker_id = ngx.worker.id
local get_phase = ngx.get_phase
local table = require("apisix.core.table")
local tablepool = require("tablepool")
local table_insert = table.insert
local inspect = require("inspect")
local mlcache = require("resty.mlcache")
-- 定义日志级别
local log_levels = {
    stderr = ngx.STDERR, -- [0]标准错误输出
    emerg = ngx.EMERG, -- [1]紧急报错
    alert = ngx.ALERT, -- [2]报警
    crit = ngx.CRIT, -- [3]严重，系统故障，触发运维告警系统
    error = ngx.ERR, -- [4]错误，业务不可恢复性错误
    warn = ngx.WARN, -- [5]提醒，业务中可忽略错误
    notice = ngx.NOTICE, -- [6]提醒，业务中比较重要信息
    info = ngx.INFO, -- [7]信息，业务琐碎日志信息，包含不同情况判断等
    debug = ngx.DEBUG -- [8]调试
}

local log_level_names = {
    [0] = "stderr",
    [1] = "emerg",
    [2] = "alert",
    [3] = "crit",
    [4] = "error",
    [5] = "warn",
    [6] = "notice",
    [7] = "info",
    [8] = "debug"
}

-- 当前设置的日志输出级别
local global_level = ngx.config.subsystem == "http" and require"ngx.errlog".get_sys_filter_level()
-- 什么也不做
local do_nothing = function()
end

local DEFAULT_CONTEXT = {
    ctyp = "-",
    cid = "-",
    cip = "-",
    req_id = "-",
    uid = "-"
}
-- 获取请求上下文中的日志上下文
local function get_log_context()
    local ctx
    local phase = get_phase()
    if phase ~= "init" then
        ctx = ngx.ctx.log_ctx
    end
    return ctx or DEFAULT_CONTEXT
end

local function print_log(level, prefix, ...)
    -- 获取日志上下文数据
    local _, ctx = pcall(get_log_context)
    -- 获取日志参数长度
    local len = select('#', ...)
    -- 多个分割参数中间填充空格, 因此需要加上新增加的空格的长度
    local new_len = len + (len - 1)
    -- 创建一个新表格
    local new_args = table.new(new_len, 0)
    local new_index = 1
    for i = 1, len do
        -- 获取第一个元素
        local v = select(i, ...)
        -- 判断元素类型
        local _typ = type(v)
        if _typ == "table" then
            -- 如果是表格,则使用inspect将其转换位字符串
            if prefix == "[temp]" then
                v = inspect(v)
            else
                v = inspect(v, {
                    newline = '',
                    indent = ''
                })
            end
        elseif _typ ~= "string" then
            -- 否则如果不是字符串类型,也把它转换位字符串
            v = tostring(v)
        end
        -- 将数据写入新表格并填充空格分隔符
        new_args[new_index] = v
        new_index = new_index + 1
        if new_index < new_len then
            new_args[new_index] = " "
            new_index = new_index + 1
        end
    end

    return ngx_log(level, "[W", worker_id() or "@", -- 工作进程ID
    "|", ctx.req_id or "-", -- 请求ID
    "|", ctx.cip or "-",    -- IP地址
    "|", ctx.ctyp or "-",   -- 客户端类型
    "|", ctx.cid or "-",    -- 客户端ID
    "|", ctx.uid or "-", "]$ ", prefix or '', " ", unpack(new_args))
end

-- 存储日志实例, 初始数量需要根据实际使用情况修改, 避免动态分配
local LOG_INSTANCES = table.new(0, 100)
-- 记录上次的报警时间, 用于temp临时调试的警告信息输出校验
local LAST_WARN_TIME
local LOG_CACHE

local _M = {}

function _M.http_init()
    local cache, err = mlcache.new("log_cache", "mlcache_log_dict", {
        ipc_shm = "mlcache_ipc_dict", -- Worker事件共享字典
        shm_locks = "mlcache_lock_dict", -- 缓存锁字典
        shm_miss = "mlcache_miss_dict", -- 缓存未命中时的存储字典
        lru_size = 100,
        ttl = 0
    })
    if not cache then
        error("could not create mlcache: " .. err)
    end
    LOG_CACHE = cache
end

-- 这里用于同步日志配置缓存
local function sync_worker_cache()
    local ok, err = LOG_CACHE:update()
    if not ok then
        ngx_log(ngx.ERR, "failed to poll evication events: ", err)
    end
end

function _M.http_access_phase()
    sync_worker_cache()
    -- 初始化一个日志上下文
    local log_ctx = tablepool.fetch("log_ctx", 0, 5)
    ngx.ctx.log_ctx = log_ctx
end

function _M.http_log_phase()
    local log_ctx = ngx.ctx.log_ctx
    if not log_ctx then
        return
    end
    tablepool.release("log_ctx", log_ctx)
end

function _M.ctx(key, value)
    local log_ctx = ngx.ctx.log_ctx
    if log_ctx then
        log_ctx[key] = value
    end
end

-- 获取当前实例化的日志列表
function _M.logs()
    local len = select('#', LOG_INSTANCES)
    local logs = table.new(len, 0)
    -- 遍历日志实例列表和缓存中的配置数据，将结果组装为table返回
    for name, _ in pairs(LOG_INSTANCES) do
        local status = _M.status(name)
        table_insert(logs, status)
    end
    -- ngx.log(ngx.ERR, require("inspect")(logs))
    return logs
end


local function is_log_enable(name)
    if LOG_CACHE then
        local status = LOG_CACHE:get(name)
        local enabled = status == true or false
        -- ngx.log(ngx.ERR, "测试日志["..name.."]是否启用: "..tostring(enabled))
        return enabled
    else
        return false
    end
end

local function is_debug_enable(name)
    if LOG_CACHE then
        local status = LOG_CACHE:get(name .. "_debug")
        local enabled = status == true or false
        -- ngx.log(ngx.ERR, "测试日志["..name.."]是否启用: "..tostring(enabled))
        return enabled
    else
        return false
    end
end

function _M.status(name)
    local status = is_log_enable(name)
    local debug = is_debug_enable(name)
    return {log=name, enabled=status, debug=debug}
end

-- 启用日志
function _M.enable(name, is_enable)
    if LOG_CACHE and LOG_INSTANCES[name] then
        if is_enable==nil then
            is_enable = false
        end
        if is_enable then
            ngx.log(ngx.ALERT, "启用日志[" .. name .. "]")
        end
        LOG_CACHE:set(name, nil, is_enable)
    end
end
-- 启用日志
function _M.debug(name, is_enable)
    local key = name .. "_debug"
    if LOG_CACHE and LOG_INSTANCES[name] then
        if is_enable==nil then
            is_enable = false
        end
        if is_enable then
            ngx.log(ngx.ALERT, "启用日志[" .. name .. "]调试模式")
        end
        LOG_CACHE:set(key, nil, is_enable)
    end
end

-- 获取日志实例
function _M.get(name)
    if not name then
        name = "core"
    end
    -- 从日志实例列表中获取指定名称的日志实例
    local instance = LOG_INSTANCES[name]
    -- 如果日志实例不存在,则初始化一个日志实例并放入实例列表
    if not instance then
        -- 日志实例对象
        instance = {
            name = name
        }
        LOG_INSTANCES[name] = instance
        -- 设置实例对象的元方法, 该方法的作用为,当在实例中未找到对应的KEY时,将使用__index方法创建一个并赋值给实例进行缓存
        setmetatable(instance, {
            __index = function(self, cmd)
                -- 关于变长参数的参考文章：https://blog.csdn.net/dikao8849/article/details/102338291
                local method
                if cmd == "temp" then
                    method = function(...)
                        -- 每2分钟输出一次报警信息
                        if LAST_WARN_TIME == nil or (ngx.time() - LAST_WARN_TIME > 120) then
                            ngx_log(ngx.ALERT,
                                "警告: temp日志仅用于临时调试，提交代码请移除临时调试日志！")
                            LAST_WARN_TIME = ngx.time()
                        end

                        return print_log(WARN, "[temp]", ...)
                    end
                else
                    local prefix = "[" .. name .. "]"
                    -- 获取日志级别
                    local log_level = log_levels[cmd]
                    if cmd == "debug" then
                        -- 因为默认开启的日志输出为"notice"，无法输出debug日志
                        -- 因此这里将调试日志级别重置为alert，从而可以输出调试日志，同时使用一个开关控制是否输出调试日志
                        -- 如果输出调试日志才进行输出，否则只输出普通日志
                        log_level = log_levels["alert"]
                    end

                    local is_do_nothing = global_level and (log_level > global_level)
                    -- 如果日志级别超出了当前级别,什么也不错

                    if is_do_nothing then
                        method = do_nothing
                    else
                        -- ngx.log(ngx.WARN,
                        --     "[W" .. (worker_id() or "#") .. "] [" .. log_level_names[global_level] .. "(" ..
                        --         global_level .. ")]" .. " 实例化日志: " .. name .. " [" .. log_level_names[log_level] ..
                        --         "(" .. log_level .. ")]")
                        if cmd == "debug" then
                            method = function(...)
                                if is_log_enable(name) and is_debug_enable(name) then
                                    return print_log(log_level, "[debug] " .. prefix, ...)
                                end
                            end
                        else
                            if log_level <= log_levels.warn then
                                -- 如果输出的日志级别小于等于警告级别,则任何时候都需要输出日志
                                method = function(...)
                                    return print_log(log_level, prefix, ...)
                                end
                            else
                                -- 如果输出的日志界别大于警告级别,则如果日志名称配置为true时才进行日志输出,否则不输出日志信息,这样可以方便的在线上动态切换业务日志的输出
                                -- 配置方式为通过接口配置指定名称的日志为ture,如果为false或nil,则不输出日志
                                method = function(...)
                                    if is_log_enable(name) then
                                        return print_log(log_level, prefix, ...)
                                    end
                                end
                            end
                        end
                    end
                end

                -- cache the lazily generated method in our
                -- module table
                instance[cmd] = method
                return method
            end
        })
    end
    return instance
end

return _M
