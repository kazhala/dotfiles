local M = {}
local au = require('kaz.utils.au')

function M.run(package_name)
  for k, _ in pairs(package.loaded) do
    if string.match(k, '^' .. package_name) then
      package.loaded[k] = nil
    end
  end
end

function M.on_save(package_name)
  au.augroup('UnloadOnSave', {
    {
      event = 'BufWritePost',
      pattern = '*',
      callback = function()
        require('kaz.utils.unload').run(package_name)
      end,
    },
  })
  M.run(package_name)
end

return M
