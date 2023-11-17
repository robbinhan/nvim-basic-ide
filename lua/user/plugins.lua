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
    "folke/noice.nvim",
    event = "VeryLazy",
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
  {
    'huggingface/llm.nvim',
    opts = {
      -- cf Setup
    },
    config = function()
      require("user.llm")
    end,
    lazy = false,
  },
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
    ft = {"rs"},
    event = {"CmdlineEnter"},
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
  { "nvim-lua/plenary.nvim",  }, -- Useful lua functions used by lots of plugins
  { "windwp/nvim-autopairs",  }, -- Autopairs, integrates with both cmp and treesitter
  { "numToStr/Comment.nvim",  config = function() require "user.comment" end},
  { "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("user.nvim-tree")
    end,
  },
  {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons', event = { "BufEnter" } , cond = firenvim_not_active,},
  { "moll/vim-bbye", }, -- delete buffer
  { 
    "nvim-lualine/lualine.nvim",
    config = function()
      require("user.lualine")
    end
  },
  { "akinsho/toggleterm.nvim",  version = "*", 
    config = function()
      require("user.toggleterm")
    end,
    event = 'VimEnter',
  },
  -- { "ahmedkhalf/project.nvim",config = function() require "user.project" end  },
  { "lukas-reineke/indent-blankline.nvim", config = function() require "user.indentline" end },
  -- dashboard
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('user.dashboard') 
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
  },

  -- Colorschemes
  { "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {}
  },

  -- cmp plugins
  { 
    "hrsh7th/nvim-cmp",-- load cmp on InsertEnter
    event = "InsertEnter",
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      require "user.cmp"
    end,
  }, -- The completion plugin
  -- { "hrsh7th/cmp-buffer",}, -- buffer completions
  { "hrsh7th/cmp-path",}, -- path completions
  { "saadparwaiz1/cmp_luasnip", }, -- snippet completions
  { "hrsh7th/cmp-nvim-lsp", },
  -- { "hrsh7th/cmp-nvim-lua", },

  -- snippets
  {
    "L3MON4D3/LuaSnip",  -- follow latest release.
    lazy = true,
	  version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	  -- install jsregexp (optional!).
	  build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
  }, --snippet engine
  { "rafamadriz/friendly-snippets",  }, -- a bunch of snippets to use

  -- LSP
  { 
    "neovim/nvim-lspconfig",
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require("user.lsp")
    end,
  }, -- enable LSP
  { "williamboman/mason.nvim"},
  { "williamboman/mason-lspconfig.nvim"},
  { "RRethy/vim-illuminate",config = function() require("user.illuminate") end},

  -- Telescope
  { "nvim-telescope/telescope.nvim", dependencies = { 'nvim-lua/plenary.nvim' }, config = function() require("user.telescope") end, lazy = false },

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
  { "lewis6991/gitsigns.nvim", config = function() require('user.gitsigns') end  },
  {'f-person/git-blame.nvim'},
  {'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim'},

  -- DAP
  { "mfussenegger/nvim-dap", config = function() require "user.dap" end },
  { "rcarriga/nvim-dap-ui",  },
  { "ravenxrz/DAPInstall.nvim",  },
  {
    'theHamsta/nvim-dap-virtual-text',
    config = function ()
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
        ["<leader>n"] = { name = "+Neorg" },
        ["gt"] = { name = "+Neorg Tasks" },
      })
    end,
    opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
      
    }
  },
  
  {'kevinhwang91/nvim-ufo', event = "LspAttach", dependencies = {'kevinhwang91/promise-async',}, config = function() require "user.ufo" end},
  -- golang
  {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require "user.ray_x_go"
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
  'ray-x/guihua.lua',
  {
      's1n7ax/nvim-window-picker',
      name = 'window-picker',
      event = 'VeryLazy',
      version = '2.*',
      config = function()
          require'window-picker'.setup()
      end,
  },
  {
    'windwp/nvim-spectre'
  },
  {'karb94/neoscroll.nvim'},
  
  {
    "ellisonleao/glow.nvim", config = true, cmd = "Glow"
  },
  {
    "ojroques/vim-oscyank",
  },
  {
    "folke/todo-comments.nvim",
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
      require("lspsaga").setup({})
    end,
    dependencies = {
      {"nvim-tree/nvim-web-devicons"},
      --Please make sure you install markdown and markdown_inline parser
      {"nvim-treesitter/nvim-treesitter"},
    },
  },
  {
  "luukvbaal/nnn.nvim",config = function() require('user.nnn') end, lazy=false
  },
  {
    "nvim-neorg/neorg",
    ft = "norg",
    -- lazy = false,
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup {
        load = {
          ["core.keybinds"] = {
            config = {
            -- not remapping existing keybinds, only adding opts desc for which-key
            hook = function(keybinds)
             keybinds.unmap("norg", "n", "gtd")
             keybinds.map_event("norg", "n", "gtd", "core.norg.qol.todo_items.todo.task_done", { desc = "Task Done" })

             keybinds.unmap("norg", "n", "gtu")
             keybinds.map_event("norg", "n", "gtu", "core.norg.qol.todo_items.todo.task_undone", { desc = "Task Undone" })

             keybinds.unmap("norg", "n", "gtp")
             keybinds.map_event("norg", "n", "gtp", "core.norg.qol.todo_items.todo.task_pending", { desc = "Task Pending" })

             keybinds.unmap("norg", "n", "gth")
             keybinds.map_event("norg", "n", "gth", "core.norg.qol.todo_items.todo.task_on_hold", { desc = "Task On Hold" })

             keybinds.unmap("norg", "n", "gtc")
             keybinds.map_event("norg", "n", "gtc", "core.norg.qol.todo_items.todo.task_cancelled", { desc = "Task Cancelled" })

             keybinds.unmap("norg", "n", "gtr")
             keybinds.map_event("norg", "n", "gtr", "core.norg.qol.todo_items.todo.task_recurring", { desc = "Task Recurring" })

             keybinds.unmap("norg", "n", "gti")
             keybinds.map_event("norg", "n", "gti", "core.norg.qol.todo_items.todo.task_important", { desc = "Task Important" })

             keybinds.unmap("norg", "n", "<leader>nn")
             keybinds.map_event("norg", "n", "<leader>nn", "core.norg.dirman.new.note", { desc = "New Note" })
            end
            },
          },
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                work = "~/notes/work",
                home = "~/notes/home",
              },
            },
          },
          ["core.export"] = {},
        },
      }
    end,
  },
},{
    defaults = {
      lazy = true, -- should plugins be lazy-loaded?
    },
    checker = {
      enabled = false,
    },
  }
)
