local M = {}

M.setup = function()
	require("catppuccin").setup({
		flavor = "mocha",
		transparent_background = true,
		integrations = {
			notify = true,
			telescope = true,
			symbols_outline = true,
			treesitter = true,
			neotree = true,
			treesitter_context = true,
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = { "italic" },
					hints = { "italic" },
					warnings = { "italic" },
					information = { "italic" },
				},
				underlines = {
					errors = { "underline" },
					hints = { "underline" },
					warnings = { "underline" },
					information = { "underline" },
				},
			},
			dap = {
				enabled = true,
				enable_ui = true,
			},
			cmp = true,
			mason = true,
			gitsigns = true,
			fidget = true,
			dashboard = true,
			hop = true,
			lsp_trouble = true,
			navic = {
				enabled = true,
				custom_bg = "NONE",
			},
			neogit = true,
			barbar = true,
			barbecue = {
				dim_dirname = true,
			},
			mini = true,
		},
	})
end

return M
