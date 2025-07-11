return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
          require("copilot").setup({
            suggestion = { enabled = false} ,
            panel = { enabled = false }
          })
        end,
      },                                              -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken",                          -- Only on MacOS or Linux
    opts = {
      window = {
        layout = 'float',
        relative = 'editor',
        width = 0.4,
        height = 0.4,
        row = 70,
        col = 0
      }

    },
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

