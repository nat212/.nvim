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
		filter = function(code_action)
			vim.notify(code_action)
		end,
	})
	vim.lsp.buf.execute_command(params)
end

M.setup = function()
	local util = require("natashz.util")
  local flutter_cmd

	if util.is_windows then
		local nvim_dir = vim.fs.dirname(util.get_init_vim())
		flutter_lookup_cmd = "pwsh " .. vim.fs.normalize(nvim_dir .. "/scripts/find-flutter.ps1")
    flutter_cmd = vim.fs.normalize("C:/src/flutter/bin/flutter.bat")
	else
		flutter_lookup_cmd = "dirname $(which flutter)"
	end
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
		debugger = {
			enabled = true,
			run_via_dap = true,
			register_configurations = function(_)
        require("dap").adapters.dart = {
          type = "executable",
          command = flutter_cmd,
          args = {"debug_adapter"},
        }
				require("dap").configurations.dart = {}
        require("dap.ext.vscode").load_launchjs(require("flutter-tools.lsp").get_lsp_root_dir() .. "/.vscode/launch.json")
        print(vim.fn.json_encode(require("dap").configurations.dart))
			end,
		},
	})
end
return M
