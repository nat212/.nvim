require('natashz.lsp')
require('natashz.statusline')
require('natashz.telescope')
require('natashz.git')
require('natashz.tabs')

P = function(v)
  print(vim.inspect(v))
  return v
end

if pcall(require, 'plenary') then
  RELOAD = require('plenary.reload').reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end

