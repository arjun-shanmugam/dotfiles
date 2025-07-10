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
lazy=false,
	},
  {
    "github/copilot.vim"
  },
{
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    filetypes = { 'markdown', 'copilot-chat' }
}


}
