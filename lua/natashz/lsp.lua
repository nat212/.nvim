local util = require("natashz.util")

-- Symbols keybinding
local toggle_outline = function()
	vim.cmd("SymbolsOutline")
	require("natashz.dap").reset_layout()
end
vim.keymap.set("n", "<C-O>", toggle_outline, { silent = true })

local capabilities = require("natashz.lsp_common").capabilities
local on_attach = require("natashz.lsp_common").on_attach

-- Organise TS imports
local function ts_organise_imports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = "",
	}
	vim.lsp.buf.execute_command(params)
end

local lspconfig = require("lspconfig")

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
		if require("natashz.util").is_windows then
			ps_bundle = vim.fs.normalize("C:/src/PowerShellEditorServices")
		end
		lspconfig[server_name].setup({
			bundle_path = ps_bundle,
		})
	end,
	["diagnosticls"] = function(server_name)
		-- lspconfig[server_name].setup({
		-- 	filetypes = {
		-- 		"python",
		-- 		"typescript",
		-- 		"javascript",
		-- 		"html",
		-- 		"css",
		-- 		"scss",
		-- 		"less",
		-- 		"typescriptreact",
		-- 		"javascriptreact",
		-- 		"svelte",
		-- 		"vue",
		-- 	},
		-- 	root_dir = function(fname)
		-- 		return require("lspconfig").util.root_pattern(
		-- 			".git",
		-- 			"setup.cfg",
		-- 			"pyproject.toml",
		-- 			"tox.ini",
		-- 			"package.json",
		-- 			"yarn.lock",
		-- 			"Pipfile",
		-- 			"Pipfile.lock"
		-- 		)(fname) or vim.fn.getcwd()
		-- 	end,
		-- })
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
			commands = {
				OrganiseImports = {
					py_organise_imports,
					description = "Organise Imports",
				},
			},
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
	["jdtls"] = function()
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
	["tsserver"] = function()
		lspconfig["tsserver"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			commands = {
				OrganiseImports = {
					ts_organise_imports,
					description = "Organise Imports",
				},
			},
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

lspconfig.gdscript.setup({ on_attach = on_attach, capabilities = capabilities })

-- Snippets + completion
local _, luasnip = pcall(require, "luasnip")
local status, cmp = pcall(require, "cmp")
if not status then
	return
end

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping(function(fallback)
			cmp.complete({
				config = {
					sources = {
						{ name = "nvim_lsp" },
						{ name = "luasnip" },
						{ name = "luasnip_choice" },
					},
				},
			})
		end),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip", keyword_length = 0 },
		{ name = "path" },
		{ name = "luasnip_choice" },
	}, { name = "buffer" }),
})

cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = "buffer" },
	}),
})

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- Snippets
require("luasnip.loaders.from_snipmate").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load()

-- Neoformat options
-- vim.g.neoformat_run_all_formatters = 1
vim.g.neoformat_only_msg_on_error = 1

-- TypeScript & JavaScript
local prettier = { "prettier" }
vim.g.neoformat_enabled_typescript = prettier
vim.g.neoformat_enabled_javascript = prettier
vim.g.neoformat_enabled_javascriptreact = prettier
vim.g.neoformat_enabled_typescriptreact = prettier
vim.g.neoformat_enabled_svelte = prettier
vim.g.neoformat_enabled_html = prettier
vim.g.neoformat_enabled_css = prettier
vim.g.neoformat_enabled_scss = prettier
vim.g.neoformat_enabled_sass = prettier

-- Python
local py_formatters = { "black", "isort" }
vim.g.neoformat_enabled_python = py_formatters
