require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", "<leader>dl", "<cmd>diffget LO<CR>", { desc = "Diff Get Local" })
map("n", "<leader>db", "<cmd>diffget BA<CR>", { desc = "Diff Get Base" })
map("n", "<leader>dr", "<cmd>diffget RE<CR>", { desc = "Diff Get Remote" })

map("n", "<leader>gw", "<cmd>BlameToggle window<CR>", { desc = "Git blame window" })
map("n", "<leader>gv", "<cmd>BlameToggle virtual<CR>", { desc = "Git blame virtual" })

-- disable tab next buffer, reenable <C-i> next jump list position
map("n", "<Tab>", "<Tab>", { noremap = true })

-- map("i", "jk", "<ESC>")
map("n", "<leader>x", "<leader>x", { noremap = true })
map("n", "<leader>xb", "<cmd>bd<CR>", { desc = "Delete buffer" })

map("n", "<leader>e", "<cmd>Oil --float<CR>", { desc = "Floating Oil Window" })
map("n", "<C-n>", "<cmd>Oil<CR>", { desc = "Oil Window" })

map("n", "<leader>u", "<cmd>Telescope undo<cr>", { desc = "Undo history" })

map({ "n", "i" }, "<S-Down>", "")
