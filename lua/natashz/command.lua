local command = require 'command_center'

local function reload_modules()
  if pcall(require, 'plenary') then
    require('plenary.reload').reload_module('natashz')
  end
  local modules = {'telescope', 'lsp', 'statusline', 'tabs'}
  for _, value in ipairs(modules) do
    require('natashz.'..value)
  end
end

command.add({
    {
        desc = 'Reload neovim configs',
        cmd = reload_modules,
        keys = {'n', '<F5>'}
    }
}, { mode = command.mode.SET_ADD })
