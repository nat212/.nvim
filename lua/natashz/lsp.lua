-- Symbols keybinding
local toggle_outline = function() vim.cmd('SymbolsOutline') end
vim.keymap.set('n', '<C-O>', toggle_outline, {silent = true})

local capabilities = require'natashz.lsp_common'.capabilities
local on_attach = require'natashz.lsp_common'.on_attach

-- Organise TS imports
local function ts_organise_imports()
    local params = {
        command = "_typescript.organizeImports",
        arguments = {vim.api.nvim_buf_get_name(0)},
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end

local function dart_organise_imports()
	local params = {
		command = "",
		arguments = {vim.api.nvim_buf_get_name(0)},
		title = ""
	}
	vim.lsp.buf.execute_command(params)
end

local lspconfig = require('lspconfig')

require("mason-lspconfig").setup_handlers {
    function(server_name) -- Default handler
        lspconfig[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach
        }
    end,
	["pylsp"] = function (server_name)
		lspconfig[server_name].setup {
			capabilities = capabilities,
			on_attach = on_attach,
			pylsp = {
				plugins = {
					rope_autoimport = {
						enabled = true,
					},
					pycodestyle = {
						enabled = false,
					},
					flake8 = {
						enabled = false,
					}
				},
			},
		}
	end,
    ["jdtls"] = function ()
        -- vim.cmd([[
        --     augroup jdtls
        --         autocmd!
        --         autocmd FileType java lua require'natashz.jdtls_setup'.setup()
        --     augroup end
        -- ]])
	-- lspconfig['jdtls'].setup {
	-- 	capabilities = capabilities,
	-- 	on_attach = on_attach,
	-- 	cmd = {
	-- 		"java",
	-- 		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
	-- 		"-Dosgi.bundles.defaultStartLevel=4",
	-- 		"-Declipse.product=org.eclipse.jdt.ls.core.product",
	-- 		"-Dlog.protocol=true",
	-- 		"-Dlog.level=ALL",
	-- 		"-Xms1g",
	-- 		"--add-modules=ALL-SYSTEM",
	-- 		"--add-opens",
	-- 		"java.base/java.util=ALL-UNNAMED",
	-- 		"--add-opens",
	-- 		"java.base/java.lang=ALL-UNNAMED",
	-- 		"-jar",
	-- 		"C:/tools/jdt-language-server/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
	-- 		"-configuration",
	-- 		"C:/tools/jdt-language-server/config_win",
	-- 	},
	-- 	root_dir = function(fname)
	-- 		return require("lspconfig").util.root_pattern("pom.xml", "gradle.build", ".git")(fname) or vim.fn.getcwd()
	-- 	end,
	-- }
    end, -- Use nvim-jdtls
    ["sumneko_lua"] = function()
        lspconfig['sumneko_lua'].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    runtime = {version = 'LuaJIT'},
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = {'vim'}
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true)
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {enable = false}
                }
            }
        }
    end,
    ["tsserver"] = function()
        lspconfig["tsserver"].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            commands = {
                OrganiseImports = {
                    ts_organise_imports,
                    description = "Organise Imports"
                }
            }
        }
    end,
    ["angularls"] = function()
        lspconfig["angularls"].setup {
            on_attach = function(client, buffer)
                client.server_capabilities.renameProvider = false
                on_attach(client, buffer)
            end,
            capabilities = capabilities
        }
    end,
	["csharp_ls"] = function ()
		lspconfig["csharp_ls"].setup {
			on_attach = on_attach,
			capabilities = capabilities,
			root_dir = function(fname)
				return require("lspconfig").util.root_pattern(".git", "*.sln")(fname) or vim.fn.getcwd()
			end,
		}
	end
}

lspconfig.gdscript.setup {on_attach = on_attach, capabilities = capabilities}

-- Snippets + completion
local luasnip = require 'luasnip'
local cmp = require 'cmp'
if cmp == nil then return end

cmp.setup({
    snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {'i', 's'})
    }),
    sources = cmp.config.sources({
        {name = 'nvim_lsp'}, {name = 'buffer'}, {name = 'luasnip'},
        {name = 'path'}
    })
})

-- Snippets
require('luasnip.loaders.from_snipmate').lazy_load()
require('luasnip.loaders.from_vscode').lazy_load()

-- Neoformat options
-- vim.g.neoformat_run_all_formatters = 1
vim.g.neoformat_only_msg_on_error = 1

-- TypeScript & JavaScript
local js_et_al_formatters = {'prettier'}
vim.g.neoformat_enabled_typescript = js_et_al_formatters
vim.g.neoformat_enabled_javascript = js_et_al_formatters
vim.g.neoformat_enabled_javascriptreact = js_et_al_formatters
vim.g.neoformat_enabled_typescriptreact = js_et_al_formatters
