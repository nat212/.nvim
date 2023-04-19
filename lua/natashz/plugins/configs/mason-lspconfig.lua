local M = {}

M.setup = function()
  require("mason-lspconfig").setup({})

  local lspconfig = require("lspconfig")
  local lsp = require("natashz.core.lsp")
  local on_attach = lsp.on_attach
  local capabilities = lsp.capabilities
  local util = require("natashz.core.util")

  require("mason-lspconfig").setup_handlers({
    function(server_name) -- Default handler
      lspconfig[server_name].setup({
       capabilities = capabilities,
        on_attach = on_attach,
      })
    end,
    ["lua_ls"] = function()
      -- Let neodev handle it.
    end,
    ["omnisharp"] = function(server_name)
      lspconfig[server_name].setup({
        cmd = { util.cmds.omnisharp },
        on_attach = on_attach,
        capabilities = capabilities,
        enable_editorconfig_support = true,
        enable_roslyn_analyzers = true,
        organize_imports_on_format = true,
        enable_import_completion = true,
      })
    end,
    ["powershell_es"] = function(server_name)
      local ps_bundle
      if require("natashz.core.util").is_windows then
        ps_bundle = vim.fs.normalize("C:/src/PowerShellEditorServices")
      end
      lspconfig[server_name].setup({
        bundle_path = ps_bundle,
      })
    end,
    ["jedi_language_server"] = function(server_name)
      lspconfig[server_name].setup({
        cmd = { util.cmds.jedi },
        capabilities = capabilities,
        on_attach = on_attach,
      })
    end,
    ["pylsp"] = function(server_name)
      local python3_path = vim.fs.dirname(vim.g.python3_host_prog)
      local pylsp_path = python3_path .. "/pylsp"
      lspconfig[server_name].setup({
        cmd = { pylsp_path },
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          pylsp = {
            plugins = {
              pydocstyle = {
                enable = true,
                convention = "numpy",
                addIgnore = { "D104" },
              },
              rope_autoimport = {
                enabled = true,
              },
              flake8 = {
                maxLineLength = 88,
              },
              pycodestyle = {
                enabled = true,
                maxLineLength = 88,
              },
              pyflakes = {
                enabled = false,
              },
            },
          },
        },
      })
    end,
    ["tsserver"] = function()
      lspconfig["tsserver"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
    end,
    ["angularls"] = function()
      lspconfig["angularls"].setup({
        on_attach = function(client, buffer)
          client.server_capabilities.renameProvider = false
          on_attach(client, buffer)
        end,
        capabilities = capabilities,
      })
    end,
    ["csharp_ls"] = function()
      lspconfig["csharp_ls"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = function(fname)
          return require("lspconfig").util.root_pattern(".git", "*.sln")(fname) or vim.fn.getcwd()
        end,
      })
    end,
  })
end

return M
