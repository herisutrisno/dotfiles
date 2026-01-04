-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymaps = vim.keymap
local opts = { noremap = true, silent = true }

-- Increment/decrement
keymaps.set("n", "+", "<C-a>")
keymaps.set("n", "_", "<C-x>")

-- Delete a word backwards
keymaps.set("n", "dw", "vb_d")

-- Select automatically
keymaps.set("n", "<C-a>", "gg<S-v>G")

-- Jumplist
keymaps.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymaps.set("n", "te", ":tabedit", opts)
keymaps.set("n", "<tab>", ":tabnext<Return>", opts)
keymaps.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- Split Window
keymaps.set("n", "ss", ":split<Return>", opts)
keymaps.set("n", "sv", ":vsplit<Return>", opts)
-- Move window
keymaps.set("n", "sh", "<C-w>h")
keymaps.set("n", "sk", "<C-w>k")
keymaps.set("n", "sj", "<C-w>j")
keymaps.set("n", "sl", "<C-w>l")

-- Resize window
keymaps.set("n", "<C-w><left>", "<C-w><")
keymaps.set("n", "<C-w><right>", "<C-w>>")
keymaps.set("n", "<C-w><up>", "<C-w>+")
keymaps.set("n", "<C-w><down>", "<C-w>-")

-- Jump to the next Diagnostics
keymaps.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)

-- Jump to the previous Diagnostic
keymaps.set("n", "<C-k>", function()
  vim.diagnostic.goto_prev()
end, opts)

vim.keymap.set("n", "<leader>rln", function()
  local relative_enabled = vim.wo.relativenumber

  if relative_enabled then
    vim.opt.relativenumber = false
  else
    vim.opt.relativenumber = true
  end
end, { desc = "Toggle relative line numbers" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })

vim.api.nvim_set_keymap(
  "n",
  "<leader>y",
  ":botright split | terminal yarn dev<CR>",
  { noremap = true, silent = true }
)

-- Open terminal vertically <leader>tv
vim.keymap.set(
  "n",
  "<Leader>tv",
  ":vert term<CR>",
  { noremap = true, silent = true }
)

-- JS Runner Config

-- Shared runner with toggle for resize and stay-in-editor
local function run_js_file(opts)
  local filename = vim.fn.expand("%:p")
  local ext = vim.fn.expand("%:e")
  local win_width = vim.api.nvim_win_get_width(0)
  local direction = win_width < 120 and "horizontal" or "vertical"
  local go_back = opts and opts.go_back and 1 or 0

  -- Detect virtualenv for Python
  local python_prefix = ""
  if ext == "py" then
    local venv = os.getenv("VIRTUAL_ENV")
    if venv then
      python_prefix = venv .. "/bin/"
    end
  end

  -- Use appropriate command for each filetype
  local cmd_map = {
    js = "node",
    ts = "ts-node",
    py = python_prefix .. "python",
    go = "go run",
    c = "clang %s -o /tmp/a.out && /tmp/a.out",
    cpp = "clang++ %s -o /tmp/a.out && /tmp/a.out",
    cc = "clang++ %s -o /tmp/a.out && /tmp/a.out",
    java = "javac %s && java -cp %s %s",
    swift = "swift",
  }

  local runner = cmd_map[ext]
  if not runner then
    vim.notify(
      "No runner defined for ." .. ext .. " files",
      vim.log.levels.WARN
    )
    return
  end

  --[[
  vim.cmd(
    string.format(
      "TermExec direction=%s id=9 go_back=%d cmd='clear && %s %s'",
      direction,
      go_back,
      runner,
      filename
    )
  )
  ]]
  -- Format the runner command if needed
  local cmd = runner
  if ext == "java" then
    local classname = vim.fn.expand("%:t:r")
    local dir = vim.fn.expand("%:p:h")
    cmd = string.format("javac %s && java -cp %s %s", filename, dir, classname)
  elseif ext == "c" or ext == "cpp" or ext == "cc" then
    cmd = string.format(cmd, filename)
  else
    cmd = cmd .. " " .. filename
  end

  -- Execute in toggleterm
  vim.cmd(
    "TermExec direction="
      .. direction
      .. " id=9 go_back="
      .. go_back
      .. " cmd='clear && "
      .. cmd
      .. "'"
  )

  -- Optional resize (only after save)
  if opts and opts.resize and direction == "vertical" then
    vim.defer_fn(function()
      vim.cmd("vertical resize 120")
    end, 100)
  end
end

-- 🔁 Auto-run on save (resizes, stay cursor in main panel)
-- change go_back=false if you would like cursor in terminal
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = {
    "*.js",
    "*.ts",
    "*.py",
    "*.go",
    "*.cpp",
    "*.cc",
    "*.c",
    "*.java",
    "*.swift",
  },
  callback = function()
    run_js_file({ resize = true, go_back = true })
  end,
})

-- 🔥 Keybinding to run manually (no resize, stay in main panel)
vim.keymap.set("n", "<leader>r", function()
  run_js_file({ resize = false, go_back = true })
end, { desc = "Run current JS file (stay in editor)" })

-- 🧹 Close all terminal windows when reopening supported files
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = {
    "*.js",
    "*.ts",
    "*.py",
    "*.go",
    "*.cpp",
    "*.cc",
    "*.c",
    "*.java",
    "*.swift",
  },
  callback = function()
    vim.defer_fn(function()
      local terminals = require("toggleterm.terminal").get_all()

      -- Close all terminal windows
      for _, term in pairs(terminals) do
        if term:is_open() then
          term:close()
        end
      end

      -- Optional: ensure you're only seeing the JS buffer
      vim.cmd("only")
    end, 150) -- small delay to allow NERDTree redraw
  end,
})
