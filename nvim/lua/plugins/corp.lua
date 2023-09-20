local config = {}

local status, res = pcall(require, 'corp.plugins')
if not status and not string.find(res, 'module corp.plugins not found') then
  error(res)
elseif status then
  config = res
end

return config

-- vim: set sw=2 ts=2 et:
