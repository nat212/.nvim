local M = {}

M.setup = function()
	require("dap-go").setup({
		dap_configurations = {
			{
				type = "go",
				name = "Pocketbase Serve",
				request = "launch",
				program = "${fileDirname}",
				args = { "serve" },
			},
		},
	})
end

return M
