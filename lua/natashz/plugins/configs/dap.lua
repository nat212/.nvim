local M = {}

local function setup_keybinds()
  local opts = { silent = true }
  local dap = require('dap')
  -- Starting/stopping
  vim.keymap.set("n", "<leader>ds", dap.close, opts)
  vim.keymap.set("n", "<F5>", dap.continue, opts)

  -- Stepping
  vim.keymap.set("n", "<F10>", dap.step_over, opts)
  vim.keymap.set("n", "<F11>", dap.step_into, opts)
  vim.keymap.set("n", "<F12>", dap.step_out, opts)
end

M.setup = function()
  setup_keybinds()
end

return M
