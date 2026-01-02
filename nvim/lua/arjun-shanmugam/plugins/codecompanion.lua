return {
  "olimorris/codecompanion.nvim",
  version = "^18.0.0",
  opts = {
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          -- MCP Tools
          make_tools = true,                  -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
          show_server_tools_in_chat = true,   -- Show individual tools in chat completion (when make_tools=true)
          add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
          show_result_in_chat = true,         -- Show tool results directly in chat buffer
          format_tool = nil,                  -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
          -- MCP Resources
          make_vars = true,                   -- Convert MCP resources to #variables for prompts
          -- MCP Prompts
          make_slash_commands = true,         -- Add MCP prompts as /slash commands
        }
      }
    },
    interactions = {
      inline = {
        keymaps = {
          accept_change = {
            modes = { n = "A" },
            description = "Accept the suggested change",
          },
          reject_change = {
            modes = { n = "R" },
            opts = { nowait = true },
            description = "Reject the suggested change",
          },
        },
      },
    },
    prompt_library = {
      ["Write Inline Documentation"] = {
        interaction = "inline",
        description = "Generates inline documentation for the selected code",
        opts = { alias = "inline_documentation" },
        prompts = {
          {
            role = "system",
            content = "You are an expert programmer who excels at explaining code clearly and concisely.",
          },
          {
            role = "user",
            content = function(context)
              local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
              return "Please write inline comments that document the following code:\n\n```" ..
                  context.filetype .. "\n" .. text .. "\n```"
            end,
          },
        },
      },
    },
    display = {
      chat = {
        window = {
          buflisted = false,     -- List the chat buffer in the buffer list?
          sticky = false,        -- Chat buffer remains open when switching tabs

          layout = "horizontal", -- float|vertical|horizontal|buffer
          position = "bottom",   -- left|right|top|bottom (nil will default depending on vim.opt.splitright|vim.opt.splitbelow)

          height = 0.3, ---@return number|fun(): number
          border = "single",
          relative = "editor",

          -- Ensure that long paragraphs of markdown are wrapped
          opts = {
            breakindent = true,
            linebreak = true,
            wrap = true,
          },
        },
      },
    }
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      build = ":Copilot auth",
      event = "BufReadPost",
      opts = {
        suggestion = {
          enabled = not vim.g.ai_cmp,
          auto_trigger = true,
          hide_during_completion = vim.g.ai_cmp,
          keymap = {
            accept = "<D-a>",
            next = "<D-]>",
            prev = "<D-[>",
          },
        },
        panel = { enabled = false },
        filetypes = {
          markdown = true,
          help = true,
        },
      },
    }
  },

}
