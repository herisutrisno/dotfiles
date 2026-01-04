-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          filetypes = { "typescript", "typescriptreact", "tsx" },
          settings = {
            vtsls = {
              enableMoveToFileCodeAction = true,
              -- Add other custom settings here
            },
          },
        },
        gopls = {
          settings = {
            gopls = {
              usePlaceholders = true,
              staticcheck = true,
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true, -- 👈 turn OFF the annoying a: hints
                rangeVariableTypes = true,
              },
            },
          },
        },
      },
    },
  },
}
