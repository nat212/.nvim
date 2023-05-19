local M = {}

M.setup = function()
  require("rose-pine").setup({
    variant = "auto",
    dark_variant = "moon",
    groups = {
      background = "transparent",
    },
  })
  vim.cmd("colorscheme rose-pine")
end

return M
