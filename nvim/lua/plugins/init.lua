return {
	-- color theme
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			background = {
				light = "latte",
				dark = "frappe",
			},
		},
	},

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

	-- adds git releated signs to the gutter, as well as utilities for managing changes
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},

	-- add indentation guides and highlighting of current scope
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			scope = { enabled = false },
		}
	},

	-- { "hiphish/rainbow-delimiters.nvim" },

	-- "gc" to comment visual regions/lines
	{
		"numToStr/Comment.nvim",
		opts = {},
	},
	{
  "GCBallesteros/jupytext.nvim",
  config = true,
  -- Depending on your nvim distro or config you may need to make the loading not lazy
lazy=false,
	}
}
