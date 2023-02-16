local M = {}
-- Capabilities to connect LSP to vim-cmp
if pcall(require, "cmp_nvim_lsp") then
	M.capabilities = require("cmp_nvim_lsp").default_capabilities()
else
	M.capabilities = vim.lsp.protocol.make_client_capabilities()
end

-- Diagnostic bindings
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)


-- LSP bindings
M.on_attach = function(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	-- Gotos
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	-- Hints/Help
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("i", "<C-j>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	-- Workspaces
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	-- Refactors/Format
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<A-CR>", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("x", "<A-CR>", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
	vim.keymap.set("v", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end)
	vim.keymap.set("n", "<space>o", ":OrganiseImports<CR>", bufopts)
end

-- Tab/Shift+Tab to cycle complete options
-- vim.api.nvim_set_keymap('i', '<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]],   { noremap = true, expr = true })
-- vim.api.nvim_set_keymap('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { noremap = true, expr = true })

-- Better <CR> handling
-- local keys = {
--     ["cr"] = vim.api.nvim_replace_termcodes("<CR>", true, true, true),
--     ["ctrl-y"] = vim.api.nvim_replace_termcodes("<C-y>", true, true, true),
--     ["ctrl-y_cr"] = vim.api.nvim_replace_termcodes("<C-y><CR>", true, true, true),
-- }
--
-- _G.cr_action = function()
--   if vim.fn.pumvisible() ~= 0 then
--     -- If popup is visible, confirm selected item or add new line otherwise
--     local item_selected = vim.fn.complete_info()["selected"] ~= -1
--     return item_selected and keys["ctrl-y"] or keys["ctrl-y_cr"]
--   else
--     -- If popup is not visible, use plain `<CR>`. You might want to customize
--     -- according to other plugins. For example, to use 'mini.pairs', replace
--     -- next line with `return require('mini.pairs').cr()`
--     return keys["cr"]
--   end
-- end
-- vim.api.nvim_set_keymap("i", "<CR>", "v:lua._G.cr_action()", { noremap = true, expr = true })

return M
