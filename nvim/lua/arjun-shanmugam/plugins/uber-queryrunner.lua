return {
  "arjun-shanmugam/uber-queryrunner.nvim",
  config = function()
    require("uber_queryrunner").setup({
      user_email = "arjun.shanmugam@uber.com",
      keymaps = {
        run_query = "<leader>qr",
      },
    })
  end,
}
