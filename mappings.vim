" " Better navigation
" noremap L $
" noremap H ^
" noremap $ L
" noremap ^ H

" " Useful as hell
" vnoremap <leader>p "_dP
" nnoremap <leader>y "+y
" vnoremap <leader>y "+y
" nnoremap <leader>Y gg"+yG

" nnoremap <leader>d "_d
" vnoremap <leader>d "_d

" " Map to refresh plugins
" function! RefreshPlugins()
"     exec 'source ~/.config/nvim/plugins.vim'
"     exec 'PlugInstall'
" endfunction

" nnoremap <leader>rp :call RefreshPlugins()<CR>

" " Markdown preview
" nmap <leader>mp <Plug>MarkdownPreviewToggle
