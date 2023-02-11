if require("natashz.util").is_windows then
  local python_path = vim.fs.normalize("~/.nvimenv/Scripts/python.exe")
	vim.g.python3_host_prog = python_path
  vim.g.wakatime_PythonBinary = python_path
else
  local python_path = vim.fs.normalize("~/.nvimenv/bin/python")
	vim.g.python3_host_prog = python_path
  vim.g.wakatime_PythonBinary = python_path
end

require("natashz.plugins")
require("natashz.sets")
require("natashz.git")
require("natashz.mappings")
require("natashz.python")
require("natashz.neovide")
