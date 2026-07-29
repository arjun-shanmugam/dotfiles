return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    terminal_cmd = "aifx agent run claude --dangerously-skip-permissions",
    -- Claude Code >= 2.1.89 renders in the terminal's alternate screen,
    -- which leaves nvim's terminal buffer without scrollback (can't scroll
    -- up past the visible screen in normal mode). Opt out so output stays
    -- in the regular buffer.
    env = {
      CLAUDE_CODE_DISABLE_ALTERNATE_SCREEN = "1",
    },
    terminal = {
      snacks_win_opts = {
        position = "right",
        width = 0.35,
        border = "single",
        keys = {
          term_normal = false, -- use global t/<esc> -> <C-\><C-n> mapping instead
        },
      },
    },
  },
  keys = {
    { "<leader>a",  "",                               desc = "+ai",               mode = { "n", "v" } },
    {
      "<leader>ac",
      function()
        vim.cmd("ClaudeCode")
        -- If a toggleterm terminal is already open, Claude's vertical split
        -- (tab-level) cuts across its row and shrinks its width. Force the
        -- terminal back to a full-width window at the bottom.
        vim.schedule(function()
          for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].filetype == "toggleterm" then
              vim.api.nvim_win_call(win, function()
                vim.cmd("wincmd J")
              end)
            end
          end
        end)
      end,
      desc = "Toggle Claude",
    },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        mode = "v",                 desc = "Send to Claude" },
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil" },
    },
    { "<leader>A", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>R", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
  },
}
