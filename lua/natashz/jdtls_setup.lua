local lsp_common = require("natashz.lsp_common")

local on_attach = lsp_common.on_attach
local capabilities = lsp_common.capabilities

local M = {}
M.setup = function()
	local jdtls_config = {
		cmd = { "jdtls" },
		on_attach = on_attach,
		capabilities = capabilities,
		root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw", "pom.xml" }, { upward = true })[1]),
	}
	require("jdtls").start_or_attach(jdtls_config)
end

return M
