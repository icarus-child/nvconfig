require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", "<leader>dl", "<cmd>diffget LO<CR>", { desc = "Diff Get Local" })
map("n", "<leader>db", "<cmd>diffget BA<CR>", { desc = "Diff Get Base" })
map("n", "<leader>dr", "<cmd>diffget RE<CR>", { desc = "Diff Get Remote" })

map("n", "<leader>gw", "<cmd>BlameToggle window<CR>", { desc = "Git blame window" })
map("n", "<leader>gv", "<cmd>BlameToggle virtual<CR>", { desc = "Git blame virtual" })

-- disable tab next buffer, reenable <C-i> next jump list position
map("n", "<Tab>", "<Tab>", {noremap = true})

map("i", "jk", "<ESC>")

map("n", "<leader>e", "<cmd>Ex<CR>", { desc = "Open netrw" })
map("n", "<C-n>", "<cmd>Rex<CR>", { desc = "Return to/from netrw (Rex)" })
