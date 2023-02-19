local M = {}

M.setup = function()
	vim.keymap.set("n", "<A-n>", "<Cmd>Neotree<CR>", { silent = true, noremap = true })
end

return M
