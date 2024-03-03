local telescope = require("telescope")

local actions = require "telescope.actions"

local keymap = vim.keymap.set

local opts = { silent = true }
-- keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
-- keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
-- keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
-- keymap("n","<leader>fr",  ":Telescope oldfiles <CR>",opts)

telescope.setup {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    -- path_display = { "smart" },
    file_ignore_patterns = { ".git/", "node_modules" },

    mappings = {
      i = {
        ["<Down>"] = actions.cycle_history_next,
        ["<Up>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-h>"] = "which_key"
      },
    },
  },
  pickers = {
		find_files = {
			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		},
	},
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
    },
  },
}


-- Enable telescope extensions, if they are installed
pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'ui-select')


-- See `:help telescope.builtin`
local builtin = require 'telescope.builtin'
keymap('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
keymap('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
keymap('n', '<leader>fs', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
keymap('n', '<leader>fw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
keymap('n', '<leader>fd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
keymap('n', '<leader>fr', builtin.resume, { desc = '[S]earch [R]esume' })
keymap('n', '<leader>fo', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
keymap('n', '<leader>fb', builtin.buffers, { desc = '[ ] Find existing buffers' })
keymap('n', '<leader>ff', builtin.find_files, { desc = '[S]earch [F]iles' })
keymap('n', '<leader>ft', builtin.live_grep, { desc = '[S]earch by [G]rep' })



-- Slightly advanced example of overriding default behavior and theme
keymap('n', '<leader>f/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })



-- Also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
keymap('n', '<leader>s/', function()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[S]earch [/] in Open Files' })

-- Shortcut for searching your neovim configuration files
keymap('n', '<leader>sn', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })
