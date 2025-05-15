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
vim.keymap.del("n", "<CR>")

-- select last paste
nmap("gV", "`[v`]", "select last paste")

-- move in command line
cmap("<C-a>", "<Home>")

-- save with ctrl+s
imap("<C-s>", "<esc>:update<cr><esc>", "save")
nmap("<C-s>", "<cmd>:update<cr><esc>", "save")

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
  else
    vim.o.background = "light"
  end
end

--show keybindings with whichkey
--add your own here if you want them to
--show up in the popup as well

-- normal mode
wk.add({
  { "<c-LeftMouse>", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "go to definition" },
  { "<c-q>", "<cmd>q<cr>", desc = "close buffer" },
  { "<esc>", "<cmd>noh<cr>", desc = "remove search highlight" },
  { "[q", ":silent cprev<cr>", desc = "[q]uickfix prev" },
  { "]q", ":silent cnext<cr>", desc = "[q]uickfix next" },
  { "gN", "Nzzzv", desc = "center search" },
  { "gf", ":e <cfile><CR>", desc = "edit file" },
  { "gl", "<c-]>", desc = "open help link" },
  { "n", "nzzzv", desc = "center search" },
  { "z?", ":setlocal spell!<cr>", desc = "toggle [z]pellcheck" },
  { "zl", ":Telescope spell_suggest<cr>", desc = "[l]ist spelling suggestions" },
}, { mode = "n", silent = true })

-- visual mode
wk.add {
  {
    mode = { "v" },
    { ".", ":norm .<cr>", desc = "repat last normal mode command" },
    { "<M-j>", ":m'>+<cr>`<my`>mzgv`yo`z", desc = "move line down" },
    { "<M-k>", ":m'<-2<cr>`>my`<mzgv`yo`z", desc = "move line up" },
    { "q", ":norm @q<cr>", desc = "repat q macro" },
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
    { "<leader>d", group = "[d]ebug" },
    { "<leader>dt", group = "[t]est" },
    { "<leader>t", group = "[t]abby / [t]reesj" },
    { "<leader>tn", "<cmd>tabnew<CR>", desc = "[n]ew tab" },
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
    { "<leader>gb", group = "[b]lame" },
    { "<leader>gbb", ":GitBlameToggle<cr>", desc = "[b]lame toggle virtual text" },
    { "<leader>gbc", ":GitBlameCopyCommitURL<cr>", desc = "[c]opy" },
    { "<leader>gbo", ":GitBlameOpenCommitURL<cr>", desc = "[o]pen" },
    { "<leader>gc", ":GitConflictRefresh<cr>", desc = "[c]onflict" },
    { "<leader>gd", group = "[d]iff" },
    { "<leader>gdc", ":DiffviewClose<cr>", desc = "[c]lose" },
    { "<leader>gdo", ":DiffviewOpen<cr>", desc = "[o]pen" },
    { "<leader>gs", ":Gitsigns<cr>", desc = "git [s]igns" },
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
