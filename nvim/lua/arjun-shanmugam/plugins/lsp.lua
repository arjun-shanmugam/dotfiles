-- LSPs to be installed
local lsp_servers = {
  pyright = {},

  -- rust
  rust_analyzer = {},

  -- web development
  html = {},
  cssls = {},
  emmet_ls = {},



  -- quarto/markdown
  marksman = {
    filetypes = { "markdown", "quarto" },
  },

}

return {
  -- LSP plugins and config
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "neovim/nvim-lspconfig", },
      { "mason-org/mason.nvim",  opts = {} },
      { "j-hui/fidget.nvim",     opts = {}, tag = "legacy" },
      { "folke/neodev.nvim",     opts = {} },
      { "hrsh7th/cmp-nvim-lsp",  opts = {} },

    },
    config = function()
      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(lsp_servers),
        automatic_installation = true,
      })



      require("lspconfig").sourcekit.setup({})
    end
  },

  {
    "nvimtools/none-ls.nvim",
    config = function()
      require("null-ls").setup({
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                vim.lsp.buf.format({ async = false })
              end,
            })
          end
        end,
        sources = {
          require("null-ls").builtins.formatting.prettierd,
          require("null-ls").builtins.diagnostics.markdownlint,
          -- FIX: this was causing crash... figure out why
          -- require("null-ls").builtins.code_actions.proselint,
          -- require("null-ls").builtins.diagnostics.proselint.with({
          -- 	extra_filetypes = { "toml", "yaml" },
          -- }),
          require("null-ls").builtins.diagnostics.swiftlint,
          require("null-ls").builtins.formatting.swiftlint,
          require("null-ls").builtins.formatting.swiftformat,
          require("null-ls").builtins.formatting.black,
        }
      })
    end
  },

  -- autocomplete
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "jmbuhr/otter.nvim",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path"
    },
    config = function()
      -- load snippet enginge
      local luasnip = require("luasnip")
      luasnip.config.setup({
        enable_autosnippets = true,
      })
      require("luasnip.loaders.from_lua")
          .load({ paths = "~/.config/nvim/snippets/" })

      -- nvim-cmp setup
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ['<C-c>'] = cmp.mapping.abort(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete({}),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          -- { name = "omni" },
          { name = "otter" }, -- for quarto
        },
      })
    end

  },
}
