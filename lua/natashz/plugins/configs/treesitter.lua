local M = {}

M.setup = function()
	require("nvim-treesitter.install").prefer_git = false
	require("nvim-treesitter.install").compilers = { "clang" }
	require("nvim-treesitter.configs").setup({
		highlight = { enable = true },
		indent = { enable = true },
		auto_install = true,
	})
end

return M
