local M = {}

function LeaveSnippet()
  if
    ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
    and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
    and not require("luasnip").session.jump_active
  then
    require("luasnip").unlink_current()
  end
end

M.setup = function()
  require("luasnip.loaders.from_snipmate").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load()

  vim.api.nvim_command([[
    autocmd ModeChanged * lua LeaveSnippet()
  ]])
end

return M
