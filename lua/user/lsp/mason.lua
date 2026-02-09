local servers = {
  "lua_ls",
  "gopls",
  "pyright",
  "ruff",
  "ts_ls",
  "rust_analyzer",
}

local settings = {
  ui = {
    border = "none",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

require("mason").setup(settings)

require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})

require('mason-tool-installer').setup {
  ensure_installed = {
    'stylua',
  }
}

require("user.lsp.handlers").setup()

local capabilities = require("user.lsp.handlers").capabilities

vim.lsp.config('*', {
  capabilities = capabilities,
  root_markers = { '.git' },
})

for _, server in pairs(servers) do
  server = vim.split(server, "@")[1]

  local opts = {}
  local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
  if require_ok then
    opts = vim.tbl_deep_extend("force", opts, conf_opts)
  end

  vim.lsp.config(server, opts)
end

vim.lsp.enable(servers)
