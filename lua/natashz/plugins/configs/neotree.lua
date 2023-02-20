local M = {}

local function exit_neotree()
	require("neo-tree.sources.manager").close_all()
end

local function setup_autocmds()
	vim.api.nvim_create_augroup("neotree_exit_on_quit", { clear = true })
	vim.api.nvim_create_autocmd("QuitPre", {
		group = "neotree_exit_on_quit",
		callback = exit_neotree,
	})
end

M.setup = function()
	vim.keymap.set("n", "<A-n>", "<Cmd>Neotree<CR>", { silent = true, noremap = true })
  setup_autocmds()
end

return M
