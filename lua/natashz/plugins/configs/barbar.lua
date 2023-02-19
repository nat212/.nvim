local M = {}

M.setup = function()
	local opts = { silent = true }
	-- Navigation
	vim.keymap.set("n", "<Tab>", "<Cmd>BufferNext<CR>", opts)
	vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferPrevious<CR>", opts)

	-- Tab management
	vim.keymap.set("n", "<leader>tW", "<Cmd>BufferCloseAllButCurrent<CR>", opts)
	vim.keymap.set("n", "<leader>th", "<Cmd>BufferCloseBuffersLeft<CR>", opts)
	vim.keymap.set("n", "<leader>tl", "<Cmd>BufferCloseBuffersRight<CR>", opts)
	vim.keymap.set("n", "<leader>tw", "<Cmd>BufferClose<CR>", opts)
end

return M
