vim.g.mapleader = " "

local keymap = vim.keymap

-- clear search highlights after searching
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search higlights" })


-- window management
keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })                   -- split window vertically
keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" })                 -- split window horizontally
keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })                    -- make split windows equal size
keymap.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close current split" })               -- close current split
keymap.set("n", "<leader>ww", "<C-w>w", { desc = "Navigate between splits" })
keymap.set("n", "<leader>bo", "<cmd>tabnew<CR>", { desc = "Open new tab" })                     -- open new tab
keymap.set("n", "<leader>bx", "<cmd>tabclose<CR>", { desc = "Close current tab" })              -- close current tab
keymap.set("n", "<leader>bn", "<cmd>tabn<CR>", { desc = "Go to next tab" })                     -- go to next tab
keymap.set("n", "<leader>bp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })                 -- go to next tab
keymap.set("n", "<leader>bf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) -- go to next tab

-- LSP
keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format buffer" })
keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename symbol" })

-- Terminal
keymap.set("n", "<leader>tt", '<cmd>TermExec name="main" size=25 direction="horizontal" cmd=" " <cr>',
  { desc = "Open Terminal" })
keymap.set("t", "<esc>", "<C-\\><C-n>", { desc = "Leave terminal mode" })
keymap.set("n", "rr", "<cmd>ToggleTermSendCurrentLine<cr>", { desc = "Run current line" })
keymap.set("v", "rr", "<cmd>ToggleTermSendVisualLines<cr>", { desc = "Run current lines" })

-- Open URL under cursor via kitten ssh, falling back to clipboard copy
local function find_kitty_socket()
  local s = vim.env.KITTY_LISTEN_ON
  if s and s ~= '' then return s end
  s = vim.fn.system('sh -c "echo -n $KITTY_LISTEN_ON"')
  if s ~= '' then return s end
  -- kitten ssh may forward the socket to a temp path
  s = vim.fn.system('ls /tmp/.kitty-ssh-* 2>/dev/null | head -1'):gsub('%s+$', '')
  if s ~= '' then return 'unix:' .. s end
  return nil
end

local function open_url()
  local url = vim.fn.expand('<cWORD>'):match('https?://[^%s]+')
  if not url then
    vim.notify('No URL found under cursor', vim.log.levels.WARN)
    return
  end
  local kitty_socket = find_kitty_socket()
  if kitty_socket then
    local result = vim.fn.system({ 'kitten', '@', '--to', kitty_socket, 'launch', '--type=background', '--', 'open', url })
    if vim.v.shell_error == 0 then
      vim.notify('Opened: ' .. url, vim.log.levels.INFO)
      return
    end
  end
  -- Fallback: copy to local clipboard via OSC 52
  vim.fn.setreg('+', url)
  vim.notify('URL copied to clipboard: ' .. url, vim.log.levels.INFO)
end

-- Debug helper: run :KittyDebug inside neovim to check what kitty env vars are available
vim.api.nvim_create_user_command('KittyDebug', function()
  local vars = { 'KITTY_LISTEN_ON', 'KITTY_WINDOW_ID', 'KITTY_PID', 'TERM' }
  local lines = {}
  for _, v in ipairs(vars) do
    table.insert(lines, v .. ' = ' .. (vim.env[v] or '(not set)'))
  end
  local shell_val = vim.fn.system('sh -c "echo -n $KITTY_LISTEN_ON"')
  table.insert(lines, 'shell KITTY_LISTEN_ON = ' .. (shell_val == '' and '(empty)' or shell_val))
  vim.notify(table.concat(lines, '\n'), vim.log.levels.INFO)
end, {})
keymap.set("n", "gx", open_url, { desc = "Open URL" })
keymap.set("n", "<C-LeftMouse>", open_url, { desc = "Open URL" })

-- Vim Doge (auto generate docstrings)

-- Generate comment for current line
keymap.set('n', '<Leader>d', '<Plug>(doge-generate)')

-- Interactive mode comment todo-jumping
keymap.set('n', '<TAB>', '<Plug>(doge-comment-jump-forward)')
keymap.set('n', '<S-TAB>', '<Plug>(doge-comment-jump-backward)')
keymap.set('i', '<TAB>', '<Plug>(doge-comment-jump-forward)')
keymap.set('i', '<S-TAB>', '<Plug>(doge-comment-jump-backward)')
keymap.set('x', '<TAB>', '<Plug>(doge-comment-jump-forward)')
keymap.set('x', '<S-TAB>', '<Plug>(doge-comment-jump-backward)')

-- Code Companion
keymap.set("n", "<leader>zc", "<cmd>CodeCompanionChat Toggle<CR>", { desc = "Open Code Companion Chat" })
keymap.set("v", "<leader>ze", "<cmd>'<,'>CodeCompanion /explain<CR>", { desc = "Explain Selected Code" })
keymap.set("v", "<leader>zf", "<cmd>'<,'>CodeCompanion /fix<CR>", { desc = "Fix Selected Code" })
keymap.set("v", "<leader>zid", "<cmd>'<,'>CodeCompanion /inline_documentation<CR>",
  { desc = "Write Inline Documentation" })
keymap.set("v", "<leader>za", "<cmd>CodeCompanionChat Add<cr>", { desc = "Add Selected Code to Chat Window" })
