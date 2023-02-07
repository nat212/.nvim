local M = {}

M.is_windows = vim.loop.os_uname().sysname == "Windows_NT"

M.get_init_vim = function()
	if M.is_windows then
		return vim.fs.normalize(vim.loop.os_homedir() .. "/AppData/Local/nvim/init.vim")
	else
		return vim.fs.normalize("$XDG_CONFIG_HOME/nvim/init.vim")
	end
end

return M
