return {
  "arjun-shanmugam/todoist.nvim",
  config = function()
    require("todoist").setup({
      token = "4f93781330d4ec768d88fbc2facf4e12e8d39e38",
      today_view_ui = "custom",   -- or "fzf"
      keymaps = {
        open_tasks = "<leader>to",
      },
    })
  end,
}
