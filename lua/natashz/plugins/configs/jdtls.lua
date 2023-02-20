local M = {}

M.setup = function()
	local lsp = require("natashz.core.lsp")

	local on_attach = lsp.on_attach
	local capabilities = lsp.capabilities

	local jdtls_config = {
		cmd = { "jdtls" },
		on_attach = on_attach,
		capabilities = capabilities,
		root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw", "pom.xml" }, { upward = true })[1]),
	}
	require("jdtls").start_or_attach(jdtls_config)
end

return M
