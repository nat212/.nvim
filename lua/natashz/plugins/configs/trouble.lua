local M = {}

M.setup = function()
	require("trouble").setup({})
	vim.keymap.set("n", "<leader>xx", "<Cmd>TroubleToggle<CR>", { silent = true, noremap = true })
end

return M
