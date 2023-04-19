local M = {}

M.setup = function()
  require("overseer").setup({
    strategy = "toggleterm",
    auto_scroll = true,
    close_on_exit = true,
  })
  vim.keymap.set("n", ";do", "<Cmd>OverseerRun<CR>", { silent = true, noremap = true })
end

return M
