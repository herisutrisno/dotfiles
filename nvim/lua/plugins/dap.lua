return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local mason_registry = require("mason-registry")

      vim.keymap.set(
        "n",
        "<F10>",
        '<cmd>lua require"dap".step_into()<CR>',
        { desc = "DAP step into" }
      )
      vim.keymap.set(
        "n",
        "<F11>",
        '<cmd>lua require"dap".step_over()<CR>',
        { desc = "DAP step over" }
      )
      vim.keymap.set(
        "n",
        "<F12>",
        '<cmd>lua require"dap".step_out()<CR>',
        { desc = "DAP step out" }
      )
      vim.keymap.set("n", "<F5>", function()
        require("dap").continue()
      end, { desc = "DAP continue" })

      vim.keymap.set(
        "n",
        "<leader>du",
        '<cmd>lua require"dapui".toggle()<CR>',
        { desc = "DAP toggle UI" }
      )

      -- reset dap ui
      vim.keymap.set("n", "<leader>dr", function()
        local dapui = require("dapui")
        dapui.close()
        dapui.open({ reset = true })
      end, { desc = "DAP reset UI" })

      vim.keymap.set(
        "n",
        "<leader>de",
        '<cmd>lua require"dapui".eval()<CR>',
        { desc = "DAP eval" }
      )

      vim.keymap.set(
        "n",
        "<leader>db",
        '<cmd>lua require"dap".toggle_breakpoint()<CR>',
        { desc = "DAP toggle breakpoint" }
      )
      vim.keymap.set(
        "n",
        "<leader>dc",
        '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
        {
          desc = "DAP set breakpoint with condition",
        }
      )

      vim.api.nvim_create_user_command("DapDisconnect", function()
        require("dap").disconnect()
        require("dapui").close()
      end, {})

      -- Node/TS adapter using js-debug-adapter installed via Mason
      dap.adapters.node2 = {
        type = "executable",
        command = "node",
        args = {
          vim.fn.stdpath("data")
            .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
        },
      }

      dap.configurations.javascript = {
        {
          name = "Launch file",
          type = "node2",
          request = "launch",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
        },
      }

      dap.configurations.typescript = dap.configurations.javascript

      dap.adapters.godot = {
        type = "server",
        host = "127.0.0.1",
        port = 6006,
      }

      dap.configurations.gdscript = {
        {
          type = "godot",
          request = "launch",
          name = "launch main scene",
          project = "${workspaceFolder}",
        },
      }
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      -- TODO: finish
      -- require('skeleton.config.dap.save_breakpoints').setup()
    end,
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = {
          "python", -- debugpy
          "delve", -- golang
          "codelldb", -- rust, c, c++
          "pwa-node", -- Node.js debugger for JS/TS
        },
        automatic_installation = true,
      })
    end,
  },

  {
    "leoluz/nvim-dap-go",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      require("dap-go").setup({
        delve = {
          build_flags = "-tags=dynamic",
        },
      })
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local dap_python = require("dap-python")

      -- Automatically find debugpy installed via Mason, project venv, or system python
      dap_python.setup() -- no path needed, works with Mason >= 1.0

      -- Optional: enable dap-ui
      require("dapui").setup()
    end,
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      -- require("nvim-dap-virtual-text").setup({})
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enable_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = true,
        show_stop_reason = true,
        commented = false,
        all_frames = false,
        only_first_definition = true,
        all_references = false,

        -- new required fields
        clear_on_continue = true,
        text_prefix = "│ ",
        separator = " ┆ ",
        error_prefix = "E: ",
        info_prefix = "I: ",
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        virt_lines = false,
        virt_lines_above = false,
        filter_references = true,
        filter_references_pattern = "", -- default: empty string
        display_callback = function(variable, buf, stackframe, node) -- default callback
          return variable.name .. " = " .. variable.value
        end,
      })
    end,
  },
}
