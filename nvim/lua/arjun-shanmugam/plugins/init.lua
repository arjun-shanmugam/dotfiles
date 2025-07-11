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
    "GCBallesteros/jupytext.nvim",
    config = true,
    -- Depending on your nvim distro or config you may need to make the loading not lazy
    lazy = false,
  },


  {
    "ibhagwan/fzf-lua",
    dependencies = { "echasnovski/mini.icons" },
    opts = {}
  }

}
