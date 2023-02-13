local lsp_common = require("natashz.lsp_common")
local on_attach = lsp_common.on_attach
local capabilities = lsp_common.capabilities

local M = {}

M.setup = function ()
	require("neodev").setup({
		library = {
			plugins = { "nvim-dap-ui" },
			types = true,
		},
	})

  require("lspconfig").lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        completion = {
          callSnippet = "ReplaceA,"
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
