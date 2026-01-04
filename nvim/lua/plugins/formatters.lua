return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      go = { "goimports", "gofumpt", "golines" }, -- or use {"goimports"} if you prefer
    },
  },
}
