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
-- if require("natashz.util").is_windows then
  -- Found at: https://github.com/akinsho/toggleterm.nvim/issues/303
	-- local powershell_options = {
	-- 	shell = vim.fn.executable("pwsh") and "pwsh" or "powershell",
	-- 	shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
	-- 	shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
	-- 	shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
	-- 	shellquote = "",
	-- 	shellxquote = "",
	-- }

	-- for option, value in pairs(powershell_options) do
	-- 	vim.opt[option] = value
	-- end
-- end
