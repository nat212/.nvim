vim.opt.termguicolors = true
vim.opt.hlsearch = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.scrolloff = 16
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.cmdheight = 1
vim.opt.updatetime = 50
vim.opt.shortmess:append("c")
vim.opt.colorcolumn = "80"
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smarttab = true
vim.opt.splitright = true

-- TODO: Figure out why this gives a python error
if require("natashz.core.util").is_windows then
	-- Found at: https://github.com/akinsho/toggleterm.nvim/issues/303
	-- vim.opt.shell = vim.fn.executable("pwsh") and "pwsh" or "powershell"
	-- vim.opt.shellcmdflag =
	-- 	"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
	-- vim.opt.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
	-- vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
	-- vim.opt.shellslash = true
	-- vim.opt.shellquote = ""
	-- vim.opt.shellxquote = ""
end
