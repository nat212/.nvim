local M = {}
local util = require("natashz.util")

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

local flutter_sdk_path
if util.is_windows then
	flutter_sdk_path = vim.fs.normalize("C:/src/flutter")
else
	flutter_sdk_path = os.getenv("HOME") .. "/flutter"
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
          command = "node",
					args = { util.cmds.dart_debug, "flutter" },
				}
				require("dap").configurations.dart = {
					{
						type = "dart",
						request = "launch",
						name = "Launch flutter",
						dartSdkPath = vim.fs.normalize(flutter_sdk_path .. "/bin/cache/dart-sdk/"),
						flutterSdkPath = flutter_sdk_path,
						program = "${workspaceFolder}/lib/main.dart",
						cwd = "${workspaceFolder}",
					},
				}
			end,
		},
	})
end
return M
