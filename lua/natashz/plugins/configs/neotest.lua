local M = {}

local function setup_keybinds()
  vim.keymap.set("n", "<leader>tt", require("neotest").summary.open, { silent = true, noremap = true })
  vim.keymap.set("n", "<leader>to", require("neotest").output_panel.open, { silent = true, noremap = true })
  vim.keymap.set("n", "<leader>tr", require("neotest").run.run, { silent = true, noremap = true })
  vim.keymap.set("n", "<leader>tf", function()
    require("neotest").run.run(vim.fn.expand("%"))
  end, { silent = true, noremap = true })
  vim.keymap.set("n", "<leader>td", function()
    require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
  end, { silent = true, noremap = true })
  vim.keymap.set("n", "<leader>tD", function()
    require("neotest").run.run({ strategy = "dap" })
  end, { silent = true, noremap = true })
  vim.keymap.set("n", "J", require("neotest").output.open, { silent = true, noremap = true })
end

local function quit_neotest()
  local neotest = require("neotest")
  neotest.output_panel.close()
  neotest.summary.close()
end

local function setup_autocmds()
  vim.api.nvim_create_augroup("neotest_exit_on_quit", { clear = true })
  vim.api.nvim_create_autocmd("QuitPre", {
    group = "neotest_exit_on_quit",
    callback = quit_neotest,
  })
end

M.setup = function()
  require("neotest").setup({
    output_panel = {
      enabled = true,
    },
    output = {
      enabled = true,
      open_on_run = true,
    },
    summary = {
      enabled = true,
      expand_errors = true,
      follow = true,
    },
    adapters = {
      require("neotest-dart")({
        command = "flutter",
        use_lsp = true,
      }),
      require("neotest-vitest"),
      require("neotest-playwright").adapter({
        options = {
          persist_project_selection = true,
          enable_dynamic_test_discovery = true,
        },
      }),
      require("neotest-dotnet")({
        dap = { justMyCode = true },
        discovery_root = "project",
      }),
    },
  })

  setup_keybinds()
  setup_autocmds()
end

return M
