return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      preset = "helix",
      defaults = {},
      spec = {
        {
          mode = { "n", "x" },
          -- Navigation & Layout
          {
            "<leader><tab>",
            group = "tabs",
          },
          {
            "<leader>b",
            group = "buffer",
            expand = function()
              return require("which-key.extras").expand.buf()
            end,
          },
          {
            "<leader>w",
            group = "windows",
            proxy = "<c-w>",
            expand = function()
              return require("which-key.extras").expand.win()
            end,
          },

          -- Coding & Tools
          {
            "<leader>c",
            group = "code",
          },
          {
            "<leader>d",
            group = "debug",
          },
          {
            "<leader>dp",
            group = "profiler",
          },
          {
            "<leader>f",
            group = "file/find",
          },

          -- Version Control
          {
            "<leader>g",
            group = "git",
          },
          {
            "<leader>gh",
            group = "hunks",
          },

          -- Content & Session
          {
            "<leader>m",
            group = "markdown",
            icon = { cat = "file", name = "README.md" },
          },
          {
            "<leader>q",
            group = "quit/session",
          }, -- Power/Exit icon
          {
            "<leader>s",
            group = "search",
          },
          {
            "<leader>u",
            group = "ui",
          },
          {
            "<leader>x",
            group = "diagnostics/quickfix",
          },

          -- Motion & Editing
          { "[", group = "prev" },
          { "]", group = "next" },
          {
            "g",
            group = "goto",
          },
          {
            "gs",
            group = "surround",
          },
          { "z", group = "fold" },

          -- Better descriptions
          { "gx", desc = "Open with system app" },

          -- Split terminal
          {
            "<leader>t",
            group = "terminal",
            icon = { cat = "filetype", name = "bash" },
          },
        },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Keymaps (which-key)",
      },
      {
        "<c-w><space>",
        function()
          require("which-key").show({ keys = "<c-w>", loop = true })
        end,
        desc = "Window Hydra Mode (which-key)",
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      if not vim.tbl_isempty(opts.defaults) then
        LazyVim.warn(
          "which-key: opts.defaults is deprecated. Please use opts.spec instead."
        )
      end
    end,
  },
  {
    "nvim-mini/mini.icons",
    version = false,
    config = function()
      require("mini.icons").setup()
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {},
  },
}
