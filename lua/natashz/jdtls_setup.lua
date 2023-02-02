local lsp_common = require'natashz.lsp_common'

local M = {}
M.setup = function ()
	local jdtls_config = {
		cmd = {'jdtls'},
		root_dir = vim.fs.dirname(vim.fs.find({'.gradlew', '.git', 'mvnw'}, { upward = true })[1]),
	}
	require'jdtls'.start_or_attach(jdtls_config)
end

return M
