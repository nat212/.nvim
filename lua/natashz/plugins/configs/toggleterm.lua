local M = {}

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

function M.close_all_terminals()
	-- local terminals = require("toggleterm.terminal").get_all(true)
	if require("toggleterm.ui").find_open_windows() then
		require("toggleterm").toggle_all(true)
	end
end

local function setup_autocmds()
	local id = vim.api.nvim_create_augroup("toggle_term_pre_exit", { clear = true })
	vim.api.nvim_create_autocmd("QuitPre", {
		group = id,
		callback = M.close_all_terminals,
	})

	vim.cmd([[autocmd! TermOpen term://* lua set_terminal_keymaps()]])
end

M.setup = function()
	require("toggleterm").setup({
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
		end,
		open_mapping = [[<c-\>]],
		shell = require("natashz.core.util").shell,
		direction = "vertical",
		on_close = function()
			_G.reset_dapui_layout()
		end,
		on_open = function()
			_G.reset_dapui_layout()
		end,
		start_in_insert = true,
		persist_mode = true,
    auto_scroll = true,
	})

	setup_autocmds()
end

return M
