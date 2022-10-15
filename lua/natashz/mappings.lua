local keymap = require'natashz.keymap'

-- Actually good end/start of line bindings
keymap.nnoremap('L', '$')
keymap.nnoremap('H', '^')
keymap.nnoremap('$', 'L')
keymap.nnoremap('^', 'H')

-- Cyka pasta
keymap.vnoremap('<leader>p', '"_dP')
keymap.nnoremap('<leader>y', '"+y')
keymap.vnoremap('<leader>y', '"+y')
keymap.nnoremap('<leader>Y', 'gg"+yG')
keymap.nnoremap('<leader>d', '"_d') -- Delete without copying? Amazing!
keymap.vnoremap('<leader>d', '"_d')

vim.cmd([[
augroup markdown_enable_preview
  autocmd!
  autocmd BufRead ft=markdown nnoremap <silent><buffer> <leader>mp <Plug>MarkdownPreviewToggle
augroup end
]])
