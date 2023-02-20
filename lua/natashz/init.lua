if require("natashz.core.util").is_windows then
  local python_path = vim.fs.normalize("~/.nvimenv/Scripts/python.exe")
  local scripts_dir = vim.fs.dirname(python_path)
	vim.g.python3_host_prog = python_path
  vim.g.wakatime_PythonBinary = python_path
  vim.go.runtimepath = vim.go.runtimepath .. "," .. scripts_dir
else
  local python_path = vim.fs.normalize("~/.nvimenv/bin/python")
  local scripts_dir = vim.fs.dirname(python_path)
	vim.g.python3_host_prog = python_path
  vim.g.wakatime_PythonBinary = python_path
  vim.go.runtimepath = vim.go.runtimepath .. "," .. scripts_dir
end

require("natashz.sets")
require("natashz.plugins")
require("natashz.mappings")
require("natashz.neovide")
