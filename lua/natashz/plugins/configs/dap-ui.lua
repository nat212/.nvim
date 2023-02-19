local M = {}

local function setup_signs()
	local sign = vim.fn.sign_define

	sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
	sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
	sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
end

_G.dapui_open = false

_G.reset_dapui_layout = function()
	if _G.dapui_open then
		require("dapui").open({ reset = true })
	end
end

local function setup_keybinds()
	-- UI
	vim.keymap.set("n", "<leader>dq", function()
		require("dapui").close()
    _G.dapui_open = false
	end)
	vim.keymap.set("n", "<leader>do", function()
		require("dapui").open({ reset = true })
		_G.dapui_open = true
	end, { silent = true })
end

M.setup = function()
	local dap = require("dap")
	local dapui = require("dapui")

	setup_signs()

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

	setup_keybinds()
end

return M
