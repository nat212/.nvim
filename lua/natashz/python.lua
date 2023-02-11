if require("natashz.util").is_windows then
  local python_path = vim.fs.normalize("~/.nvimenv/Scripts/python.exe")
  local scripts_dir = vim.fs.dirname(python_path)
	vim.g.python3_host_prog = python_path
  vim.go.runtimepath = vim.go.runtimepath .. "," .. scripts_dir
else
  local python_path = vim.fs.normalize("~/.nvimenv/bin/python")
	vim.g.python3_host_prog = python_path
end
