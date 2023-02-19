local M = {}

M.setup = function()
	require("symbols-outline").setup({
		highlight_hovered_item = true,
		show_guides = true,
		auto_close = true,
	})
end

return M
