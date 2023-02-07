local M = {}
-- Capabilities to connect LSP to vim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Diagnostic bindings
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Terminal
-- vim.keymap.set("n", "<C-`>", "<Cmd>Lspsaga open_floaterm<CR>", opts)
-- vim.keymap.set("t", "<C-`>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], opts)

-- LSP bindings
M.on_attach = function(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	-- Gotos
	-- vim.keymap.set("n", "<space>d", "<Cmd>Lspsaga lsp_finder<CR>", bufopts)
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
	vim.keymap.set("x", "<A-CR>", vim.lsp.buf.range_code_action, bufopts)
	vim.keymap.set("n", "<space>f", "<Cmd>Neoformat<CR>", bufopts)
	vim.keymap.set("n", "<space>o", ":OrganiseImports<CR>", bufopts)
end

return M
