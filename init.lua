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
