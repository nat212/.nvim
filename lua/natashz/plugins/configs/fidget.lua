local M = {}

M.setup = function()
	require("fidget").setup({
		window = {
			blend = 0,
		},
	})
end

return M
