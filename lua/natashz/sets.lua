vim.opt.termguicolors = true
vim.opt.hlsearch = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.smartcase = true
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.scrolloff = 16
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')

vim.opt.cmdheight = 1
vim.opt.updatetime = 50
vim.opt.shortmess:append('c')
vim.opt.colorcolumn = '80'
