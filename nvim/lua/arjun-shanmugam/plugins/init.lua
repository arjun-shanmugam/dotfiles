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

  -- {
  --   "zbirenbaum/copilot-cmp",
  --   config = function()
  --     require("copilot_cmp").setup()
  --   end
  -- },


}
