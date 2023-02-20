local M = {}

M.setup = function()
	require("dressing").setup({
		select = {
			enabled = true,
			telescope = require("telescope.themes").get_cursor(),
			builtin = {
				relative = "cursor",
				start_in_insert = true,
				win_options = {
					winblend = 0,
				},
			},
		},
		input = {
			win_options = {
				winblend = 0,
			},
		},
	})
end

return M
