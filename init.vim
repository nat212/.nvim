lua << EOF
  if pcall(require, 'plenary.reload') then
    require('plenary.reload').reload_module('natashz')
  end
EOF
lua require'natashz'

" Colour scheme
set background=dark

" Highlight when yanking
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup end
