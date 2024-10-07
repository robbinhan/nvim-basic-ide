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

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "Lazygit" })
keymap("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = "Git Diff" })

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", { desc = "Comment" })
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
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", { desc = "Format" })

-- makrdown
keymap("n", "<leader>mp", ":Glow<cr>", { desc = "Preview current markdown file" })


-- pick window
keymap("n", "<leader>w", function()
  local picked_window_id = require('window-picker').pick_window() or vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(picked_window_id)
end, { desc = "Pick a window" })

-- spectre
keymap("n", "<leader>S", "<cmd>lua require'spectre'.open()<cr>", { desc = "Search and Replace with spectre" })
-- search current word
keymap("n", "<leader>sw", "<cmd>lua require'spectre'.open_visual({select_word=true})<cr>",
  { desc = "search current word" })
-- search in current file
keymap("n", "<leader>sp", "viw:lua require'spectre'.open_file_search()<cr>", { desc = "search in current file" })

-- fold
-- keymap('n', 'zR', require('ufo').openAllFolds)
-- keymap('n', 'zM', require('ufo').closeAllFolds)


-- keymap("n", "<Leader>x", "<cmd>bd", { noremap = true, silent = true, desc = "Close buffer" })

-- termnial

keymap("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "Open Termnial" })


-- oscyank
keymap("n", "<Leader>c", '<Plug>OSCYankOperator')
keymap("n", "<Leader>cc", '<leader>c_', { remap = true })
keymap("v", "<Leader>c", '<Plug>OSCYankVisual')

-- lspsaga
-- LSP finder - Find the symbol's definition
-- If there is no definition, it will instead be hidden
-- When you use an action in finder like "open vsplit",
-- you can use <C-t> to jump back
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

-- Code action
keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

-- Rename all occurrences of the hovered word for the entire file
keymap("n", "gr", "<cmd>Lspsaga rename<CR>")

-- Rename all occurrences of the hovered word for the selected files
keymap("n", "gr", "<cmd>Lspsaga rename ++project<CR>")

-- Peek definition
-- You can edit the file containing the definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>")

-- Go to definition
keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>")

-- Peek type definition
-- You can edit the file containing the type definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
keymap("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")

-- Go to type definition
keymap("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>")


-- Show line diagnostics
-- You can pass argument ++unfocus to
-- unfocus the show_line_diagnostics floating window
keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")

-- Show buffer diagnostics
keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

-- Show workspace diagnostics
keymap("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>")

-- Show cursor diagnostics
keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

-- Diagnostic jump
-- You can use <C-o> to jump back to your previous location
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

-- Diagnostic jump with filters such as only jumping to an error
keymap("n", "[E", function()
  require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)
keymap("n", "]E", function()
  require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end)

-- Toggle outline
keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>")

-- Hover Doc
-- If there is no hover doc,
-- there will be a notification stating that
-- there is no information available.
-- To disable it just use ":Lspsaga hover_doc ++quiet"
-- Pressing the key twice will enter the hover window
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")

-- If you want to keep the hover window in the top right hand corner,
-- you can pass the ++keep argument
-- Note that if you use hover with ++keep, pressing this key again will
-- close the hover window. If you want to jump to the hover window
-- you should use the wincmd command "<C-w>w"
keymap("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>")

-- Call hierarchy
keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

-- Floating terminal
keymap({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")


-- lspimport
keymap("n", "<leader>a", function()
  require("lspimport").import()
end, { noremap = true, desc = "Python Auto Import" })



keymap("n", "<leader>rn", ":IncRename ")


-- mouse users + nvimtree users!
vim.keymap.set("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local neogit_options = {
    {
      name = "Neogit",
      cmd = function()
        vim.cmd "Neogit"
      end,
    },
  }
  local options = {
    {
      name = "Code Actions",
      cmd = vim.lsp.buf.code_action,
      rtxt = "<leader>ca",
    },

    { name = "separator" },

    {
      name = "  Lsp Actions",
      hl = "Exblue",
      items = "lsp",
    },
    { name = "separator" },
    {
      name = " Gitsigns Actions",
      hl = "Exblue",
      items = "gitsigns",
    },
    { name = "separator" },
    {
      name = "  Neogit Actions",
      hl = "Exblue",
      items = neogit_options,
    },
    { name = "separator" },
    {
      name = "Edit Config",
      cmd = function()
        vim.cmd "tabnew"
        local conf = vim.fn.stdpath "config"
        vim.cmd("tcd " .. conf .. " | e init.lua")
      end,
      rtxt = "ed",
    },

    { name = "separator" },

    {
      name = "  Open in terminal",
      hl = "ExRed",
      cmd = function()
        local old_buf = require("menu.state").old_data.buf
        local old_bufname = vim.api.nvim_buf_get_name(old_buf)
        local old_buf_dir = vim.fn.fnamemodify(old_bufname, ":h")

        local cmd = "cd " .. old_buf_dir

        -- base46_cache var is an indicator of nvui user!
        if vim.g.base46_cache then
          require("nvchad.term").new { cmd = cmd, pos = "sp" }
        else
          vim.cmd "enew"
          vim.fn.termopen { vim.o.shell, "-c", cmd .. " ; " .. vim.o.shell }
        end
      end,
    },

    { name = "separator" },

    {
      name = "  Color Picker",
      cmd = function()
        require("minty.huefy").open()
      end,
    },
  }
  require("menu").open(options, { mouse = true })
end, {})
