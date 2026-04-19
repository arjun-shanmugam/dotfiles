return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    -- terminal_cmd = "aifx agent run claude --resume --dangerously-skip-permissions",
    terminal = {
      snacks_win_opts = {
        position = "bottom",
        height = 0.45,
        width = 1.0,
        border = "single",
        keys = {
          term_normal = false, -- use global t/<esc> -> <C-\><C-n> mapping instead
        },
      },
    },
  },
  keys = {
    { "<leader>a",  "",                               desc = "+ai",               mode = { "n", "v" } },
    { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
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
