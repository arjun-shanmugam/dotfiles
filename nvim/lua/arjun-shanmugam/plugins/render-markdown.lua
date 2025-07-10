-- Register copilot-chat filetype
require('render-markdown').setup({
  file_types = { 'markdown', 'copilot-chat' },
  render_modes = true
})

-- Adjust chat display settings
require('CopilotChat').setup({
  highlight_headers = false,
  separator = '---',
  error_header = '> [!ERROR] Error',
})
