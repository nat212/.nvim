local M = {}

local capabilities = require'natashz.lsp_common'.capabilities
local on_attach = require'natashz.lsp_common'.on_attach

M.setup = function ()
	require'flutter-tools'.setup {
		lsp = {
			on_attach = on_attach,
			capabilities = capabilities,
			color = {
				enabled = true,
				background = true,
				foreground = true,
				virtual_text = true,
			},
			settings = {
				showTodos = true,
				completeFunctionCalls = true,
				renameFilesWithClasses = "prompt",
				enableSnippets = true,
			},
		},
		ui = {
			notification_style = 'native',
		},
		dev_log = {
			enabled = false,
		},
		widget_guides = {
			enabled = true,
		},
		decorations = {
			statusline = {
				device = true,
			},
		},
	}
end

return M
