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
      'onsails/lspkind.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('utils').require_or('corp.cmp')

      local cmp = require('cmp')

      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-u>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.close(),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-m>"] = cmp.mapping.confirm({ select = true }),
        }),

        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "vim_vsnip" },
          { name = "buffer",   keyword_length = 5 },
          { name = "buganizer" },
          { name = 'nvim_ciderlsp' },
        },

        sorting = {
          comparators = {}, -- We stop all sorting to let the lsp do the sorting
        },

        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },

        formatting = {
          format = require('lspkind').cmp_format(require'lspkind_config'),
        },

        experimental = {
          native_menu = false,
          ghost_text = true,
        },
      })

      vim.cmd([[
        augroup CmpZsh
          au!
          autocmd Filetype zsh lua require'cmp'.setup.buffer { sources = { { name = "zsh" }, } }
        augroup END
      ]])
    end,
    event = "VeryLazy"
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('utils').require_or('corp.lsp')

      require('lspconfig').gopls.setup({
        capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = require('utils').on_attach,
        single_file_support = false,
      })

      vim.opt.completeopt = { "menu", "menuone", "noselect" }
      vim.opt.completeopt = { "menu", "menuone", "noselect" }
      vim.opt.shortmess:append("c")
    end,
    event = "VeryLazy"
  },
  {
    'onsails/lspkind.nvim',
    config = function()
      require('lspkind').init()
    end
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      -- options
    },
  },
}

-- vim: set ts=2 sw=2 et:
