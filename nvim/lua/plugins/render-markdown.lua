-- return {
--   "MeanderingProgrammer/render-markdown.nvim",
--   ft = { "markdown", "quarto" },
--
--   dependencies = {
--     "nvim-treesitter/nvim-treesitter",
--     "nvim-mini/mini.icons", -- lightweight and clean icons
--   },
--
--   opts = {
--     enabled = true,
--
--     -- Only render in normal mode (clean editing experience)
--     render_modes = { "n" },
--
--     heading = {
--       enabled = true,
--       sign = false,
--       icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
--     },
--
--     code = {
--       enabled = true,
--       sign = false,
--       style = "full", -- full-width clean code blocks
--     },
--
--     bullet = {
--       enabled = true,
--       icons = { "●", "○", "◆", "◇" },
--     },
--
--     checkbox = {
--       enabled = true,
--       unchecked = {
--         icon = "󰄱 ",
--         highlight = "DiagnosticWarn",
--       },
--       checked = {
--         icon = "󰱒 ",
--         highlight = "DiagnosticOk",
--       },
--       custom = {
--         in_progress = {
--           raw = "[-]",
--           rendered = "󰥔 ",
--           highlight = "DiagnosticInfo",
--         },
--       },
--     },
--
--     quote = {
--       enabled = true,
--       icon = "▋",
--       repeat_linebreak = false,
--     },
--
--     dash = {
--       enabled = true,
--     },
--
--     pipe_table = {
--       enabled = true,
--     },
--
--     link = {
--       enabled = true,
--       image = "󰥶 ",
--       hyperlink = "󰌹 ",
--       highlight = "Underlined",
--     },
--
--     win_options = {
--       conceallevel = 2,
--       concealcursor = "nc",
--     },
--   },
-- }

return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "quarto" },
  -- lazy = false is fine, but ft = { ... } already handles the lazy loading
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-mini/mini.icons",
  },
  opts = {
    enabled = true,
    -- Removed "t" to avoid terminal lag, added "i" for real-time editing
    render_modes = { "n", "v", "i", "c" },
    win_options = {
      conceallevel = {
        default = vim.o.conceallevel,
        rendered = 2,
      },
      concealcursor = {
        default = vim.o.concealcursor,
        rendered = "nc",
      },
    },
    -- mini.icons is used automatically, but you can force it here:
    anti_conceal = { enabled = true },
  },
}
