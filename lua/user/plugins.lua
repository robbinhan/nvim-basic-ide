local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Install your plugins here
return require("lazy").setup({
  {
    "Mr-LLLLL/lualine-ext.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lualine/lualine.nvim",
      -- if you want to open telescope window when click on LSP info of lualine, uncomment it
      -- "nvim-telescope/telescope.nvim"
    },
    opts = {
      separator = {
        left = "",
        right = "",
      },
      init_tab_project = {
        disabled = false,
        -- set this for your colorscheme. I have not default setting in diff colorcheme.
        tabs_color = {
          inactive = {
            fg = "#9da9a0",
            bg = "#4f5b58",
          },
        }
      },
      init_lsp = {
        disabled = false,
      },
      init_tab_date = true,
    }
  },
  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
  },
  {
    "rolv-apneseth/tfm.nvim",
    lazy = false,
    config = function()
      -- Set keymap so you can open the default terminal file manager (yazi)
      vim.api.nvim_set_keymap("n", "<leader>e", "TFM", {
        noremap = true,
        callback = require("tfm").open,
      })
    end,
  },
  {
    "echasnovski/mini.bufremove",
    keys = {
      { "<leader>x", "<cmd>lua MiniBufremove.delete()<CR>", desc = "Buf Delete" },
    },
    version = "*",
    config = true,
  },
  -- db manage
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { 'tpope/vim-dadbod',                     lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  { -- Autoformat
    'stevearc/conform.nvim',
    event = "LspAttach",
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform will run multiple formatters sequentially
        go = { "goimports", "gofmt" },
        -- Use a sub-list to run only the first available formatter
        javascript = { { "prettierd", "prettier" } },
        -- You can use a function here to determine the formatters dynamically
        python = function(bufnr)
          if require("conform").get_formatter_info("ruff_format", bufnr).available then
            return { "ruff_format" }
          else
            return { "isort", "black" }
          end
        end,
        -- Use the "*" filetype to run formatters on all filetypes.
        ["*"] = { "codespell" },
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ["_"] = { "trim_whitespace" },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
      },
    },
  },
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  {
    'mikesmithgh/kitty-scrollback.nvim',
    enabled = true,
    lazy = true,
    cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
    event = { 'User KittyScrollbackLaunch' },
    -- version = '*', -- latest stable version, may have breaking changes if major version changed
    -- version = '^2.0.0', -- pin major version, include fixes and features that do not have breaking changes
    config = function()
      require('kitty-scrollback').setup()
    end,
  },
  -- Lazy
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    },
    config = function()
      require('user.chatgpt')
    end
  },
  -- {
  --   "piersolenski/wtf.nvim",
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --   },
  --   opts = {},
  --   keys = {
  --     {
  --       "gw",
  --       mode = { "n", "x" },
  --       function()
  --         require("wtf").ai()
  --       end,
  --       desc = "Debug diagnostic with AI",
  --     },
  --     {
  --       mode = { "n" },
  --       "gW",
  --       function()
  --         require("wtf").search()
  --       end,
  --       desc = "Search diagnostic with Google",
  --     },
  --   },
  --   config = function()
  --     require('user.wtf')
  --   end
  -- },
  {
    "stevanmilic/nvim-lspimport",
    lazy = false
  },
  {
    'luk400/vim-jukit',
  },
  -- {
  --   'echasnovski/mini.files',
  --   version = '*',
  --   config = function()
  --     require('mini.files').setup()
  --   end,
  --   lazy = false
  -- },
  -- { 'echasnovski/mini.statusline', version = '*' },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require('user.noice')
    end,
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },
  -- {
  --   'huggingface/llm.nvim',
  --   opts = {
  --     -- cf Setup
  --   },
  --   config = function()
  --     require("user.llm")
  --   end,
  --   lazy = false,
  -- },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim",        -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    lazy = false,
    config = true
  },
  {
    "simrat39/rust-tools.nvim",
    ft = { "rs" },
    event = { "CmdlineEnter" },
    config = function()
      require("user.rust-tools")
    end,
  },
  {
    "dstein64/vim-startuptime", -- lazy-load on a command
    cmd = "StartupTime",
    -- init is called during startup. Configuration for vim plugins typically should be set in an init function
    init = function()
      vim.g.startuptime_tries = 10
    end
  },
  -- My plugins here
  { "nvim-lua/plenary.nvim", }, -- Useful lua functions used by lots of plugins
  { "windwp/nvim-autopairs", }, -- Autopairs, integrates with both cmp and treesitter
  { "numToStr/Comment.nvim",   config = function() require "user.comment" end, event = "LspAttach" },
  -- { "nvim-tree/nvim-tree.lua",
  --   version = "*",
  --   lazy = false,
  --   dependencies = {
  --     "nvim-tree/nvim-web-devicons",
  --   },
  --   config = function()
  --     require("user.nvim-tree")
  --   end,
  -- },
  { 'akinsho/bufferline.nvim', version = "*",                                  dependencies = 'nvim-tree/nvim-web-devicons', event = { "BufEnter" }, cond = firenvim_not_active, },
  { "moll/vim-bbye", }, -- delete buffer
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("user.lualine")
    end,
    event = 'VimEnter',
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("user.toggleterm")
    end,
    event = 'VimEnter',
  },
  -- { "ahmedkhalf/project.nvim",config = function() require "user.project" end  },
  -- { "lukas-reineke/indent-blankline.nvim", config = function() require "user.indentline" end },
  -- dashboard
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('user.dashboard')
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
  },

  -- Colorschemes
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      -- Load the colorscheme here
      vim.cmd.colorscheme 'tokyonight-night'

      -- You can configure highlights by doing something like
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  -- cmp plugins
  {
    "hrsh7th/nvim-cmp", -- load cmp on InsertEnter
    event = "InsertEnter",
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets
          -- This step is not supported in many windows environments
          -- Remove the below condition to re-enable on windows
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-path',
    },
    config = function()
      require "user.cmp"
    end,
  },                               -- The completion plugin
  -- { "hrsh7th/cmp-buffer",}, -- buffer completions
  { "hrsh7th/cmp-path", },         -- path completions
  { "saadparwaiz1/cmp_luasnip", }, -- snippet completions
  { "hrsh7th/cmp-nvim-lsp", },
  -- { "hrsh7th/cmp-nvim-lua", },

  -- snippets
  {
    "L3MON4D3/LuaSnip", -- follow latest release.
    lazy = true,
    version = "2.*",    -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
  },                                   --snippet engine
  { "rafamadriz/friendly-snippets", }, -- a bunch of snippets to use

  -- LSP
  {
    "neovim/nvim-lspconfig",
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require("user.lsp")
    end,
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },
    },
  }, -- enable LSP
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "RRethy/vim-illuminate",            config = function() require("user.illuminate") end },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for install instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires special font.
      --  If you already have a Nerd Font, or terminal set up with fallback fonts
      --  you can enable this
      -- { 'nvim-tree/nvim-web-devicons' }
    },
    config = function() require("user.telescope") end
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function()
      require("user.treesitter")
    end,
  },

  -- Git
  { "lewis6991/gitsigns.nvim",  config = function() require('user.gitsigns') end, event = "LspAttach" },
  { 'f-person/git-blame.nvim',  event = "LspAttach" },
  { 'sindrets/diffview.nvim',   dependencies = 'nvim-lua/plenary.nvim' },

  -- DAP
  { "mfussenegger/nvim-dap",    config = function() require "user.dap" end },
  { "rcarriga/nvim-dap-ui", },
  { "ravenxrz/DAPInstall.nvim", },
  {
    'theHamsta/nvim-dap-virtual-text',
    config = function()
      require("nvim-dap-virtual-text").setup()
    end
  },


  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      local wk = require("which-key")
      wk.register({
        ["<leader>n"] = { name = "+nnn" },
        -- ["gt"] = { name = "+Neorg Tasks" },
      })
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },

  {
    'kevinhwang91/nvim-ufo',
    event = "LspAttach",
    dependencies = { 'kevinhwang91/promise-async', },
    config = function()
      require "user.ufo"
    end
  },
  -- golang
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require "user.ray_x_go"
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
  'ray-x/guihua.lua',
  {
    's1n7ax/nvim-window-picker',
    name = 'window-picker',
    event = 'VeryLazy',
    version = '2.*',
    config = function()
      require 'window-picker'.setup()
    end,
  },
  {
    'windwp/nvim-spectre'
  },
  { 'karb94/neoscroll.nvim' },

  {
    "ellisonleao/glow.nvim", config = true, cmd = "Glow"
  },
  {
    "ojroques/vim-oscyank",
  },
  {
    "folke/todo-comments.nvim",
    event = "LspAttach",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to the default settings
        -- refer to the configuration section below
      }
    end
  },
  {
    "nvimdev/lspsaga.nvim",
    -- after = 'nvim-lspconfig',
    -- opt = true,
    -- branch = "main",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        debug = false,
        use_saga_diagnostic_sign = true,
        -- diagnostic sign
        error_sign = "",
        warn_sign = "",
        hint_sign = "",
        infor_sign = "",
        diagnostic_header_icon = "   ",
        -- code action title icon
        code_action_icon = " ",
        code_action_prompt = { enable = true, sign = true, sign_priority = 40, virtual_text = true },
        finder_definition_icon = "  ",
        finder_reference_icon = "  ",
        max_preview_lines = 10,

        finder_action_keys = {
          open = "o",
          vsplit = "s",
          split = "i",
          quit = "q",
          scroll_down = "<C-f>",
          scroll_up = "<C-b>",
        },

        hover = {
          max_width = 0.7,
        },

        code_action_keys = { quit = "q", exec = "<CR>" },
        rename_action_keys = { quit = "<C-c>", exec = "<CR>" },
        definition_preview_icon = "  ",
        border_style = "single",
        rename_prompt_prefix = "➤",
        server_filetype_map = {},
        diagnostic_prefix_format = "%d. ",
      })
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  -- {
  --   "luukvbaal/nnn.nvim", config = function() require('user.nnn') end, lazy = false
  -- },
  -- {
  --   "nvim-neorg/neorg",
  --   ft = "norg",
  --   -- lazy = false,
  --   build = ":Neorg sync-parsers",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function()
  --     require("neorg").setup {
  --       load = {
  --         ["core.keybinds"] = {
  --           config = {
  --           -- not remapping existing keybinds, only adding opts desc for which-key
  --           hook = function(keybinds)
  --            keybinds.unmap("norg", "n", "gtd")
  --            keybinds.map_event("norg", "n", "gtd", "core.norg.qol.todo_items.todo.task_done", { desc = "Task Done" })
  --
  --            keybinds.unmap("norg", "n", "gtu")
  --            keybinds.map_event("norg", "n", "gtu", "core.norg.qol.todo_items.todo.task_undone", { desc = "Task Undone" })
  --
  --            keybinds.unmap("norg", "n", "gtp")
  --            keybinds.map_event("norg", "n", "gtp", "core.norg.qol.todo_items.todo.task_pending", { desc = "Task Pending" })
  --
  --            keybinds.unmap("norg", "n", "gth")
  --            keybinds.map_event("norg", "n", "gth", "core.norg.qol.todo_items.todo.task_on_hold", { desc = "Task On Hold" })
  --
  --            keybinds.unmap("norg", "n", "gtc")
  --            keybinds.map_event("norg", "n", "gtc", "core.norg.qol.todo_items.todo.task_cancelled", { desc = "Task Cancelled" })
  --
  --            keybinds.unmap("norg", "n", "gtr")
  --            keybinds.map_event("norg", "n", "gtr", "core.norg.qol.todo_items.todo.task_recurring", { desc = "Task Recurring" })
  --
  --            keybinds.unmap("norg", "n", "gti")
  --            keybinds.map_event("norg", "n", "gti", "core.norg.qol.todo_items.todo.task_important", { desc = "Task Important" })
  --
  --            keybinds.unmap("norg", "n", "<leader>nn")
  --            keybinds.map_event("norg", "n", "<leader>nn", "core.norg.dirman.new.note", { desc = "New Note" })
  --           end
  --           },
  --         },
  --         ["core.defaults"] = {}, -- Loads default behaviour
  --         ["core.concealer"] = {}, -- Adds pretty icons to your documents
  --         ["core.dirman"] = { -- Manages Neorg workspaces
  --           config = {
  --             workspaces = {
  --               work = "~/notes/work",
  --               home = "~/notes/home",
  --             },
  --           },
  --         },
  --         ["core.export"] = {},
  --       },
  --     }
  --   end,
  -- },
}, {
  defaults = {
    lazy = true, -- should plugins be lazy-loaded?
  },
  checker = {
    enabled = false,
  },
}
)
