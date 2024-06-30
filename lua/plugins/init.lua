return {
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
  },

  {
    "norcalli/nvim-colorizer.lua",
    enabled = false,
  },

  {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    config = function()
      vim.opt.termguicolors = true
      require("nvim-highlight-colors").setup {}
    end,
  },

  {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require "configs.oil"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "bash-language-server",
        "tsserver",
        "eslint-lsp",
        "python-lsp-server",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "python",
      },
    },
  },

  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    config = true,
  },

  {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
    version = "*",
    lazy = false,
    config = function()
      require "configs.neorg"
    end,
  },

  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     "nvim-neorg/neorg"
  --   },
  --   config = function()
  --     require("cmp").setup({
  --       sources = {
  --         { name = "neorg" }
  --       }
  --     })
  --   end
  -- },

  {
    "jeffkreeftmeijer/vim-numbertoggle",
    event = "VeryLazy",
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    event = "VeryLazy",
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
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  {
    "FabijanZulj/blame.nvim",
    event = "VeryLazy",
    config = function()
      require("blame").setup()
    end,
  },

  {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    config = function()
      vim.opt.termguicolors = true
      require("nvim-highlight-colors").setup {}
    end,
  },

  {
    "jeetsukumaran/vim-indentwise",
    event = "VeryLazy",
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require "configs.harpoon"
    end
  },
}
