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
    "stevearc/conform.nvim",
    opts = require "configs.conform",
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
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "bash",
        "vim",
        "lua",
        "vimdoc",
        "python",
        "gdscript",
        "gdshader",
        "typescript",
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
    event = "VeryLazy",
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
    end,
  },

  {
    "debugloop/telescope-undo.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    opts = {
      -- don't use `defaults = { }` here, do this in the main telescope spec
      extensions = {
        undo = {
          side_by_side = true,
          layout_strategy = "vertical",
          layout_config = {
            preview_height = 0.8,
          },
        },
        -- no other extensions here, they can have their own spec too
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension "undo"
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = {
      require "configs.conform",
    },
  },

  {
    "mfussenegger/nvim-lint",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    config = function()
      local lint = require "lint"

      lint.linters_by_ft = {
        gdscript = { "gdlint" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>lt", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },

  {
    "kevinhwang91/nvim-bqf",
    event = "FileType qf",
  },

  {
    "Wansmer/treesj",
    event = "VeryLazy",
    keys = {
      { "<leader>tm", "<cmd>TSJToggle<cr>", desc = "TreeSJ toggle" },
      { "<leader>tj", "<cmd>TSJJoin<cr>", desc = "TreeSJ join" },
      { "<leader>ts", "<cmd>TSJSplit<cr>", desc = "TreeSJ split" },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
    opts = { use_default_keymaps = false },
  },

  {
    "dstein64/vim-startuptime",
    event = "VeryLazy",
  },

  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    opts = function()
      vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
      vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
      vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")
      require("leap").opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }
    end,
  },

  {
    "monaqa/dial.nvim",
    event = "VeryLazy",
    keys = { "<C-a>", { "<C-x>", mode = "n" } },
  },

  {
    "folke/trouble.nvim",
    event = "VeryLazy",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  {
    "mfussenegger/nvim-jdtls",
    event = "VeryLazy",
  },

  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  {
    "vyfor/cord.nvim",
    branch = "master",
    build = ":Cord update",
    opts = {}, -- calls require('cord').setup()
  },

  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      require "configs.vimtex"
    end,
  },

  {
    "github/copilot.vim",
    event = "VeryLazy",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.keymap.set("i", "<C-a>", "copilot#Accept()", { expr = true, silent = true, replace_keycodes = false })
    end,
  },

  {
    "R-nvim/R.nvim",
    -- Only required if you also set defaults.lazy = true
    lazy = false,
    -- R.nvim is still young and we may make some breaking changes from time
    -- to time (but also bug fixes all the time). If configuration stability
    -- is a high priority for you, pin to the latest minor version, but unpin
    -- it and try the latest version before reporting an issue:
    -- version = "~0.1.0"
    config = function()
      -- Create a table with the options to be passed to setup()
      ---@type RConfigUserOpts
      local opts = {
        hook = {
          on_filetype = function()
            vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
            vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
          end,
        },
        R_args = { "--quiet", "--no-save" },
        min_editor_width = 72,
        rconsole_width = 78,
        objbr_mappings = { -- Object browser keymap
          c = "class", -- Call R functions
          ["<localleader>gg"] = "head({object}, n = 15)", -- Use {object} notation to write arbitrary R code.
          v = function()
            -- Run lua functions
            require("r.browser").toggle_view()
          end,
        },
        disable_cmds = {
          "RClearConsole",
          "RCustomStart",
          "RSPlot",
          "RSaveClose",
        },
      }
      -- Check if the environment variable "R_AUTO_START" exists.
      -- If using fish shell, you could put in your config.fish:
      -- alias r "R_AUTO_START=true nvim"
      if vim.env.R_AUTO_START == "true" then
        opts.auto_start = "on startup"
        opts.objbr_auto_start = true
      end
      require("r").setup(opts)
    end,
  },
}
