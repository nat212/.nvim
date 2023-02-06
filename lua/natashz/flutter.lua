local M = {}

local capabilities = require("natashz.lsp_common").capabilities
local on_attach = require("natashz.lsp_common").on_attach

local function dart_organise_imports()
	local params = {
		command = "organiseImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = "",
	}
  vim.lsp.buf.code_action({
    filter = function (code_action)
      vim.notify(code_action)
    end,
  })
	vim.lsp.buf.execute_command(params)
end


M.setup = function()
	require("flutter-tools").setup({
		lsp = {
			on_attach = on_attach,
			capabilities = capabilities,
			commands = {
				OrganiseImports = {
          dart_organise_imports,
					description = "Organise Imports",
				},
			},
			color = {
				enabled = true,
				background = true,
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
			notification_style = "native",
		},
		dev_log = {
			enabled = false,
			open_cmd = "FloatermNew tail -f",
		},
		widget_guides = {
			enabled = true,
		},
		decorations = {
			statusline = {
				device = true,
			},
		},
	})
end
return M
