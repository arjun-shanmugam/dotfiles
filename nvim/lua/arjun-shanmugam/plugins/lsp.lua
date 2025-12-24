-- Updated lsp.lua
local lsp_servers = {
  basedpyright = {},
  ruff = {},
  lua_ls = {},
}
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  end,
})

return {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      {
        'neovim/nvim-lspconfig',
        dependencies = { 'saghen/blink.cmp' },
        config = function()
          local capabilities = require('blink.cmp').get_lsp_capabilities()

          -- NEW: Use vim.lsp.config and vim.lsp.enable
          -- This replaces the old lspconfig[server].setup() loop
          for server, opts in pairs(lsp_servers) do
            -- Merge your blink capabilities into the server config
            opts.capabilities = capabilities

            -- 1. Apply the configuration
            vim.lsp.config(server, opts)
            -- 2. Enable the server to auto-start on the correct filetypes
            vim.lsp.enable(server)
          end
        end
      },
      { "mason-org/mason.nvim", opts = {} },
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(lsp_servers),
        automatic_installation = true,
      })
    end
  },

  {
    "nvimtools/none-ls.nvim",
    config = function()
      -- Use the local variable name 'null_ls' consistently
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.black,
        }
      })
    end
  },
}
