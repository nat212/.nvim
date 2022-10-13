require'bufferline'.setup {
    options = {
        mode = 'buffers',
        separator_style = 'slant',
        always_show_bufferline = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        color_icons = true,
        diagnostics = 'nvim_lsp'
    }
}

local opts = {silent = true}

-- Navigation
vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', opts)

-- Tab management
-- TODO: Figure out bufferline not refreshing
vim.keymap.set('n', '<leader>tW', function()
    require'bufferline.commands'.close_in_direction('left', false)
    require'bufferline.commands'.close_in_direction('right', false)
    require'bufferline.buffers'
end, opts)
vim.keymap.set('n', '<leader>th', '<Cmd>BufferLineCloseLeft<CR>', opts)
vim.keymap.set('n', '<leader>tl', '<Cmd>BufferLineCloseRight<CR>', opts)
vim.keymap.set('n', '<leader>tw', require'bufferline.commands'.close_with_pick, opts)
