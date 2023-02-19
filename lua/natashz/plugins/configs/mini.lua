local M = {}

M.setup_ai = function()
	require("mini.ai").setup()
end

M.setup_align = function()
	require("mini.align").setup()
end

M.setup_comment = function()
	require("mini.comment").setup()
end

M.setup = function()
	M.setup_ai()
	M.setup_align()
	M.setup_comment()
end

return M
