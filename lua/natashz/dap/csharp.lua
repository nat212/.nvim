local M = {}

M.setup_csharp_dap = function()
  local dap = require("dap")
  local utils = require("natashz.core.util")
  dap.adapters.coreclr = {
    type = "executable",
    command = utils.cmds.netcoredbg,
    args = { "--interpreter=vscode" },
  }

  dap.configurations.cs = {
    {
      type = "coreclr",
      name = "launch - netcoredbg",
      request = "launch",
      program = function()
        return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
      end,
    },
  }
end

return M
