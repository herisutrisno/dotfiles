-- File: lua/plugins/colorscheme.lua

return {
  -- Catppuccin theme plugin (higher priority to ensure it's loaded first)
  { -- was missing this
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      transparent_background = true,
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },
  -- Solarized Osaka theme plugin (lower priority to load it later)
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = true,
    priority = 1000, -- Lower priority so it loads after Catppuccin
    opts = function()
      return {
        transparant = true,
      }
    end,
  },
}
