local M = {}
local keymap = require("natashz.keymap")

M.start_debugging = function()
	require("dap").continue()
	require("dapui").open({ reset = true })
end

M.setup = function()
	local dapui = require("dapui")
	local dap = require("dap")
	dapui.setup({
		layouts = {
			{
				elements = {
					{
						id = "scopes",
						size = 0.25,
					},
					{
						id = "breakpoints",
						size = 0.25,
					},
					{
						id = "stacks",
						size = 0.25,
					},
					{
						id = "watches",
						size = 0.25,
					},
				},
				position = "left",
				size = 40,
			},
			{
				elements = { {
					id = "repl",
					size = 1.0,
				} },
				position = "bottom",
				size = 10,
			},
		},
	})

	-- Breakpoints
	keymap.nnoremap("<leader>b", dap.toggle_breakpoint, { silent = true })
	keymap.nnoremap("<leader>B", dap.set_breakpoint, { silent = true })
	keymap.nnoremap("<leader>lp", function()
		require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
	end)
	-- REPL
	keymap.nnoremap("<leader>dr", function()
		dapui.update_render({})
	end)
	-- Starting
	keymap.nnoremap("<leader>do", function()
		dapui.toggle({ reset = true })
		dapui.update_render({})
	end, { silent = true })
	keymap.nnoremap("<leader>2do", function()
		dapui.toggle({ layout = 2 })
		dapui.update_render({})
	end)
	keymap.nnoremap("<leader>1do", function()
		dapui.toggle({ layout = 1 })
		dapui.update_render({})
	end)
	keymap.nnoremap("<leader>dd", M.start_debugging, { silent = true })
	keymap.nnoremap("<leader>ds", dap.stop, { silent = true })
	-- In debugging
	keymap.nnoremap("<F5>", dap.continue, { silent = true })
	keymap.nnoremap("<F10>", dap.step_over, { silent = true })
	keymap.nnoremap("<F11>", dap.step_into, { silent = true })
	keymap.nnoremap("<F12>", dap.step_out, { silent = true })
end

return M
