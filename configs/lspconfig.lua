local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local defaulting_servers = { "html", "cssls", "tsserver", "clangd", "texlab"}

for _, lsp in ipairs(defaulting_servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- custom server configurations
lspconfig["rust_analyzer"].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
        check = {
            command = "clippy",
        },
    },
  },
}

