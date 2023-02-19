local M = {}

M.setup = function()
	local hop = require("hop")
	hop.setup({ keys = "etovxqpdygfblzhckisuran" })

	local directions = require("hop.hint").HintDirection
	vim.keymap.set("", "<leader>hf", function()
		hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
	end, { remap = true })
	vim.keymap.set("", "<leader>hF", function()
		hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
	end, { remap = true })
	vim.keymap.set("", "<leader>ht", function()
		hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })
	end, { remap = true })
	vim.keymap.set("", "<leader>hT", function()
		hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })
	end, { remap = true })
end

return M
