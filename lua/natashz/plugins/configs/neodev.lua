local M = {}

M.setup = function ()
local lsp = require("natashz.core.lsp")
local on_attach = lsp.on_attach
local capabilities = lsp.capabilities

	require("neodev").setup({
		library = {
      plugins = true,
			types = true,
      runtime = true,
      enabled = true,
		},
    lspconfig = true,
    pathStrict = true,
	})

  require("lspconfig").lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace"
        },
        workspace = {
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  })
end

return M
