local M = {}

M.setup = function()
  require("nvim-autopairs").setup({})

  local has_cmp, cmp = pcall(require, "cmp")
  if has_cmp then
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end
end

return M
