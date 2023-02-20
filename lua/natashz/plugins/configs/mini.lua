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

M.setup_indentscope = function()
	require("mini.indentscope").setup({
		symbol = "│",
	})
end

M.setup_jump2d = function()
	require("mini.jump2d").setup()
end

M.setup_cursorword = function()
	require("mini.cursorword").setup()
end

M.setup_map = function()
	require("mini.map").setup({
		symbols = {
			encode = require("mini.map").gen_encode_symbols.dot('4x2'),
		},
		window = {
      side = 'right',
			winblend = 0,
		},
	})

	vim.keymap.set("n", "<leader>mm", require("mini.map").toggle)
end

M.setup_move = function ()
  require("mini.move").setup()
end

M.setup_pairs = function ()
  require("mini.pairs").setup()
end

M.setup_trailspace = function ()
  require("mini.trailspace").setup()

  vim.keymap.set("n", "<leader>ts", require("mini.trailspace").trim)
end

M.setup = function()
	M.setup_ai()
	M.setup_align()
	M.setup_comment()
	M.setup_indentscope()
	M.setup_jump2d()
	M.setup_cursorword()
	M.setup_map()
  M.setup_move()
  M.setup_pairs()
  M.setup_trailspace()
end

return M
