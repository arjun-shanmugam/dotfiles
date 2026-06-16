return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      sql = { "sqlfluff" },
    },
    formatters = {
      sqlfluff = {
        -- Exit code 1 means "unfixable violations remain" but formatting was still applied
        exit_codes = { 0, 1 },
      },
    },
    format_on_save = function(bufnr)
      -- SQL formatting is slow and files are often WIP; skip on save, use <leader>lf manually
      if vim.bo[bufnr].filetype == "sql" then return end
      return { lsp_fallback = true }
    end,
  },
}
