local config = {
  "nvim-telescope/telescope.nvim",
  cmd = 'Telescope',
  -- Add telescope-codesearch as a dependency of telescope.nvim.
  -- This ensures that telescope-codesearch is loaded when telescope.nvim is
  -- loaded. So if you use the `Telescope` ex-command `codesearch` will
  -- immediately appear as one of the available pickers.
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function ()
    require('telescope').setup{}
  end
}

local dependencies = require('utils').require_or('corp.telescope')
if dependencies ~= nil then
  for _, v in ipairs(dependencies) do
    table.insert(config.dependencies, v)
  end
end

return config

-- vim: set sw=2 ts=2 et:
