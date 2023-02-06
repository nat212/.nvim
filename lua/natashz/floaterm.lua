local keymap = require("natashz.keymap")

if require("natashz.util").is_windows then
	vim.g.floaterm_shell = "pwsh"
end

keymap.nnoremap("<leader>tc", "<Cmd>FloatermNew<CR>", { silent = true })
keymap.nnoremap("<leader>tt", "<Cmd>FloatermToggle<CR>", { silent = true })
keymap.nnoremap("<leader>tn", "<Cmd>FloatermNext<CR>", { silent = true })
keymap.nnoremap("<leader>tp", "<Cmd>FloatermPrev<CR>", { silent = true })
