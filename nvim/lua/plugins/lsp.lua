return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
    },
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local status, err = pcall(require, 'corp.lsp')
      if not status and not string.find(err, "module 'corp.lsp' not found") then
        error(err)
      end
    end,
  },
  'onsails/lspkind.nvim',
}

-- vim: set ts=2 sw=2 et:
