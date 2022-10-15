-- Symbols keybinding
local toggle_outline = function() vim.cmd('SymbolsOutline') end
vim.keymap.set('n', '<C-O>', toggle_outline, {silent = true})

-- Capabilities to connect LSP to vim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Diagnostic bindings
local opts = {noremap = true, silent = true}
vim.keymap.set('n', '<space>e', '<Cmd>Lspsaga show_line_diagnostics<CR>', opts)
vim.keymap.set('n', '[d', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Terminal
vim.keymap.set('n', '<C-`>', '<Cmd>Lspsaga open_floaterm<CR>', opts)
vim.keymap.set('t', '<C-`>', [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], opts)

-- LSP bindings
local on_attach = function(client, bufnr)
    local bufopts = {noremap = true, silent = true, buffer = bufnr}
    -- Gotos
    vim.keymap.set('n', '<space>d', '<Cmd>Lspsaga lsp_finder<CR>', bufopts)
    -- Hints/Help
    vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', bufopts)
    vim.keymap.set('n', '<C-j>', vim.lsp.buf.signature_help, bufopts)
    -- Workspaces
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder,
                   bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    -- Refactors/Format
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<A-CR>', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<space>f',
                   '<Cmd>Neoformat<CR>', bufopts)
    vim.keymap.set('n', '<space>o', ':OrganiseImports<CR>', bufopts)
end

-- Organise TS imports
local function ts_organise_imports()
    local params = {
        command = "_typescript.organizeImports",
        arguments = {vim.api.nvim_buf_get_name(0)},
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end

local lspconfig = require('lspconfig')
-- Servers that don't require any additional setup
local servers = {
    'rust_analyzer',
    'jsonls',
    'angularls',
    'html',
    'eslint',
    'tailwindcss',
    'marksman',
    'zk',
    'prosemd_lsp',
}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {capabilities = capabilities, on_attach = on_attach}
end

-- Setup LUA server
lspconfig['sumneko_lua'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {version = 'LuaJIT'},
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true)
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {enable = false}
        }
    }
}

-- Setup tsserver
lspconfig['tsserver'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    commands = {
        OrganiseImports = {
            ts_organise_imports,
            description = "Organise Imports"
        }
    }
}

-- Snippets + completion
local luasnip = require 'luasnip'
local cmp = require 'cmp'
if cmp == nil then return end

cmp.setup({
    snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {'i', 's'})
    }),
    sources = cmp.config.sources({
        {name = 'nvim_lsp'}, {name = 'buffer'}, {name = 'luasnip'},
        {name = 'path'}
    })
})

require('luasnip.loaders.from_vscode').lazy_load()
