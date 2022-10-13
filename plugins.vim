" Install vim-plug if not already installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" ~ Aesthetics ~
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'gruvbox-community/gruvbox'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'
" Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }

" LSP + Completion Stuff
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'glepnir/lspsaga.nvim'

" Other IDE-esque stuff
Plug 'simrat39/symbols-outline.nvim'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'sbdchd/neoformat'
Plug 'simrat39/symbols-outline.nvim'

" Language support + syntax
Plug 'rust-lang/rust.vim'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'editorconfig/editorconfig-vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag'

" Movement + utilities
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'ThePrimeagen/harpoon'

" Git
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
" Plug 'dinhhuy258/git.nvim'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'ThePrimeagen/git-worktree.nvim'

" Misc
Plug 'theprimeagen/vim-be-good'

" Local Development
Plug '~/Development/Personal/Vim/bufferline.nvim'

call plug#end()
