local M = {}

M.setup = function()
	require("nvim-ts-autotag").setup({
    autotag = {
      enable = true,
    },
    filetypes = {
      "html", "htmldjango",
      "javascript", "javascriptreact", "jsx",
      "typescript", "typescriptreact", "tsx",
      "rescript",
      "svelte",
      "vue",
      "xml",
      "php",
      "markdown",
      "glimmer", "handlebars", "hbs",
    },
  })
end

return M
