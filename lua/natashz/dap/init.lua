local M = {}

M.setup_daps = function ()
  local python = require("natashz.dap.python")
  local csharp = require("natashz.dap.csharp")
  python.setup_python_dap()
  csharp.setup_csharp_dap()
end

return M
