return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      require'nvim-treesitter.configs'.setup {
        -- Modules and its options go here
        ensure_installed = "all",
        sync_install = true,  -- Uncomment when installing on small machine
        highlight = { enable = true },
        incremental_selection = { enable = true },
        textobjects = { enable = true },
        indent = { enable = true },
      }
      if vim.treesitter.highlighter.hl_map ~= nil then
        vim.treesitter.highlighter.hl_map.error = nil
      end
    end
  }
}

-- vim: set sw=2 ts=2 et:
