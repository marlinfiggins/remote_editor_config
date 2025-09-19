local map = vim.keymap.set

vim.opt.hlsearch = true
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostics
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostics" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics list" })

-- Terminal
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Splits
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move left" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move right" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move down" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move up" })
