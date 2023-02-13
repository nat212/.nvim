local M = {}
local keymap = require("natashz.keymap")

M.reset_layout = function()
	if M.ui_open then
		require("dapui").open({ reset = true })
	end
end

M.start_debugging = function()
	require("dap").continue()
	require("dapui").open({ reset = true })
	M.ui_open = true
end

M.setup = function()
	M.ui_open = false
	local dapui = require("dapui")
	local dap = require("dap")
	dapui.setup({
		mappings = {
			expand = "<CR>",
			open = "o",
			remove = "d",
			edit = "e",
			repl = "r",
		},
		layouts = {
			{
				elements = {
					{ id = "watches", size = 0.25 },
					{ id = "scopes", size = 0.25 },
					{ id = "breakpoints", size = 0.25 },
					{ id = "stacks", size = 0.25 },
				},
				size = 40,
				position = "left",
			},
			{
				elements = { "repl" },
				size = 10,
				position = "bottom",
			},
		},
		floating = { border = "rounded", mappings = { close = "q" } },
	})

	-- Listeners
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open({ reset = true })
	end

	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end

	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end

	dap.listeners.before.disconnect["dapui_config"] = function()
		dapui.close()
	end

	-- Breakpoints
	keymap.nnoremap("<leader>b", dap.toggle_breakpoint, { silent = true })
	keymap.nnoremap("<leader>B", dap.set_breakpoint, { silent = true })
	keymap.nnoremap("<leader>lp", function()
		require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
	end)
	-- UI
	keymap.nnoremap("<leader>dq", function()
		dapui.close()
		M.ui_open = false
	end)
	keymap.nnoremap("<leader>do", function()
		dapui.open({ reset = true })
		M.ui_open = true
	end, { silent = true })

	-- Starting/stopping
	keymap.nnoremap("<leader>dd", M.start_debugging, { silent = true })
	keymap.nnoremap("<leader>ds", dap.close, { silent = true })
	-- In debugging
	keymap.nnoremap("<F5>", dap.continue, { silent = true })
	keymap.nnoremap("<F10>", dap.step_over, { silent = true })
	keymap.nnoremap("<F11>", dap.step_into, { silent = true })
	keymap.nnoremap("<F12>", dap.step_out, { silent = true })
end

return M
