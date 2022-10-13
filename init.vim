" Sources
source ~/.config/nvim/plugins.vim
source ~/.config/nvim/mappings.vim
lua require'natashz'

" Colour scheme
colo dracula
set background=dark

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

" Highlight when yanking
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup end
