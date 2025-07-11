return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "BufReadPost",
        opts = {
          suggestion = {
            enabled = not vim.g.ai_cmp,
            auto_trigger = true,
            hide_during_completion = vim.g.ai_cmp,
            keymap = {
              accept = false, -- handled by nvim-cmp / blink.cmp
              next = "<M-]>",
              prev = "<M-[>",
            },
          },
          panel = { enabled = false },
          filetypes = {
            markdown = true,
            help = true,
          },
        },
      },
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
