local keymap = require("natashz.keymap")

local function close_quickfix()
  vim.cmd([[cclose]])
  _G.reset_dapui_layout()
end

-- Actually good end/start of line bindings
keymap.noremap("L", "$")
keymap.noremap("H", "^")
keymap.noremap("$", "L")
keymap.noremap("^", "H")

-- Cyka pasta
keymap.vnoremap("<leader>p", '"_dP')
keymap.nnoremap("<leader>y", '"+y')
keymap.vnoremap("<leader>y", '"+y')
keymap.nnoremap("<leader>Y", 'gg"+yG')
keymap.nnoremap("<leader>d", '"_d') -- Delete without copying? Amazing!
keymap.vnoremap("<leader>d", '"_d')

-- Terminal
keymap.tnoremap("<Esc>", "<C-\\><C-n>")

-- Quickfix
keymap.nmap("<leader>qc", close_quickfix) -- Close quickfix window

-- MD preview
vim.cmd([[
augroup markdown_enable_preview
  autocmd!
  autocmd BufRead ft=markdown nnoremap <silent><buffer> <leader>mp <Plug>MarkdownPreviewToggle
augroup end
]])

-- Reload neovim configs
keymap.nnoremap("<leader>ss", function()
  local file = vim.fn.expand("%:p")
  vim.cmd([[source ]] .. file)
  vim.notify("Reloaded " .. file, "Config")
end)
-- Packer
keymap.nnoremap("<leader>pc", function()
  vim.notify("Compiling packer", "Plugins")
  local packer = require("packer")
  packer.compile()
end, { silent = true })
keymap.nnoremap("<leader>pi", function()
  vim.notify("Installing plugins", "Plugins")
  local packer = require("packer")
  packer.install()
end, { silent = true })
keymap.nnoremap("<leader>ps", function()
  vim.notify("Syncing plugins", "Plugins")
  local packer = require("packer")
  packer.sync()
end, { silent = true })
