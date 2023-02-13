local M = {}

M.setup = function()
  local null_ls = require("null-ls")
  local diagnostics = null_ls.builtins.diagnostics
  local code_actions = null_ls.builtins.code_actions
  local completion = null_ls.builtins.completion
  local formatting = null_ls.builtins.formatting
  local hover = null_ls.builtins.hover
  local sources = {
      diagnostics.eslint_d.with({
          extra_filetypes = { "svelte" },
      }),
      code_actions.eslint_d.with({
          extra_filetypes = { "svelte" },
      }),
      -- code_actions.refactoring,
      -- diagnostics.commitlint,
      diagnostics.fish,
      diagnostics.golangci_lint,
      diagnostics.markdownlint,
      diagnostics.mypy,
      -- diagnostics.pycodestyle,
      diagnostics.pydocstyle,
      diagnostics.pylint,
      -- diagnostics.selene,
      -- diagnostics.semgrep,
      diagnostics.shellcheck,
      diagnostics.stylint.with({
          extra_filetypes = { "svelte" },
      }),
      diagnostics.tidy,
      diagnostics.todo_comments,
      diagnostics.tsc,
      formatting.black,
      formatting.dart_format,
      formatting.eslint_d.with({
          extra_filetypes = { "svelte" },
      }),
      formatting.fish_indent,
      formatting.fixjson,
      formatting.gofmt,
      formatting.isort,
      formatting.mdformat,
      formatting.nginx_beautifier,
      formatting.prettierd.with({
          extra_filetypes = { "svelte", "html" },
      }),
      formatting.shfmt,
      formatting.stylelint.with({
          extra_filetypes = { "svelte", "html" },
      }),
      formatting.stylua,
      -- formatting.tidy,
      hover.dictionary,
      hover.printenv,
      formatting.clang_format,
      formatting.csharpier,
  }

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
