if require("natashz.util").is_windows then
	vim.g.python3_host_prog = vim.fs.normalize("~/.nvimenv/Scripts/python.exe")
else
	vim.g.python3_host_prog = vim.fs.normalize("~/.nvimenv/bin/python")
end
