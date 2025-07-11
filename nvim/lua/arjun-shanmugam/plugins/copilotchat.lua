return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },                   -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken",                          -- Only on MacOS or Linux
    opts = {
      window = {
        layout = 'float',
        relative = 'editor', -- Anchor the window relative to the editor screen
        width = .33,       -- 100% of the editor's width
        height = 0.4,    -- 40% of the editor's height
        -- Position the top of the window at 60% from the top of the editor,
        -- effectively placing the 40% height window at the bottom.
        row = .4
      }
      --window = {
      --  layout = 'horizontal',
      -- height = .2,
      --zindex = -100
      -- }
    }, -- See Configuration section for options
    keys = {
      { "<leader>zc", ":CopilotChat<CR>",         mode = "n", desc = "Chat with Copilot" },
      { "<leader>ze", ":CopilotChatExplain<CR>",  mode = "v", desc = "Explain Code" },
      { "<leader>zr", ":CopilotChatReview<CR>",   mode = "v", desc = "Review Code" },
      { "<leader>zf", ":CopilotChatFix<CR>",      mode = "v", desc = "Fix Code Issues" },
      { "<leader>zo", ":CopilotChatOptimize<CR>", mode = "v", desc = "Optimize Code" },
      { "<leader>zd", ":CopilotChatDocs<CR>",     mode = "v", desc = "Generate Docs" },
      { "<leader>zt", ":CopilotChatTests<CR>",    mode = "v", desc = "Generate Tests" },
    },


  },

}
