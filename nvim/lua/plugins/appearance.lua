return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require'lualine'.setup{
        options = {
          theme = 'solarized_dark'
        },
      }
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
