local ok, impatient = pcall(require, 'impatient')
if ok then
  impatient.enable_profile()
else
  vim.notify(impatient)
end

require('kaz.settings')
require('kaz.keybindings')
require('kaz.plugins')
require('kaz.autocmds')
require('kaz.commands')
