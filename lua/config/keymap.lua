-- required in which-key plugin spec in plugins/ui.lua as `require 'config.keymap'`
local wk = require "which-key"

local nmap = function(key, effect, desc)
  vim.keymap.set("n", key, effect, { silent = true, noremap = true, desc = desc })
end

local vmap = function(key, effect, desc)
  vim.keymap.set("v", key, effect, { silent = true, noremap = true, desc = desc })
end

local imap = function(key, effect, desc)
  vim.keymap.set("i", key, effect, { silent = true, noremap = true, desc = desc })
end

local cmap = function(key, effect, desc)
  vim.keymap.set("c", key, effect, { silent = true, noremap = true, desc = desc })
end

-- unbind
-- vim.keymap.del("n", "<CR>")

-- select last paste
nmap("gV", "`[v`]", "select last paste")

-- move in command line
cmap("<C-a>", "<Home>")

-- save with ctrl+s
imap("<C-s>", "<esc><cmd>update<cr>a", "save")
nmap("<C-s>", "<cmd>update<cr>", "save")

-- Move between windows using <ctrl> direction
nmap("<C-j>", "<C-W>j")
nmap("<C-k>", "<C-W>k")
nmap("<C-h>", "<C-W>h")
nmap("<C-l>", "<C-W>l")

-- Resize window using <shift> arrow keys
nmap("<S-Up>", "<cmd>resize +2<CR>")
nmap("<S-Down>", "<cmd>resize -2<CR>")
nmap("<S-Left>", "<cmd>vertical resize -2<CR>")
nmap("<S-Right>", "<cmd>vertical resize +2<CR>")

-- Move in edit mode with hjkl
imap("<C-h>", "<Left>", "move left")
imap("<C-j>", "<Down>", "move down")
imap("<C-k>", "<Up>", "move up")
imap("<C-l>", "<Right>", "move right")

-- Add undo break-points
imap(",", ",<c-g>u")
imap(".", ".<c-g>u")
imap(";", ";<c-g>u")

-- keep selection after indent/dedent
vmap(">", ">gv", "indent")
vmap("<", "<gv", "outdent")

-- comment
vim.keymap.set("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
vim.keymap.set("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- center after search and jumps
nmap("n", "nzz", "next match")
nmap("N", "Nzz", "prev match")
-- nmap('<c-d>', '<c-d>zz')
-- nmap('<c-u>', '<c-u>zz')

-- move between splits and tabs
nmap("<c-h>", "<c-w>h")
nmap("<c-l>", "<c-w>l")
nmap("<c-j>", "<c-w>j")
nmap("<c-k>", "<c-w>k")
nmap("H", "<cmd>tabprevious<cr>", "prev tab")
nmap("L", "<cmd>tabnext<cr>", "next tab")

local function toggle_light_dark_theme()
  if vim.o.background == "light" then
    vim.o.background = "dark"
    vim.cmd.colorscheme = "terafox"
  else
    vim.o.background = "light"
    vim.cmd.colorscheme = "dawnfox"
  end
end

--show keybindings with whichkey
--add your own here if you want them to
--show up in the popup as well

-- normal mode
wk.add({
  { "<c-LeftMouse>", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "go to definition" },
  { "<esc>", "<cmd>noh<cr>", desc = "remove search highlight" },
  { "[q", "<cmd>silent cprev<cr>", desc = "[q]uickfix prev" },
  { "]q", "<cmd>silent cnext<cr>", desc = "[q]uickfix next" },
  { "gl", "<c-]>", desc = "open help link" },
  { "z?", "<cmd>setlocal spell!<cr>", desc = "toggle [z]pellcheck" },
  { "zl", "<cmd>Telescope spell_suggest<cr>", desc = "[l]ist spelling suggestions" },
  { "vih", "<cmd>Gitsigns select_hunk<cr>", desc = "select git [h]unk" },
}, { mode = "n", silent = true })

-- visual mode
wk.add {
  {
    mode = { "v" },
    { ".", ":norm .<cr>", desc = "repat last normal mode command" },
    { "<M-j>", ":m'>+<cr>`<my`>mzgv`yo`z", desc = "move line down" },
    { "<M-k>", ":m'<-2<cr>`>my`<mzgv`yo`z", desc = "move line up" },
    { "q", ":norm @q<cr>", desc = "repeat q macro" },
  },
}

-- visual with <leader>
wk.add({
  { "<leader>d", '"_d', desc = "delete without overwriting reg", mode = "v" },
  { "<leader>p", '"_dP', desc = "replace without overwriting reg", mode = "v" },
}, { mode = "v" })

-- insert mode
wk.add({
  {
    mode = { "i" },
    { "<c-x><c-x>", "<c-x><c-o>", desc = "omnifunc completion" },
    { "<m-->", " <- ", desc = "assign" },
    { "<m-m>", " |>", desc = "pipe" },
  },
}, { mode = "i" })

local function toggle_conceal()
  local lvl = vim.o.conceallevel
  if lvl > DefaultConcealLevel then
    vim.o.conceallevel = DefaultConcealLevel
  else
    vim.o.conceallevel = FullConcealLevel
  end
end

-- eval "$(tmux showenv -s DISPLAY)"
-- normal mode with <leader>
wk.add({
  {
    { "<leader>c", group = "[c]ode / [c]ell / [c]hunk" },
    { "<leader>ct", "<cmd>TodoQuickFix<cr>", desc = "open [T]ODO comment list" },
    { "<leader>d", group = "[d]ebug" },
    { "<leader>dt", group = "[t]est" },
    { "<leader>t", group = "[t]abby / [t]reesj" },
    { "<leader>tn", "<cmd>tabnew<CR>", desc = "[n]ew tab" },
    { "<leader>tc", "<cmd>tabclose<CR>", desc = "[c]lose tab" },
    -- { "<leader>e", group = "[e]dit" },
    -- { "<leader>e", group = "[t]mux" },
    { "<leader>fd", [[eval "$(tmux showenv -s DISPLAY)"]], desc = "[d]isplay fix" },
    { "<leader>f", group = "[f]ind (telescope)" },
    { "<leader>f<space>", "<cmd>Telescope buffers<cr>", desc = "[ ] buffers" },
    { "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "[w]ord" },
    { "<leader>fM", "<cmd>Telescope man_pages<cr>", desc = "[M]an pages" },
    { "<leader>fb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "[b]uffer fuzzy find" },
    { "<leader>fc", "<cmd>Telescope git_commits<cr>", desc = "git [c]ommits" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "[f]iles" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "[h]elp" },
    { "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "[j]umplist" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "[k]eymaps" },
    { "<leader>fl", "<cmd>Telescope loclist<cr>", desc = "[l]oclist" },
    { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "[m]arks" },
    { "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "[q]uickfix" },
    { "<leader>g", group = "[g]it" },
    { "<leader>gb", "<cmd>BlameToggle window<cr>", desc = "[b]lame toggle window" },
    { "<leader>gv", "<cmd>BlameToggle virtual<cr>", desc = "blame toggle [v]irtual" },
    { "<leader>gc", "<cmd>GitConflictRefresh<cr>", desc = "[c]onflict" },
    { "<leader>gd", group = "[d]iff" },
    { "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "[c]lose" },
    { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "[o]pen" },
    { "<leader>gdh", "<cmd>DiffviewFileHistory<cr>", desc = "[h]istory" },
    { "<leader>gs", group = "git [s]igns" },
    { "<leader>gsr", "<cmd>Gitsigns reset_hunk<cr>", desc = "[r]eset hunk" },
    { "<leader>gsp", "<cmd>Gitsigns preview_hunk_inline<cr>", desc = "[p]review hunk" },
    { "<leader>gsr", "<cmd>Gitsigns reset_hunk<cr>", desc = "[r]eset hunk" },
    { "<leader>gw", group = "[w]orktree" },
    -- NOTE: git worktree not installed
    {
      "<leader>gwc",
      ":lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
      desc = "worktree create",
    },
    {
      "<leader>gws",
      ":lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
      desc = "worktree switch",
    },
    { "<leader>h", group = "[h]elp / [h]ide / debug" },
    -- { "<leader>hc", group = "[c]onceal" },
    { "<leader>hc", toggle_conceal, desc = "[c]onceal toggle" },
    -- { "<leader>ht", group = "[t]reesitter" },
    { "<leader>ht", vim.treesitter.inspect_tree, desc = "show [t]ree" },
    { "<leader>i", group = "[i]mage" },
    { "<leader>l", group = "[l]anguage/lsp" },
    { "<leader>ld", group = "[d]iagnostics" },
    {
      "<leader>ldd",
      function()
        vim.diagnostic.enable(false)
      end,
      desc = "[d]isable",
    },
    { "<leader>lde", vim.diagnostic.enable, desc = "[e]nable" },
    { "<leader>le", vim.diagnostic.open_float, desc = "diagnostics (show hover [e]rror)" },
    { "<leader>ln", ":Neogen<cr>", desc = "[n]eogen docstring" },
    { "<leader>v", group = "[v]im" },
    { "<leader>vc", ":Telescope colorscheme<cr>", desc = "[c]olortheme" },
    { "<leader>vh", ':execute "h " . expand("<cword>")<cr>', desc = "vim [h]elp for current word" },
    { "<leader>vl", ":Lazy<cr>", desc = "[l]azy package manager" },
    { "<leader>vm", ":Mason<cr>", desc = "[m]ason software installer" },
    { "<leader>vs", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k<cr>", desc = "[s]ettings, edit vimrc" },
    { "<leader>vt", toggle_light_dark_theme, desc = "[t]oggle light/dark theme" },
    { "<leader>x", group = "e[x]ecute" },
    { "<leader>xx", ":w<cr>:source %<cr>", desc = "[x] source %" },
  },
}, { mode = "n" })
