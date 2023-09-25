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
  { "numToStr/Comment.nvim",  },
  { "JoosepAlviste/nvim-ts-context-commentstring", },
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
  { "moll/vim-bbye", },
  { "nvim-lualine/lualine.nvim", },
  { "akinsho/toggleterm.nvim",  },
  { "ahmedkhalf/project.nvim",  },
  { "lewis6991/impatient.nvim",},
  { "lukas-reineke/indent-blankline.nvim", },
  -- dashboard
  { "goolord/alpha-nvim",  },

  -- Colorschemes
  { "folke/tokyonight.nvim", },
  { "lunarvim/darkplus.nvim",  },

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
      -- require("config.nvim-cmp")
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
	  build = "make install_jsregexp"
  }, --snippet engine
  { "rafamadriz/friendly-snippets",  }, -- a bunch of snippets to use

  -- LSP
  { "williamboman/nvim-lsp-installer",  }, -- simple to language server installer
  { 
    "neovim/nvim-lspconfig",
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      -- require("config.lsp")
    end,}, -- enable LSP
  { "williamboman/mason.nvim"},
  { "williamboman/mason-lspconfig.nvim"},
  { "jose-elias-alvarez/null-ls.nvim"}, -- for formatters and linters
  { "RRethy/vim-illuminate"},

  -- Telescope
  { "nvim-telescope/telescope.nvim", },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function()
      -- require("config.treesitter")
    end,
  },

  -- Git
  { "lewis6991/gitsigns.nvim",  },
  {'f-person/git-blame.nvim'},
  {'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim'},

  -- DAP
  { "mfussenegger/nvim-dap",  },
  { "rcarriga/nvim-dap-ui",  },
  { "ravenxrz/DAPInstall.nvim",  },


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
  
  {'kevinhwang91/nvim-ufo', dependencies = {'kevinhwang91/promise-async',},config = function ()
    -- Option 2: nvim lsp as LSP client
    -- Tell the server the capability of foldingRange,
    -- Neovim hasn't added foldingRange to default capabilities, users must add it manually
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }
    local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'},
    for _, ls in ipairs(language_servers) do
      require('lspconfig')[ls].setup({
        capabilities = capabilities
        -- you can add other fields for setting up lsp server in this table
      })
    end
    require('ufo').setup()
  end
  },
  {
    "olimorris/onedarkpro.nvim",
    config = function() require("onedarkpro").setup() end,
  },
  -- golang
  {
    "ray-x/go.nvim",
    event = "VimEnter",
    config = function() require("go").setup() end,
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
    "ellisonleao/glow.nvim",
    config = function ()
      require('glow').setup()
    end,
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    config = function ()
      require("nvim-dap-virtual-text").setup()
    end
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
    -- event = "LspAttach",
    config = function()
      require("lspsaga").setup({})
    end,
    dependencies = {
      {"nvim-tree/nvim-web-devicons"},
      --Please make sure you install markdown and markdown_inline parser
      {"nvim-treesitter/nvim-treesitter"},
    },
  }
}
-- ,
  -- {
  --   defaults = {
  --     lazy = true, -- should plugins be lazy-loaded?
  --   },
  --   checker = {
  --     enabled = true,
  --   },
  -- }
)
