return {
  {
    "willothy/nvim-cokeline",
    dependencies = {
      "nvim-lua/plenary.nvim",        -- Required for v0.4.0+
      "kyazdani42/nvim-web-devicons", -- If you want devicons
      "stevearc/resession.nvim"       -- Optional, for persistent history
    },
    config = true
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local config = {
        options = {
          theme = 'solarized_dark'
        },
        sections = {
          lualine_b = { 'branch', 'diff', 'diagnostics' }
        }
      }

      local corp = require('utils').require_or('corp.lualine-config')
      if corp then config = corp(config) end
      require('lualine').setup(config)
    end,
  },
  {
    'svrana/neosolarized.nvim',
    lazy = false,
    priority = 1000,
    dependencies = {
      {
        'tjdevries/colorbuddy.nvim',
        config = function()
          require('colorbuddy').setup()
        end,
      },
    },
    config = function()
      require('neosolarized').setup()
      vim.opt.termguicolors = true
      vim.cmd([[colorscheme neosolarized]])
    end,
  },
}

-- vim: set sw=2 ts=2 et:
