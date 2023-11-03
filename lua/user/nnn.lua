-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }



keymap("n","<leader>nn", ":NnnExplorer<CR>", opts)
keymap("n","<leader>np", ":NnnPicker<CR>", opts)

require('nnn').setup({
  picker = {
    cmd = "tmux new-session nnn  -d -i -U -o -G -Pp",
    style = { border = "rounded" },
    session = "shared",
  }
})
