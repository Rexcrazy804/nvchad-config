local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local defaulting_servers = { "html", "cssls", "tsserver", "clangd", "texlab", "zls", "pyright", "nushell"}

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
      rustfmt = {
        overrideCommand = { "leptosfmt", "--stdin", "--rustfmt" },
      },
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      check = {
        command = "clippy",
      },
      procMacro = {
        enable = true,
        ignored = {
          leptos_macro = {
            -- optional: --
            -- "component",
            "server",
          },
        },
      },
    },
  },
}

lspconfig.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  autostart = false,
  filetypes = {
    "rust",
    -- html
    'html',
    'css',
    -- js
    'javascript',
    'typescript',
    -- php
    'php',
  },
  init_options = {
    userLanguages = {
      rust = "html",
    },
  },
}
