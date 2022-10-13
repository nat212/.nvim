require('mason').setup()
require('mason-lspconfig').setup()
require('nvim-autopairs').setup {}

require('symbols-outline').setup {
    highlight_hovered_item = true,
    show_guides = true
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Diagnostic bindings
local opts = {noremap = true, silent = true}

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- LSP bindings
local on_attach = function(client, bufnr)
    local bufopts = {noremap = true, silent = true, buffer = bufnr}
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder,
                   bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<A-CR>', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f',
                   function() vim.lsp.buf.format {async = true} end, bufopts)
end

local lspconfig = require('lspconfig')

local function ts_organise_imports()
    local params = {
        command = "_typescript.organizeImports",
        arguments = {vim.api.nvim_buf_get_name(0)},
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end

local servers = {
    'rust_analyzer', 'jsonls', 'angularls', 'html', 'eslint', 'tailwindcss'
}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {capabilities = capabilities, on_attach = on_attach}
end

lspconfig['sumneko_lua'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT'
            },
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

local luasnip = require 'luasnip'

local cmp = require 'cmp'

if cmp == nil then
    return
end

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
        -- ['<CR>'] = cmp.mapping.confirm{
        --     behavior = cmp.ConfirmBehavior.Replace,
        --     select = true,
        -- },
        -- ['<Up>'] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_prev_item()
        --     else
        --         fallback()
        --     end
        -- end, { "i", "s" }),
        -- ['<Down>'] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_next_item()
        --     else
        --         fallback()
        --     end
        -- end, { "i", "s" }),
        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         local entry = cmp.get_selected_entry()
        --         if not entry then
        --             cmp.select_next_item({ behavior = cmp.SelectBehavior.Replace })
        --         else
        --             cmp.confirm()
        --         end
        --     else
        --         fallback()
        --     end
        -- end, {"i", "s", "c", }),
    }),
    sources = cmp.config.sources({
        {name = 'nvim_lsp'}, {name = 'buffer'}, {name = 'luasnip'},
        {name = 'path'}
    })
})

require('luasnip.loaders.from_vscode').lazy_load()