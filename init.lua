if pcall(require, "plenary.reload") then
	require("plenary.reload").reload_module("natashz")
end

require("natashz")

vim.opt.background = "dark"
vim.opt.guifont = "Iosevka"

vim.cmd([[
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup end
]])

-- Transparent bg
-- vim.cmd([[
-- au ColorScheme * hi Normal ctermbg=none guibg=none
-- ]])

-- Restore cursor
vim.cmd([[
au VimLeave,VimSuspend * set guicursor=a:ver30-iCursor-blinkon0
]])
