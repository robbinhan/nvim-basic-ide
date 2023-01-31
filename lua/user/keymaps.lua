-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Plugins --

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", {desc = "Lazygit"})
keymap("n", "<leader>gd", ":DiffviewOpen<CR>", {desc = "Git Diff"})

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", {desc = "Comment"})
keymap("x", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- Lsp
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", {desc = "Format"})

-- makrdown
keymap("n", "<leader>mp", ":Glow<cr>", {desc = "Preview current markdown file"})


-- pick window
keymap("n", "<leader>w", function()
    local picked_window_id = require('window-picker').pick_window() or vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(picked_window_id)
end, { desc = "Pick a window" })

-- spectre
keymap("n", "<leader>S", "<cmd>lua require'spectre'.open()<cr>", {desc="Search and Replace with spectre"})
-- search current word
keymap("n", "<leader>sw", "<cmd>lua require'spectre'.open_visual({select_word=true})<cr>", {desc = "search current word"})
-- search in current file
keymap("n", "<leader>sp", "viw:lua require'spectre'.open_file_search()<cr>", {desc = "search in current file"})

-- fold
keymap('n', 'zR', require('ufo').openAllFolds)
keymap('n', 'zM', require('ufo').closeAllFolds)


local function close_buffer_and_nvimtree(buffer_cmd, last_window_cmd)
  local tree = require("nvim-tree.api").tree
  local buffer_count = #vim.fn.filter(vim.fn.range(1, vim.fn.bufnr '$'), 'buflisted(v:val)')
  local command = buffer_count > 1 and buffer_cmd or last_window_cmd

  tree.toggle({ focus = false })

  local success, errorMsg = pcall(vim.api.nvim_command, command)
  if not success then
    print("Failed to quit: " .. errorMsg)
  end

  tree.toggle({ focus = false })

  if buffer_count == 1 and #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
    vim.cmd("quit")
  end
end

keymap("n", "<Leader>q", function()
  close_buffer_and_nvimtree("bd", "q")
end, { noremap = true, silent = true ,desc = "Close buffer"})
keymap("n", "<Leader>x", function()
  close_buffer_and_nvimtree("bd!", "q!")
end, { noremap = true, silent = true, desc = "Close buffer Force" })

-- termnial

keymap("n", "<leader>tt", ":ToggleTerm<CR>", {desc="Open Termnial"})

