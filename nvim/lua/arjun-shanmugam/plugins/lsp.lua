-- LSPs to be installed
local lsp_servers = {
  basedpyright = {},

  -- astral python tools
  ruff = {}, -- linter/formatter
  -- ty = {}, -- type checker

  -- lua
  lua_ls = {},




}

return {
  -- LSP plugins and config
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      {
        'neovim/nvim-lspconfig',
        dependencies = { 'saghen/blink.cmp' },

        config = function()
          local capabilities = require('blink.cmp').get_lsp_capabilities()
          local lspconfig = require('lspconfig')

          lspconfig['lua_ls'].setup({ capabilities = capabilities })
        end
      },
      { "mason-org/mason.nvim", opts = {} },

    },
    config = function()
      require("mason-lspconfig").setup({
        automatic_enable = true,
        ensure_installed = vim.tbl_keys(lsp_servers),
        automatic_installation = true,
      })
    end
  },

  {
    "nvimtools/none-ls.nvim",
    config = function()
      require("null-ls").setup({
        sources = {
          require("null-ls").builtins.formatting.black,
        }
      })
    end
  },

}
