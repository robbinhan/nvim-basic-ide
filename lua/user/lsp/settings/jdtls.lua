-- require 'lspconfig'.jdtls.setup {}


local jdtls_bin = vim.fn.stdpath("data") .. "/mason/bin/jdtls"


return {
  cmd = { jdtls_bin },
}
