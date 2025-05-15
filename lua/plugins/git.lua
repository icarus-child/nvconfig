-- git plugins

return {
  { "sindrets/diffview.nvim", event = "VeryLazy" },

  -- handy git ui
  {
    "NeogitOrg/neogit",
    lazy = true,
    cmd = "Neogit",
    keys = {
      { "<leader>gg", ":Neogit<cr>", desc = "neo[g]it" },
    },
    config = function()
      require("neogit").setup {
        disable_commit_confirmation = true,
        integrations = {
          diffview = true,
        },
      }
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    enabled = true,
    opts = {},
  },

  {
    "akinsho/git-conflict.nvim",
    version = "^2.1.0",
    event = "VeryLazy",
    init = function()
      ---@diagnostic disable-next-line: missing-fields
      require("git-conflict").setup {
        default_mappings = true, -- disable buffer local mapping created by this plugin
        default_commands = true, -- disable commands created by this plugin
        disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
        list_opener = "copen", -- command or function to open the conflicts list
        highlights = { -- They must have background color, otherwise the default color will be used
          incoming = "DiffAdd",
          current = "DiffText",
        },
      }
    end,
    keys = {
      { "<leader>gco", ":GitConflictChooseOurs<cr>" },
      { "<leader>gct", ":GitConflictChooseTheirs<cr>" },
      { "<leader>gcb", ":GitConflictChooseBoth<cr>" },
      { "<leader>gc0", ":GitConflictChooseNone<cr>" },
      { "]x", ":GitConflictNextConflict<cr>" },
      { "[x", ":GitConflictPrevConflict<cr>" },
    },
  },

  {
    "FabijanZulj/blame.nvim",
    config = function()
      require("blame").setup {}
    end,
    cmd = "BlameToggle",
  },

  -- github PRs and the like with gh - cli
  {
    "pwntester/octo.nvim",
    enabled = true,
    cmd = "Octo",
    config = function()
      require("octo").setup()
      vim.keymap.set("n", "<leader>gpl", ":Octo pr list<cr>", { desc = "octo [p]r list" })
      vim.keymap.set("n", "<leader>gpr", ":Octo review start<cr>", { desc = "octo [r]eview" })
    end,
  },

  -- TODO: fix esc breaking lazygit
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "[l]azy[g]it" },
    },
  },
}
