return {


  {
    "nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      {
        "zbirenbaum/copilot-cmp",
        opts = {},
      },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      return {
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "copilot" }
        })
      }
    end,
  },

}
