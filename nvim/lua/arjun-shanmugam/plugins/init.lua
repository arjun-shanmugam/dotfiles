return {
  -- shows pending keybinds
  {
    "folke/which-key.nvim",
    opts = {},
  },
  -- highlight todo comments
  {
    "folke/todo-comments.nvim",
    opts = {},
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- floating terminal
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
      float_opts = { border = "curved" }
    }
  },
  -- "gc" to comment visual regions/lines
  {
    "numToStr/Comment.nvim",
    opts = {},
  },

  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end
  },

  {
    "jvdmeulen/json-fold.nvim",
    config = function()
      require('json-fold').setup()

      -- keybinding for the min (un-)fold actions
      vim.api.nvim_set_keymap('n', '<leader>jc', ':JsonFoldFromCursor<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>jd', ':JsonUnfoldFromCursor<CR>', { noremap = true, silent = true })

      -- keybinding for the max (un-)fold actions
      vim.api.nvim_set_keymap('n', '<leader>jC', ':JsonMaxFoldFromCursor<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>jD', ':JsonMaxUnfoldFromCursor<CR>', { noremap = true, silent = true })
    end
  }

}
