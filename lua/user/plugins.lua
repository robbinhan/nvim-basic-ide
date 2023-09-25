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
    end
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
    opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    }
  },
  
  {'kevinhwang91/nvim-ufo', dependencies = {'kevinhwang91/promise-async',}, config = function() require "user.ufo" end},
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
  }
},{
    defaults = {
      lazy = true, -- should plugins be lazy-loaded?
    },
    checker = {
      enabled = true,
    },
  }
)
