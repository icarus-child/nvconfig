-- global options

DefaultConcealLevel = 0
FullConcealLevel = 3

-- proper colors
vim.opt.termguicolors = true

-- show insert mode in terminal buffers
vim.api.nvim_set_hl(0, "TermCursor", { fg = "#A6E3A1", bg = "#A6E3A1" })

-- disable fill chars (the ~ after the buffer)
vim.o.fillchars = "eob: "

-- folding
vim.o.foldenable = true -- enable fold
vim.o.foldlevel = 99 -- start editing with all folds opened
vim.o.foldmethod = "expr" -- use tree-sitter for folding method
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- more opinionated
vim.opt.number = true -- show linenumbers
vim.opt.mouse = "a" -- enable mouse
vim.opt.mousefocus = true
vim.opt.clipboard:append "unnamedplus" -- use system clipboard

vim.opt.timeoutlen = 400 -- until which-key pops up
vim.opt.updatetime = 250 -- for autocommands and hovers

-- don't ask about existing swap files
vim.opt.shortmess:append "A"

-- mode is already in statusline
vim.opt.showmode = false

-- use less indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 0
vim.opt.tabstop = 2

-- enable persistent undo
vim.o.undofile = true
vim.o.undolevels = 10000

-- space as leader
vim.g.mapleader = vim.keycode "<space>"
vim.g.maplocalleader = vim.keycode "\\"

-- smarter search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- indent
vim.opt.smartindent = true
vim.opt.breakindent = true

-- Sets how neovim will display certain whitespace in the editor.
--  See :help 'list'
--  and :help 'listchars'
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- consistent number column
vim.opt.signcolumn = "yes:1"

-- how to show autocomplete menu
vim.opt.completeopt = "menuone,noinsert"
-- vim.o.completeopt = "menu,menuone,popup,fuzzy"

-- global statusline
vim.opt.laststatus = 3

vim.cmd [[
let g:currentmode={
       \ 'n'  : '%#String# NORMAL ',
       \ 'v'  : '%#Search# VISUAL ',
       \ 's'  : '%#ModeMsg# VISUAL ',
       \ "\<C-V>" : '%#Title# V·Block ',
       \ 'V'  : '%#IncSearch# V·Line ',
       \ 'Rv' : '%#String# V·Replace ',
       \ 'i'  : '%#ModeMsg# INSERT ',
       \ 'R'  : '%#Substitute# R ',
       \ 'c'  : '%#CurSearch# Command ',
       \ 't'  : '%#ModeMsg# TERM ',
       \}
]]

vim.opt.statusline = "%{%g:currentmode[mode()]%} %{%reg_recording()%} %* %t | %y | %* %= c:%c l:%l/%L %p%% %#NonText# "
  .. " %*"

-- hide cmdline when not used
vim.opt.cmdheight = 1

-- split right and below by default
vim.opt.splitbelow = true
vim.opt.splitright = true

--tabline
vim.opt.showtabline = 1

--windowline
vim.opt.winbar = "%f"

-- don't continue comments automagically
vim.opt.formatoptions:remove "c"
-- vim.opt.formatoptions:remove 'r'
vim.opt.formatoptions:remove "o"

-- set formatoptions again in an autocmd to override
-- ft specific plugins
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function(_)
    vim.opt.formatoptions:remove "c"
    -- vim.opt.formatoptions:remove 'r'
    vim.opt.formatoptions:remove "o"
  end,
})

-- scroll before end of window
vim.opt.scrolloff = 2

-- (don't == 0) replace certain elements with prettier ones
vim.opt.conceallevel = DefaultConcealLevel

-- diagnostics
vim.diagnostic.config {
  virtual_text = true,
  underline = true,
  signs = true,
}

-- add new filetypes
vim.filetype.add {
  extension = {
    ojs = "javascript",
    pyodide = "python",
    webr = "r",
  },
}

-- additional builtin vim packages
-- filter quickfix list with Cfilter
vim.cmd.packadd "cfilter"

-- to enable cursorline
vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"

-- session save
vim.o.sessionoptions = "buffers,curdir,folds,options,tabpages,resize"

-- fixes changing every file I open for git commits
-- vim.opt.fixendofline = false
