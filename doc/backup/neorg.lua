local plugin_name = "neorg"
local status, neorg = pcall(require, plugin_name)
if not status then
  vim.notify(plugin_name .. "not found!")
  return
end
local home = vim.env.HOME
print("============= " .. home)
local workspace_root = home .. "/notes"

neorg.setup {
  load = {
    ["core.defaults"] = {},
    -- 补全
    --["core.norg.completion"] = {},
    -- 工作目录
    ["core.norg.dirman"] = {
      config = {
        -- TODO: 增加在初始化文件中自定义的功能，这里封装起来
        workspaces = {
          notes = workspace_root,
          work = workspace_root .. "/journal",
          gtd = workspace_root .. "/gtd"
        },
        default_workspace = workspace_root,
        autochdir = true,
      }
    },
    -- 基础的GTD管理
    ["core.gtd.base"] = {
      config = {
        workspace = workspace_root .. "/gtd"
      }
    },
    -- 使用图标代替字符
    ["core.norg.concealer"] = {},
    -- 目录生成
    ["core.norg.qol.toc"] = {},
    -- 日志
    ["core.norg.journal"] = {},
    -- 幻灯片 zen_mode
    -- ["core.presenter"] = {
    --   config = {
    --     zen_mode = ""
    --   }
    -- },
  }
}
