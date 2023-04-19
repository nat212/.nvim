local M = {}

M.is_windows = vim.loop.os_uname().sysname == "Windows_NT"

M.get_init_vim = function()
  if M.is_windows then
    return vim.fs.normalize(vim.loop.os_homedir() .. "/AppData/Local/nvim/init.vim")
  else
    return vim.fs.normalize("$XDG_CONFIG_HOME/nvim/init.vim")
  end
end
M.mason_dir = vim.fs.normalize(vim.fn.stdpath("data") .. "/mason")

M.cmds = {
    dart_debug = vim.fs.normalize(M.mason_dir .. "/packages/dart-debug-adapter/extension/out/dist/debug.js"),
    omnisharp = "omnisharp",
    netcoredbg = "netcoredbg",
    delve = "dlv",
    jedi = "jedi-language-server",
}

if M.is_windows then
  M.shell = "pwsh"
  M.cmds.omnisharp = "omnisharp.cmd"
  M.cmds.netcoredbg = "netcoredbg.cmd"
  M.cmds.delve = "dlv.cmd"
  M.cmds.jedi = "jedi-language-server.cmd"
else
  M.shell = nil
end

return M
