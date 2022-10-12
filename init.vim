set path+=**

set termguicolors
set nohlsearch
set number
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set relativenumber
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set hidden
set noerrorbells
set scrolloff=8
set signcolumn=yes
set isfname+=@-@

set cmdheight=1

set updatetime=50

set shortmess+=c
set colorcolumn=80

set wildmode=longest,list,full
set wildmenu
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/.git/*


source ~/.config/nvim/plugins.vim

colo dracula

source ~/.config/nvim/mappings.vim

" Load plugin configs
source ~/.config/nvim/plugins/git.vim
source ~/.config/nvim/plugins/netrw.vim
source ~/.config/nvim/plugins/telescope.vim

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }
lua require'symbols-outline'.setup()


augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup end
