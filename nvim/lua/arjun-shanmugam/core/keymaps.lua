vim.g.mapleader = " "

local keymap = vim.keymap

-- clear search highlights after searching
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search higlights" })


-- window management
keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })                   -- split window vertically
keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" })                 -- split window horizontally
keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })                    -- make split windows equal size
keymap.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close current split" })               -- close current split
keymap.set("n", "<leader>ww", function()
  vim.cmd("wincmd w")
  if vim.bo.buftype == "terminal" then
    vim.cmd("stopinsert")
  end
end, { desc = "Navigate between splits" })
keymap.set("n", "<leader>bo", "<cmd>tabnew<CR>", { desc = "Open new tab" })                     -- open new tab
keymap.set("n", "<leader>bx", "<cmd>tabclose<CR>", { desc = "Close current tab" })              -- close current tab
keymap.set("n", "<leader>bn", "<cmd>tabn<CR>", { desc = "Go to next tab" })                     -- go to next tab
keymap.set("n", "<leader>bp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })                 -- go to next tab
keymap.set("n", "<leader>bf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) -- go to next tab

-- LSP
-- Use conform when available (e.g. SQL via sql-formatter), fall back to LSP (e.g. Python via ruff)
keymap.set("n", "<leader>lf", function()
  require("conform").format({ lsp_fallback = true, timeout_ms = 10000 })
end, { desc = "Format buffer" })
keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename symbol" })

-- Terminal
keymap.set("n", "<leader>tt", "<cmd>ToggleTerm size=15 direction=horizontal<cr>",
  { desc = "Toggle Terminal" })
keymap.set("t", "<esc>", "<C-\\><C-n>", { desc = "Leave terminal mode" })
keymap.set("n", "rr", "<cmd>ToggleTermSendCurrentLine<cr>", { desc = "Run current line" })
keymap.set("v", "rr", "<cmd>ToggleTermSendVisualLines<cr>", { desc = "Run current lines" })

-- Swap positions of the Claude and terminal windows (only when both are open).
-- Whichever window currently spans the full width is at the bottom; it moves to
-- the right, and the other moves to the bottom last so it spans the full width.
keymap.set("n", "<leader>swap", function()
  local term_win, claude_win
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local ft = vim.bo[vim.api.nvim_win_get_buf(win)].filetype
    if ft == "toggleterm" then
      term_win = win
    elseif ft == "snacks_terminal" then
      claude_win = win
    end
  end
  if not (term_win and claude_win) then
    vim.notify("Both Claude and terminal windows must be open to swap", vim.log.levels.WARN)
    return
  end
  local to_side, to_bottom
  if vim.api.nvim_win_get_width(term_win) >= vim.o.columns then
    to_side, to_bottom = term_win, claude_win
  else
    to_side, to_bottom = claude_win, term_win
  end
  vim.api.nvim_win_call(to_side, function() vim.cmd("wincmd L") end)
  vim.api.nvim_win_call(to_bottom, function() vim.cmd("wincmd J") end)
  vim.api.nvim_win_set_width(to_side, math.floor(vim.o.columns * 0.35))
  vim.api.nvim_win_set_height(to_bottom, 15)
end, { desc = "Swap Claude and terminal window positions" })

-- Copy URL under cursor to clipboard (via OSC 52, works over SSH)
local function copy_url()
  local url = vim.fn.expand('<cWORD>'):match('https?://[^%s]+')
  if not url then
    vim.notify('No URL found under cursor', vim.log.levels.WARN)
    return
  end
  vim.fn.setreg('+', url)
  vim.notify('URL copied: ' .. url, vim.log.levels.INFO)
end
keymap.set("n", "gx", copy_url, { desc = "Copy URL to clipboard" })

-- Yank current file's path
keymap.set("n", "<leader>ycf", function()
  vim.fn.setreg(vim.v.register, vim.fn.expand("%:."))
end, { desc = "Yank relative path of current file" })
keymap.set("n", "<leader>Ycf", function()
  vim.fn.setreg(vim.v.register, vim.fn.expand("%:p"))
end, { desc = "Yank absolute path of current file" })

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
