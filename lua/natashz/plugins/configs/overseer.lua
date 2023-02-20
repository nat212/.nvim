local M = {}

M.setup = function()
	require("overseer").setup({
    strategy = "toggleterm",
    auto_scroll = true,
    close_on_exit = true,
  })
end

return M
