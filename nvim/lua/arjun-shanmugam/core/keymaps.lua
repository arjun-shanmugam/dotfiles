vim.g.mapleader = " "

local keymap = vim.keymap

-- clear search highlights after searching
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search higlights" })


-- window management
keymap.set("n", "<leader>wv", "<C-w>s", { desc = "Split window horizontally" })  -- split window horizontally 
keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size"})  -- make split windows equal size
keymap.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close current split" })  -- close current split
keymap.set("n", "<leader>ww", "<C-w>w", { desc = "Navigate between splits" }) 

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })  -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab"})  -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab"})  -- go to next tab 
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab"})  -- go to next tab 
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab"})  -- go to next tab 

