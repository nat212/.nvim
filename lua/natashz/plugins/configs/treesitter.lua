local M = {}

M.setup = function()
  require("nvim-treesitter.install").prefer_git = false
  require("nvim-treesitter.install").compilers = { "clang" }
  require("nvim-treesitter.configs").setup({
    highlight = { enable = true },
    indent = { enable = true },
    auto_install = true,
    ensure_installed = {
      "dart",
      "html",
      "tsx",
      "svelte",
      "css",
      "javascript",
      "typescript",
      "vim",
      "lua",
      "json",
      "scss",
      "c_sharp",
      "yaml",
    },
    matchup = {
      enable = true,
    },
    -- autotag = {
    --   enable = true,
    --   filetypes = {
    --     "html",
    --     "javascript",
    --     "typescript",
    --     "javascriptreact",
    --     "typescriptreact",
    --     "vue",
    --     "svelte",
    --     "tsx",
    --     "jsx",
    --     "xml",
    --     "markdown",
    --   },
    -- },
  })
end

return M
