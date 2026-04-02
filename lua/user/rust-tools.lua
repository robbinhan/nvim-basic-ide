vim.g.rustaceanvim = {
  server = {
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "<C-space>", function()
        vim.cmd.RustLsp { 'hover', 'actions' }
      end, { buffer = bufnr })
      vim.keymap.set("n", "<Leader>a", function()
        vim.cmd.RustLsp('codeAction')
      end, { buffer = bufnr })
    end,
    default_settings = {
      ['rust-analyzer'] = {
        diagnostics = {
          enable = true,
        },
      },
    },
  },
}
