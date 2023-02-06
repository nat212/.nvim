local keymap = require("natashz.keymap")

keymap.nnoremap("<leader>ga", "<Cmd>Git! fetch --all<CR>")
keymap.nnoremap("<leader>gs", "<Cmd>G<CR>")
keymap.nnoremap("<leader>gp", "<Cmd>Git! push<CR>")
keymap.nnoremap("<leader>gf", "<Cmd>Git! push --force-with-lease<CR>")
