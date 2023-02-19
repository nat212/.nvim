local M = {}

M.setup = function()
	local neogit = require("neogit")
	neogit.setup({
		popup = {
			kind = "vsplit",
		},
		commit_popup = {
			kind = "vsplit",
		},
	})
	vim.keymap.set("n", "<leader>gs", neogit.open)
	vim.keymap.set("n", "<leader>gc", function()
		require("neogit").open({ "commit" })
	end)
end

return M
