if vim.g.neovide then
  -- vim.api.nvim_set_keymap('v', '<D-c>', '"+y', { noremap = true })
  -- vim.api.nvim_set_keymap('n', '<D-v>', 'l"+P', { noremap = true })
  -- vim.api.nvim_set_keymap('v', '<D-v>', '"+P', { noremap = true })
  -- vim.api.nvim_set_keymap('c', '<D-v>', '<C-o>l<C-o>"+<C-o>P<C-o>l', { noremap = true })
  -- vim.api.nvim_set_keymap('i', '<D-v>', '<ESC>l"+Pli', { noremap = true })
  -- vim.api.nvim_set_keymap('t', '<D-v>', '<C-\\><C-n>"+Pi', { noremap = true })


  vim.keymap.set('n', '<D-s>', ':w<CR>')      -- Save
  vim.keymap.set('v', '<D-c>', '"+y')         -- Copy
  vim.keymap.set('n', '<D-v>', '"+P')         -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P')         -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+')      -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode

  vim.g.transparency = 0.9
  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
end

require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.autocommands"
require "user.colorscheme"
require "user.autopairs"
require "user.bufferline"

-- local http = require("http") -- 假设你有一个 HTTP 客户端库
-- local json = require("json") -- 确保你有一个 JSON 库
--
-- local function read_org_tasks(file_path)
--   local tasks = {}
--   local current_task = nil
--
--   for line in io.lines(file_path) do
--     -- 检查行是否为任务
--     if line:match("^%* %s*TODO") or line:match("^%* %s*DONE") then
--       if current_task then
--         table.insert(tasks, current_task)
--       end
--       current_task = line -- 保存当前任务
--     elseif current_task then
--       -- 如果当前任务存在，继续添加相关信息
--       current_task = current_task .. "\n" .. line
--     end
--   end
--
--   -- 添加最后一个任务（如果存在）
--   if current_task then
--     table.insert(tasks, current_task)
--   end
--
--   return tasks
-- end
--
-- local function send_to_notion(tasks)
--   local notion_api_url = "https://api.notion.com/v1/pages"
--   local headers = {
--     ["Authorization"] = "Bearer YOUR_NOTION_API_KEY",
--     ["Content-Type"] = "application/json",
--     ["Notion-Version"] = "2021-05-13",
--   }
--
--   local success = true
--
--   for _, task in ipairs(tasks) do
--     local data = {
--       parent = { id = "YOUR_DATABASE_ID" },
--       properties = {
--         Title = {
--           title = {
--             { text = { content = task } }
--           }
--         }
--       }
--     }
--
--     local response = http.post(notion_api_url, headers, json.encode(data))
--     if response.status ~= 200 then
--       print("Error sending task to Notion: " .. response.body)
--       success = false
--       break
--     end
--   end
--
--   if success then
--     -- 清空当前文件内容
--     vim.api.nvim_buf_set_lines(0, 0, -1, false, {})
--     print("Tasks exported to Notion successfully and current file cleared!")
--   end
-- end
--
-- local function export_tasks_to_notion()
--   local current_file = vim.fn.expand("%:p")
--   local tasks = read_org_tasks(current_file)
--
--   if #tasks == 0 then
--     print("No tasks found in the current Org file.")
--     return
--   end
--
--   send_to_notion(tasks)
-- end
-- vim.api.nvim_create_user_command("ExportTasksToNotion", export_tasks_to_notion, {})
