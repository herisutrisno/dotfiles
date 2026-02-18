return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",

  opts = {
    ensure_installed = {
      -- Core
      "bash",
      "lua",
      "vim",
      "vimdoc",
      "query",
      "regex",

      -- Web
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "json",
      "yaml",

      -- Markdown
      "markdown",
      "markdown_inline",

      -- Backend
      "python",
      "go",
      "gomod",
      "gowork",
      "gosum",
    },
    highlight = {
      enable = true,
      disable = function(_, buf)
        -- handle large filessize
        local max_filesize = 100 * 1024
        local filename = vim.api.nvim_buf_get_name(buf)

        local uv = vim.uv or vim.loop
        local ok, stats = pcall(uv.fs_stat, filename)

        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
    },
    indent = {
      enable = true,
    },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        node_decremental = "<bs>",
      },
    },
  },
}
