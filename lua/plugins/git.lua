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
    enabled = true,
    event = "User FilePost",
    opts = {},
  },

  {
    "akinsho/git-conflict.nvim",
    version = "^2.1.0",
    event = "VeryLazy",
    init = function()
      require("git-conflict").setup {
        default_mappings = false,
        disable_diagnostics = true,
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
    "f-person/git-blame.nvim",
    event = "User FilePost",
    init = function()
      require("gitblame").setup {
        enabled = false,
      }
      vim.g.gitblame_display_virtual_text = 1
      -- vim.g.gitblame_enabled = 0
    end,
  },

  { -- github PRs and the like with gh - cli
    "pwntester/octo.nvim",
    enabled = true,
    cmd = "Octo",
    config = function()
      require("octo").setup()
      vim.keymap.set("n", "<leader>gpl", ":Octo pr list<cr>", { desc = "octo [p]r list" })
      vim.keymap.set("n", "<leader>gpr", ":Octo review start<cr>", { desc = "octo [r]eview" })
    end,
  },

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
