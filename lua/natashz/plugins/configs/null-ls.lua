local M = {}

local function get_sources()
	local null_ls = require("null-ls")
	local diagnostics = null_ls.builtins.diagnostics
	local code_actions = null_ls.builtins.code_actions
	local completion = null_ls.builtins.completion
	local formatting = null_ls.builtins.formatting
	local hover = null_ls.builtins.hover

	return {
		-- Web
		diagnostics.eslint_d.with({
			extra_filetypes = { "svelte" },
		}),
		code_actions.eslint_d.with({
			extra_filetypes = { "svelte" },
		}),
		formatting.eslint_d.with({
			extra_filetypes = { "svelte" },
		}),
		diagnostics.stylint.with({
			extra_filetypes = { "svelte" },
		}),
		formatting.prettierd.with({
			extra_filetypes = { "svelte", "html" },
		}),
		formatting.stylelint.with({
			extra_filetypes = { "svelte", "html" },
		}),
		diagnostics.tsc,

		-- Shell
		diagnostics.fish,
		diagnostics.shellcheck,
		formatting.fish_indent,
		formatting.shfmt,

		-- Lua
		formatting.stylua,
		diagnostics.selene,

		-- Golang
		diagnostics.golangci_lint,
		formatting.gofmt,

		-- Python
		diagnostics.mypy,
		diagnostics.pydocstyle,
		diagnostics.pylint,
		formatting.black,
		formatting.isort,

		-- Markdown/english
		diagnostics.markdownlint,
		formatting.mdformat,
		hover.dictionary,

		-- JSON
		formatting.fixjson,

		-- C#
		formatting.csharpier,

    -- Dart/Flutter
		formatting.dart_format,

    -- Configs
		formatting.nginx_beautifier,

    -- Misc
		diagnostics.tidy,
		diagnostics.todo_comments,
		hover.printenv,
	}
end

M.setup = function()
	local null_ls = require("null-ls")

  local sources = get_sources()

	null_ls.setup({
		sources = sources,
		root_dir = require("null-ls.utils").root_pattern(
			".null-ls-root",
			"Makefile",
			".git",
			"pom.xml",
			"Pipfile",
			"Pipfile.lock",
			"setup.cfg",
			"tox.ini",
			"pyproject.toml",
			"angular.json"
		),
	})
end

return M
