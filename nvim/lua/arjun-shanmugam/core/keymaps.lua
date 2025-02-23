vim.g.mapleader = " "

local keymap = vim.keymap

-- clear search highlights after searching
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search higlights" })


-- window management
keymap.set("n", "<leader>wv", "<C-w>s", { desc = "Split window horizontally" })  -- split window horizontally 
keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size"})  -- make split windows equal size
keymap.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close current split" })  -- close current split
keymap.set("n", "<leader>ww", "<C-w>w", { desc = "Navigate between splits" }) 
keymap.set("n", "<leader>bo", "<cmd>tabnew<CR>", { desc = "Open new tab" })  -- open new tab
keymap.set("n", "<leader>bx", "<cmd>tabclose<CR>", { desc = "Close current tab"})  -- close current tab
keymap.set("n", "<leader>bn", "<cmd>tabn<CR>", { desc = "Go to next tab"})  -- go to next tab 
keymap.set("n", "<leader>bp", "<cmd>tabp<CR>", { desc = "Go to previous tab"})  -- go to next tab 
keymap.set("n", "<leader>bf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab"})  -- go to next tab 

-- LSP 
keymap.set("n", "<leader>lf", vim.lsp.buf.format, {desc = "Format buffer"})
keymap.set("n", "<leader>lr", vim.lsp.buf.rename, {desc = "Rename symbol"})

-- Terminal
keymap.set("n", "<leader>tp", '<cmd>TermExec name="python" size=85 direction="vertical" cmd="source ${VIRTUAL_ENV}/bin/activate && ipython"<CR>', { desc = "Open iPython" })
keymap.set("n", "<leader>tt", '<cmd>TermExec name="main" size=85 direction="vertical" cmd=" " <cr>', { desc = "Open iPython" })
keymap.set("t", "<esc>",  "<C-\\><C-n>", { desc = "Leave terminal mode" })
keymap.set("n", "rr", "<cmd>ToggleTermSendCurrentLine<cr>", { desc = "Run current line"})
keymap.set("v", "rr", "<cmd>ToggleTermSendVisualLines<cr>", { desc = "Run current lines"})
