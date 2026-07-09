return {
  "hat0uma/csvview.nvim",
  cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  keys = {
    {
      "<leader>csv",
      function()
        local csvview = require("csvview")
        local bufnr = vim.api.nvim_get_current_buf()
        if csvview.is_enabled(bufnr) then
          csvview.disable(bufnr)
        else
          csvview.enable(bufnr, { view = { display_mode = "border", header_lnum = 1 } })
        end
      end,
      desc = "Enable/disable CSV view",
    },
  },
  opts = {},
}
