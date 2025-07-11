return {

  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      return {
        sources = cmp.config.sources({
          { name = "nvim_lsp", },



          { name = "copilot" }


        })
      }
    end
  }

}
