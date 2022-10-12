require('mason').setup()
require('mason-lspconfig').setup()
require('nvim-autopairs').setup {}

require('symbols-outline').setup {
    highlight_hovered_item = true,
    show_guides = true,
}


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')

local function ts_organise_imports()
    local params = {
        command = "_typescript.organizeImports",
        arguments = {vim.api.nvim_buf_get_name(0)},
        title = "",
    }
    vim.lsp.buf.execute_command(params)
end

local servers = { 'rust_analyzer', 'sumneko_lua', 'jsonls', 'angularls', 'html', 'eslint', 'tailwindcss' }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        capabilities = capabilities,
    }
end

lspconfig['tsserver'].setup {
    capabilities = capabilities,
    commands = {
        OrganiseImports = {
            ts_organise_imports,
            description = "Organise Imports",
        }
    }
}

local luasnip = require'luasnip'

local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
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
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'luasnip' },
    }),
})

require('luasnip.loaders.from_vscode').lazy_load()
