local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
  git = {
    clone_timeout = 300, -- Timeout, in seconds, for git clones
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use { "wbthomason/packer.nvim", commit = "6afb67460283f0e990d35d229fd38fdc04063e0a" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim", commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7" } -- Useful lua functions used by lots of plugins
  use { "windwp/nvim-autopairs", commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347" } -- Autopairs, integrates with both cmp and treesitter
  use { "numToStr/Comment.nvim", commit = "97a188a98b5a3a6f9b1b850799ac078faa17ab67" }
  use { "JoosepAlviste/nvim-ts-context-commentstring", commit = "32d9627123321db65a4f158b72b757bcaef1a3f4" }
  use { "kyazdani42/nvim-web-devicons", commit = "563f3635c2d8a7be7933b9e547f7c178ba0d4352" }
  use { "kyazdani42/nvim-tree.lua", commit = "7282f7de8aedf861fe0162a559fc2b214383c51c" }
  use { "akinsho/bufferline.nvim", commit = "83bf4dc7bff642e145c8b4547aa596803a8b4dc4" }
  use { "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" }
  use { "nvim-lualine/lualine.nvim", commit = "a52f078026b27694d2290e34efa61a6e4a690621" }
  use { "akinsho/toggleterm.nvim", commit = "2a787c426ef00cb3488c11b14f5dcf892bbd0bda" }
  use { "ahmedkhalf/project.nvim", commit = "628de7e433dd503e782831fe150bb750e56e55d6" }
  use { "lewis6991/impatient.nvim", commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6" }
  use { "lukas-reineke/indent-blankline.nvim", commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6" }
  -- dashboard
  use { "goolord/alpha-nvim", commit = "0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31"  }

  -- Colorschemes
  use { "folke/tokyonight.nvim", commit = "66bfc2e8f754869c7b651f3f47a2ee56ae557764" }
  use { "lunarvim/darkplus.nvim", commit = "13ef9daad28d3cf6c5e793acfc16ddbf456e1c83" }

  -- cmp plugins
  use { "hrsh7th/nvim-cmp", } -- The completion plugin
  use { "hrsh7th/cmp-buffer",} -- buffer completions
  use { "hrsh7th/cmp-path",} -- path completions
  use { "saadparwaiz1/cmp_luasnip", } -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp", }
  use { "hrsh7th/cmp-nvim-lua", }

  -- snippets
  use { "L3MON4D3/LuaSnip", commit = "8f8d493e7836f2697df878ef9c128337cbf2bb84" } --snippet engine
  use { "rafamadriz/friendly-snippets", commit = "2be79d8a9b03d4175ba6b3d14b082680de1b31b1" } -- a bunch of snippets to use

  -- LSP
  -- use { "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" } -- simple to use language server installer
  use { "neovim/nvim-lspconfig"} -- enable LSP
  use { "williamboman/mason.nvim", }
  use { "williamboman/mason-lspconfig.nvim"}
  use { "jose-elias-alvarez/null-ls.nvim", commit = "c0c19f32b614b3921e17886c541c13a72748d450" } -- for formatters and linters
  use { "RRethy/vim-illuminate"}

  -- Telescope
  use { "nvim-telescope/telescope.nvim", commit = "76ea9a898d3307244dce3573392dcf2cc38f340f" }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    commit = "8e763332b7bf7b3a426fd8707b7f5aa85823a5ac",
  }

  -- Git
  use { "lewis6991/gitsigns.nvim", commit = "f98c85e7c3d65a51f45863a34feb4849c82f240f" }
  use {'f-person/git-blame.nvim'}
  use {'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim'}

  -- DAP
  use { "mfussenegger/nvim-dap", commit = "6b12294a57001d994022df8acbe2ef7327d30587" }
  use { "rcarriga/nvim-dap-ui", commit = "1cd4764221c91686dcf4d6b62d7a7b2d112e0b13" }
  use { "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" }


  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use  {
    "wfxr/minimap.vim",
  }
  use {'kevinhwang91/nvim-ufo',
    requires = 'kevinhwang91/promise-async',
  }
  use {
    "olimorris/onedarkpro.nvim",
    config = function() require("onedarkpro").setup() end,
  }
  -- golang
  use {
    "ray-x/go.nvim",
    event = "VimEnter",
    config = function() require("go").setup() end,
  }
  use 'ray-x/guihua.lua'


  use {
    's1n7ax/nvim-window-picker',
    tag = 'v1.*',
    config = function()
      require'window-picker'.setup()
    end,
  }

  use {
    'windwp/nvim-spectre'
  }

  use {'karb94/neoscroll.nvim'}

  use {
    "ellisonleao/glow.nvim",
    config = function ()
      require('glow').setup()
    end,
  }
  use {
    'theHamsta/nvim-dap-virtual-text',
    config = function ()
      require("nvim-dap-virtual-text").setup()
    end
  }


  use { 
    'Exafunction/codeium.vim',
    config = function ()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true })
      vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
      vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    end
  }

  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
