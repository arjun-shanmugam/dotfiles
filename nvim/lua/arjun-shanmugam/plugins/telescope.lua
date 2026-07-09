return { {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    { 'nvim-telescope/telescope-ui-select.nvim' }
  },
  opts = {

  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        preview = {
          treesitter = false,
        },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next,     -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
          n = {
            ["y"] = function()
              local entry = action_state.get_selected_entry()
              if not entry then return end
              local path = entry.path or entry.value
              vim.fn.setreg(vim.v.register, vim.fn.fnamemodify(path, ":."))
            end,
            ["Y"] = function()
              local entry = action_state.get_selected_entry()
              if not entry then return end
              local path = entry.path or entry.value
              vim.fn.setreg(vim.v.register, vim.fn.fnamemodify(path, ":p"))
            end,
          },
        },
      },
    })
    -- This is your opts table
    require("telescope").setup {
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
            -- even more opts
          }

          -- pseudo code / specification for writing custom displays, like the one
          -- for "codeactions"
          -- specific_opts = {
          --   [kind] = {
          --     make_indexed = function(items) -> indexed_items, width,
          --     make_displayer = function(widths) -> displayer
          --     make_display = function(displayer) -> function(e)
          --     make_ordinal = function(e) -> string
          --   },
          --   -- for example to disable the custom builtin "codeactions" display
          --      do the following
          --   codeactions = false,
          -- }
        }
      }
    }
    -- To get ui-select loaded and working with telescope, you need to call
    -- load_extension, somewhere after setup function:
    require("telescope").load_extension("ui-select")
    -- set keymaps
    local keymap = vim.keymap

    local function toggle_picker(cmd)
      return function()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.bo[buf].filetype == "TelescopePrompt" then
            actions.close(buf)
            return
          end
        end
        vim.cmd(cmd)
      end
    end

    keymap.set("n", "<leader>ff", toggle_picker("Telescope find_files"), { desc = "Toggle fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", toggle_picker("Telescope live_grep"), { desc = "Toggle find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
  end,
}, { 'nvim-telescope/telescope-ui-select.nvim' } }
